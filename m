Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08461F30A
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiKGMZx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiKGMZm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3771A816
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p21so10902231plr.7
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prsFAPKtax3VzoeqbbBhMC8ROHOAEyX3jB6qXAVQ/Ww=;
        b=q6KXSlAbnp/SZymZh8CcnO9paKWchqYLFhBRKGvtbQcU+gpZ01h1eAfMzKkMTwYoLK
         SDAYVNKzwe4NFc91bw0Flr8aSW9yg1PJ/jSxC3TvPqgLBHKPfCA8M0NwUSwJCIZtW+py
         X+5hgTugEi2uVkgCDpL+SkPUP37RQ18LlU7hsnB7xWk6b0QvY5umfyFhbhR6vrbkCTCP
         IOyDCRtpvJjjsFEvTXf3UzFB35anf76tju4c/pVIKUn/HbxYjohxrMD+ahMutZ303Kgc
         rQplKoPHnWa1mT0hLt23rEd9DibigGpbXg/m2TR8ApDe6TxUFl+s9HCX1fl+UGTo+xBv
         XfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prsFAPKtax3VzoeqbbBhMC8ROHOAEyX3jB6qXAVQ/Ww=;
        b=uqdnd1L6JsDEvwYJ3WU02fKoLbmExddbkuEoCeaUPIAAHSK3bCmXBHVWxIPdHrRqUH
         8Xz7GjW27EdDi6U7H3otxlTBF3CvaA1WeB75KaioKffE2HNwOeZOS3zooqiMbbB9KtM7
         rDJ1/b3dCvxkai/iHzN+vSUqkSWgP0BCgZGq2LtMU+iztOOAo3JFsoyO7D2HSIsfYTGK
         ZV11/+yKFCoF9DMppq/YOaa5RsbUCIIZp/HU8AcgT2zkQVOQV/oQ0TeLRyqdI401Cng1
         0stgOWkrOIZgXS2gO1byYAtoKOjEWU718wv/OztM0dNFL5RQ8rVM67O0b21/Q91qmRxi
         UupQ==
X-Gm-Message-State: ACrzQf06qTE5fW9A6qx/Np3K8LK7yN6WEUoSfzBxcDTk3mRSgczOtG79
        bhFQWk/oq9N5OqKTj6nJTlc=
X-Google-Smtp-Source: AMsMyM7Dugk9K4i1Uxdwd3xIbXa8aHv3y+bc07hynd8wx/KLrBD14oY7IqkqcsAkW6KTgVsauGVLbg==
X-Received: by 2002:a17:903:124e:b0:179:da2f:244e with SMTP id u14-20020a170903124e00b00179da2f244emr51059882plh.169.1667823940839;
        Mon, 07 Nov 2022 04:25:40 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b0056bcd7e1e04sm4339922pfq.124.2022.11.07.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:40 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 32/72] e2fsck: do not change global variables
Date:   Mon,  7 Nov 2022 17:51:20 +0530
Message-Id: <d21c5f832978c9c6248a5c13c12448b77ebf1cd8.1667822611.git.ritesh.list@gmail.com>
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

From: Li Xi <lixi@ddn.com>

Global variables used in pass1 check are changed to local variables
in this patch. This will avoid conflict between threads.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 75 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a2c13be5..d5c01dc7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -86,7 +86,6 @@ static void alloc_imagic_map(e2fsck_t ctx);
 static void mark_inode_bad(e2fsck_t ctx, ext2_ino_t ino);
 static void add_casefolded_dir(e2fsck_t ctx, ext2_ino_t ino);
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
@@ -1173,7 +1172,6 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 void e2fsck_pass1_run(e2fsck_t ctx)
 {
 	int	i;
-	__u64	max_sizes;
 	ext2_filsys fs = ctx->fs;
 	ext2_ino_t	ino = 0;
 	struct ext2_inode *inode = NULL;
@@ -1196,6 +1194,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	ext2_ino_t	ino_threshold = 0;
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
+	struct process_inode_block *inodes_to_process;
+	int process_inode_count;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1220,17 +1220,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -1368,6 +1357,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	ctx->stashed_inode = inode;
 	scan_struct.ctx = ctx;
 	scan_struct.block_buf = block_buf;
+	scan_struct.inodes_to_process = inodes_to_process;
+	scan_struct.process_inode_count = &process_inode_count;
 	ext2fs_set_inode_callback(scan, scan_callback, &scan_struct);
 	if (ctx->progress && ((ctx->progress)(ctx, 1, 0,
 					      ctx->fs->group_desc_count)))
@@ -2048,13 +2039,15 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
 
@@ -2177,6 +2170,27 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+static void init_ext2_max_sizes()
+{
+	int i;
+	__u64 max_sizes;
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
 #ifdef HAVE_PTHREAD
 static errcode_t e2fsck_pass1_merge_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
 					  ext2fs_generic_bitmap *dest)
@@ -2616,6 +2630,7 @@ out_abort:
 
 void e2fsck_pass1(e2fsck_t ctx)
 {
+	init_ext2_max_sizes();
 #ifdef HAVE_PTHREAD
 	if (ctx->options & E2F_OPT_MULTITHREAD)
 		e2fsck_pass1_multithread(ctx);
@@ -2641,7 +2656,9 @@ static errcode_t scan_callback(ext2_filsys fs,
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
 
-	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf);
+	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf,
+		       scan_struct->inodes_to_process,
+		       scan_struct->process_inode_count);
 
 	if (ctx->progress)
 		if ((ctx->progress)(ctx, 1, group+1,
@@ -2667,7 +2684,9 @@ static errcode_t scan_callback(ext2_filsys fs,
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
@@ -2679,15 +2698,15 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
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
@@ -2705,7 +2724,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 	}
 	ctx->stashed_inode = old_stashed_inode;
 	ctx->stashed_ino = old_stashed_ino;
-	process_inode_count = 0;
+	*process_inode_count = 0;
 #if 0
 	printf("end process inodes\n");
 #endif
-- 
2.37.3

