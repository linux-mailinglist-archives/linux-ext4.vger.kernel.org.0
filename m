Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC787045
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405189AbfHIDqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405167AbfHIDqc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so45276173pfq.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRm5rXOCZ+bnuTSrbkDttjv2f7u7GVHobS5RP9hhdGM=;
        b=kw/CuSIngoVKVcycMid6rKdXHTmubr0p/c7ODOWS9Rxh5YZbphoiU4YX3mLtmCDBNC
         kZlebNrbNx5SlptPoZEA92Kn6P+my5pfioX3BgMxSBcGhiiRmOwrOIsZ008m8Aljz3aV
         lFX1cKHDvK3mJTkzWwK6DXSHmB+PUzw6lZeH+0iptNEAF1y2jr6vaPWWIIffJXk+NzSp
         hjlQCx17RPnC5SKK1eaGjtmZRLm1yVE7vLt6hT3mF9xoM2tggqCODRUOe4X9fqwRsCk5
         codqE/W0zDod0EDKyM7foXdrmMTepALjomjwkcX8Zz2zzNjIfZyrJInVZ9V5UBZRseRp
         VU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRm5rXOCZ+bnuTSrbkDttjv2f7u7GVHobS5RP9hhdGM=;
        b=TkCCqnj15Fl609OmG0AyG5TAsiyubPgwjz1Gkj4b5gYiKTYmqgz48TZR/7+VAdu0wu
         6Ft2e0ifMY3IGeKnb6MmseouJ7cyBqlVMfJ7Q71KWYQ1wBz2pEcD90wP6HEJBkXEpLdC
         oorggMjhkwn5esmNxzZs1asTbfUBatX1v+GAMy8n/qUFXtDz9emz2FKgK2Co1bKyOVvE
         BY0Dm1UpirlR7yEKhLacH/bRzl8aPRPO/MYibuluF10YPM9bgE4SZHII3US48MXVhM9t
         N5P7AzrmDwoSsgpKCuO0fnnDdaxPEAUYEGjEmbkq+BHhVX+EAUXP56WQmnAE15Sg/u3J
         OVCw==
X-Gm-Message-State: APjAAAVv0we+Mvv0dT8yB4lDU3lQtYxrJ1Yvrn9Ke/HAi4LRpPz7llph
        pKb1m3Wzn1COHc6ORrsDqMdMBu9z
X-Google-Smtp-Source: APXvYqwWcu6aPoAEqbJ22KSCoGQ+R6pb1Er3th5MZ/wq3bg9xqJabwGHyzFhu3dcdOJpLWAG1nK+xQ==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr15676966pgk.431.1565322390940;
        Thu, 08 Aug 2019 20:46:30 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:30 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 04/12] jbd2: fast-commit commit path changes
Date:   Thu,  8 Aug 2019 20:45:44 -0700
Message-Id: <20190809034552.148629-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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
APIs now take an additional argument which indicates if fast commits
are allowed or not.

In this patch we also add a new entry to journal->stats which counts
the number of fast commits performed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

---

Changelog:

V2: JBD2 commit routine passes stats to the fast commit callbac. Also,
    added a new entry to journal->stats and its tracking.
---
 fs/ext4/super.c       |  2 +-
 fs/jbd2/checkpoint.c  |  2 +-
 fs/jbd2/commit.c      | 47 +++++++++++++++++++++++--
 fs/jbd2/journal.c     | 81 +++++++++++++++++++++++++++++++++++--------
 fs/jbd2/transaction.c |  6 ++--
 fs/ocfs2/alloc.c      |  2 +-
 fs/ocfs2/super.c      |  2 +-
 include/linux/jbd2.h  |  9 +++--
 8 files changed, 124 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81c3ec165822..6bab59ae81f7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5148,7 +5148,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		    !jbd2_trans_will_send_data_barrier(sbi->s_journal, target))
 			needs_barrier = true;
 
-		if (jbd2_journal_start_commit(sbi->s_journal, &target)) {
+		if (jbd2_journal_start_commit(sbi->s_journal, &target, true)) {
 			if (wait)
 				ret = jbd2_log_wait_commit(sbi->s_journal,
 							   target);
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index a1909066bde6..6297978ae3bc 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -277,7 +277,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
-			jbd2_log_start_commit(journal, tid);
+			jbd2_log_start_commit(journal, tid, true);
 			/*
 			 * jbd2_journal_commit_transaction() may want
 			 * to take the checkpoint_mutex if JBD2_FLUSHED
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 132fb92098c7..9281814606e7 100644
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
 
@@ -413,6 +418,40 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(journal->j_running_transaction != NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 
+	read_lock(&journal->j_state_lock);
+	full_commit = journal->j_do_full_commit;
+	read_unlock(&journal->j_state_lock);
+
+	/* Let file-system try its own fast commit */
+	if (jbd2_has_feature_fast_commit(journal)) {
+		if (!full_commit && fc && *fc == true &&
+		    journal->j_fc_commit_callback &&
+		    !journal->j_fc_commit_callback(
+			journal, journal->j_running_transaction->t_tid,
+			journal->j_subtid, &stats.run)) {
+			jbd_debug(3, "fast commit success.\n");
+			if (journal->j_fc_cleanup_callback)
+				journal->j_fc_cleanup_callback(journal);
+			write_lock(&journal->j_state_lock);
+			journal->j_subtid++;
+			if (fc)
+				*fc = true;
+			write_unlock(&journal->j_state_lock);
+			goto update_overall_stats;
+		}
+		if (journal->j_fc_cleanup_callback)
+			journal->j_fc_cleanup_callback(journal);
+		write_lock(&journal->j_state_lock);
+		journal->j_fc_off = 0;
+		journal->j_subtid = 0;
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
@@ -1129,8 +1168,12 @@ void jbd2_journal_commit_transaction(journal_t *journal)
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
index 59ad709154a3..ab05e47ed2d4 100644
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
 
@@ -517,11 +534,17 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 	return 0;
 }
 
-int jbd2_log_start_commit(journal_t *journal, tid_t tid)
+int jbd2_log_start_commit(journal_t *journal, tid_t tid, bool full_commit)
 {
 	int ret;
 
 	write_lock(&journal->j_state_lock);
+	/*
+	 * If someone has already requested a full commit,
+	 * we have to honor it.
+	 */
+	if (!journal->j_do_full_commit)
+		journal->j_do_full_commit = full_commit;
 	ret = __jbd2_log_start_commit(journal, tid);
 	write_unlock(&journal->j_state_lock);
 	return ret;
@@ -556,7 +579,7 @@ static int __jbd2_journal_force_commit(journal_t *journal)
 	tid = transaction->t_tid;
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
-		jbd2_log_start_commit(journal, tid);
+		jbd2_log_start_commit(journal, tid, true);
 	ret = jbd2_log_wait_commit(journal, tid);
 	if (!ret)
 		ret = 1;
@@ -603,11 +626,14 @@ int jbd2_journal_force_commit(journal_t *journal)
  * if a transaction is going to be committed (or is currently already
  * committing), and fills its tid in at *ptid
  */
-int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
+int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid, bool full_commit)
 {
 	int ret = 0;
 
 	write_lock(&journal->j_state_lock);
+	if (!journal->j_do_full_commit)
+		journal->j_do_full_commit = full_commit;
+
 	if (journal->j_running_transaction) {
 		tid_t tid = journal->j_running_transaction->t_tid;
 
@@ -675,7 +701,7 @@ EXPORT_SYMBOL(jbd2_trans_will_send_data_barrier);
  * Wait for a specified commit to complete.
  * The caller may not hold the journal lock.
  */
-int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
+int __jbd2_log_wait_commit(journal_t *journal, tid_t tid, tid_t subtid)
 {
 	int err = 0;
 
@@ -702,12 +728,25 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
-				  tid, journal->j_commit_sequence);
+		if ((!journal->j_do_full_commit) &&
+		    !tid_geq(subtid, journal->j_subtid))
+			break;
+		jbd_debug(1, "JBD2: want full commit %u %s %u, ",
+			  tid, journal->j_do_full_commit ?
+			  "and ignoring fast commit request for " :
+			  "or want fast commit",
+			  journal->j_subtid);
+		jbd_debug(1, "j_commit_sequence=%u, j_subtid=%u\n",
+			  journal->j_commit_sequence, journal->j_subtid);
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
+				   !tid_geq(subtid, journal->j_subtid));
 		read_lock(&journal->j_state_lock);
 	}
 	read_unlock(&journal->j_state_lock);
@@ -717,6 +756,13 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
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
@@ -751,7 +797,7 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid)
 		if (journal->j_commit_request != tid) {
 			/* transaction not yet started, so request it */
 			read_unlock(&journal->j_state_lock);
-			jbd2_log_start_commit(journal, tid);
+			jbd2_log_start_commit(journal, tid, true);
 			goto wait_commit;
 		}
 	} else if (!(journal->j_committing_transaction &&
@@ -996,6 +1042,8 @@ static int jbd2_seq_info_show(struct seq_file *seq, void *v)
 		   "each up to %u blocks\n",
 		   s->stats->ts_tid, s->stats->ts_requested,
 		   s->journal->j_max_transaction_buffers);
+	seq_printf(seq, "%lu fast commits performed\n",
+		   s->stats->ts_num_fast_commits);
 	if (s->stats->ts_tid == 0)
 		return 0;
 	seq_printf(seq, "average: \n  %ums waiting for transaction\n",
@@ -1020,6 +1068,9 @@ static int jbd2_seq_info_show(struct seq_file *seq, void *v)
 	    s->stats->run.rs_blocks / s->stats->ts_tid);
 	seq_printf(seq, "  %lu logged blocks per transaction\n",
 	    s->stats->run.rs_blocks_logged / s->stats->ts_tid);
+	seq_printf(seq, "  %lu logged blocks per commit\n",
+	    s->stats->run.rs_blocks_logged /
+	    (s->stats->ts_tid + s->stats->ts_num_fast_commits));
 	return 0;
 }
 
@@ -1741,7 +1792,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
 	/* Force a final log commit */
 	if (journal->j_running_transaction)
-		jbd2_journal_commit_transaction(journal);
+		jbd2_journal_commit_transaction(journal, NULL);
 
 	/* Force any old transactions to disk */
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..87f6627d78aa 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -154,7 +154,7 @@ static void wait_transaction_locked(journal_t *journal)
 	need_to_start = !tid_geq(journal->j_commit_request, tid);
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
-		jbd2_log_start_commit(journal, tid);
+		jbd2_log_start_commit(journal, tid, true);
 	jbd2_might_wait_for_commit(journal);
 	schedule();
 	finish_wait(&journal->j_wait_transaction_locked, &wait);
@@ -708,7 +708,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
 	need_to_start = !tid_geq(journal->j_commit_request, tid);
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
-		jbd2_log_start_commit(journal, tid);
+		jbd2_log_start_commit(journal, tid, true);
 
 	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
 	handle->h_buffer_credits = nblocks;
@@ -1822,7 +1822,7 @@ int jbd2_journal_stop(handle_t *handle)
 		jbd_debug(2, "transaction too old, requesting commit for "
 					"handle %p\n", handle);
 		/* This is non-blocking */
-		jbd2_log_start_commit(journal, transaction->t_tid);
+		jbd2_log_start_commit(journal, transaction->t_tid, true);
 
 		/*
 		 * Special case: JBD2_SYNC synchronous updates require us
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 0c335b51043d..df41c43573b7 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6117,7 +6117,7 @@ int ocfs2_try_to_free_truncate_log(struct ocfs2_super *osb,
 		goto out;
 	}
 
-	if (jbd2_journal_start_commit(osb->journal->j_journal, &target)) {
+	if (jbd2_journal_start_commit(osb->journal->j_journal, &target, true)) {
 		jbd2_log_wait_commit(osb->journal->j_journal, target);
 		ret = 1;
 	}
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 8b2f39506648..60ecc51759ae 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -410,7 +410,7 @@ static int ocfs2_sync_fs(struct super_block *sb, int wait)
 	}
 
 	if (jbd2_journal_start_commit(osb->journal->j_journal,
-				      &target)) {
+				      &target, true)) {
 		if (wait)
 			jbd2_log_wait_commit(osb->journal->j_journal,
 					     target);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 153840b422cc..535f88dff653 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -742,6 +742,7 @@ struct transaction_run_stats_s {
 
 struct transaction_stats_s {
 	unsigned long		ts_tid;
+	unsigned long		ts_num_fast_commits;
 	unsigned long		ts_requested;
 	struct transaction_run_stats_s run;
 };
@@ -1364,7 +1365,8 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 
 /* Commit management */
-extern void jbd2_journal_commit_transaction(journal_t *);
+extern void jbd2_journal_commit_transaction(journal_t *journal,
+					    bool *full_commit);
 
 /* Checkpoint list management */
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
@@ -1571,9 +1573,10 @@ extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
  * transitions on demand.
  */
 
-int jbd2_log_start_commit(journal_t *journal, tid_t tid);
+int jbd2_log_start_commit(journal_t *journal, tid_t tid, bool full_commit);
 int __jbd2_log_start_commit(journal_t *journal, tid_t tid);
-int jbd2_journal_start_commit(journal_t *journal, tid_t *tid);
+int jbd2_journal_start_commit(journal_t *journal, tid_t *tid,
+			      bool full_commit);
 int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
 int jbd2_transaction_committed(journal_t *journal, tid_t tid);
 int jbd2_complete_transaction(journal_t *journal, tid_t tid);
-- 
2.23.0.rc1.153.gdeed80330f-goog

