Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D033C498
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhCORhs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhCORhb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F73C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bt4so9191749pjb.5
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmlsdQ4f+sTpe2XR9Vu0t08ZjLZ95HGssXEQMJAEsJg=;
        b=PpJ0ILVzhx5oDwYSS37NB+kHd73hRn/wspvUgZP2aP8oc16/nRTo4eI2mKclMs8AlE
         KKtch0CegAOWg7XSiUpsexc4uaTa8QTZv4lNVqTAl3szTtYQqGu2u+rFPmFUde+KbPka
         RnSHTL+iqPSr6Iz82mKLEoPENgPP5k1cGfuN5NqmhAruaNU6CjNcVBmbV8xLDsbH0x5s
         hsk7/jzujB4NX95Bk3avobI4djf3NYaYcpGOR/VDg1KubGRFwqlA1Ej8vJpE8i4DH4nH
         NROpOEJhESpbJ+hEGcCxENKAHjJH4jcpYh/s3aTqjz5cDJgVz2NUfS2OCiSf4CnlHXh3
         WfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmlsdQ4f+sTpe2XR9Vu0t08ZjLZ95HGssXEQMJAEsJg=;
        b=itvi2DnAwtoBhBb592v/S6QNWN3Igvr+5BZn09pvXTMQMC/eW5YO6qqEKY3U+gfgm/
         JjGBqFCxH9AcoZhFBa+WnlXvCYmHeZat1OW7W3EINl3mmyjvKogveY5Bg685FpAmcIEg
         oMRJ+YEhAwkwZPYSVQAAtfoUcEsYzSKqMcPi9ucIWQF1hxewU5SAWJl4QdJkdYgf8b1r
         juxE4zRL37E36KbcLMuTaW6TtFbDd9PIHzATRNN9jc/ZZ5MblIEG1ifJpPzU5BilmHG1
         3HCVRFh6KC76+o9IFZAvO8slMT8wv+ZyhTF9wnAg83INVkNRDl6ZF2FvfeHS8zDyhFid
         Ee5Q==
X-Gm-Message-State: AOAM5331AdczXsKL3AIIntuBSfwfFeGZi/RW00mMeymaloQtLZHReewg
        4bCldKeaCiwMW34GaQvxXKMSncuiWoM=
X-Google-Smtp-Source: ABdhPJzfWR7OwOuVx1/5w7hKLm+VIgLjf2NPBDNOWL1X+x30sS/UPe4ZLBlCVCWHK525nSLqIyddCA==
X-Received: by 2002:a17:90a:7182:: with SMTP id i2mr167715pjk.111.1615829850249;
        Mon, 15 Mar 2021 10:37:30 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:29 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 2/6] ext4: add ability to return parsed options from parse_options
Date:   Mon, 15 Mar 2021 10:37:12 -0700
Message-Id: <20210315173716.360726-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Before this patch, the function parse_options() was returning
journal_devnum and journal_ioprio variables to the caller. This patch
generalizes that interface to allow parse_options to return any parsed
options to return back to the caller. In this patch series, it gets
used to capture the value of "mb_optimize_scan=%u" mount option.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/super.c | 50 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 071d131fadd8..0491e7a6b04c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2089,9 +2089,14 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 	return 1;
 }
 
+struct ext4_parsed_options {
+	unsigned long journal_devnum;
+	unsigned int journal_ioprio;
+};
+
 static int handle_mount_opt(struct super_block *sb, char *opt, int token,
-			    substring_t *args, unsigned long *journal_devnum,
-			    unsigned int *journal_ioprio, int is_remount)
+			    substring_t *args, struct ext4_parsed_options *parsed_opts,
+			    int is_remount)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	const struct mount_opts *m;
@@ -2248,7 +2253,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 				 "Cannot specify journal on remount");
 			return -1;
 		}
-		*journal_devnum = arg;
+		parsed_opts->journal_devnum = arg;
 	} else if (token == Opt_journal_path) {
 		char *journal_path;
 		struct inode *journal_inode;
@@ -2284,7 +2289,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			return -1;
 		}
 
-		*journal_devnum = new_encode_dev(journal_inode->i_rdev);
+		parsed_opts->journal_devnum = new_encode_dev(journal_inode->i_rdev);
 		path_put(&path);
 		kfree(journal_path);
 	} else if (token == Opt_journal_ioprio) {
@@ -2293,7 +2298,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 				 " (must be 0-7)");
 			return -1;
 		}
-		*journal_ioprio =
+		parsed_opts->journal_ioprio =
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, arg);
 	} else if (token == Opt_test_dummy_encryption) {
 		return ext4_set_test_dummy_encryption(sb, opt, &args[0],
@@ -2410,8 +2415,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 }
 
 static int parse_options(char *options, struct super_block *sb,
-			 unsigned long *journal_devnum,
-			 unsigned int *journal_ioprio,
+			 struct ext4_parsed_options *ret_opts,
 			 int is_remount)
 {
 	struct ext4_sb_info __maybe_unused *sbi = EXT4_SB(sb);
@@ -2431,8 +2435,8 @@ static int parse_options(char *options, struct super_block *sb,
 		 */
 		args[0].to = args[0].from = NULL;
 		token = match_token(p, tokens, args);
-		if (handle_mount_opt(sb, p, token, args, journal_devnum,
-				     journal_ioprio, is_remount) < 0)
+		if (handle_mount_opt(sb, p, token, args, ret_opts,
+				     is_remount) < 0)
 			return 0;
 	}
 #ifdef CONFIG_QUOTA
@@ -4014,7 +4018,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_fsblk_t sb_block = get_sb_block(&data);
 	ext4_fsblk_t logical_sb_block;
 	unsigned long offset = 0;
-	unsigned long journal_devnum = 0;
 	unsigned long def_mount_opts;
 	struct inode *root;
 	const char *descr;
@@ -4025,8 +4028,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	int needs_recovery, has_huge_files;
 	__u64 blocks_count;
 	int err = 0;
-	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	ext4_group_t first_not_zeroed;
+	struct ext4_parsed_options parsed_opts;
+
+	/* Set defaults for the variables that will be set during parsing */
+	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+	parsed_opts.journal_devnum = 0;
 
 	if ((data && !orig_data) || !sbi)
 		goto out_free_base;
@@ -4272,8 +4279,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 					      GFP_KERNEL);
 		if (!s_mount_opts)
 			goto failed_mount;
-		if (!parse_options(s_mount_opts, sb, &journal_devnum,
-				   &journal_ioprio, 0)) {
+		if (!parse_options(s_mount_opts, sb, &parsed_opts, 0)) {
 			ext4_msg(sb, KERN_WARNING,
 				 "failed to parse options in superblock: %s",
 				 s_mount_opts);
@@ -4281,8 +4287,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(s_mount_opts);
 	}
 	sbi->s_def_mount_opt = sbi->s_mount_opt;
-	if (!parse_options((char *) data, sb, &journal_devnum,
-			   &journal_ioprio, 0))
+	if (!parse_options((char *) data, sb, &parsed_opts, 0))
 		goto failed_mount;
 
 #ifdef CONFIG_UNICODE
@@ -4773,7 +4778,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * root first: it may be modified in the journal!
 	 */
 	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
-		err = ext4_load_journal(sb, es, journal_devnum);
+		err = ext4_load_journal(sb, es, parsed_opts.journal_devnum);
 		if (err)
 			goto failed_mount3a;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
@@ -4873,7 +4878,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount_wq;
 	}
 
-	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
+	set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
 
 	sbi->s_journal->j_submit_inode_data_buffers =
 		ext4_journal_submit_inode_data_buffers;
@@ -5808,13 +5813,15 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	struct ext4_mount_options old_opts;
 	int enable_quota = 0;
 	ext4_group_t g;
-	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	int err = 0;
 #ifdef CONFIG_QUOTA
 	int i, j;
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
 	char *orig_data = kstrdup(data, GFP_KERNEL);
+	struct ext4_parsed_options parsed_opts;
+
+	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 
 	if (data && !orig_data)
 		return -ENOMEM;
@@ -5845,7 +5852,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			old_opts.s_qf_names[i] = NULL;
 #endif
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
-		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
+		parsed_opts.journal_ioprio =
+			sbi->s_journal->j_task->io_context->ioprio;
 
 	/*
 	 * Some options can be enabled by ext4 and/or by VFS mount flag
@@ -5855,7 +5863,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
 	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
 
-	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
+	if (!parse_options(data, sb, &parsed_opts, 1)) {
 		err = -EINVAL;
 		goto restore_opts;
 	}
@@ -5905,7 +5913,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 
 	if (sbi->s_journal) {
 		ext4_init_journal_params(sb, sbi->s_journal);
-		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
+		set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
 	}
 
 	/* Flush outstanding errors before changing fs state */
-- 
2.31.0.rc2.261.g7f71774620-goog

