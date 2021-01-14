Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6472F5598
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 01:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbhANA3o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 19:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbhANA2q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:46 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1DC0617A7
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:05 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so3006875qkh.10
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5PNx77Dvmkd0Z9m/q1SrizAoOiMtXhLe2t7ghz7SXAo=;
        b=jxu3/jtHtPuHTuaZbcC6XZ3cgNWExdmHFqBkgIZeM6HhLqHOKHj7e+nErWuZmzPCOb
         kT0wyztftPaCH5VDsYWthLSTvzfBf4SmeNCO97ngtksBA8EyV3CXrDrKecJAaLnLCY4Q
         DXRJpfZ7msysugMGKfWEQ/22uIAMoPkHSiD6omZ0YUF0pqz51HnsLqm8uPG22vX7Yb81
         IfGi4NhLNPDf5s1CnQb+LcXDg5q4pUq1iEJ8/ziXx2wk7ZIK771gn21m8W7ZNWpuYMkT
         Uvtg+wj5gXiCusDzub3RuBQxzDbhiRmLgNmD94mZGiD+kA4FtqF2xX8B8gCWQFL0jhbR
         N9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5PNx77Dvmkd0Z9m/q1SrizAoOiMtXhLe2t7ghz7SXAo=;
        b=ELMsjHfrmBmEpr+vFoBjpoF30Ni2xczY4S1HbENa1u438xcC1RhaV1Qdj2sbqGGYkg
         RXHKRTLMXx4q62qjAeHsDr702kRKK044b1kexbqUUyfsWK/y+gQFeVmCOMKhC8S0ZZHG
         JEDs9eFDak21k5/Jgx5Msae2euSUc483jPL0AK4WN92VMxar03Rj1TbjxoS7YaOeJpCI
         9rP+XtoMm7R7uItRCBcmMOuNlzsGPj5pPgbqklZnzDqaEK+sLOwdNfBnBFiO1jeSWQOw
         g2xRduVBisYpdCEXItl52hM6kfJxEAM8GgZclPv+xezCUAIStFjktR/AbTvviLDKzgn6
         bWyw==
X-Gm-Message-State: AOAM5316G3eCRJ+S3dKPhAo7YK2vTsNouksYB99Jo0fQ7nm/2FTHie2W
        drw3j0p5M8Le2DSSeUSMiJHx5+TvwpLCCPMeUvYOtdolyF+Q36hTvsV94n29Df4CYwd7TOMt+O/
        jF6rS3FVVS4LeGsARbEanW/rVXT9cUS5vjexmIlXnqjvgSdgbyfPnmPe2+bQUqtGydO8KvKjCzi
        DWzY+16p0=
X-Google-Smtp-Source: ABdhPJwphpady5Na0RQORTRjzWcKjwMaoz28rDfjaDMcmT7tOwK7px7LvXeXGhQdU9NUP6MDE+rb0CZsvNApSA5uWis=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a05:6902:504:: with SMTP id
 x4mr7275088ybs.446.1610584084981; Wed, 13 Jan 2021 16:28:04 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:22 -0800
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Message-Id: <20210114002723.643589-5-saranyamohan@google.com>
Mime-Version: 1.0
References: <20210114002723.643589-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 4/5] ext2fs: parallel bitmap loading
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
 lib/ext2fs/rw_bitmaps.c | 332 +++++++++++++++++++++++++++++++++-------
 2 files changed, 288 insertions(+), 52 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 5955c3ae..82ce9126 100644
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
index d80c9eb8..7e4f7c6a 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -23,11 +23,33 @@
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
+#ifdef HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
 
 #include "ext2_fs.h"
 #include "ext2fs.h"
 #include "e2image.h"
 
+#ifdef HAVE_PTHREAD
+typedef pthread_mutex_t mutex_t;
+
+static void unix_pthread_mutex_lock(mutex_t *mutex)
+{
+	if (mutex)
+		pthread_mutex_lock(mutex);
+}
+static void unix_pthread_mutex_unlock(mutex_t *mutex)
+{
+	if (mutex)
+		pthread_mutex_unlock(mutex);
+}
+#else
+typedef int mutex_t;
+#define unix_pthread_mutex_lock(mutex_t) do {} while (0)
+#define unix_pthread_mutex_unlock(mutex_t) do {} while (0)
+#endif
+
 static errcode_t write_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 {
 	dgrp_t 		i;
@@ -205,22 +227,12 @@ static int bitmap_tail_verify(unsigned char *bitmap, int first, int last)
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
 
@@ -230,12 +242,11 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 
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
@@ -243,12 +254,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
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
@@ -256,13 +264,62 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
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
+					  mutex_t *mutex,
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
@@ -300,10 +357,12 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
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
@@ -329,12 +388,14 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 				}
 				if (!bitmap_tail_verify((unsigned char *) block_bitmap,
 							block_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
 			} else
 				memset(block_bitmap, 0, block_nbytes);
 			cnt = block_nbytes << 3;
+			unix_pthread_mutex_lock(mutex);
 			retval = ext2fs_set_block_bitmap_range2(fs->block_map,
 					       blk_itr, cnt, block_bitmap);
+			unix_pthread_mutex_unlock(mutex);
 			if (retval)
 				goto cleanup;
 			blk_itr += block_nbytes << 3;
@@ -365,63 +426,225 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 				}
 				if (!bitmap_tail_verify((unsigned char *) inode_bitmap,
 							inode_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
 			} else
 				memset(inode_bitmap, 0, inode_nbytes);
 			cnt = inode_nbytes << 3;
+			unix_pthread_mutex_lock(mutex);
 			retval = ext2fs_set_inode_bitmap_range2(fs->inode_map,
 					       ino_itr, cnt, inode_bitmap);
+			unix_pthread_mutex_unlock(mutex);
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
+#endif /* HAVE_SYSCONF */
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
+#endif /* HAVE_PTHREAD */
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
@@ -436,10 +659,15 @@ errcode_t ext2fs_write_block_bitmap (ext2_filsys fs)
 
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
2.30.0.284.gd98b1dd5eaa7-goog

