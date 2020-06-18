Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148371FF6AC
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgFRP2r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgFRP2m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85862C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so2921243pfa.12
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GN80QJGnjitZWS7UPqYxzPZKOi6DC3cDai/llQtaLkw=;
        b=XrlwwGjiQgIoFyIflFqPGEgRLlm0opESvDxH1LD9nhtGf69/jxZhhpfRR9SyTPdLxD
         4R9DnEV+jlgCo4/UrQs5KSodKg/s4yHtYYI7uh2MB4kUWxl2jFifREr7nLYE6xLSm36a
         KleG6xtyMCBXFtdjxZWm/C7y+j17opWG5LlFGYcmV6ZtnRZa8m4+fPdXX3SmjC/NoJWx
         dIuAYKhpYvSaAaST4COLFkSLh6pugtQQE7S5BahQtqNDHchup07BotIOBmsnta/bXu3e
         sRTFkg9vnCNSA/NcXLb1x/HPLLYIDI9DaW8xZRyT8HVOq7vxbHouRuP0hlZcP9wyMh2O
         cnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GN80QJGnjitZWS7UPqYxzPZKOi6DC3cDai/llQtaLkw=;
        b=KnJJclSYfKdeORwJBQcMlfc5m6TkYWxpSaOCQDYkiutiHh/FRs4G5v2we+9OZgBxwH
         CH44kH0DnnCVStsB/3ViZuhgNBFjAWBzPGp4LULB+G8ZxSEhbn8lkIbhUgQQEDAgtj5s
         hum2WbNt57DdJvpKVAmbl9ES1k9GtrLRzLZoXDTdlS4+iWBQVqfvLVIbE/jOj/EETCzb
         fDjPn0mQ2vZ+F20ELlPPK7sWFbC79yh/ZFhQg/juEssYwY23SpCRDWxmsDDEhmbWGQ+6
         5C/+gE8GXCA0FoMfVI1gkG1Yd7joXcpSGCdj6VPXVnFC4+Q31Vef5dFhMnxAOFv6c4+I
         4paA==
X-Gm-Message-State: AOAM530V6JspZCeksCnrIGPNn4kE3e0SklQZxCF2/XRFscZpwTWOsVmJ
        DxP6Nec0ubQX93YxyWSYahMXsBnMKDM=
X-Google-Smtp-Source: ABdhPJw1V5K94rhv/3yuL/pLdeuGRpWfUi/lWGwTrQq8zhKPFEoR45GkbxyQPaFzLlsUbE6/HL5Ypw==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr4117733pfd.248.1592494121569;
        Thu, 18 Jun 2020 08:28:41 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:40 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 12/51] e2fsck: create logs for mult-threads
Date:   Fri, 19 Jun 2020 00:27:15 +0900
Message-Id: <1592494074-28991-13-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

When multi-threads are used, different logs should be created
for different threads. Each thread has log files with subfix
of ".$THREAD_INDEX".

And this patch adds f_multithread_logfile test case.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h                      |  2 ++
 e2fsck/logfile.c                     | 11 +++++++++-
 e2fsck/pass1.c                       | 24 ++++++++++++++++-----
 tests/f_multithread_logfile/expect.1 | 23 ++++++++++++++++++++
 tests/f_multithread_logfile/image.gz |  1 +
 tests/f_multithread_logfile/name     |  1 +
 tests/f_multithread_logfile/script   | 32 ++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 6 deletions(-)
 create mode 100644 tests/f_multithread_logfile/expect.1
 create mode 120000 tests/f_multithread_logfile/image.gz
 create mode 100644 tests/f_multithread_logfile/name
 create mode 100644 tests/f_multithread_logfile/script

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 8925b5d8..b6cfcbb5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -378,6 +378,8 @@ struct e2fsck_struct {
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
+	/* Thread index, if global_ctx is null, this field is useless */
+	int			thread_index;
 
 	/*
 	 * Directory information
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 63e9a12f..17bfc86e 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <pwd.h>
@@ -291,6 +292,8 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 	struct string s, s1, s2;
 	char *s0 = 0, *log_dir = 0, *log_fn = 0;
 	int log_dir_wait = 0;
+	int string_size;
+	char string_index[4];
 
 	s.s = s1.s = s2.s = 0;
 
@@ -307,6 +310,13 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		goto out;
 
 	expand_logfn(ctx, log_fn, &s);
+	if (ctx->global_ctx) {
+		assert(ctx->thread_index < 1000);
+		sprintf(string_index, "%03d", ctx->thread_index);
+		append_string(&s, ".", 1);
+		append_string(&s, string_index, 0);
+	}
+
 	if ((log_fn[0] == '/') || !log_dir || !log_dir[0])
 		s0 = s.s;
 
@@ -325,7 +335,6 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		append_string(&s2, log_dir, 0);
 		append_string(&s2, "/", 1);
 		append_string(&s2, s.s, 0);
-		printf("%s\n", s2.s);
 	}
 
 	if (s0)
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 013c8478..bf843bb9 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2324,6 +2324,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	}
 	thread_fs->priv_data = thread_context;
 
+	thread_context->thread_index = 0;
+	set_up_logging(thread_context);
+
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
@@ -2336,12 +2339,14 @@ out_context:
 
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
-	errcode_t	retval;
-	int		flags = global_ctx->flags;
-	ext2_filsys	thread_fs = thread_ctx->fs;
-	ext2_filsys	global_fs = global_ctx->fs;
+	errcode_t	 retval;
+	int		 flags = global_ctx->flags;
+	ext2_filsys	 thread_fs = thread_ctx->fs;
+	ext2_filsys	 global_fs = global_ctx->fs;
+	FILE		*global_logf = global_ctx->logf;
+	FILE		*global_problem_logf = global_ctx->problem_logf;
 #ifdef HAVE_SETJMP_H
-	jmp_buf		old_jmp;
+	jmp_buf		 old_jmp;
 
 	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
 #endif
@@ -2360,6 +2365,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
+	global_ctx->logf = global_logf;
+	global_ctx->problem_logf = global_problem_logf;
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2375,6 +2382,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
+
 	return 0;
 }
 
@@ -2384,6 +2392,12 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 
 	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
 	ext2fs_free_mem(&thread_ctx->fs);
+	if (thread_ctx->logf)
+		fclose(thread_ctx->logf);
+	if (thread_ctx->problem_logf) {
+		fputs("</problem_log>\n", thread_ctx->problem_logf);
+		fclose(thread_ctx->problem_logf);
+	}
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
diff --git a/tests/f_multithread_logfile/expect.1 b/tests/f_multithread_logfile/expect.1
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread_logfile/expect.1
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread_logfile/image.gz b/tests/f_multithread_logfile/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread_logfile/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread_logfile/name b/tests/f_multithread_logfile/name
new file mode 100644
index 00000000..b8fcb997
--- /dev/null
+++ b/tests/f_multithread_logfile/name
@@ -0,0 +1 @@
+test "e2fsck -m" option works with "--E log_filename="
diff --git a/tests/f_multithread_logfile/script b/tests/f_multithread_logfile/script
new file mode 100644
index 00000000..d7042a03
--- /dev/null
+++ b/tests/f_multithread_logfile/script
@@ -0,0 +1,32 @@
+LOG_FNAME="f_multithread_logfile_xxx"
+FSCK_OPT="-fy -m -y -E log_filename=$LOG_FNAME"
+SKIP_VERIFY="true"
+ONE_PASS_ONLY="true"
+SKIP_CLEANUP="true"
+
+rm -f $LOG_FNAME.* $LOG_FNAME
+
+. $cmd_dir/run_e2fsck
+
+rm -f $test_name.ok $test_name.failed
+cmp -s $OUT1 $EXP1
+status1=$?
+
+if [ "$status1" -eq 0 ]; then
+	if [ ! -f $LOG_FNAME -o ! -f $LOG_FNAME.000 ]; then
+		echo "$LOG_FNAME or $LOG_FNAME.000 is not created" > $test_name.failed
+		echo "$test_name: $test_description: failed"
+	else
+		echo "$test_name: $test_description: ok"
+		touch $test_name.ok
+	fi
+else
+	diff $DIFF_OPTS $test_dir/expect.1 \
+		$test_name.1.log >> $test_name.failed
+        echo "$test_name: $test_description: failed"
+fi
+
+unset IMAGE FSCK_OPT SECOND_FSCK_OPT OUT1 OUT2 EXP1 EXP2
+unset SKIP_VERIFY SKIP_CLEANUP SKIP_GUNZIP ONE_PASS_ONLY PREP_CMD
+unset DESCRIPTION SKIP_UNLINK AFTER_CMD PASS_ZERO
+unset LOG_FINAME
-- 
2.25.4

