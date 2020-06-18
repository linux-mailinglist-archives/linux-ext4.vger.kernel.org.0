Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3B1FF6B5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgFRP3A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgFRP25 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C6C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so3041930pgq.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKCXuVPO7JJiy5PqVi2U2rlgKIOk9aQLIFtYnGa4TcU=;
        b=NqYJr2e4ZKQcfG80c/m92jyh22NBQeG4Ewuuc2BQ5//356idsSyWnFv7R++0AYavCE
         LxOAgpIV2FnMcPFSWy7WR88FB7YJKIzzJAE9UxeSZcNWIMHcUosehxxjUvbRAVKwBAXE
         xEZa0lHZLjUODUE30mzGgPIfTn0sOFPriePICxcHZV7kOs48EMh3Oh6D5Q5B7/UvsPDF
         O32MCEvvgu5Y4XfXp8tyZsvYanhaiSurfUi73BwyajKrLUxo6+8rCxsJG4+hUFtw1qjL
         6bXrzimhp3q229DJVzOv+FLRobMwY0alpN1Nh0Lez/QrZtAJGsWF3I2i9lKnKTev1tNp
         txcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKCXuVPO7JJiy5PqVi2U2rlgKIOk9aQLIFtYnGa4TcU=;
        b=bh0zBdNxn0I2fYG/fT6gKmz2RJztTyRacm+oURR3Pwlb4ORBdppbW1sTQW9dcyupsI
         iOa3tb8v1YQdgRx86lz484etza5bNuIsvULLfKc+EOl9IadMXeh3by2dbCVXWfADQZq9
         UTS4hqcJYWD5kVnqoExyupmdxbsNm9z4OyPMxAWkSF3KFMqxYtXsDSuYqNjtZ7MHlgZv
         bkKhwj+gakb+jNEbZ2//FjY6rbi7gLXPO/uAfoUeRFtX6xHA9Jh/GmTdPUVqXpgAex/b
         z5rxQmmVL36CXOJ8mj1GeIYgxkDryFR5q/zjBD8sFH8+euiw7KOHWYDx3ewkDY87ax7X
         AfAA==
X-Gm-Message-State: AOAM532KmYCNzXR7f04TERPP1HDh2Xp2VYOgoQozhHfBtrkKuXTMVDqm
        iq3nahC1sBi5MMyxAEVz0cOAUHIm+Mw=
X-Google-Smtp-Source: ABdhPJyfBNvCEdCq8Bvz1Cj6c+66zuzRBIuheT9xu2gOcjxPvABpOlc7ERg3gftiA7vPEwA8AIhGgw==
X-Received: by 2002:a63:d148:: with SMTP id c8mr3701617pgj.51.1592494136064;
        Thu, 18 Jun 2020 08:28:56 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:55 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 18/51] e2fsck: do not change global variables
Date:   Fri, 19 Jun 2020 00:27:21 +0900
Message-Id: <1592494074-28991-19-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Global variables used in pass1 check are changed to local variables
in this patch. This will avoid conflict between threads.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 75 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8f24df0e..85444421 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -84,7 +84,6 @@ static void alloc_bb_map(e2fsck_t ctx);
 static void alloc_imagic_map(e2fsck_t ctx);
 static void mark_inode_bad(e2fsck_t ctx, ino_t ino);
 static void handle_fs_bad_blocks(e2fsck_t ctx);
-static void process_inodes(e2fsck_t ctx, char *block_buf);
 static EXT2_QSORT_TYPE process_inode_cmp(const void *a, const void *b);
 static errcode_t scan_callback(ext2_filsys fs, ext2_inode_scan scan,
 				  dgrp_t group, void * priv_data);
@@ -119,15 +118,15 @@ struct process_inode_block {
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
@@ -1166,7 +1165,6 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 void _e2fsck_pass1(e2fsck_t ctx)
 {
 	int	i;
-	__u64	max_sizes;
 	ext2_filsys fs = ctx->fs;
 	ext2_ino_t	ino = 0;
 	struct ext2_inode *inode = NULL;
@@ -1189,6 +1187,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ext2_ino_t	ino_threshold = 0;
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
+	struct process_inode_block *inodes_to_process;
+	int		process_inode_count;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1213,17 +1213,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -1347,6 +1336,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ctx->stashed_inode = inode;
 	scan_struct.ctx = ctx;
 	scan_struct.block_buf = block_buf;
+	scan_struct.inodes_to_process = inodes_to_process;
+	scan_struct.process_inode_count = &process_inode_count;
 	ext2fs_set_inode_callback(scan, scan_callback, &scan_struct);
 	if (ctx->progress && ((ctx->progress)(ctx, 1, 0,
 					      ctx->fs->group_desc_count)))
@@ -1989,13 +1980,15 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
 
@@ -2653,12 +2646,34 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	return 0;
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
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos = NULL;
 	int				 num_threads = 1;
 	errcode_t			 retval;
 
+	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -2700,7 +2715,9 @@ static errcode_t scan_callback(ext2_filsys fs,
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
 
-	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf);
+	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf,
+		       scan_struct->inodes_to_process,
+		       scan_struct->process_inode_count);
 
 	if (ctx->progress)
 		if ((ctx->progress)(ctx, 1, group+1,
@@ -2721,7 +2738,9 @@ static errcode_t scan_callback(ext2_filsys fs,
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
@@ -2733,15 +2752,15 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
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
@@ -2759,7 +2778,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 	}
 	ctx->stashed_inode = old_stashed_inode;
 	ctx->stashed_ino = old_stashed_ino;
-	process_inode_count = 0;
+	*process_inode_count = 0;
 #if 0
 	printf("end process inodes\n");
 #endif
-- 
2.25.4

