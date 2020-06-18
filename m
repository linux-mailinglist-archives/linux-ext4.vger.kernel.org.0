Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC61FF6D7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgFRP3w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbgFRP3o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A1C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so2933965pfp.9
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HNj4mCbBP5A3Lij1+0uCzfFqVBTzoRtdjFFXmM+1IOo=;
        b=eiUHdWeAGeCdiysMsNG/yo8h6gKL6ReJ8hL0Mi2+nn6yeEfXlrYOvIwW/qNZw6BbIp
         51BI53AHb75JBxOqsPdxoP1aShHwyBwydvmnzaArJjg2y2anhvQ2iGC4LR6jgc3sma+9
         /sp+nqqkIJTRzNIPA3iYOw9JiA5+dU+WdvE+l/Z17c0qVCCtA3X8lq09X7crRrwJhOjR
         ojTu8R1jzLhC7axnijnpM5QZC5aEG7aINNawoZ++uPVJ9mStPpjKuptBHD6TIx+WtYM3
         fFylh4zfoqu8HLh4j1doQXsHgLQDv4FVd50UwgYCP05g2DLXv7MiGKWeckZrT1EqLrf9
         vu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HNj4mCbBP5A3Lij1+0uCzfFqVBTzoRtdjFFXmM+1IOo=;
        b=uPBv8GU2wGKXpNswv0rELMpHyfbkm1HN0JQ+mv1WQK+XHPPJeDgfGFqmxKEHV1ZsoW
         ouDkL4RvBHpfmeXPucmalN1Png8IuniAuBg3gwOlL83k6XU4sZOdgjLJE9EZK26t+5Rc
         Th8IW4pYdxUCsqILkRbk4gVH4/aPdU3eH13W+x1dnBMxSc1D7lG0fP+kpOlu5hRMIZD6
         BjwhBvu/V6eu9WoG7jGCPFbJMjgWGAw6WvFgkFiZL+cM29c58ikKSZh5bIdEtO5Wpk8P
         iL/jH4qQEoD9ayA4lOieJ5SKzl6TedMuh/+Nq0AV0Han8T2plX+6BB35UKwQyIW/n8in
         7WDQ==
X-Gm-Message-State: AOAM530I/Exat7QbnNFpzQMMinGbEUR2UsaUR4+ZjWrfbn1J67Awsj78
        uD3v0EqGCljoirIsI1NL2fB1Q/M/pPY=
X-Google-Smtp-Source: ABdhPJwIcipYOTRS8t0sJKgsjxP0+MV++xtt9qbmQLhIzsKtjnt/AAtjkO+cWVBnLywcJwNOTdHwZw==
X-Received: by 2002:aa7:9782:: with SMTP id o2mr4134696pfp.212.1592494181524;
        Thu, 18 Jun 2020 08:29:41 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:40 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 37/51] e2fsck: allow admin specify number of threads
Date:   Fri, 19 Jun 2020 00:27:40 +0900
Message-Id: <1592494074-28991-38-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h                       | 1 +
 e2fsck/pass1.c                        | 8 ++++++--
 e2fsck/unix.c                         | 3 ++-
 tests/f_multithread/script            | 2 +-
 tests/f_multithread_completion/script | 2 +-
 tests/f_multithread_logfile/script    | 2 +-
 tests/f_multithread_no/script         | 2 +-
 tests/f_multithread_preen/script      | 2 +-
 tests/f_multithread_yes/script        | 2 +-
 9 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index dcc5c2d6..cd1bab07 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -444,6 +444,7 @@ struct e2fsck_struct {
 	__u32			fs_fragmented_dir;
 	__u32			large_files;
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
+	__u32			fs_num_threads;
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a73d35fd..40fe6b36 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3114,11 +3114,14 @@ static void init_ext2_max_sizes()
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos = NULL;
-	int				 num_threads = 1;
+	int num_threads = global_ctx->fs_num_threads;
 	errcode_t			 retval;
 	unsigned flexbg_size = 1;
 	int max_threads;
 
+	if (num_threads < 1)
+		num_threads = 1;
+
 	retval = _e2fsck_pass1_prepare(global_ctx);
 	if (retval)
 		goto out_abort;
@@ -3136,11 +3139,12 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 		int times = max_threads / num_threads;
 
 		if (times == 0)
-			num_threads = 1;
+			num_threads = max_threads;
 		else
 			num_threads = max_threads / times;
 	}
 
+	global_ctx->fs_num_threads = num_threads;
 	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 3124019a..485899b3 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -848,7 +848,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
-	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+	while ((c = getopt(argc, argv, "pam:nyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 		switch (c) {
 		case 'C':
 			ctx->progress = e2fsck_update_progress;
@@ -891,6 +891,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			break;
 		case 'm':
 			ctx->options |= E2F_OPT_MULTITHREAD;
+			ctx->fs_num_threads = atoi(optarg);
 			break;
 		case 'n':
 			if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
diff --git a/tests/f_multithread/script b/tests/f_multithread/script
index 0fe96cd0..83cd0f03 100644
--- a/tests/f_multithread/script
+++ b/tests/f_multithread/script
@@ -1,4 +1,4 @@
-FSCK_OPT="-fy -m"
+FSCK_OPT="-fy -m1"
 SECOND_FSCK_OPT=-yf
 
 . $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_completion/script b/tests/f_multithread_completion/script
index bf23cd61..0ec13816 100644
--- a/tests/f_multithread_completion/script
+++ b/tests/f_multithread_completion/script
@@ -1,4 +1,4 @@
-FSCK_OPT="-fy -m -C 1"
+FSCK_OPT="-fy -m1 -C 1"
 SECOND_FSCK_OPT=-yf
 
 . $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_logfile/script b/tests/f_multithread_logfile/script
index d7042a03..ae497298 100644
--- a/tests/f_multithread_logfile/script
+++ b/tests/f_multithread_logfile/script
@@ -1,5 +1,5 @@
 LOG_FNAME="f_multithread_logfile_xxx"
-FSCK_OPT="-fy -m -y -E log_filename=$LOG_FNAME"
+FSCK_OPT="-fy -m1 -y -E log_filename=$LOG_FNAME"
 SKIP_VERIFY="true"
 ONE_PASS_ONLY="true"
 SKIP_CLEANUP="true"
diff --git a/tests/f_multithread_no/script b/tests/f_multithread_no/script
index b93deb3a..db791e11 100644
--- a/tests/f_multithread_no/script
+++ b/tests/f_multithread_no/script
@@ -1,4 +1,4 @@
-FSCK_OPT="-fn -m"
+FSCK_OPT="-fn -m1"
 SECOND_FSCK_OPT=-yf
 
 . $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_preen/script b/tests/f_multithread_preen/script
index ecb79cd6..8965f4a7 100644
--- a/tests/f_multithread_preen/script
+++ b/tests/f_multithread_preen/script
@@ -1,4 +1,4 @@
-FSCK_OPT="-fp -m"
+FSCK_OPT="-fp -m1"
 SECOND_FSCK_OPT=-yf
 
 . $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_yes/script b/tests/f_multithread_yes/script
index 38891f6a..8b4aa9b8 100644
--- a/tests/f_multithread_yes/script
+++ b/tests/f_multithread_yes/script
@@ -1,4 +1,4 @@
-FSCK_OPT="-f -m"
+FSCK_OPT="-f -m1"
 SECOND_FSCK_OPT=-yf
 
 . $cmd_dir/run_e2fsck
-- 
2.25.4

