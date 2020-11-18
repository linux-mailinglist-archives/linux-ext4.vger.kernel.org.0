Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69D22B80F9
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKRPmR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgKRPmQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:16 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF3C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x3so1394461plr.23
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AMvkoRCCFsGkzkWRSSMZqjAs0Ax8qqFNLPWjD1f+sNw=;
        b=iy4Qkr6EoAiNyRhnNHcSQ8doFB7RbZkzRIPB8Q8eMYW0H0JvRBY33yM4YQi1OI7JFI
         JW2DSL9r3ApKhdi3miEts3JlxH8IK2H0hkALlusotTGYAVKzvWS92URa4FzlWrj8UilW
         LzaH9zUkhbhkeyijUrT8oUmMliGwSjL/wU0JkW2roi/xlidnuZtCk/G6xqU2EwM4AXjh
         zku3a/8PRXlsARQKyj+2h5U4v0jXyx+8DVHI/dhvg1zpGU0ZMLOL1t4ATLPt23vvGNXC
         4d/RXTL9saE8KxasXojlvrLjOfpkb87RANlqNhAWBwIYMGgapLitr45PM/FwGD22TpJa
         Kfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AMvkoRCCFsGkzkWRSSMZqjAs0Ax8qqFNLPWjD1f+sNw=;
        b=uVyxJxG8rErsLzhp2FbozhnNo8Vqjrv54+cspPB0WrZXUxJbTzlM1Iq8aFk1dC9RkT
         E8BhSkwTARt4eiJ1PGsl71ly31sHEW3NXqZ2HxkhYJq89/iALtMOzJ+OjBDSOthcHMUB
         q9xCvkLbUBs3O21BzztVxe5hWwJXqHgifFKz3vbKFa8b21rFkdnHaacl4rwhhVrVdjrw
         uRryzBQ/SMEK4XaA0WFnk8bpxzdtR1fq8+JMJl89FBqwU51Fg8vsYg5HwDEhnqMlrR7B
         3BLbkA1SyLjq082p52WHr+tzbxANGTvgzzyrJ/AIUbDVhRvWK6J7cWpYuFDF7TIb5zgL
         GxLw==
X-Gm-Message-State: AOAM532eRYpukw52cRXxVbFeP0KAz1AvPtEjJw/1CzjFeUxrvPBuaxPR
        ZtsrpihTnHAGHKVtq/Sexb+zIgHmjLcW+ZHeq8v9QECn2DXAAJqxRKLjrqpkMbtdecyryUFuQr6
        cj7jrtJ9S0NiPAmYVUurT1ja5SFFt0SVSsouRtAfE0cx2PZTctGRjwmcWDdhQx2yLKsq8HsWfO0
        i7gCU+jrM=
X-Google-Smtp-Source: ABdhPJyVh9uMShOsIHfe1dTVvxanWom7kNQC+sl1JieTodHNDva4ORcld6NONW6b/8sCJnuMH43dyLxb/FeJOUs8YSk=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:b613:b029:d9:56e:d93c with
 SMTP id b19-20020a170902b613b02900d9056ed93cmr4972664pls.14.1605714135181;
 Wed, 18 Nov 2020 07:42:15 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:44 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-59-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 58/61] e2fsck: misc cleanups for pfsck
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Andreas Dilger <adilger@whamcloud.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andreas Dilger <adilger@whamcloud.com>

Add -m option description to e2fsck.8 man page.

Rename e2fsck_struct fs_num_threads to pfs_num_threads to avoid
confusion with the ext2_filsys fs_num_threads field, and move
thread_info to be together with the other CONFIG_PFSCK fields.

Move ext2_filsys fs_num_threads to fit into the __u16 "pad" field
to avoid consuming one of the few remaining __u32 reserved fields.

Fix a few print format warnings.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.8.in  |  8 +++++++-
 e2fsck/e2fsck.h     | 13 +++++--------
 e2fsck/pass1.c      | 29 +++++++++++++++--------------
 e2fsck/unix.c       |  4 ++--
 lib/ext2fs/ext2fs.h |  5 ++---
 5 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
index 4e3890b2..404d07fe 100644
--- a/e2fsck/e2fsck.8.in
+++ b/e2fsck/e2fsck.8.in
@@ -8,7 +8,7 @@ e2fsck \- check a Linux ext2/ext3/ext4 file system
 .SH SYNOPSIS
 .B e2fsck
 [
-.B \-pacnyrdfkvtDFV
+.B \-pacnyrdfkmvtDFV
 ]
 [
 .B \-b
@@ -329,6 +329,12 @@ Set the bad blocks list to be the list of blocks specified by
 option, except the bad blocks list is cleared before the blocks listed
 in the file are added to the bad blocks list.)
 .TP
+.B \-m " threads"
+Run e2fsck with up to the specified number of
+.IR threads .
+The actual number of threads may be lower, if the filesystem does not
+have enough block groups to effectively parallelize the workload.
+.TP
 .B \-n
 Open the filesystem read-only, and assume an answer of `no' to all
 questions.  Allows
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 1469c3e1..362e128c 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -243,8 +243,8 @@ struct e2fsck_thread {
 	dgrp_t		et_group_next;
 	/* Scanned inode number */
 	ext2_ino_t	et_inode_number;
-	char		et_log_buf[2048];
 	char		et_log_length;
+	char		et_log_buf[2048];
 };
 #endif
 
@@ -333,11 +333,6 @@ struct e2fsck_struct {
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
 
-	/* if @global_ctx is null, this field is unused */
-#ifdef CONFIG_PFSCK
-	struct e2fsck_thread	 thread_info;
-#endif
-
 	/*
 	 * Location of the lost and found directory
 	 */
@@ -450,7 +445,9 @@ struct e2fsck_struct {
 	/* Undo file */
 	char *undo_file;
 #ifdef CONFIG_PFSCK
-	__u32			 fs_num_threads;
+	/* if @global_ctx is null, this field is unused */
+	struct e2fsck_thread	 thread_info;
+	__u32			 pfs_num_threads;
 	__u32			 mmp_update_thread;
 	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
@@ -689,7 +686,7 @@ int check_backup_super_block(e2fsck_t ctx);
 void check_resize_inode(e2fsck_t ctx);
 
 /* util.c */
-#define E2FSCK_MAX_THREADS	(65536)
+#define E2FSCK_MAX_THREADS	(65535)
 extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 				    const char *description);
 extern int ask(e2fsck_t ctx, const char * string, int def);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7768119b..8d4e2675 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1260,7 +1260,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 {
 	unsigned flexbg_size = 1;
 	ext2_filsys fs = ctx->fs;
-	int num_threads = ctx->fs_num_threads;
+	int num_threads = ctx->pfs_num_threads;
 	int max_threads;
 
 	if (num_threads < 1) {
@@ -1280,6 +1280,8 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 	max_threads = fs->group_desc_count / flexbg_size;
 	if (max_threads == 0)
 		max_threads = 1;
+	if (max_threads > E2FSCK_MAX_THREADS)
+		max_threads = E2FSCK_MAX_THREADS;
 
 	if (num_threads > max_threads) {
 		fprintf(stderr, "Use max possible thread num: %d instead\n",
@@ -1287,7 +1289,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 		num_threads = max_threads;
 	}
 out:
-	ctx->fs_num_threads = num_threads;
+	ctx->pfs_num_threads = num_threads;
 	ctx->fs->fs_num_threads = num_threads;
 }
 #endif
@@ -1315,7 +1317,7 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 
 #ifdef CONFIG_PFSCK
 	/* don't use more than 1/10 of memory for threads checking */
-	readahead_kb = get_memory_size() / (10 * ctx->fs_num_threads);
+	readahead_kb = get_memory_size() / (10 * ctx->pfs_num_threads);
 	/* maybe better disable RA if this is too small? */
 	if (ctx->readahead_kb > readahead_kb)
 		ctx->readahead_kb = readahead_kb;
@@ -1373,7 +1375,7 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 #ifdef	CONFIG_PFSCK
 	pthread_rwlock_init(&ctx->fs_fix_rwlock, NULL);
 	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
-	if (ctx->fs_num_threads > 1)
+	if (ctx->pfs_num_threads > 1)
 		ctx->fs_need_locking = 1;
 #endif
 
@@ -1633,7 +1635,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	if (ctx->global_ctx) {
 		if (ctx->options & E2F_OPT_DEBUG &&
 		    ctx->options & E2F_OPT_MULTITHREAD)
-			fprintf(stderr, "thread %d jumping to group %d\n",
+			fprintf(stderr, "thread %d jumping to group %u\n",
 					ctx->thread_info.et_thread_index,
 					ctx->thread_info.et_group_start);
 		pctx.errcode = ext2fs_inode_scan_goto_blockgroup(scan,
@@ -3129,11 +3131,11 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 				     e2fsck_t global_ctx)
 {
-	errcode_t			 rc;
-	errcode_t			 ret = 0;
-	int				 i;
-	struct e2fsck_thread_info	*pinfo;
-	int				 num_threads = global_ctx->fs_num_threads;
+	errcode_t rc;
+	errcode_t ret = 0;
+	struct e2fsck_thread_info *pinfo;
+	int num_threads = global_ctx->pfs_num_threads;
+	int i;
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
@@ -3199,7 +3201,7 @@ static void *e2fsck_pass1_thread(void *arg)
 out:
 	if (thread_ctx->options & E2F_OPT_MULTITHREAD)
 		log_out(thread_ctx,
-			_("Scanned group range [%lu, %lu), inodes %lu\n"),
+			_("Scanned group range [%u, %u), inodes %u\n"),
 			thread_ctx->thread_info.et_group_start,
 			thread_ctx->thread_info.et_group_end,
 			thread_ctx->thread_info.et_inode_number);
@@ -3225,7 +3227,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	int				 i;
 	e2fsck_t			 thread_ctx;
 	dgrp_t				 average_group;
-	int				 num_threads = global_ctx->fs_num_threads;
+	int num_threads = global_ctx->pfs_num_threads;
 #ifdef DEBUG_THREADS
 	struct e2fsck_thread_debug	 thread_debug =
 		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
@@ -3329,8 +3331,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 	if (retval)
 		return;
 #ifdef CONFIG_PFSCK
-	if (ctx->fs_num_threads > 1 ||
-	    ctx->options & E2F_OPT_MULTITHREAD) {
+	if (ctx->pfs_num_threads > 1 || ctx->options & E2F_OPT_MULTITHREAD) {
 		need_single = 0;
 		e2fsck_pass1_multithread(ctx);
 	}
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index cd31bcd5..bebc19ed 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -908,12 +908,12 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 					_("Invalid multiple thread num.\n"));
 			if (thread_num > E2FSCK_MAX_THREADS) {
 				fprintf(stderr,
-					_("threads %lu too large (max %lu)\n"),
+					_("threads %lu too large (max %u)\n"),
 					thread_num, E2FSCK_MAX_THREADS);
 				fatal_error(ctx, 0);
 			}
 			ctx->options |= E2F_OPT_MULTITHREAD;
-			ctx->fs_num_threads = thread_num;
+			ctx->pfs_num_threads = thread_num;
 			break;
 #endif
 		case 'n':
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 616c9412..f74303f4 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -254,12 +254,11 @@ struct struct_ext2_filsys {
 	time_t				now;
 	int				cluster_ratio_bits;
 	__u16				default_bitmap_type;
-	__u16				pad;
-	__u32				fs_num_threads;
+	__u16				fs_num_threads;
 	/*
 	 * Reserved for future expansion
 	 */
-	__u32				reserved[4];
+	__u32				reserved[5];
 
 	/*
 	 * Reserved for the use of the calling application.
-- 
2.29.2.299.gdc1121823c-goog

