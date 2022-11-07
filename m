Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B314761F33C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiKGMah (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiKGM2v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:51 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BC3A2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y4so10922189plb.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqRhkkJs9Imy/9nsxcxcZAJBsG1Q3o+zeup0dYMht2E=;
        b=fdfk6xNaeigJgyGy7UPfMxTfsFtyH/VLyd01sjuRzJ7W0WNkLUNFTq7ixU36Uk4Qbs
         tobR2bf5DIlvDJZgAKRflcGDAa2RrOiFTvSsBhuHPyyz6gPwYlvtRSVp168VdDS7o6ZG
         tXySCbOiCm2rU+O3UikTeN7fC1/M8LpTDnp4u8u6FozpRVj91Q0G6BDQ/g42vuFCnpYK
         ZQrgxHM2jjMwacFlQ168x9VXKnBUgzgq91ahnbvEgKYjG3zTNsqmzpcnXoA6RjIqebNR
         YAea0KykuCs9oIpdAvesvyeP0Jp2ZoQbaMn8qyNUmyNGwKt9ODgOvqRp90vKmbFAv+k9
         LrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqRhkkJs9Imy/9nsxcxcZAJBsG1Q3o+zeup0dYMht2E=;
        b=x8GZ/vc6gvk/4MZJ9mXPsb0Bs+tJmm4yahlyAP0Fe2JkecAgYuEAOFiB843ImIr6rE
         GwYTERBOuAWocuVqVYFpzwqUyf0kUx+zD1JAvBV+r2uB533novz08SsdabycdHAodzsQ
         f7vd1zIVQNwnA1xWs/hVxO67JlH5oQ0N/DvYs8qpwiurtFG+cuZI5HV75Cogo8l2x+jk
         UVXJ/aVhLl/IcaUmQVk3SeJrZihbo6GeAv2ynYYW+spsLAyz+vMgvNJcJau8OKDZzTVO
         i+qn0T1hag+VzFAAb/V/42wk3wLWlqD0HKZhq23RKUQFFzDJ/jrM9yfRTEnD0RK3vdr1
         yq2g==
X-Gm-Message-State: ACrzQf1fzn9J1xvZIsFMBmxRsSXPqDImXJ7yQXhyNfcBSH+VzsjBS6KI
        6ZzP+dIAPpDGzk6zVCvtJmk=
X-Google-Smtp-Source: AMsMyM7fJgRpWEiLg63aomqdCeiHOSifjzgOwxsq21ruAg2fc4P0PvjzEMS8/0hZ5NWS8irjdDn4Lg==
X-Received: by 2002:a17:903:2289:b0:187:21f6:fdea with SMTP id b9-20020a170903228900b0018721f6fdeamr41706160plh.120.1667824130457;
        Mon, 07 Nov 2022 04:28:50 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a104800b002137d3da760sm6017506pjd.39.2022.11.07.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:49 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Andreas Dilger <adilger@whamcloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 63/72] e2fsck: misc cleanups for pfsck
Date:   Mon,  7 Nov 2022 17:51:51 +0530
Message-Id: <59a08a01fd7e24b8fe9341d647510f55389f951d.1667822612.git.ritesh.list@gmail.com>
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

From: Andreas Dilger <adilger@whamcloud.com>

Add -m option description to e2fsck.8 man page.

Rename e2fsck_struct fs_num_threads to pfs_num_threads to avoid
confusion with the ext2_filsys fs_num_threads field, and move
thread_info to be together with the other HAVE_PTHREAD fields.

Move ext2_filsys fs_num_threads to fit into the __u16 "pad" field
to avoid consuming one of the few remaining __u32 reserved fields.

Fix a few print format warnings.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.8.in |  8 +++++++-
 e2fsck/e2fsck.h    | 13 +++++--------
 e2fsck/pass1.c     | 20 +++++++++++---------
 e2fsck/unix.c      |  4 ++--
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/e2fsck/e2fsck.8.in b/e2fsck/e2fsck.8.in
index dc6a5856..37dc8936 100644
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
@@ -333,6 +333,12 @@ Set the bad blocks list to be the list of blocks specified by
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
 Open the file system read-only, and assume an answer of `no' to all
 questions.  Allows
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2dd7ba27..33866316 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -277,8 +277,8 @@ struct e2fsck_thread {
 	dgrp_t		et_group_next;
 	/* Scanned inode number */
 	ext2_ino_t	et_inode_number;
-	char		et_log_buf[2048];
 	char		et_log_length;
+	char		et_log_buf[2048];
 };
 #endif
 
@@ -367,11 +367,6 @@ struct e2fsck_struct {
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
 
-	/* if @global_ctx is null, this field is unused */
-#ifdef HAVE_PTHREAD
-	struct e2fsck_thread	 thread_info;
-#endif
-
 	/*
 	 * Location of the lost and found directory
 	 */
@@ -487,7 +482,9 @@ struct e2fsck_struct {
 	char *undo_file;
 
 #ifdef HAVE_PTHREAD
-	__u32			 fs_num_threads;
+	/* if @global_ctx is null, this field is unused */
+	struct e2fsck_thread	 thread_info;
+	__u32			 pfs_num_threads;
 	__u32			 mmp_update_thread;
 	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
@@ -732,7 +729,7 @@ void check_resize_inode(e2fsck_t ctx);
 int check_init_orphan_file(e2fsck_t ctx);
 
 /* util.c */
-#define E2FSCK_MAX_THREADS	(65536)
+#define E2FSCK_MAX_THREADS	(65535)
 extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 				    const char *description);
 extern int ask(e2fsck_t ctx, const char * string, int def);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d745699d..8a6cdd8f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1265,7 +1265,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 {
 	unsigned flexbg_size = 1;
 	ext2_filsys fs = ctx->fs;
-	int num_threads = ctx->fs_num_threads;
+	int num_threads = ctx->pfs_num_threads;
 	int max_threads;
 
 	if (num_threads < 1) {
@@ -1285,6 +1285,8 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 	max_threads = fs->group_desc_count / flexbg_size;
 	if (max_threads == 0)
 		max_threads = 1;
+	if (max_threads > E2FSCK_MAX_THREADS)
+		max_threads = E2FSCK_MAX_THREADS;
 
 	if (num_threads > max_threads) {
 		fprintf(stderr, "Use max possible thread num: %d instead\n",
@@ -1292,7 +1294,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 		num_threads = max_threads;
 	}
 out:
-	ctx->fs_num_threads = num_threads;
+	ctx->pfs_num_threads = num_threads;
 	ctx->fs->fs_num_threads = num_threads;
 }
 #endif
@@ -1320,7 +1322,7 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 
 #ifdef HAVE_PTHREAD
 	/* don't use more than 1/10 of memory for threads checking */
-	readahead_kb = get_memory_size() / (10 * ctx->fs_num_threads);
+	readahead_kb = get_memory_size() / (10 * ctx->pfs_num_threads);
 	/* maybe better disable RA if this is too small? */
 	if (ctx->readahead_kb > readahead_kb)
 		ctx->readahead_kb = readahead_kb;
@@ -1378,7 +1380,7 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 #ifdef	HAVE_PTHREAD
 	pthread_rwlock_init(&ctx->fs_fix_rwlock, NULL);
 	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
-	if (ctx->fs_num_threads > 1)
+	if (ctx->pfs_num_threads > 1)
 		ctx->fs_need_locking = 1;
 	else
 		ctx->fs_need_locking = 0;
@@ -1659,7 +1661,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	if (ctx->global_ctx) {
 		if (ctx->options & E2F_OPT_DEBUG &&
 		    ctx->options & E2F_OPT_MULTITHREAD)
-			fprintf(stderr, "thread %d jumping to group %d\n",
+			fprintf(stderr, "thread %d jumping to group %u\n",
 					ctx->thread_info.et_thread_index,
 					ctx->thread_info.et_group_start);
 		pctx.errcode = ext2fs_inode_scan_goto_blockgroup(scan,
@@ -3064,7 +3066,7 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 	errcode_t ret = 0;
 	int i;
 	struct e2fsck_thread_info *pinfo;
-	int num_threads = global_ctx->fs_num_threads;
+	int num_threads = global_ctx->pfs_num_threads;
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
@@ -3130,7 +3132,7 @@ static void *e2fsck_pass1_thread(void *arg)
 out:
 	if (thread_ctx->options & E2F_OPT_MULTITHREAD)
 		log_out(thread_ctx,
-			_("Scanned group range [%lu, %lu), inodes %lu\n"),
+			_("Scanned group range [%u, %u), inodes %u\n"),
 			thread_ctx->thread_info.et_group_start,
 			thread_ctx->thread_info.et_group_end,
 			thread_ctx->thread_info.et_inode_number);
@@ -3156,7 +3158,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	int i;
 	e2fsck_t thread_ctx;
 	dgrp_t average_group;
-	int num_threads = global_ctx->fs_num_threads;
+	int num_threads = global_ctx->pfs_num_threads;
 #ifdef DEBUG_THREADS
 	struct e2fsck_thread_debug thread_debug =
 		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
@@ -3259,7 +3261,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 	if (retval)
 		return;
 #ifdef HAVE_PTHREAD
-	if (ctx->options & E2F_OPT_MULTITHREAD || ctx->fs_num_threads > 1)
+	if (ctx->options & E2F_OPT_MULTITHREAD || ctx->pfs_num_threads > 1)
 		e2fsck_pass1_multithread(ctx);
 	else
 #endif
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index dfa3f897..461ab8cb 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -915,12 +915,12 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
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
-- 
2.37.3

