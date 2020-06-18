Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967F81FF6DE
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgFRPaB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgFRP3u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55FC0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so2828362pjs.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q8oLpAav82yILYMsj/pigwiul7ITwgG8XYzfBCRL+z0=;
        b=UKiOsD9uX/dZ1t0QzxoURmy8adiH6VpefJCGyh7wdlhDZfmsj5LAlN0JrxpLvowuy3
         rUJEkx2xJg/Otm1HtAUloFkjjcpv13cbp2DiDE2P+MrCKTeku8tIetFH86s8TarnCGh7
         TBNXhu5CQvp7/cTeU0132wbwhTpONFlualShOQACcSuvBdRycDRabA7DD0KnUhmZ2NeQ
         9aU+A7Ho4LgdyNqBqo5LG/NLzhiET4FLaOh03Qz6tEHExK0hYP9htRXoBErfvPeMHvFz
         uDe0917bkkbUT9Y5J92pVB+yjYi9jtk9T8YrpQJaVp0Ha8pJ7JBh9Ho14GMpRhpoBhAx
         eemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q8oLpAav82yILYMsj/pigwiul7ITwgG8XYzfBCRL+z0=;
        b=bsn1p79/U2+f0runw5Qgo0KnHwnua6V3u6Ma2olkWf3E+wLVE1cSiUWNlJrFzretI0
         KM3dLGzFRS5OUaa3SBLaA1NAh/ySWYAq0DvUe+T9mGuQJNNL4uWjdJsOqaphaWjkMML8
         SjitPqA2eHXZc7hnZ+Gr47tMa3xkqw6/3w58agtvy5FXfPVCG7bsLY1JJCahIytN20Ij
         3Vlxd7OErey4mk2R4AUBM80cllomltAi2YOD5c1eZxAqA81YEzuAANniPbA+WFHuR3/O
         y47qXrLl/St8+Dq/zu09FcuH8HzHOopzWGQ5wTnEYo1VsVYPXQTMR4JKD2yw1iz7KUcN
         aiVw==
X-Gm-Message-State: AOAM531z+0WXw1yUOF5cr+NMpeX+GB/AJqMnq+iZV492MizOfsCm4KUY
        P0qRsSSl/CKsRhidoc0U4djqXDEZxeU=
X-Google-Smtp-Source: ABdhPJwrkL1QB3OfzEGXgTh0rcO+K5Cfs5dzsyNHQKWIxU+8/gsju7JSCuc7MJFasYV/dkGy22oN2Q==
X-Received: by 2002:a17:90a:260e:: with SMTP id l14mr4927721pje.76.1592494186765;
        Thu, 18 Jun 2020 08:29:46 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:46 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 39/51] e2fsck: fix readahead for pfsck of pass1
Date:   Fri, 19 Jun 2020 00:27:42 +0900
Message-Id: <1592494074-28991-40-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c | 90 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 0cc4e60d..457c713f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1177,13 +1177,14 @@ static void pass1_readahead(e2fsck_t ctx, dgrp_t *group, ext2_ino_t *next_ino)
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
@@ -1275,6 +1276,38 @@ static int e2fsck_should_abort(e2fsck_t ctx)
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
@@ -1284,6 +1317,20 @@ static int _e2fsck_pass1_prepare(e2fsck_t ctx)
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
@@ -1467,13 +1514,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -2997,7 +3038,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 }
 
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
-				      int num_threads, e2fsck_t global_ctx)
+				     e2fsck_t global_ctx)
 {
 	errcode_t			 rc;
 	errcode_t			 ret = 0;
@@ -3006,7 +3047,7 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
-	for (i = 0; i < num_threads; i++) {
+	for (i = 0; i < global_ctx->fs_num_threads; i++) {
 		pinfo = &infos[i];
 
 		if (!pinfo->eti_started)
@@ -3083,7 +3124,7 @@ out:
 }
 
 static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
-				      int num_threads, e2fsck_t global_ctx)
+				      e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos;
 	pthread_attr_t			 attr;
@@ -3098,6 +3139,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 
 	thread_debug.etd_finished_threads = 0;
 #endif
+	int num_threads = global_ctx->fs_num_threads;
 
 	retval = pthread_attr_init(&attr);
 	if (retval) {
@@ -3152,7 +3194,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	}
 
 	if (retval) {
-		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		e2fsck_pass1_threads_join(infos, global_ctx);
 		return retval;
 	}
 	*pinfo = infos;
@@ -3183,13 +3225,7 @@ static void init_ext2_max_sizes()
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
@@ -3198,31 +3234,15 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_rwlock_init(&global_ctx->fs_block_map_rwlock, NULL);
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
-
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
2.25.4

