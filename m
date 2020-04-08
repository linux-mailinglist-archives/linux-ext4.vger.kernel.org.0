Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427E11A1F10
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDHKq4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37017 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgDHKqz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id r4so3151770pgg.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Lf08hFBZYUmWyGRfX/iPNL+UZiEF3Xj6CbBsYbLc84=;
        b=U4r769r6faQNIc6jBZx3L+mMTQlQlXv+0JQeyZVTk9xSTfadtJU/ABmOfcaKZMkEbl
         unbCjiObTPTS06F/oZG+8huUk+eGM/KFcJiOlQzDuJrjQLg8DKOsPktyJJDnmff2nWHJ
         eyK2vttFiljo6yoO9IWktm0khu97O3fj2OyOQj8xI0WYHvxj/k4mfYZhaWpSe3esioaR
         OfBY3NpNA87iN7UQzIdeMLpIpmUk81MpX9EGV+qTpAII+RzUvnH4DAjhPQqa5fBibGqH
         SuCD95z8PQbLl/fMy7peDNbF6lMvymhnAPUMv62EH4fSI/g92ZxE9YhtNNI7Q/kw2bxb
         nzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Lf08hFBZYUmWyGRfX/iPNL+UZiEF3Xj6CbBsYbLc84=;
        b=evvPw8TT6/UGC67lBNQ/jrvLhZfAXNQZxsPIqXoD1n/3bO2sA8CziJmxM8acwMC/1Q
         DHWJc4w85DhfJwaTm7/APDVyMz0iw5FugKL3bBTW9p5IIPA1AOXQu5rL/RwTSgV03cg7
         wcf7Qx47n0/0Iiq6FXVwGMO64z2hF8jvD8JjdIHye/vTSki3S8JVk7RM+jOocF8hkqql
         3mGzgqwxCgQIgGZ7VbZLbqIz3u3V9xSdsKbQAPDJuSFdXdkbaw6hfuOCqlQQ/82nC0ZP
         yJjE5/hTRf+7wA/OPLRf++RBGJ75+seChE6RRaQ7ATT3uo/GoqLbCiOp+Apn61wDXcnb
         rXIw==
X-Gm-Message-State: AGi0PuaCWMEiXa4Jjx0N1BuAQdgyx0A8OlU27k6ZQnyKyqvdNLiPlhJf
        x79VwRcrNGwEcS52DWJeX06VZrtSWg4=
X-Google-Smtp-Source: APiQypJqJlGah0ULaGb9t+g84RGc12O0Xz7Z+FimSv/RhbsbgjmXroLCJHWJ1mec2Qx30NdgPRGuGw==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr7154118pfr.292.1586342814287;
        Wed, 08 Apr 2020 03:46:54 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:53 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 38/46] e2fsck: fix readahead for pfsck of pass1
Date:   Wed,  8 Apr 2020 19:45:06 +0900
Message-Id: <1586342714-12536-39-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Several improvments for this patch:

1) move readahead_kb detection to preparing phase.
2) inode readahead should be aware of thread block group
boundary.
3) make readahead_kb aware of multiple threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 89 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4654e673..efd2e72d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1173,13 +1173,14 @@ static void pass1_readahead(e2fsck_t ctx, dgrp_t *group, ext2_ino_t *next_ino)
 	dgrp_t start = *group, grp;
 	blk64_t blocks_to_read = 0;
 	errcode_t err = EXT2_ET_INVALID_ARGUMENT;
+	dgrp_t grp_end = ctx->thread_info.et_group_end;
 
 	if (ctx->readahead_kb == 0)
 		goto out;
 
 	/* Keep iterating groups until we have enough to readahead */
 	inodes_per_block = EXT2_INODES_PER_BLOCK(ctx->fs->super);
-	for (grp = start; grp < ctx->fs->group_desc_count; grp++) {
+	for (grp = start; grp < grp_end; grp++) {
 		if (ext2fs_bg_flags_test(ctx->fs, grp, EXT2_BG_INODE_UNINIT))
 			continue;
 		inodes_in_group = ctx->fs->super->s_inodes_per_group -
@@ -1271,6 +1272,38 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
+/**
+ * Even though we could specify number of threads,
+ * but it might be more than the whole filesystem
+ * block groups, correct it here.
+ */
+static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
+{
+	unsigned flexbg_size = 1;
+	ext2_filsys fs = ctx->fs;
+	int num_threads = ctx->fs_num_threads;
+	int max_threads;
+
+	if (num_threads < 1)
+		num_threads = 1;
+
+	if (ext2fs_has_feature_flex_bg(fs->super))
+		flexbg_size = 1 << fs->super->s_log_groups_per_flex;
+
+	max_threads = fs->group_desc_count / flexbg_size;
+	if (max_threads == 0)
+		num_threads = 1;
+	else if (max_threads % num_threads) {
+		int times = max_threads / num_threads;
+
+		if (times == 0)
+			num_threads = max_threads;
+		else
+			num_threads = max_threads / times;
+	}
+	ctx->fs_num_threads = num_threads;
+}
+
 /*
  * We need call mark_table_blocks() before multiple
  * thread start, since all known system blocks should be
@@ -1280,6 +1313,20 @@ static int _e2fsck_pass1_prepare(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	unsigned long long readahead_kb;
+
+	e2fsck_pass1_set_thread_num(ctx);
+	/* If we can do readahead, figure out how many groups to pull in. */
+	if (!e2fsck_can_readahead(ctx->fs))
+		ctx->readahead_kb = 0;
+	else if (ctx->readahead_kb == ~0ULL)
+		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
+
+	/* don't use more than 1/10 of memory for threads checking */
+	readahead_kb = get_memory_size() / (10 * ctx->fs_num_threads);
+	/* maybe better disable RA if this is too small? */
+	if (ctx->readahead_kb > readahead_kb)
+		ctx->readahead_kb = readahead_kb;
 
 	clear_problem_context(&pctx);
 	if (!(ctx->options & E2F_OPT_PREEN))
@@ -1460,13 +1507,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
 
-	/* If we can do readahead, figure out how many groups to pull in. */
-	if (!e2fsck_can_readahead(ctx->fs))
-		ctx->readahead_kb = 0;
-	else if (ctx->readahead_kb == ~0ULL)
-		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 	pass1_readahead(ctx, &ra_group, &ino_threshold);
-
 	if (ext2fs_has_feature_dir_index(fs->super) &&
 	    !(ctx->options & E2F_OPT_NO)) {
 		if (ext2fs_u32_list_create(&ctx->dirs_to_hash, 50))
@@ -2993,7 +3034,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 }
 
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
-				      int num_threads, e2fsck_t global_ctx)
+				     e2fsck_t global_ctx)
 {
 	errcode_t			 rc;
 	errcode_t			 ret = 0;
@@ -3002,7 +3043,7 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
-	for (i = 0; i < num_threads; i++) {
+	for (i = 0; i < global_ctx->fs_num_threads; i++) {
 		pinfo = &infos[i];
 
 		if (!pinfo->eti_started)
@@ -3079,7 +3120,7 @@ out:
 }
 
 static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
-				      int num_threads, e2fsck_t global_ctx)
+				      e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos;
 	pthread_attr_t			 attr;
@@ -3094,6 +3135,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 
 	thread_debug.etd_finished_threads = 0;
 #endif
+	int num_threads = global_ctx->fs_num_threads;
 
 	retval = pthread_attr_init(&attr);
 	if (retval) {
@@ -3148,7 +3190,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	}
 
 	if (retval) {
-		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		e2fsck_pass1_threads_join(infos, global_ctx);
 		return retval;
 	}
 	*pinfo = infos;
@@ -3179,13 +3221,7 @@ static void init_ext2_max_sizes()
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos = NULL;
-	int num_threads = global_ctx->fs_num_threads;
 	errcode_t			 retval;
-	unsigned flexbg_size = 1;
-	int max_threads;
-
-	if (num_threads < 1)
-		num_threads = 1;
 
 	retval = _e2fsck_pass1_prepare(global_ctx);
 	if (retval)
@@ -3194,31 +3230,16 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
 	pthread_mutex_init(&global_ctx->fs_ea_mutex, NULL);
-	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
-		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
-
-	max_threads = global_ctx->fs->group_desc_count / flexbg_size;
-	if (max_threads == 0)
-		num_threads = 1;
-	else if (max_threads % num_threads) {
-		int times = max_threads / num_threads;
-
-		if (times == 0)
-			num_threads = max_threads;
-		else
-			num_threads = max_threads / times;
-	}
 
-	global_ctx->fs_num_threads = num_threads;
 	init_ext2_max_sizes();
-	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
+	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
 			_("while starting pass1 threads\n"));
 		goto out_abort;
 	}
 
-	retval = e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+	retval = e2fsck_pass1_threads_join(infos, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
 			_("while joining pass1 threads\n"));
-- 
2.25.2

