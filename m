Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5534852F
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhCXXTh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbhCXXTe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 19:19:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CDC06174A
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v2so15863486pgk.11
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVNBv7IUj3D+f0SQ4ke1UYWivy34rQQaV2QBFPUrTMk=;
        b=JvF6skb+eBmVWBP6asEvE2lMecX/ahscHj1MWmGmc7pEht5Ip+CXTC4XBSwVSTEWgg
         /J/1ZatVgv4BTzM+fmloiVXR8MoVV5kkGwR8wX4i3JG8J0WlvRYx0RmejOQt80a97UaS
         PjLpWFVVGcpQpSKJAUZZMlRe9FxYX62beanDcJQG3/COVp/AnXx4XNEuKJYFH1Yf5CfU
         ZZz15Q2DKc7siEdRlyEKvBi3bTNUTmim7b7l1pyhcVHdQc4pVfAnV2zNIAwDk/0V2Y3w
         msEii0j3s5/0MV+XLs3ilIya0bPSjafPPvkqj/i9cUcuDfEgyKKHQF8HwCTMLvlx5fLW
         R+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVNBv7IUj3D+f0SQ4ke1UYWivy34rQQaV2QBFPUrTMk=;
        b=K39zmxA//9QacyWf404et01xONj8auSQd5RwzbF6NKozYFud3vkld/h2hdLzpGyT84
         UyYcP2FPeKqwwEjfC+HVbPpI+397LI62IFNGTCwV65e00Yy8BopohlE72mUAwzuT6e3a
         flCAFFDEtvHo2fGMpdruUEVi/GRcoHvwfu7up08A09a9LMyEzWZg2gjMtZ1p7HdQVXBk
         l0vCz7a7WlETwElW/2vRgpZHFF1H/NVPbF29+8b/IrSXqkAhC/MWstpPAVCxmwYRbh4R
         eUmeqMQKWiY0VUf+2hHm9D/E9iFH3NFotZv0t2XbMlsRiR4eEPIWKn4vusGanmOyR5wE
         4U0A==
X-Gm-Message-State: AOAM531e/rXrx9RX3zjgAg7Ya3VMcI2DJjZHyelV1RRbhzhcF6ZMlzzq
        zBGwVwpnhkLH+JG4HAOEJC72gRdFYjE=
X-Google-Smtp-Source: ABdhPJzZi66xJe2GnBiCRvwrJWVyBkeaVMUnG3SzIwBrWg8O1j5rAXBimvMhr50CMS240lk85AXKmw==
X-Received: by 2002:a17:902:d202:b029:e4:55cd:dde8 with SMTP id t2-20020a170902d202b02900e455cddde8mr5834807ply.51.1616627973094;
        Wed, 24 Mar 2021 16:19:33 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:f8fe:8e5d:4c9f:edfd])
        by smtp.googlemail.com with ESMTPSA id z3sm3629928pff.40.2021.03.24.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:32 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 2/6] ext4: add ability to return parsed options from parse_options
Date:   Wed, 24 Mar 2021 16:19:12 -0700
Message-Id: <20210324231916.2515824-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/super.c | 51 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 071d131fadd8..3a2cd9fb7e73 100644
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
@@ -5808,13 +5813,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
+	parsed_opts.journal_devnum = 0;
 
 	if (data && !orig_data)
 		return -ENOMEM;
@@ -5845,7 +5853,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			old_opts.s_qf_names[i] = NULL;
 #endif
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
-		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
+		parsed_opts.journal_ioprio =
+			sbi->s_journal->j_task->io_context->ioprio;
 
 	/*
 	 * Some options can be enabled by ext4 and/or by VFS mount flag
@@ -5855,7 +5864,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
 	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
 
-	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
+	if (!parse_options(data, sb, &parsed_opts, 1)) {
 		err = -EINVAL;
 		goto restore_opts;
 	}
@@ -5905,7 +5914,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 
 	if (sbi->s_journal) {
 		ext4_init_journal_params(sb, sbi->s_journal);
-		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
+		set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
 	}
 
 	/* Flush outstanding errors before changing fs state */
-- 
2.31.0.291.g576ba9dcdaf-goog

