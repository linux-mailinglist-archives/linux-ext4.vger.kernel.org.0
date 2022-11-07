Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5761F309
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiKGMZv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKGMZg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:36 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94C63D5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 78so10285819pgb.13
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsYo/9S6H3NL4uLoiJkCUuAX1SB13ttlqeqEDieKiRM=;
        b=cUgZQjqNN9O8XYOlAeWMTV1F+j4R1eRgi7XAg1ehNxWbNDMWAMZF2CT22610VByuPR
         DmM+VX3T7EoH9Mx/cQXf+yoaLPgtZ1Q28IvlVH390oSB/hT6yzc1bpc/Ll7uV5dFt65E
         tLeVKAc6XkHjZg7BlN3Jr1sRSkRXInH99qLGtfwMUTBftA1RMfXU8CAGJyNCclP2zoWV
         NUC0bPDLloQOw48IGRhNA+IJ5c5pQq+i92QxNSi5q+aKb0BVOY+VOQrDqGC7/EETK3B/
         LKTYFDuOKNtvNDs0851JxkvE12RuTnahye/IsHv3gF2n5Zrd1d4eLl5Jdn1mhY86lwCt
         E1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsYo/9S6H3NL4uLoiJkCUuAX1SB13ttlqeqEDieKiRM=;
        b=2P1e6X6q29tEydhKr/oktzzxM+LrxVeYf7J9BR1dKOIF837LDsVvjMXj4iXTaMMR+v
         fQbf92bPtzE+Ae1lUyxwZMZxEPKp6a0fb/PDc7VLcX2OrlMdQBYmJq1NECTkVSxbZMMW
         zTXY398yGNKLpwRpktb8LCDsKO4JXrUr2MmMVNsj7d86o9Quggz9ClKclMXAlz8JR0uW
         /u08Mnf698zZ1h2zJKwDSkx+6EvbCWUndqYodfrIw+2KXRCzcVb6BcW4egYofHn1n65H
         5RFGGNondaEQmrbcxDUlZV9jKj7O2XjSdXuymmMRPePgTpRGMwIjgweubwknnXlsTwJr
         Ea8w==
X-Gm-Message-State: ACrzQf112uImYbKYzIyLk2nwT3zmfVFHdsYTHjoKRvAdMrPVUySraPNg
        pwADXBCj4Gm3GHWSZI4j7uUMELidllk=
X-Google-Smtp-Source: AMsMyM40dL1HP3mM3LUVOSBIf+tGrObANtTeqF9qo+SDH8N96ikIQVYIl1qNEajUj0D9OpAiPSA8lA==
X-Received: by 2002:a63:595:0:b0:470:8b7:255a with SMTP id 143-20020a630595000000b0047008b7255amr24127496pgf.329.1667823934904;
        Mon, 07 Nov 2022 04:25:34 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y65-20020a623244000000b0056262811c5fsm4361303pfy.59.2022.11.07.04.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:34 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 31/72] e2fsck: print thread log properly
Date:   Mon,  7 Nov 2022 17:51:19 +0530
Message-Id: <ea553a9a84da47c7f6037f2cdd86ce670bece62e.1667822611.git.ritesh.list@gmail.com>
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
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h                      |  4 ++
 e2fsck/pass1.c                       | 21 ++++++++++
 e2fsck/problem.c                     |  6 +++
 e2fsck/util.c                        | 61 ++++++++++++++++++++++++++--
 tests/f_multithread/expect.1         |  4 +-
 tests/f_multithread_logfile/expect.1 |  4 +-
 tests/f_multithread_no/expect.1      |  4 +-
 7 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 639f4e80..cdd158cc 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -274,6 +274,10 @@ struct e2fsck_thread {
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
index 3b411b70..a2c13be5 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1460,6 +1460,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		}
 		if (!ino)
 			break;
+#ifdef HAVE_PTHREAD
+		if (ctx->global_ctx)
+		        ctx->thread_info.et_inode_number++;
+#endif
 		pctx.ino = ino;
 		pctx.inode = inode;
 		ctx->stashed_ino = ino;
@@ -2292,6 +2296,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		tinfo->et_group_end = average_group * (thread_index + 1);
 	tinfo->et_group_next = tinfo->et_group_start;
 
+	tinfo->et_inode_number = 0;
+	tinfo->et_log_buf[0] = '\0';
+	tinfo->et_log_length = 0;
+	if (thread_context->options & E2F_OPT_MULTITHREAD)
+		log_out(thread_context, _("Scan group range [%d, %d)\n"),
+			tinfo->et_group_start, tinfo->et_group_end);
 	*thread_ctx = thread_context;
 	return 0;
 out_fs:
@@ -2348,6 +2358,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+	global_ctx->global_ctx = NULL;
 
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
@@ -2500,6 +2511,12 @@ static void *e2fsck_pass1_thread(void *arg)
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
 
@@ -2635,6 +2652,10 @@ static errcode_t scan_callback(ext2_filsys fs,
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
index d5452441..9ee3914e 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2594,6 +2594,12 @@ int fix_problem(e2fsck_t ctx, problem_t code, struct problem_context *pctx)
 	if (*message)
 		message = _(message);
 	if (!suppress) {
+#ifdef	HAVE_PTHREAD
+		if ((ctx->options & E2F_OPT_MULTITHREAD) && ctx->global_ctx)
+			printf("[Thread %d] ",
+			       ctx->thread_info.et_thread_index);
+#endif
+
 		if ((ctx->options & E2F_OPT_PREEN) &&
 		    !(ptr->flags & PR_PREEN_NOHDR)) {
 			printf("%s: ", ctx->device_name ?
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 42740d9e..254b4d04 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -11,6 +11,7 @@
 
 #include "config.h"
 #include <stdlib.h>
+#include <assert.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
@@ -84,13 +85,67 @@ out:
 	exit(exit_value);
 }
 
+#ifdef HAVE_PTHREAD
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
+#ifdef HAVE_PTHREAD
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
2.37.3

