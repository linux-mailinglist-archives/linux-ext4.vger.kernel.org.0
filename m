Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D751A1F0B
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgDHKqr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:47 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34095 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgDHKqq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:46 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so2071360pje.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNC6DmJMmMRsRohb1ZFlDLLq7TMQSB5L7qoWyrub6m4=;
        b=WMS8hY4K4NveDvMO5Q90hyeSJddOuNbPgMK+hnzDvJ4BzRZ6MVJ+DqML3b3Udaahbb
         DIWnKxLEjBNzOUJ45GcKwvH94KVZz09k2c5VLUo8xogQy3UFMzn2xSc8Wy+IGcLwjdfE
         9a7oqhHYeHLg7uJFphzpZksOOveiQFKRqA7M5SQjKThFYWXTh1XBhsHcYBQCTAzdpZQs
         frcX8TTqAMqahQdwn9unuhWr8Fi8s7BX7EtcTaR8FYkLITE9SqUh+qsnhXiaRde0fp+z
         lqeLUMg/otnJr7y3znA33YSO37ojx0u6VUNaodr/htsFpvI/4lvo2mzPRZQ0yO1DQf8b
         Gg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNC6DmJMmMRsRohb1ZFlDLLq7TMQSB5L7qoWyrub6m4=;
        b=KONydhVU99P0eOHJqJdghPJwCsnratV7K7NtC0fjTk5OKm7KYkdI9MbkgTzfeN5t6I
         7k6eA0aUvS2/1UDH7sQlbatEOK9v6iVGgImaeoYxaeAMZroCiHXqhRUclP+5jP2RosYb
         GycpFl482kJnMAys4W6Ld1DVCUTye964YaqWckrdh9k7MDOXvtUMT7dgTViCafvNromy
         ofBvelZpyTe7nEN4bXt5rckb6bHSQSLHtu/SLyRMq0kI1QoPs1B1MkJTdvbgthcs3+8T
         8UN/M0sNvqINIGsaPpYz+1z9TWqlPrVxzEAKG5epFW6E8j1evvqN5LMFEgmkuXX4mjxS
         Z1yg==
X-Gm-Message-State: AGi0Puaxb4Hd5H03xZUISo+ic6xguEKRgFDOV8M+P1F7nX0+qacEZ1IT
        Fe7r6m1sOG/3c3wx/A3USATQOnBb9oM=
X-Google-Smtp-Source: APiQypJZ3k0UQs/K8qSWi/T7SNjo2slZ2KiLBGXFjWCPkAzDJSFRLV63wBa4eY0gxqb/FudnijFIvg==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr6269573plt.51.1586342803461;
        Wed, 08 Apr 2020 03:46:43 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:42 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 33/46] e2fsck: move some fixes out of parallel pthreads
Date:   Wed,  8 Apr 2020 19:45:01 +0900
Message-Id: <1586342714-12536-34-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

We could only use @found_map_block to find free blocks
after we have collectd all used blocks, so something like
handle_fs_bad_blocks(), ext2fs_create_resize_inode(),
e2fsck_pass1_dupblocks() really should be handled after
all threads has been finished.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h                      |   2 +
 e2fsck/pass1.c                       | 314 +++++++++++++++++----------
 tests/f_multithread/expect.1         |   2 +-
 tests/f_multithread_logfile/expect.1 |   2 +-
 tests/f_multithread_no/expect.1      |   2 +-
 5 files changed, 199 insertions(+), 123 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 20d61651..19df6cd3 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -450,6 +450,8 @@ struct e2fsck_struct {
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
+	/* protect block_found_map, block_dup_map */
+	pthread_mutex_t		 fs_block_map_mutex;
 };
 
 #ifdef DEBUG_THREADS
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f3b52103..793a2944 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -132,24 +132,35 @@ static void process_inodes(e2fsck_t ctx, char *block_buf,
 static __u64 ext2_max_sizes[EXT2_MAX_BLOCK_LOG_SIZE -
 			    EXT2_MIN_BLOCK_LOG_SIZE + 1];
 
+#define e2fsck_get_lock_context(ctx)		\
+	e2fsck_t global_ctx = ctx->global_ctx;	\
+	if (!global_ctx)			\
+		global_ctx = ctx;		\
+
 static void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
-	e2fsck_t global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
-
+	e2fsck_get_lock_context(ctx);
 	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
 }
 
 static void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
-	e2fsck_t global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
-
+	e2fsck_get_lock_context(ctx);
 	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
 }
 
+static inline void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_lock(&global_ctx->fs_block_map_mutex);
+}
+
+static inline void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
+}
+
 /*
  * Free all memory allocated by pass1 in preparation for restarting
  * things.
@@ -789,11 +800,15 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
 			if (i >= 4)
 				not_device++;
 
+			e2fsck_pass1_block_map_lock(ctx);
 			if (blk < ctx->fs->super->s_first_data_block ||
 			    blk >= ext2fs_blocks_count(ctx->fs->super) ||
 			    ext2fs_fast_test_block_bitmap2(ctx->block_found_map,
-							   blk))
+							   blk)) {
+				e2fsck_pass1_block_map_unlock(ctx);
 				return;	/* Invalid block, can't be dir */
+			}
+			e2fsck_pass1_block_map_unlock(ctx);
 		}
 		blk = inode->i_block[0];
 	}
@@ -929,19 +944,15 @@ static void reserve_block_for_root_repair(e2fsck_t ctx)
 	errcode_t	err;
 	ext2_filsys	fs = ctx->fs;
 
-	e2fsck_pass1_fix_lock(ctx);
 	ctx->root_repair_block = 0;
 	if (ext2fs_test_inode_bitmap2(ctx->inode_used_map, EXT2_ROOT_INO))
-		goto out;
+		return;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		goto out;
+		return;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->root_repair_block = blk;
-out:
-	e2fsck_pass1_fix_unlock(ctx);
-	return;
 }
 
 static void reserve_block_for_lnf_repair(e2fsck_t ctx)
@@ -952,18 +963,15 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
 	static const char name[] = "lost+found";
 	ext2_ino_t	ino;
 
-	e2fsck_pass1_fix_lock(ctx);
 	ctx->lnf_repair_block = 0;
 	if (!ext2fs_lookup(fs, EXT2_ROOT_INO, name, sizeof(name)-1, 0, &ino))
-		goto out;
+		return;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		goto out;
+		return;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->lnf_repair_block = blk;
-out:
-	e2fsck_pass1_fix_unlock(ctx);
 	return;
 }
 
@@ -1229,6 +1237,115 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
+/*
+ * We need call mark_table_blocks() before multiple
+ * thread start, since all known system blocks should be
+ * marked and checked later.
+ */
+static int _e2fsck_pass1_prepare(e2fsck_t ctx)
+{
+	struct problem_context pctx;
+	ext2_filsys fs = ctx->fs;
+
+	clear_problem_context(&pctx);
+	if (!(ctx->options & E2F_OPT_PREEN))
+		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
+
+	pctx.errcode = e2fsck_allocate_subcluster_bitmap(ctx->fs,
+			_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+			"block_found_map", &ctx->block_found_map);
+	if (pctx.errcode) {
+		pctx.num = 1;
+		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
+		ctx->flags |= E2F_FLAG_ABORT;
+		return pctx.errcode;
+	}
+	pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
+			_("metadata block map"), EXT2FS_BMAP64_RBTREE,
+			"block_metadata_map", &ctx->block_metadata_map);
+	if (pctx.errcode) {
+		pctx.num = 1;
+		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
+		ctx->flags |= E2F_FLAG_ABORT;
+		return pctx.errcode;
+	}
+
+	mark_table_blocks(ctx);
+	pctx.errcode = ext2fs_convert_subcluster_bitmap(ctx->fs,
+						&ctx->block_found_map);
+	if (pctx.errcode) {
+		fix_problem(ctx, PR_1_CONVERT_SUBCLUSTER, &pctx);
+		ctx->flags |= E2F_FLAG_ABORT;
+		return pctx.errcode;
+	}
+
+	if (ext2fs_has_feature_mmp(fs->super) &&
+	    fs->super->s_mmp_block > fs->super->s_first_data_block &&
+	    fs->super->s_mmp_block < ext2fs_blocks_count(fs->super))
+		ext2fs_mark_block_bitmap2(ctx->block_found_map,
+					  fs->super->s_mmp_block);
+
+	return 0;
+}
+
+static void _e2fsck_pass1_post(e2fsck_t ctx)
+{
+	struct problem_context pctx;
+	ext2_filsys fs = ctx->fs;
+	char *block_buf;
+
+	reserve_block_for_root_repair(ctx);
+	reserve_block_for_lnf_repair(ctx);
+
+	if (ctx->invalid_bitmaps)
+		handle_fs_bad_blocks(ctx);
+
+	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
+		struct ext2_inode *inode;
+		int inode_size = EXT2_INODE_SIZE(fs->super);
+		inode = e2fsck_allocate_memory(ctx, inode_size,
+					       "scratch inode");
+
+		clear_problem_context(&pctx);
+		pctx.errcode = ext2fs_create_resize_inode(fs);
+		if (pctx.errcode) {
+			if (!fix_problem(ctx, PR_1_RESIZE_INODE_CREATE,
+					 &pctx)) {
+				ctx->flags |= E2F_FLAG_ABORT;
+				ext2fs_free_mem(&inode);
+				return;
+			}
+			pctx.errcode = 0;
+		}
+		if (!pctx.errcode) {
+			e2fsck_read_inode(ctx, EXT2_RESIZE_INO, inode,
+					  "recreate inode");
+			inode->i_mtime = ctx->now;
+			e2fsck_write_inode(ctx, EXT2_RESIZE_INO, inode,
+					   "recreate inode");
+		}
+		ctx->flags &= ~E2F_FLAG_RESIZE_INODE;
+		ext2fs_free_mem(&inode);
+	}
+
+	if (ctx->flags & E2F_FLAG_RESTART)
+		return;
+
+	if (ctx->block_dup_map) {
+		if (ctx->options & E2F_OPT_PREEN) {
+			clear_problem_context(&pctx);
+			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
+		}
+		block_buf =
+			(char *)e2fsck_allocate_memory(ctx,
+					ctx->fs->blocksize * 3,
+					"block interate buffer");
+		e2fsck_pass1_dupblocks(ctx, block_buf);
+		ext2fs_free_mem(&block_buf);
+	}
+}
+
+
 void _e2fsck_pass1(e2fsck_t ctx)
 {
 	int	i;
@@ -1267,10 +1384,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 	pass1_readahead(ctx, &ra_group, &ino_threshold);
 
-	if (!(ctx->options & E2F_OPT_PREEN) &&
-	    ((!ctx->global_ctx) || (ctx->thread_info.et_thread_index == 0)))
-		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
-
 	if (ext2fs_has_feature_dir_index(fs->super) &&
 	    !(ctx->options & E2F_OPT_NO)) {
 		if (ext2fs_u32_list_create(&ctx->dirs_to_hash, 50))
@@ -1318,24 +1431,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		ctx->flags |= E2F_FLAG_ABORT;
 		return;
 	}
-	pctx.errcode = e2fsck_allocate_subcluster_bitmap(fs,
-			_("in-use block map"), EXT2FS_BMAP64_RBTREE,
-			"block_found_map", &ctx->block_found_map);
-	if (pctx.errcode) {
-		pctx.num = 1;
-		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
-	}
-	pctx.errcode = e2fsck_allocate_block_bitmap(fs,
-			_("metadata block map"), EXT2FS_BMAP64_RBTREE,
-			"block_metadata_map", &ctx->block_metadata_map);
-	if (pctx.errcode) {
-		pctx.num = 1;
-		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
-	}
 	pctx.errcode = e2fsck_setup_icount(ctx, "inode_link_info", 0, NULL,
 					   &ctx->inode_link_info);
 	if (pctx.errcode) {
@@ -1377,14 +1472,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		}
 	}
 
-	mark_table_blocks(ctx);
-	pctx.errcode = ext2fs_convert_subcluster_bitmap(fs,
-						&ctx->block_found_map);
-	if (pctx.errcode) {
-		fix_problem(ctx, PR_1_CONVERT_SUBCLUSTER, &pctx);
-		ctx->flags |= E2F_FLAG_ABORT;
-		goto endit;
-	}
 	block_buf = (char *) e2fsck_allocate_memory(ctx, fs->blocksize * 3,
 						    "block interate buffer");
 	if (EXT2_INODE_SIZE(fs->super) == EXT2_GOOD_OLD_INODE_SIZE)
@@ -1418,12 +1505,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	     fs->super->s_mkfs_time < fs->super->s_inodes_count))
 		low_dtime_check = 0;
 
-	if (ext2fs_has_feature_mmp(fs->super) &&
-	    fs->super->s_mmp_block > fs->super->s_first_data_block &&
-	    fs->super->s_mmp_block < ext2fs_blocks_count(fs->super))
-		ext2fs_mark_block_bitmap2(ctx->block_found_map,
-					  fs->super->s_mmp_block);
-
 	/* Set up ctx->lost_and_found if possible */
 	(void) e2fsck_get_lost_and_found(ctx, 0);
 
@@ -1774,8 +1855,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
+			e2fsck_pass1_block_map_lock(ctx);
 			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
 							  &pb.fs_meta_blocks);
+			e2fsck_pass1_block_map_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2107,9 +2190,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ext2fs_close_inode_scan(scan);
 	scan = NULL;
 
-	reserve_block_for_root_repair(ctx);
-	reserve_block_for_lnf_repair(ctx);
-
 	/*
 	 * If any extended attribute blocks' reference counts need to
 	 * be adjusted, either up (ctx->refcount_extra), or down
@@ -2137,11 +2217,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-	if (ctx->invalid_bitmaps) {
-		e2fsck_pass1_fix_lock(ctx);
-		handle_fs_bad_blocks(ctx);
-		e2fsck_pass1_fix_unlock(ctx);
-	}
 
 	/* We don't need the block_ea_map any more */
 	if (ctx->block_ea_map) {
@@ -2152,31 +2227,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	/* We don't need the encryption policy => ID map any more */
 	destroy_encryption_policy_map(ctx);
 
-	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
-		clear_problem_context(&pctx);
-		e2fsck_pass1_fix_lock(ctx);
-		pctx.errcode = ext2fs_create_resize_inode(fs);
-		e2fsck_pass1_fix_unlock(ctx);
-		if (pctx.errcode) {
-			if (!fix_problem(ctx, PR_1_RESIZE_INODE_CREATE,
-					 &pctx)) {
-				ctx->flags |= E2F_FLAG_ABORT;
-				goto endit;
-			}
-			pctx.errcode = 0;
-		}
-		if (!pctx.errcode) {
-			e2fsck_read_inode(ctx, EXT2_RESIZE_INO, inode,
-					  "recreate inode");
-			e2fsck_pass1_fix_lock(ctx);
-			inode->i_mtime = ctx->now;
-			e2fsck_write_inode(ctx, EXT2_RESIZE_INO, inode,
-					   "recreate inode");
-			e2fsck_pass1_fix_unlock(ctx);
-		}
-		ctx->flags &= ~E2F_FLAG_RESIZE_INODE;
-	}
-
 	if (ctx->flags & E2F_FLAG_RESTART) {
 		/*
 		 * Only the master copy of the superblock and block
@@ -2189,15 +2239,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		goto endit;
 	}
 
-	if (ctx->block_dup_map) {
-		if (ctx->options & E2F_OPT_PREEN) {
-			clear_problem_context(&pctx);
-			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
-		}
-		e2fsck_pass1_fix_lock(ctx);
-		e2fsck_pass1_dupblocks(ctx, block_buf);
-		e2fsck_pass1_fix_unlock(ctx);
-	}
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
 	ext2fs_free_mem(&inodes_to_process);
 endit:
@@ -2501,10 +2542,10 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 	assert(global_ctx->inode_reg_map == NULL);
 	assert(global_ctx->inodes_to_rebuild == NULL);
 
-	assert(global_ctx->block_found_map == NULL);
 	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_found_map != NULL);
+	assert(global_ctx->block_metadata_map != NULL);
 	assert(global_ctx->block_ea_map == NULL);
-	assert(global_ctx->block_metadata_map == NULL);
 
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
@@ -2672,10 +2713,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
-	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2717,10 +2756,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_imagic_map = inode_imagic_map;
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_found_map = block_found_map;
-	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_ea_map = block_ea_map;
-	global_ctx->block_metadata_map = block_metadata_map;
+	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -2783,10 +2820,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
-	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_found_map);
-	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
-	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
 
 	return 0;
 }
@@ -2809,10 +2843,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_imagic_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
-	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
-	PASS1_FREE_CTX_BITMAP(thread_ctx, block_dup_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
-	PASS1_FREE_CTX_BITMAP(thread_ctx, block_metadata_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	ext2fs_free_mem(&thread_ctx);
@@ -3010,7 +3041,12 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	unsigned flexbg_size = 1;
 	int max_threads;
 
+	retval = _e2fsck_pass1_prepare(global_ctx);
+	if (retval)
+		goto out_abort;
+
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
+	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
 	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
 		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
 
@@ -3049,6 +3085,7 @@ out_abort:
 void e2fsck_pass1(e2fsck_t ctx)
 {
 	e2fsck_pass1_multithread(ctx);
+	_e2fsck_pass1_post(ctx);
 }
 
 #undef FINISH_INODE_LOOP
@@ -3234,7 +3271,12 @@ static void alloc_imagic_map(e2fsck_t ctx)
  */
 static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 {
-	struct		problem_context pctx;
+	struct problem_context pctx;
+	e2fsck_t global_ctx;
+
+	global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
 
 	clear_problem_context(&pctx);
 
@@ -3243,11 +3285,15 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 		    !(ctx->options & E2F_OPT_UNSHARE_BLOCKS)) {
 			return;
 		}
-		if (!ctx->block_dup_map) {
+		/**
+		 * this should be safe because this operation has
+		 * been serialized by mutex.
+		 */
+		if (!global_ctx->block_dup_map) {
 			pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
 					_("multiply claimed block map"),
 					EXT2FS_BMAP64_RBTREE, "block_dup_map",
-					&ctx->block_dup_map);
+					&global_ctx->block_dup_map);
 			if (pctx.errcode) {
 				pctx.num = 3;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR,
@@ -3257,7 +3303,7 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 				return;
 			}
 		}
-		ext2fs_fast_mark_block_bitmap2(ctx->block_dup_map, block);
+		ext2fs_fast_mark_block_bitmap2(global_ctx->block_dup_map, block);
 	} else {
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, block);
 	}
@@ -3270,14 +3316,16 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 				      unsigned int num)
 {
-	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num))
+	e2fsck_pass1_block_map_lock(ctx);
+	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num)) {
 		ext2fs_mark_block_bitmap_range2(ctx->block_found_map, block, num);
-	else {
+	} else {
 		unsigned int i;
 
 		for (i = 0; i < num; i += EXT2FS_CLUSTER_RATIO(ctx->fs))
 			mark_block_used(ctx, block + i);
 	}
+	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 /*
@@ -3591,7 +3639,9 @@ refcount_fail:
 
 	inc_ea_inode_refs(ctx, pctx, first, end);
 	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
+	e2fsck_pass1_block_map_lock(ctx);
 	mark_block_used(ctx, blk);
+	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
 
@@ -3976,7 +4026,9 @@ report_problem:
 				pctx->str = "EXT2_EXTENT_UP";
 				return;
 			}
+			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
+			e2fsck_pass1_block_map_unlock(ctx);
 			pb->num_blocks++;
 			goto next;
 		}
@@ -4083,6 +4135,7 @@ alloc_later:
 					      pb->last_block,
 					      extent.e_pblk,
 					      extent.e_lblk)) {
+			e2fsck_pass1_block_map_lock(ctx);
 			for (i = 0; i < extent.e_len; i++) {
 				pctx->blk = extent.e_lblk + i;
 				pctx->blk2 = extent.e_pblk + i;
@@ -4090,6 +4143,7 @@ alloc_later:
 				mark_block_used(ctx, extent.e_pblk + i);
 				mark_block_used(ctx, extent.e_pblk + i);
 			}
+			e2fsck_pass1_block_map_unlock(ctx);
 		}
 
 		/*
@@ -4732,6 +4786,7 @@ static int process_block(ext2_filsys fs,
 			*block_nr = 0;
 			return 0;
 		}
+
 		if (!p->suppress && (p->num_illegal_blocks % 12) == 0) {
 			if (fix_problem(ctx, PR_1_TOO_MANY_BAD_BLOCKS, pctx)) {
 				p->clear = 1;
@@ -4773,8 +4828,11 @@ static int process_block(ext2_filsys fs,
 		 * being in use; all of the other blocks are handled
 		 * by mark_table_blocks()).
 		 */
-		if (blockcnt == BLOCK_COUNT_DIND)
+		if (blockcnt == BLOCK_COUNT_DIND) {
+			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
+			e2fsck_pass1_block_map_unlock(ctx);
+		}
 		p->num_blocks++;
 	} else if (!(ctx->fs->cluster_ratio_bits &&
 		     p->previous_block &&
@@ -4782,15 +4840,19 @@ static int process_block(ext2_filsys fs,
 		      EXT2FS_B2C(ctx->fs, p->previous_block)) &&
 		     (blk & EXT2FS_CLUSTER_MASK(ctx->fs)) ==
 		     ((unsigned) blockcnt & EXT2FS_CLUSTER_MASK(ctx->fs)))) {
+		e2fsck_pass1_block_map_lock(ctx);
 		mark_block_used(ctx, blk);
+		e2fsck_pass1_block_map_unlock(ctx);
 		p->num_blocks++;
 	} else if (has_unaligned_cluster_map(ctx, p->previous_block,
 					     p->last_block, blk, blockcnt)) {
 		pctx->blk = blockcnt;
 		pctx->blk2 = blk;
 		fix_problem(ctx, PR_1_MISALIGNED_CLUSTER, pctx);
+		e2fsck_pass1_block_map_lock(ctx);
 		mark_block_used(ctx, blk);
 		mark_block_used(ctx, blk);
+		e2fsck_pass1_block_map_unlock(ctx);
 	}
 	if (blockcnt >= 0)
 		p->last_block = blockcnt;
@@ -4857,10 +4919,12 @@ static int process_bad_block(ext2_filsys fs,
 	}
 
 	if (blockcnt < 0) {
+		e2fsck_pass1_block_map_lock(ctx);
 		if (ext2fs_test_block_bitmap2(p->fs_meta_blocks, blk)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BB_FS_BLOCK, pctx)) {
 				*block_nr = 0;
+				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
 		} else if (ext2fs_test_block_bitmap2(ctx->block_found_map,
@@ -4869,12 +4933,17 @@ static int process_bad_block(ext2_filsys fs,
 			if (fix_problem(ctx, PR_1_BBINODE_BAD_METABLOCK,
 					pctx)) {
 				*block_nr = 0;
+				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
-			if (e2fsck_should_abort(ctx))
+			if (e2fsck_should_abort(ctx)) {
+				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_ABORT;
-		} else
+			}
+		} else {
 			mark_block_used(ctx, blk);
+		}
+		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
 #if 0
@@ -4887,10 +4956,13 @@ static int process_bad_block(ext2_filsys fs,
 	 * there's an overlap between the filesystem table blocks
 	 * (bitmaps and inode table) and the bad block list.
 	 */
+	e2fsck_pass1_block_map_lock(ctx);
 	if (!ext2fs_test_block_bitmap2(ctx->block_found_map, blk)) {
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
+		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
+	e2fsck_pass1_block_map_unlock(ctx);
 	/*
 	 * Try to find the where the filesystem block was used...
 	 */
@@ -5045,6 +5117,7 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
+	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -5065,6 +5138,7 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
+	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/tests/f_multithread/expect.1 b/tests/f_multithread/expect.1
index 8d2acd2b..4db68d9e 100644
--- a/tests/f_multithread/expect.1
+++ b/tests/f_multithread/expect.1
@@ -1,7 +1,7 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scan group range [0, 2)
-[Thread 0] Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
diff --git a/tests/f_multithread_logfile/expect.1 b/tests/f_multithread_logfile/expect.1
index 8d2acd2b..4db68d9e 100644
--- a/tests/f_multithread_logfile/expect.1
+++ b/tests/f_multithread_logfile/expect.1
@@ -1,7 +1,7 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scan group range [0, 2)
-[Thread 0] Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
diff --git a/tests/f_multithread_no/expect.1 b/tests/f_multithread_no/expect.1
index f85a3382..eda2fcac 100644
--- a/tests/f_multithread_no/expect.1
+++ b/tests/f_multithread_no/expect.1
@@ -1,7 +1,7 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scan group range [0, 2)
-[Thread 0] Pass 1: Checking inodes, blocks, and sizes
 [Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
-- 
2.25.2

