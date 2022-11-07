Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2416561F315
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKGM0t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGM0t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20D6247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso10141430pjc.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGtoRKYzYuzYnA7xUwO89/4tGL6NcueUvPqXpKALfxU=;
        b=T5rSjtWsO/lTSD/gr2eQefYkQtUNMg/m1K4khrTQldP74PgtuvONrM2zxVA2gtSDlN
         r1LnFQ/gUiqVtsw3eefpHI7O336LYqnhOHFwAe7ZYAwu4edtxzQrGHSpaQmSC3WzAMD/
         JDFCcA3KnAocM5C+10tFNCOMUl/NTt8IGP6Q8GKcPTuxdcfudCn7sS7rsSkLR3qi94ty
         dRsvWAK0Cu4CP5rFc6N8SztsOj3inZUyuJKb8TJo4AfSst1N4hiQtU+NrGq89J55HoZk
         gvuZjXklboCLFHMqbml/nAa+figxusoTjTCALQNaLIFIeppxwq9NyXZw9xKMH0YNaHb7
         EO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGtoRKYzYuzYnA7xUwO89/4tGL6NcueUvPqXpKALfxU=;
        b=jg/NpWE0DtrogtoNR7s4D/rqc9dbBKPbtpT7uK2VvS1H8m+gTUmB0g508bd1lcLFcA
         59rRXuxqkqMcR7v3g+r5XUoTIn52V7AVPae2h1+c1bNBJVy68Mcmmp10x6UCHMD8IWip
         Dkfm9n7xfPDeQ1eNvQx35X62/SbDIH8Y8x1eCFNf1Up4+d0dBHhSHUfT/93WlODrl3jc
         ysEU6oTelwmsIo6UL7jjCG66IxV651u4ei41vjcGylOH1dCAj7tmtGtKqasMwGBBqWrH
         K/+qnGNhxixOUREpc/aB4P6Om7ZAc2fp72ddBVLfimyXDt3LnTAVNCj4pmRGRKE2gDOv
         TmoA==
X-Gm-Message-State: ACrzQf36DA+b7Ixe9+P6iPmBR39+Y9HJ6ZPK9mwbRGJCinRLl5jx2kJJ
        Xgji4IDwjNg7dBk99qvfpWY=
X-Google-Smtp-Source: AMsMyM70CV76IQmMHdmyWL2Z+QV86uQ1ggRWmYQmmr2f3RWu/faFLJ96mGGQcgtI/bTqLFSNBFsj8Q==
X-Received: by 2002:a17:90b:4b09:b0:213:655c:158b with SMTP id lx9-20020a17090b4b0900b00213655c158bmr51721479pjb.119.1667824007570;
        Mon, 07 Nov 2022 04:26:47 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id lt20-20020a17090b355400b0020d48bc6661sm6093042pjb.31.2022.11.07.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:47 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 43/72] e2fsck: serialize fix operations
Date:   Mon,  7 Nov 2022 17:51:31 +0530
Message-Id: <2cbf760ca0510593a005f4955abd333ddcbf571f.1667822611.git.ritesh.list@gmail.com>
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
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h |  6 +++++
 e2fsck/pass1.c  | 63 +++++++++++++++++++++++++++++++++++++++++++------
 e2fsck/util.c   | 38 +++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 26c3b8a5..5356e172 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -484,6 +484,10 @@ struct e2fsck_struct {
 	/* Undo file */
 	char *undo_file;
 
+#ifdef HAVE_PTHREAD
+	/* serialize fix operation for multiple threads */
+	pthread_mutex_t		 fs_fix_mutex;
+#endif
 	/* Fast commit replay state */
 	struct e2fsck_fc_replay_state fc_replay_state;
 };
@@ -787,6 +791,8 @@ extern errcode_t e2fsck_allocate_subcluster_bitmap(ext2_filsys fs,
 						   const char *profile_name,
 						   ext2fs_block_bitmap *ret);
 unsigned long long get_memory_size(void);
+extern void e2fsck_pass1_fix_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_fix_unlock(e2fsck_t ctx);
 
 /* unix.c */
 extern void e2fsck_clear_progbar(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 213c1a51..c68e6957 100644
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
@@ -875,8 +877,11 @@ static errcode_t recheck_bad_inode_checksum(ext2_filsys fs, ext2_ino_t ino,
 	if (!fix_problem(ctx, PR_1_INODE_ONLY_CSUM_INVALID, pctx))
 		return 0;
 
+
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
 					 sizeof(inode));
+	e2fsck_pass1_fix_unlock(ctx);
 	return retval;
 }
 
@@ -886,15 +891,19 @@ static void reserve_block_for_root_repair(e2fsck_t ctx)
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
@@ -905,15 +914,19 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
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
@@ -1551,8 +1564,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 							       &size);
 			if (!pctx.errcode &&
 			    fix_problem(ctx, PR_1_INLINE_DATA_FEATURE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				ext2fs_set_feature_inline_data(sb);
 				ext2fs_mark_super_dirty(fs);
+				e2fsck_pass1_fix_unlock(ctx);
 				inlinedata_fs = 1;
 			} else if (fix_problem(ctx, PR_1_INLINE_DATA_SET, &pctx)) {
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
@@ -1640,9 +1655,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2082,8 +2099,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2096,7 +2116,9 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 
 	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
 		clear_problem_context(&pctx);
+		e2fsck_pass1_fix_lock(ctx);
 		pctx.errcode = ext2fs_create_resize_inode(fs);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx.errcode) {
 			if (!fix_problem(ctx, PR_1_RESIZE_INODE_CREATE,
 					 &pctx)) {
@@ -2804,6 +2826,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	int num_threads = 1;
 	errcode_t retval;
 
+	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -3119,6 +3142,18 @@ static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
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
@@ -3155,7 +3190,7 @@ static void adjust_extattr_refcount(e2fsck_t ctx, ext2_refcount_t refcount,
 		pctx.num = should_be;
 		if (fix_problem(ctx, PR_1_EXTATTR_REFCOUNT, &pctx)) {
 			header->h_refcount = should_be;
-			pctx.errcode = ext2fs_write_ext_attr3(fs, blk,
+			pctx.errcode = e2fsck_write_ext_attr3(ctx, blk,
 							     block_buf,
 							     pctx.ino);
 			if (pctx.errcode) {
@@ -3387,7 +3422,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	 */
 	if (failed_csum &&
 	    fix_problem(ctx, PR_1_EA_BLOCK_ONLY_CSUM_INVALID, pctx)) {
-		pctx->errcode = ext2fs_write_ext_attr3(fs, blk, block_buf,
+		pctx->errcode = e2fsck_write_ext_attr3(ctx, blk, block_buf,
 						       pctx->ino);
 		if (pctx->errcode)
 			return 0;
@@ -3699,10 +3734,12 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -3744,15 +3781,19 @@ report_problem:
 					}
 					continue;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_read_bitmaps(ctx);
 				pb->inode_modified = 1;
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
@@ -3821,9 +3862,11 @@ report_problem:
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
@@ -3887,15 +3930,19 @@ report_problem:
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
@@ -3991,8 +4038,10 @@ alloc_later:
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
index 254b4d04..9470068f 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -38,6 +38,10 @@
 #include <errno.h>
 #endif
 
+#ifdef HAVE_PTHREAD
+#include <pthread.h>
+#endif
+
 #include "e2fsck.h"
 
 extern e2fsck_t e2fsck_global_ctx;   /* Try your very best not to use this! */
@@ -570,13 +574,45 @@ void e2fsck_read_inode_full(e2fsck_t ctx, unsigned long ino,
 	}
 }
 
+#ifdef HAVE_PTHREAD
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
@@ -589,7 +625,9 @@ void e2fsck_write_inode(e2fsck_t ctx, unsigned long ino,
 {
 	errcode_t retval;
 
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode(ctx->fs, ino, inode);
+	e2fsck_pass1_fix_unlock(ctx);
 	if (retval) {
 		com_err("ext2fs_write_inode", retval,
 			_("while writing inode %lu in %s"), ino, proc);
-- 
2.37.3

