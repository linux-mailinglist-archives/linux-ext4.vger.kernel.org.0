Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762A2B80E2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKRPl2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKRPl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478DC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g129so2904309ybf.20
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=V1e/3CITZ0z8WAi/fer1yOneLGk2EQ4KLkYZwrwSFxQ=;
        b=bLwWo5XtTj32vn19PVOsrDefCcEI3LLBhajVvalvz2gO1YuMMJrpsBvoDIkXkn5rm5
         Vxwj7vlAu+pnCp/zJqV8eytNLu+C1Hx7Y2VQFs9qPBu5P8GSQiZClZVtEux+ORXK5e7F
         5QrZJ6m4tS2qocpD5IBzfR3EcdwhodoiyKHW1aXzUUuthGzJl/SI4D8LNsO90hrJxg1B
         dn5aCXZXuG7f4GHmljJx5hrz6ANyxRNa68T/LJcCSNmUPtU+wONheAXyTgwctMfFadLH
         6JGTedpuH5Y646hXViyjDucl3vuvBsmN/Sq2oF5EW+eTpNkUzJ6+UoVkbK+YEyxZ/FHv
         k3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V1e/3CITZ0z8WAi/fer1yOneLGk2EQ4KLkYZwrwSFxQ=;
        b=Skn+/q7oK9UTt7FhgFrk2r8DMwt915o+YXJlSEiFXd/SPfH2BqyFmC7HfJSDGHsihY
         toZCND5DP8QWxRPbn/aJ0V+V9CeZmKYjzntJA3G/yUKYuRSaAkyDl1SdABaxSmwIjYvt
         BKKBg6945dltjJ20uQlH04HBakr0WRiLLS4dU6EH04N+Xrcd8mmltC4EKG6uDEtYkpSc
         ufQA70Wk6IdFhlBtuGKzfcobEToqhivjJU11rLWDRmaFKHDZoEaS8nEkNuTA57awiO1P
         1RDCRQiS+ZK1dUKpOMeB9Jbzw0ov9ERUbDWRAg1CoDekTvx12vi60MaNRcS+dnddC4lp
         CBGA==
X-Gm-Message-State: AOAM530s0MC6AqBRc+a90kdAWO8TB3/BC+GV/+YZ2llAxa6REcPdgnuf
        tjf/b5/eZYs3tIFt6bVLwyvkL6lfhQ2urO2OUiKl5bFTgXNWfJ6N738bOnU3GXbLjehVanQdzjL
        Baix45e1UrsDf3AEJkl+3Do/JRO6IyPnEffmzI5HZ/IraQXYFapai+yeWbChuJbewkx+42dLrlX
        G1s8O2fds=
X-Google-Smtp-Source: ABdhPJxArmqqXf2hy+/yGqmbnTSD2ium0IDyGn0aR8+TsfqxfOWpch8g8q8yIhxNpwg0aY2WbkDfY3qyTgEGWn4VutQ=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:d412:: with SMTP id
 m18mr6651149ybf.361.1605714087265; Wed, 18 Nov 2020 07:41:27 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:19 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-34-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 33/61] e2fsck: kickoff mutex lock for block found map
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Now @block_found_map is no longer shared by multiple threads,
and @block_dup_map need be checked again after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h                   |   9 +-
 e2fsck/pass1.c                    | 172 ++++++++++++++++++------------
 e2fsck/util.c                     |  34 ++++--
 lib/ext2fs/bitops.h               |   2 +
 lib/ext2fs/gen_bitmap64.c         |  33 ++++++
 tests/f_itable_collision/expect.1 |   3 -
 6 files changed, 172 insertions(+), 81 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 192a534c..d4b472f5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -202,6 +202,7 @@ struct resource_track {
 #define E2F_FLAG_TIME_INSANE	0x2000 /* Time is insane */
 #define E2F_FLAG_PROBLEMS_FIXED	0x4000 /* At least one problem was fixed */
 #define E2F_FLAG_ALLOC_OK	0x8000 /* Can we allocate blocks? */
+#define E2F_FLAG_DUP_BLOCK	0x20000 /* dup block found during pass1 */
 
 #define E2F_RESET_FLAGS (E2F_FLAG_TIME_INSANE | E2F_FLAG_PROBLEMS_FIXED)
 
@@ -452,7 +453,7 @@ struct e2fsck_struct {
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
-	pthread_mutex_t		 fs_block_map_mutex;
+	pthread_rwlock_t	 fs_block_map_rwlock;
 #endif
 };
 
@@ -753,8 +754,10 @@ extern errcode_t e2fsck_allocate_subcluster_bitmap(ext2_filsys fs,
 unsigned long long get_memory_size(void);
 extern void e2fsck_pass1_fix_lock(e2fsck_t ctx);
 extern void e2fsck_pass1_fix_unlock(e2fsck_t ctx);
-extern void e2fsck_pass1_block_map_lock(e2fsck_t ctx);
-extern void e2fsck_pass1_block_map_unlock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx);
 
 /* unix.c */
 extern void e2fsck_clear_progbar(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8b03b6f9..6dba6d1b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -647,6 +647,31 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 
 }
 
+static _INLINE_ int is_blocks_used(e2fsck_t ctx, blk64_t block,
+				   unsigned int num)
+{
+	int retval;
+
+	/* used to avoid duplicate output from below */
+	retval = ext2fs_test_block_bitmap_range2_valid(ctx->block_found_map,
+						       block, num);
+	if (!retval)
+		return 0;
+
+	retval = ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num);
+	if (retval) {
+		e2fsck_pass1_block_map_r_lock(ctx);
+		if (ctx->global_ctx)
+			retval = ext2fs_test_block_bitmap_range2(
+					ctx->global_ctx->block_found_map, block, num);
+		e2fsck_pass1_block_map_r_unlock(ctx);
+		if (retval)
+			return 0;
+	}
+
+	return 1;
+}
+
 /*
  * Check to see if the inode might really be a directory, despite i_mode
  *
@@ -750,15 +775,10 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
 			if (i >= 4)
 				not_device++;
 
-			e2fsck_pass1_block_map_lock(ctx);
 			if (blk < ctx->fs->super->s_first_data_block ||
 			    blk >= ext2fs_blocks_count(ctx->fs->super) ||
-			    ext2fs_fast_test_block_bitmap2(ctx->block_found_map,
-							   blk)) {
-				e2fsck_pass1_block_map_unlock(ctx);
+			    is_blocks_used(ctx, blk, 1))
 				return;	/* Invalid block, can't be dir */
-			}
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 		blk = inode->i_block[0];
 	}
@@ -1216,11 +1236,28 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 		return pctx.errcode;
 	}
 
+	pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
+			_("multiply claimed block map"),
+			EXT2FS_BMAP64_RBTREE, "block_dup_map",
+			&ctx->block_dup_map);
+	if (pctx.errcode) {
+		pctx.num = 3;
+		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR,
+			    &pctx);
+		/* Should never get here */
+		ctx->flags |= E2F_FLAG_ABORT;
+		return pctx.errcode;
+	}
+
 	if (ext2fs_has_feature_mmp(fs->super) &&
 	    fs->super->s_mmp_block > fs->super->s_first_data_block &&
 	    fs->super->s_mmp_block < ext2fs_blocks_count(fs->super))
 		ext2fs_mark_block_bitmap2(ctx->block_found_map,
 					  fs->super->s_mmp_block);
+#ifdef	CONFIG_PFSCK
+	pthread_mutex_init(&ctx->fs_fix_mutex, NULL);
+	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
+#endif
 
 	return 0;
 }
@@ -1297,12 +1334,17 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 	}
 
 	if (ctx->block_dup_map) {
+		if (!(ctx->flags & E2F_FLAG_DUP_BLOCK)) {
+			ext2fs_free_mem(&block_buf);
+			return;
+		}
 		if (ctx->options & E2F_OPT_PREEN) {
 			clear_problem_context(&pctx);
 			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
 		}
 		e2fsck_pass1_dupblocks(ctx, block_buf);
 		ext2fs_free_mem(&block_buf);
+		ctx->flags &= ~E2F_FLAG_DUP_BLOCK;
 	}
 }
 
@@ -1796,10 +1838,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
-			e2fsck_pass1_block_map_lock(ctx);
-			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
-							  &pb.fs_meta_blocks);
-			e2fsck_pass1_block_map_unlock(ctx);
+			e2fsck_pass1_block_map_r_lock(ctx);
+			pctx.errcode = ext2fs_copy_bitmap(ctx->global_ctx ?
+					ctx->global_ctx->block_found_map :
+					ctx->block_found_map, &pb.fs_meta_blocks);
+			e2fsck_pass1_block_map_r_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2451,7 +2494,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 
 	assert(global_ctx->block_found_map != NULL);
 	assert(global_ctx->block_metadata_map != NULL);
-	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_dup_map != NULL);
 	assert(global_ctx->block_ea_map == NULL);
 	assert(global_ctx->fs->dblist == NULL);
 
@@ -2461,8 +2504,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
-	thread_context->global_ctx = global_ctx;
+	thread_context->block_dup_map = NULL;
 
+	retval = e2fsck_allocate_block_bitmap(global_ctx->fs,
+				_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+				"block_found_map", &thread_context->block_found_map);
+	if (retval)
+		goto out_context;
+
+	thread_context->global_ctx = global_ctx;
 	retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &thread_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
@@ -2513,6 +2563,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 out_fs:
 	ext2fs_free_mem(&thread_fs);
 out_context:
+	if (thread_context->block_found_map)
+		ext2fs_free_mem(&thread_context->block_found_map);
 	ext2fs_free_mem(&thread_context);
 	return retval;
 }
@@ -2767,7 +2819,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2803,6 +2854,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
+	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2822,6 +2875,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
 	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_found_map = block_found_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -2937,6 +2991,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	if (retval)
 		return retval;
 
+	if (ext2fs_has_feature_shared_blocks(global_fs->super) &&
+	    !(global_ctx->options & E2F_OPT_UNSHARE_BLOCKS))
+		return 0;
+	/*
+	 * This need be done after merging block_ea_map
+	 * because ea block might be shared, we need exclude
+	 * them from dup blocks.
+	 */
+	e2fsck_pass1_block_map_w_lock(thread_ctx);
+	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
+				     global_ctx->block_found_map,
+				     global_ctx->block_dup_map,
+				     global_ctx->block_ea_map);
+	e2fsck_pass1_block_map_w_unlock(thread_ctx);
+	if (retval == EEXIST)
+		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
+
 	return 0;
 }
 
@@ -2959,6 +3030,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	if (thread_ctx->refcount)
 		ea_refcount_free(thread_ctx->refcount);
@@ -3152,8 +3224,6 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	int				 num_threads = 1;
 	errcode_t			 retval;
 
-	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
-	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -3412,54 +3482,27 @@ static void alloc_imagic_map(e2fsck_t ctx)
  * WARNING: Assumes checks have already been done to make sure block
  * is valid.  This is true in both process_block and process_bad_block.
  */
-static _INLINE_ void mark_block_used_unlocked(e2fsck_t ctx, blk64_t block)
+static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 {
 	struct problem_context pctx;
-	e2fsck_t global_ctx;
-
-	global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	clear_problem_context(&pctx);
 
-	if (ext2fs_fast_test_block_bitmap2(ctx->block_found_map, block)) {
+	if (is_blocks_used(ctx, block, 1)) {
 		if (ext2fs_has_feature_shared_blocks(ctx->fs->super) &&
 		    !(ctx->options & E2F_OPT_UNSHARE_BLOCKS)) {
 			return;
 		}
-		/**
-		 * this should be safe because this operation has
-		 * been serialized by mutex.
-		 */
-		if (!global_ctx->block_dup_map) {
-			pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
-					_("multiply claimed block map"),
-					EXT2FS_BMAP64_RBTREE, "block_dup_map",
-					&global_ctx->block_dup_map);
-			if (pctx.errcode) {
-				pctx.num = 3;
-				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR,
-					    &pctx);
-				/* Should never get here */
-				ctx->flags |= E2F_FLAG_ABORT;
-				return;
-			}
-		}
+		ctx->flags |= E2F_FLAG_DUP_BLOCK;
+		e2fsck_pass1_block_map_w_lock(ctx);
 		ext2fs_fast_mark_block_bitmap2(global_ctx->block_dup_map, block);
+		e2fsck_pass1_block_map_w_unlock(ctx);
 	} else {
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, block);
 	}
 }
 
-static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
-{
-	e2fsck_pass1_block_map_lock(ctx);
-	mark_block_used_unlocked(ctx, block);
-	e2fsck_pass1_block_map_unlock(ctx);
-
-}
-
 /*
  * When cluster size is greater than one block, it is caller's responsibility
  * to make sure block parameter starts at a cluster boundary.
@@ -3467,16 +3510,14 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 				      unsigned int num)
 {
-	e2fsck_pass1_block_map_lock(ctx);
-	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num)) {
+	if (!is_blocks_used(ctx, block, num)) {
 		ext2fs_mark_block_bitmap_range2(ctx->block_found_map, block, num);
 	} else {
 		unsigned int i;
 
 		for (i = 0; i < num; i += EXT2FS_CLUSTER_RATIO(ctx->fs))
-			mark_block_used_unlocked(ctx, block + i);
+			mark_block_used(ctx, block + i);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 static errcode_t _INLINE_ e2fsck_write_ext_attr3(e2fsck_t ctx, blk64_t block,
@@ -3808,7 +3849,12 @@ refcount_fail:
 	inc_ea_inode_refs(ctx, pctx, first, end);
 	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
 	ea_refcount_store(ctx->refcount_orig, blk, header->h_refcount);
-	mark_block_used(ctx, blk);
+	/**
+	 * It might be racy that this block has been merged in the
+	 * global found map.
+	 */
+	if (!is_blocks_used(ctx, blk, 1))
+		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, blk);
 	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
 
@@ -5053,31 +5099,24 @@ static int process_bad_block(ext2_filsys fs,
 	}
 
 	if (blockcnt < 0) {
-		e2fsck_pass1_block_map_lock(ctx);
 		if (ext2fs_test_block_bitmap2(p->fs_meta_blocks, blk)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BB_FS_BLOCK, pctx)) {
 				*block_nr = 0;
-				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
-		} else if (ext2fs_test_block_bitmap2(ctx->block_found_map,
-						    blk)) {
+		} else if (is_blocks_used(ctx, blk, 1)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BBINODE_BAD_METABLOCK,
 					pctx)) {
 				*block_nr = 0;
-				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
-			if (e2fsck_should_abort(ctx)) {
-				e2fsck_pass1_block_map_unlock(ctx);
+			if (e2fsck_should_abort(ctx))
 				return BLOCK_ABORT;
-			}
 		} else {
-			mark_block_used_unlocked(ctx, blk);
+			mark_block_used(ctx, blk);
 		}
-		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
 #if 0
@@ -5090,13 +5129,10 @@ static int process_bad_block(ext2_filsys fs,
 	 * there's an overlap between the filesystem table blocks
 	 * (bitmaps and inode table) and the bad block list.
 	 */
-	e2fsck_pass1_block_map_lock(ctx);
-	if (!ext2fs_test_block_bitmap2(ctx->block_found_map, blk)) {
+	if (!is_blocks_used(ctx, blk, 1)) {
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
-		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	/*
 	 * Try to find the where the filesystem block was used...
 	 */
@@ -5251,7 +5287,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
-	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -5272,7 +5307,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 3dcfa86a..3a84abb6 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -587,17 +587,29 @@ void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
 }
 
-void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_wrlock(&global_ctx->fs_block_map_rwlock);
 }
 
-void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
 }
+
+void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_rdlock(&global_ctx->fs_block_map_rwlock);
+}
+
+void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
+ }
 #else
 void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
@@ -608,14 +620,24 @@ void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
 
 }
+void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
+{
 
-void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+}
+
+void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
 
 }
 
-void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
 {
+
+}
+
+void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
+{
+
 }
 #endif
 
diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
index 505b3c9c..1facc8dd 100644
--- a/lib/ext2fs/bitops.h
+++ b/lib/ext2fs/bitops.h
@@ -120,6 +120,8 @@ extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 extern __u32 ext2fs_get_generic_bitmap_start(ext2fs_generic_bitmap bitmap);
 extern __u32 ext2fs_get_generic_bitmap_end(ext2fs_generic_bitmap bitmap);
+extern int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+						blk64_t block, unsigned int num);
 
 /* 64-bit versions */
 
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 50617a34..bdfed633 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -725,6 +725,39 @@ int ext2fs_test_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 	return bmap->bitmap_ops->test_clear_bmap_extent(bmap, block, num);
 }
 
+int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+					  blk64_t block, unsigned int num)
+{
+	ext2fs_generic_bitmap_64 bmap = (ext2fs_generic_bitmap_64)bitmap;
+	__u64	end = block + num;
+
+	if (!bmap)
+		return 0;
+
+	if (EXT2FS_IS_32_BITMAP(bmap)) {
+		if ((block & ~0xffffffffULL) ||
+		    ((block+num-1) & ~0xffffffffULL)) {
+			return 0;
+		}
+	}
+
+	if (!EXT2FS_IS_64_BITMAP(bmap))
+		return 0;
+
+	/* convert to clusters if necessary */
+	block >>= bmap->cluster_bits;
+	end += (1 << bmap->cluster_bits) - 1;
+	end >>= bmap->cluster_bits;
+	num = end - block;
+
+	if ((block < bmap->start) || (block > bmap->end) ||
+	    (block+num-1 > bmap->end))
+		return 0;
+
+	return 1;
+}
+
+
 void ext2fs_mark_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 				     blk64_t block, unsigned int num)
 {
diff --git a/tests/f_itable_collision/expect.1 b/tests/f_itable_collision/expect.1
index 01c85d4d..7e98baa8 100644
--- a/tests/f_itable_collision/expect.1
+++ b/tests/f_itable_collision/expect.1
@@ -1,6 +1,5 @@
 Pass 1: Checking inodes, blocks, and sizes
 Inode 12 block 37 conflicts with critical metadata, skipping block checks.
-Illegal block number passed to ext2fs_test_block_bitmap #268435455 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #268435455 for in-use block map
 Inode 12, i_blocks is 48, should be 56.  Fix? yes
 
@@ -27,9 +26,7 @@ Clear inode? yes
 Restarting e2fsck from the beginning...
 Pass 1: Checking inodes, blocks, and sizes
 Inode 12 block 37 conflicts with critical metadata, skipping block checks.
-Illegal block number passed to ext2fs_test_block_bitmap #4294967294 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #4294967294 for in-use block map
-Illegal block number passed to ext2fs_test_block_bitmap #268435455 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #268435455 for in-use block map
 
 Running additional passes to resolve blocks claimed by more than one inode...
-- 
2.29.2.299.gdc1121823c-goog

