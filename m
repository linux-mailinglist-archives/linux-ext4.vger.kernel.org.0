Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4C4A7F63
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 07:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiBCGrV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 01:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBCGrV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 01:47:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B28C061714
        for <linux-ext4@vger.kernel.org>; Wed,  2 Feb 2022 22:47:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id j10so1521659pgc.6
        for <linux-ext4@vger.kernel.org>; Wed, 02 Feb 2022 22:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XAw+4uRL9cCIRG7UnCt0jtZh4DKyLoFc/kYq5Vcthmo=;
        b=CUI9Kqt5nZ45JK1NVeLfY8n0PvJP3oNpKWAzzFaWC19hraC/AY2JO5kLDuoMyEH3bE
         wK8PY+ZqPdJIuKOhZDW0mpL6yB/yYhx/vQf2AENz/Q6TtRy4C1bBwKdpdmPFBO7NYb0g
         u+FyaVbZtFQ4M99oXmxWtLtHWCuNuq4OG1EE+ErxAa4MNwedSMA9gAq4kinBKECgZ3oL
         DGmkWVzwYtJp8BezRnpwWRGrJj280OJLcdkHBVtigMtU8UDO4WkUS237ey8Ity6Cmg6g
         Jee5VGVutfyZ/j+EQ5dm/mm4M3m1pkQLx8OhBJRbXNVp8q6tNnCy2ZNOvVEuWEZ5IQca
         yCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XAw+4uRL9cCIRG7UnCt0jtZh4DKyLoFc/kYq5Vcthmo=;
        b=YLT2++l+o6JrzkwlBHw+cZBPxEfKqpSJnkKVYk9KP+zeMzM9vFC21nHohobTMA5ARu
         PdDJHehR4fqoBmnkyJrjt3iGqBi/qL3G9CthVIyo3aL+lJ2oIdulNXN5d25TJy0WvHt5
         GZ8QSGgjdJG+0NjhNQeHDz+G0fnC8d2phsTudjDz//WhjR2p7AzDA/mgvZGejuEWyWme
         bi8Iok0WxZx50DwVusJxcIM8sStE3G8d7sH0Giv3v/MpJzG1bl+83i4kQyEtMxIyMI78
         NJ/a1RSR5BeHbt7d9rdwKYsWVYrjnkJIziGqtGpGenRi0HZtSvHdKdeANltmYXVSii/J
         Q6Kg==
X-Gm-Message-State: AOAM533sw5HBweBSKahS4uvJDyEc2QbwPY/1W9c5dR3bNRT7nAGNGAQ+
        Xn4qbig/m8r7f3iyCQgou9R77MYxwvA=
X-Google-Smtp-Source: ABdhPJzIXa2o39/2MNeu/xNISESrWwd4tM1FgTOp5efw+A/71iQoxQqLlJg59Nz1PdEeTmI/b16iXQ==
X-Received: by 2002:a63:e046:: with SMTP id n6mr26851490pgj.489.1643870840271;
        Wed, 02 Feb 2022 22:47:20 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:b9c2:41c:e6eb:263])
        by smtp.googlemail.com with ESMTPSA id t9sm8300648pjg.44.2022.02.02.22.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 22:47:19 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: remove journal barrier during fast commit
Date:   Wed,  2 Feb 2022 22:46:59 -0800
Message-Id: <20220203064659.1438701-1-harshads@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

In commit 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69 ("ext4: use
ext4_journal_start/stop for fast commit transactions"), journal
barrier was introduced in fast commit path as an intermediate step for
fast commit API migration. This patch removes the journal barrier to
improve the fast commit performance. Instead of blocking the entire
journal before starting the fast commit, this patch only blocks the
inode that is being committed during a fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  6 ++---
 fs/ext4/ext4_jbd2.c   | 57 +++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h   | 13 +++-------
 fs/ext4/fast_commit.c | 30 ++++++++++++++---------
 fs/ext4/fast_commit.h |  1 +
 fs/ext4/ialloc.c      |  1 +
 fs/ext4/inode.c       |  1 -
 fs/ext4/super.c       |  1 -
 fs/jbd2/journal.c     |  2 --
 include/linux/jbd2.h  |  4 +++
 10 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 09d8f60ebf0f..a72667c19ebe 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2924,9 +2924,9 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
-void ext4_fc_del(struct inode *inode);
+void ext4_fc_start_update(handle_t *handle, struct inode *inode);
+void ext4_fc_stop_update(handle_t *handle);
+void ext4_fc_del(handle_t *handle, struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 3477a16d08ae..16321f89934c 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -106,6 +106,61 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 				   GFP_NOFS, type, line);
 }
 
+handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
+				  int type, int blocks, int rsv_blocks,
+				  int revoke_creds)
+{
+	handle_t *handle;
+	journal_t *journal;
+	int err;
+
+	trace_ext4_journal_start(inode->i_sb, blocks, rsv_blocks, revoke_creds,
+				 _RET_IP_);
+	err = ext4_journal_check_start(inode->i_sb);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	journal = EXT4_SB(inode->i_sb)->s_journal;
+	if (!journal || (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return ext4_get_nojournal();
+
+	handle = jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
+				     GFP_NOFS, type, line);
+
+	if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT)
+	    && !IS_ERR(handle)
+	    && !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE)) {
+		if (handle->h_ref == 1) {
+			WARN_ON(handle->h_priv != NULL);
+			ext4_fc_start_update(handle, inode);
+			handle->h_priv = inode;
+			return handle;
+		}
+		/*
+		 * Check if this is a nested transaction that modifies multiple
+		 * inodes. Such a transaction is fast commit ineligible.
+		 */
+		if (handle->h_priv != inode)
+			ext4_fc_mark_ineligible(inode->i_sb,
+						EXT4_FC_REASON_TOO_MANY_INODES,
+						handle);
+	}
+
+	return handle;
+}
+
+/* Stop fast commit update on the inode in this handle, if any. */
+static void ext4_fc_journal_stop(handle_t *handle)
+{
+	if (!handle->h_priv || handle->h_ref > 1)
+		return;
+	/*
+	 * We have an inode and this is the top level __ext4_journal_stop call.
+	 */
+	ext4_fc_stop_update(handle);
+	handle->h_priv = NULL;
+}
+
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
 {
 	struct super_block *sb;
@@ -119,11 +174,13 @@ int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
 
 	err = handle->h_err;
 	if (!handle->h_transaction) {
+		ext4_fc_journal_stop(handle);
 		rc = jbd2_journal_stop(handle);
 		return err ? err : rc;
 	}
 
 	sb = handle->h_transaction->t_journal->j_private;
+	ext4_fc_journal_stop(handle);
 	rc = jbd2_journal_stop(handle);
 
 	if (!err)
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index db2ae4a2b38d..e408622fe896 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -302,6 +302,10 @@ static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
 	return ext4_free_metadata_revoke_credits(sb, 8);
 }
 
+handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
+			       int type, int blocks, int rsv_blocks,
+			       int revoke_creds);
+
 #define ext4_journal_start_sb(sb, type, nblocks)			\
 	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0,	\
 				ext4_trans_default_revoke_credits(sb))
@@ -318,15 +322,6 @@ static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
 	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
 			     (revoke_creds))
 
-static inline handle_t *__ext4_journal_start(struct inode *inode,
-					     unsigned int line, int type,
-					     int blocks, int rsv_blocks,
-					     int revoke_creds)
-{
-	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
-				       rsv_blocks, revoke_creds);
-}
-
 #define ext4_journal_stop(handle) \
 	__ext4_journal_stop(__func__, __LINE__, (handle))
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7964ee34e322..667f06c44e4e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -156,13 +156,7 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
- *
- * 2) Handle more ineligible cases.
+ * 1) Handle more ineligible cases.
  */
 
 #include <trace/events/ext4.h>
@@ -235,7 +229,7 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
  * performing any inode update. This function blocks if there's an ongoing
  * fast commit on the inode in question.
  */
-void ext4_fc_start_update(struct inode *inode)
+void ext4_fc_start_update(handle_t *handle, struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
@@ -255,13 +249,15 @@ void ext4_fc_start_update(struct inode *inode)
 out:
 	atomic_inc(&ei->i_fc_updates);
 	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	ext4_fc_track_inode(handle, inode);
 }
 
 /*
  * Stop inode update and wake up waiting fast commits if any.
  */
-void ext4_fc_stop_update(struct inode *inode)
+void ext4_fc_stop_update(handle_t *handle)
 {
+	struct inode *inode = handle->h_priv;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
@@ -276,7 +272,7 @@ void ext4_fc_stop_update(struct inode *inode)
  * Remove inode from fast commit list. If the inode is being committed
  * we wait until inode commit is done.
  */
-void ext4_fc_del(struct inode *inode)
+void ext4_fc_del(handle_t *handle, struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
@@ -292,7 +288,18 @@ void ext4_fc_del(struct inode *inode)
 	}
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+		/*
+		 * This inode is being committed using fast commit. We need to
+		 * temporarily pause the handle in order to let the commit
+		 * finish. When we reach here, inode->i_size has been set to 0,
+		 * so if we crash after the fast commit completes, the replay
+		 * code will ensure that the inode gets properly truncated and
+		 * removed. So, it is safe to stop the fast commit transaction
+		 * now and let the fast commit go through.
+		 */
+		ext4_fc_stop_update(handle);
 		ext4_fc_wait_committing_inode(inode);
+		ext4_fc_start_update(handle, inode);
 		goto restart;
 	}
 	list_del_init(&ei->i_fc_list);
@@ -2140,7 +2147,8 @@ static const char *fc_ineligible_reasons[] = {
 	"Dir renamed",
 	"Falloc range op",
 	"Data journalling",
-	"FC Commit Failed"
+	"FC Commit Failed",
+	"Too many inodes in a transaction",
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 083ad1cb705a..ea21a9397125 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -94,6 +94,7 @@ enum {
 	EXT4_FC_REASON_FALLOC_RANGE,
 	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_COMMIT_FAILED,
+	EXT4_FC_REASON_TOO_MANY_INODES,
 	EXT4_FC_REASON_MAX
 };
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f73e5eb43eae..26d645b7a74c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -274,6 +274,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 
 	is_directory = S_ISDIR(inode->i_mode);
 
+	ext4_fc_del(handle, inode);
 	/* Do this BEFORE marking the inode not in use or returning an error */
 	ext4_clear_inode(inode);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d2a29fc93742..5edac6f6f7d3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5658,7 +5658,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 		put_bh(iloc->bh);
 		return -EIO;
 	}
-	ext4_fc_track_inode(handle, inode);
 
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d1c4b04e72ab..7cbe0084bb39 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1428,7 +1428,6 @@ static void destroy_inodecache(void)
 
 void ext4_clear_inode(struct inode *inode)
 {
-	ext4_fc_del(inode);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	ext4_discard_preallocations(inode, 0);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a654d22aa2f1..5327ba7f144a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,7 +757,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
-	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -769,7 +768,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 9c3ada74ffb1..f96d770931af 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -478,6 +478,9 @@ struct jbd2_revoke_table_s;
  * @h_requested_credits: Holds @h_total_credits after handle is started.
  * @h_revoke_credits_requested: Holds @h_revoke_credits after handle is started.
  * @saved_alloc_context: Saved context while transaction is open.
+ * @h_priv: private pointer for the client file system to store anything it
+ *      wants. Currently, ext4 uses it to store the inode on which this
+ *      transaction is happening. This is needed for fast commits.
  **/
 
 /* Docbook can't yet cope with the bit fields, but will leave the documentation
@@ -511,6 +514,7 @@ struct jbd2_journal_handle
 	unsigned int		h_requested_credits;
 
 	unsigned int		saved_alloc_context;
+	void		*h_priv;
 };
 
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

