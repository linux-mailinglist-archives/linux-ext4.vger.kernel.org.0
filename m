Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1611A1EFB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDHKqN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKqM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so2232072pfo.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSQFkvZhHJAaBHZvRdjI9Ehr5XIo2pfMcBKvptY0qUc=;
        b=BBI6mKQoLve/9aDHy7IG8sYIzGDehzaa67yB3YCRYcwdWBj9dEDFvE/Nzu8tNNgczj
         5EVEK+Tjtb7rTKd6+sgSyX/ydju2tqCgbXDJCo1iqxZ0F4nVChUyd4ANSAEH4LuI7Czw
         qtvbJ6v7wXqc/H68ttvNwiUh/Mzji5449qWQs48OsHFy8H4CQtZVXpu6RSMI+AI0NT06
         sLsQN1bpPGpjgw6XI7tPQgNlEzruvmLG7BcRWXjCVI00+IRQ5RWohYm17GZQozVTr+Go
         jPwOdsR1ARlDejtV4vRd6dYailm3BKp4Ya7hbfZcGdLmyjAdlWDmsSQFk8qQVDpqbRys
         9Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSQFkvZhHJAaBHZvRdjI9Ehr5XIo2pfMcBKvptY0qUc=;
        b=oEaNv+mIZ7A+Jd2GdC19Q9Gx+br/E87uUEeUrlTk5KjpmsK15Kadxm+2lMeFWmKxlP
         zqkaOMXWkEQALg7GOc1/4mDxEfb10xl4H9Unoul/4N+CbPBjs1CzVHwKAVXQm5lQMipZ
         h5byUge+Hcws7qFmHBBIQhn9gVg2pXFdvNQVsozce5ZvqpdKviQgMPV/ujDVnBJ7gqvl
         alI0H+Om89th49673KJSps6FsSAGvGg+LWAcgBBL6RLM07f0ouukxL+vQEmDS07IHQIv
         m+NiFNh8dRji7zZlzEqLiV+4pbTFPadYixWqeRjDmYvOWjlpGKchUgox0g39zacXs1fX
         8O6A==
X-Gm-Message-State: AGi0Pua6vJ8uIoAXATJhp0Gc+HsPY8W0DK1FZ7v61eKqR3GLCU/tv1jc
        ye6DK6Yr7mO/kBMY/SuANfOGdJcTt4k=
X-Google-Smtp-Source: APiQypJLoaw3aeuxhMflqLI5bkPrIAj1uIIe7YAxLMhaInaufrU+tjGWIkOpnZvLRLTgUhy+lUBaAg==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr7151656pfr.292.1586342769476;
        Wed, 08 Apr 2020 03:46:09 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:08 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 17/46] e2fsck: do not change global variables
Date:   Wed,  8 Apr 2020 19:44:45 +0900
Message-Id: <1586342714-12536-18-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c | 81 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2c2973c7..85d18c55 100644
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
@@ -136,10 +135,10 @@ static __u64 ext2_max_sizes[EXT2_MAX_BLOCK_LOG_SIZE -
  * Free all memory allocated by pass1 in preparation for restarting
  * things.
  */
-static void unwind_pass1(ext2_filsys fs EXT2FS_ATTR((unused)))
+static void unwind_pass1(struct process_inode_block *inodes_to_process)
 {
 	ext2fs_free_mem(&inodes_to_process);
-	inodes_to_process = 0;
+	inodes_to_process = NULL;
 }
 
 /*
@@ -1176,7 +1175,6 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 void _e2fsck_pass1(e2fsck_t ctx)
 {
 	int	i;
-	__u64	max_sizes;
 	ext2_filsys fs = ctx->fs;
 	ext2_ino_t	ino = 0;
 	struct ext2_inode *inode = NULL;
@@ -1199,6 +1197,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ext2_ino_t	ino_threshold = 0;
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
+	struct process_inode_block *inodes_to_process;
+	int		process_inode_count;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1223,17 +1223,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -1357,6 +1346,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ctx->stashed_inode = inode;
 	scan_struct.ctx = ctx;
 	scan_struct.block_buf = block_buf;
+	scan_struct.inodes_to_process = inodes_to_process;
+	scan_struct.process_inode_count = &process_inode_count;
 	ext2fs_set_inode_callback(scan, scan_callback, &scan_struct);
 	if (ctx->progress && ((ctx->progress)(ctx, 1, 0,
 					      ctx->fs->group_desc_count)))
@@ -2007,13 +1998,15 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
 
@@ -2088,7 +2081,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		 * master superblock.
 		 */
 		ctx->use_superblock = 0;
-		unwind_pass1(fs);
+		unwind_pass1(inodes_to_process);
 		goto endit;
 	}
 
@@ -2671,12 +2664,34 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
@@ -2718,7 +2733,9 @@ static errcode_t scan_callback(ext2_filsys fs,
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
 
-	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf);
+	process_inodes((e2fsck_t) fs->priv_data, scan_struct->block_buf,
+		       scan_struct->inodes_to_process,
+		       scan_struct->process_inode_count);
 
 	if (ctx->progress)
 		if ((ctx->progress)(ctx, 1, group+1,
@@ -2739,7 +2756,9 @@ static errcode_t scan_callback(ext2_filsys fs,
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
@@ -2751,15 +2770,15 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
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
@@ -2777,7 +2796,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 	}
 	ctx->stashed_inode = old_stashed_inode;
 	ctx->stashed_ino = old_stashed_ino;
-	process_inode_count = 0;
+	*process_inode_count = 0;
 #if 0
 	printf("end process inodes\n");
 #endif
-- 
2.25.2

