Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEE9C80E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfHZDzS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:55:18 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51334 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbfHZDzS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Aug 2019 23:55:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TaQIzL6_1566791708;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TaQIzL6_1566791708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 11:55:16 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [RFC] jbd2: reclaim journal space asynchronously when free space is low
Date:   Mon, 26 Aug 2019 11:54:59 +0800
Message-Id: <20190826035459.4121-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
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
low, journal space is somewhat like a global lock, in high concurrency case,
if many tasks contend for journal credits, they will easily hit above stack
and be stuck in waitting for free journal space, so I wonder whether we can
reclaim journal space asynchronously when free space is lower than a specified
threshold, to avoid that all applications are stalled at the same time.

I think this will be more useful in high speed store, journal space will be
reclaimed in background quickly, and applications will less likely to be
stucked by above issue. To improve this case, we use workqueue to queue a
work in background to reclaim journal space.

I also construct a test case to verify improvement, test case will create
1000000 directories, use 1, 2, 4, 8 and 16 tasks per test round. For example,
in 8 tasks case, create 8 processes and every process creates 125000 directories,
16 tasks case, every process creates 62500 directories. Every test case run
5 iterations.

Tested in my vm(16cores, 8G memory), count the run time per test round.
Without this patch,
16 tasks:  35s 34s 33s 34s 34s total: 170s, avg: 34s
8  tasks:  33s 35s 34s 35s 35s total: 172s, avg: 34.4s
4  tasks:  36s 38s 39s 39s 41s total: 193s, avg: 38.6s
2  tasks:  53s 54s 52s 55s 54s total: 268s, avg: 53.6s
1  tasks:  65s 65s 65s 65s 64s total: 324s, avg: 64.8s

With this patch:
16 tasks:  29s 32s 32s 31s 33s total: 157s, avg: 31.4s
8  tasks:  30s 31s 30s 31s 30s total: 152s, avg: 30.4s
4  tasks:  33s 34s 32s 33s 37s total: 169s, avg: 33.8s
2  tasks:  47s 48s 46s 49s 48s total: 238s, avg: 47.6s
1  tasks:  56s 55s 56s 54s 55s total: 276s, avg: 55.2s

From above test, we can have 10% improvements.

Run same test in physical machine with nvme store, get such test results:
without patch(count the total time spending to create 5000000 sub-directories):
64 tasks  32 tasks 16 tasks  8 tasks  4 tasks  2 tasks  1 tasks
     66s       64s      67s      71s      81s     108s     133s
with patch:
64 tasks  32 tasks 16 tasks  8 tasks  4 tasks  2 tasks  1 tasks
    66s        64s      69s      72s      80s     103s     112s

Seems that improvements are only somewhat significant in low concurrency
case, I guess it's because that the checkpoint work in nvme is quick.
In high concurrency case, the overhead caused by waitting for log space
may not a big bottleneck, I'll look into this issue more.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/checkpoint.c  |  4 ++--
 fs/jbd2/journal.c     | 26 ++++++++++++++++++++++++++
 fs/jbd2/transaction.c | 12 +++++++++++-
 include/linux/jbd2.h  | 23 ++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index a1909066bde6..da0920cbc1d3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -105,12 +105,12 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
  * Called under j-state_lock *only*.  It will be unlocked if we have to wait
  * for a checkpoint to free up some space in the log.
  */
-void __jbd2_log_wait_for_space(journal_t *journal)
+void __jbd2_log_wait_for_space(journal_t *journal, int scale)
 {
 	int nblocks, space_left;
 	/* assert_spin_locked(&journal->j_state_lock); */
 
-	nblocks = jbd2_space_needed(journal);
+	nblocks = jbd2_space_needed(journal) * scale;
 	while (jbd2_log_space_left(journal) < nblocks) {
 		write_unlock(&journal->j_state_lock);
 		mutex_lock_io(&journal->j_checkpoint_mutex);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990eb70a9..871c3d251fdb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1100,6 +1100,21 @@ static void jbd2_stats_proc_exit(journal_t *journal)
 	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
 }
 
+/*
+ * Start to reclaim journal space asynchronously.
+ */
+void jbd2_reclaim_log_space_async(struct work_struct *work)
+{
+	journal_t *journal = container_of(work, journal_t, j_reclaim_work);
+
+	write_lock(&journal->j_state_lock);
+	/* See comments in add_transaction_credits() */
+	if (jbd2_log_space_left(journal) < jbd2_space_needed(journal) * 2)
+		__jbd2_log_wait_for_space(journal, 2);
+	journal->j_async_reclaim_run = 0;
+	write_unlock(&journal->j_state_lock);
+}
+
 /*
  * Management for journal control blocks: functions to create and
  * destroy journal_t structures, and to initialise and read existing
@@ -1142,6 +1157,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
 
+	journal->j_reclaim_wq = alloc_workqueue("jbd2-reclaim-wq",
+					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!journal->j_reclaim_wq) {
+		pr_err("%s: failed to create workqueue\n", __func__);
+		goto err_cleanup;
+	}
+	INIT_WORK(&journal->j_reclaim_work, jbd2_reclaim_log_space_async);
+	journal->j_async_reclaim_run = 0;
+
 	/* Set up a default-sized revoke table for the new mount. */
 	err = jbd2_journal_init_revoke(journal, JOURNAL_REVOKE_DEFAULT_HASH);
 	if (err)
@@ -1718,6 +1742,7 @@ int jbd2_journal_destroy(journal_t *journal)
 	if (journal->j_running_transaction)
 		jbd2_journal_commit_transaction(journal);
 
+	flush_workqueue(journal->j_reclaim_wq);
 	/* Force any old transactions to disk */
 
 	/* Totally anal locking here... */
@@ -1768,6 +1793,7 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
+	destroy_workqueue(journal->j_reclaim_wq);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..27f9d47c620e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -247,6 +247,16 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 		return 1;
 	}
 
+	/*
+	 * If free journal space is lower than (jbd2_space_needed(journal) * 2),
+	 * let's reclaim some journal space early and do it asynchronously.
+	 */
+	if (journal->j_async_reclaim_run == 0 &&
+	    jbd2_log_space_left(journal) < (jbd2_space_needed(journal) * 2)) {
+		journal->j_async_reclaim_run = 1;
+		queue_work(journal->j_reclaim_wq, &journal->j_reclaim_work);
+	}
+
 	/*
 	 * The commit code assumes that it can get enough log space
 	 * without forcing a checkpoint.  This is *critical* for
@@ -264,7 +274,7 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 		jbd2_might_wait_for_commit(journal);
 		write_lock(&journal->j_state_lock);
 		if (jbd2_log_space_left(journal) < jbd2_space_needed(journal))
-			__jbd2_log_wait_for_space(journal);
+			__jbd2_log_wait_for_space(journal, 1);
 		write_unlock(&journal->j_state_lock);
 		return 1;
 	}
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index df03825ad1a1..acc93597271b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1152,6 +1152,27 @@ struct journal_s
 	 */
 	__u32 j_csum_seed;
 
+	/**
+	 * @j_async_reclaim_run:
+	 *
+	 * Is there a work running asynchronously to reclaim journal space.
+	 */
+	int j_async_reclaim_run;
+
+	/**
+	 * @j_reclaim_work:
+	 *
+	 * Work_struct to reclaim journal space.
+	 */
+	struct work_struct j_reclaim_work;
+
+	/**
+	 * @j_reclaim_wq:
+	 *
+	 * Workqueue for reclaim journal space asynchronously.
+	 */
+	struct workqueue_struct *j_reclaim_wq;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/**
 	 * @j_trans_commit_map:
@@ -1498,7 +1519,7 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
 
-void __jbd2_log_wait_for_space(journal_t *journal);
+void __jbd2_log_wait_for_space(journal_t *journal, int scale);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
-- 
2.17.2

