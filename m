Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9212B80E1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgKRPl2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKRPl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:27 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE20C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q25so1749056qkm.17
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZIUX778P7BRRnxlKsN/61V0caaEGkj/6yu/1n19ZbCw=;
        b=AO09PttaA6ki8Sf81OwZjjVWhsFbfVvZj2EgcyyIAY8St6PcViI/PU20Ear+nNxpQk
         jPGCDxAmXpbTYfbhbHNJfnExBJPHRSnbpxIUIlopwNKmap4i15t7VVZUOsTBP/5smCnQ
         68knrJMam7fDcQsG6WeINV37MPDExfjBvRNTgUsENBE8x3LvHpHYXDH1qNspGDcZpzW1
         D7slzxzo+Ebd4JeR3s0eUdXsgi+D7cFVptUe2H47JT2A42iDt06n8yZoRo7KY7lr/SIw
         b+DH+/2htP3xkCI9zHih9EtEA3d0bF82S/wDcZ1ctPBXnzA4wmkC0zq/TvXZPQnnja0Z
         puzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZIUX778P7BRRnxlKsN/61V0caaEGkj/6yu/1n19ZbCw=;
        b=NGmqUNYwTnkKO3+x3ebBfE9p7xbFio7TGI1gCCssdGr0XNee1NN0IglHYsfqLsuqJ5
         TnG2HIL7wZVhp9NLCefEnc3IRFMDbmhuXU3KZd8PofLHv2fM8BuyWRQ2h+34duzg+G8L
         QiSA88MGK2xqIr2iNIKsVtsN8yiZMharrlIvS39Y2c0RAaGv/oL+1C9TBsobA0RY+9Ef
         7+t7QR+bOV1szszx9fAdomfCNA4MKSkxsCk1t65qq+RFSL87H4ow6HGFddu4koS8FUGu
         Oz+rOHNHvhVMflf4uKvxqBMPtBBL/yzMH65yQ5fbJ4uTYzdKwvt16/YBAEsWPvpmgjUS
         ZkdQ==
X-Gm-Message-State: AOAM531JlKo+gKxEdT1mcbVVDQ8BreIyEhr9pw2zVoYWbd8rvawsPnAe
        Kyv9tBHcE3RiQrEPefUXu3Em1rO2/G7ciQt3mZHqlvPROqPoSaEul2nwsUK4mYCqWDNA+zsOhte
        Z4Nx0Ge8jwZj1uFmeIYdEesg51FMUmU2lMhsGf/sUqve7pYxFq6U8MAmtjo3Q3umY+g6Fj5mXNI
        4eDO7psh4=
X-Google-Smtp-Source: ABdhPJycKQTQKSCvsWwDXuo8iS7VXEbY63r/zj5YZ2R6Q6FZLq3gxsSWKWCjPayLbAq4DduntRD31n8oCbGKnrOTFG4=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:e88c:: with SMTP id
 b12mr4984612qvo.42.1605714085381; Wed, 18 Nov 2020 07:41:25 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:18 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-33-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 32/61] e2fsck: merge EA blocks properly
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

EA blocks might be shared, merge them carefully.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h |   1 +
 e2fsck/pass1.c  | 245 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 213 insertions(+), 33 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index fecc8bbf..192a534c 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -299,6 +299,7 @@ struct e2fsck_struct {
 
 	ext2_refcount_t	refcount;
 	ext2_refcount_t refcount_extra;
+	ext2_refcount_t refcount_orig;
 
 	/*
 	 * Quota blocks and inodes to be charged for each ea block.
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 29954e88..8b03b6f9 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -677,14 +677,14 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
 	    LINUX_S_ISLNK(inode->i_mode) || inode->i_block[0] == 0)
 		return;
 
-	/* 
+	/*
 	 * Check the block numbers in the i_block array for validity:
 	 * zero blocks are skipped (but the first one cannot be zero -
 	 * see above), other blocks are checked against the first and
 	 * max data blocks (from the the superblock) and against the
 	 * block bitmap. Any invalid block found means this cannot be
 	 * a directory.
-	 * 
+	 *
 	 * If there are non-zero blocks past the fourth entry, then
 	 * this cannot be a device file: we remember that for the next
 	 * check.
@@ -1229,14 +1229,39 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
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
@@ -1276,10 +1301,6 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
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
@@ -2094,23 +2115,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
 	if (ctx->ea_block_quota_blocks) {
 		ea_refcount_free(ctx->ea_block_quota_blocks);
 		ctx->ea_block_quota_blocks = 0;
@@ -2121,13 +2125,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-
-	/* We don't need the block_ea_map any more */
-	if (ctx->block_ea_map) {
-		ext2fs_free_block_bitmap(ctx->block_ea_map);
-		ctx->block_ea_map = 0;
-	}
-
 	/* We don't need the encryption policy => ID map any more */
 	destroy_encryption_policy_map(ctx);
 
@@ -2604,6 +2601,156 @@ static errcode_t e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx,
 	return retval;
 }
 
+static errcode_t e2fsck_pass1_merge_ea_inode_refs(e2fsck_t global_ctx,
+						  e2fsck_t thread_ctx)
+{
+	ea_value_t count;
+	blk64_t blk;
+	errcode_t retval;
+
+	if (!thread_ctx->ea_inode_refs)
+		return 0;
+
+	if (!global_ctx->ea_inode_refs) {
+		global_ctx->ea_inode_refs = thread_ctx->ea_inode_refs;
+		thread_ctx->ea_inode_refs = NULL;
+		return 0;
+	}
+
+	ea_refcount_intr_begin(thread_ctx->ea_inode_refs);
+	while (1) {
+		if ((blk = ea_refcount_intr_next(thread_ctx->ea_inode_refs,
+						 &count)) == 0)
+			break;
+		if (!global_ctx->block_ea_map ||
+		    !ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+						    blk)) {
+			retval = ea_refcount_store(global_ctx->ea_inode_refs,
+						   blk, count);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return retval;
+}
+
+static ea_value_t ea_refcount_usage(e2fsck_t ctx, blk64_t blk,
+				    ea_value_t *orig)
+{
+	ea_value_t count_cur;
+	ea_value_t count_extra = 0;
+	ea_value_t count_orig;
+
+	ea_refcount_fetch(ctx->refcount_orig, blk, &count_orig);
+	ea_refcount_fetch(ctx->refcount, blk, &count_cur);
+	/* most of time this is not needed */
+	if (ctx->refcount_extra && count_cur == 0)
+		ea_refcount_fetch(ctx->refcount_extra, blk, &count_extra);
+
+	if (!count_orig)
+		count_orig = *orig;
+	else if (orig)
+		*orig = count_orig;
+
+	return count_orig + count_extra - count_cur;
+}
+
+static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
+						e2fsck_t thread_ctx)
+{
+	ea_value_t count;
+	blk64_t blk;
+	errcode_t retval = 0;
+
+	if (!thread_ctx->refcount)
+		return 0;
+
+	if (!global_ctx->refcount) {
+		global_ctx->refcount = thread_ctx->refcount;
+		thread_ctx->refcount = NULL;
+		global_ctx->refcount_extra = thread_ctx->refcount;
+		thread_ctx->refcount_extra = NULL;
+		return 0;
+	}
+
+	ea_refcount_intr_begin(thread_ctx->refcount);
+	while (1) {
+		if ((blk = ea_refcount_intr_next(thread_ctx->refcount,
+						 &count)) == 0)
+			break;
+		/**
+		 * this EA has never seen before, so just store its
+		 * refcount and refcount_extra into global_ctx if needed.
+		 */
+		if (!global_ctx->block_ea_map ||
+		    !ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+						    blk)) {
+			ea_value_t extra;
+
+			retval = ea_refcount_store(global_ctx->refcount,
+						   blk, count);
+			if (retval)
+				return retval;
+
+			if (count > 0 || !thread_ctx->refcount_extra)
+				continue;
+			ea_refcount_fetch(thread_ctx->refcount_extra, blk,
+					  &extra);
+			if (extra == 0)
+				continue;
+
+			if (!global_ctx->refcount_extra) {
+				retval = ea_refcount_create(0,
+						&global_ctx->refcount_extra);
+				if (retval)
+					return retval;
+			}
+			retval = ea_refcount_store(global_ctx->refcount_extra,
+						   blk, extra);
+			if (retval)
+				return retval;
+		} else {
+			ea_value_t orig;
+			ea_value_t thread_usage;
+			ea_value_t global_usage;
+			ea_value_t new;
+
+			thread_usage = ea_refcount_usage(thread_ctx,
+							 blk, &orig);
+			global_usage = ea_refcount_usage(global_ctx,
+							 blk, &orig);
+			if (thread_usage + global_usage <= orig) {
+				new = orig - thread_usage - global_usage;
+				retval = ea_refcount_store(global_ctx->refcount,
+							   blk, new);
+				if (retval)
+					return retval;
+				continue;
+			}
+			/* update it is as zero */
+			retval = ea_refcount_store(global_ctx->refcount,
+						   blk, 0);
+			if (retval)
+				return retval;
+			/* Ooops, this EA was referenced more than it stated */
+			if (!global_ctx->refcount_extra) {
+				retval = ea_refcount_create(0,
+						&global_ctx->refcount_extra);
+				if (retval)
+					return retval;
+			}
+			new = global_usage + thread_usage - orig;
+			retval = ea_refcount_store(global_ctx->refcount_extra,
+						   blk, new);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return retval;
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2621,7 +2768,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
 	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
-	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2650,6 +2796,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
 	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
 	int invalid_bitmaps = global_ctx->invalid_bitmaps;
+	ext2_refcount_t refcount = global_ctx->refcount;
+	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
+	ext2_refcount_t refcount_orig = global_ctx->refcount_orig;
+	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
+	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
+	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
+	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2668,7 +2821,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_imagic_map = inode_imagic_map;
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
@@ -2678,6 +2830,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
+	global_ctx->refcount = refcount;
+	global_ctx->refcount_extra = refcount_extra;
+	global_ctx->refcount_orig = refcount_orig;
+	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
+	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
+	global_ctx->block_ea_map = block_ea_map;
+	global_ctx->ea_inode_refs = ea_inode_refs;
 	global_ctx->fs_directory_count += fs_directory_count;
 	global_ctx->fs_regular_count += fs_regular_count;
 	global_ctx->fs_blockdev_count += fs_blockdev_count;
@@ -2723,6 +2882,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
+	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
 	global_ctx->qctx = qctx;
 	retval = quota_merge_and_update_usage(global_ctx->qctx,
 					      thread_ctx->qctx);
@@ -2799,6 +2960,14 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
+	if (thread_ctx->refcount)
+		ea_refcount_free(thread_ctx->refcount);
+	if (thread_ctx->refcount_extra)
+		ea_refcount_free(thread_ctx->refcount_extra);
+	if (thread_ctx->ea_inode_refs)
+		ea_refcount_free(thread_ctx->ea_inode_refs);
+	if (thread_ctx->refcount_orig)
+		ea_refcount_free(thread_ctx->refcount_orig);
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
@@ -3425,6 +3594,15 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 
 	/* Create the EA refcount structure if necessary */
 	if (!ctx->refcount) {
+		pctx->errcode = ea_refcount_create(0,
+					&ctx->refcount_orig);
+		if (pctx->errcode) {
+			pctx->num = 1;
+			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			return 0;
+		}
+
 		pctx->errcode = ea_refcount_create(0, &ctx->refcount);
 		if (pctx->errcode) {
 			pctx->num = 1;
@@ -3629,6 +3807,7 @@ refcount_fail:
 
 	inc_ea_inode_refs(ctx, pctx, first, end);
 	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
+	ea_refcount_store(ctx->refcount_orig, blk, header->h_refcount);
 	mark_block_used(ctx, blk);
 	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
-- 
2.29.2.299.gdc1121823c-goog

