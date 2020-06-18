Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B471FF6C7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgFRP3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgFRP3O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13FC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so3039700pgk.11
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AifQFTxEKrGRbD38Sdmun5yAZCtH/np0pekdqNHLco=;
        b=jtp5ZifPMnlCADF+KR8NskZ0hKyuuA/tF4/2BtIPFRxCZhPmpDfMkS8jpOQxqtrrQY
         b991FUO2LAm+DIdeqJljIqQEcT0+qO0r5v25Mz9mSBrQpnNLvZ0vWsPf6gR3a8pmMGDd
         9uAuGqq1YTyJP/u984uwko/l29M9FZebZOzHAzsq0a7HIF9LXTE8f0JL2XEO4C3ciGIz
         kV7zeqBXwQ8DlBV+A7ZPnIiHAyfZbvkVPfQk8ilaDG3jtM62QyM2I2osSQLettO4XUJY
         xoaPX2lfvQT3SXOOdSMQmDhYg2d5SbAjODC//PkeqqXZgby3yDah05BykC9yA2YHxEdk
         Pk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AifQFTxEKrGRbD38Sdmun5yAZCtH/np0pekdqNHLco=;
        b=N7weTMXFmdQJTn+uebJKXWz1YWA+EtxL3YWesXlzJXbn6sqjLBMIrKUxvp2YRAQj3V
         0PmWQxrGOnSlD3CfyREkFT1re1b6RsNasMN34hSeeVgn6X4mfdTJP9BXzaRQkv/2iS0J
         r5MvK9FBhYs83E5h/dmq91hzmOFkOISdZRdSn8xuB9YypdzvHgCGMtLROT6tmK/yG1kg
         sE7Xd+ZDbLv67WlZKjvr4p3EV5vvec6IFTc0JYJM7xYrsbU57WKc6RqfiFGLDuOmY9OR
         vFV0siV5Snmm8mfiLimr+uMs9uGen3hZ+yyevumj2Zvvl+iKd3VEP9Ya8JNgkqEz5hvk
         ZaDA==
X-Gm-Message-State: AOAM531fMlxmZQJMCUbvoZxPvk4Zr9jZEnyIc3JYjFIwy4sto/9dDY1k
        Z84TcUbTWw1kPb1VpTlVsmk06Be9S1I=
X-Google-Smtp-Source: ABdhPJxxpOeUn8zUdBzuqX4p7caOrJ54pSo/iz6ZJRs08ACabHFTRnBYUk9cls1C3CmbMMCSX8x13g==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr3906505pfi.261.1592494152503;
        Thu, 18 Jun 2020 08:29:12 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:11 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 25/51] e2fsck: add debug codes for multiple threds
Date:   Fri, 19 Jun 2020 00:27:28 +0900
Message-Id: <1592494074-28991-26-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

These debug codes are added to run the multiple pass1 check
thread one by one in order. If all the codes are correct,
fsck of multiple threads should have exactly the same outcome
with single thread.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h | 14 ++++++++++++++
 e2fsck/pass1.c  | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 24f164a7..ec5b0fbc 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -446,6 +446,17 @@ struct e2fsck_struct {
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 };
 
+#ifdef DEBUG_THREADS
+/*
+ * Enabling DEBUG_THREADS would cause the parall fsck threads run sequentially
+ */
+struct e2fsck_thread_debug {
+	pthread_mutex_t	etd_mutex;
+	pthread_cond_t	etd_cond;
+	int		etd_finished_threads;
+};
+#endif
+
 struct e2fsck_thread_info {
 	/* ID returned by pthread_create() */
 	pthread_t		 eti_thread_id;
@@ -455,6 +466,9 @@ struct e2fsck_thread_info {
 	int			 eti_started;
 	/* Context used for this thread */
 	e2fsck_t		 eti_thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug	*eti_debug;
+#endif
 };
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7accc76c..d2f4ba79 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1200,7 +1200,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 	pass1_readahead(ctx, &ra_group, &ino_threshold);
 
-	if (!(ctx->options & E2F_OPT_PREEN))
+	if (!(ctx->options & E2F_OPT_PREEN) &&
+	    ((!ctx->global_ctx) || (ctx->thread_info.et_thread_index == 0)))
 		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
 
 	if (ext2fs_has_feature_dir_index(fs->super) &&
@@ -2619,6 +2620,17 @@ static void *e2fsck_pass1_thread(void *arg)
 {
 	struct e2fsck_thread_info	*info = arg;
 	e2fsck_t			 thread_ctx = info->eti_thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug	*thread_debug = info->eti_debug;
+#endif
+
+#ifdef DEBUG_THREADS
+	pthread_mutex_lock(&thread_debug->etd_mutex);
+	while (info->eti_thread_index > thread_debug->etd_finished_threads) {
+		pthread_cond_wait(&thread_debug->etd_cond, &thread_debug->etd_mutex);
+	}
+	pthread_mutex_unlock(&thread_debug->etd_mutex);
+#endif
 
 #ifdef HAVE_SETJMP_H
 	/*
@@ -2643,6 +2655,14 @@ out:
 			thread_ctx->thread_info.et_group_start,
 			thread_ctx->thread_info.et_group_end,
 			thread_ctx->thread_info.et_inode_number);
+
+#ifdef DEBUG_THREADS
+	pthread_mutex_lock(&thread_debug->etd_mutex);
+	thread_debug->etd_finished_threads++;
+	pthread_cond_broadcast(&thread_debug->etd_cond);
+	pthread_mutex_unlock(&thread_debug->etd_mutex);
+#endif
+
 	return NULL;
 }
 
@@ -2656,6 +2676,12 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	struct e2fsck_thread_info	*tmp_pinfo;
 	int				 i;
 	e2fsck_t			 thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug	 thread_debug =
+		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
+
+	thread_debug.etd_finished_threads = 0;
+#endif
 
 	retval = pthread_attr_init(&attr);
 	if (retval) {
@@ -2676,6 +2702,9 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
+#ifdef DEBUG_THREADS
+		tmp_pinfo->eti_debug = &thread_debug;
+#endif
 		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx,
 						     i, num_threads);
 		if (retval) {
-- 
2.25.4

