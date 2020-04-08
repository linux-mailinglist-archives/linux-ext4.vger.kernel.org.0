Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97581A1F0E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgDHKqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35668 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgDHKqv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so3164154pga.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nj5Zcto19jAG/2+iUH/d35sA52Q6CmVF9ht5DaMNdYM=;
        b=k9WeWuKlNBsXuibwg7Fsvr58pTJgR0WJCnCLLbXowu3kRDblswG4BWDhorljGg1nGy
         awvxw7VKIsBZyZ8kxPEEoP5q3jeg9s6qUWxEzkQiHKFs6BhpMxfaklDx89F8crws9oaE
         5qpmWYkF9mJa0aZ9/gAN9yYs6hkxpK6US8ENUUBb33U3nDj00Jq4fAgRUGhY/qHl26zh
         xjKowqaAv67NoWQRXA0upq6Tf6CvcukqBYUwlo7fLyM3yPrLp20R14aQWQQe9nnqPgRZ
         Q+Uvinwn+DJlgMEjnf7MDusitU8V+pZ/joe2f2ms8JEYXT+wzuNPhj1j9O5lsitF6gjr
         J7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nj5Zcto19jAG/2+iUH/d35sA52Q6CmVF9ht5DaMNdYM=;
        b=aLlKfLSmI4q90/4YMNA4ytARGixQmFA8zqr16aYloCA0FJzZfyslMcI5Pv850EtYni
         Bv5/P/vOLinSXee0F5A87P7RbsEKnu6cy/tdYvQQXvIrWaW6VEcgh2fXZG1U5XwXftM5
         J7aVvKdImNfyKjoSxb0+cfwQ7Cdt4/YobKf2Jpb3lOubrxi4rT/cuNJzEU56xHvV+rzw
         ef4RGRTnOvdu/sBWOxHtWk0bjgW2erIAQi4vuw7cT0zjTr0CQ3A6fRwh5gGyBwt0Tmfj
         ubunyrsHYPoqndT+WwG0D0t58t/O8BT2kIEtKhTMO2Q4bg+svbDIlld5GXn+5KFmz+ZO
         Ticg==
X-Gm-Message-State: AGi0PuaPk3hiPr8TxUudSCwfNfS4bA9KwQ773yHEkKim6lETw48tzvHe
        4MIqPijQkB3czFq8YXv6X0qwK5TAtQk=
X-Google-Smtp-Source: APiQypITE9yabz3G4hFYKTw0prhnaEfulZIpa5BSHe54Tx/M2FBfaiqkCE2K3MOSUx1lJ6lEynO5FA==
X-Received: by 2002:aa7:957d:: with SMTP id x29mr6882762pfq.304.1586342809873;
        Wed, 08 Apr 2020 03:46:49 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:49 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 36/46] e2fsck: allow admin specify number of threads
Date:   Wed,  8 Apr 2020 19:45:04 +0900
Message-Id: <1586342714-12536-37-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 4e156f17..cfe045a1 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -448,6 +448,7 @@ struct e2fsck_struct {
 	__u32			fs_ext_attr_inodes;
 	__u32			fs_ext_attr_blocks;
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
+	__u32			fs_num_threads;
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 1e98f8b6..7320d85f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3127,11 +3127,14 @@ static void init_ext2_max_sizes()
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
@@ -3149,11 +3152,12 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
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
index fff7376c..79800a98 100644
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
2.25.2

