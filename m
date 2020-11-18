Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E202B80DE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKRPlW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKRPlW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8EC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id fy23so1312017pjb.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TVe1odX/JVSYE4SRhbM5hD7LUAtvYJZZ2Y4+3CnwaDs=;
        b=ieCSvWxwDPesusq+/yuP0Et8s7LyCjd4diPJxNlpfGJF9F6VjaCW0upDgAbKVEs1gI
         pU9t3I1VCL9PyGwh6NtGAmEt6OtgAqrR68BeuJi5cI42nl+RJ6i3YbPw7teLwO6Ah5wG
         6FA/oK5x2AdefRp6Ph1O4BGaERZdAhxEFAe3KLbXyG/rzsrGgVY7ODOX5g7A9u4l1Fkx
         60dogVKARJtpg40UpOMEsgwvslG31o8Pg/W7RJ9NcX4o5lyLPlwAE7rmgaATMUHTw51a
         Tq6k7RfSbKkTjVGSHesd2lrUHaRtYIYVn2LGGbsnn6Yr7ODLssDqceemNk2W7XUgjXJ4
         8Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TVe1odX/JVSYE4SRhbM5hD7LUAtvYJZZ2Y4+3CnwaDs=;
        b=D416cLQcdum6QvFooUeaTUW8Cvg10J0NcUYhbVxwY0f4ECrVAYoPXN6Y5VCPx20P4T
         gaiBEMrwnbo870yNBCBOdEe3S/JdcBLk0uXH4N8r7cmbJxkjtW/BJAaUtb+JlmMOAnEO
         ywkkhf6TrfuuS5mtI9sw73XlFBOMHCaqBV9dfn0g75s4jxds9a6+diPfDWeMYLlri4Gh
         C8VoLp2vtSJyPQqN1Vg6R16lW6q7XdgkvkPzSyruBHhZ+Ckb2V8fRM3HCDnxvGfanvEo
         bQjK07KtRLrYMxbPfP0l17XNF3SQOtNsbhYEgQ6rWmO11Q223y/M/zVYv8OlnZHAiXj6
         unPg==
X-Gm-Message-State: AOAM533TBS/Ebuuo7cidf4BPoq3HkDoBvYT8l2OTEMGrYKkOqPqLsFjo
        jcb3k0hUsvKLl2masF05GLIkhBtKlHOXmKhXsl0LKugz1zBw7Ob/FQMkC2aaGUewBtbh7svJXNJ
        d4j11EZWXqSpE/zA6rqUy+EBl5bZL4rF1jQgfsCAK+yTWt91jaqRPw5H9s7mPLrXV1SHTxeCVu1
        pvY6CABlY=
X-Google-Smtp-Source: ABdhPJyOPRMxcPubQGdiMeVPnIW7PaSf5KHBFZi9KPsKEL3S8efRzWHeUc5pDRGW0+mfw9LbZ7ou49Hoc7WKQJn/hT4=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:90b:e04:: with SMTP id
 ge4mr46315pjb.0.1605714079596; Wed, 18 Nov 2020 07:41:19 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:15 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-30-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 29/61] e2fsck: serialize fix operations
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Allow different threads to fix at the same time could
be dangerous and error-prone now, and most of time
parallel scanning and checking is important.

So this patch adds a mutex to serialize
fix operations during pass1.

And the good benefit of this, we don't need block
allocations and free, superblock updates protection
any more, since only fix operations during pass1
could touch them.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h |  6 +++++
 e2fsck/pass1.c  | 63 +++++++++++++++++++++++++++++++++++++++++++------
 e2fsck/util.c   | 38 +++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index c3b0af34..777d8b96 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -447,6 +447,10 @@ struct e2fsck_struct {
 
 	/* Undo file */
 	char *undo_file;
+#ifdef CONFIG_PFSCK
+	/* serialize fix operation for multiple threads */
+	pthread_mutex_t		 fs_fix_mutex;
+#endif
 };
 
 #ifdef CONFIG_PFSCK
@@ -744,6 +748,8 @@ extern errcode_t e2fsck_allocate_subcluster_bitmap(ext2_filsys fs,
 						   const char *profile_name,
 						   ext2fs_block_bitmap *ret);
 unsigned long long get_memory_size(void);
+extern void e2fsck_pass1_fix_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_fix_unlock(e2fsck_t ctx);
 
 /* unix.c */
 extern void e2fsck_clear_progbar(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f2476261..594571a7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -380,8 +380,10 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
 		pctx->num = entry->e_value_inum;
 		if (fix_problem(ctx, PR_1_ATTR_SET_EA_INODE_FL, pctx)) {
 			inode.i_flags |= EXT4_EA_INODE_FL;
+			e2fsck_pass1_fix_lock(ctx);
 			ext2fs_write_inode(ctx->fs, entry->e_value_inum,
 					   &inode);
+			e2fsck_pass1_fix_unlock(ctx);
 		} else {
 			return PR_1_ATTR_NO_EA_INODE_FL;
 		}
@@ -872,8 +874,11 @@ static errcode_t recheck_bad_inode_checksum(ext2_filsys fs, ext2_ino_t ino,
 	if (!fix_problem(ctx, PR_1_INODE_ONLY_CSUM_INVALID, pctx))
 		return 0;
 
+
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
 					 sizeof(inode));
+	e2fsck_pass1_fix_unlock(ctx);
 	return retval;
 }
 
@@ -883,15 +888,19 @@ static void reserve_block_for_root_repair(e2fsck_t ctx)
 	errcode_t	err;
 	ext2_filsys	fs = ctx->fs;
 
+	e2fsck_pass1_fix_lock(ctx);
 	ctx->root_repair_block = 0;
 	if (ext2fs_test_inode_bitmap2(ctx->inode_used_map, EXT2_ROOT_INO))
-		return;
+		goto out;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		return;
+		goto out;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->root_repair_block = blk;
+out:
+	e2fsck_pass1_fix_unlock(ctx);
+	return;
 }
 
 static void reserve_block_for_lnf_repair(e2fsck_t ctx)
@@ -902,15 +911,19 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
 	static const char name[] = "lost+found";
 	ext2_ino_t	ino;
 
+	e2fsck_pass1_fix_lock(ctx);
 	ctx->lnf_repair_block = 0;
 	if (!ext2fs_lookup(fs, EXT2_ROOT_INO, name, sizeof(name)-1, 0, &ino))
-		return;
+		goto out;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		return;
+		goto out;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->lnf_repair_block = blk;
+out:
+	e2fsck_pass1_fix_unlock(ctx);
+	return;
 }
 
 static errcode_t get_inline_data_ea_size(ext2_filsys fs, ext2_ino_t ino,
@@ -1531,8 +1544,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			pctx.errcode = get_inline_data_ea_size(fs, ino, &size);
 			if (!pctx.errcode &&
 			    fix_problem(ctx, PR_1_INLINE_DATA_FEATURE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				ext2fs_set_feature_inline_data(sb);
 				ext2fs_mark_super_dirty(fs);
+				e2fsck_pass1_fix_unlock(ctx);
 				inlinedata_fs = 1;
 			} else if (fix_problem(ctx, PR_1_INLINE_DATA_SET, &pctx)) {
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
@@ -1620,9 +1635,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			if ((ext2fs_extent_header_verify(inode->i_block,
 						 sizeof(inode->i_block)) == 0) &&
 			    fix_problem(ctx, PR_1_EXTENT_FEATURE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				ext2fs_set_feature_extents(sb);
 				ext2fs_mark_super_dirty(fs);
 				extent_fs = 1;
+				e2fsck_pass1_fix_unlock(ctx);
 			} else if (fix_problem(ctx, PR_1_EXTENTS_SET, &pctx)) {
 			clear_inode:
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
@@ -2031,8 +2048,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-	if (ctx->invalid_bitmaps)
+	if (ctx->invalid_bitmaps) {
+		e2fsck_pass1_fix_lock(ctx);
 		handle_fs_bad_blocks(ctx);
+		e2fsck_pass1_fix_unlock(ctx);
+	}
 
 	/* We don't need the block_ea_map any more */
 	if (ctx->block_ea_map) {
@@ -2045,7 +2065,9 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 
 	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
 		clear_problem_context(&pctx);
+		e2fsck_pass1_fix_lock(ctx);
 		pctx.errcode = ext2fs_create_resize_inode(fs);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx.errcode) {
 			if (!fix_problem(ctx, PR_1_RESIZE_INODE_CREATE,
 					 &pctx)) {
@@ -2874,6 +2896,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	int				 num_threads = 1;
 	errcode_t			 retval;
 
+	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -3172,6 +3195,18 @@ static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 	}
 }
 
+static errcode_t _INLINE_ e2fsck_write_ext_attr3(e2fsck_t ctx, blk64_t block,
+						 void *inbuf, ext2_ino_t inum)
+{
+	errcode_t retval;
+	ext2_filsys fs = ctx->fs;
+
+	e2fsck_pass1_fix_lock(ctx);
+	retval = ext2fs_write_ext_attr3(fs, block, inbuf, inum);
+	e2fsck_pass1_fix_unlock(ctx);
+
+	return retval;
+}
 /*
  * Adjust the extended attribute block's reference counts at the end
  * of pass 1, either by subtracting out references for EA blocks that
@@ -3208,7 +3243,7 @@ static void adjust_extattr_refcount(e2fsck_t ctx, ext2_refcount_t refcount,
 		pctx.num = should_be;
 		if (fix_problem(ctx, PR_1_EXTATTR_REFCOUNT, &pctx)) {
 			header->h_refcount = should_be;
-			pctx.errcode = ext2fs_write_ext_attr3(fs, blk,
+			pctx.errcode = e2fsck_write_ext_attr3(ctx, blk,
 							     block_buf,
 							     pctx.ino);
 			if (pctx.errcode) {
@@ -3439,7 +3474,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	 */
 	if (failed_csum &&
 	    fix_problem(ctx, PR_1_EA_BLOCK_ONLY_CSUM_INVALID, pctx)) {
-		pctx->errcode = ext2fs_write_ext_attr3(fs, blk, block_buf,
+		pctx->errcode = e2fsck_write_ext_attr3(ctx, blk, block_buf,
 						       pctx->ino);
 		if (pctx->errcode)
 			return 0;
@@ -3717,10 +3752,12 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
 		if (try_repairs && is_dir && problem == 0 &&
 		    (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT) &&
 		    fix_problem(ctx, PR_1_UNINIT_DBLOCK, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			extent.e_flags &= ~EXT2_EXTENT_FLAGS_UNINIT;
 			pb->inode_modified = 1;
 			pctx->errcode = ext2fs_extent_replace(ehandle, 0,
 							      &extent);
+			e2fsck_pass1_fix_unlock(ctx);
 			if (pctx->errcode)
 				return;
 			failed_csum = 0;
@@ -3764,13 +3801,17 @@ report_problem:
 				}
 				e2fsck_read_bitmaps(ctx);
 				pb->inode_modified = 1;
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode =
 					ext2fs_extent_delete(ehandle, 0);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode) {
 					pctx->str = "ext2fs_extent_delete";
 					return;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode = ext2fs_extent_fix_parents(ehandle);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode &&
 				    pctx->errcode != EXT2_ET_NO_CURRENT_NODE) {
 					pctx->str = "ext2fs_extent_fix_parents";
@@ -3834,9 +3875,11 @@ report_problem:
 				pctx->num = e_info.curr_level - 1;
 				problem = PR_1_EXTENT_INDEX_START_INVALID;
 				if (fix_problem(ctx, problem, pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					pb->inode_modified = 1;
 					pctx->errcode =
 						ext2fs_extent_fix_parents(ehandle);
+					e2fsck_pass1_fix_unlock(ctx);
 					if (pctx->errcode) {
 						pctx->str = "ext2fs_extent_fix_parents";
 						return;
@@ -3900,15 +3943,19 @@ report_problem:
 			pctx->blk = extent.e_lblk;
 			pctx->blk2 = new_lblk;
 			if (fix_problem(ctx, PR_1_COLLAPSE_DBLOCK, pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				extent.e_lblk = new_lblk;
 				pb->inode_modified = 1;
 				pctx->errcode = ext2fs_extent_replace(ehandle,
 								0, &extent);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode) {
 					pctx->errcode = 0;
 					goto alloc_later;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode = ext2fs_extent_fix_parents(ehandle);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode)
 					goto failed_add_dir_block;
 				pctx->errcode = ext2fs_extent_goto(ehandle,
@@ -4004,8 +4051,10 @@ alloc_later:
 	/* Failed csum but passes checks?  Ask to fix checksum. */
 	if (failed_csum &&
 	    fix_problem(ctx, PR_1_EXTENT_ONLY_CSUM_INVALID, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		pb->inode_modified = 1;
 		pctx->errcode = ext2fs_extent_replace(ehandle, 0, &extent);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx->errcode)
 			return;
 	}
diff --git a/e2fsck/util.c b/e2fsck/util.c
index a388bd70..8eec477c 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -42,6 +42,10 @@
 #include <sys/sysctl.h>
 #endif
 
+#ifdef CONFIG_PFSCK
+#include <pthread.h>
+#endif
+
 #include "e2fsck.h"
 
 extern e2fsck_t e2fsck_global_ctx;   /* Try your very best not to use this! */
@@ -565,13 +569,45 @@ void e2fsck_read_inode_full(e2fsck_t ctx, unsigned long ino,
 	}
 }
 
+#ifdef CONFIG_PFSCK
+void e2fsck_pass1_fix_lock(e2fsck_t ctx)
+{
+	e2fsck_t global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
+
+	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
+}
+
+void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
+{
+	e2fsck_t global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
+
+	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
+}
+#else
+void e2fsck_pass1_fix_lock(e2fsck_t ctx)
+{
+
+}
+
+void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
+{
+
+}
+#endif
+
 void e2fsck_write_inode_full(e2fsck_t ctx, unsigned long ino,
 			     struct ext2_inode * inode, int bufsize,
 			     const char *proc)
 {
 	errcode_t retval;
 
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode_full(ctx->fs, ino, inode, bufsize);
+	e2fsck_pass1_fix_unlock(ctx);
 	if (retval) {
 		com_err("ext2fs_write_inode", retval,
 			_("while writing inode %lu in %s"), ino, proc);
@@ -584,7 +620,9 @@ void e2fsck_write_inode(e2fsck_t ctx, unsigned long ino,
 {
 	errcode_t retval;
 
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode(ctx->fs, ino, inode);
+	e2fsck_pass1_fix_unlock(ctx);
 	if (retval) {
 		com_err("ext2fs_write_inode", retval,
 			_("while writing inode %lu in %s"), ino, proc);
-- 
2.29.2.299.gdc1121823c-goog

