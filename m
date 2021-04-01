Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10F6351CF5
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhDASXI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhDASMp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 14:12:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781FC0319CB
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w10so381672pgh.5
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLf1j98U7dB/FSVX9/cKICxC1QgjOXdqBES2EYHvpWA=;
        b=qbtk0xdxzxrBQvt3HcyourNeZEMng8llAMzxIb0iCE+xXVeKCyFzSh7JPft1YRhZV0
         1rIlZcWItI7PRS/+jmg9BShSy3GXqWbaYJ0eMhivL6drnshva3TdyMm1vf0kKB2Tl0eY
         Xp4NmYSdIU96dRbJfzJasBPqUoYkFrshB+KUQf0/QAX7xr2dBCwBRx5Y/3YTcqkbG+nj
         yjsmWqoaSFpBbbeJXm/rB29kLEqqEb9asBKGDNvKIx+iZRRrNbHS0kKah7MV5StkbWvY
         A3Rx5Hxz5xLSqeaIR1DzqS9cpD/zdzvn/h4loD6q1YLfY2qOOCFPkGe48ypOi0w3nhGR
         FFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLf1j98U7dB/FSVX9/cKICxC1QgjOXdqBES2EYHvpWA=;
        b=EH0RQNmjTV5rzLKACJCRUIN8bwPzf6+o5DdJF+QAcA24wdX9DYsyQ/eRMVMpH3FR0T
         R4K+Oxts3Uhc3g75SrRYsCSAnLkXWNoW6OVJQeuw/nKgwrC3QhuNeAwnIAYLGpXzj4or
         wjkSHzH21NyQ9pGQTUn2M9vzYPIh9d+Wht9FZql1SMk5VuYbv4DjBd9O5HX95+j85Etc
         tci8FGLKzuppxd6VFxgwd4LeIQEupFS0rCLJVpFT1Imc3pnG9CgVfoBweWxAVmY455/k
         yic6Dh0RilK5R+Gz76W7X7y4ZWmyFsZMMvurdKglYRSRjQIc3/dzG/6twPuLlAcwQo+y
         DCEg==
X-Gm-Message-State: AOAM530k1SpLED2h+JijMKsGL1iy3rhH6cO8rymvUK/dNbfJp/34RJta
        2ugamn0AxdMeXHdVOP5/1X6VzAHdVsU=
X-Google-Smtp-Source: ABdhPJwAPN+nTxZXUB/UQsQC8sl8R6+nIAIFf9cWpO5q1UkLRzzjBZkGZAgjoK2IFpR6u58uqe9lUg==
X-Received: by 2002:a63:356:: with SMTP id 83mr8437103pgd.344.1617297700340;
        Thu, 01 Apr 2021 10:21:40 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:39 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 2/7] ext4: add ability to return parsed options from parse_options
Date:   Thu,  1 Apr 2021 10:21:24 -0700
Message-Id: <20210401172129.189766-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
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
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
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

