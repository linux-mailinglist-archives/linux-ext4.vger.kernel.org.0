Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E61FF6D2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgFRP3l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgFRP3k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2BC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so2581505pls.2
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aq4Ad3DVFjR+g5CTygPN8JsHDdsr3plkLwsoBXe5EOE=;
        b=j1oIgYYLW20rb+58xhllMfk7H9rb/SoIdO4sEPlWzklPOYQDD9HWlURP/Umpam8kL1
         CWpDFCYCYa2fpuD2gsKFpEfwhh2faJrUZRs4jvMr7QQmP3k6/2G4H0Ywz7B5hrqqdgeu
         RjSADwi2eNAM3b0KQzryzScRK7PsYUda6X8Gnm72cKctEVnKPchwl7nYrwywCqdhwvmV
         I54nd6FuIvGX1f2QNkCrICmRXQ5VdNlBxj/gIaBUN3J0aDyJvc9FKq5s4Znk3nLzzM3Z
         0Faxo6ArlxqjnHaG0jZPJ+EEv3oF8aEL2HPrAWp6P85vInMlk94rc26eKsYcTy8r16As
         4tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aq4Ad3DVFjR+g5CTygPN8JsHDdsr3plkLwsoBXe5EOE=;
        b=Y2qS5SU/wkCG/I3e0ijCmlO+KGtIn9Utrs7qZ0BdTgiwK4w1yQqR/raNlme8halxGA
         G/sIxdQcgRVEljjuOtDFsGEmMCnFa6m1+NmKoechgzLpsuxYGRu7jyuCLq8csqpjcZbY
         KuzgstUTvb5LHjAcl5i8xfw3RkuRmbPmPU5zvqpxMTOew3CvY/wZ2991LttWj2FqDi7D
         wIpf7ilaOd+KbEoqd6uZtNZjpryQwiaINKP3SnrhmruekhOU0QVDmO18JRpjQ+R9MXYP
         IjE24Aq0mPKqgP/YYSyXcZQqSQ2gkbm028DwShiPC8GWwNJRJpO2+R1BQE0xKNdD1BZ9
         4kzg==
X-Gm-Message-State: AOAM532FUFSSegrmVs9U2DBID2mTVSP/RfXHON7WjxExXsrBYE2S5wZG
        v9rBFc1S0weS4QuR7XLhZNpCAP1ASjE=
X-Google-Smtp-Source: ABdhPJxLvKUI1dmoiUzjgOcmwuOtLm6bFLRrCkapAgY/sXLe0FsWLLVekbB2bCjcUMAstXPnBpoioQ==
X-Received: by 2002:a17:90b:3448:: with SMTP id lj8mr4682899pjb.163.1592494178859;
        Thu, 18 Jun 2020 08:29:38 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:38 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 36/51] e2fsck: fix to protect EA checking
Date:   Fri, 19 Jun 2020 00:27:39 +0900
Message-Id: <1592494074-28991-37-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

EA related variables are now shared by different
threads, but without any protections.

So this patch try to fix these by seralizing operations.
Optimizations could be done later, since EA blocks
could be shared, need be careful to split and merge.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h |   2 +
 e2fsck/pass1.c  | 184 ++++++++++++++++++++++++++++--------------------
 2 files changed, 111 insertions(+), 75 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2defab92..dcc5c2d6 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -448,6 +448,8 @@ struct e2fsck_struct {
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
 	pthread_mutex_t		 fs_block_map_mutex;
+	/* protect ea related structure */
+	pthread_mutex_t		 fs_ea_mutex;
 };
 
 #ifdef DEBUG_THREADS
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e8c0618b..a73d35fd 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -161,6 +161,18 @@ static inline void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
 	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
 }
 
+static inline void e2fsck_pass1_ea_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_lock(&global_ctx->fs_ea_mutex);
+}
+
+static inline void e2fsck_pass1_ea_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_mutex_unlock(&global_ctx->fs_ea_mutex);
+}
+
 /*
  * Check to make sure a device inode is real.  Returns 1 if the device
  * checks out, 0 if not.
@@ -429,15 +441,16 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 			      struct ext2_ext_attr_entry *first, void *end)
 {
 	struct ext2_ext_attr_entry *entry;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	for (entry = first;
 	     (void *)entry < end && !EXT2_EXT_IS_LAST_ENTRY(entry);
 	     entry = EXT2_EXT_ATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
-		if (!ctx->ea_inode_refs) {
+		if (!global_ctx->ea_inode_refs) {
 			pctx->errcode = ea_refcount_create(0,
-							   &ctx->ea_inode_refs);
+						&global_ctx->ea_inode_refs);
 			if (pctx->errcode) {
 				pctx->num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
@@ -445,8 +458,8 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 				return;
 			}
 		}
-		ea_refcount_increment(ctx->ea_inode_refs, entry->e_value_inum,
-				      0);
+		ea_refcount_increment(global_ctx->ea_inode_refs,
+				      entry->e_value_inum, 0);
 	}
 }
 
@@ -572,8 +585,10 @@ fix:
 	 * EA(s) in automatic fashion -bzzz
 	 */
 	if (problem == 0 || !fix_problem(ctx, problem, pctx)) {
+		e2fsck_pass1_ea_lock(ctx);
 		inc_ea_inode_refs(ctx, pctx,
 				  (struct ext2_ext_attr_entry *)start, end);
+		e2fsck_pass1_ea_unlock(ctx);
 		return;
 	}
 
@@ -1282,14 +1297,49 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
-	char *block_buf;
 
+	char *block_buf =
+		(char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
+					      "block interate buffer");
 	reserve_block_for_root_repair(ctx);
 	reserve_block_for_lnf_repair(ctx);
 
+	/*
+	 * If any extended attribute blocks' reference counts need to
+	 * be adjusted, either up (ctx->refcount_extra), or down
+	 * (ctx->refcount), then fix them.
+	 */
+	if (ctx->refcount) {
+		adjust_extattr_refcount(ctx, ctx->refcount, block_buf, -1);
+		ea_refcount_free(ctx->refcount);
+		ctx->refcount = 0;
+	}
+	if (ctx->refcount_extra) {
+		adjust_extattr_refcount(ctx, ctx->refcount_extra,
+					block_buf, +1);
+		ea_refcount_free(ctx->refcount_extra);
+		ctx->refcount_extra = 0;
+	}
+
+	if (ctx->ea_block_quota_blocks) {
+		ea_refcount_free(ctx->ea_block_quota_blocks);
+		ctx->ea_block_quota_blocks = 0;
+	}
+
+	if (ctx->ea_block_quota_inodes) {
+		ea_refcount_free(ctx->ea_block_quota_inodes);
+		ctx->ea_block_quota_inodes = 0;
+	}
+
 	if (ctx->invalid_bitmaps)
 		handle_fs_bad_blocks(ctx);
 
+	/* We don't need the block_ea_map any more */
+	if (ctx->block_ea_map) {
+		ext2fs_free_block_bitmap(ctx->block_ea_map);
+		ctx->block_ea_map = 0;
+	}
+
 	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
 		struct ext2_inode *inode;
 		int inode_size = EXT2_INODE_SIZE(fs->super);
@@ -1329,10 +1379,6 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 			clear_problem_context(&pctx);
 			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
 		}
-		block_buf =
-			(char *)e2fsck_allocate_memory(ctx,
-					ctx->fs->blocksize * 3,
-					"block interate buffer");
 		e2fsck_pass1_dupblocks(ctx, block_buf);
 		ext2fs_free_mem(&block_buf);
 	}
@@ -2175,40 +2221,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ext2fs_close_inode_scan(scan);
 	scan = NULL;
 
-	/*
-	 * If any extended attribute blocks' reference counts need to
-	 * be adjusted, either up (ctx->refcount_extra), or down
-	 * (ctx->refcount), then fix them.
-	 */
-	if (ctx->refcount) {
-		adjust_extattr_refcount(ctx, ctx->refcount, block_buf, -1);
-		ea_refcount_free(ctx->refcount);
-		ctx->refcount = 0;
-	}
-	if (ctx->refcount_extra) {
-		adjust_extattr_refcount(ctx, ctx->refcount_extra,
-					block_buf, +1);
-		ea_refcount_free(ctx->refcount_extra);
-		ctx->refcount_extra = 0;
-	}
-
-	if (ctx->ea_block_quota_blocks) {
-		ea_refcount_free(ctx->ea_block_quota_blocks);
-		ctx->ea_block_quota_blocks = 0;
-	}
-
-	if (ctx->ea_block_quota_inodes) {
-		ea_refcount_free(ctx->ea_block_quota_inodes);
-		ctx->ea_block_quota_inodes = 0;
-	}
-
-
-	/* We don't need the block_ea_map any more */
-	if (ctx->block_ea_map) {
-		ext2fs_free_block_bitmap(ctx->block_ea_map);
-		ctx->block_ea_map = 0;
-	}
-
 	/* We don't need the encryption policy => ID map any more */
 	destroy_encryption_policy_map(ctx);
 
@@ -2759,7 +2771,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
 	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
-	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2788,6 +2799,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
 	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
 	int invalid_bitmaps = global_ctx->invalid_bitmaps;
+	ext2_refcount_t refcount = global_ctx->refcount;
+	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
+	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
+	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
+	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
+	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2805,7 +2822,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_imagic_map = inode_imagic_map;
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
@@ -2815,6 +2831,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
+	global_ctx->refcount = refcount;
+	global_ctx->refcount_extra = refcount_extra;
+	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
+	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
+	global_ctx->block_ea_map = block_ea_map;
+	global_ctx->ea_inode_refs = ea_inode_refs;
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_directory_count);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_regular_count);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_blockdev_count);
@@ -2875,7 +2897,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
-	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
 
 	return 0;
 }
@@ -2898,7 +2919,6 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_imagic_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
-	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	e2fsck_free_dir_info(thread_ctx);
@@ -3105,6 +3125,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
+	pthread_mutex_init(&global_ctx->fs_ea_mutex, NULL);
 	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
 		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
 
@@ -3421,12 +3442,10 @@ static void adjust_extattr_refcount(e2fsck_t ctx, ext2_refcount_t refcount,
 		should_be = header->h_refcount + adjust_sign * (int)count;
 		pctx.num = should_be;
 		if (fix_problem(ctx, PR_1_EXTATTR_REFCOUNT, &pctx)) {
-			e2fsck_pass1_fix_lock(ctx);
 			header->h_refcount = should_be;
 			pctx.errcode = ext2fs_write_ext_attr3(fs, blk,
 							     block_buf,
 							     pctx.ino);
-			e2fsck_pass1_fix_unlock(ctx);
 			if (pctx.errcode) {
 				fix_problem(ctx, PR_1_EXTATTR_WRITE_ABORT,
 					    &pctx);
@@ -3453,6 +3472,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	__u64		quota_inodes = 0;
 	region_t	region = 0;
 	int		failed_csum = 0;
+	e2fsck_t	global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	ea_block_quota->blocks = 0;
 	ea_block_quota->inodes = 0;
@@ -3476,26 +3496,30 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	}
 
 	/* If ea bitmap hasn't been allocated, create it */
-	if (!ctx->block_ea_map) {
+	e2fsck_pass1_ea_lock(ctx);
+	if (!global_ctx->block_ea_map) {
 		pctx->errcode = e2fsck_allocate_block_bitmap(fs,
 					_("ext attr block map"),
 					EXT2FS_BMAP64_RBTREE, "block_ea_map",
-					&ctx->block_ea_map);
+					&global_ctx->block_ea_map);
 		if (pctx->errcode) {
 			pctx->num = 2;
 			fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
+			e2fsck_pass1_ea_unlock(ctx);
 			return 0;
 		}
 	}
 
 	/* Create the EA refcount structure if necessary */
-	if (!ctx->refcount) {
-		pctx->errcode = ea_refcount_create(0, &ctx->refcount);
+	if (!global_ctx->refcount) {
+		pctx->errcode = ea_refcount_create(0,
+					&global_ctx->refcount);
 		if (pctx->errcode) {
 			pctx->num = 1;
 			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
+			e2fsck_pass1_ea_unlock(ctx);
 			return 0;
 		}
 	}
@@ -3506,37 +3530,44 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 #endif
 
 	/* Have we seen this EA block before? */
-	if (ext2fs_fast_test_block_bitmap2(ctx->block_ea_map, blk)) {
+	if (ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+					   blk)) {
 		ea_block_quota->blocks = EXT2FS_C2B(fs, 1);
 		ea_block_quota->inodes = 0;
 
-		if (ctx->ea_block_quota_blocks) {
-			ea_refcount_fetch(ctx->ea_block_quota_blocks, blk,
-					  &quota_blocks);
+		if (global_ctx->ea_block_quota_blocks) {
+			ea_refcount_fetch(global_ctx->ea_block_quota_blocks,
+					  blk, &quota_blocks);
 			if (quota_blocks)
 				ea_block_quota->blocks = quota_blocks;
 		}
 
-		if (ctx->ea_block_quota_inodes)
-			ea_refcount_fetch(ctx->ea_block_quota_inodes, blk,
-					  &ea_block_quota->inodes);
+		if (global_ctx->ea_block_quota_inodes)
+			ea_refcount_fetch(global_ctx->ea_block_quota_inodes,
+					  blk, &ea_block_quota->inodes);
 
-		if (ea_refcount_decrement(ctx->refcount, blk, 0) == 0)
+		if (ea_refcount_decrement(global_ctx->refcount,
+					  blk, 0) == 0) {
+			e2fsck_pass1_ea_unlock(ctx);
 			return 1;
+		}
 		/* Ooops, this EA was referenced more than it stated */
-		if (!ctx->refcount_extra) {
+		if (!global_ctx->refcount_extra) {
 			pctx->errcode = ea_refcount_create(0,
-					   &ctx->refcount_extra);
+					   &global_ctx->refcount_extra);
 			if (pctx->errcode) {
 				pctx->num = 2;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_ea_unlock(ctx);
 				return 0;
 			}
 		}
-		ea_refcount_increment(ctx->refcount_extra, blk, 0);
+		ea_refcount_increment(global_ctx->refcount_extra, blk, 0);
+		e2fsck_pass1_ea_unlock(ctx);
 		return 1;
 	}
+	e2fsck_pass1_ea_unlock(ctx);
 
 	/*
 	 * OK, we haven't seen this EA block yet.  So we need to
@@ -3663,44 +3694,47 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 			return 0;
 	}
 
+	e2fsck_pass1_ea_lock(ctx);
 	if (quota_blocks != EXT2FS_C2B(fs, 1U)) {
-		if (!ctx->ea_block_quota_blocks) {
+		if (!global_ctx->ea_block_quota_blocks) {
 			pctx->errcode = ea_refcount_create(0,
-						&ctx->ea_block_quota_blocks);
+					&global_ctx->ea_block_quota_blocks);
 			if (pctx->errcode) {
 				pctx->num = 3;
 				goto refcount_fail;
 			}
 		}
-		ea_refcount_store(ctx->ea_block_quota_blocks, blk,
-				  quota_blocks);
+		ea_refcount_store(global_ctx->ea_block_quota_blocks,
+				  blk, quota_blocks);
 	}
 
 	if (quota_inodes) {
-		if (!ctx->ea_block_quota_inodes) {
+		if (!global_ctx->ea_block_quota_inodes) {
 			pctx->errcode = ea_refcount_create(0,
-						&ctx->ea_block_quota_inodes);
+					&global_ctx->ea_block_quota_inodes);
 			if (pctx->errcode) {
 				pctx->num = 4;
 refcount_fail:
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_ea_unlock(ctx);
 				return 0;
 			}
 		}
 
-		ea_refcount_store(ctx->ea_block_quota_inodes, blk,
-				  quota_inodes);
+		ea_refcount_store(global_ctx->ea_block_quota_inodes,
+				  blk, quota_inodes);
 	}
 	ea_block_quota->blocks = quota_blocks;
 	ea_block_quota->inodes = quota_inodes;
 
-	inc_ea_inode_refs(ctx, pctx, first, end);
-	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
+	inc_ea_inode_refs(global_ctx, pctx, first, end);
+	ea_refcount_store(global_ctx->refcount, blk, header->h_refcount - 1);
 	e2fsck_pass1_block_map_lock(ctx);
 	mark_block_used(ctx, blk);
 	e2fsck_pass1_block_map_unlock(ctx);
-	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
+	ext2fs_fast_mark_block_bitmap2(global_ctx->block_ea_map, blk);
+	e2fsck_pass1_ea_unlock(ctx);
 	return 1;
 
 clear_extattr:
-- 
2.25.4

