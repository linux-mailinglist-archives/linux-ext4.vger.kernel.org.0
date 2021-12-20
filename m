Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6147A3D1
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 04:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhLTDRT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Dec 2021 22:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhLTDRT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Dec 2021 22:17:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44BC061574
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k4so8115314pgb.8
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UW9n2VRj6nMMfvzL+DSyZBAR1HT04cH6q41kOBvMMMQ=;
        b=lnp+V5ppm+BNm/vXNFxFvkvWV2iNICBXZ6/O8U7fB4RHa5OWgVx7Zj9mp8HPrmfztK
         MENcHkuTpSkx7KIIwBzhUOjmBWlYCxhcrA/i17tjpQ3NxUS7ouMqxP1VE0csH0XigSBZ
         8ISRGMK6+hmkIsKq98WJLrd9per+yvNTZwC4g9fkedeUXW686mKZqMKuWCdoZEG65t72
         4lsnQugPzgUtkrAyvfJWrD3lCEjKv7/Z/MvdTEBt+bJHlsO027z3ijUpNNtoZ35VvLAX
         23eZNGJj1WRTnNDos5/tfRGUWwBseUuxwRy9SBUPNgApOzv3iYp3TDKgo/2r0lnVVObg
         3yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UW9n2VRj6nMMfvzL+DSyZBAR1HT04cH6q41kOBvMMMQ=;
        b=Vj40Yi2OjG+Rc8dS6wHwdgC+PRkyP8m0bkzLrHwKIiPGAzvYy6jgA6no33YFwbBr6/
         FcVJ+3o3kUpgTjIptPY0Z5RyuUB86eKciwPuSQp9TRdw4tBvWqcJXiCrbWt213rNW8tC
         71tL+nquwkvKKwlVFh85T1NFTigGZEsULmDfa5v1tIMNZ/jYhxTJg+D8xvewhIy9nlk3
         Cytql81wbF/O9SAZFAKNJ3/vzeNo30JRs1HtNFXD7nvoUsZeS26HsRKiS+/WzLQcoSu0
         xj12+5zxAIGKQLugG6Mx1Hw3FHZISPwyYMkVS1uS//PaZvOYPnm2AwEnjbaDGcWINTR2
         WWfg==
X-Gm-Message-State: AOAM533h+tLzjVfVZZvgUFRzciFNCv0V1dvXDnidDv6EKOBfv+jqe+ox
        0jo5vQBdt08KHNvuNsWE2XqrDDM5dkw=
X-Google-Smtp-Source: ABdhPJydg8cOrXawTkYn1s/xk0VnWH75mBgbYycpaAYQmoLWRA+41ok6DdMuXFUKUZfJ+u50ApuVFg==
X-Received: by 2002:a62:830e:0:b0:4b1:78a:d4f with SMTP id h14-20020a62830e000000b004b1078a0d4fmr14390747pfe.52.1639970237956;
        Sun, 19 Dec 2021 19:17:17 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:29b6:d340:a7f2:2b64])
        by smtp.googlemail.com with ESMTPSA id kb1sm9102412pjb.56.2021.12.19.19.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 19:17:17 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     yinxin.x@bytedance.com, enwlinux@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/3] ext4: drop transaction start stop APIs for fast commit
Date:   Sun, 19 Dec 2021 19:17:02 -0800
Message-Id: <20211220031704.441727-2-harshads@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211220031704.441727-1-harshads@google.com>
References: <20211220031704.441727-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch drops ext4_fc_start_update() and ext4_fc_stop_update() APIs
for fast commits. To ensure that there are no ongoing journal updates
during fast commit, we also make jbd2_fc_begin_commit() lock journal
for updates. This way we don't have to maintain two different
transaction start stop APIs for fast commit and full commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/acl.c         |  2 --
 fs/ext4/ext4.h        |  5 ---
 fs/ext4/extents.c     |  3 --
 fs/ext4/fast_commit.c | 76 ++++---------------------------------------
 fs/ext4/file.c        |  4 ---
 fs/ext4/inode.c       |  7 +---
 fs/ext4/ioctl.c       | 10 +-----
 fs/jbd2/journal.c     |  2 ++
 8 files changed, 10 insertions(+), 99 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 0613dfcbfd4a..5a35768d6149 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -246,7 +246,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
@@ -264,7 +263,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5..89bf10d020c9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1057,9 +1057,6 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
-	/* Number of ongoing updates on this inode */
-	atomic_t  i_fc_updates;
-
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -2928,8 +2925,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
 void ext4_fc_start_ineligible(struct super_block *sb, int reason);
 void ext4_fc_stop_ineligible(struct super_block *sb);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0ecf819bf189..703feff8cb8c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4697,8 +4697,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
-
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		ret = ext4_punch_hole(inode, offset, len);
 		goto exit;
@@ -4762,7 +4760,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f32b445582a..084ab4d4e2ce 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -58,11 +58,6 @@
  *     section for more details).
  * [7] Wait for [4], [5] and [6] to complete.
  *
- * All the inode updates must call ext4_fc_start_update() before starting an
- * update. If such an ongoing update is present, fast commit waits for it to
- * complete. The completion of such an update is marked by
- * ext4_fc_stop_update().
- *
  * Fast Commit Ineligibility
  * -------------------------
  * Not all operations are supported by fast commits today (e.g extended
@@ -166,15 +161,13 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Make fast commit atomic updates more fine grained. Today, a fast commit
- *    eligible update must be protected within ext4_fc_start_update() and
- *    ext4_fc_stop_update(). These routines are called at much higher
- *    routines. This can be made more fine grained by combining with
- *    ext4_journal_start().
- *
- * 2) Same above for ext4_fc_start_ineligible() and ext4_fc_stop_ineligible()
+ * 1) Instead of having ext4_fc_start_ineligible() and
+ *    ext4_fc_stop_ineligible(), add an argument to jbd2__journal_start() and
+ *    jbd2__journal_stop(), that way fast commit eligibility of an operation is
+ *    completely maintained with jbd2. If we do that, we would also move
+ *    EXT4_MF_FC_INELIGIBLE flag to jbd2.
  *
- * 3) Handle more ineligible cases.
+ * 2) Handle more ineligible cases.
  */
 
 #include <trace/events/ext4.h>
@@ -212,7 +205,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	init_waitqueue_head(&ei->i_fc_wait);
-	atomic_set(&ei->i_fc_updates, 0);
 }
 
 /* This function must be called with sbi->s_fc_lock held. */
@@ -240,50 +232,6 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
 	finish_wait(wq, &wait.wq_entry);
 }
 
-/*
- * Inform Ext4's fast about start of an inode update
- *
- * This function is called by the high level call VFS callbacks before
- * performing any inode update. This function blocks if there's an ongoing
- * fast commit on the inode in question.
- */
-void ext4_fc_start_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	if (list_empty(&ei->i_fc_list))
-		goto out;
-
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
-	}
-out:
-	atomic_inc(&ei->i_fc_updates);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-}
-
-/*
- * Stop inode update and wake up waiting fast commits if any.
- */
-void ext4_fc_stop_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-	if (atomic_dec_and_test(&ei->i_fc_updates))
-		wake_up_all(&ei->i_fc_wait);
-}
-
 /*
  * Remove inode from fast commit list. If the inode is being committed
  * we wait until inode commit is done.
@@ -933,18 +881,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
-		while (atomic_read(&ei->i_fc_updates)) {
-			DEFINE_WAIT(wait);
-
-			prepare_to_wait(&ei->i_fc_wait, &wait,
-						TASK_UNINTERRUPTIBLE);
-			if (atomic_read(&ei->i_fc_updates)) {
-				spin_unlock(&sbi->s_fc_lock);
-				schedule();
-				spin_lock(&sbi->s_fc_lock);
-			}
-			finish_wait(&ei->i_fc_wait, &wait);
-		}
 		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(ei->jinode);
 		if (ret)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 4c5f41052351..8cc11715518a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -259,7 +259,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -271,7 +270,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -552,9 +550,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..82f555d26980 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5320,7 +5320,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5344,7 +5344,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5356,7 +5355,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5370,12 +5368,10 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
-				ext4_fc_stop_update(inode);
 				return -EFBIG;
 			}
 		}
 		if (!S_ISREG(inode->i_mode)) {
-			ext4_fc_stop_update(inode);
 			return -EINVAL;
 		}
 
@@ -5499,7 +5495,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..e64a12e1218a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -743,7 +743,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
 
@@ -764,7 +763,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
 out:
-	ext4_fc_stop_update(inode);
 	return err;
 }
 
@@ -1273,13 +1271,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	long ret;
-
-	ext4_fc_start_update(file_inode(filp));
-	ret = __ext4_ioctl(filp, cmd, arg);
-	ext4_fc_stop_update(file_inode(filp));
-
-	return ret;
+	return __ext4_ioctl(filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 35302bc192eb..0b86a4365b66 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,6 +757,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -768,6 +769,7 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
+	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0);
 	write_lock(&journal->j_state_lock);
-- 
2.34.1.173.g76aa8bc2d0-goog

