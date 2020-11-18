Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB22B80CB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKRPkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRPkv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678DC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:50 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t141so1742650qke.22
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xw8J8ecgXUipk91IsHmPZ3f663HyE/z2PUAfN1Cueww=;
        b=aCmx3gWv/o0CbJK5P7FD0MtH8gJPMXuiu9/RPDVErVgi5ahTMsjc78B2ICwomlCKF0
         p+H/rc+vSkH5iUv5wS9LkaVlhCeINVT6ftmUW6jEmcRJQ8BVwvwKnPXn9qvGa9TRMY4b
         I7mV6vrVrOZJufnpVVdDRNsz5Q+yHeOF85aQJnPbw/sZgS+Uw+Edrc66cQXh5UlNHOEU
         K7WCdBoJFYD1e2i4Nh9kZXAh0nKTZkkT6mkZOfqDKVn8OgHZEAOq+rz08f7pQFZRgnVZ
         pZaCZjT7Yc3hU0veTLOjgvFB/soUAgXNBwVFW/yNX/+EROJ8hpY5wBFemsMKV2bt4mqE
         ykeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xw8J8ecgXUipk91IsHmPZ3f663HyE/z2PUAfN1Cueww=;
        b=HaHilc19omDbjaAO2Y/7ueavHK5m4yb5/JXXnzHCj8g7bGt+qKRhQ4QFi3zjlaVC2m
         Y5xnixLx5jnW/OTtLE925Kwgz6fdGER8oZ3pIE8bKX29lVfdaX6fecdhutEjtIr8DLuB
         2jjk1KM3YPlYGGELpgqUMjaaODeuVXb2rMrNDdgADYuT7XfDwvNJEEgLz0Yq/rpSdJjE
         QjEAm3jR5Tw9/rrZorOCNI6trdJpdWXv/UEH0Pi0+nbI276r/tOHxpS1ifDUc5RF4KXE
         p5DIsuh/25R831HvQ1mPto6Ic61W06thNXz8icKHX2RdzQLKQu8SvD6+N/8O9toMWaO1
         hklQ==
X-Gm-Message-State: AOAM532HBTUnUUdhaSQVpHy6lJlN4bW0tmqHWPh8wrS/2gXbBBmRJ9fn
        IPAAa0Cd5mnIUVQBXCtudg3dJQGpQfSIbcuLv3VxVlwv9l0wy/p8Y+v70jkWnqB2G3rFNWkOwOE
        5tRvl6e7mzWVA4MHKBU5MEaq0/yz8Kl25+GVB9IVn6mTb7O3P6nsRS3SZOz476E4DbXgWetS0Mt
        oalmJQLck=
X-Google-Smtp-Source: ABdhPJy1fbXFka3VzcYkBCeYUgoNPiu7BDEZr4vShgXvzRqBSCfH5iBE/qC/Fv9p8BLdg+oKuRW82D2taWemGSPlM8U=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:ad4:490d:: with SMTP id
 bh13mr5585274qvb.14.1605714049984; Wed, 18 Nov 2020 07:40:49 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:59 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-14-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 13/61] e2fsck: print thread log properly
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

When multi-thread fsck is enabled, logs printed from multiple
threads could overlap with each other. The overlap sometimes
makes the logs unreadable because log_out() is used multiple times
for a single line.

This patch adds leading [Thread XXX] to each logs if multi-thread
is enabed by -m option.

This patch also adds message to show the group ranges and inode
numbers for each thread, which is useful for debuging multi-thread
check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h                      |  4 ++
 e2fsck/pass1.c                       | 22 +++++++++-
 e2fsck/problem.c                     |  6 +++
 e2fsck/util.c                        | 61 ++++++++++++++++++++++++++--
 tests/f_multithread/expect.1         |  4 +-
 tests/f_multithread_logfile/expect.1 |  4 +-
 tests/f_multithread_no/expect.1      |  4 +-
 7 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index ba1af6bf..06893f67 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -240,6 +240,10 @@ struct e2fsck_thread {
 	dgrp_t		et_group_end;
 	/* The next group number to check */
 	dgrp_t		et_group_next;
+	/* Scanned inode number */
+	ext2_ino_t	et_inode_number;
+	char		et_log_buf[2048];
+	char		et_log_length;
 };
 #endif
 
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index fd354529..528f0a6b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1441,6 +1441,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		}
 		if (!ino)
 			break;
+#ifdef CONFIG_PFSCK
+		if (ctx->global_ctx)
+		        ctx->thread_info.et_inode_number++;
+#endif
 		pctx.ino = ino;
 		pctx.inode = inode;
 		ctx->stashed_ino = ino;
@@ -2293,7 +2297,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	else
 		tinfo->et_group_end = average_group * (thread_index + 1);
 	tinfo->et_group_next = tinfo->et_group_start;
-
+	tinfo->et_inode_number = 0;
+	tinfo->et_log_buf[0] = '\0';
+	tinfo->et_log_length = 0;
+	if (thread_context->options & E2F_OPT_MULTITHREAD)
+		log_out(thread_context, _("Scan group range [%d, %d)\n"),
+			tinfo->et_group_start, tinfo->et_group_end);
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
@@ -2334,6 +2343,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs = global_fs;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+	global_ctx->global_ctx = NULL;
 
 	if (thread_ctx->inode_used_map) {
 		retval = e2fsck_pass1_copy_bitmap(global_fs,
@@ -2483,6 +2493,12 @@ static void *e2fsck_pass1_thread(void *arg)
 	e2fsck_pass1_run(thread_ctx);
 
 out:
+	if (thread_ctx->options & E2F_OPT_MULTITHREAD)
+		log_out(thread_ctx,
+			_("Scanned group range [%lu, %lu), inodes %lu\n"),
+			thread_ctx->thread_info.et_group_start,
+			thread_ctx->thread_info.et_group_end,
+			thread_ctx->thread_info.et_inode_number);
 	return NULL;
 }
 
@@ -2618,6 +2634,10 @@ static errcode_t scan_callback(ext2_filsys fs,
 	if (ctx->global_ctx) {
 		tinfo = &ctx->thread_info;
 		tinfo->et_group_next++;
+		if (ctx->options & E2F_OPT_DEBUG &&
+		    ctx->options & E2F_OPT_MULTITHREAD)
+			log_out(ctx, _("group %d finished\n"),
+				tinfo->et_group_next);
 		if (tinfo->et_group_next >= tinfo->et_group_end)
 			return EXT2_ET_SCAN_FINISHED;
 	}
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 22c2652c..1ff6b028 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2481,6 +2481,12 @@ int fix_problem(e2fsck_t ctx, problem_t code, struct problem_context *pctx)
 	if (*message)
 		message = _(message);
 	if (!suppress) {
+#ifdef	CONFIG_PFSCK
+		if ((ctx->options & E2F_OPT_MULTITHREAD) && ctx->global_ctx)
+			printf("[Thread %d] ",
+			       ctx->thread_info.et_thread_index);
+#endif
+
 		if ((ctx->options & E2F_OPT_PREEN) &&
 		    !(ptr->flags & PR_PREEN_NOHDR)) {
 			printf("%s: ", ctx->device_name ?
diff --git a/e2fsck/util.c b/e2fsck/util.c
index e0623e4c..a388bd70 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -11,6 +11,7 @@
 
 #include "config.h"
 #include <stdlib.h>
+#include <assert.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
@@ -88,13 +89,67 @@ out:
 	exit(exit_value);
 }
 
+#ifdef CONFIG_PFSCK
+static void thread_log_out(struct e2fsck_thread *tinfo)
+{
+	printf("[Thread %d] %s", tinfo->et_thread_index,
+	       tinfo->et_log_buf);
+	tinfo->et_log_length = 0;
+	tinfo->et_log_buf[0] = '\0';
+}
+#endif
+
 void log_out(e2fsck_t ctx, const char *fmt, ...)
 {
 	va_list pvar;
+	struct e2fsck_thread *tinfo;
+	int buf_size;
+	int msg_size;
+	int left_size;
+	int fmt_length = strlen(fmt);
+
+#ifdef CONFIG_PFSCK
+	if ((ctx->options & E2F_OPT_MULTITHREAD) && ctx->global_ctx) {
+		tinfo = &ctx->thread_info;
+		buf_size = sizeof(tinfo->et_log_buf);
+		left_size = buf_size - tinfo->et_log_length;
+
+		va_start(pvar, fmt);
+		msg_size = vsnprintf(tinfo->et_log_buf + tinfo->et_log_length,
+				     left_size, fmt, pvar);
+		va_end(pvar);
+
+		if (msg_size >= left_size) {
+			tinfo->et_log_buf[tinfo->et_log_length] = '\0';
+
+			assert(msg_size < buf_size);
+			if (msg_size < buf_size) {
+				thread_log_out(tinfo);
+
+				va_start(pvar, fmt);
+				msg_size = vsnprintf(tinfo->et_log_buf, buf_size,
+						     fmt, pvar);
+				va_end(pvar);
+
+				tinfo->et_log_length += msg_size;
+				tinfo->et_log_buf[tinfo->et_log_length] = '\0';
+			}
+		} else {
+			tinfo->et_log_length += msg_size;
+			tinfo->et_log_buf[tinfo->et_log_length] = '\0';
+		}
+
+		if (tinfo->et_log_length > 0 &&
+		    tinfo->et_log_buf[tinfo->et_log_length - 1] == '\n')
+			thread_log_out(tinfo);
+	} else
+#endif
+	{
+		va_start(pvar, fmt);
+		vprintf(fmt, pvar);
+		va_end(pvar);
+	}
 
-	va_start(pvar, fmt);
-	vprintf(fmt, pvar);
-	va_end(pvar);
 	if (ctx->logf) {
 		va_start(pvar, fmt);
 		vfprintf(ctx->logf, fmt, pvar);
diff --git a/tests/f_multithread/expect.1 b/tests/f_multithread/expect.1
index e2b954d0..8d2acd2b 100644
--- a/tests/f_multithread/expect.1
+++ b/tests/f_multithread/expect.1
@@ -1,6 +1,8 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
-Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scan group range [0, 2)
+[Thread 0] Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
diff --git a/tests/f_multithread_logfile/expect.1 b/tests/f_multithread_logfile/expect.1
index e2b954d0..8d2acd2b 100644
--- a/tests/f_multithread_logfile/expect.1
+++ b/tests/f_multithread_logfile/expect.1
@@ -1,6 +1,8 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
-Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scan group range [0, 2)
+[Thread 0] Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
diff --git a/tests/f_multithread_no/expect.1 b/tests/f_multithread_no/expect.1
index d14c4083..f85a3382 100644
--- a/tests/f_multithread_no/expect.1
+++ b/tests/f_multithread_no/expect.1
@@ -1,6 +1,8 @@
 ext2fs_open2: Bad magic number in super-block
 ../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
-Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scan group range [0, 2)
+[Thread 0] Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scanned group range [0, 2), inodes 3008
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
-- 
2.29.2.299.gdc1121823c-goog

