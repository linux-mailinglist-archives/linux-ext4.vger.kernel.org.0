Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4372B80D7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgKRPlI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKRPlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:07 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB9C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:07 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id 60so1550322qvb.15
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KtL1a+UcdzM6y5a8zXSch74a153jD7I4Dvtdi1s66D0=;
        b=N2p0KN/ke8gX9lVzxAKG3KkNQ2V0Lgm6QktGzolBZl95RLHYNnioRcNKzz9rktqclx
         bUXHRfIxEhcVQBOu8y+dZVAszlTslpVaNAcdxrpgOijYZ+UJP1YZ4AORHGestYTmtBWL
         aPtGUuJdGEX5DPjwc4fcSytF5DT3+537Lm1HsnTr9aWdgZ5rDfbmBOYXvn4YSiRhCOkg
         o/ccCUdSyzfmbAxzPAVy6LDVl2Ew/wZActpj1cTwyku9VjoCU+o+K2SYq8DR93ULqgFM
         OS9F50lIMxQ3xNZFtBeg83u5lZlCxPdW94T5T7Hec4AQL7BaQZnpssXCwO4IIaT7LFwK
         Ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KtL1a+UcdzM6y5a8zXSch74a153jD7I4Dvtdi1s66D0=;
        b=sMTPX5tthNuVv6hL98FNLrN0XJSn4/c7fHF4P+9jsCVvmC9Q5ZBmG+VZnnuUKrRoQt
         Wxgwe5cZLukpjrCFkgDsuig8XW8pL3kUu/hc4SNvA0j6qDfGwjOL9BRbMXXKJKiI17w4
         5k5tPOf+tmSuCkwsNwGaQHArqr2goelGFsNvuZnEgpABcNVBKNNd8+teOLlljK6JXnhe
         c2UUadpLuUAwfRVOil1d2uCKLoF4F6PvbGoJLWsCi1IRDMjw526oGuM8Nnt6csTe93OG
         O8mhHGF8ZnYmOMyAmayDclPEaP+cOBbODSt/ww3lbhSIhTvimeEdn5ALxt7l2MeZUJjH
         RWOw==
X-Gm-Message-State: AOAM530V4fbIgPdlu17OWktF4un8LOHmnGogxfXrUCQX8ckfS/RktSEk
        44+IBkWmA5s72rz5nqkAIYQ4pno/XpyvM0aDI5rGiwD91o5C/RbKizPD58lI2Efqn5O6+DbFYmi
        w6zYK6qpJpwVswLQ8I5XDy/+Mt+G8bOWryaj9jUX/MixSFqZCfIsqQLDV3Fv6eCjrxpaeX24fk0
        TaD6iuwc8=
X-Google-Smtp-Source: ABdhPJzk0Ih+xfqKif+8wEe0x+883imIsfQZ5rtI3hTr3CNnTCy4CrPRbz6VCqT5X/7ZbZBV/y43ZV1ZroI+0OX8juc=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:ad4:4633:: with SMTP id
 x19mr5590005qvv.11.1605714066752; Wed, 18 Nov 2020 07:41:06 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:08 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-23-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 22/61] e2fsck: add debug codes for multiple threads
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

These debug codes are added to run the multiple pass1 check
thread one by one in order. If all the codes are correct,
fsck of multiple threads should have exactly the same outcome
with single thread.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h | 16 ++++++++++++++++
 e2fsck/pass1.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 6783ed05..972c8410 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -450,6 +450,18 @@ struct e2fsck_struct {
 };
 
 #ifdef CONFIG_PFSCK
+#ifdef DEBUG_THREADS
+/*
+ * Enabling DEBUG_THREADS would cause the parallel
+ * fsck threads run sequentially.
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
@@ -459,7 +471,11 @@ struct e2fsck_thread_info {
 	int			 eti_started;
 	/* Context used for this thread */
 	e2fsck_t		 eti_thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug	*eti_debug;
+#endif
 };
+
 #endif
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 75298d9d..f36b3e70 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2641,6 +2641,18 @@ static void *e2fsck_pass1_thread(void *arg)
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
+		pthread_cond_wait(&thread_debug->etd_cond,
+				  &thread_debug->etd_mutex);
+	}
+	pthread_mutex_unlock(&thread_debug->etd_mutex);
+#endif
 
 #ifdef HAVE_SETJMP_H
 	/*
@@ -2665,6 +2677,14 @@ out:
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
 
@@ -2678,6 +2698,12 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
@@ -2698,6 +2724,9 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
2.29.2.299.gdc1121823c-goog

