Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB22B80CF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKRPk5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRPk4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:56 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40DC0613D6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:54 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id q6so1538848qvr.21
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s6vvkqtHHiOY9yhMkp1shpLW5N5pECGkPdJxNegvhgM=;
        b=Z3erXeufjPGDspy5380mXSFMrs7zWT8BofvOdCuuhU0jOObB1S+5XJCPrADth9S5w6
         0I3qFaqpxxMhonEeANh58gi/rdWCUqzBsc4OBqiUySEyIpyU759hklouko7FXb0m3CCL
         rGLM83qxlFXhfOfrHkNAvbYpndyp2CX0MDtTDTSL1I1lKhwUmtdjxHkRpRdLQmpqzoLv
         5nLGuPrrWJQSM4M5sSoKevYjXz/D8zN46yiYAB7hU9EyF4xMmbjmkZf11KwN2biKOfMe
         SyaT3P1AIHs+jl0h9W4QqJlhZwINIpPMn2IJyKmsUmpsLGXaiPcoQZWF0AK+Kljwyl7I
         lI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s6vvkqtHHiOY9yhMkp1shpLW5N5pECGkPdJxNegvhgM=;
        b=Vhfs51HWgCB+G2aWPIdmPjg/rs97qqxv1UC0DzJFk030oML1V+b35qF5b/d1JPMG0F
         nzFu/hkfXtaLUDdpvxpIy+rrx+hQYp1t0ExHborXV40mFPuvohI8WnjclyIR+PyTRikc
         ZV08GaZ70iuwep+TjAKAPUiEqCqEi9nbDZBwcDuKFgO+9q0O7UIQ5TjhqgNMAKEWCc2W
         1P5EP0snyWKh6MaGeu5e2y6nPwv0zrELml2/vyOoTgTCUAN/eH34UGWkI4rsBi+6zGVc
         IHZnTllq557H2YGaHlspws3lGWZD8xQHRFwYHwgYpyL9Od4D5VtYwku8+40tTRmYcaDL
         lvVQ==
X-Gm-Message-State: AOAM533Nu+WzqotF3ytQhNGPQP0gbe7wGTWqYDLVqOrxX3CJXi1g1EnA
        i6eaR2DpGGS3EoiPNZBrfwJ41jCQBgslZMo+poDmHipM3WNilp+RYm1LhPnwRFdZ9NAZg/8cQV1
        T3vSe1QNHtX3009t8zVyC8Mmu95KCbx1sp4HoHIh5I2JtGQJpA4rVCflXNYENkW+YEeLIUxGAig
        8Zd10o1ws=
X-Google-Smtp-Source: ABdhPJyu/Q0SdGo3aK0P/GJK/oFh0dPRGvfyXJX9dlFzrrh1a2iHBPfS3Vo00ml92qzwcnYbVI90mdf9uNWchhJunXs=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:f28d:: with SMTP id
 k13mr5591389qvl.31.1605714053843; Wed, 18 Nov 2020 07:40:53 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:01 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-16-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 15/61] e2fsck: do not change global variables
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Global variables used in pass1 check are changed to local variables
in this patch. This will avoid conflict between threads.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 75 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 9e4abad0..d4a2e707 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -86,7 +86,6 @@ static void alloc_bb_map(e2fsck_t ctx);
 static void alloc_imagic_map(e2fsck_t ctx);
 static void mark_inode_bad(e2fsck_t ctx, ino_t ino);
 static void handle_fs_bad_blocks(e2fsck_t ctx);
-static void process_inodes(e2fsck_t ctx, char *block_buf);
 static EXT2_QSORT_TYPE process_inode_cmp(const void *a, const void *b);
 static errcode_t scan_callback(ext2_filsys fs, ext2_inode_scan scan,
 				  dgrp_t group, void * priv_data);
@@ -121,15 +120,15 @@ struct process_inode_block {
 };
 
 struct scan_callback_struct {
-	e2fsck_t	ctx;
-	char		*block_buf;
+	e2fsck_t			 ctx;
+	char				*block_buf;
+	struct process_inode_block	*inodes_to_process;
+	int				*process_inode_count;
 };
 
-/*
- * For the inodes to process list.
- */
-static struct process_inode_block *inodes_to_process;
-static int process_inode_count;
+static void process_inodes(e2fsck_t ctx, char *block_buf,
+			   struct process_inode_block *inodes_to_process,
+			   int *process_inode_count);
 
 static __u64 ext2_max_sizes[EXT2_MAX_BLOCK_LOG_SIZE -
 			    EXT2_MIN_BLOCK_LOG_SIZE + 1];
@@ -1168,7 +1167,6 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 void e2fsck_pass1_run(e2fsck_t ctx)
 {
 	int	i;
-	__u64	max_sizes;
 	ext2_filsys fs = ctx->fs;
 	ext2_ino_t	ino = 0;
 	struct ext2_inode *inode = NULL;
@@ -1191,6 +1189,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	ext2_ino_t	ino_threshold = 0;
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
+	struct process_inode_block *inodes_to_process;
+	int		process_inode_count;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1215,17 +1215,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	mtrace_print("Pass 1");
 #endif
 
-#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
-
-	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
-		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = (max_sizes * (1UL << i));
-		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
-	}
-#undef EXT2_BPP
-
 	imagic_fs = ext2fs_has_feature_imagic_inodes(sb);
 	extent_fs = ext2fs_has_feature_extents(sb);
 	inlinedata_fs = ext2fs_has_feature_inline_data(sb);
@@ -1349,6 +1338,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	ctx->stashed_inode = inode;
 	scan_struct.ctx = ctx;
 	scan_struct.block_buf = block_buf;
+	scan_struct.inodes_to_process = inodes_to_process;
+	scan_struct.process_inode_count = &process_inode_count;
 	ext2fs_set_inode_callback(scan, scan_callback, &scan_struct);
 	if (ctx->progress && ((ctx->progress)(ctx, 1, 0,
 					      ctx->fs->group_desc_count)))
@@ -1997,13 +1988,15 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			goto endit;
 
 		if (process_inode_count >= ctx->process_inode_size) {
-			process_inodes(ctx, block_buf);
+			process_inodes(ctx, block_buf, inodes_to_process,
+				       &process_inode_count);
 
 			if (e2fsck_should_abort(ctx))
 				goto endit;
 		}
 	}
-	process_inodes(ctx, block_buf);
+	process_inodes(ctx, block_buf, inodes_to_process,
+		       &process_inode_count);
 	ext2fs_close_inode_scan(scan);
 	scan = NULL;
 
@@ -2113,6 +2106,27 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+static void init_ext2_max_sizes()
+{
+	int	i;
+	__u64	max_sizes;
+
+	/*
+	 * Init ext2_max_sizes which will be immutable and shared between
+	 * threads
+	 */
+#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
+
+	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
+		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = (max_sizes * (1UL << i));
+		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
+	}
+#undef EXT2_BPP
+}
+
 #ifdef CONFIG_PFSCK
 static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
 					  ext2fs_generic_bitmap *dest)
@@ -2656,6 +2670,7 @@ out_abort:
 void e2fsck_pass1(e2fsck_t ctx)
 {
 
+	init_ext2_max_sizes();
 #ifdef CONFIG_PFSCK
 	e2fsck_pass1_multithread(ctx);
 #else
@@ -2680,7 +2695,9 @@ static errcode_t scan_callback(ext2_filsys fs,
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
 
-	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf);
+	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf,
+		       scan_struct->inodes_to_process,
+		       scan_struct->process_inode_count);
 
 	if (ctx->progress)
 		if ((ctx->progress)(ctx, 1, group+1,
@@ -2706,7 +2723,9 @@ static errcode_t scan_callback(ext2_filsys fs,
 /*
  * Process the inodes in the "inodes to process" list.
  */
-static void process_inodes(e2fsck_t ctx, char *block_buf)
+static void process_inodes(e2fsck_t ctx, char *block_buf,
+			   struct process_inode_block *inodes_to_process,
+			   int *process_inode_count)
 {
 	int			i;
 	struct ext2_inode	*old_stashed_inode;
@@ -2718,15 +2737,15 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 #if 0
 	printf("begin process_inodes: ");
 #endif
-	if (process_inode_count == 0)
+	if (*process_inode_count == 0)
 		return;
 	old_operation = ehandler_operation(0);
 	old_stashed_inode = ctx->stashed_inode;
 	old_stashed_ino = ctx->stashed_ino;
-	qsort(inodes_to_process, process_inode_count,
+	qsort(inodes_to_process, *process_inode_count,
 		      sizeof(struct process_inode_block), process_inode_cmp);
 	clear_problem_context(&pctx);
-	for (i=0; i < process_inode_count; i++) {
+	for (i=0; i < *process_inode_count; i++) {
 		pctx.inode = ctx->stashed_inode =
 			(struct ext2_inode *) &inodes_to_process[i].inode;
 		pctx.ino = ctx->stashed_ino = inodes_to_process[i].ino;
@@ -2744,7 +2763,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 	}
 	ctx->stashed_inode = old_stashed_inode;
 	ctx->stashed_ino = old_stashed_ino;
-	process_inode_count = 0;
+	*process_inode_count = 0;
 #if 0
 	printf("end process inodes\n");
 #endif
-- 
2.29.2.299.gdc1121823c-goog

