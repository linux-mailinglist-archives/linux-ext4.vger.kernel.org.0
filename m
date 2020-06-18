Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F71FF6B2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgFRP2z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgFRP2w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB50C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so3037233pge.12
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5EW6epEmdE93CbxHbIVGZAZggoW01UuVRfE0PHtQQI4=;
        b=Mfz8MB0M9X4zG2la3hB080mezZw8We/7Y/UBTzEYvW/O6fhLjJ2NayicvDtfJ1X8dh
         XbjO9Oa8KwZyBEE3jKb/gKZdJQ0ZBKRqQrSijHUMKuE8nr75q/MTg5PrTxcYaGJmAGYd
         4ruSgvXQ9GrVFDybNhlW4TeLF/0yFUT0fbbWQYgbyk/FYaC7YROIDa0TvvWAGvC+tC8Q
         1vVv7GxDe+cRb9Pv9P0B1JFgKfrCjhJlK/ZFAEOOE7Jrml4YqL3pFH5isgFzLZeOCXDx
         vhEMJ77LvXnjfOKkvWJeFrMqqGXT3YMwcC97i0m5bWOLUj7smDM5JULqFRr+B/V4iaJx
         zDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5EW6epEmdE93CbxHbIVGZAZggoW01UuVRfE0PHtQQI4=;
        b=WtYiJLGFQjLFesWiesLnAgJgmTf5NjU7/IM9WoC3p+bq9WNN8v5TdI0LGsdRfibk7P
         xCZGBa4G5050997jzeEttCjLasu3NPWLGpXJ+/OL9RyrVPcCgce9x38dsimF3AxDkovA
         BHLiaBnGD1HU97zu8OZjjjO3IsVsDiaN8eNH24WdCqi/jtdXB60eFqU1kdFw2rkS+5x9
         xNTZT4EZqcUr1/MsGTkl6GT4teq/jWTYAGan9Au5gR0f8C0vqmFdDKupKfWyfTtfcTMb
         +XbsszlrSrCaYaa54SDSkWQEh2WaMmVF8c9Sf+a/gwL1zGtIuPY5KR13nnUplzTOkbL3
         7u9Q==
X-Gm-Message-State: AOAM5320KNmlM1al+lLMhuNX4GhGSYmxucFgUNkhqFry7BGiOZxQz5wo
        m3HAp4Gstes/zMFXdBw8XCXcCOx/wmw=
X-Google-Smtp-Source: ABdhPJxqAwT5pIduY1MjTgPeNp2eMnKCJESQD+DUK3edGkEF+0E8dYCuy54C0Aez884tHbn6Kp5lmw==
X-Received: by 2002:a63:4a0b:: with SMTP id x11mr3744580pga.191.1592494131222;
        Thu, 18 Jun 2020 08:28:51 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:50 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 16/51] e2fsck: print thread log properly
Date:   Fri, 19 Jun 2020 00:27:19 +0900
Message-Id: <1592494074-28991-17-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
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
---
 e2fsck/e2fsck.h                      |  4 ++
 e2fsck/pass1.c                       | 17 ++++++++-
 e2fsck/problem.c                     |  4 ++
 e2fsck/util.c                        | 56 ++++++++++++++++++++++++++--
 tests/f_multithread/expect.1         |  4 +-
 tests/f_multithread_logfile/expect.1 |  4 +-
 tests/f_multithread_no/expect.1      |  4 +-
 7 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 896f5f39..121d1b9b 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -239,6 +239,10 @@ struct e2fsck_thread {
 	dgrp_t		et_group_next;
 	/* Thread index */
 	int		et_thread_index;
+	/* Scanned inode number */
+	ext2_ino_t	et_inode_number;
+	char		et_log_buf[2048];
+	char		et_log_length;
 };
 
 struct e2fsck_struct {
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index c676cbbc..64666663 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1435,6 +1435,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		}
 		if (!ino)
 			break;
+		if (ctx->global_ctx)
+		        ctx->thread_info.et_inode_number++;
 		pctx.ino = ino;
 		pctx.inode = inode;
 		ctx->stashed_ino = ino;
@@ -2362,7 +2364,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
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
@@ -2403,6 +2410,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs = global_fs;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+	global_ctx->global_ctx = NULL;
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2489,6 +2497,12 @@ static void *e2fsck_pass1_thread(void *arg)
 	_e2fsck_pass1(thread_ctx);
 
 out:
+	if (thread_ctx->options & E2F_OPT_MULTITHREAD)
+		log_out(thread_ctx,
+			_("Scanned group range [%lu, %lu), inodes %lu\n"),
+			thread_ctx->thread_info.et_group_start,
+			thread_ctx->thread_info.et_group_end,
+			thread_ctx->thread_info.et_inode_number);
 	return NULL;
 }
 
@@ -2616,6 +2630,7 @@ static errcode_t scan_callback(ext2_filsys fs,
 
 	if (ctx->global_ctx) {
 		tinfo = &ctx->thread_info;
+		//printf("iii group %d finished\n", tinfo->et_group_next);
 		tinfo->et_group_next++;
 		if (tinfo->et_group_next >= tinfo->et_group_end)
 			return EXT2_ET_SCAN_FINISHED;
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 22c2652c..ff52099f 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2481,6 +2481,10 @@ int fix_problem(e2fsck_t ctx, problem_t code, struct problem_context *pctx)
 	if (*message)
 		message = _(message);
 	if (!suppress) {
+		if ((ctx->options & E2F_OPT_MULTITHREAD) && ctx->global_ctx)
+			printf("[Thread %d] ",
+			       ctx->thread_info.et_thread_index);
+
 		if ((ctx->options & E2F_OPT_PREEN) &&
 		    !(ptr->flags & PR_PREEN_NOHDR)) {
 			printf("%s: ", ctx->device_name ?
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 8cebd95a..ffa5c64b 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -11,6 +11,7 @@
 
 #include "config.h"
 #include <stdlib.h>
+#include <assert.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
@@ -88,13 +89,62 @@ out:
 	exit(exit_value);
 }
 
+static void thread_log_out(struct e2fsck_thread *tinfo)
+{
+	printf("[Thread %d] %s", tinfo->et_thread_index,
+	       tinfo->et_log_buf);
+	tinfo->et_log_length = 0;
+	tinfo->et_log_buf[0] = '\0';
+}
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
+	} else {
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
2.25.4

