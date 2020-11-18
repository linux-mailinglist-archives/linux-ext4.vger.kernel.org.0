Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B902B80DF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKRPlY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKRPlW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA07C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v188so2873189ybc.19
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pHlJ0i5ksTG/QCCZPUMiKyeLB7mnIPuIMptsj+rv/IY=;
        b=f8DPkwFdC6oK5hbVg1i66kFYT3FtznB3/VFBJyf1YTLEt7z96xnK1Llzu7R3POmufE
         If/0PoC/SJLzk+uXYKz2TY1Gr+JJbbalh9hrVoc5IYBbanAtHfjKlzjzh25cx752DYZ+
         RiR1I8xWZqlJGAi+UYddKbV5DZ9DFN5Vmzs/X6DqYecVnGfvkNjD4Q6IfIrq1jgg9evU
         OePoU6pRS7NI1GT+l3vS2d/yJcrXk2E4J8t6r6P/YT70fY0GLYu1LPaVMcJnLQyMFnrs
         eq/wH+VErzG+VqdjnDowEbatFh3El568YcUxqszR70luIrh1pvsPLq3+8i/LFBoYo9TG
         fvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pHlJ0i5ksTG/QCCZPUMiKyeLB7mnIPuIMptsj+rv/IY=;
        b=cRKxwqw/WSg+R2i+JZXTnSUidEz6geFH+OtH8SF6RrsDN5g3drdGmyIhMOwu2Mkn68
         v5XctFVmuKuQ9+0o+rbTrXZcUmHbNyIqvca6Hn8jo/L7AvT641vjV4TbsX54RqYp6GJO
         iWn6/W8yPRYu5UURghwxfTEBaghzrmeXdyKwOuVu7RAzv3v7BheKacDj4MLI2zNjNk5k
         S+dSmS8jQZNXKDHUh1aO+jt+l/TrOuXT1djtdmt0MT+ZgYs0imOIRqkFI4S0+RZguGDH
         VaJmc9/13XDn9J1NSheZkJJM+WRIvt46HQEWFj9jHfqM/PHogHV1Sno0AQmU/ez9Bsl/
         7tmg==
X-Gm-Message-State: AOAM533E+iHVYoffU6+kZgpXYqYSIW7gvJOKECIcf854Ofwz4xgG0hFR
        z7OXUSQ9gg//PovQP70VozuX3XG7dlKiuyBpAlkU4AuHTpHqRrrNQs5y2pQudYF0sPliRirpTP+
        84b5DmhbBZTEHW52pU/OOEnTDH9fuHhERFFUtUFvdIuAPR81t9Qeoi2GH8IzwiAJBre5/knu3dj
        pN9fnjgFU=
X-Google-Smtp-Source: ABdhPJxGC6dLr+drLsizPgXLkUgGeEPLimdIZIxr3tyaROQQkele7MRQ6n+MOdq3jQBJy4UeE2DeCDNq5GJL0KML7vE=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:c74b:: with SMTP id
 w72mr10495275ybe.117.1605714081827; Wed, 18 Nov 2020 07:41:21 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:16 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-31-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 30/61] e2fsck: move some fixes out of parallel pthreads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h                      |   4 +
 e2fsck/pass1.c                       | 306 ++++++++++++++++-----------
 e2fsck/util.c                        |  36 +++-
 tests/f_multithread/expect.1         |   2 +-
 tests/f_multithread_logfile/expect.1 |   2 +-
 tests/f_multithread_no/expect.1      |   2 +-
 6 files changed, 216 insertions(+), 136 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 777d8b96..fecc8bbf 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -450,6 +450,8 @@ struct e2fsck_struct {
 #ifdef CONFIG_PFSCK
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
+	/* protect block_found_map, block_dup_map */
+	pthread_mutex_t		 fs_block_map_mutex;
 #endif
 };
 
@@ -750,6 +752,8 @@ extern errcode_t e2fsck_allocate_subcluster_bitmap(ext2_filsys fs,
 unsigned long long get_memory_size(void);
 extern void e2fsck_pass1_fix_lock(e2fsck_t ctx);
 extern void e2fsck_pass1_fix_unlock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_unlock(e2fsck_t ctx);
 
 /* unix.c */
 extern void e2fsck_clear_progbar(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 594571a7..49bdba21 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -750,11 +750,15 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -888,19 +892,15 @@ static void reserve_block_for_root_repair(e2fsck_t ctx)
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
@@ -911,18 +911,15 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
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
 
@@ -1177,6 +1174,118 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
+/*
+ * We need call mark_table_blocks() before multiple
+ * thread start, since all known system blocks should be
+ * marked and checked later.
+ */
+static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
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
+static void e2fsck_pass1_post(e2fsck_t ctx)
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
+				ext2fs_free_mem(&block_buf);
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
+	if (ctx->flags & E2F_FLAG_RESTART) {
+		ext2fs_free_mem(&block_buf);
+		return;
+	}
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
 void e2fsck_pass1_run(e2fsck_t ctx)
 {
 	int	i;
@@ -1215,9 +1324,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 	pass1_readahead(ctx, &ra_group, &ino_threshold);
 
-	if (!(ctx->options & E2F_OPT_PREEN))
-		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
-
 	if (ext2fs_has_feature_dir_index(fs->super) &&
 	    !(ctx->options & E2F_OPT_NO)) {
 		if (ext2fs_u32_list_create(&ctx->dirs_to_hash, 50))
@@ -1266,24 +1372,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -1325,14 +1413,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -1366,12 +1446,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
 
@@ -1701,8 +1775,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
+			e2fsck_pass1_block_map_lock(ctx);
 			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
 							  &pb.fs_meta_blocks);
+			e2fsck_pass1_block_map_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2018,9 +2094,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	ext2fs_close_inode_scan(scan);
 	scan = NULL;
 
-	reserve_block_for_root_repair(ctx);
-	reserve_block_for_lnf_repair(ctx);
-
 	/*
 	 * If any extended attribute blocks' reference counts need to
 	 * be adjusted, either up (ctx->refcount_extra), or down
@@ -2048,11 +2121,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-	if (ctx->invalid_bitmaps) {
-		e2fsck_pass1_fix_lock(ctx);
-		handle_fs_bad_blocks(ctx);
-		e2fsck_pass1_fix_unlock(ctx);
-	}
 
 	/* We don't need the block_ea_map any more */
 	if (ctx->block_ea_map) {
@@ -2063,29 +2131,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
-			inode->i_mtime = ctx->now;
-			e2fsck_write_inode(ctx, EXT2_RESIZE_INO, inode,
-					   "recreate inode");
-		}
-		ctx->flags &= ~E2F_FLAG_RESIZE_INODE;
-	}
-
 	if (ctx->flags & E2F_FLAG_RESTART) {
 		/*
 		 * Only the master copy of the superblock and block
@@ -2097,13 +2142,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		goto endit;
 	}
 
-	if (ctx->block_dup_map) {
-		if (ctx->options & E2F_OPT_PREEN) {
-			clear_problem_context(&pctx);
-			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
-		}
-		e2fsck_pass1_dupblocks(ctx, block_buf);
-	}
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
 endit:
 	e2fsck_use_inode_shortcuts(ctx, 0);
@@ -2358,10 +2396,10 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	assert(global_ctx->inode_reg_map == NULL);
 	assert(global_ctx->inodes_to_rebuild == NULL);
 
-	assert(global_ctx->block_found_map == NULL);
+	assert(global_ctx->block_found_map != NULL);
+	assert(global_ctx->block_metadata_map != NULL);
 	assert(global_ctx->block_dup_map == NULL);
 	assert(global_ctx->block_ea_map == NULL);
-	assert(global_ctx->block_metadata_map == NULL);
 	assert(global_ctx->fs->dblist == NULL);
 
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
@@ -2525,10 +2563,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2571,10 +2607,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2670,26 +2704,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 				&global_ctx->inodes_to_rebuild);
 	if (retval)
 		return retval;
-	retval = e2fsck_pass1_merge_bitmap(global_fs,
-				&thread_ctx->block_found_map,
-				&global_ctx->block_found_map);
-	if (retval)
-		return retval;
-	retval = e2fsck_pass1_merge_bitmap(global_fs,
-				&thread_ctx->block_dup_map,
-				&global_ctx->block_dup_map);
-	if (retval)
-		return retval;
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->block_ea_map,
 				&global_ctx->block_ea_map);
 	if (retval)
 		return retval;
-	retval = e2fsck_pass1_merge_bitmap(global_fs,
-				&thread_ctx->block_metadata_map,
-				&global_ctx->block_metadata_map);
-	if (retval)
-		return retval;
 
 	return 0;
 }
@@ -2713,10 +2732,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_dup_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
@@ -2897,6 +2913,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	errcode_t			 retval;
 
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
+	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -2948,17 +2965,25 @@ static int multiple_threads_supported(e2fsck_t ctx)
 
 void e2fsck_pass1(e2fsck_t ctx)
 {
+	errcode_t retval;
+	int multiple = 0;
 
 	init_ext2_max_sizes();
+	retval = e2fsck_pass1_prepare(ctx);
+	if (retval)
+		return;
 #ifdef CONFIG_PFSCK
 	if (multiple_threads_supported(ctx)) {
+		multiple = 1;
 		e2fsck_pass1_multithread(ctx);
-		return;
+	} else {
+		fprintf(stderr, "Fall through single thread for pass1 "
+				"because tdb could not handle properly\n");
 	}
-	fprintf(stderr, "Fall through single thread for pass1 "
-			"because tdb could not handle properly\n");
 #endif
-	e2fsck_pass1_run(ctx);
+	if (!multiple)
+		e2fsck_pass1_run(ctx);
+	e2fsck_pass1_post(ctx);
 }
 
 #undef FINISH_INODE_LOOP
@@ -3147,9 +3172,14 @@ static void alloc_imagic_map(e2fsck_t ctx)
  * WARNING: Assumes checks have already been done to make sure block
  * is valid.  This is true in both process_block and process_bad_block.
  */
-static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
+static _INLINE_ void mark_block_used_unlocked(e2fsck_t ctx, blk64_t block)
 {
-	struct		problem_context pctx;
+	struct problem_context pctx;
+	e2fsck_t global_ctx;
+
+	global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
 
 	clear_problem_context(&pctx);
 
@@ -3158,11 +3188,15 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
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
@@ -3172,12 +3206,20 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 				return;
 			}
 		}
-		ext2fs_fast_mark_block_bitmap2(ctx->block_dup_map, block);
+		ext2fs_fast_mark_block_bitmap2(global_ctx->block_dup_map, block);
 	} else {
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, block);
 	}
 }
 
+static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
+{
+	e2fsck_pass1_block_map_lock(ctx);
+	mark_block_used_unlocked(ctx, block);
+	e2fsck_pass1_block_map_unlock(ctx);
+
+}
+
 /*
  * When cluster size is greater than one block, it is caller's responsibility
  * to make sure block parameter starts at a cluster boundary.
@@ -3185,14 +3227,16 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
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
-			mark_block_used(ctx, block + i);
+			mark_block_used_unlocked(ctx, block + i);
 	}
+	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 static errcode_t _INLINE_ e2fsck_write_ext_attr3(e2fsck_t ctx, blk64_t block,
@@ -4759,10 +4803,12 @@ static int process_bad_block(ext2_filsys fs,
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
@@ -4771,12 +4817,17 @@ static int process_bad_block(ext2_filsys fs,
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
-			mark_block_used(ctx, blk);
+			}
+		} else {
+			mark_block_used_unlocked(ctx, blk);
+		}
+		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
 #if 0
@@ -4789,10 +4840,13 @@ static int process_bad_block(ext2_filsys fs,
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
@@ -4947,6 +5001,7 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
+	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -4967,6 +5022,7 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
+	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 8eec477c..3dcfa86a 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -570,23 +570,34 @@ void e2fsck_read_inode_full(e2fsck_t ctx, unsigned long ino,
 }
 
 #ifdef CONFIG_PFSCK
+#define e2fsck_get_lock_context(ctx)		\
+	e2fsck_t global_ctx = ctx->global_ctx;	\
+	if (!global_ctx)			\
+		global_ctx = ctx;		\
+
 void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
-	e2fsck_t global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
-
+	e2fsck_get_lock_context(ctx);
 	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
 }
 
 void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
-	e2fsck_t global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
-
+	e2fsck_get_lock_context(ctx);
 	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
 }
+
+void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_lock(&global_ctx->fs_block_map_mutex);
+}
+
+void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
+}
 #else
 void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
@@ -596,6 +607,15 @@ void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
 
+}
+
+void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+{
+
+}
+
+void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+{
 }
 #endif
 
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
2.29.2.299.gdc1121823c-goog

