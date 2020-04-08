Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73EC1A1EF7
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDHKqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42217 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgDHKqE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id g6so3140694pgs.9
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q7hmk7BP1ayFiCU/lJeIe+xT9L5cltDsdCDQDhW96gY=;
        b=ZCE137VILTJkgYYOE/9T6SqOyGR5TguITiqeOxICLIaYhoQOsGiW8y2g5OB4mXLYdU
         Bu1JP7UqC6nY23o0fiOfbayS/lgfgudCLYxz6gAQxGcXJp86kcdtB+zhNdDGELWO5sYF
         tdub+l13WL8nLsaESyXSx9fSYuc38i6OGZNysI3zheEW8U4OXVkF5c3NpVNN1axo8XhE
         8xfLVVkKMsxd6r6fNQSJWeGpjDn38XwPgjKaByQG/FAcfVId+NCy/r6xsLzZQI8k2szK
         5AHUt3ni5Wx/5wlRP5TwFIQhmBBQMqbSid4ipFxHt20Cz415NMJRyRlL4cHlHDGYsjmi
         YQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q7hmk7BP1ayFiCU/lJeIe+xT9L5cltDsdCDQDhW96gY=;
        b=fi68AVnjo/MfHncq3vBgjSgx9F8vvn36Hpu2n9iUaDtYu8mE/x5SnsmtlaEsq/NgRp
         lqHCNwIdXBgNWdNTUiqOvEU8cJhRysNJOSBMIfhn4/V8MG3Xlf7YR3rSt7PyfEiaKkE9
         aPFQqyxDj0xj6OSoD+40iZkMrKYhUJvEE+3HoZaTxnqu/4DYRI0pRPRcnb28oRY079G2
         pfSEHpOBZuHOKDYQPZF6zsr5vEzei0c8TbFDu8+hUXjsPKpGSqLWgxoAvYJwph/QrVdj
         1CHqAvNvrFhoXF1tr/91AEKrgAIIYOabMRv4PTQFtZEcBoQJO2yqlUPxDbKARMXE7XSm
         DXBQ==
X-Gm-Message-State: AGi0PuZ6TUB3SPWT9DmXBzzCMQub1Bmg0PtOnHgJCoOa1K6DZDMO7pc5
        PJqPyGV3zu1shCSYgq6i4i07wLGwvtQ=
X-Google-Smtp-Source: APiQypLEPlIe7inAqJtAOkH2XpH0Raj5Yv/PJTNgkwsrpLzavvRUnQrurOxDFbS0DUS+JbaJdD399A==
X-Received: by 2002:aa7:86d3:: with SMTP id h19mr7408085pfo.297.1586342760841;
        Wed, 08 Apr 2020 03:46:00 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:00 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 13/46] e2fsck: add start/end group for thread
Date:   Wed,  8 Apr 2020 19:44:41 +0900
Message-Id: <1586342714-12536-14-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

When multi-threads are used for check, each thread needs to jump
to different group in pass1 check. This patch adds the group
jumping support. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h           | 18 +++++++++++++--
 e2fsck/logfile.c          |  5 +++--
 e2fsck/pass1.c            | 46 +++++++++++++++++++++++++++++++++------
 e2fsck/problem.c          |  5 +++++
 e2fsck/problem.h          |  3 +++
 lib/ext2fs/ext2_err.et.in |  3 +++
 6 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 7e00648e..f42da58e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -227,6 +227,20 @@ typedef struct e2fsck_struct *e2fsck_t;
 
 #define MAX_EXTENT_DEPTH_COUNT 5
 
+/*
+ * Fields that used for multi-thread
+ */
+struct e2fsck_thread {
+	/* The start group number for this thread */
+	dgrp_t		et_group_start;
+	/* The end (not included) group number for this thread*/
+	dgrp_t		et_group_end;
+	/* The next group number to check */
+	dgrp_t		et_group_next;
+	/* Thread index */
+	int		et_thread_index;
+};
+
 struct e2fsck_struct {
 	/* ---- Following fields are never updated during the pass1 ---- */
 	/* Global context to get the cancel flag */
@@ -380,8 +394,8 @@ struct e2fsck_struct {
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
-	/* Thread index, if global_ctx is null, this field is useless */
-	int			thread_index;
+	/* if @global_ctx is null, this field is useless */
+	struct e2fsck_thread	 thread_info;
 
 	/*
 	 * Directory information
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 4e8de342..de0885e6 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -311,8 +311,9 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 
 	expand_logfn(ctx, log_fn, &s);
 	if (ctx->global_ctx) {
-		assert(ctx->thread_index < 1000);
-		sprintf(string_index, "%03d", ctx->thread_index);
+		assert(ctx->thread_info.et_thread_index < 1000);
+		sprintf(string_index, "%03d",
+			ctx->thread_info.et_thread_index);
 		append_string(&s, ".", 1);
 		append_string(&s, string_index, 0);
 	}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 890819f7..811d3991 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1378,6 +1378,19 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	/* Set up ctx->lost_and_found if possible */
 	(void) e2fsck_get_lost_and_found(ctx, 0);
 
+	if (ctx->global_ctx) {
+#if 0
+		printf("jumping to %d\n", ctx->thread_info.et_group_start);
+#endif
+		pctx.errcode = ext2fs_inode_scan_goto_blockgroup(scan,
+					ctx->thread_info.et_group_start);
+		if (pctx.errcode) {
+			fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			goto endit;
+		}
+	}
+
 	while (1) {
 		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
 			if (e2fsck_mmp_update(fs))
@@ -1429,6 +1442,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
 			continue;
 		}
+		if (pctx.errcode == EXT2_ET_SCAN_FINISHED)
+			break;
 		if (pctx.errcode &&
 		    pctx.errcode != EXT2_ET_INODE_CSUM_INVALID &&
 		    pctx.errcode != EXT2_ET_INODE_IS_GARBAGE) {
@@ -2302,12 +2317,15 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	return retval;
 }
 
-static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
+static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
+					     e2fsck_t *thread_ctx,
+					     int thread_index)
 {
-	errcode_t	retval;
-	e2fsck_t	thread_context;
-	ext2_filsys	thread_fs;
-	ext2_filsys	global_fs = global_ctx->fs;
+	errcode_t		 retval;
+	e2fsck_t		 thread_context;
+	ext2_filsys		 thread_fs;
+	ext2_filsys		 global_fs = global_ctx->fs;
+	struct e2fsck_thread	*tinfo;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2343,9 +2361,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
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
@@ -2505,7 +2529,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
-		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx, i);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
@@ -2584,6 +2608,7 @@ static errcode_t scan_callback(ext2_filsys fs,
 {
 	struct scan_callback_struct *scan_struct;
 	e2fsck_t ctx;
+	struct e2fsck_thread *tinfo;
 
 	scan_struct = (struct scan_callback_struct *) priv_data;
 	ctx = scan_struct->ctx;
@@ -2595,6 +2620,13 @@ static errcode_t scan_callback(ext2_filsys fs,
 				    ctx->fs->group_desc_count))
 			return EXT2_ET_CANCEL_REQUESTED;
 
+	if (ctx->global_ctx) {
+		tinfo = &ctx->thread_info;
+		tinfo->et_group_next++;
+		if (tinfo->et_group_next >= tinfo->et_group_end)
+			return EXT2_ET_SCAN_FINISHED;
+	}
+
 	return 0;
 }
 
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index c7c0ba98..23183db9 100644
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
index c7f65f6d..37cad7f8 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -707,6 +707,9 @@ struct problem_context {
 /* Encrypted inode has corrupt encryption extended attribute */
 #define PR_1_CORRUPT_ENCRYPTION_XATTR		0x01008B
 
+/* Failed to goto block group */
+#define PR_1_SCAN_GOTO				0x01008C
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
2.25.2

