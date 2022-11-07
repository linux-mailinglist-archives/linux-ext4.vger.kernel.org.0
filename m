Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A761F31D
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiKGM13 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiKGM1U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621086247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q9so10453352pfg.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeEkOAiz0Ab66xS7o/5LER3ddboExhEpNk0u/MGhN+E=;
        b=pCOARm7kcBgdAFtONwUIM512UpGNsKFeVDjXd5wGoIJ/cXm7qXk3ldqDJLQ+gYGA3y
         GuKeNxF82/k2lsCYkTmJTtkxjv36o+N3XkeMgxR3Ve0nVrZUKGMG7XjGdxxutvCUcrkf
         82Pg7RjFpt0s+IzA0+mYWMYQRxaBsBRcaTmMzqwETU/Wc9EayhL0dCcUJ698isQ/RUS1
         4uljm0RdbbfLPydstEE1BOSKWH55rUI8AM6buKW20eVvlB2wDB5JAj+YmZgQ/cSJ4kMq
         xEC3xDdGOBiH6B/XhogYFnTL1/I/5f/l8P51CPUfI2jjRzfJe0k/aZQI75g6ZbG27cRz
         nFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeEkOAiz0Ab66xS7o/5LER3ddboExhEpNk0u/MGhN+E=;
        b=JmRBOTZUXTsdEYmxceJtr6Cm0pODM55GDNS8a7iKxmtMKtILGWStvxTVR072HndFGQ
         /D1zRS/4rPDIeequPUqouWCDThBCct3iYtCdG7zWDT66pTQlXpkZvzYCJ7WWGqAigPS1
         Al9DlL5gEQlANvhfUOyO5vqxHPfC/arsubYIVSC6W4+yag404+AjpaHTpCR6No3/QTXd
         0nmKBe5KuHOEQGGpuxZuwB78BLKIQrSi0uj26sUgTuz7mNG6oRh0WT1IJu/QGXXLeCGi
         kQrcLUTqkILMLgtPJEjclMx2d2si2r3JnyB/e5uK+A7tfMsmA5MYR1r5v7G5FZCb6V8S
         zK9Q==
X-Gm-Message-State: ACrzQf1Tttic4lTXERzNITxpptI90lj1hSF936JcmpSDCT24f0fcW+y+
        2upm30U/r5HJ/bVJli6p/Wc=
X-Google-Smtp-Source: AMsMyM7sU+LvDdqyVejLXCq1MnQ2Uu5qc77wk+2Pa1jKLGRSI5VItBhQ/6MkEZi3YqJVY7ShByMz6g==
X-Received: by 2002:a05:6a00:98d:b0:56c:7c5c:da30 with SMTP id u13-20020a056a00098d00b0056c7c5cda30mr49471658pfg.22.1667824037822;
        Mon, 07 Nov 2022 04:27:17 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id w69-20020a627b48000000b00545f5046372sm4324904pfc.208.2022.11.07.04.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:17 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 48/72] e2fsck: allow admin specify number of threads
Date:   Mon,  7 Nov 2022 17:51:36 +0530
Message-Id: <e4d9a66512e8c29cc18698f7d33bc9e1cf8b8795.1667822611.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

-m option is introduced to specify number of threads for pfsck.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h                       |   2 +
 e2fsck/pass1.c                        | 154 ++++++++++++++++----------
 e2fsck/unix.c                         |  17 ++-
 tests/f_multithread/script            |   2 +-
 tests/f_multithread_completion/script |   2 +-
 tests/f_multithread_logfile/script    |   2 +-
 tests/f_multithread_no/script         |   2 +-
 tests/f_multithread_preen/script      |   2 +-
 tests/f_multithread_yes/script        |   2 +-
 9 files changed, 122 insertions(+), 63 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 23e8d2ed..e3276924 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -487,6 +487,7 @@ struct e2fsck_struct {
 	char *undo_file;
 
 #ifdef HAVE_PTHREAD
+	__u32			 fs_num_threads;
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
@@ -727,6 +728,7 @@ void check_resize_inode(e2fsck_t ctx);
 int check_init_orphan_file(e2fsck_t ctx);
 
 /* util.c */
+#define E2FSCK_MAX_THREADS	(65536)
 extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 				    const char *description);
 extern int ask(e2fsck_t ctx, const char * string, int def);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index fdd1f3d6..5bf6980b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1199,6 +1199,97 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
+static void init_ext2_max_sizes()
+{
+	int i;
+	__u64 max_sizes;
+
+	/*
+	 * Init ext2_max_sizes which will be immutable and shared between
+	 * threads
+	 */
+#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
+
+	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
+		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = (max_sizes * (1UL << i));
+		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
+	}
+#undef EXT2_BPP
+}
+
+#ifdef HAVE_PTHREAD
+/* TODO: tdb needs to be handled properly for multiple threads*/
+static int multiple_threads_supported(e2fsck_t ctx)
+{
+#ifdef	CONFIG_TDB
+	unsigned int		threshold;
+	ext2_ino_t		num_dirs;
+	errcode_t		retval;
+	char			*tdb_dir;
+	int			enable;
+
+	profile_get_string(ctx->profile, "scratch_files", "directory", 0, 0,
+			   &tdb_dir);
+	profile_get_uint(ctx->profile, "scratch_files",
+			 "numdirs_threshold", 0, 0, &threshold);
+	profile_get_boolean(ctx->profile, "scratch_files",
+			    "icount", 0, 1, &enable);
+
+	retval = ext2fs_get_num_dirs(ctx->fs, &num_dirs);
+	if (retval)
+		num_dirs = 1024;	/* Guess */
+
+	/* tdb is unsupported now */
+	if (enable && tdb_dir && !access(tdb_dir, W_OK) &&
+	    (!threshold || num_dirs > threshold))
+		return 0;
+#endif
+	return 1;
+}
+
+/**
+ * Even though we could specify number of threads,
+ * but it might be more than the whole filesystem
+ * block groups, correct it here.
+ */
+static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
+{
+	unsigned flexbg_size = 1;
+	ext2_filsys fs = ctx->fs;
+	int num_threads = ctx->fs_num_threads;
+	int max_threads;
+
+	if (num_threads < 1) {
+		num_threads = 1;
+		goto out;
+	}
+
+	if (!multiple_threads_supported(ctx)) {
+		num_threads = 1;
+		fprintf(stderr, "Fall through single thread for pass1 "
+			"because tdb could not handle properly\n");
+		goto out;
+	}
+
+	if (ext2fs_has_feature_flex_bg(fs->super))
+		flexbg_size = 1 << fs->super->s_log_groups_per_flex;
+	max_threads = fs->group_desc_count / flexbg_size;
+	if (max_threads == 0)
+		max_threads = 1;
+
+	if (num_threads > max_threads) {
+		fprintf(stderr, "Use max possible thread num: %d instead\n",
+				max_threads);
+		num_threads = max_threads;
+	}
+out:
+	ctx->fs_num_threads = num_threads;
+}
+#endif
+
 /*
  * We need call mark_table_blocks() before multiple
  * thread start, since all known system blocks should be
@@ -1209,6 +1300,11 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
 
+	init_ext2_max_sizes();
+#ifdef	HAVE_PTHREAD
+	e2fsck_pass1_set_thread_num(ctx);
+#endif
+
 	clear_problem_context(&pctx);
 	if (!(ctx->options & E2F_OPT_PREEN))
 		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
@@ -2271,27 +2367,6 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
-static void init_ext2_max_sizes()
-{
-	int i;
-	__u64 max_sizes;
-
-	/*
-	 * Init ext2_max_sizes which will be immutable and shared between
-	 * threads
-	 */
-#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
-
-	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
-		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = (max_sizes * (1UL << i));
-		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
-	}
-#undef EXT2_BPP
-}
-
 #ifdef HAVE_PTHREAD
 static errcode_t e2fsck_pass1_merge_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
 					  ext2fs_generic_bitmap *dest)
@@ -3151,7 +3226,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info *infos = NULL;
-	int num_threads = 1;
+	int num_threads = global_ctx->fs_num_threads;
 	errcode_t retval;
 
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
@@ -3174,48 +3249,15 @@ out_abort:
 }
 #endif
 
-/* TODO: tdb needs to be handled properly for multiple threads*/
-static int multiple_threads_supported(e2fsck_t ctx)
-{
-#ifdef	CONFIG_TDB
-	unsigned int threshold;
-	ext2_ino_t num_dirs;
-	errcode_t retval;
-	char *tdb_dir;
-	int enable;
-
-	profile_get_string(ctx->profile, "scratch_files", "directory", 0, 0,
-			   &tdb_dir);
-	profile_get_uint(ctx->profile, "scratch_files",
-			 "numdirs_threshold", 0, 0, &threshold);
-	profile_get_boolean(ctx->profile, "scratch_files",
-			    "icount", 0, 1, &enable);
-
-	retval = ext2fs_get_num_dirs(ctx->fs, &num_dirs);
-	if (retval)
-		num_dirs = 1024;	/* Guess */
-
-	/* tdb is unsupported now */
-	if (enable && tdb_dir && !access(tdb_dir, W_OK) &&
-	    (!threshold || num_dirs > threshold)) {
-		fprintf(stderr, "Fall through single thread for pass1 "
-				"because tdb could not handle properly\n");
-		return 0;
-	}
- #endif
-	return 1;
-}
-
 void e2fsck_pass1(e2fsck_t ctx)
 {
 	errcode_t retval;
 
-	init_ext2_max_sizes();
 	retval = e2fsck_pass1_prepare(ctx);
 	if (retval)
 		return;
 #ifdef HAVE_PTHREAD
-	if (ctx->options & E2F_OPT_MULTITHREAD && multiple_threads_supported(ctx))
+	if (ctx->options & E2F_OPT_MULTITHREAD || ctx->fs_num_threads > 1)
 		e2fsck_pass1_multithread(ctx);
 	else
 #endif
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index af2457e3..dfa3f897 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -826,6 +826,10 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	int 		res;		/* result of sscanf */
 #ifdef CONFIG_JBD_DEBUG
 	char 		*jbd_debug;
+#endif
+#ifdef HAVE_PTHREAD
+	char		*pm;
+	unsigned long	thread_num;
 #endif
 	unsigned long long phys_mem_kb, blk;
 
@@ -859,7 +863,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	ctx->readahead_kb = ~0ULL;
 
 #ifdef HAVE_PTHREAD
-	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+	while ((c = getopt(argc, argv, "pam:nyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 #else
 	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 #endif
@@ -905,7 +909,18 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			break;
 #ifdef HAVE_PTHREAD
 		case 'm':
+			thread_num = strtoul(optarg, &pm, 0);
+			if (*pm)
+				fatal_error(ctx,
+					_("Invalid multiple thread num.\n"));
+			if (thread_num > E2FSCK_MAX_THREADS) {
+				fprintf(stderr,
+					_("threads %lu too large (max %lu)\n"),
+					thread_num, E2FSCK_MAX_THREADS);
+				fatal_error(ctx, 0);
+			}
 			ctx->options |= E2F_OPT_MULTITHREAD;
+			ctx->fs_num_threads = thread_num;
 			break;
 #endif
 		case 'n':
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
index 4f9ca6f8..dbb65319 100644
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
2.37.3

