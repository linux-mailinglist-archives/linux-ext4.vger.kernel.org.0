Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E872A61F31E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiKGM1a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGM1Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F11AD9C
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h14so10410304pjv.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GliyG/gfgbrd/RaksM0VE0kE757GWQ+YGnDdx0Zlfkc=;
        b=Iy1pba0/sdFMGQqzSq9ZTNq5snxoqbwSTVIRi4jvw/hPjnXrd1CLdCelQcgycD/Vk2
         /3b1VGkCxOiV5En72P47BOQeJWQxB4Dj0MmnRQoYqPKYJE16AEc1KIbMgaRZ22DxZvJX
         BkrXtHLpdwUVkWUg9zACrk3qEQZWSYhWMpyyuLE3ahSt8TshxvLeACDccHUxY1MXeX7u
         ajSDE+NIK3tYZHuAJcR2kd3d2AIbIgqHzRfynUb2RmCSb5ZRmzQ3fIYqKDAGsGLt57U5
         068G1p3ZrSnCHMYqRrgbbQh9EyV+z7LGfSzwcbzsLzuIYVEo7Sr/AWbgG2iA5wa4RR8x
         6+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GliyG/gfgbrd/RaksM0VE0kE757GWQ+YGnDdx0Zlfkc=;
        b=XhTZgwv83hZrXhUSjwt5BtXfOLXso7q6DS5e9TAfKWU4DEi14pi/xTB2APCZRYk28g
         2xiWRERHEgFYeoYMqpQFeByGqWt4NzM5urhxEoFfZnytSHZeXVnCfH0GU4DNgvmTC6d4
         MgMkO0CVpXxlSaE7nV5fdV3IAP+zKaD8k3GVzUknqlPfnW1REbrwTo0xRmJ4WZiB2Rrh
         91P6+xmFele1q7oMWSqxonDzYnRLM+e2d2og7H8y/UR6fYIwTusApKB9fbTtPrn375Dd
         EahTq03O2KbF7TnFNDPcqTGyV+uP1SEHmU/w8+4o7+uEkjZQH2CMzeq+vex4F4VsfI0e
         y7pg==
X-Gm-Message-State: ACrzQf1jgYEa94I1Ij5CQ6HTvZKxTAxawJFcgcv+TAQbTBZ9/w3dINfm
        /jbxrd4ZIF9NaYNzUSCxGI4=
X-Google-Smtp-Source: AMsMyM5GHwheccaNhiFg4HwuyTs17W3vjuWKGnWEgCjbcG3gjHA6zKqwS7SHvrZyFkNfLgKXpfdPYA==
X-Received: by 2002:a17:90a:578c:b0:213:b509:9474 with SMTP id g12-20020a17090a578c00b00213b5099474mr48745598pji.45.1667824043633;
        Mon, 07 Nov 2022 04:27:23 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001784a45511asm4885435pls.79.2022.11.07.04.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:22 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 49/72] e2fsck: adjust number of threads
Date:   Mon,  7 Nov 2022 17:51:37 +0530
Message-Id: <787fea1b97ccfda61736f7a9e07d9eeed17b1bc8.1667822611.git.ritesh.list@gmail.com>
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

number of threads should not exceed flex bg numbers,
and output messages if we adjust threads number.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5bf6980b..1d4f576c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1287,6 +1287,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 	}
 out:
 	ctx->fs_num_threads = num_threads;
+	ctx->fs->fs_num_threads = num_threads;
 }
 #endif
 
@@ -2481,14 +2482,14 @@ static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
-					     int thread_index, int num_threads)
+					     int thread_index, int num_threads,
+					     dgrp_t average_group)
 {
 	errcode_t retval;
 	e2fsck_t thread_context;
 	ext2_filsys thread_fs;
 	ext2_filsys global_fs = global_ctx->fs;
 	struct e2fsck_thread *tinfo;
-	dgrp_t average_group;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2535,16 +2536,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
 
-	/*
-	 * Distribute work to multiple threads:
-	 * Each thread work on fs->group_desc_count / nthread groups.
-	 */
 	tinfo = &thread_context->thread_info;
-	average_group = thread_fs->group_desc_count / num_threads;
-	if (average_group == 0)
-		average_group = 1;
 	tinfo->et_group_start = average_group * thread_index;
-	if (thread_index == num_threads - 1)
+	if (thread_index == global_fs->fs_num_threads - 1)
 		tinfo->et_group_end = thread_fs->group_desc_count;
 	else
 		tinfo->et_group_end = average_group * (thread_index + 1);
@@ -3060,12 +3054,13 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 }
 
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
-				      int num_threads, e2fsck_t global_ctx)
+				     e2fsck_t global_ctx)
 {
 	errcode_t rc;
 	errcode_t ret = 0;
 	int i;
 	struct e2fsck_thread_info *pinfo;
+	int num_threads = global_ctx->fs_num_threads;
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
@@ -3147,7 +3142,7 @@ out:
 }
 
 static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
-				      int num_threads, e2fsck_t global_ctx)
+				      e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info *infos;
 	pthread_attr_t attr;
@@ -3156,6 +3151,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	struct e2fsck_thread_info *tmp_pinfo;
 	int i;
 	e2fsck_t thread_ctx;
+	dgrp_t average_group;
+	int num_threads = global_ctx->fs_num_threads;
 #ifdef DEBUG_THREADS
 	struct e2fsck_thread_debug thread_debug =
 		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
@@ -3179,6 +3176,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 		return retval;
 	}
 
+	average_group = ext2fs_get_avg_group(global_ctx->fs);
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
@@ -3186,7 +3184,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 		tmp_pinfo->eti_debug = &thread_debug;
 #endif
 		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx,
-						     i, num_threads);
+						     i, num_threads,
+						     average_group);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
@@ -3216,7 +3215,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	}
 
 	if (retval) {
-		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		e2fsck_pass1_threads_join(infos, global_ctx);
 		return retval;
 	}
 	*pinfo = infos;
@@ -3226,17 +3225,16 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info *infos = NULL;
-	int num_threads = global_ctx->fs_num_threads;
 	errcode_t retval;
 
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
2.37.3

