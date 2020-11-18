Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35FE2B80EE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKRPlx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKRPlw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:52 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C6C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:52 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id r29so1639244qtu.21
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IE9Hh3H2hu1A0A0Mt4wO8xcJjU6GkisyeoFBwJ3SNGY=;
        b=VCjyRVQzt+NNFZlvoOjKw7JcvyPD5sC1KpncWacxuSzSh9RdDRj3n4eXcMHFuKZpse
         TSF2le8PTGO/n70bWPHPG0Zk77Cj/utfOhCPxudNeua4FCa0PQgRqgLp7PjXlGiKf0JH
         pYoQ8piQz7UhuXooh/5Ef8WsDakV0yqjBe5NrAe5/fwDzcmpbM7lmzKGYHQahx9hxGtc
         KtBEVwvzRSTsHnBm4iujHu4JS3eLNiDp09szH04kGKjlfLQkgwhzYFVfY5bn5HhKTp2Y
         okbvmHGLzIMusLWfimsGJxE62FuW2Jqq3YiJR2ia+05CuxUg8zT28crXNLUH41mQ3o8x
         gUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IE9Hh3H2hu1A0A0Mt4wO8xcJjU6GkisyeoFBwJ3SNGY=;
        b=CctuBNMGALqqz1w6VIwP4jFYcX6hzsP5E3PAGtpVJPSRAG6jgsF/wp/nmRtNA4XNF6
         2DEAXI47WXj3Y/IB6cQsexz2lVAuH8QDvPXSBwLjToJx0RZcg7BiFAQ51wGwnJsmFV+m
         alWgzBRBjlluk0uPQzXkzGER4RzvRSd3MCMlJ7GNgk74nnKklsbwIygdSXCIPcPLEMo2
         GiYxvmyEaDKtNTHw6zmqdldoy7YTRC92/P28QmwXKFx5ASmPTpdCh8P3QfPBImnKHhVZ
         9rvhc8Wimfw23AjXWlsdVyOj/IQ2etPDvr//D/0JQDFmr8w9SluUW+gKOVCUlej/e7ht
         6PTQ==
X-Gm-Message-State: AOAM531w+l0KmW7xeBywF2RILbsjxp2cgksELSy9nHCf+nijIDBmrUiQ
        AlK7cDrSSwqlEgX6PkyZcNVeN9rkCtXRVt4YtDkcbmoK9bB8NffRDYJWmoqkN5sWjKxbloC55ZX
        blBqrF2RqHyBMBCAJbeq0Nqz/I9vUH3ojbGcXxq3TnEvhGDp/LHlfRVzylhfzmmT8zOfM2ODA26
        hxsqX1+oA=
X-Google-Smtp-Source: ABdhPJyjUVHvp9uendqEMskWzMUR9evEWDOXGIWWo14TC2Bvg/jlJSafjX3grYP/1RJvkS2Hca703sSSHVvZyCBl7vQ=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:ab1e:: with SMTP id
 h30mr5140936qvb.55.1605714111776; Wed, 18 Nov 2020 07:41:51 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:32 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-47-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 46/61] ext2fs: parallel bitmap loading
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
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

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 lib/ext2fs/rw_bitmaps.c | 289 ++++++++++++++++++++++++++++++++++------
 1 file changed, 250 insertions(+), 39 deletions(-)

diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index d80c9eb8..960a6913 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -23,6 +23,7 @@
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
+#include <pthread.h>
 
 #include "ext2_fs.h"
 #include "ext2fs.h"
@@ -205,22 +206,12 @@ static int bitmap_tail_verify(unsigned char *bitmap, int first, int last)
 	return 1;
 }
 
-static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
+static errcode_t read_bitmaps_range_prepare(ext2_filsys fs, int do_inode, int do_block)
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
 
@@ -230,11 +221,10 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 
 	fs->write_bitmaps = ext2fs_write_bitmaps;
 
-	csum_flag = ext2fs_has_group_desc_csum(fs);
-
 	retval = ext2fs_get_mem(strlen(fs->device_name) + 80, &buf);
 	if (retval)
 		return retval;
+
 	if (do_block) {
 		if (fs->block_map)
 			ext2fs_free_block_bitmap(fs->block_map);
@@ -243,11 +233,8 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		retval = ext2fs_allocate_block_bitmap(fs, buf, &fs->block_map);
 		if (retval)
 			goto cleanup;
-		retval = io_channel_alloc_buf(fs->io, 0, &block_bitmap);
-		if (retval)
-			goto cleanup;
-	} else
-		block_nbytes = 0;
+	}
+
 	if (do_inode) {
 		if (fs->inode_map)
 			ext2fs_free_inode_bitmap(fs->inode_map);
@@ -256,13 +243,69 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		retval = ext2fs_allocate_inode_bitmap(fs, buf, &fs->inode_map);
 		if (retval)
 			goto cleanup;
-		retval = io_channel_alloc_buf(fs->io, 0, &inode_bitmap);
+	}
+	ext2fs_free_mem(&buf);
+
+	return retval;
+
+cleanup:
+	if (do_block) {
+		ext2fs_free_block_bitmap(fs->block_map);
+		fs->block_map = 0;
+	}
+	if (do_inode) {
+		ext2fs_free_inode_bitmap(fs->inode_map);
+		fs->inode_map = 0;
+	}
+	if (buf)
+		ext2fs_free_mem(&buf);
+	return retval;
+}
+
+static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_block,
+					  dgrp_t start, dgrp_t end, pthread_mutex_t *mutex,
+					  io_channel io)
+{
+	dgrp_t i;
+	char *block_bitmap = 0, *inode_bitmap = 0;
+	char *buf;
+	errcode_t retval;
+	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
+	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
+	int tail_flags = 0;
+	int csum_flag;
+	unsigned int	cnt;
+	blk64_t	blk;
+	blk64_t	blk_itr = EXT2FS_B2C(fs, fs->super->s_first_data_block);
+	blk64_t   blk_cnt;
+	ext2_ino_t ino_itr = 1;
+	ext2_ino_t ino_cnt;
+	io_channel this_io;
+
+	if (!io)
+		this_io = fs->io;
+	else
+		this_io = io;
+
+	csum_flag = ext2fs_has_group_desc_csum(fs);
+
+	if (do_block) {
+		retval = io_channel_alloc_buf(this_io, 0, &block_bitmap);
+		if (retval)
+			goto cleanup;
+	} else {
+		block_nbytes = 0;
+	}
+
+	if (do_inode) {
+		retval = io_channel_alloc_buf(this_io, 0, &inode_bitmap);
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
@@ -303,7 +346,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		goto success_cleanup;
 	}
 
-	for (i = 0; i < fs->group_desc_count; i++) {
+	blk_itr += ((blk64_t)start * (block_nbytes << 3));
+	ino_itr += ((blk64_t)start * (inode_nbytes << 3));
+	for (i = start; i <= end; i++) {
 		if (block_bitmap) {
 			blk = ext2fs_block_bitmap_loc(fs, i);
 			if ((csum_flag &&
@@ -312,7 +357,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 			    (blk >= ext2fs_blocks_count(fs->super)))
 				blk = 0;
 			if (blk) {
-				retval = io_channel_read_blk64(fs->io, blk,
+				retval = io_channel_read_blk64(this_io, blk,
 							       1, block_bitmap);
 				if (retval) {
 					retval = EXT2_ET_BLOCK_BITMAP_READ;
@@ -333,8 +378,12 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 			} else
 				memset(block_bitmap, 0, block_nbytes);
 			cnt = block_nbytes << 3;
+			if (mutex)
+				pthread_mutex_lock(mutex);
 			retval = ext2fs_set_block_bitmap_range2(fs->block_map,
 					       blk_itr, cnt, block_bitmap);
+			if (mutex)
+				pthread_mutex_unlock(mutex);
 			if (retval)
 				goto cleanup;
 			blk_itr += block_nbytes << 3;
@@ -347,7 +396,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 			    (blk >= ext2fs_blocks_count(fs->super)))
 				blk = 0;
 			if (blk) {
-				retval = io_channel_read_blk64(fs->io, blk,
+				retval = io_channel_read_blk64(this_io, blk,
 							       1, inode_bitmap);
 				if (retval) {
 					retval = EXT2_ET_INODE_BITMAP_READ;
@@ -369,29 +418,28 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
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
 
-	/* Mark group blocks for any BLOCK_UNINIT groups */
-	if (do_block) {
-		retval = mark_uninit_bg_group_blocks(fs);
-		if (retval)
-			goto cleanup;
-	}
-
 success_cleanup:
-	if (inode_bitmap) {
-		ext2fs_free_mem(&inode_bitmap);
-		fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-	}
-	if (block_bitmap) {
-		ext2fs_free_mem(&block_bitmap);
-		fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+	if (start == 0 && end == fs->group_desc_count - 1) {
+		if (inode_bitmap) {
+			ext2fs_free_mem(&inode_bitmap);
+			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+		}
+		if (block_bitmap) {
+			ext2fs_free_mem(&block_bitmap);
+			fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+		}
 	}
 	fs->flags |= tail_flags;
 	return 0;
@@ -412,6 +460,169 @@ cleanup:
 	if (buf)
 		ext2fs_free_mem(&buf);
 	return retval;
+
+}
+
+static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_block)
+{
+	errcode_t retval = 0;
+
+	/* Mark group blocks for any BLOCK_UNINIT groups */
+	if (do_block) {
+		retval = mark_uninit_bg_group_blocks(fs);
+		if (retval)
+			goto cleanup;
+	}
+
+	return retval;
+cleanup:
+	if (do_block) {
+		ext2fs_free_block_bitmap(fs->block_map);
+		fs->block_map = 0;
+	}
+	if (do_inode) {
+		ext2fs_free_inode_bitmap(fs->inode_map);
+		fs->inode_map = 0;
+	}
+	return retval;
+}
+
+static errcode_t read_bitmaps_range(ext2_filsys fs, int do_inode, int do_block,
+				    dgrp_t start, dgrp_t end)
+{
+	errcode_t retval;
+
+	retval = read_bitmaps_range_prepare(fs, do_inode, do_block);
+	if (retval)
+		return retval;
+
+	retval = read_bitmaps_range_start(fs, do_inode, do_block, start, end, NULL, NULL);
+	if (retval)
+		return retval;
+
+	return read_bitmaps_range_end(fs, do_inode, do_block);
+}
+
+#ifdef CONFIG_PFSCK
+struct read_bitmaps_thread_info {
+	ext2_filsys	rbt_fs;
+	int 		rbt_do_inode;
+	int		rbt_do_block;
+	dgrp_t		rbt_grp_start;
+	dgrp_t		rbt_grp_end;
+	errcode_t	rbt_retval;
+	pthread_mutex_t *rbt_mutex;
+	io_channel      rbt_io;
+};
+
+static void* read_bitmaps_thread(void *data)
+{
+	struct read_bitmaps_thread_info *rbt = data;
+
+	rbt->rbt_retval = read_bitmaps_range_start(rbt->rbt_fs,
+				rbt->rbt_do_inode, rbt->rbt_do_block,
+				rbt->rbt_grp_start, rbt->rbt_grp_end,
+				rbt->rbt_mutex, rbt->rbt_io);
+	return NULL;
+}
+#endif
+
+static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
+{
+#ifdef CONFIG_PFSCK
+	pthread_attr_t	attr;
+	int num_threads = fs->fs_num_threads;
+	pthread_t *thread_ids = NULL;
+	struct read_bitmaps_thread_info *thread_infos = NULL;
+	pthread_mutex_t rbt_mutex = PTHREAD_MUTEX_INITIALIZER;
+	errcode_t retval;
+	errcode_t rc;
+	dgrp_t average_group;
+	int i;
+	io_manager manager = unix_io_manager;
+#else
+	int num_threads = 1;
+#endif
+
+	if (num_threads <= 1 || (fs->flags & EXT2_FLAG_IMAGE_FILE))
+		return read_bitmaps_range(fs, do_inode, do_block, 0, fs->group_desc_count - 1);
+
+#ifdef CONFIG_PFSCK
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
+	average_group = ext2fs_get_avg_group(fs);
+	retval = read_bitmaps_range_prepare(fs, do_inode, do_block);
+	if (retval)
+		goto out;
+
+	fprintf(stdout, "Multiple threads triggered to read bitmaps\n");
+	for (i = 0; i < num_threads; i++) {
+		thread_infos[i].rbt_fs = fs;
+		thread_infos[i].rbt_do_inode = do_inode;
+		thread_infos[i].rbt_do_block = do_block;
+		thread_infos[i].rbt_mutex = &rbt_mutex;
+		if (i == 0)
+			thread_infos[i].rbt_grp_start = 0;
+		else
+			thread_infos[i].rbt_grp_start = average_group * i + 1;
+
+		if (i == num_threads - 1)
+			thread_infos[i].rbt_grp_end = fs->group_desc_count - 1;
+		else
+			thread_infos[i].rbt_grp_end = average_group * (i + 1);
+		retval = manager->open(fs->device_name, IO_FLAG_RW,
+					&thread_infos[i].rbt_io);
+		if (retval)
+			break;
+		io_channel_set_blksize(thread_infos[i].rbt_io, fs->io->block_size);
+		retval = pthread_create(&thread_ids[i], &attr,
+					&read_bitmaps_thread, &thread_infos[i]);
+		if (retval) {
+			io_channel_close(thread_infos[i].rbt_io);
+			break;
+		}
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
+		io_channel_close(thread_infos[i].rbt_io);
+	}
+out:
+	rc = pthread_attr_destroy(&attr);
+	if (rc && !retval)
+		retval = rc;
+	free(thread_infos);
+	free(thread_ids);
+
+	if (!retval)
+		retval = read_bitmaps_range_end(fs, do_inode, do_block);
+
+	if (!retval) {
+		if (do_inode)
+			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+		if (do_block)
+			fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+	}
+
+	return retval;
+#endif
 }
 
 errcode_t ext2fs_read_inode_bitmap(ext2_filsys fs)
-- 
2.29.2.299.gdc1121823c-goog

