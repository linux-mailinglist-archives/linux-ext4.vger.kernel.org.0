Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0F61F2FF
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKGMZF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKGMYx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292F140F6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so10952969pli.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMUAlTv0xFqkr4yBd3hOL6zg1L92K891HA8xH93YHYc=;
        b=PpRIw9C97by405j/e3btrx6VItpdNXtv2DAZPfa/VaRb8qcjyb30blV4S7KIyXxzV6
         t0qvnH3OteQkerC2MWG17nT7GC9cXU49uZwdjgRJKAYJt47EiKuSC28f1pv7nDy63rro
         m9gPFhHcWtGxxnpvbLEHENdepJPvRDJPTr2ddtayaBZZk3YQnbzHMD7jy+dIqnlYV1d4
         rFMhK96O8TiwrVaBbQR43g1jjvHvXrYypenR1/0gEJDDfZe0ufDoniUuMnK2tOuvR93U
         C9So8L0g3X+t2y+XFzyFsYzEfiFK9DtxR2JX9iCUHCILg5sUSTS7F6mk1xByg/lJq6XG
         AAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMUAlTv0xFqkr4yBd3hOL6zg1L92K891HA8xH93YHYc=;
        b=diw+Bp6njgQQs7o/ReWMLT4AJwIKnVFeIvFzw9iLQGCD5n/IjGHP5nK8hC5+3x3tQ0
         hQhpqhPT6Ox17hQSu/Wb2zSe2yEYBMbBJdGuvtkKnW26JmbyzlzalOnZ89JvXnrcg4cD
         eszs1Lo8QA40pQK3BMl5/UFYezJ+FlqqJakLI8amedsax//x9n0cLlF15xSDeQ9f5/N5
         wpiL/JxWb8hp/s2DyaEUaRqje4VPdEKoHpGCcA0lgz8cgMMAklGmq+ijM/cKlZYvexdl
         PvDw+3HFzWeUOs2mupc4mIfe3NSyjmR3lg/d6YRpkX6vOaDesX8pwMuV1RleDOTe3JkM
         cK/g==
X-Gm-Message-State: ACrzQf3aQiPdxeXk0wjxqRr8KZyINBzyScVFsuks6jQi1iKFVc+hJW+/
        djhdu9+8o1f8ewiUeXYfjdc=
X-Google-Smtp-Source: AMsMyM5qrnMtyEVlyQajWbXzA6J6jDqMInTe7IBqb4yK3Lt3v2T5szpZ9L34KeWlYLONM/MKj+QRng==
X-Received: by 2002:a17:903:1381:b0:188:602c:3332 with SMTP id jx1-20020a170903138100b00188602c3332mr19711924plb.122.1667823892062;
        Mon, 07 Nov 2022 04:24:52 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id v2-20020aa799c2000000b00561dcfa700asm4358141pfi.107.2022.11.07.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:51 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 24/72] e2fsck: configure one pfsck thread
Date:   Mon,  7 Nov 2022 17:51:12 +0530
Message-Id: <0bd43001b7c2d1cb5551564b83baf02bc771dcb6.1667822611.git.ritesh.list@gmail.com>
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

This patch creates only one thread to do pass1 check if pthreads are
enabled. The same codes can be used to create multiple threads, but
other functions need to be modified to get ready for that.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h   |  13 ++++
 e2fsck/logfile.c  |   2 +
 e2fsck/pass1.c    | 152 ++++++++++++++++++++++++++++++++++++++++------
 e2fsck/unix.c     |  10 +++
 tests/test_one.in |   8 +++
 5 files changed, 166 insertions(+), 19 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 284bc52e..5bc24c3f 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -465,6 +465,19 @@ struct e2fsck_struct {
 	struct e2fsck_fc_replay_state fc_replay_state;
 };
 
+#ifdef HAVE_PTHREAD
+struct e2fsck_thread_info {
+	/* ID returned by pthread_create() */
+	pthread_t		 eti_thread_id;
+	/* Application-defined thread index */
+	int			 eti_thread_index;
+	/* Thread has been started */
+	int			 eti_started;
+	/* Context used for this thread */
+	e2fsck_t		 eti_thread_ctx;
+};
+#endif
+
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
 struct extent_tree_level {
 	unsigned int	num_extents;
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 83dbceff..74781f80 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -313,11 +313,13 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		goto out;
 
 	expand_logfn(ctx, log_fn, &s);
+#ifdef HAVE_PTHREAD
 	if (ctx->global_ctx) {
 		sprintf(string_index, "%d", ctx->thread_index);
 		append_string(&s, ".", 1);
 		append_string(&s, string_index, 0);
 	}
+#endif
 
 	if ((log_fn[0] == '/') || !log_dir || !log_dir[0])
 		s0 = s.s;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2d4e62ca..596096d1 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -47,6 +47,9 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#ifdef HAVE_PTHREAD
+#include <pthread.h>
+#endif
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -1166,7 +1169,7 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
-void e2fsck_pass1_thread(e2fsck_t ctx)
+void e2fsck_pass1_run(e2fsck_t ctx)
 {
 	int	i;
 	__u64	max_sizes;
@@ -2150,6 +2153,7 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+#ifdef HAVE_PTHREAD
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
 {
 	errcode_t retval;
@@ -2201,18 +2205,38 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	return 0;
 }
 
-void e2fsck_pass1_multithread(e2fsck_t ctx)
+static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
+				      int num_threads, e2fsck_t global_ctx)
 {
-	errcode_t retval;
-	e2fsck_t thread_ctx;
+	errcode_t rc;
+	errcode_t ret = 0;
+	int i;
+	struct e2fsck_thread_info *pinfo;
 
-	retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
-	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while preparing pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+	for (i = 0; i < num_threads; i++) {
+		pinfo = &infos[i];
+
+		if (!pinfo->eti_started)
+			continue;
+
+		rc = pthread_join(pinfo->eti_thread_id, NULL);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
+		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
 	}
+	free(infos);
+
+	return ret;
+}
+
+static void *e2fsck_pass1_thread(void *arg)
+{
+	struct e2fsck_thread_info *info = arg;
+	e2fsck_t thread_ctx = info->eti_thread_ctx;
 
 #ifdef HAVE_SETJMP_H
 	/*
@@ -2223,28 +2247,118 @@ void e2fsck_pass1_multithread(e2fsck_t ctx)
 	 */
 	if (setjmp(thread_ctx->abort_loc)) {
 		thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
-		e2fsck_pass1_thread_join(ctx, thread_ctx);
-		return;
+		goto out;
 	}
 	thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
 #endif
 
-	e2fsck_pass1_thread(thread_ctx);
-	retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
+	e2fsck_pass1_run(thread_ctx);
+
+out:
+	return NULL;
+}
+
+static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
+				      int num_threads, e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info *infos;
+	pthread_attr_t attr;
+	errcode_t retval;
+	errcode_t ret;
+	struct e2fsck_thread_info *tmp_pinfo;
+	int i;
+	e2fsck_t thread_ctx;
+
+	retval = pthread_attr_init(&attr);
 	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while joining pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+		com_err(global_ctx->program_name, retval,
+			_("while setting pthread attribute\n"));
+		return retval;
+	}
+
+	infos = calloc(num_threads, sizeof(struct e2fsck_thread_info));
+	if (infos == NULL) {
+		retval = -ENOMEM;
+		com_err(global_ctx->program_name, retval,
+			_("while allocating memory for threads\n"));
+		pthread_attr_destroy(&attr);
+		return retval;
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		tmp_pinfo = &infos[i];
+		tmp_pinfo->eti_thread_index = i;
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while preparing pass1 thread\n"));
+			break;
+		}
+		tmp_pinfo->eti_thread_ctx = thread_ctx;
+
+		retval = pthread_create(&tmp_pinfo->eti_thread_id, &attr,
+					&e2fsck_pass1_thread, tmp_pinfo);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while creating thread\n"));
+			e2fsck_pass1_thread_join(global_ctx, thread_ctx);
+			break;
+		}
+
+		tmp_pinfo->eti_started = 1;
+	}
+
+	/* destroy the thread attribute object, since it is no longer needed */
+	ret = pthread_attr_destroy(&attr);
+	if (ret) {
+		com_err(global_ctx->program_name, ret,
+			_("while destroying thread attribute\n"));
+		if (retval == 0)
+			retval = ret;
+	}
+
+	if (retval) {
+		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		return retval;
 	}
+	*pinfo = infos;
+	return 0;
 }
 
+static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info *infos = NULL;
+	int num_threads = 1;
+	errcode_t retval;
+
+	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while starting pass1 threads\n"));
+		goto out_abort;
+	}
+
+	retval = e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while joining pass1 threads\n"));
+		goto out_abort;
+	}
+	return;
+out_abort:
+	global_ctx->flags |= E2F_FLAG_ABORT;
+	return;
+}
+#endif
+
 void e2fsck_pass1(e2fsck_t ctx)
 {
+#ifdef HAVE_PTHREAD
 	if (ctx->options & E2F_OPT_MULTITHREAD)
 		e2fsck_pass1_multithread(ctx);
 	else
-		e2fsck_pass1_thread(ctx);
+#endif
+		e2fsck_pass1_run(ctx);
 }
 
 #undef FINISH_INODE_LOOP
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index a77041b0..af2457e3 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -83,7 +83,9 @@ static void usage(e2fsck_t ctx)
 
 	fprintf(stderr, "%s", _("\nEmergency help:\n"
 		" -p                   Automatic repair (no questions)\n"
+#ifdef HAVE_PTHREAD
 		" -m                   multiple threads to speedup fsck\n"
+#endif
 		" -n                   Make no changes to the filesystem\n"
 		" -y                   Assume \"yes\" to all questions\n"
 		" -c                   Check for bad blocks and add them to the badblock list\n"
@@ -856,7 +858,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
 
+#ifdef HAVE_PTHREAD
 	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+#else
+	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+#endif
 		switch (c) {
 		case 'C':
 			ctx->progress = e2fsck_update_progress;
@@ -897,9 +903,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			}
 			ctx->options |= E2F_OPT_PREEN;
 			break;
+#ifdef HAVE_PTHREAD
 		case 'm':
 			ctx->options |= E2F_OPT_MULTITHREAD;
 			break;
+#endif
 		case 'n':
 			if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
 				goto conflict_opt;
@@ -1019,6 +1027,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			_("The -n and -l/-L options are incompatible."));
 		fatal_error(ctx, 0);
 	}
+#ifdef HAVE_PTHREAD
 	if (ctx->options & E2F_OPT_MULTITHREAD) {
 		if ((ctx->options & (E2F_OPT_YES|E2F_OPT_NO|E2F_OPT_PREEN)) == 0) {
 			com_err(ctx->program_name, 0, "%s",
@@ -1031,6 +1040,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			fatal_error(ctx, 0);
 		}
 	}
+#endif
 	if (ctx->options & E2F_OPT_NO)
 		ctx->options |= E2F_OPT_READONLY;
 
diff --git a/tests/test_one.in b/tests/test_one.in
index 78499ad0..a1d46c9c 100644
--- a/tests/test_one.in
+++ b/tests/test_one.in
@@ -27,6 +27,7 @@ esac
 
 test_dir=$1
 cmd_dir=$SRCDIR
+pfsck_enabled="no"
 
 if test "$TEST_CONFIG"x = x; then
 	TEST_CONFIG=$SRCDIR/test_config
@@ -52,6 +53,13 @@ else
 	test_description=
 fi
 
+$FSCK --help 2>&1 | grep -q -w -- -m && pfsck_enabled=yes
+if [ "$pfsck_enabled" != "yes" ] ; then
+	echo "$test_dir" | grep -q multithread &&
+	echo "$test_name: $test_description: skipped (pfsck disabled)" &&
+	exit 0
+fi
+
 if [ -n "$SKIP_SLOW_TESTS" -a -f $test_dir/is_slow_test ]; then
     echo "$test_name: $test_description: skipped (slow test)"
     exit 0
-- 
2.37.3

