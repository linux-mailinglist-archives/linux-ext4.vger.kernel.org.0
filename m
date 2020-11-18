Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EA2B80E8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgKRPll (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgKRPlk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FECC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o10so1409943pjr.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l3Zjzi7p0M6YZou7JBYanihfRqqLv3MLERAvxMffuZI=;
        b=dISW5vyJiz3fP8/TiCalReqv7CX1jgiCZFky5i/CLLlnM45Ze59ZKjC1eGKI2f7rZ/
         kKcXzruG8i94q2HIDe1bZEfnFU4l6dnVry6/T8dIENumScT9wULfKX+7gn919AdJJ9S9
         t9Q2QleaaXRuMHidzJUqoQvyJSI2ZClNOSkSG5tqpY+h25qE/sLRYqh0dWLl4SvRDJzB
         iPBf76lQfv9L8i7kOpoJFzpeCVLsLp5DEFhOZhhr7YC3+YWySqlpwCRDQatCYHdxKbp4
         IM79PlizbgOiaQe3T/69F/VFBz38JFuiR4PbmqxIt9RTNm2XFCMw62oJPHMVal3nsvdX
         f1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l3Zjzi7p0M6YZou7JBYanihfRqqLv3MLERAvxMffuZI=;
        b=L3lU2tZRIEHwacguzfJNwaaKt4WaPMvBR/UwJV/QQv19+1/kWhusF9OUb0YyGiiIoc
         Sd0cGbT/rRnbu0r+jtfx5Uzc2l2qOtLJuGWNYqlMHS1lkBX5qzdTBDm3kq1vTaUvrHL2
         qdD6gj3MyB64nUZK5sMuRGdrKZzuNw7urgwIeq7lsdhX+UBloMrkSdJNZFbpxH7SQUZn
         ndvkBjo61IfEBU+YYxQjqTltlQcaDYr0vJvw8AJ1yMAbYAQzgaTh4CT0fPUB8H1CVpXs
         cLuA911P2DyiCe4glJTDSJWs3ZeeMia0JcWJtuD+c6IHojmtGtiJo1A8oL6+j96k5G8R
         588g==
X-Gm-Message-State: AOAM5333DGOtrIulOUn2peAkVJJjTIWTTuBJXfSlSkPUy4wyVoT9pT3N
        oXjtoJUY6iaxlgOLT42cq5Y2HoP5A8NQkOX65umG83zNbyN/sPqF0NX2KZByOkueREA8skgir2X
        2O+1jSNZruTAecMSNuBLLkQe70JxVYTssqXscdOQO5vMaf4UkW2Dy1RShc+S2+DoqbdglpSioYa
        INYzSF+kA=
X-Google-Smtp-Source: ABdhPJx+MN2ojE/9FynzzhO4iNOU5UpFgbvx0YX3px2vVBfIbLc9N6ywo5SM6sn4ZNnmadNLpJNhC4jzrqlrFhu2D0U=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a62:ee06:0:b029:164:20d:183b with
 SMTP id e6-20020a62ee060000b0290164020d183bmr5170370pfi.4.1605714100119; Wed,
 18 Nov 2020 07:41:40 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:26 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-41-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 40/61] e2fsck: simplify e2fsck context merging codes
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 151 ++++++++++---------------------------------------
 1 file changed, 31 insertions(+), 120 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 0a872028..03d7f455 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2432,6 +2432,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2_badblocks_list badblocks;
 	ext2_dblist dblist;
 	int flags;
+	e2fsck_t dest_ctx = dest->priv_data;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2449,6 +2450,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->block_map = block_map;
 	dest->badblocks = badblocks;
 	dest->dblist = dblist;
+	dest->priv_data = dest_ctx;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 	dest->flags = src->flags | flags;
@@ -2882,140 +2884,51 @@ static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
+					    e2fsck_t thread_ctx)
 {
-	errcode_t	 retval;
-	int		 flags = global_ctx->flags;
-	ext2_filsys	 thread_fs = thread_ctx->fs;
-	ext2_filsys	 global_fs = global_ctx->fs;
-	FILE		*global_logf = global_ctx->logf;
-	FILE		*global_problem_logf = global_ctx->problem_logf;
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
-	jmp_buf		 old_jmp;
-
-	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
-#endif
-	memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
-#ifdef HAVE_SETJMP_H
-	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
-#endif
+	ext2_filsys global_fs = global_ctx->fs;
+	errcode_t retval;
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
 
-	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
+
+	retval = e2fsck_pass1_merge_fs(global_ctx->fs, thread_ctx->fs);
 	if (retval) {
 		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
 		return retval;
 	}
-	global_fs->priv_data = global_ctx;
-	global_ctx->fs = global_fs;
-	global_ctx->logf = global_logf;
-	global_ctx->problem_logf = global_problem_logf;
-	global_ctx->global_ctx = NULL;
 	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, 0,
@@ -3023,7 +2936,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
-	global_ctx->dirs_to_hash = dirs_to_hash;
 	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, 0,
@@ -3033,7 +2945,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 
 	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
-	global_ctx->qctx = qctx;
 	retval = quota_merge_and_update_usage(global_ctx->qctx,
 					      thread_ctx->qctx);
 	if (retval)
@@ -3107,7 +3018,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	retval;
 
-	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
+	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
 	ext2fs_free_mem(&thread_ctx->fs);
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
-- 
2.29.2.299.gdc1121823c-goog

