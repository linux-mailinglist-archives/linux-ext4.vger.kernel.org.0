Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C92B80C9
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKRPks (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRPkr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E30AC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b25so2982507ybj.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ndvprwttcZ5SVlppQepEdUUybSw42we0bey0lTA9TnU=;
        b=Zw4vY3dSfMfuiDwvS26yWBK+Ej8+Puc5hlbu8oGoU/jJMtL1sYqsQnV18lqqjfaqzy
         nfSX8rdwFHSRBWsqf8rzS2unmXI7ruqD9zQEvH/RxqjDcwKxld82KX9CjMHyEx70oIGv
         Twu3TrxInqe4qIoA+kJ+TTMXcy04uFF+nkHnAqj6Cetr91fvLpuWBXpb/zsTPJ+MI3ue
         ZozaVf/SvE6o5/kIBX6Daz3IhO7S3YicxVt3Nie/83BShmF65tk/lmFNuzRIzyr1Yd1p
         DYgbXG7trDkLNlgkLitTKlfKa6PjJkVn79JNZtldIP+WkzH/1pTHMwUSWI57MpeewSRP
         Uqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ndvprwttcZ5SVlppQepEdUUybSw42we0bey0lTA9TnU=;
        b=YcTLWeMNO+h0dwcoU+jlCmIz+XP4JEiS3jxYr4xYG1im439yvSb152iHFg8nYndBcg
         UV4x6JGuTc9s+buAdXBMSvjSmPpg26dJRX2sxP46rVzuXV+9PcGF6jI4azKftcHW49Xq
         pm2zDrpv8hVF4Ny1M+PZ6peR60QnlwjXDi8QHBlF9xgdq4NwutO/EUJS/TYDgMpiOZuK
         qKDQZNasQAkfW48JIHIR1N1+HePs95sPeMXrG6gagZjip6QgGQ4PSmjWxYCFMIQdflAP
         y0qhVM4yhyB5Dm3zNvDmj4Ys44K4/VxwDOhjbnLRmocDtQmA/lFBuf1czYIXNI9oYoSw
         Fj0A==
X-Gm-Message-State: AOAM5326q/PRX86JpRmPDk78SDIYpM9vCrgu/9J5cJpiDeZ5Hdk6kfaB
        k6W1c0sG+/QsielYLfiLk0MgZEzQotR9Y91p8pCr4W5b6tjvIeeUp3yOQN02U6K294NFFAZhBip
        w8eAmv4rntvKShh5eG6bBU4I5MWW+IQtz7A4r/IY6jOeCgF/vR1mR6ZtPJg7Cs0TCYzyliFcCAr
        7C24sIB38=
X-Google-Smtp-Source: ABdhPJzmhfTKOFuSUM3NRcKpKPF5Iuqy4Qe8surkVhih7nJ/9VSsEHs9X24I939sXAN0kSx66g5j9iZvx4lr+lZZSMM=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:7444:: with SMTP id
 p65mr6512909ybc.149.1605714046371; Wed, 18 Nov 2020 07:40:46 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:57 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-12-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 11/61] e2fsck: add start/end group for thread
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

When multi-threads are used for check, each thread needs to jump
to different group in pass1 check. This patch adds the group
jumping support. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h           | 23 ++++++++++++++++--
 e2fsck/logfile.c          |  3 ++-
 e2fsck/pass1.c            | 51 +++++++++++++++++++++++++++++++++------
 e2fsck/problem.c          |  5 ++++
 e2fsck/problem.h          |  3 +++
 lib/ext2fs/ext2_err.et.in |  3 +++
 6 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index ccb66ae7..ba1af6bf 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -227,6 +227,22 @@ typedef struct e2fsck_struct *e2fsck_t;
 
 #define MAX_EXTENT_DEPTH_COUNT 5
 
+#ifdef CONFIG_PFSCK
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
 	e2fsck_t		global_ctx;
@@ -310,8 +326,11 @@ struct e2fsck_struct {
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
-	/* Thread index, if global_ctx is null, this field is unused */
-	int			thread_index;
+
+	/* if @global_ctx is null, this field is unused */
+#ifdef CONFIG_PFSCK
+	struct e2fsck_thread	 thread_info;
+#endif
 
 	/*
 	 * Location of the lost and found directory
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 8bda6b81..d177e4b5 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -312,7 +312,8 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 	expand_logfn(ctx, log_fn, &s);
 #ifdef CONFIG_PFSCK
 	if (ctx->global_ctx) {
-		sprintf(string_index, "%d", ctx->thread_index);
+		sprintf(string_index, "%d",
+			ctx->thread_info.et_thread_index);
 		append_string(&s, ".", 1);
 		append_string(&s, string_index, 0);
 	}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 0d0fe366..bb32511f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1370,6 +1370,23 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	/* Set up ctx->lost_and_found if possible */
 	(void) e2fsck_get_lost_and_found(ctx, 0);
 
+#ifdef CONFIG_PFSCK
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
@@ -1413,6 +1430,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
 			continue;
 		}
+		if (pctx.errcode == EXT2_ET_SCAN_FINISHED)
+			break;
 		if (pctx.errcode &&
 		    pctx.errcode != EXT2_ET_INODE_CSUM_INVALID &&
 		    pctx.errcode != EXT2_ET_INODE_IS_GARBAGE) {
@@ -2212,12 +2231,14 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	return retval;
 }
 
-static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
+static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
+					     int thread_index)
 {
-	errcode_t	retval;
-	e2fsck_t	thread_context;
-	ext2_filsys	thread_fs;
-	ext2_filsys	global_fs = global_ctx->fs;
+	errcode_t		retval;
+	e2fsck_t		thread_context;
+	ext2_filsys		thread_fs;
+	ext2_filsys		global_fs = global_ctx->fs;
+	struct e2fsck_thread	*tinfo;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2254,9 +2275,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	}
 	thread_fs->priv_data = thread_context;
 
-	thread_context->thread_index = 0;
+	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
 
+	assert(thread_index == 0);
+	tinfo = &thread_context->thread_info;
+	tinfo->et_group_start = 0;
+	tinfo->et_group_next = 0;
+	tinfo->et_group_end = thread_fs->group_desc_count;
+
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
@@ -2479,7 +2506,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
-		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx, i);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
@@ -2564,6 +2591,7 @@ static errcode_t scan_callback(ext2_filsys fs,
 {
 	struct scan_callback_struct *scan_struct;
 	e2fsck_t ctx;
+	struct e2fsck_thread *tinfo;
 
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
@@ -2575,6 +2603,15 @@ static errcode_t scan_callback(ext2_filsys fs,
 				    ctx->fs->group_desc_count))
 			return EXT2_ET_CANCEL_REQUESTED;
 
+#ifdef CONFIG_PFSCK
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
index e79c853b..22c2652c 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1269,6 +1269,11 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Encrypted @i %i has corrupt encryption @a.\n"),
 	  PROMPT_CLEAR_INODE, 0, 0, 0, 0 },
 
+	/* Failed to goto block group */
+	{ PR_1_SCAN_GOTO,
+	  N_("failed to goto block group"),
+          PROMPT_NONE, PR_FATAL, 0, 0, 0 },
+
 	/* Pass 1b errors */
 
 	/* Pass 1B: Rescan for duplicate/bad blocks */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 4185e517..e28adebb 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -707,6 +707,9 @@ struct problem_context {
 /* Encrypted inode has corrupt encryption extended attribute */
 #define PR_1_CORRUPT_ENCRYPTION_XATTR		0x01008B
 
+/* Failed to goto block group */
+#define PR_1_SCAN_GOTO				0x0100A0
+
 /*
  * Pass 1b errors
  */
diff --git a/lib/ext2fs/ext2_err.et.in b/lib/ext2fs/ext2_err.et.in
index 0c76fee6..cdb37423 100644
--- a/lib/ext2fs/ext2_err.et.in
+++ b/lib/ext2fs/ext2_err.et.in
@@ -548,4 +548,7 @@ ec	EXT2_ET_EA_INODE_CORRUPTED,
 ec	EXT2_ET_NO_GDESC,
 	"Group descriptors not loaded"
 
+ec	EXT2_ET_SCAN_FINISHED,
+	"Scanning finished"
+
 	end
-- 
2.29.2.299.gdc1121823c-goog

