Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E861F30F
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiKGM0V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiKGM0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA363CE
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so12433023pjh.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxVl6aa3TBLVMV6wzcR2mNLIXsGqjOYiHHOZUywWNRk=;
        b=jGKXN5JcBnInGg6Z7bNkQ7i1SFQsEHPjzkF40ykWe/sU9Q3dDjk2WOzVIB2aKQrHRL
         XZFKc08QtHyupk1JqKXJp8YeBvNg2zc/YqEwXPFl059HWegv4FhsZ2NeMCyMHsQYym7w
         TEVjbL46r6b+En09kbNIZTfJPUQDP/Gz9a6ZnkMnbIeZrCpuwGe6R9hAg2Ejl3jCxJAg
         e+lYbmhm3P6vEfgJi0PEKPjAwKFRKhmOOEIBIssGd4YaRSHZ/yCDTXgUdpaCbEeCFDyN
         8GxqYoaIFYiVzwasB0fHuWkPd7qiYqN7OsSf45rRTB4MEx3FqDRs48dlNvr3HXCgJou0
         veNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxVl6aa3TBLVMV6wzcR2mNLIXsGqjOYiHHOZUywWNRk=;
        b=kFpkY55JyzMgcEm4o2QOp3CfqGc+q5RvOU3w2kYbJSS74DzkCBRV+Ft5ONfY/Iz4pn
         WZNk1kmAA6McREPiQD/b/7RjRNc3WwQXCOL1hPXozgwcJXI1osJg4j/wlIGi5FQ0ZSE2
         Mb+coNYm5bjV9sW8ZH90OUwCRHQu1n9p2yLAqn/+rS2FWccYzuwbLMYMsMJyG50sojTN
         YaLmKjg/8HnYPx4TlXjgdDru0DU17H2yVU6wE7tFyRD7jS/IahYupgxgSwGYux3tJIyE
         KHuEuBFr/l7aq0K8OryW04omnt35wmGb/55LpnYLsMm4SPh9FUMR/pIESTkSaAX/hvgq
         jVIg==
X-Gm-Message-State: ACrzQf3dFBV/NUj6VgQp3JkmQFt4250Rbr883EPmPfK/VH26N0IUrvtN
        ejfAsZoiabmPcQj6NeNLHTQ=
X-Google-Smtp-Source: AMsMyM7Pw96uTie9GX7uz2tqAQfJRNKauGBrRK/bLBvU7wI0FXWhIbzoejKK36zfVVviVA+7NF14Tw==
X-Received: by 2002:a17:902:b708:b0:184:3921:df30 with SMTP id d8-20020a170902b70800b001843921df30mr51240748pls.43.1667823970427;
        Mon, 07 Nov 2022 04:26:10 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b00186c41bd213sm4870881plg.177.2022.11.07.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:09 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 37/72] e2fsck: add debug codes for multiple threads
Date:   Mon,  7 Nov 2022 17:51:25 +0530
Message-Id: <6034e7dc1304ad2eea9ffabff96cb1604336d3e9.1667822611.git.ritesh.list@gmail.com>
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

These debug codes are added to run the multiple pass1 check
thread one by one in order. If all the codes are correct,
fsck of multiple threads should have exactly the same outcome
with single thread.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h | 16 ++++++++++++++++
 e2fsck/pass1.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2ee37f78..9b0f5067 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -489,6 +489,18 @@ struct e2fsck_struct {
 };
 
 #ifdef HAVE_PTHREAD
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
@@ -498,7 +510,11 @@ struct e2fsck_thread_info {
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
index 18bf7efd..752dca03 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2575,6 +2575,18 @@ static void *e2fsck_pass1_thread(void *arg)
 {
 	struct e2fsck_thread_info *info = arg;
 	e2fsck_t thread_ctx = info->eti_thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug *thread_debug = info->eti_debug;
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
@@ -2599,6 +2611,14 @@ out:
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
 
@@ -2612,6 +2632,12 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	struct e2fsck_thread_info *tmp_pinfo;
 	int i;
 	e2fsck_t thread_ctx;
+#ifdef DEBUG_THREADS
+	struct e2fsck_thread_debug thread_debug =
+		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
+
+	thread_debug.etd_finished_threads = 0;
+#endif
 
 	retval = pthread_attr_init(&attr);
 	if (retval) {
@@ -2632,6 +2658,9 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
2.37.3

