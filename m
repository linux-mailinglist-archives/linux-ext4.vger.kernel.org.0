Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE22B80E3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgKRPlb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKRPla (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F649C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c137so2904038ybf.21
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8LU0YxAerh4POqUdK05x0LXM/TPnR/ysn8K7JZeGK1E=;
        b=rHZZnZaxluMOW3UBeHuhozNpkeJjUC/oHh3NG+JwZsw/13LQQZvbJgZtF+w0jmZUaN
         b8pUS48laux+hLkA9cG8aHysXu0cvjBV899/WcADgHp/Le8KiyEM9iJJeO2PD9RuMGZY
         NvXQ/qOAJC+8B2YGs2lHKbVkzWO4CXFp9j44TJH13Q/RD+zpG4NilrCRWsBkJU5Hknbq
         4Ble+w2PJbkGQsW0WiEm+qmwjinpdozmVO2THlDab4pBSnTsE9SpN8L27Qf+oBCpL0WX
         JWquHB7AEP04M71GR9+usLqF05wprTkxeDgf7I3NaLtLWbI+H1M5kwnlO/NK9hECoApJ
         YliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8LU0YxAerh4POqUdK05x0LXM/TPnR/ysn8K7JZeGK1E=;
        b=Ozhpj8ToHfcawjAwzcy5rEUNQAJaMh/L/yeAEwTH+zS/MkjREMc//aGI9f8hk9ky6h
         VxxW5W+E17oTl6c7TX4yR3Xz66Z1eZ9rlU/zOrJkhoTcEb1of4F8LF1wosCtqTmXkmjs
         L27duzCE5H5zIQk5CIvtiXrAQSDl1MnrxfCRywu6LLvF+3kFylwhl6UJCkLI7aIfMQE/
         nne1dDhEO6x3WEuxEQmPFC/ohZ6uKp+bH1Mf2vDXs/f5cTKtLX716I5j6oqYmO/TLxLH
         q8AqEDtR4NBnt1XS6WaYQeyPDTnIAGQxk8AtMhF5B8aHG21+J6m0Y8aO2HOUEN8RV1Jt
         dA8Q==
X-Gm-Message-State: AOAM533ORvcMzI5n9Dinoq9AP8ttU35AhMF+lPc+dsy4JZ9+u7cqbxa9
        0XtIg/CaxLBNEx3GCZhxcSCNd8EcIOmY1cZ+kORuLrcxdTXUbLNnGg/+GxKUga5mBJui6fDGdkv
        g4W4MxzLkL5rnrw64z/FGy2P5o6GTWA7pE4d5kLVCuzPPvohkv0P1D4/+VEF9GTVtYivQ6ply7a
        lTPOHbQu0=
X-Google-Smtp-Source: ABdhPJwLUDBO86KnpjCzLu/P7FhWHFIl4ex5K0Q93MoWR9FrJLha1IxSnjW+GAKMrRie1hecg9SfzxFXhGVF6fItFjI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:4946:: with SMTP id
 w67mr11695609yba.143.1605714089269; Wed, 18 Nov 2020 07:41:29 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:20 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-35-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 34/61] e2fsck: allow admin specify number of threads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

-m option is introduced to specify number of threads for pfsck.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h                       |   2 +
 e2fsck/pass1.c                        | 165 ++++++++++++++++----------
 e2fsck/unix.c                         |  17 ++-
 tests/f_multithread/script            |   2 +-
 tests/f_multithread_completion/script |   2 +-
 tests/f_multithread_logfile/script    |   2 +-
 tests/f_multithread_no/script         |   2 +-
 tests/f_multithread_preen/script      |   2 +-
 tests/f_multithread_yes/script        |   2 +-
 9 files changed, 128 insertions(+), 68 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index d4b472f5..f46a95ef 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -450,6 +450,7 @@ struct e2fsck_struct {
 	/* Undo file */
 	char *undo_file;
 #ifdef CONFIG_PFSCK
+	__u32			 fs_num_threads;
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
@@ -684,6 +685,7 @@ int check_backup_super_block(e2fsck_t ctx);
 void check_resize_inode(e2fsck_t ctx);
 
 /* util.c */
+#define E2FSCK_MAX_THREADS	(65536)
 extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 				    const char *description);
 extern int ask(e2fsck_t ctx, const char * string, int def);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 6dba6d1b..30365d23 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1194,6 +1194,97 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
+static void init_ext2_max_sizes()
+{
+	int	i;
+	__u64	max_sizes;
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
+#ifdef CONFIG_PFSCK
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
@@ -1204,6 +1295,11 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
 
+	init_ext2_max_sizes();
+#ifdef	CONFIG_PFSCK
+	e2fsck_pass1_set_thread_num(ctx);
+#endif
+
 	clear_problem_context(&pctx);
 	if (!(ctx->options & E2F_OPT_PREEN))
 		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
@@ -2207,27 +2303,6 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
-static void init_ext2_max_sizes()
-{
-	int	i;
-	__u64	max_sizes;
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
 #ifdef CONFIG_PFSCK
 static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
 					  ext2fs_generic_bitmap *dest)
@@ -3220,9 +3295,9 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
-	struct e2fsck_thread_info	*infos = NULL;
-	int				 num_threads = 1;
-	errcode_t			 retval;
+	struct e2fsck_thread_info *infos = NULL;
+	int num_threads = global_ctx->fs_num_threads;
+	errcode_t retval;
 
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
@@ -3244,54 +3319,22 @@ out_abort:
 }
 #endif
 
-/* TODO: tdb needs to be handled properly for multiple threads*/
-static int multiple_threads_supported(e2fsck_t ctx)
-{
-#ifdef	CONFIG_TDB
-	unsigned int		threshold;
-	ext2_ino_t		num_dirs;
-	errcode_t		retval;
-	char			*tdb_dir;
-	int			enable;
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
-	    (!threshold || num_dirs > threshold))
-		return 0;
- #endif
-	return 1;
-}
-
 void e2fsck_pass1(e2fsck_t ctx)
 {
 	errcode_t retval;
-	int multiple = 0;
+	int need_single = 1;
 
-	init_ext2_max_sizes();
 	retval = e2fsck_pass1_prepare(ctx);
 	if (retval)
 		return;
 #ifdef CONFIG_PFSCK
-	if (multiple_threads_supported(ctx)) {
-		multiple = 1;
+	if (ctx->fs_num_threads > 1 ||
+	    ctx->options & E2F_OPT_MULTITHREAD) {
+		need_single = 0;
 		e2fsck_pass1_multithread(ctx);
-	} else {
-		fprintf(stderr, "Fall through single thread for pass1 "
-				"because tdb could not handle properly\n");
 	}
 #endif
-	if (!multiple)
+	if (need_single)
 		e2fsck_pass1_run(ctx);
 	e2fsck_pass1_post(ctx);
 }
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 30c2bf31..cd31bcd5 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -819,6 +819,10 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	int 		res;		/* result of sscanf */
 #ifdef CONFIG_JBD_DEBUG
 	char 		*jbd_debug;
+#endif
+#ifdef CONFIG_PFSCK
+	char		*pm;
+	unsigned long	thread_num;
 #endif
 	unsigned long long phys_mem_kb;
 
@@ -852,7 +856,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	ctx->readahead_kb = ~0ULL;
 
 #ifdef CONFIG_PFSCK
-	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+	while ((c = getopt(argc, argv, "pam:nyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 #else
 	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 #endif
@@ -898,7 +902,18 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			break;
 #ifdef CONFIG_PFSCK
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
2.29.2.299.gdc1121823c-goog

