Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98328FA31
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgJOUiT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbgJOUiQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC7C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id az3so86398pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6X316R7LPxyQnrmphVNhttMorXQDLg3NFYPqja0t/qM=;
        b=JcqfifeqrW7ZonROHzoIA8RjzF/QbTC9C3UCP7Ac+eyDXPhrxp9xvYEKgYhwdMxjan
         DUn1aeUoxLiZ/sKqDnd1m+M4JZqJvdKDzjL2ewzJYjNGF5UA6q4eY6EPQeSIDlo+jK2q
         I7QwacZtxIzECjgirm6VXU/XP0Ek0nYLFz7Q7Eqn0nCrZI8gyqBtmCFBf2oOrt6D35pH
         5KwE5LIv23cJvwA5dKjKj6njggJTvpuC2opxdJWw9dh8izQZLOEbxxjhrC87QgDjf8ia
         aMtDPXsLkUvH37QN3A0UyQ8IStHNGk7OaAxtNAcYQbrTTAqxCRfNlghzApPKnE1dIBCW
         hNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6X316R7LPxyQnrmphVNhttMorXQDLg3NFYPqja0t/qM=;
        b=AD9YsXjzJ3/PUANMJTtym4Nxz/DC3wV9d1itP1gmTOpRwt6vXMxo8vDCXB3ySpSvXg
         t04HmsifmW3NCKdjSksYMaSwTlwhRCGsEIzTD/eNjj5GURRLkeHc7t2ZZSI8uFA8o3YX
         fiZd1GiZ0vMyW2vOsbtrQafIfqe5io4sGhAa1fN2Aq4fuMwA/RZrWMfk0wFX80T7MkDS
         Lt5I7by/F0BwL5nV4WdJ+antUgEiLtdCutsadwFEqvt4dweGl7C4aWuWZFIHajacsRbr
         /OFG1TWWd1LrD4ytURR9ksNQCfOwNuhNadyvVbbTLnBw2y+hejcaRWv1txgIRp8VXB4K
         P34Q==
X-Gm-Message-State: AOAM533pE49KIdOWParDPNNbOErWmbn8P872EBnSYzLOWq6V7ZpB8ihQ
        NxlKPA/c5wn2n6TBdhV2pqmSRqDDUig=
X-Google-Smtp-Source: ABdhPJx0nRt24ikfay/Uwo8/j/+BaWYH2ghG1OMO/206HjHvgZQBfa+lQxUnc9KE/uJq+ySd+kyxfg==
X-Received: by 2002:a17:902:b70d:b029:d2:6277:385f with SMTP id d13-20020a170902b70db02900d26277385fmr325147pls.25.1602794294320;
        Thu, 15 Oct 2020 13:38:14 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:13 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 4/9] jbd2: add fast commit machinery
Date:   Thu, 15 Oct 2020 13:37:56 -0700
Message-Id: <20201015203802.3597742-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This functions adds necessary APIs needed in JBD2 layer for fast
commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c |   8 ++
 fs/jbd2/commit.c      |  44 ++++++++++
 fs/jbd2/journal.c     | 190 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/jbd2.h  |  27 ++++++
 4 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0dad8bdb1253..f2d11b4c6b62 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -8,11 +8,19 @@
  * Ext4 fast commits routines.
  */
 #include "ext4_jbd2.h"
+/*
+ * Fast commit cleanup routine. This is called after every fast commit and
+ * full commit. full is true if we are called after a full commit.
+ */
+static void ext4_fc_cleanup(journal_t *journal, int full)
+{
+}
 
 void ext4_fc_init(struct super_block *sb, journal_t *journal)
 {
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return;
+	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
 	if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
 		pr_warn("Error while enabling fast commits, turning off.");
 		ext4_clear_feature_fast_commit(sb);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6252b4c50666..fa688e163a80 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -206,6 +206,30 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 	return generic_writepages(mapping, &wbc);
 }
 
+/* Send all the data buffers related to an inode */
+int jbd2_submit_inode_data(struct jbd2_inode *jinode)
+{
+
+	if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
+		return 0;
+
+	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
+	return jbd2_journal_submit_inode_data_buffers(jinode);
+
+}
+EXPORT_SYMBOL(jbd2_submit_inode_data);
+
+int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
+{
+	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
+		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
+		return 0;
+	return filemap_fdatawait_range_keep_errors(
+		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
+		jinode->i_dirty_end);
+}
+EXPORT_SYMBOL(jbd2_wait_inode_data);
+
 /*
  * Submit all the data buffers of inode associated with the transaction to
  * disk.
@@ -415,6 +439,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(journal->j_running_transaction != NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
+	while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_fc_wait, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		write_lock(&journal->j_state_lock);
+		finish_wait(&journal->j_fc_wait, &wait);
+	}
+	write_unlock(&journal->j_state_lock);
+
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
@@ -422,6 +460,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_fc_off = 0;
 	J_ASSERT(commit_transaction->t_state == T_RUNNING);
 	commit_transaction->t_state = T_LOCKED;
 
@@ -1121,12 +1160,16 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	if (journal->j_commit_callback)
 		journal->j_commit_callback(journal, commit_transaction);
+	if (journal->j_fc_cleanup_callback)
+		journal->j_fc_cleanup_callback(journal, 1);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
 	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
@@ -1138,6 +1181,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_unlock(&journal->j_list_lock);
 	write_unlock(&journal->j_state_lock);
 	wake_up(&journal->j_wait_done_commit);
+	wake_up(&journal->j_fc_wait);
 
 	/*
 	 * Calculate overall stats
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 4497bfbac527..0c7c42bd530f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -159,7 +159,9 @@ static void commit_timeout(struct timer_list *t)
  *
  * 1) COMMIT:  Every so often we need to commit the current state of the
  *    filesystem to disk.  The journal thread is responsible for writing
- *    all of the metadata buffers to disk.
+ *    all of the metadata buffers to disk. If a fast commit is ongoing
+ *    journal thread waits until it's done and then continues from
+ *    there on.
  *
  * 2) CHECKPOINT: We cannot reuse a used section of the log file until all
  *    of the data in that part of the log has been rewritten elsewhere on
@@ -716,6 +718,75 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	return err;
 }
 
+/*
+ * Start a fast commit. If there's an ongoing fast or full commit wait for
+ * it to complete. Returns 0 if a new fast commit was started. Returns -EALREADY
+ * if a fast commit is not needed, either because there's an already a commit
+ * going on or this tid has already been committed. Returns -EINVAL if no jbd2
+ * commit has yet been performed.
+ */
+int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
+{
+	/*
+	 * Fast commits only allowed if at least one full commit has
+	 * been processed.
+	 */
+	if (!journal->j_stats.ts_tid)
+		return -EINVAL;
+
+	if (tid <= journal->j_commit_sequence)
+		return -EALREADY;
+
+	write_lock(&journal->j_state_lock);
+	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+	    (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_fc_wait, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		finish_wait(&journal->j_fc_wait, &wait);
+		return -EALREADY;
+	}
+	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(jbd2_fc_begin_commit);
+
+/*
+ * Stop a fast commit. If fallback is set, this function starts commit of
+ * TID tid before any other fast commit can start.
+ */
+static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
+{
+	if (journal->j_fc_cleanup_callback)
+		journal->j_fc_cleanup_callback(journal, 0);
+	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
+	if (fallback)
+		journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+	wake_up(&journal->j_fc_wait);
+	if (fallback)
+		return jbd2_complete_transaction(journal, tid);
+	return 0;
+}
+
+int jbd2_fc_end_commit(journal_t *journal)
+{
+	return __jbd2_fc_end_commit(journal, 0, 0);
+}
+EXPORT_SYMBOL(jbd2_fc_end_commit);
+
+int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid)
+{
+	return __jbd2_fc_end_commit(journal, tid, 1);
+}
+EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
+
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
@@ -784,6 +855,110 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
 	return jbd2_journal_bmap(journal, blocknr, retp);
 }
 
+/* Map one fast commit buffer for use by the file system */
+int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
+{
+	unsigned long long pblock;
+	unsigned long blocknr;
+	int ret = 0;
+	struct buffer_head *bh;
+	int fc_off;
+
+	*bh_out = NULL;
+	write_lock(&journal->j_state_lock);
+
+	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
+		fc_off = journal->j_fc_off;
+		blocknr = journal->j_fc_first + fc_off;
+		journal->j_fc_off++;
+	} else {
+		ret = -EINVAL;
+	}
+	write_unlock(&journal->j_state_lock);
+
+	if (ret)
+		return ret;
+
+	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
+	if (ret)
+		return ret;
+
+	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
+	if (!bh)
+		return -ENOMEM;
+
+	lock_buffer(bh);
+
+	clear_buffer_uptodate(bh);
+	set_buffer_dirty(bh);
+	unlock_buffer(bh);
+	journal->j_fc_wbuf[fc_off] = bh;
+
+	*bh_out = bh;
+
+	return 0;
+}
+EXPORT_SYMBOL(jbd2_fc_get_buf);
+
+/*
+ * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
+ * for completion.
+ */
+int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
+{
+	struct buffer_head *bh;
+	int i, j_fc_off;
+
+	read_lock(&journal->j_state_lock);
+	j_fc_off = journal->j_fc_off;
+	read_unlock(&journal->j_state_lock);
+
+	/*
+	 * Wait in reverse order to minimize chances of us being woken up before
+	 * all IOs have completed
+	 */
+	for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
+		bh = journal->j_fc_wbuf[i];
+		wait_on_buffer(bh);
+		put_bh(bh);
+		journal->j_fc_wbuf[i] = NULL;
+		if (unlikely(!buffer_uptodate(bh)))
+			return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(jbd2_fc_wait_bufs);
+
+/*
+ * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
+ * for completion.
+ */
+int jbd2_fc_release_bufs(journal_t *journal)
+{
+	struct buffer_head *bh;
+	int i, j_fc_off;
+
+	read_lock(&journal->j_state_lock);
+	j_fc_off = journal->j_fc_off;
+	read_unlock(&journal->j_state_lock);
+
+	/*
+	 * Wait in reverse order to minimize chances of us being woken up before
+	 * all IOs have completed
+	 */
+	for (i = j_fc_off - 1; i >= 0; i--) {
+		bh = journal->j_fc_wbuf[i];
+		if (!bh)
+			break;
+		put_bh(bh);
+		journal->j_fc_wbuf[i] = NULL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(jbd2_fc_release_bufs);
+
 /*
  * Conversion of logical to physical block numbers for the journal
  *
@@ -1142,6 +1317,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	init_waitqueue_head(&journal->j_fc_wait);
 	mutex_init(&journal->j_abort_mutex);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
@@ -1495,6 +1671,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1508,9 +1685,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		/*
+		 * When journal is clean, no need to commit fast commit flag and
+		 * make file system incompatible with older kernels.
+		 */
+		jbd2_clear_feature_fast_commit(journal);
+		had_fast_commit = true;
+	}
 
 	jbd2_write_superblock(journal, write_op);
 
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
+
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 008629b4d615..a009d9b9c620 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -861,6 +861,13 @@ struct journal_s
 	 */
 	wait_queue_head_t	j_wait_reserved;
 
+	/**
+	 * @j_fc_wait:
+	 *
+	 * Wait queue to wait for completion of async fast commits.
+	 */
+	wait_queue_head_t	j_fc_wait;
+
 	/**
 	 * @j_checkpoint_mutex:
 	 *
@@ -1232,6 +1239,15 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+
+	/**
+	 * @j_fc_cleanup_callback:
+	 *
+	 * Clean-up after fast commit or full commit. JBD2 calls this function
+	 * after every commit operation.
+	 */
+	void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
+
 };
 
 #define jbd2_might_wait_for_commit(j) \
@@ -1316,6 +1332,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
 						 * data write error in ordered
 						 * mode */
+#define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
+#define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 
 /*
  * Function declarations for the journaling transaction and buffer
@@ -1574,6 +1592,15 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
 
 /* Fast commit related APIs */
 int jbd2_fc_init(journal_t *journal, int num_fc_blks);
+int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
+int jbd2_fc_end_commit(journal_t *journal);
+int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid);
+int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
+int jbd2_submit_inode_data(struct jbd2_inode *jinode);
+int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
+int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
+int jbd2_fc_release_bufs(journal_t *journal);
+
 /*
  * is_journal_abort
  *
-- 
2.29.0.rc1.297.gfa9743e501-goog

