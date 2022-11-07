Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5C61F328
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiKGM2B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiKGM1y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AED1A817
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d20so9844328plr.10
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvzSnOk6N2gJ52ngbooAIOmxuIXr9zJ3A/nrYrNKyog=;
        b=idB6WIWy+aDX1rLNDWYK552R6h52I5AFSe0TVGFPRiyaYOYQpC/ffW1G1Ou2/Ol41L
         StYdeFkCqZC6VrNSgRYyX7tuWNejrT5jcAplhfC87dtFq9ic3JayQ73FusFAUsoI6S7S
         PX1cUQepnspum3Z+mmjAdHXdbFZGvBOb7OTcjx3CJrGzkWybD2sRnuj5wD26+78V4q9W
         Qw2aqAgxS+9D99y4UxLIFyeE5SguGpKGFQhB7kpqSnXe0iT6ryVoa0Krb/JEj+8eUMqn
         9i5dgIFH42zU1vughL1JdUGy4g7uRicRkGe0C1qaj2f+x1SeJ3g4We6a23+P42IZp2NZ
         zScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvzSnOk6N2gJ52ngbooAIOmxuIXr9zJ3A/nrYrNKyog=;
        b=heGso9nZTJdtsMUEUuw1Pe+KZcdpMSSVybHHp3t6P7qoOZVx3Zu1PvFSlHz49KhQHP
         D5YBZ6MseBKFkfg9DFDexpC28BScjkuMePCc7w0CDmAvDfGUubFahETgxh8fMQVssy0s
         84jdgHAXsM0iUrvQ/eKQa3kjMVbKRWUfTk6sCsJDzynuudyE4BktY+dvzTLXwA7XFOXa
         8ck9aEITGZcdXz1oQ9QkI18YMiXPt8tFlwOGtVDxjG0QMbOUBTRBcSnWix49X2ah/xoz
         lfyxJH2vGf29CutXJG9aF4SxttpY1sd49b3HCd5p94uZ1hlAjpNtZGQn3kA5/Do80ZHu
         x1HA==
X-Gm-Message-State: ACrzQf026imAIW8mg/wlTR9qIkue0gNFc0/94oy2OkzJvsF3Zaa6P2C0
        9sfn24ryh/K4XyKPlhZxBl8=
X-Google-Smtp-Source: AMsMyM4IEkNfO2J75xu59rpwvyN6CDx6t5RLp18NQY+Yi8gDY/903f3J4AWL/LgTwUmz3G+I43SMUw==
X-Received: by 2002:a17:903:2446:b0:187:11c6:6a1b with SMTP id l6-20020a170903244600b0018711c66a1bmr43952690pls.39.1667824072400;
        Mon, 07 Nov 2022 04:27:52 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090300d100b0016eef326febsm4910425plc.1.2022.11.07.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:51 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 54/72] e2fsck: simplify e2fsck context merging codes
Date:   Mon,  7 Nov 2022 17:51:42 +0530
Message-Id: <e631d4c9da5f9abb691983f75b1636edeb1ce92f.1667822611.git.ritesh.list@gmail.com>
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

We tried to copy thread context to global context directly
and then copy back some saved variables before merging.

Since we have finished almost all necessary variables
in the e2fsck context, we could simplify codes, and
this could help us understand what is missing rather
than hide problems.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 158 ++++++++++---------------------------------------
 1 file changed, 31 insertions(+), 127 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index c89c424d..8e85f70f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2813,136 +2813,51 @@ static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
+					    e2fsck_t thread_ctx)
 {
-	errcode_t retval = 0;
-	int flags = global_ctx->flags;
-	FILE *global_logf = global_ctx->logf;
-	FILE *global_problem_logf = global_ctx->problem_logf;
-	ext2_filsys thread_fs = thread_ctx->fs;
 	ext2_filsys global_fs = global_ctx->fs;
-	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
-	struct dir_info_db *dir_info = global_ctx->dir_info;
-	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
-	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
-	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
-	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
-	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
-	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
-	ext2_icount_t inode_count = global_ctx->inode_count;
-	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
-	__u32 fs_directory_count = global_ctx->fs_directory_count;
-	__u32 fs_regular_count = global_ctx->fs_regular_count;
-	__u32 fs_blockdev_count = global_ctx->fs_blockdev_count;
-	__u32 fs_chardev_count = global_ctx->fs_chardev_count;
-	__u32 fs_links_count = global_ctx->fs_links_count;
-	__u32 fs_symlinks_count = global_ctx->fs_symlinks_count;
-	__u32 fs_fast_symlinks_count = global_ctx->fs_fast_symlinks_count;
-	__u32 fs_fifo_count = global_ctx->fs_fifo_count;
-	__u32 fs_total_count = global_ctx->fs_total_count;
-	__u32 fs_badblocks_count = global_ctx->fs_badblocks_count;
-	__u32 fs_sockets_count = global_ctx->fs_sockets_count;
-	__u32 fs_ind_count = global_ctx->fs_ind_count;
-	__u32 fs_dind_count = global_ctx->fs_dind_count;
-	__u32 fs_tind_count = global_ctx->fs_tind_count;
-	__u32 fs_fragmented = global_ctx->fs_fragmented;
-	__u32 fs_fragmented_dir = global_ctx->fs_fragmented_dir;
-	__u32 large_files = global_ctx->large_files;
-	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
-	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
-	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
-	quota_ctx_t qctx = global_ctx->qctx;
-	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
-	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
-	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
-	int invalid_bitmaps = global_ctx->invalid_bitmaps;
-	ext2_refcount_t refcount = global_ctx->refcount;
-	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
-	ext2_refcount_t refcount_orig = global_ctx->refcount_orig;
-	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
-	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
-	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
-	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
-	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
-	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
-	int options = global_ctx->options, i;
-	__u32 extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
-
-	memcpy(extent_depth_count, global_ctx->extent_depth_count,
-	       sizeof(extent_depth_count));
-#ifdef HAVE_SETJMP_H
-	jmp_buf old_jmp;
-
-	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
-#endif
-	memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
-#ifdef HAVE_SETJMP_H
-	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
-#endif
+	errcode_t retval = 0;
+	int i;
 
-	global_ctx->inode_used_map = inode_used_map;
-	global_ctx->inode_bad_map = inode_bad_map;
-	global_ctx->inode_dir_map = inode_dir_map;
-	global_ctx->inode_bb_map = inode_bb_map;
-	global_ctx->inode_imagic_map = inode_imagic_map;
-	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
-	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_dup_map = block_dup_map;
-	global_ctx->block_found_map = block_found_map;
-	global_ctx->dir_info = dir_info;
-	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
-	global_ctx->dx_dir_info = dx_dir_info;
-	global_ctx->dx_dir_info_count = dx_dir_info_count;
-	global_ctx->dx_dir_info_size = dx_dir_info_size;
-	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
-	global_ctx->inode_count = inode_count;
-	global_ctx->inode_link_info = inode_link_info;
-	global_ctx->refcount = refcount;
-	global_ctx->refcount_extra = refcount_extra;
-	global_ctx->refcount_orig = refcount_orig;
-	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
-	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
-	global_ctx->block_ea_map = block_ea_map;
-	global_ctx->ea_inode_refs = ea_inode_refs;
-	global_ctx->fs_directory_count += fs_directory_count;
-	global_ctx->fs_regular_count += fs_regular_count;
-	global_ctx->fs_blockdev_count += fs_blockdev_count;
-	global_ctx->fs_chardev_count += fs_chardev_count;
-	global_ctx->fs_links_count += fs_links_count;
-	global_ctx->fs_symlinks_count += fs_symlinks_count;
-	global_ctx->fs_fast_symlinks_count += fs_fast_symlinks_count;
-	global_ctx->fs_fifo_count += fs_fifo_count;
-	global_ctx->fs_total_count += fs_total_count;
-	global_ctx->fs_badblocks_count += fs_badblocks_count;
-	global_ctx->fs_sockets_count += fs_sockets_count;
-	global_ctx->fs_ind_count += fs_ind_count;
-	global_ctx->fs_dind_count += fs_dind_count;
-	global_ctx->fs_tind_count += fs_tind_count;
-	global_ctx->fs_fragmented += fs_fragmented;
-	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
-	global_ctx->large_files += large_files;
+	global_ctx->fs_directory_count += thread_ctx->fs_directory_count;
+	global_ctx->fs_regular_count += thread_ctx->fs_regular_count;
+	global_ctx->fs_blockdev_count += thread_ctx->fs_blockdev_count;
+	global_ctx->fs_chardev_count += thread_ctx->fs_chardev_count;
+	global_ctx->fs_links_count += thread_ctx->fs_links_count;
+	global_ctx->fs_symlinks_count += thread_ctx->fs_symlinks_count;
+	global_ctx->fs_fast_symlinks_count += thread_ctx->fs_fast_symlinks_count;
+	global_ctx->fs_fifo_count += thread_ctx->fs_fifo_count;
+	global_ctx->fs_total_count += thread_ctx->fs_total_count;
+	global_ctx->fs_badblocks_count += thread_ctx->fs_badblocks_count;
+	global_ctx->fs_sockets_count += thread_ctx->fs_sockets_count;
+	global_ctx->fs_ind_count += thread_ctx->fs_ind_count;
+	global_ctx->fs_dind_count += thread_ctx->fs_dind_count;
+	global_ctx->fs_tind_count += thread_ctx->fs_tind_count;
+	global_ctx->fs_fragmented += thread_ctx->fs_fragmented;
+	global_ctx->fs_fragmented_dir += thread_ctx->fs_fragmented_dir;
+	global_ctx->large_files += thread_ctx->large_files;
 	/* threads might enable E2F_OPT_YES */
-	global_ctx->options |= options;
-	global_ctx->flags |= flags;
-	global_ctx->logf = global_logf;
-	global_ctx->problem_logf = global_problem_logf;
-	global_ctx->global_ctx = NULL;
+	global_ctx->options |= thread_ctx->options;
+	global_ctx->flags |= thread_ctx->flags;
 	/*
 	 * The l+f inode may have been cleared, so zap it now and
 	 * later passes will recalculate it if necessary
 	 */
 	global_ctx->lost_and_found = 0;
-	memcpy(global_ctx->extent_depth_count, extent_depth_count,
-	       sizeof(extent_depth_count));
 	/* merge extent depth count */
 	for (i = 0; i < MAX_EXTENT_DEPTH_COUNT; i++)
 		global_ctx->extent_depth_count[i] +=
 			thread_ctx->extent_depth_count[i];
 
-	global_fs->priv_data = global_ctx;
-	global_ctx->fs = global_fs;
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 
+	retval = ext2fs_merge_fs(&(thread_ctx->fs));
+	if (retval) {
+		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
+		return retval;
+	}
 	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, 0,
@@ -2950,12 +2865,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
-	retval = ext2fs_merge_fs(&(thread_ctx->fs));
-	if (retval) {
-		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
-		return retval;
-	}
-	global_ctx->dirs_to_hash = dirs_to_hash;
 	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, 0,
@@ -2965,16 +2874,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 
 	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
-	global_ctx->qctx = qctx;
 	retval = quota_merge_and_update_usage(global_ctx->qctx,
 					      thread_ctx->qctx);
 	if (retval)
 		return retval;
 
-	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
-	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
-	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
-	global_ctx->invalid_bitmaps = invalid_bitmaps;
 	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
@@ -3043,7 +2947,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t retval;
 
-	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
+	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_used_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bad_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_dir_map);
-- 
2.37.3

