Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0982CF962
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgLEE7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50359 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgLEE7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:53 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54wwWh001992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:58:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8FD384202E4; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 4/5] ext2fs: parallel bitmap loading
Date:   Fri,  4 Dec 2020 23:58:55 -0500
Message-Id: <20201205045856.895342-5-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205045856.895342-1-tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

In our benchmarking for PiB size filesystem, pass5 takes
10446s to finish and 99.5% of time takes on reading bitmaps.

It makes sense to reading bitmaps using multiple threads,
a quickly benchmark show 10446s to 626s with 64 threads.

[ This has all of many bug fixes for rw_bitmaps.c from the original
  luster patch set collapsed into a single commit.   In addition it has
  the new ext2fs_rw_bitmaps() api proposed by Ted. ]

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2fs.h     |   8 +
 lib/ext2fs/rw_bitmaps.c | 323 +++++++++++++++++++++++++++++++++-------
 2 files changed, 279 insertions(+), 52 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 5955c3ae9..82ce91264 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -688,6 +688,14 @@ struct ext2_xattr_handle;
 #define XATTR_ABORT	1
 #define XATTR_CHANGED	2
 
+/*
+ * flags for ext2fs_rw_bitmaps()
+ */
+#define EXT2FS_BITMAPS_WRITE		0x0001
+#define EXT2FS_BITMAPS_BLOCK		0x0002
+#define EXT2FS_BITMAPS_INODE		0x0004
+#define EXT2FS_BITMAPS_VALID_FLAGS	0x0007
+
 /*
  * function prototypes
  */
diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index d80c9eb8f..9d5456578 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -23,6 +23,9 @@
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
+#ifdef HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
 
 #include "ext2_fs.h"
 #include "ext2fs.h"
@@ -205,22 +208,12 @@ static int bitmap_tail_verify(unsigned char *bitmap, int first, int last)
 	return 1;
 }
 
-static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
+static errcode_t read_bitmaps_range_prepare(ext2_filsys fs, int flags)
 {
-	dgrp_t i;
-	char *block_bitmap = 0, *inode_bitmap = 0;
-	char *buf;
 	errcode_t retval;
 	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
 	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
-	int tail_flags = 0;
-	int csum_flag;
-	unsigned int	cnt;
-	blk64_t	blk;
-	blk64_t	blk_itr = EXT2FS_B2C(fs, fs->super->s_first_data_block);
-	blk64_t   blk_cnt;
-	ext2_ino_t ino_itr = 1;
-	ext2_ino_t ino_cnt;
+	char *buf;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -230,12 +223,11 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 
 	fs->write_bitmaps = ext2fs_write_bitmaps;
 
-	csum_flag = ext2fs_has_group_desc_csum(fs);
-
 	retval = ext2fs_get_mem(strlen(fs->device_name) + 80, &buf);
 	if (retval)
 		return retval;
-	if (do_block) {
+
+	if (flags & EXT2FS_BITMAPS_BLOCK) {
 		if (fs->block_map)
 			ext2fs_free_block_bitmap(fs->block_map);
 		strcpy(buf, "block bitmap for ");
@@ -243,12 +235,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		retval = ext2fs_allocate_block_bitmap(fs, buf, &fs->block_map);
 		if (retval)
 			goto cleanup;
-		retval = io_channel_alloc_buf(fs->io, 0, &block_bitmap);
-		if (retval)
-			goto cleanup;
-	} else
-		block_nbytes = 0;
-	if (do_inode) {
+	}
+
+	if (flags & EXT2FS_BITMAPS_INODE) {
 		if (fs->inode_map)
 			ext2fs_free_inode_bitmap(fs->inode_map);
 		strcpy(buf, "inode bitmap for ");
@@ -256,13 +245,62 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		retval = ext2fs_allocate_inode_bitmap(fs, buf, &fs->inode_map);
 		if (retval)
 			goto cleanup;
+	}
+	ext2fs_free_mem(&buf);
+
+	return retval;
+
+cleanup:
+	if (flags & EXT2FS_BITMAPS_BLOCK) {
+		ext2fs_free_block_bitmap(fs->block_map);
+		fs->block_map = 0;
+	}
+	if (flags & EXT2FS_BITMAPS_INODE) {
+		ext2fs_free_inode_bitmap(fs->inode_map);
+		fs->inode_map = 0;
+	}
+	if (buf)
+		ext2fs_free_mem(&buf);
+	return retval;
+}
+
+static errcode_t read_bitmaps_range_start(ext2_filsys fs, int flags,
+					  dgrp_t start, dgrp_t end,
+					  pthread_mutex_t *mutex,
+					  int *tail_flags)
+{
+	dgrp_t i;
+	char *block_bitmap = 0, *inode_bitmap = 0;
+	errcode_t retval = 0;
+	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
+	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
+	int csum_flag;
+	unsigned int	cnt;
+	blk64_t	blk;
+	blk64_t	blk_itr = EXT2FS_B2C(fs, fs->super->s_first_data_block);
+	blk64_t   blk_cnt;
+	ext2_ino_t ino_itr = 1;
+	ext2_ino_t ino_cnt;
+
+	csum_flag = ext2fs_has_group_desc_csum(fs);
+
+	if (flags & EXT2FS_BITMAPS_BLOCK) {
+		retval = io_channel_alloc_buf(fs->io, 0, &block_bitmap);
+		if (retval)
+			goto cleanup;
+	} else {
+		block_nbytes = 0;
+	}
+
+	if (flags & EXT2FS_BITMAPS_INODE) {
 		retval = io_channel_alloc_buf(fs->io, 0, &inode_bitmap);
 		if (retval)
 			goto cleanup;
-	} else
+	} else {
 		inode_nbytes = 0;
-	ext2fs_free_mem(&buf);
+	}
 
+	/* io should be null */
 	if (fs->flags & EXT2_FLAG_IMAGE_FILE) {
 		blk = (ext2fs_le32_to_cpu(fs->image_header->offset_inodemap) / fs->blocksize);
 		ino_cnt = fs->super->s_inodes_count;
@@ -300,10 +338,12 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 			blk_itr += cnt;
 			blk_cnt -= cnt;
 		}
-		goto success_cleanup;
+		goto cleanup;
 	}
 
-	for (i = 0; i < fs->group_desc_count; i++) {
+	blk_itr += ((blk64_t)start * (block_nbytes << 3));
+	ino_itr += ((blk64_t)start * (inode_nbytes << 3));
+	for (i = start; i <= end; i++) {
 		if (block_bitmap) {
 			blk = ext2fs_block_bitmap_loc(fs, i);
 			if ((csum_flag &&
@@ -329,12 +369,20 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 				}
 				if (!bitmap_tail_verify((unsigned char *) block_bitmap,
 							block_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
 			} else
 				memset(block_bitmap, 0, block_nbytes);
 			cnt = block_nbytes << 3;
+#ifdef HAVE_PTHREAD
+			if (mutex)
+				pthread_mutex_lock(mutex);
+#endif
 			retval = ext2fs_set_block_bitmap_range2(fs->block_map,
 					       blk_itr, cnt, block_bitmap);
+#ifdef HAVE_PTHREAD
+			if (mutex)
+				pthread_mutex_unlock(mutex);
+#endif
 			if (retval)
 				goto cleanup;
 			blk_itr += block_nbytes << 3;
@@ -365,63 +413,229 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 				}
 				if (!bitmap_tail_verify((unsigned char *) inode_bitmap,
 							inode_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
 			} else
 				memset(inode_bitmap, 0, inode_nbytes);
 			cnt = inode_nbytes << 3;
+			if (mutex)
+				pthread_mutex_lock(mutex);
 			retval = ext2fs_set_inode_bitmap_range2(fs->inode_map,
 					       ino_itr, cnt, inode_bitmap);
+			if (mutex)
+				pthread_mutex_unlock(mutex);
 			if (retval)
 				goto cleanup;
 			ino_itr += inode_nbytes << 3;
 		}
 	}
 
+cleanup:
+	if (inode_bitmap)
+		ext2fs_free_mem(&inode_bitmap);
+	if (block_bitmap)
+		ext2fs_free_mem(&block_bitmap);
+	return retval;
+}
+
+static errcode_t read_bitmaps_range_end(ext2_filsys fs, int flags,
+					int tail_flags)
+{
+	errcode_t retval;
+
 	/* Mark group blocks for any BLOCK_UNINIT groups */
-	if (do_block) {
+	if (flags & EXT2FS_BITMAPS_BLOCK) {
 		retval = mark_uninit_bg_group_blocks(fs);
 		if (retval)
-			goto cleanup;
-	}
-
-success_cleanup:
-	if (inode_bitmap) {
-		ext2fs_free_mem(&inode_bitmap);
-		fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-	}
-	if (block_bitmap) {
-		ext2fs_free_mem(&block_bitmap);
+			return retval;
 		fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
 	}
+	if (flags & EXT2FS_BITMAPS_INODE)
+		fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
 	fs->flags |= tail_flags;
+
 	return 0;
+}
 
-cleanup:
-	if (do_block) {
+static void read_bitmaps_cleanup_on_error(ext2_filsys fs, int flags)
+{
+	if (flags & EXT2FS_BITMAPS_BLOCK) {
 		ext2fs_free_block_bitmap(fs->block_map);
 		fs->block_map = 0;
 	}
-	if (do_inode) {
+	if (flags & EXT2FS_BITMAPS_INODE) {
 		ext2fs_free_inode_bitmap(fs->inode_map);
 		fs->inode_map = 0;
 	}
-	if (inode_bitmap)
-		ext2fs_free_mem(&inode_bitmap);
-	if (block_bitmap)
-		ext2fs_free_mem(&block_bitmap);
-	if (buf)
-		ext2fs_free_mem(&buf);
+}
+
+static errcode_t read_bitmaps_range(ext2_filsys fs, int flags,
+				    dgrp_t start, dgrp_t end)
+{
+	errcode_t retval;
+	int tail_flags = 0;
+
+	retval = read_bitmaps_range_prepare(fs, flags);
+	if (retval)
+		return retval;
+
+	retval = read_bitmaps_range_start(fs, flags, start, end,
+					  NULL, &tail_flags);
+	if (retval == 0)
+		retval = read_bitmaps_range_end(fs, flags, tail_flags);
+	if (retval)
+		read_bitmaps_cleanup_on_error(fs, flags);
+	return retval;
+}
+
+#ifdef HAVE_PTHREAD
+struct read_bitmaps_thread_info {
+	ext2_filsys	rbt_fs;
+	int		rbt_flags;
+	dgrp_t		rbt_grp_start;
+	dgrp_t		rbt_grp_end;
+	errcode_t	rbt_retval;
+	pthread_mutex_t *rbt_mutex;
+	int		rbt_tail_flags;
+};
+
+static void *read_bitmaps_thread(void *data)
+{
+	struct read_bitmaps_thread_info *rbt = data;
+
+	rbt->rbt_retval = read_bitmaps_range_start(rbt->rbt_fs, rbt->rbt_flags,
+				rbt->rbt_grp_start, rbt->rbt_grp_end,
+				rbt->rbt_mutex, &rbt->rbt_tail_flags);
+	return NULL;
+}
+#endif
+
+errcode_t ext2fs_rw_bitmaps(ext2_filsys fs, int flags, int num_threads)
+{
+#ifdef HAVE_PTHREAD
+	pthread_attr_t	attr;
+	pthread_t *thread_ids = NULL;
+	struct read_bitmaps_thread_info *thread_infos = NULL;
+	pthread_mutex_t rbt_mutex = PTHREAD_MUTEX_INITIALIZER;
+	errcode_t retval;
+	errcode_t rc;
+	unsigned flexbg_size = 1 << fs->super->s_log_groups_per_flex;
+	dgrp_t average_group;
+	int i, tail_flags = 0;
+	io_manager manager = unix_io_manager;
+#endif
+
+	if (flags & ~EXT2FS_BITMAPS_VALID_FLAGS)
+		return EXT2_ET_INVALID_ARGUMENT;
+
+	if (flags & EXT2FS_BITMAPS_WRITE)
+		return write_bitmaps(fs, flags & EXT2FS_BITMAPS_INODE,
+				     flags & EXT2FS_BITMAPS_BLOCK);
+
+#ifdef HAVE_PTHREAD
+	if (((fs->io->flags & CHANNEL_FLAGS_THREADS) == 0) ||
+	    (num_threads == 1) || (fs->flags & EXT2_FLAG_IMAGE_FILE))
+		goto fallback;
+
+	if (num_threads < 0) {
+#if defined(HAVE_SYSCONF) && defined(_SC_NPROCESSORS_CONF)
+		num_threads = sysconf(_SC_NPROCESSORS_CONF);
+#else
+		/*
+		 * Guess for now; eventually we should probably define
+		 * ext2fs_get_num_cpus() and teach it how to get this info on
+		 * MacOS, FreeBSD, etc.
+		 * ref: https://stackoverflow.com/questions/150355
+		 */
+		num_threads = 4;
+#endif
+		if (num_threads <= 1)
+			goto fallback;
+	}
+	if (num_threads > fs->group_desc_count)
+		num_threads = fs->group_desc_count;
+	average_group = fs->group_desc_count / num_threads;
+	if (ext2fs_has_feature_flex_bg(fs->super)) {
+		average_group = (average_group / flexbg_size) * flexbg_size;
+	}
+	if (average_group == 0)
+		goto fallback;
+
+	io_channel_set_options(fs->io, "cache=off");
+	retval = pthread_attr_init(&attr);
+	if (retval)
+		return retval;
+
+	thread_ids = calloc(sizeof(pthread_t), num_threads);
+	if (!thread_ids)
+		return -ENOMEM;
+
+	thread_infos = calloc(sizeof(struct read_bitmaps_thread_info),
+				num_threads);
+	if (!thread_infos)
+		goto out;
+
+	retval = read_bitmaps_range_prepare(fs, flags);
+	if (retval)
+		goto out;
+
+//	fprintf(stdout, "Multiple threads triggered to read bitmaps\n");
+	for (i = 0; i < num_threads; i++) {
+		thread_infos[i].rbt_fs = fs;
+		thread_infos[i].rbt_flags = flags;
+		thread_infos[i].rbt_mutex = &rbt_mutex;
+		thread_infos[i].rbt_tail_flags = 0;
+		if (i == 0)
+			thread_infos[i].rbt_grp_start = 0;
+		else
+			thread_infos[i].rbt_grp_start = average_group * i + 1;
+
+		if (i == num_threads - 1)
+			thread_infos[i].rbt_grp_end = fs->group_desc_count - 1;
+		else
+			thread_infos[i].rbt_grp_end = average_group * (i + 1);
+		retval = pthread_create(&thread_ids[i], &attr,
+					&read_bitmaps_thread, &thread_infos[i]);
+		if (retval)
+			break;
+	}
+	for (i = 0; i < num_threads; i++) {
+		if (!thread_ids[i])
+			break;
+		rc = pthread_join(thread_ids[i], NULL);
+		if (rc && !retval)
+			retval = rc;
+		rc = thread_infos[i].rbt_retval;
+		if (rc && !retval)
+			retval = rc;
+		tail_flags |= thread_infos[i].rbt_tail_flags;
+	}
+out:
+	rc = pthread_attr_destroy(&attr);
+	if (rc && !retval)
+		retval = rc;
+	free(thread_infos);
+	free(thread_ids);
+
+	if (retval == 0)
+		retval = read_bitmaps_range_end(fs, flags, tail_flags);
+	if (retval)
+		read_bitmaps_cleanup_on_error(fs, flags);
+	/* XXX should save and restore cache setting */
+	io_channel_set_options(fs->io, "cache=on");
 	return retval;
+fallback:
+#endif
+	return read_bitmaps_range(fs, flags, 0, fs->group_desc_count - 1);
 }
 
 errcode_t ext2fs_read_inode_bitmap(ext2_filsys fs)
 {
-	return read_bitmaps(fs, 1, 0);
+	return ext2fs_rw_bitmaps(fs, EXT2FS_BITMAPS_INODE, -1);
 }
 
 errcode_t ext2fs_read_block_bitmap(ext2_filsys fs)
 {
-	return read_bitmaps(fs, 0, 1);
+	return ext2fs_rw_bitmaps(fs, EXT2FS_BITMAPS_BLOCK, -1);
 }
 
 errcode_t ext2fs_write_inode_bitmap(ext2_filsys fs)
@@ -436,10 +650,15 @@ errcode_t ext2fs_write_block_bitmap (ext2_filsys fs)
 
 errcode_t ext2fs_read_bitmaps(ext2_filsys fs)
 {
-	if (fs->inode_map && fs->block_map)
-		return 0;
+	int flags = 0;
 
-	return read_bitmaps(fs, !fs->inode_map, !fs->block_map);
+	if (!fs->inode_map)
+		flags |= EXT2FS_BITMAPS_INODE;
+	if (!fs->block_map)
+		flags |= EXT2FS_BITMAPS_BLOCK;
+	if (flags == 0)
+		return 0;
+	return ext2fs_rw_bitmaps(fs, flags, -1);
 }
 
 errcode_t ext2fs_write_bitmaps(ext2_filsys fs)
-- 
2.28.0

