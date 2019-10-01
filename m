Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86847C2E55
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbfJAHmF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33126 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJAHmF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so985951pgb.0
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM8JPDkZemhTgvJ+cN8giFPadOHPxunbdFock8wet+U=;
        b=UvWJ6ReoG0w56MjjKypwvfWRQfqbVDmSlwFBcCIOvBgWRDT2vCaJwbs5fwiAqgbfc3
         VCSF84VwBJf5JJUHPUT85rv9Z8hioy2qegByUnukU9ynRkNJ57cXeh1ueU0au/5uMJe1
         WgP71SpjkIXLZeoDiNczr27rJQGoSjlBT2IZZNbjUpQWsoTeW4ZftZu9VBp1bgAO3vX0
         sQUWB4pjQqVTqmQI37hX/66hYmCCc9OzD7AIQ+3sTbAJ+UENtA42jVKNYKSDds3u1/A0
         i1QpIgYlM8X5MeZqTn/Bif5u9SGhEkYjWvAJH7kOPMwchBugrhwNnmsxgphQDScthRzf
         hydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM8JPDkZemhTgvJ+cN8giFPadOHPxunbdFock8wet+U=;
        b=GndGMo7t2jeTW0B1D4azaxI2NpF3rjcHJGPFErtTd99pTM0EGGMNahuQz1Hp5KlVuT
         WaC6s72Fvq3ZwI3vdDjEa+unBVLCmqkLNSwQXwZ2wVGhx5gsTaa2lCYNnbQyUTGh6k1s
         ODvaZ4AapjTwP6jc5BKhW8hDS1e3thF/oMGqpg/F9Z331VyKTNs5mF+BF/QAEdmnBHI2
         M/sErlarWbnKe9dqdsUDlBWboTh45J3vax0N/Yy2DQbnIZue3g31ORGoT285KWFLld9M
         AgKpfpz77HtK7AVzrCu6H6z9PuZ86g/u1rLpb/G/LFy2cXRXvpHFYe2Xmv5m5FIb5YV0
         hNGg==
X-Gm-Message-State: APjAAAWOn3r9NnB1Zfqka6T1K/KCiJa3jmkBx3Qgts+ATAIpGReRrLbE
        4KIdDStw9EbVSGRGHx1y9yYf+VM0e38=
X-Google-Smtp-Source: APXvYqzEKbiZ06/z/XrO2QbDZWsH42ArNZYqDbJ8QTmhPqi+N+HAIy9Y50Q/wiaPtUSE7IigIeABMA==
X-Received: by 2002:a62:ac13:: with SMTP id v19mr27198774pfe.202.1569915723659;
        Tue, 01 Oct 2019 00:42:03 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:03 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 03/13] jbd2: fast-commit commit path changes
Date:   Tue,  1 Oct 2019 00:40:52 -0700
Message-Id: <20191001074101.256523-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds core fast-commit commit path changes. This patch also
modifies existing JBD2 APIs to allow usage of fast commits. If fast
commits are enabled and journal->j_do_full_commit is not set, the
commit routine tries the file system specific fast commmit first. Only
if it fails, it falls back to the full commit. Commit start and wait
routines have their own variants that support fast commits.

In this patch we also add a new entry to journal->stats which counts
the number of fast commits performed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c            | 55 ++++++++++++++++++++--
 fs/jbd2/journal.c           | 94 ++++++++++++++++++++++++++++++++-----
 fs/jbd2/transaction.c       |  1 +
 include/linux/jbd2.h        | 42 ++++++++++++++++-
 include/trace/events/jbd2.h |  9 ++--
 5 files changed, 182 insertions(+), 19 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 132fb92098c7..7db3e2b6336d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -351,8 +351,12 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
  *
  * The primary function for committing a transaction to the log.  This
  * function is called by the journal thread to begin a complete commit.
+ *
+ * fc is input / output parameter. If fc is non-null and is set to true, this
+ * function tries to perform fast commit. If the fast commit is successfully
+ * performed, *fc is set to true.
  */
-void jbd2_journal_commit_transaction(journal_t *journal)
+void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
 {
 	struct transaction_stats_s stats;
 	transaction_t *commit_transaction;
@@ -380,6 +384,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	tid_t first_tid;
 	int update_tail;
 	int csum_size = 0;
+	bool full_commit;
 	LIST_HEAD(io_bufs);
 	LIST_HEAD(log_bufs);
 
@@ -413,6 +418,44 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(journal->j_running_transaction != NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 
+	write_lock(&journal->j_state_lock);
+	full_commit = journal->j_do_full_commit;
+	write_unlock(&journal->j_state_lock);
+
+	/* Let file-system try its own fast commit */
+	if (jbd2_has_feature_fast_commit(journal)) {
+		if (!full_commit && fc && *fc == true &&
+		    journal->j_fc_commit_callback &&
+		    !journal->j_fc_commit_callback(
+			journal, journal->j_running_transaction->t_tid,
+			journal->j_running_transaction->t_subtid, &stats.run)) {
+			jbd_debug(3, "fast commit success.\n");
+			if (journal->j_fc_cleanup_callback)
+				journal->j_fc_cleanup_callback(journal);
+			write_lock(&journal->j_state_lock);
+			journal->j_fc_sequence = journal->j_running_transaction
+						 ->t_subtid;
+			journal->j_running_transaction->t_subtid++;
+			if (fc)
+				*fc = true;
+			write_unlock(&journal->j_state_lock);
+			trace_jbd2_run_stats(journal->j_fs_dev->bd_dev,
+					     journal->j_running_transaction
+					     ->t_tid,
+					     &stats.run, true);
+			goto update_overall_stats;
+		}
+		if (journal->j_fc_cleanup_callback)
+			journal->j_fc_cleanup_callback(journal);
+		write_lock(&journal->j_state_lock);
+		journal->j_do_full_commit = false;
+		write_unlock(&journal->j_state_lock);
+	}
+
+	jbd_debug(3, "fast commit not performed, trying full.\n");
+	if (fc)
+		*fc = false;
+
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
@@ -420,6 +463,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_fc_off = 0;
 	J_ASSERT(commit_transaction->t_state == T_RUNNING);
 	commit_transaction->t_state = T_LOCKED;
 
@@ -1085,12 +1129,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_handle_count =
 		atomic_read(&commit_transaction->t_handle_count);
 	trace_jbd2_run_stats(journal->j_fs_dev->bd_dev,
-			     commit_transaction->t_tid, &stats.run);
+			     commit_transaction->t_tid, &stats.run, false);
 	stats.ts_requested = (commit_transaction->t_requested) ? 1 : 0;
 
 	commit_transaction->t_state = T_COMMIT_CALLBACK;
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
 	journal->j_commit_sequence = commit_transaction->t_tid;
+	journal->j_fc_sequence = 0;
 	journal->j_committing_transaction = NULL;
 	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
 
@@ -1129,8 +1174,12 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	/*
 	 * Calculate overall stats
 	 */
+update_overall_stats:
 	spin_lock(&journal->j_history_lock);
-	journal->j_stats.ts_tid++;
+	if (fc && *fc == true)
+		journal->j_stats.ts_num_fast_commits++;
+	else
+		journal->j_stats.ts_tid++;
 	journal->j_stats.ts_requested += stats.ts_requested;
 	journal->j_stats.run.rs_wait += stats.run.rs_wait;
 	journal->j_stats.run.rs_request_delay += stats.run.rs_request_delay;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 7c13834873ad..6853064605ff 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -160,7 +160,13 @@ static void commit_timeout(struct timer_list *t)
  *
  * 1) COMMIT:  Every so often we need to commit the current state of the
  *    filesystem to disk.  The journal thread is responsible for writing
- *    all of the metadata buffers to disk.
+ *    all of the metadata buffers to disk. If fast commits are allowed,
+ *    journal thread passes the control to the file system and file system
+ *    is then responsible for writing metadata buffers to disk (in whichever
+ *    format it wants). If fast commit succeds, journal thread won't perform
+ *    a normal commit. In case the fast commit fails, journal thread performs
+ *    full commit as normal.
+ *
  *
  * 2) CHECKPOINT: We cannot reuse a used section of the log file until all
  *    of the data in that part of the log has been rewritten elsewhere on
@@ -172,6 +178,7 @@ static int kjournald2(void *arg)
 {
 	journal_t *journal = arg;
 	transaction_t *transaction;
+	bool fc_flag = true, fc_flag_save;
 
 	/*
 	 * Set up an interval timer which can be used to trigger a commit wakeup
@@ -209,9 +216,14 @@ static int kjournald2(void *arg)
 		jbd_debug(1, "OK, requests differ\n");
 		write_unlock(&journal->j_state_lock);
 		del_timer_sync(&journal->j_commit_timer);
-		jbd2_journal_commit_transaction(journal);
+		fc_flag_save = fc_flag;
+		jbd2_journal_commit_transaction(journal, &fc_flag);
 		write_lock(&journal->j_state_lock);
-		goto loop;
+		if (!fc_flag) {
+			/* fast commit not performed */
+			fc_flag = fc_flag_save;
+			goto loop;
+		}
 	}
 
 	wake_up(&journal->j_wait_done_commit);
@@ -235,16 +247,18 @@ static int kjournald2(void *arg)
 
 		prepare_to_wait(&journal->j_wait_commit, &wait,
 				TASK_INTERRUPTIBLE);
-		if (journal->j_commit_sequence != journal->j_commit_request)
+		if (!fc_flag &&
+		    journal->j_commit_sequence != journal->j_commit_request)
 			should_sleep = 0;
 		transaction = journal->j_running_transaction;
 		if (transaction && time_after_eq(jiffies,
-						transaction->t_expires))
+						 transaction->t_expires))
 			should_sleep = 0;
 		if (journal->j_flags & JBD2_UNMOUNT)
 			should_sleep = 0;
 		if (should_sleep) {
 			write_unlock(&journal->j_state_lock);
+			jbd_debug(1, "%s sleeps\n", __func__);
 			schedule();
 			write_lock(&journal->j_state_lock);
 		}
@@ -259,7 +273,10 @@ static int kjournald2(void *arg)
 	transaction = journal->j_running_transaction;
 	if (transaction && time_after_eq(jiffies, transaction->t_expires)) {
 		journal->j_commit_request = transaction->t_tid;
+		fc_flag = false;
 		jbd_debug(1, "woke because of timeout\n");
+	} else {
+		fc_flag = true;
 	}
 	goto loop;
 
@@ -522,11 +539,23 @@ int jbd2_log_start_commit(journal_t *journal, tid_t tid)
 	int ret;
 
 	write_lock(&journal->j_state_lock);
+	journal->j_do_full_commit = true;
 	ret = __jbd2_log_start_commit(journal, tid);
 	write_unlock(&journal->j_state_lock);
 	return ret;
 }
 
+int jbd2_log_start_commit_fast(journal_t *journal, tid_t tid)
+{
+	int ret;
+
+	write_lock(&journal->j_state_lock);
+	ret = __jbd2_log_start_commit(journal, tid);
+	write_unlock(&journal->j_state_lock);
+
+	return ret;
+}
+
 /*
  * Force and wait any uncommitted transactions.  We can only force the running
  * transaction if we don't have an active handle, otherwise, we will deadlock.
@@ -603,11 +632,15 @@ int jbd2_journal_force_commit(journal_t *journal)
  * if a transaction is going to be committed (or is currently already
  * committing), and fills its tid in at *ptid
  */
-int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
+int __jbd2_journal_start_commit(journal_t *journal, tid_t *ptid,
+				bool full_commit)
 {
 	int ret = 0;
 
 	write_lock(&journal->j_state_lock);
+	if (!journal->j_do_full_commit)
+		journal->j_do_full_commit = full_commit;
+
 	if (journal->j_running_transaction) {
 		tid_t tid = journal->j_running_transaction->t_tid;
 
@@ -630,6 +663,16 @@ int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
 	return ret;
 }
 
+int jbd2_journal_start_commit_fast(journal_t *journal, tid_t *ptid)
+{
+	return __jbd2_journal_start_commit(journal, ptid, false);
+}
+
+int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
+{
+	return __jbd2_journal_start_commit(journal, ptid, true);
+}
+
 /*
  * Return 1 if a given transaction has not yet sent barrier request
  * connected with a transaction commit. If 0 is returned, transaction
@@ -675,7 +718,7 @@ EXPORT_SYMBOL(jbd2_trans_will_send_data_barrier);
  * Wait for a specified commit to complete.
  * The caller may not hold the journal lock.
  */
-int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
+int __jbd2_log_wait_commit(journal_t *journal, tid_t tid, tid_t subtid)
 {
 	int err = 0;
 
@@ -702,12 +745,27 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
-				  tid, journal->j_commit_sequence);
+		if ((!journal->j_do_full_commit) &&
+		    !tid_gt(subtid, journal->j_fc_sequence))
+			break;
+		jbd_debug(1, "JBD2: want full commit %u %s %u, ",
+			  tid, journal->j_do_full_commit ?
+			  "and ignoring fast commit request for " :
+			  "or want fast commit",
+			  journal->j_fc_sequence);
+		jbd_debug(1, "j_commit_sequence=%u, j_fc_sequence=%u\n",
+			  journal->j_commit_sequence,
+			  journal->j_fc_sequence);
 		read_unlock(&journal->j_state_lock);
 		wake_up(&journal->j_wait_commit);
-		wait_event(journal->j_wait_done_commit,
-				!tid_gt(tid, journal->j_commit_sequence));
+		if (journal->j_do_full_commit)
+			wait_event(journal->j_wait_done_commit,
+				   !tid_gt(tid, journal->j_commit_sequence));
+		else
+			wait_event(journal->j_wait_done_commit,
+				   !tid_gt(tid, journal->j_commit_sequence) ||
+				   !tid_gt(subtid,
+					    journal->j_fc_sequence));
 		read_lock(&journal->j_state_lock);
 	}
 	read_unlock(&journal->j_state_lock);
@@ -717,6 +775,13 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	return err;
 }
 
+int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
+{
+	journal->j_do_full_commit = true;
+	return __jbd2_log_wait_commit(journal, tid, 0);
+}
+
+
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
@@ -996,6 +1061,8 @@ static int jbd2_seq_info_show(struct seq_file *seq, void *v)
 		   "each up to %u blocks\n",
 		   s->stats->ts_tid, s->stats->ts_requested,
 		   s->journal->j_max_transaction_buffers);
+	seq_printf(seq, "%lu fast commits performed\n",
+		   s->stats->ts_num_fast_commits);
 	if (s->stats->ts_tid == 0)
 		return 0;
 	seq_printf(seq, "average: \n  %ums waiting for transaction\n",
@@ -1020,6 +1087,9 @@ static int jbd2_seq_info_show(struct seq_file *seq, void *v)
 	    s->stats->run.rs_blocks / s->stats->ts_tid);
 	seq_printf(seq, "  %lu logged blocks per transaction\n",
 	    s->stats->run.rs_blocks_logged / s->stats->ts_tid);
+	seq_printf(seq, "  %lu logged blocks per commit\n",
+	    s->stats->run.rs_blocks_logged /
+	    (s->stats->ts_tid + s->stats->ts_num_fast_commits));
 	return 0;
 }
 
@@ -1752,7 +1822,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
 	/* Force a final log commit */
 	if (journal->j_running_transaction)
-		jbd2_journal_commit_transaction(journal);
+		jbd2_journal_commit_transaction(journal, NULL);
 
 	/* Force any old transactions to disk */
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..ce7f03cfd90b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -84,6 +84,7 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_state = T_RUNNING;
 	transaction->t_start_time = ktime_get();
 	transaction->t_tid = journal->j_transaction_sequence++;
+	transaction->t_subtid = 1;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
 	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 84d04e1f3d92..41315f648c0f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -580,6 +580,9 @@ struct transaction_s
 	/* Sequence number for this transaction [no locking] */
 	tid_t			t_tid;
 
+	/* Sequence number of the current ongoing fast commit [no locking] */
+	tid_t			t_subtid;
+
 	/*
 	 * Transaction's current state
 	 * [no locking - only kjournald2 alters this]
@@ -742,6 +745,7 @@ struct transaction_run_stats_s {
 
 struct transaction_stats_s {
 	unsigned long		ts_tid;
+	unsigned long		ts_num_fast_commits;
 	unsigned long		ts_requested;
 	struct transaction_run_stats_s run;
 };
@@ -943,6 +947,13 @@ struct journal_s
 	 */
 	unsigned long		j_last_fc;
 
+	/*
+	 * @j_do_full_commit:
+	 *
+	 * Force a full commit. If this flag is set JBD2 won't try fast commits
+	 */
+	bool			j_do_full_commit;
+
 	/**
 	 * @j_dev: Device where we store the journal.
 	 */
@@ -1012,6 +1023,14 @@ struct journal_s
 	 */
 	tid_t			j_transaction_sequence;
 
+	/**
+	 * @j_fc_sequence:
+	 *
+	 * The sequence number of the most recently committed fast
+	 * commit. [j_state_lock]
+	 */
+	tid_t			j_fc_sequence;
+
 	/**
 	 * @j_commit_sequence:
 	 *
@@ -1205,6 +1224,24 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+	/**
+	 * @j_fc_commit_callback:
+	 *
+	 * File-system specific function that performs actual fast commit
+	 * operation. Should return 0 if the fast commit was successful, in that
+	 * case, JBD2 will just increment journal->j_subtid and move on. If it
+	 * returns < 0, JBD2 will fall-back to full commit.
+	 */
+	int (*j_fc_commit_callback)(struct journal_s *journal, tid_t tid,
+				    tid_t subtid,
+				    struct transaction_run_stats_s *stats);
+	/**
+	 * @j_fc_cleanup_callback:
+	 *
+	 * Clean-up after fast commit or full commit. JBD2 calls this function
+	 * after every commit operation.
+	 */
+	void (*j_fc_cleanup_callback)(struct journal_s *journal);
 };
 
 #define jbd2_might_wait_for_commit(j) \
@@ -1323,7 +1360,8 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 
 /* Commit management */
-extern void jbd2_journal_commit_transaction(journal_t *);
+extern void jbd2_journal_commit_transaction(journal_t *journal,
+					    bool *full_commit);
 
 /* Checkpoint list management */
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
@@ -1532,8 +1570,10 @@ extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
  */
 
 int jbd2_log_start_commit(journal_t *journal, tid_t tid);
+int jbd2_log_start_commit_fast(journal_t *journal, tid_t tid);
 int __jbd2_log_start_commit(journal_t *journal, tid_t tid);
 int jbd2_journal_start_commit(journal_t *journal, tid_t *tid);
+int jbd2_journal_start_commit_fast(journal_t *journal, tid_t *tid);
 int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
 int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..af78bacdae83 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -233,9 +233,9 @@ TRACE_EVENT(jbd2_handle_stats,
 
 TRACE_EVENT(jbd2_run_stats,
 	TP_PROTO(dev_t dev, unsigned long tid,
-		 struct transaction_run_stats_s *stats),
+		 struct transaction_run_stats_s *stats, bool fc),
 
-	TP_ARGS(dev, tid, stats),
+	TP_ARGS(dev, tid, stats, fc),
 
 	TP_STRUCT__entry(
 		__field(		dev_t,	dev		)
@@ -249,6 +249,7 @@ TRACE_EVENT(jbd2_run_stats,
 		__field(		__u32,	handle_count	)
 		__field(		__u32,	blocks		)
 		__field(		__u32,	blocks_logged	)
+		__field(		 bool,	fc		)
 	),
 
 	TP_fast_assign(
@@ -263,11 +264,13 @@ TRACE_EVENT(jbd2_run_stats,
 		__entry->handle_count	= stats->rs_handle_count;
 		__entry->blocks		= stats->rs_blocks;
 		__entry->blocks_logged	= stats->rs_blocks_logged;
+		__entry->fc		= fc;
 	),
 
-	TP_printk("dev %d,%d tid %lu wait %u request_delay %u running %u "
+	TP_printk("%s commit, dev %d,%d tid %lu wait %u request_delay %u running %u "
 		  "locked %u flushing %u logging %u handle_count %u "
 		  "blocks %u blocks_logged %u",
+		  __entry->fc ? "fast" : "full",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->tid,
 		  jiffies_to_msecs(__entry->wait),
 		  jiffies_to_msecs(__entry->request_delay),
-- 
2.23.0.444.g18eeb5a265-goog

