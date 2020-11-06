Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F249E2A8DE6
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKFD7v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:51 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FCC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 13so106782pfy.4
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEUHniCwb/xx1lKRcADI2741njgdkHiQLjWiWM/5o9Y=;
        b=ufpIkbB0LsFk2O1mWMaCF2okbMV9rZxuWOLXgMaME26xPYwphWgPZ+i2w8OjpVBOx4
         kXHFFRFUVLlNyx6sGeMEyeJcdjbXj6A+/MvIfANw+8SyHL6x73aEJBbmxRpgNOrnW1/5
         qoA2jYCCIVHGkmlP1che4EsSgk9APNdZAT7vEwhXboBP5sTNFMgfYnfUniDVMNEk6GiP
         HI70x7Ehdv+fSiueWY388FlJWAdDGfzh3+9kPZxACmKKzwn5Jl0rmakMm4yLtcb8i7KZ
         mmtaba3ZenwAAZOLt7yaiDwUlHh59bmRj9FxYZaxGpYasi2eMW51YnCEfiEGVTniPfDl
         TlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEUHniCwb/xx1lKRcADI2741njgdkHiQLjWiWM/5o9Y=;
        b=P34+2KktyNosOpbMuwlvhBUo4My612vySLakgJh+Y05fsNhztG3EL03YXhLhyuvzGx
         9TfQ0i7Yak+F8hTdG3XwYido8ghUn4Jv31OiiXSWENFCsrB98LphMSN07Gakt7xtAFGC
         URUaHWlXZLPxmoLpFmhYcsLSqvg3HK/uFZQEUE4mAl3IEK26PHGUOqcxoiEXOBIa1ZmL
         nCngU1pyfmO1JRCu2W6SjyVRLhfGY8X+8XKw1Umhu6oalWD6G6OuvQ+mXU4BN3o8AkNJ
         YMIoUtTGM8omsW1h7yLTr8O4S7zKP9/mkPNa+tTl1NCVfmPFZygxG92qHgzdvxVmJ7Cu
         Yy4Q==
X-Gm-Message-State: AOAM533YVxhliyCb4xv2wSc2P5r/G6yzp/oLYAMumnCpJ6493bYh8UxT
        ns7YlwDN/F+rGQfeLqUc+yFEzpYrsjs=
X-Google-Smtp-Source: ABdhPJwdsJboOFVrJLGpya/W6pjB+1SKo1XNkc1K3ysj0pnQkXGYtapxojeWauWqJ8/F+JH7aMgSrA==
X-Received: by 2002:a17:90a:ef8b:: with SMTP id m11mr242632pjy.161.1604635190118;
        Thu, 05 Nov 2020 19:59:50 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:49 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 20/22] ext4: make s_mount_flags modifications atomic
Date:   Thu,  5 Nov 2020 19:59:09 -0800
Message-Id: <20201106035911.1942128-21-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit file system states are recorded in
sbi->s_mount_flags. Fast commit expects these bit manipulations to be
atomic. This patch adds helpers to make those modifications atomic.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 40 +++++++++++++++++++++++++++++-----------
 fs/ext4/fast_commit.c | 18 +++++++++---------
 fs/ext4/file.c        |  4 ++--
 fs/ext4/fsync.c       |  2 +-
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/mballoc.c     |  4 ++--
 fs/ext4/super.c       | 14 +++++++-------
 7 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e81104578015..16de3d62ce2b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1419,16 +1419,6 @@ struct ext4_super_block {
 
 #ifdef __KERNEL__
 
-/*
- * run-time mount flags
- */
-#define EXT4_MF_MNTDIR_SAMPLED		0x0001
-#define EXT4_MF_FS_ABORTED		0x0002	/* Fatal error detected */
-#define EXT4_MF_FC_INELIGIBLE		0x0004	/* Fast commit ineligible */
-#define EXT4_MF_FC_COMMITTING		0x0008	/* File system underoing a fast
-						 * commit.
-						 */
-
 #ifdef CONFIG_FS_ENCRYPTION
 #define DUMMY_ENCRYPTION_ENABLED(sbi) ((sbi)->s_dummy_enc_policy.policy != NULL)
 #else
@@ -1471,7 +1461,7 @@ struct ext4_sb_info {
 	struct buffer_head * __rcu *s_group_desc;
 	unsigned int s_mount_opt;
 	unsigned int s_mount_opt2;
-	unsigned int s_mount_flags;
+	unsigned long s_mount_flags;
 	unsigned int s_def_mount_opt;
 	ext4_fsblk_t s_sb_block;
 	atomic64_t s_resv_clusters;
@@ -1703,6 +1693,34 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 	_v;								   \
 })
 
+/*
+ * run-time mount flags
+ */
+enum {
+	EXT4_MF_MNTDIR_SAMPLED,
+	EXT4_MF_FS_ABORTED,	/* Fatal error detected */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_FC_COMMITTING	/* File system underoing a fast
+				 * commit.
+				 */
+};
+
+static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
+{
+	set_bit(bit, &EXT4_SB(sb)->s_mount_flags);
+}
+
+static inline void ext4_clear_mount_flag(struct super_block *sb, int bit)
+{
+	clear_bit(bit, &EXT4_SB(sb)->s_mount_flags);
+}
+
+static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
+{
+	return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
+}
+
+
 /*
  * Simulate_fail codes
  */
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ebe5f423f8f2..5cd6630ab1b9 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -261,7 +261,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
 	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
-	sbi->s_mount_flags |= EXT4_MF_FC_INELIGIBLE;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
@@ -294,14 +294,14 @@ void ext4_fc_stop_ineligible(struct super_block *sb)
 	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
-	EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FC_INELIGIBLE;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	atomic_dec(&EXT4_SB(sb)->s_fc_ineligible_updates);
 }
 
 static inline int ext4_fc_is_ineligible(struct super_block *sb)
 {
-	return (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FC_INELIGIBLE) ||
-		atomic_read(&EXT4_SB(sb)->s_fc_ineligible_updates);
+	return (ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE) ||
+		atomic_read(&EXT4_SB(sb)->s_fc_ineligible_updates));
 }
 
 /*
@@ -349,7 +349,7 @@ static int ext4_fc_track_template(
 	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
-				(sbi->s_mount_flags & EXT4_MF_FC_COMMITTING) ?
+				(ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
 	spin_unlock(&sbi->s_fc_lock);
@@ -402,7 +402,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	node->fcd_name.len = dentry->d_name.len;
 
 	spin_lock(&sbi->s_fc_lock);
-	if (sbi->s_mount_flags & EXT4_MF_FC_COMMITTING)
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
 		list_add_tail(&node->fcd_list,
 				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	else
@@ -857,7 +857,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	int ret = 0;
 
 	spin_lock(&sbi->s_fc_lock);
-	sbi->s_mount_flags |= EXT4_MF_FC_COMMITTING;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
 		ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
@@ -1206,8 +1206,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_STAGING]);
 
-	sbi->s_mount_flags &= ~EXT4_MF_FC_COMMITTING;
-	sbi->s_mount_flags &= ~EXT4_MF_FC_INELIGIBLE;
+	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
+	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 
 	if (full)
 		sbi->s_fc_bytes = 0;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 80ad5ccc0288..3ed8c048fb12 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -780,13 +780,13 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	handle_t *handle;
 	int err;
 
-	if (likely(sbi->s_mount_flags & EXT4_MF_MNTDIR_SAMPLED))
+	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
 		return 0;
 
 	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
 		return 0;
 
-	sbi->s_mount_flags |= EXT4_MF_MNTDIR_SAMPLED;
+	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
 	/*
 	 * Sample where the filesystem has been mounted and
 	 * store it in the superblock for sysadmin convenience
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 81a545fd14a3..a42ca95840f2 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -143,7 +143,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (sb_rdonly(inode->i_sb)) {
 		/* Make sure that we read updated s_mount_flags value */
 		smp_rmb();
-		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
+		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))
 			ret = -EROFS;
 		goto out;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 000bf70e88ed..0d8385aea898 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2442,7 +2442,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			struct super_block *sb = inode->i_sb;
 
 			if (ext4_forced_shutdown(EXT4_SB(sb)) ||
-			    EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+			    ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
 				goto invalidate_dirty_pages;
 			/*
 			 * Let the uper layers retry transient errors.
@@ -2676,7 +2676,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 * the stack trace.
 	 */
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(mapping->host->i_sb)) ||
-		     sbi->s_mount_flags & EXT4_MF_FS_ABORTED)) {
+		     ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))) {
 		ret = -EROFS;
 		goto out_writepages;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 85abbfb98cbe..f482a17ae764 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4477,7 +4477,7 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 {
 	ext4_group_t i, ngroups;
 
-	if (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
 		return;
 
 	ngroups = ext4_get_groups_count(sb);
@@ -4508,7 +4508,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
 
-	if (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
 		return;
 
 	mb_debug(sb, "Can't allocate:"
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5386736913d2..edb36581f6cc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -686,7 +686,7 @@ static void ext4_handle_error(struct super_block *sb)
 	if (!test_opt(sb, ERRORS_CONT)) {
 		journal_t *journal = EXT4_SB(sb)->s_journal;
 
-		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
+		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
 		if (journal)
 			jbd2_journal_abort(journal, -EIO);
 	}
@@ -904,7 +904,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	va_end(args);
 
 	if (sb_rdonly(sb) == 0) {
-		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
+		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
 		if (EXT4_SB(sb)->s_journal)
 			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
 
@@ -2153,7 +2153,7 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option", opt);
 		return 1;
 	case Opt_abort:
-		sbi->s_mount_flags |= EXT4_MF_FS_ABORTED;
+		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
 		return 1;
 	case Opt_i_version:
 		sb->s_flags |= SB_I_VERSION;
@@ -4778,8 +4778,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	sbi->s_fc_bytes = 0;
-	sbi->s_mount_flags &= ~EXT4_MF_FC_INELIGIBLE;
-	sbi->s_mount_flags &= ~EXT4_MF_FC_COMMITTING;
+	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	spin_lock_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
@@ -5881,7 +5881,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
+	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
 		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
@@ -5895,7 +5895,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
-		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED) {
+		if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED)) {
 			err = -EROFS;
 			goto restore_opts;
 		}
-- 
2.29.1.341.ge80a0c044ae-goog

