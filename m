Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF55047A3D2
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhLTDRW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Dec 2021 22:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhLTDRU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Dec 2021 22:17:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702AC061574
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q17so6951959plr.11
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a35sQHDOY13qtNOT6mgKkiXL/g/x7ybU0ZJu3OLQn5w=;
        b=SAVnbIhYgOba022Zd1//uvIqwU13yZDaeem2rO8Q4XPIcsXcWzQx3v4P81QTaGz8Ey
         yg4qy/0PkRLJYj97etin1TdQOjQrjxzvU3+L4S2+t08mthna1WMN+wbazdnDOLYyOtnv
         L1CFSXg22xqZz9LJSS5+u2VFyn24Z1PcfQqmSLcZVkWmGtYuz6+DLUDPWXUMUwGd/U+H
         vvqOMrjXiFMUpvKuaPDLRG+hKdclfInSRe7bEGzbOBHEOoKwEBhfnXKd28r7aZUNmOih
         J7PSWKmKqH53amaWLqTWyTczNNPL2ShSjrogXQid+dnnH2cQvwlPDYXBH2GRlOJIDCHy
         yIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a35sQHDOY13qtNOT6mgKkiXL/g/x7ybU0ZJu3OLQn5w=;
        b=i9GktJHGuVD72W6myfnO2JBIJ1EtNxRx24GURB6OPh+Srvd8j4ii62X+yCyTKGmLYL
         9BzLuPTb+4IPYopVZoToACYedHyw54B6o8Zv/gvsIRskt9KYmeUF+B56bFCaV6HdvEqt
         3HK+e5hdPZ+Fd/zcmcgFFmnoC2mH9dz6af7wzFo5eniWFxIOBrZr/VIftBhsNrhlYM0H
         6uuIask+QfiV7RpNuYqNtcj+p4Q80pjC336fN163r4INpZMHUp7ES4KuE6Dtwtltq+7y
         Ip9FviAX7T8YsQDSeg3gbB1ZbY1yHNMxop3gBv6nmVKcN7ZQLSoY8sNKxjmr2AhYoGHv
         iXyw==
X-Gm-Message-State: AOAM533mmi2YoDowAyosYR/gT3T2CcYa6nDvHOZalO5s2DJK5M/z4btn
        p33MYN9Egf9JcujcxR+qv4NvnKbsGlY=
X-Google-Smtp-Source: ABdhPJxwVNI3XYi0OduNShkELtXHFb1eixk8JVM3sSi/vwIH2tLbiBpHJePcwBVvMiV1YQ+TN2qw0g==
X-Received: by 2002:a17:90b:3b8c:: with SMTP id pc12mr25717992pjb.9.1639970239152;
        Sun, 19 Dec 2021 19:17:19 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:29b6:d340:a7f2:2b64])
        by smtp.googlemail.com with ESMTPSA id kb1sm9102412pjb.56.2021.12.19.19.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 19:17:18 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     yinxin.x@bytedance.com, enwlinux@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/3] ext4: drop ineligible txn start stop APIs
Date:   Sun, 19 Dec 2021 19:17:03 -0800
Message-Id: <20211220031704.441727-3-harshads@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211220031704.441727-1-harshads@google.com>
References: <20211220031704.441727-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch drops ext4_fc_start_ineligible() and
ext4_fc_stop_ineligible() APIs. Fast commit ineligible transactions
should simply call ext4_fc_mark_ineligible() after starting the
trasaction.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  6 ++--
 fs/ext4/extents.c     |  6 ++--
 fs/ext4/fast_commit.c | 79 ++++++++-----------------------------------
 fs/ext4/ioctl.c       |  3 +-
 fs/ext4/super.c       |  1 -
 5 files changed, 20 insertions(+), 75 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 89bf10d020c9..a6cb4ca99c41 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1722,9 +1722,9 @@ struct ext4_sb_info {
 	 */
 	struct work_struct s_error_work;
 
-	/* Ext4 fast commit stuff */
+	/* Ext4 fast commit sub transaction ID */
 	atomic_t s_fc_subtid;
-	atomic_t s_fc_ineligible_updates;
+
 	/*
 	 * After commit starts, the main queue gets locked, and the further
 	 * updates get added in the staging queue.
@@ -2923,8 +2923,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
-void ext4_fc_start_ineligible(struct super_block *sb, int reason);
-void ext4_fc_stop_ineligible(struct super_block *sb);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 703feff8cb8c..38111ea18ae1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5341,7 +5341,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode, 0);
@@ -5380,7 +5380,6 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_ineligible(sb);
 out_mmap:
 	filemap_invalidate_unlock(mapping);
 out_mutex:
@@ -5482,7 +5481,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
 
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
@@ -5557,7 +5556,6 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_ineligible(sb);
 out_mmap:
 	filemap_invalidate_unlock(mapping);
 out_mutex:
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 084ab4d4e2ce..609c416841d5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -60,21 +60,11 @@
  *
  * Fast Commit Ineligibility
  * -------------------------
- * Not all operations are supported by fast commits today (e.g extended
- * attributes). Fast commit ineligibility is marked by calling one of the
- * two following functions:
- *
- * - ext4_fc_mark_ineligible(): This makes next fast commit operation to fall
- *   back to full commit. This is useful in case of transient errors.
  *
- * - ext4_fc_start_ineligible() and ext4_fc_stop_ineligible() - This makes all
- *   the fast commits happening between ext4_fc_start_ineligible() and
- *   ext4_fc_stop_ineligible() and one fast commit after the call to
- *   ext4_fc_stop_ineligible() to fall back to full commits. It is important to
- *   make one more fast commit to fall back to full commit after stop call so
- *   that it guaranteed that the fast commit ineligible operation contained
- *   within ext4_fc_start_ineligible() and ext4_fc_stop_ineligible() is
- *   followed by at least 1 full commit.
+ * Not all operations are supported by fast commits today (e.g extended
+ * attributes). Fast commit ineligibility is marked by calling
+ * ext4_fc_mark_ineligible(): This makes next fast commit operation to fall back
+ * to full commit.
  *
  * Atomicity of commits
  * --------------------
@@ -276,44 +266,6 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
 
-/*
- * Start a fast commit ineligible update. Any commits that happen while
- * such an operation is in progress fall back to full commits.
- */
-void ext4_fc_start_ineligible(struct super_block *sb, int reason)
-{
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-
-	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-	WARN_ON(reason >= EXT4_FC_REASON_MAX);
-	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
-	atomic_inc(&sbi->s_fc_ineligible_updates);
-}
-
-/*
- * Stop a fast commit ineligible update. We set EXT4_MF_FC_INELIGIBLE flag here
- * to ensure that after stopping the ineligible update, at least one full
- * commit takes place.
- */
-void ext4_fc_stop_ineligible(struct super_block *sb)
-{
-	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	atomic_dec(&EXT4_SB(sb)->s_fc_ineligible_updates);
-}
-
-static inline int ext4_fc_is_ineligible(struct super_block *sb)
-{
-	return (ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE) ||
-		atomic_read(&EXT4_SB(sb)->s_fc_ineligible_updates));
-}
-
 /*
  * Generic fast commit tracking function. If this is the first time this we are
  * called after a full commit, we initialize fast commit fields and then call
@@ -339,7 +291,7 @@ static int ext4_fc_track_template(
 	    (sbi->s_mount_state & EXT4_FC_REPLAY))
 		return -EOPNOTSUPP;
 
-	if (ext4_fc_is_ineligible(inode->i_sb))
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return -EINVAL;
 
 	tid = handle->h_transaction->t_tid;
@@ -1078,11 +1030,8 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 
 	start_time = ktime_get();
 
-	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
-		(ext4_fc_is_ineligible(sb))) {
-		reason = EXT4_FC_REASON_INELIGIBLE;
-		goto out;
-	}
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		return jbd2_complete_transaction(journal, commit_tid);
 
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
@@ -1098,6 +1047,14 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		reason = EXT4_FC_REASON_FC_START_FAILED;
 		goto out;
 	}
+	/*
+	 * After establishing journal barrier via jbd2_fc_begin_commit(), check
+	 * if we are fast commit ineligible.
+	 */
+	if (ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE)) {
+		reason = EXT4_FC_REASON_INELIGIBLE;
+		goto out;
+	}
 
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
 	ret = ext4_fc_perform_commit(journal);
@@ -1116,12 +1073,6 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	atomic_inc(&sbi->s_fc_subtid);
 	jbd2_fc_end_commit(journal);
 out:
-	/* Has any ineligible update happened since we started? */
-	if (reason == EXT4_FC_REASON_OK && ext4_fc_is_ineligible(sb)) {
-		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
-		reason = EXT4_FC_REASON_INELIGIBLE;
-	}
-
 	spin_lock(&sbi->s_fc_lock);
 	if (reason != EXT4_FC_REASON_OK &&
 		reason != EXT4_FC_REASON_ALREADY_COMMITTED) {
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e64a12e1218a..1366afb59fba 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -169,7 +169,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		err = -EINVAL;
 		goto err_out;
 	}
-	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT);
 
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(inode, inode_bl);
@@ -252,7 +252,6 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 err_out1:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_ineligible(sb);
 	ext4_double_up_write_data_sem(inode, inode_bl);
 
 err_out:
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6998c07c209a..0e547c6ec73f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5069,7 +5069,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb,
 
 	/* Initialize fast commit stuff */
 	atomic_set(&sbi->s_fc_subtid, 0);
-	atomic_set(&sbi->s_fc_ineligible_updates, 0);
 	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
 	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
-- 
2.34.1.173.g76aa8bc2d0-goog

