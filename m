Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D54904F9
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jan 2022 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiAQJhX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jan 2022 04:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiAQJhX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jan 2022 04:37:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B9C061574
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q30-20020a17090a752100b001b49f65ff61so3069062pjk.4
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oislcibWwGVzrAINuQT2hU5CHo3zB1lWarxdo9wT0s=;
        b=b5th21Et7tFT+ClwOpqMu4Agy7U/yZLD/T0yUxrn3ZU25o1V63BHFHjJoO/nT3H1Z8
         XzmzAjp9LL0K13QW1vEOVTFeVRDLOimJKhj9RVhnNERvt9e7NdGNiGB1+9ZZsPXYOneB
         z9eGr1CnEPwDD55nsCQAPRsmoKY7SMEBUK3e5MvHj2lSPp2/IVNFvpark3FhtG2TdCC/
         wH948Ln6gqCKKj0ZPMHzKNmPQiWhTsePHdHu5pvTjpEZ51ZPXuogi3DV90VmYcQY3PKy
         OGi+fCD1I81+9HMsCwTsjxI7Td6xNCr5te5apIJufJ4zAVeEZI8Hf5TZUjsMfVp5OV8X
         m8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oislcibWwGVzrAINuQT2hU5CHo3zB1lWarxdo9wT0s=;
        b=C8SsGAa+e05yIkFFwjarikl+hu5h6PGAbjNZpz56teQ8TFwCO9W+dmgPp7dJzjCRdQ
         yOvDVkxxWNjkYrv7a/wdBoc9BthQLwP+bok0qrnfiDiCOaZZF9HfS1z8w89mBb26J/Nj
         3JcfhMYlu9QmkJDY2mL9l2loO+2WEApWnCWDzhOG+M2vJk+JG1eD59YFztJ2qJy2lFx/
         WSencBW+Q3g0KD6V1ps/fOV2as3lWTsMnK3W+SGiookh2sjnKPkz8xprXoiSUQgKB71N
         meUk1yKVfbDboUqa8JeFEQ6JpD3llbrm7PT23/UkJF8ThNM+wvh4mdSFyH8fbEitlJO2
         XJXA==
X-Gm-Message-State: AOAM533zAzltc8ULwPtopkJO+JtzUV21cDJoLRav24OgtgWxSk+X2I27
        LhrNhK+4ZZAaBpk5PHRgePx4aA==
X-Google-Smtp-Source: ABdhPJy2118DgqrUVisbC9X3bUyHa46chPOgaUGN9puXtVVUtKi1iq5xcfl4PEg5ElO5oJKpmwPmNg==
X-Received: by 2002:a17:902:9682:b0:149:15d2:55ae with SMTP id n2-20020a170902968200b0014915d255aemr21215753plp.59.1642412242730;
        Mon, 17 Jan 2022 01:37:22 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z16sm11426497pgi.89.2022.01.17.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:37:22 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     dan.carpenter@oracle.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] ext4: fast commit may not fallback for ineligible commit
Date:   Mon, 17 Jan 2022 17:36:54 +0800
Message-Id: <20220117093655.35160-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117093655.35160-1-yinxin.x@bytedance.com>
References: <20220117093655.35160-1-yinxin.x@bytedance.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Suggested-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v3: Fix use-after-free issue for improper use of the 'handle' parameter in
ext4_xattr_set() and ext4_evict_inode(). Record current running
transaction tid as latest ineligible tid if 'handle' passed as NULL.
Update comments for ext4_fc_mark_ineligible().
---
 fs/ext4/ext4.h        |  3 ++-
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/fast_commit.c | 33 +++++++++++++++++++++++++--------
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/ioctl.c       |  4 ++--
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  1 +
 fs/ext4/xattr.c       |  6 +++---
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     |  2 +-
 include/linux/jbd2.h  |  2 +-
 11 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 457b76d35473..881f480dd150 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1750,6 +1750,7 @@ struct ext4_sb_info {
 	spinlock_t s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
+	tid_t s_fc_ineligible_tid;
 #ifdef CONFIG_EXT4_DEBUG
 	int s_fc_debug_max_replay;
 #endif
@@ -2926,7 +2927,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 			    struct dentry *dentry);
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
-void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
+void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
 void ext4_fc_start_update(struct inode *inode);
 void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01d318645421..880a61dcd81b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5334,7 +5334,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode, 0);
@@ -5474,7 +5474,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		ret = PTR_ERR(handle);
 		goto out_mmap;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1abe78b8d84f..e031afee42de 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -300,18 +300,32 @@ void ext4_fc_del(struct inode *inode)
 }
 
 /*
- * Mark file system as fast commit ineligible. This means that next commit
- * operation would result in a full jbd2 commit.
+ * Mark file system as fast commit ineligible, and record latest
+ * ineligible transaction tid. This means until the recorded
+ * transaction, commit operation would result in a full jbd2 commit.
  */
-void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
+void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	tid_t tid;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
 	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	if (handle && !IS_ERR(handle))
+		tid = handle->h_transaction->t_tid;
+	else {
+		read_lock(&sbi->s_journal->j_state_lock);
+		tid = sbi->s_journal->j_running_transaction ?
+				sbi->s_journal->j_running_transaction->t_tid : 0;
+		read_unlock(&sbi->s_journal->j_state_lock);
+	}
+	spin_lock(&sbi->s_fc_lock);
+	if (sbi->s_fc_ineligible_tid < tid)
+		sbi->s_fc_ineligible_tid = tid;
+	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
@@ -387,7 +401,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	mutex_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -400,7 +414,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
-				EXT4_FC_REASON_NOMEM);
+				EXT4_FC_REASON_NOMEM, NULL);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
@@ -502,7 +516,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 
 	if (ext4_should_journal_data(inode)) {
 		ext4_fc_mark_ineligible(inode->i_sb,
-					EXT4_FC_REASON_INODE_JOURNAL_DATA);
+					EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
 		return;
 	}
 
@@ -1179,7 +1193,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
  * Fast commit cleanup routine. This is called after every fast commit and
  * full commit. full is true if we are called after a full commit.
  */
-static void ext4_fc_cleanup(journal_t *journal, int full)
+static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1227,7 +1241,10 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
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
index 5f79d265d06a..60a1bab59f10 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -338,7 +338,7 @@ void ext4_evict_inode(struct inode *inode)
 	return;
 no_delete:
 	if (!list_empty(&EXT4_I(inode)->i_fc_list))
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
 	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
@@ -5983,7 +5983,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		return PTR_ERR(handle);
 
 	ext4_fc_mark_ineligible(inode->i_sb,
-		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
+		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, handle);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bbbedf27b71c..a8022c2c6a58 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -411,7 +411,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		err = -EINVAL;
 		goto err_out;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT);
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT, handle);
 
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(inode, inode_bl);
@@ -1373,7 +1373,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
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
index 0343f682504d..38b496745825 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5087,6 +5087,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
+	sbi->s_fc_ineligible_tid = 0;
 	spin_lock_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 1e0fc1ed845b..042325349098 100644
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
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
 
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
2.25.1

