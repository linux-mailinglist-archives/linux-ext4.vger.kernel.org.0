Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E247E8B7
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbhLWUV4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhLWUV4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:21:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA906C061401
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9724784pji.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qah7Eb5C8wOg30Xr3OPVSSlzckAWk9ZEXXlEtgk1/B0=;
        b=Ep/Fzd++0KKX8xwHvN/qzgMFR7iTE2DK6alToEGj/HGNcyEXrkgHT7ITRs2lYLlihY
         ejpvw+pNI2wn8zcgTfcshNRkW9X7j1eKg+7quqcSEY5xoQ3zFwyQio45j6qZG4r/qvFp
         BEUocGyfqNuLrPDsHTeJQ2Qo+Wd1/G1/j1fASRr9dKaI2egdMpL9MgjZ3Jb6xJMZfht8
         8ZNRlN+sL4XclIGFbv0Q19Rq4lLIOid/UaoVhWXqujFtSOpigFEdmaBG1O/9Q9nI5pVH
         ue28Zn8v0h7UIy0SkzzoYBDmm1O72OPgUddJZjU1H6+wTtYEDURvKCZ/VCBz45BNMSHc
         dBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qah7Eb5C8wOg30Xr3OPVSSlzckAWk9ZEXXlEtgk1/B0=;
        b=q5zPOlKQ69mj2AMTuU2Y0AXn4LBwYt1mNLdlc1cUwB+xFI573JYVBoRLG3jFo9iTHH
         zQJt6BfRSTA8bxcnL2ZTSkL/drvcgbi0IvIn5CGqEV2XQrBYI2iX3pNI+COotYmIYPMb
         sApostbM7S0X6KegFPoqt/RxS7pA0z5UORbihXJKKweZTczIVpeLqHF+cV2B1jjgYDmy
         uhcI2V192nB/GmLgKiDa/p1IzVPbadam1WU6QNf91uTxB1/xhmjKCVfBE+amX8ynmyyA
         QIjJ7dLsI3ePn8nS4ehYeVUmFYO05/sOlWHmXaocYnK5zTUiDtETcbJuSF/+iusmlIKL
         8Kow==
X-Gm-Message-State: AOAM531MlyCG7OFCmeWPBqglZ5U0cNp/f7c1yU5gvssnKrjhjplp+/tn
        VClc4fv+EwTgTS7zo9wE/tgA2DJ7c2Y=
X-Google-Smtp-Source: ABdhPJxGts3Npz68PprD1li3EDkOOSirIKzwfvgEC/MVx75MHKDNaxb4CKxI6x0HxS0FM9fliUtVEg==
X-Received: by 2002:a17:902:a601:b0:148:adf2:9725 with SMTP id u1-20020a170902a60100b00148adf29725mr3792155plq.136.1640290914968;
        Thu, 23 Dec 2021 12:21:54 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:404a:8e2b:a329:bed6])
        by smtp.googlemail.com with ESMTPSA id lx8sm10351074pjb.18.2021.12.23.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:21:54 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 2/4] ext4: drop ineligible txn start stop APIs
Date:   Thu, 23 Dec 2021 12:21:38 -0800
Message-Id: <20211223202140.2061101-3-harshads@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211223202140.2061101-1-harshads@google.com>
References: <20211223202140.2061101-1-harshads@google.com>
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
index 404dd50856e5..d71485d53050 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1725,9 +1725,9 @@ struct ext4_sb_info {
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
@@ -2926,8 +2926,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
-void ext4_fc_start_ineligible(struct super_block *sb, int reason);
-void ext4_fc_stop_ineligible(struct super_block *sb);
 void ext4_fc_start_update(struct inode *inode);
 void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
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
index 0f32b445582a..2771adefdba0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -65,21 +65,11 @@
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
@@ -328,44 +318,6 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
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
@@ -391,7 +343,7 @@ static int ext4_fc_track_template(
 	    (sbi->s_mount_state & EXT4_FC_REPLAY))
 		return -EOPNOTSUPP;
 
-	if (ext4_fc_is_ineligible(inode->i_sb))
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return -EINVAL;
 
 	tid = handle->h_transaction->t_tid;
@@ -1142,11 +1094,8 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 
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
@@ -1162,6 +1111,14 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
@@ -1180,12 +1137,6 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
2.34.1.307.g9b7440fafd-goog

