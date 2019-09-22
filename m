Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00B8BA14F
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2019 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfIVHFV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Sep 2019 03:05:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43182 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbfIVHFU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Sep 2019 03:05:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Td15m7I_1569135913;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Td15m7I_1569135913)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Sep 2019 15:05:15 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Subject: [RFC 1/2] jbd2: checkpoint asynchronously when free journal space is lower than threshold
Date:   Sun, 22 Sep 2019 15:04:58 +0800
Message-Id: <20190922070459.39797-2-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20190922070459.39797-1-xiaoguang.wang@linux.alibaba.com>
References: <20190922070459.39797-1-xiaoguang.wang@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In current jbd2's implemention, jbd2 won't reclaim journal space unless
free journal space is lower than specified threshold, see logic in
add_transaction_credits():
        write_lock(&journal->j_state_lock);
        if (jbd2_log_space_left(journal) < jbd2_space_needed(journal))
            __jbd2_log_wait_for_space(journal);
        write_unlock(&journal->j_state_lock);
Indeed with this logic, we can also have many transactions queued to be
checkpointd, which means these transactions still occupy jbd2 space.

Recently I have seen some disadvantages caused by this logic:
Some of our applications will get stuck in below stack periodically:
        __jbd2_log_wait_for_space+0xd5/0x200 [jbd2]
        start_this_handle+0x31b/0x8f0 [jbd2]
        jbd2__journal_start+0xcd/0x1f0 [jbd2]
        __ext4_journal_start_sb+0x69/0xe0 [ext4]
        ext4_dirty_inode+0x32/0x70 [ext4]
        __mark_inode_dirty+0x15f/0x3a0
        generic_update_time+0x87/0xe0
        file_update_time+0xbd/0x120
        __generic_file_aio_write+0x198/0x3e0
        generic_file_aio_write+0x5d/0xc0
        ext4_file_write+0xb5/0x460 [ext4]
        do_sync_write+0x8d/0xd0
        vfs_write+0xbd/0x1e0
        SyS_write+0x7f/0xe0

Meanwhile I found io usage in these applications' machines are relatively
low, journal space is somewhat like a global lock. In high concurrency case,
if many tasks contend for journal credits, they will easily hit above stack
and be stuck in waitting for free journal space, so I wonder whether we can
reclaim journal space asynchronously when free space is lower than a specified
threshold, to avoid that all applications are stalled at the same time.

This will be more useful in high speed store, journal space will be reclaimed
in background quickly, and applications will less likely to be stucked by above
issue. To improve this case, we use workqueue to queue a work in background to
reclaim journal space.

And see performance improvements in following patch:
    ext4: add async_checkpoint mount option

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/checkpoint.c  | 28 +++++++++++++++++++++++++---
 fs/jbd2/journal.c     | 15 +++++++++++++--
 fs/jbd2/transaction.c | 16 ++++++++++++++++
 include/linux/jbd2.h  | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index a190906..fdaf87c 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -100,6 +100,21 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
 }
 
 /*
+ * Do transaction checkpoint asynchronously.
+ */
+void jbd2_log_do_checkpoint_async(struct work_struct *work)
+{
+	journal_t *journal = container_of(work, journal_t, j_checkpoint_work);
+
+	mutex_lock_io(&journal->j_checkpoint_mutex);
+	jbd2_log_do_checkpoint(journal, 1);
+	mutex_unlock(&journal->j_checkpoint_mutex);
+	WRITE_ONCE(journal->j_async_checkpoint_run, 0);
+}
+EXPORT_SYMBOL(jbd2_log_do_checkpoint_async);
+
+
+/*
  * __jbd2_log_wait_for_space: wait until there is space in the journal.
  *
  * Called under j-state_lock *only*.  It will be unlocked if we have to wait
@@ -142,7 +157,7 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			write_unlock(&journal->j_state_lock);
 			if (chkpt) {
-				jbd2_log_do_checkpoint(journal);
+				jbd2_log_do_checkpoint(journal, 0);
 			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
 				/* We were able to recover space; yay! */
 				;
@@ -201,7 +216,7 @@ void __jbd2_log_wait_for_space(journal_t *journal)
  * The journal should be locked before calling this function.
  * Called with j_checkpoint_mutex held.
  */
-int jbd2_log_do_checkpoint(journal_t *journal)
+int jbd2_log_do_checkpoint(journal_t *journal, int async)
 {
 	struct journal_head	*jh;
 	struct buffer_head	*bh;
@@ -277,7 +292,14 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
-			jbd2_log_start_commit(journal, tid);
+
+			/*
+			 * It's from async checkpoint routine, which means it's
+			 * low priority, so here don't kick transaction commit
+			 * early.
+			 */
+			if (!async)
+				jbd2_log_start_commit(journal, tid);
 			/*
 			 * jbd2_journal_commit_transaction() may want
 			 * to take the checkpoint_mutex if JBD2_FLUSHED
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 43df0c9..4fd198254e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1184,6 +1184,16 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	return NULL;
 }
 
+void jbd2_journal_destroy_async_checkpoint_wq(journal_t *journal)
+{
+	if (!journal->j_checkpoint_wq)
+		return;
+	flush_workqueue(journal->j_checkpoint_wq);
+	destroy_workqueue(journal->j_checkpoint_wq);
+	journal->j_checkpoint_wq = NULL;
+}
+EXPORT_SYMBOL(jbd2_journal_destroy_async_checkpoint_wq);
+
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
  *
  * Create a journal structure assigned some fixed set of disk blocks to
@@ -1719,6 +1729,7 @@ int jbd2_journal_destroy(journal_t *journal)
 	if (journal->j_running_transaction)
 		jbd2_journal_commit_transaction(journal);
 
+	jbd2_journal_destroy_async_checkpoint_wq(journal);
 	/* Force any old transactions to disk */
 
 	/* Totally anal locking here... */
@@ -1726,7 +1737,7 @@ int jbd2_journal_destroy(journal_t *journal)
 	while (journal->j_checkpoint_transactions != NULL) {
 		spin_unlock(&journal->j_list_lock);
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		err = jbd2_log_do_checkpoint(journal);
+		err = jbd2_log_do_checkpoint(journal, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 		/*
 		 * If checkpointing failed, just free the buffers to avoid
@@ -1990,7 +2001,7 @@ int jbd2_journal_flush(journal_t *journal)
 	while (!err && journal->j_checkpoint_transactions != NULL) {
 		spin_unlock(&journal->j_list_lock);
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		err = jbd2_log_do_checkpoint(journal);
+		err = jbd2_log_do_checkpoint(journal, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 		spin_lock(&journal->j_list_lock);
 	}
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8ca4fdd..c5a50a9 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -204,6 +204,7 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 	transaction_t *t = journal->j_running_transaction;
 	int needed;
 	int total = blocks + rsv_blocks;
+	unsigned int async_ckpt_thresh;
 
 	/*
 	 * If the current transaction is locked down for commit, wait
@@ -248,6 +249,21 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 	}
 
 	/*
+	 * When the percentage of free jounal space is lower than user specified
+	 * threshold, start to do transaction checkpoint asynchronously.
+	 */
+	if (journal->j_flags & JBD2_ASYNC_CHECKPOINT &&
+	    READ_ONCE(journal->j_async_checkpoint_run) == 0) {
+		async_ckpt_thresh = journal->j_async_checkpoint_thresh *
+					journal->j_maxlen / 100;
+		if (jbd2_log_space_left(journal) < async_ckpt_thresh) {
+			journal->j_async_checkpoint_run = 1;
+			queue_work(journal->j_checkpoint_wq,
+					&journal->j_checkpoint_work);
+		}
+	}
+
+	/*
 	 * The commit code assumes that it can get enough log space
 	 * without forcing a checkpoint.  This is *critical* for
 	 * correctness: a checkpoint of a buffer which is also
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5c04181..e9b80fb 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -46,6 +46,11 @@
  */
 #define JBD2_DEFAULT_MAX_COMMIT_AGE 5
 
+/*
+ * The default percentage threshold for async checkpoint.
+ */
+#define JBD2_DEFAULT_ASYCN_CHECKPOINT_THRESH	50
+
 #ifdef CONFIG_JBD2_DEBUG
 /*
  * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
@@ -814,6 +819,21 @@ struct journal_s
 	transaction_t		*j_checkpoint_transactions;
 
 	/**
+	 * @j_async_checkpoint_thresh
+	 *
+	 * When the percentage of free jounal space is lower than this value,
+	 * start to do transaction checkpoint asynchronously.
+	 */
+	int j_async_checkpoint_thresh;
+
+	/**
+	 * @j_num_checkpoint_transactions:
+	 *
+	 * Number of transactions to be checkpointed.
+	 */
+	int			j_num_checkpoint_transactions;
+
+	/**
 	 * @j_wait_transaction_locked:
 	 *
 	 * Wait queue for waiting for a locked transaction to start committing,
@@ -1136,6 +1156,27 @@ struct journal_s
 	 */
 	__u32 j_csum_seed;
 
+	/**
+	 * @j_async_checkpoint_run:
+	 *
+	 * Is there a work running asynchronously to do transaction checkpoint.
+	 */
+	int j_async_checkpoint_run;
+
+	/**
+	 * @j_checkpoint_work:
+	 *
+	 * Work_struct to do transaction checkpoint.
+	 */
+	struct work_struct j_checkpoint_work;
+
+	/**
+	 * @j_checkpoint_wq:
+	 *
+	 * Workqueue for doing transaction checkpoint asynchronously.
+	 */
+	struct workqueue_struct *j_checkpoint_wq;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/**
 	 * @j_trans_commit_map:
@@ -1234,6 +1275,9 @@ struct journal_s
 						 * mode */
 #define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
 
+/* Do transaction checkpoint initiatively and asynchronously.*/
+#define JBD2_ASYNC_CHECKPOINT	0x100
+
 /*
  * Function declarations for the journaling transaction and buffer
  * management
@@ -1366,6 +1410,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
+extern void jbd2_journal_destroy_async_checkpoint_wq(journal_t *journal);
 extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
 				unsigned long long start, int len, int bsize);
@@ -1474,7 +1519,8 @@ extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
 int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
 int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
-int jbd2_log_do_checkpoint(journal_t *journal);
+int jbd2_log_do_checkpoint(journal_t *journal, int async);
+void jbd2_log_do_checkpoint_async(struct work_struct *work);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
 
 void __jbd2_log_wait_for_space(journal_t *journal);
-- 
1.8.3.1

