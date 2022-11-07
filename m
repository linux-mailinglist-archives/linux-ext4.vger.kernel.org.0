Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC361F307
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiKGMZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiKGMZZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B966247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v28so10429543pfi.12
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzYUNICtcdUfkHGzm3SM3RGET55sqDgTXz+Q60l/yv0=;
        b=EADHTMOHLN5PEWZanKvGFAMTKeoUEYJn9VJkIzy4YbjQ8lk7eyqu5BGC+mjygwl3Ln
         aeP8kmUR1tTOIfNK+r/yUQk2SFNUk2bFBeZpd2RYF7OO63rdkRXOF8i5XvHE+3xgx1x8
         83lcPbNdvcGKAz9UFbwx+g6En0DFb/eRphqk5dpCo/3jcADZ1oO1U6sa5qZNtsUnWRTD
         soRjS2l4b275479YioKblfzPMbzDBQUeXR7kuVkSF3uSRybGTtzyFit8D/37iKk/SyIH
         bNF03Ijb/z+d/ZQ6ODabM3VLfctxtj3blWo9MwOqVHpfHqXzrMlHaZIqzPB4PuzrXhqY
         rh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzYUNICtcdUfkHGzm3SM3RGET55sqDgTXz+Q60l/yv0=;
        b=jz2+HO2vOyJ0COKvKnD7MiO/JBfDZB51lD8qoYgU3dgOwdS6WOePUkiItgh1+0THNt
         LRdEYOMgJbudTEH2UOsCmyRl7Km2wyQN1Ehr4yLcxjwei2s5D469GL9xSWiaVPDvgyMU
         8OBod5LhXVBHhm1iyxneWzUfx/Zj+3ja6ZBq5wJZltwrABntZky6YgUby8d2O6M2JWiv
         +sCbrZQ/he/ApXnYcst+chhHth0shF/vfY3ZmGz0HaaNSiuuJmKqfIFqWGu/TUamYnx9
         HICGfDtYG3+FNN8olcwhnu1KPFophT1U1TVZobiVxmVNb/n823fqL/OxCkBt7SOzEBbp
         0/aw==
X-Gm-Message-State: ACrzQf1DiD0OMrn2E0BDAgNQdPg+1cw8lmbV3sav1ChnC7sWku5rLrtK
        JFCLJ/yILon5c+RxLmDxPDxqd9PKS/A=
X-Google-Smtp-Source: AMsMyM4wJMNbpHBUCk1Q6EcN19rSlOUx9ETDX+YFcS4/0LTGQ2Jq5qRtHzu6h75h3SyQnV56E3kZ8w==
X-Received: by 2002:a05:6a00:23c9:b0:56c:9f62:3369 with SMTP id g9-20020a056a0023c900b0056c9f623369mr49147365pfc.22.1667823922675;
        Mon, 07 Nov 2022 04:25:22 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0056bb7d90f0fsm4366888pfr.182.2022.11.07.04.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:21 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 29/72] e2fsck: add start/end group for thread
Date:   Mon,  7 Nov 2022 17:51:17 +0530
Message-Id: <800f926c9314d97f735fb25c40a3a88efcc05beb.1667822611.git.ritesh.list@gmail.com>
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

When multi-threads are used for check, each thread needs to jump
to different group in pass1 check. This patch adds the group
jumping support. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h           | 23 ++++++++++++++++++--
 e2fsck/logfile.c          |  3 ++-
 e2fsck/pass1.c            | 44 ++++++++++++++++++++++++++++++++++++---
 e2fsck/problem.c          |  5 +++++
 e2fsck/problem.h          |  3 +++
 lib/ext2fs/ext2_err.et.in |  3 +++
 6 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 5bc24c3f..639f4e80 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -261,6 +261,22 @@ struct e2fsck_fc_replay_state {
 	__u16 fc_super_state;
 };
 
+#ifdef HAVE_PTHREAD
+/*
+ * Fields that used for multi-thread
+ */
+struct e2fsck_thread {
+	/* Thread index */
+	int		et_thread_index;
+	/* The start group number for this thread */
+	dgrp_t		et_group_start;
+	/* The end (not included) group number for this thread*/
+	dgrp_t		et_group_end;
+	/* The next group number to check */
+	dgrp_t		et_group_next;
+};
+#endif
+
 struct e2fsck_struct {
 	/* Global context to get the cancel flag */
 	e2fsck_t global_ctx;
@@ -344,8 +360,11 @@ struct e2fsck_struct {
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
-	/* Thread index, if global_ctx is null, this field is unused */
-	int			thread_index;
+
+	/* if @global_ctx is null, this field is unused */
+#ifdef HAVE_PTHREAD
+	struct e2fsck_thread	 thread_info;
+#endif
 
 	/*
 	 * Location of the lost and found directory
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 74781f80..cc811d5a 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -315,7 +315,8 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 	expand_logfn(ctx, log_fn, &s);
 #ifdef HAVE_PTHREAD
 	if (ctx->global_ctx) {
-		sprintf(string_index, "%d", ctx->thread_index);
+		sprintf(string_index, "%d",
+			ctx->thread_info.et_thread_index);
 		append_string(&s, ".", 1);
 		append_string(&s, string_index, 0);
 	}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ea432ff2..3bb87669 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1389,6 +1389,23 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	/* Set up ctx->lost_and_found if possible */
 	(void) e2fsck_get_lost_and_found(ctx, 0);
 
+#ifdef HAVE_PTHREAD
+	if (ctx->global_ctx) {
+		if (ctx->options & E2F_OPT_DEBUG &&
+		    ctx->options & E2F_OPT_MULTITHREAD)
+			fprintf(stderr, "thread %d jumping to group %d\n",
+					ctx->thread_info.et_thread_index,
+					ctx->thread_info.et_group_start);
+		pctx.errcode = ext2fs_inode_scan_goto_blockgroup(scan,
+					ctx->thread_info.et_group_start);
+		if (pctx.errcode) {
+			fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			goto endit;
+		}
+	}
+#endif
+
 	while (1) {
 		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
 			if (e2fsck_mmp_update(fs))
@@ -1432,6 +1449,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
 			continue;
 		}
+		if (pctx.errcode == EXT2_ET_SCAN_FINISHED)
+			break;
 		if (pctx.errcode &&
 		    pctx.errcode != EXT2_ET_INODE_CSUM_INVALID &&
 		    pctx.errcode != EXT2_ET_INODE_IS_GARBAGE) {
@@ -2211,12 +2230,14 @@ static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context,
 	return 0;
 }
 
-static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
+static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
+					     int thread_index)
 {
 	errcode_t retval;
 	e2fsck_t thread_context;
 	ext2_filsys thread_fs;
 	ext2_filsys global_fs = global_ctx->fs;
+	struct e2fsck_thread *tinfo;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2252,8 +2273,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_fs;
 	}
 
-	thread_context->thread_index = 0;
+	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
+
+	assert(thread_index == 0);
+	tinfo = &thread_context->thread_info;
+	tinfo->et_group_start = 0;
+	tinfo->et_group_next = 0;
+	tinfo->et_group_end = thread_fs->group_desc_count;
+
 	*thread_ctx = thread_context;
 	return 0;
 out_fs:
@@ -2495,7 +2523,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
-		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx, i);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
@@ -2580,6 +2608,7 @@ static errcode_t scan_callback(ext2_filsys fs,
 {
 	struct scan_callback_struct *scan_struct;
 	e2fsck_t ctx;
+	struct e2fsck_thread *tinfo;
 
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
@@ -2591,6 +2620,15 @@ static errcode_t scan_callback(ext2_filsys fs,
 				    ctx->fs->group_desc_count))
 			return EXT2_ET_CANCEL_REQUESTED;
 
+#ifdef HAVE_PTHREAD
+	if (ctx->global_ctx) {
+		tinfo = &ctx->thread_info;
+		tinfo->et_group_next++;
+		if (tinfo->et_group_next >= tinfo->et_group_end)
+			return EXT2_ET_SCAN_FINISHED;
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 6ad6fb84..d5452441 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1309,6 +1309,11 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Orphan file @i %i is not in use, but contains data.  "),
 	  PROMPT_CLEAR, PR_PREEN_OK },
 
+	/* Failed to goto block group */
+	{ PR_1_SCAN_GOTO,
+	  N_("failed to goto block group"),
+          PROMPT_NONE, PR_FATAL, 0, 0, 0 },
+
 	/* Pass 1b errors */
 
 	/* Pass 1B: Rescan for duplicate/bad blocks */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index b47b0c63..a6207428 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -734,6 +734,9 @@ struct problem_context {
 /* Orphan file inode is not in use, but contains data */
 #define PR_1_ORPHAN_FILE_NOT_CLEAR		0x010090
 
+/* Failed to goto block group */
+#define PR_1_SCAN_GOTO				0x0100A0
+
 /*
  * Pass 1b errors
  */
diff --git a/lib/ext2fs/ext2_err.et.in b/lib/ext2fs/ext2_err.et.in
index de140198..b8f45ae2 100644
--- a/lib/ext2fs/ext2_err.et.in
+++ b/lib/ext2fs/ext2_err.et.in
@@ -557,4 +557,7 @@ ec	EXT2_ET_EXTENT_CYCLE,
 ec	EXT2_ET_EXTERNAL_JOURNAL_NOSUPP,
 	"Operation not supported on an external journal"
 
+ec	EXT2_ET_SCAN_FINISHED,
+	"Scanning finished"
+
 	end
-- 
2.37.3

