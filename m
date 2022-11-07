Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6860461F2FE
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiKGMY7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiKGMYr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32031B7AE
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u6so10881021plq.12
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NuUxgcrcbyLEt+4D5wU+GVX4W+ksOY5RfbdK0CPaRk=;
        b=Ix8FHeEmnUoyT5Wiff1YiUOBbkH2ITNogZrk4cgWYfoLnR2RPo2nENzFDS71+kFc2y
         Qg86ALET1edqF9ZHIy0SYi8cAyqIpVpBoyrIgI47lxS7SgC0/F5UEPOC7aTqA0IfysMb
         ao1ehlxwodN6taZx0fMxwxb9UXoKKyYGXzevtazfJd1kLVwBkoziV+XQN6JZFJnGVW5c
         BdS7dcGoBNnL+NQoM9idcmHEgEJeVC0eC02RHGAX4hLlks1G2mTJ9lki7FgGyi5rFyU9
         WykcCFX3+1Klwote+MFeQ3zfRK8u7EDemrZkO/Ge0DEO07z05lgeUDc2cAlEBnQ3tNSv
         CVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NuUxgcrcbyLEt+4D5wU+GVX4W+ksOY5RfbdK0CPaRk=;
        b=A/qnvWryOhNsHDyXReNOl9dSTjPnGhhdhuZpvoBqxZKTkbH35GZNFWVH4l21OB9ukR
         Q3tLMquo2snh+tamHC7ey2EjrvXjIB5MuLAze2GONCc1eaB5Zmh35E3s4W9OSexPX6Dq
         HEoLeY4YZoR00NdG+uTZd33v0MDowiRzSIpPQMoPuZGKm1k8SRbkWuZJ6bL+j+M2nvm8
         0ftC9WrJU8KVUYL9nIuTgE3vOTJqPM+OmdQ8nagupa+dO/KeAz7ZOu8dqLOCF8zmFMP4
         hRx7OAz7oJ66CtXSgRfFK/MbCQ8/cDV23XZZtQXpgiwYiNePhZ/40WMmq8ZZLsJxAkOt
         Ce3g==
X-Gm-Message-State: ACrzQf3n5Ww1HFdf9+VrZgchBC66cAp9fNFHuur/1+3F/pziy/kETepR
        5zMVK73l1NcL3jl39NCw068=
X-Google-Smtp-Source: AMsMyM7Xc45YVUVrIbKj33wGGxzZPTVQQLYRkmDpUeF4MD46jIq2xNQeqqQBRg4Rtwr9kvXcQCnoTA==
X-Received: by 2002:a17:90a:d80a:b0:213:1442:24be with SMTP id a10-20020a17090ad80a00b00213144224bemr751410pjv.15.1667823886170;
        Mon, 07 Nov 2022 04:24:46 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id l5-20020a622505000000b0056be1581126sm4525205pfl.143.2022.11.07.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:45 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 23/72] e2fsck: create logs for multi-threads
Date:   Mon,  7 Nov 2022 17:51:11 +0530
Message-Id: <d3c5e6f7a959f865b0bf054778bfb72cccd2476b.1667822611.git.ritesh.list@gmail.com>
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

When multi-threads are used, different logs should be created
for different threads. Each thread has log files with suffix
of ".$THREAD_INDEX".

And this patch adds f_multithread_logfile test case.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h                      |  6 ++++--
 e2fsck/logfile.c                     | 10 ++++++++-
 e2fsck/pass1.c                       | 12 +++++++++++
 tests/f_multithread_logfile/expect.1 | 23 ++++++++++++++++++++
 tests/f_multithread_logfile/image.gz |  1 +
 tests/f_multithread_logfile/name     |  1 +
 tests/f_multithread_logfile/script   | 32 ++++++++++++++++++++++++++++
 7 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 tests/f_multithread_logfile/expect.1
 create mode 120000 tests/f_multithread_logfile/image.gz
 create mode 100644 tests/f_multithread_logfile/name
 create mode 100644 tests/f_multithread_logfile/script

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index f1259728..284bc52e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -342,8 +342,10 @@ struct e2fsck_struct {
 	/*
 	 * For pass1_check_directory and pass1_get_blocks
 	 */
-	ext2_ino_t stashed_ino;
-	struct ext2_inode *stashed_inode;
+	ext2_ino_t		stashed_ino;
+	struct ext2_inode	*stashed_inode;
+	/* Thread index, if global_ctx is null, this field is unused */
+	int			thread_index;
 
 	/*
 	 * Location of the lost and found directory
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 9d79eed2..83dbceff 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <pwd.h>
@@ -294,6 +295,8 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 	struct string s, s1, s2;
 	char *s0 = 0, *log_dir = 0, *log_fn = 0;
 	int log_dir_wait = 0;
+	int string_size;
+	char string_index[10];
 
 	s.s = s1.s = s2.s = 0;
 
@@ -310,6 +313,12 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		goto out;
 
 	expand_logfn(ctx, log_fn, &s);
+	if (ctx->global_ctx) {
+		sprintf(string_index, "%d", ctx->thread_index);
+		append_string(&s, ".", 1);
+		append_string(&s, string_index, 0);
+	}
+
 	if ((log_fn[0] == '/') || !log_dir || !log_dir[0])
 		s0 = s.s;
 
@@ -328,7 +337,6 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		append_string(&s2, log_dir, 0);
 		append_string(&s2, "/", 1);
 		append_string(&s2, s.s, 0);
-		printf("%s\n", s2.s);
 	}
 
 	if (s0)
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 972265b8..2d4e62ca 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2164,6 +2164,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	thread_context->fs->priv_data = thread_context;
 	thread_context->global_ctx = global_ctx;
 
+	thread_context->thread_index = 0;
+	set_up_logging(thread_context);
 	*thread_ctx = thread_context;
 	return 0;
 }
@@ -2171,6 +2173,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	int flags = global_ctx->flags;
+	FILE *global_logf = global_ctx->logf;
+	FILE *global_problem_logf = global_ctx->problem_logf;
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
 
@@ -2185,6 +2189,14 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
 	global_ctx->fs->priv_data = global_ctx;
+	global_ctx->logf = global_logf;
+	global_ctx->problem_logf = global_problem_logf;
+	if (thread_ctx->logf)
+		fclose(thread_ctx->logf);
+	if (thread_ctx->problem_logf) {
+		fputs("</problem_log>\n", thread_ctx->problem_logf);
+		fclose(thread_ctx->problem_logf);
+	}
 	ext2fs_free_mem(&thread_ctx);
 	return 0;
 }
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
index 00000000..faaabc3b
--- /dev/null
+++ b/tests/f_multithread_logfile/name
@@ -0,0 +1 @@
+test "e2fsck -m" option works with "-E log_filename="
diff --git a/tests/f_multithread_logfile/script b/tests/f_multithread_logfile/script
new file mode 100644
index 00000000..4f9ca6f8
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
+	if [ ! -f $LOG_FNAME -o ! -f $LOG_FNAME.0 ]; then
+		echo "$LOG_FNAME or $LOG_FNAME.0 is not created" > $test_name.failed
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
2.37.3

