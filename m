Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AF61F318
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiKGM1K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiKGM1H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454616247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r18so10296258pgr.12
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZD2Jr2yW63XIeTFZ1Y0HbzT/Is6Ul87Qe/nsH446CI=;
        b=Y2Vcq8aJzbmapYxHsFQszOfCoQLKuycjBL5CHvWpUW1zNE/nf9NwtGOg7rELVSnag0
         X6ENNHfuWjzy22RNhVAFVPYInAJLP1o+B4idblrABtwUIdAVYVc0jtCGMqsdinxro0k3
         P+RDiT2waSY5dchAyAkfJRZu4yEmvGnl8smlnvwMDjdqEN9l+P548guA/t8Dv3YhR/kz
         IHrh9INgSLt36li124AP6hkY+DY9sows7Af113s1I0CVedjXp25X9e7czoWh3GtzNeLM
         A7Hk/yog9nu5dZ5snmuXWBd14oV6dMiDv9Cbhqs83BpoHs20tKz4a3KHXSESZNEOXyEK
         hfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZD2Jr2yW63XIeTFZ1Y0HbzT/Is6Ul87Qe/nsH446CI=;
        b=gdGw4F4AXtiAHYryJPk1Fj3gp70cU+gJqQaP9eS2hBb+yGSsLnaXS8dVlSurzT8HKv
         tLaFO+i2kl1h3H24aM2mF9zA+4QWd9IRbE7xs/aoRRx2tSMqrkQsnUa3sP3p3NHk5JvK
         nw33HRXeJfZp4aAg0AQNLUE2lW3Yb0bIozNWYHqTXnydFaMKy51gy4HdjlwFEZLmSN+D
         JuMaxdhNsppgQK5TvCSd588GQ3L9WZEoyFzuYMKV4/xJLHtd92plNlFJbzdOQ5woV4d9
         mF6Kab8jCUIUJggrb3bDjqOYVnZN6w03FmAYJffn15AWj1xg3lJNlUQYZmM19QOr0NpJ
         7ASQ==
X-Gm-Message-State: ACrzQf3oJYMF1cHZbO9S3WhpGNsUjRvd72NcmIKIHFCRQHeI2M4o+LQj
        VPPOGybLNoEZ6qeXVNRcSNw=
X-Google-Smtp-Source: AMsMyM4RpHOh5TKd7rsXDzM2Fm3AdPk74wBz2FP+8M1o5Vt2PhO+iukD+/p1J2jargyDmrB6lE9Ctg==
X-Received: by 2002:a65:5942:0:b0:46f:f741:8adc with SMTP id g2-20020a655942000000b0046ff7418adcmr27026815pgu.265.1667824025611;
        Mon, 07 Nov 2022 04:27:05 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id ei15-20020a17090ae54f00b00213d08fa459sm4260093pjb.17.2022.11.07.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:05 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 46/72] e2fsck: merge EA blocks properly
Date:   Mon,  7 Nov 2022 17:51:34 +0530
Message-Id: <554875d57922b15947ee874e2588d174ec2e6284.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

EA blocks might be shared, merge them carefully.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h |   1 +
 e2fsck/pass1.c  | 244 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 212 insertions(+), 33 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 55f75042..beac7054 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -333,6 +333,7 @@ struct e2fsck_struct {
 
 	ext2_refcount_t	refcount;
 	ext2_refcount_t refcount_extra;
+	ext2_refcount_t refcount_orig;
 
 	/*
 	 * Quota blocks and inodes to be charged for each ea block.
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e268441a..06306a17 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -680,14 +680,14 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -1234,14 +1234,39 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
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
@@ -1281,10 +1306,6 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
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
@@ -2145,23 +2166,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2172,13 +2176,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
 
@@ -2533,6 +2530,155 @@ static errcode_t e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx,
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
 
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
@@ -2551,7 +2697,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
 	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
-	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2580,6 +2725,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
 	jmp_buf old_jmp;
@@ -2598,7 +2750,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_imagic_map = inode_imagic_map;
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
@@ -2608,6 +2759,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2654,6 +2812,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
+	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
 	global_ctx->qctx = qctx;
 	retval = quota_merge_and_update_usage(global_ctx->qctx,
 					      thread_ctx->qctx);
@@ -2723,6 +2883,14 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
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
@@ -3370,6 +3538,15 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 
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
@@ -3575,6 +3752,7 @@ refcount_fail:
 
 	inc_ea_inode_refs(ctx, pctx, first, end);
 	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
+	ea_refcount_store(ctx->refcount_orig, blk, header->h_refcount);
 	mark_block_used(ctx, blk);
 	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
-- 
2.37.3

