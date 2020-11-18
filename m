Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06022B80C6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgKRPkn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgKRPkn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:43 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8BC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q199so1399663pfc.21
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AOd0lv18DG3TAacXp8lOAI2DizjzN1cH+leZkyRtJs0=;
        b=jdexb142H9STPGvBoUyfpA4zYSlpvxJJEd7INsae/Pt0oSnXbLhfSR2AHlwrJEB8eo
         Bzn+FqGl7//tKRGwoAtqrWU49sdaNJ653PwhWHUhj20X6/hJ37MEl6oNhGUcX4AXF8MF
         SCu03AbYSym+iUKhji7aYehFCTWVEYI0mlzlYIYrDKxBy8AFxoQoL4RDQjqb+ImWLeVM
         goHqzQD6+ypoezpQGDVRGJXyl7R09qDPibSJwSOqfRcU9aS4uv5ZXHZZ0SmKjxwdmLeC
         QaFLMM9bSY07ec+3S6kcIthDZaFHSiR57azX3/j4uoGzAlYgDg5/3uZAGvc3222S0v+g
         +VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AOd0lv18DG3TAacXp8lOAI2DizjzN1cH+leZkyRtJs0=;
        b=mFP7BI7t/5if5BoHkkVEwQE14/eJEYp038B49sUXZW3O8PAmCJDslOKEeZwRNqn3f1
         5rLdPELkSsoQGwNkLZan2swGQsBPETmTNDrYqnQqJ0RBzIMBfqoXdttDDg2H2eAC4fqJ
         KudNcNyiViuTOMDrmZYBjgRgv2hOSrjvPWKIKG9cJrblxbWWwM98KMOKhLYrZoaVuElI
         gA5nsjGDVz5mP36MtxulNTq+i+NGzxZgauuNrrGPKbFJLisu/n+RGstmNMtfpV1nYXuh
         4ExjCJalSB8mf3tRLi60RU5HVDO4Se3fETlN5GrhwQnJbSP1nflrh2XcFgwZqPSHUK2K
         gO+w==
X-Gm-Message-State: AOAM531dA3B/vju4DI5VynJaLngAx6tGvakEQV6Pe94IyE9rsc1pHvGT
        drl4zrQvTzxFUhm4Vlc4GMLIfC3Zyv6pgSyxbJcCMt3ydZDyELSqflC6dJqDgVH80l8IjaMNlLd
        iefUrNN0mY9LEFmY9qnqQhBONaVfw6LdgK18+zsY/214GF8ZqTaQebCGef9TVY38znwqQqGkeoF
        bmEkbpgQs=
X-Google-Smtp-Source: ABdhPJwlR2Smca9XduHd3P6uzllSeTgjZQ9URT1Z6eLw8TLtP95ucJp+obVZIom2diVC1Uxdj0z1QzlgfQfSe7+dowI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:b415:b029:d6:ec35:755b with
 SMTP id x21-20020a170902b415b02900d6ec35755bmr4938340plr.47.1605714042648;
 Wed, 18 Nov 2020 07:40:42 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:55 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-10-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 09/61] e2fsck: create logs for mult-threads
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

When multi-threads are used, different logs should be created
for different threads. Each thread has log files with suffix
of ".$THREAD_INDEX".

And this patch adds f_multithread_logfile test case.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h                      |  6 ++++--
 e2fsck/logfile.c                     | 10 ++++++++-
 e2fsck/pass1.c                       | 23 +++++++++++++++-----
 tests/f_multithread_logfile/expect.1 | 23 ++++++++++++++++++++
 tests/f_multithread_logfile/image.gz |  1 +
 tests/f_multithread_logfile/name     |  1 +
 tests/f_multithread_logfile/script   | 32 ++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 8 deletions(-)
 create mode 100644 tests/f_multithread_logfile/expect.1
 create mode 120000 tests/f_multithread_logfile/image.gz
 create mode 100644 tests/f_multithread_logfile/name
 create mode 100644 tests/f_multithread_logfile/script

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 1416f15e..5ad0fe93 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -308,8 +308,10 @@ struct e2fsck_struct {
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
index 63e9a12f..c5505d27 100644
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
+	char string_index[10];
 
 	s.s = s1.s = s2.s = 0;
 
@@ -307,6 +310,12 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
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
 
@@ -325,7 +334,6 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		append_string(&s2, log_dir, 0);
 		append_string(&s2, "/", 1);
 		append_string(&s2, s.s, 0);
-		printf("%s\n", s2.s);
 	}
 
 	if (s0)
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 10efa0ed..bae47a7f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2250,6 +2250,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	}
 	thread_fs->priv_data = thread_context;
 
+	thread_context->thread_index = 0;
+	set_up_logging(thread_context);
+
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
@@ -2262,12 +2265,14 @@ out_context:
 
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
@@ -2286,6 +2291,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
+	global_ctx->logf = global_logf;
+	global_ctx->problem_logf = global_problem_logf;
 
 	if (thread_ctx->inode_used_map) {
 		retval = e2fsck_pass1_copy_bitmap(global_fs,
@@ -2374,6 +2381,12 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 
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
2.29.2.299.gdc1121823c-goog

