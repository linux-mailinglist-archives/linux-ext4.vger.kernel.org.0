Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037291A1EF9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDHKqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46953 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKqG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id s23so2354575plq.13
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxXssIsjNIiHDGoUNg67XbcvjpGUrFHeXSou9kKoFWE=;
        b=OxoWyfhscUvMCpEbKVwkbBJTCYdu1ZyZc6YXtsd/hOss0HWDh2B1DoVSPR/xzJlQYq
         zc7AsOJCIv0ycUDJMweY7BTO7X5KTSYgz/l7SU8egyZghKoBofiaOhkTEU8sBRNz1gag
         xBYYCu+s/J6kgDB+OHv4Y08CPNmy2TUzjKx1qBlARoskIfE0InJKlGDyIvc+peqZPVLa
         MBzrXFekMHk7BVPHNCsYhk7FRbI9kRomLo0SKYvNk+8N6SUnJSgi9WxeVdtEq8IbqOMS
         H4Gb6hWqKOUG9O6Dww/73xGCtAPS3p5avsBdneehRyFJWGUx+i9/yTsWpH4GkknM58YN
         /2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HxXssIsjNIiHDGoUNg67XbcvjpGUrFHeXSou9kKoFWE=;
        b=b7LKVnQEvdvBWEn1yxQkg3MXsHmshfh9VHR/hKkT5hb97HHyZznEQU7ot9hhPa03rS
         yZdzg9pFgCR9p3j8+t/qdoBtpJrCXdabBfsYH9r/c8c4K4gqs5blG53emB7uqO6+Haz0
         DiacWZT+Ktqtn1i5V6wGQhN8IsJaoi21oQRTJX2JOHseDpyadAHsekCtWt1/qDGFpmQF
         9jo72/Blqctsn78PqawyrSDdWxdhdN+6vf7uoUIM6jXCyXSRq1n5NyNK3nzr2Fqnhl4b
         ZMRKo6Vy+Rto8JyQrckmHUxbM99ooGZUUj0I4kPx8I4ypRu76xMn2NCs585NS3zmjzxz
         gKDQ==
X-Gm-Message-State: AGi0PuYS73y1zmdQ7ZSR/v6WBCsK0ZXGiGawSw1N3nl3msHaWeWbTMkK
        W1WhKw/YA1V6UU076Vwyk+OcsegVplI=
X-Google-Smtp-Source: APiQypIMTU4Y+eSMAKK11TP7kKGiJeioRkMm6XKTj2EMieBP6NO+hspmleeUPmDpxHiQNBvJeiG+Ow==
X-Received: by 2002:a17:90a:8546:: with SMTP id a6mr4732673pjw.8.1586342765146;
        Wed, 08 Apr 2020 03:46:05 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:04 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 15/46] e2fsck: print thread log properly
Date:   Wed,  8 Apr 2020 19:44:43 +0900
Message-Id: <1586342714-12536-16-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index f42da58e..48afc8f3 100644
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
index 8147e944..7a66bdf9 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1453,6 +1453,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		}
 		if (!ino)
 			break;
+		if (ctx->global_ctx)
+		        ctx->thread_info.et_inode_number++;
 		pctx.ino = ino;
 		pctx.inode = inode;
 		ctx->stashed_ino = ino;
@@ -2380,7 +2382,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
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
@@ -2421,6 +2428,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs = global_fs;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+	global_ctx->global_ctx = NULL;
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2507,6 +2515,12 @@ static void *e2fsck_pass1_thread(void *arg)
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
 
@@ -2634,6 +2648,7 @@ static errcode_t scan_callback(ext2_filsys fs,
 
 	if (ctx->global_ctx) {
 		tinfo = &ctx->thread_info;
+		//printf("iii group %d finished\n", tinfo->et_group_next);
 		tinfo->et_group_next++;
 		if (tinfo->et_group_next >= tinfo->et_group_end)
 			return EXT2_ET_SCAN_FINISHED;
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 23183db9..78ea195e 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2476,6 +2476,10 @@ int fix_problem(e2fsck_t ctx, problem_t code, struct problem_context *pctx)
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
index db6a1cc1..3f5abfeb 100644
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
2.25.2

