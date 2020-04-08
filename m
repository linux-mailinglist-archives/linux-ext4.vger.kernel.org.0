Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17B91A1EF5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgDHKp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKp6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so2231853pfo.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=THMxYIUynLkJkJS+9c3F2Unnr62wETxmWRutxcsukhw=;
        b=lQxjVmQH1o+2njwP1WYM/nYUQhUQS46zn4hBvyRFqhf5YBHAYTelOjFHwoCzcYuK2a
         JHZrHP1zeSHJpfzZ8uui+d7wclKkPCSkT7KKhQ5gIR/9txtWRQnCHphTcNY2aQaglXYk
         h+76fhdyuBcJkABteWZaJGSCY5aruWRCAcJ7/gKBjnwfx21lu+4a7O4n2rv10uXd3nbX
         aecTf8LqsmINQPjizf6UnR4lE/B7EDcboe1hgzWOFhPDQ3v2tgwbtKdePGeHjNcm3zvC
         n5xt3xPEEEgkKySX8EerjM9KrPCO+crBKvFQpwbOII0PxG5YfCvLbZpAVRRZfh5Kw30C
         WPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=THMxYIUynLkJkJS+9c3F2Unnr62wETxmWRutxcsukhw=;
        b=eKwl9XPN/rJDcJewIASjmSm1qVpn3Hq2KrgpboC4qoG/fYhbkS2Sz/O/N5+I3X9CaI
         qSyToTyClRUZqI9zoFjuqKG8nwPf/nBa/d4L4Z684MQkZOsLLY7odkQ4h1A5C+Yau9D1
         DRea7kdH7gqrlnbI9W3MOdao+Hl+DDWanWZwcqvA1vaMsOuMA30GW022V1vMVEqRTc2n
         ntBzk/rsqctVP8Ob1HK6wAjC2bbEKHlK3jfZlJiT0ns1ypg4z9nCotpWswDipAzQxUu1
         ygz3m0JKSba9sG+mtmiWCOiPljE4Um6Eak3qJ+bJ8NqEZY4IPWabBgfCUbgyWav7rS9D
         t7kA==
X-Gm-Message-State: AGi0PubHKVF/r8lGRaNXwq5yteHxb7l3KEsNYRrInXGoSi1EKDuYT22w
        BAY2irFxcBq3+x4cfrspZF5tmeu/50M=
X-Google-Smtp-Source: APiQypLHK24TtsseDUpblk//h5QjUZRWriGDU2ZpkKmcXt+ypoxqz1IaOAD0kQ6wcDuitSUAsxEREQ==
X-Received: by 2002:a63:fd11:: with SMTP id d17mr6721147pgh.213.1586342756638;
        Wed, 08 Apr 2020 03:45:56 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:56 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 11/46] e2fsck: create logs for mult-threads
Date:   Wed,  8 Apr 2020 19:44:39 +0900
Message-Id: <1586342714-12536-12-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 58fb49c5..25aaea20 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -380,6 +380,8 @@ struct e2fsck_struct {
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
+	/* Thread index, if global_ctx is null, this field is useless */
+	int			thread_index;
 
 	/*
 	 * Directory information
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 3eeefd19..4e8de342 100644
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
index 900d6cad..ed49b59b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2342,6 +2342,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	}
 	thread_fs->priv_data = thread_context;
 
+	thread_context->thread_index = 0;
+	set_up_logging(thread_context);
+
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
@@ -2354,12 +2357,14 @@ out_context:
 
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
@@ -2378,6 +2383,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
+	global_ctx->logf = global_logf;
+	global_ctx->problem_logf = global_problem_logf;
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2393,6 +2400,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
 	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
+
 	return 0;
 }
 
@@ -2402,6 +2410,12 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 
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
2.25.2

