Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2544B48777E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiAGMMz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 07:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiAGMMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 07:12:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39170C061201
        for <linux-ext4@vger.kernel.org>; Fri,  7 Jan 2022 04:12:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i30so5338706pgl.0
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jan 2022 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBXHKoOMQCOBVUnOHE7jHMQgHcPdumAbOd86oRm9h2s=;
        b=WsK9JXw2mPNVbnaJsXnxFN1GWGPVf9u9Ha51e03TM8woqPBZtGkvvbujREUb/nxlWd
         eM8jMpNkVByOzNK/eP2CaJ+0RM2Cn4Dw+L+NBn9guztj6gZvCuFT6W5+Sqhhoc+h0hY8
         3KXLpsMvCDKnnQMjaq7B/RY42hXwfDIXwnBoZaFiG7xTJcDjGO+41n4aPfZRYMLpV07L
         FGM7rhvIGxsKzxYFTnqEVcCKSZzWucYDoON+WCPp4S/S8yC7C3VmRmCUqxxE9oLFNa1t
         j9ehRf4XCnuCBVaTY9P1NBIdhAKg4HMaUBlBqNaXbpHZtopS0tZig/KTKISoBKRFR8n+
         1K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBXHKoOMQCOBVUnOHE7jHMQgHcPdumAbOd86oRm9h2s=;
        b=klfUgPfUplI8p7GoYYRVRL+LVzW+m+86vojMazwaYtzCVPnZ32OqJviOHZiH1rfMAz
         KapLiNQy8zL8TovVHtVjLNL51QvRnnrzBWGsPLcJgYPMU0LA0VHkS/WR8WlpqrCcsvQR
         ySovoRxTxUs+EIhJU3zLsnlw0Ma2a0vkOZB9h3OxM6CQxYKmQsfSbCNE69itPxFHu15m
         VhWz6wM1pbLdssIBy3zEuPD3xV+8GOZzGXPpaUdYNyHaT0TaItDyQ2iF4DVAKrlBlcrb
         rxtoxEg9F+oVJO6D4gGy1Pt1vgN2036o+PVr6heV9z2RJHdKtW0XemKJIUDqn5PJ8M2Y
         HyQA==
X-Gm-Message-State: AOAM533xk4+Z/twQZlmEpJISPof0ajv/XDmN0QocberAuWyvHPpczKvI
        bB5zxeN2BybgnMWnv7V6R8T8kV39mBuXSw==
X-Google-Smtp-Source: ABdhPJzAoddh0q3JeN1P4CtSV31pUu1LIDaPsGkZdvdLGFQYeKWsEHrV/um2RYU3P987WooW0ugxBA==
X-Received: by 2002:a63:5147:: with SMTP id r7mr55062436pgl.581.1641557574736;
        Fri, 07 Jan 2022 04:12:54 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h1sm5888137pfi.109.2022.01.07.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:12:54 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 1/2] ext4: fast commit may not fallback for ineligible commit
Date:   Fri,  7 Jan 2022 20:12:14 +0800
Message-Id: <20220107121215.1912-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107121215.1912-1-yinxin.x@bytedance.com>
References: <20220107121215.1912-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

for the follow scenario:
1. jbd start commit transaction n
2. task A get new handle for transaction n+1
3. task A do some ineligible actions and mark FC_INELIGIBLE
4. jbd complete transaction n and clean FC_INELIGIBLE
5. task A call fsync

in this case fast commit will not fallback to full commit and
transaction n+1 also not handled by jbd.

make ext4_fc_mark_ineligible() also record transaction tid for
latest ineligible case, when call ext4_fc_cleanup() check
current transaction tid, if small than latest ineligible tid
do not clear the EXT4_MF_FC_INELIGIBLE.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/ext4.h        |  3 ++-
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/fast_commit.c | 19 +++++++++++++------
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/ioctl.c       |  4 ++--
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  1 +
 fs/ext4/xattr.c       |  6 +++---
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     |  2 +-
 include/linux/jbd2.h  |  2 +-
 11 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7b0686758691..a060bb56e654 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1747,6 +1747,7 @@ struct ext4_sb_info {
 	spinlock_t s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
+	tid_t s_fc_ineligible_tid;
 #ifdef CONFIG_EXT4_DEBUG
 	int s_fc_debug_max_replay;
 #endif
@@ -2924,7 +2925,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 			    struct dentry *dentry);
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
-void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
+void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
 void ext4_fc_start_update(struct inode *inode);
 void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9b6c76629c93..3be90aa5a5ba 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5339,7 +5339,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode, 0);
@@ -5479,7 +5479,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f0cd20f5fe5e..3673d4798af3 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -303,7 +303,7 @@ void ext4_fc_del(struct inode *inode)
  * Mark file system as fast commit ineligible. This means that next commit
  * operation would result in a full jbd2 commit.
  */
-void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
+void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
@@ -312,6 +312,10 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
 		return;
 
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	spin_lock(&sbi->s_fc_lock);
+	if (handle && !IS_ERR(handle))
+		sbi->s_fc_ineligible_tid = handle->h_transaction->t_tid;
+	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
@@ -387,7 +391,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	mutex_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -400,7 +404,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
-				EXT4_FC_REASON_NOMEM);
+				EXT4_FC_REASON_NOMEM, NULL);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
@@ -502,7 +506,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 
 	if (ext4_should_journal_data(inode)) {
 		ext4_fc_mark_ineligible(inode->i_sb,
-					EXT4_FC_REASON_INODE_JOURNAL_DATA);
+					EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
 		return;
 	}
 
@@ -1180,7 +1184,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
  * Fast commit cleanup routine. This is called after every fast commit and
  * full commit. full is true if we are called after a full commit.
  */
-static void ext4_fc_cleanup(journal_t *journal, int full)
+static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1228,7 +1232,10 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	if (tid >= sbi->s_fc_ineligible_tid) {
+		sbi->s_fc_ineligible_tid = 0;
+		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	}
 
 	if (full)
 		sbi->s_fc_bytes = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 08a90e25b78b..2ffa9bbb1324 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -337,7 +337,7 @@ void ext4_evict_inode(struct inode *inode)
 	return;
 no_delete:
 	if (!list_empty(&EXT4_I(inode)->i_fc_list))
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, handle);
 	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
@@ -5995,7 +5995,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		return PTR_ERR(handle);
 
 	ext4_fc_mark_ineligible(inode->i_sb,
-		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
+		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, handle);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1366afb59fba..0557402ac4fd 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -169,7 +169,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		err = -EINVAL;
 		goto err_out;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT, handle);
 
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(inode, inode_bl);
@@ -1073,7 +1073,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_resize_fs(sb, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
-			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE, NULL);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 52c9bd154122..47b9f87dbc6f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3889,7 +3889,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		 * dirents in directories.
 		 */
 		ext4_fc_mark_ineligible(old.inode->i_sb,
-			EXT4_FC_REASON_RENAME_DIR);
+			EXT4_FC_REASON_RENAME_DIR, handle);
 	} else {
 		if (new.inode)
 			ext4_fc_track_unlink(handle, new.dentry);
@@ -4049,7 +4049,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (unlikely(retval))
 		goto end_rename;
 	ext4_fc_mark_ineligible(new.inode->i_sb,
-				EXT4_FC_REASON_CROSS_RENAME);
+				EXT4_FC_REASON_CROSS_RENAME, handle);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
 		if (retval)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d81423021e3b..6049547d3c0f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4627,6 +4627,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
+	sbi->s_fc_ineligible_tid = 0;
 	spin_lock_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 1e0fc1ed845b..c1748730c1df 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2408,7 +2408,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, handle);
 
 cleanup:
 	brelse(is.iloc.bh);
@@ -2486,7 +2486,7 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, handle);
 
 	return error;
 }
@@ -2920,7 +2920,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 					 error);
 			goto cleanup;
 		}
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, handle);
 	}
 	error = 0;
 cleanup:
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 3cc4ab2ba7f4..d188fa913a07 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1170,7 +1170,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (journal->j_commit_callback)
 		journal->j_commit_callback(journal, commit_transaction);
 	if (journal->j_fc_cleanup_callback)
-		journal->j_fc_cleanup_callback(journal, 1);
+		journal->j_fc_cleanup_callback(journal, 1, commit_transaction->t_tid);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
 	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0b86a4365b66..a8e64ad11ae3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -771,7 +771,7 @@ static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
 	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
-		journal->j_fc_cleanup_callback(journal, 0);
+		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
 	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	if (fallback)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index fd933c45281a..d63b8106796e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1295,7 +1295,7 @@ struct journal_s
 	 * Clean-up after fast commit or full commit. JBD2 calls this function
 	 * after every commit operation.
 	 */
-	void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
+	void (*j_fc_cleanup_callback)(struct journal_s *journal, int full, tid_t tid);
 
 	/**
 	 * @j_fc_replay_callback:
-- 
2.20.1

