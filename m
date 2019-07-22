Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AED6F82D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfGVECT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42960 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGVECT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so16989339pgb.9
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztMBQmYi0ZO2pz5mmachuZDeFBzxpQdnH8XOr2AW50A=;
        b=CZVe6e96PRWI7uy1jkKnLZj7f3QJUDSXjPj1ZmeS+PBZ9RUI5lfuUCDRvPApxgQ/xe
         ubzZPtAUhc+GHG9ZHNDSXfdxG/dytU8UN3QeYid9AK4sjtiOgyEm5Gxs8u+jLskXyGcm
         xhNTyAls6L3ZJ7INfLr1hdFPgkwjg2TNk4xPr09rvgCMyRS0J+Mu3zVw4S4yvZGemqbD
         j2/5HSnFeYIIM1wW/TnRsN74j1OEtPw2NkorhpuJm5GRcWnuRsjHrWeAxFmkm4DgQ6Br
         JQBmpcfWy1El690XvhtViczGmECDdWHh07aTw/nULCIlKXbsDoZWFVUpvuEIO4fuEqC4
         3A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztMBQmYi0ZO2pz5mmachuZDeFBzxpQdnH8XOr2AW50A=;
        b=VzAuBj1jNF70gdy63SXdhdDgJy5YQWFgSe9mvewcd2aPDzXur55CzGpTsp2/vzP1vw
         ZuwWM2LT8xlSxNX3750Y/049FSVgkvtWrc2ROtp/L8BKxGwG1rVCE3Ht1WCLnX8Xq5PQ
         /rdPBEt5HHBJ492xuY9p/pCMUoSd0Y+wZqNZ1nF79EZhw8OIvgqxDA5oZEERupcTrOCw
         NnXuyQtgdpV/NzFY1OhhLwBAwfp3wTh74oB+4Z9mYYZ6+Lj0oKUyVCKDhUilis8A3mXj
         Z+LvovcI2sHqaHcjD0urae3Lj/me5ZWUy4rLJixUdxH/LgbFyx/zOjCM0frlZHEXQuGA
         W4Aw==
X-Gm-Message-State: APjAAAXPH4EcWnPIqtVUEWdPtAzuIupP8aMNxtTPfLiB/UYRLAyEZOvp
        aHayqg9BJnBMeSgIvnhF85mLLcKl
X-Google-Smtp-Source: APXvYqwJIR+vn7yVCjtz3ZtXfu24KWtyx9p5+qgtQHLyvaWvjjR1xa/DWRRSxh7nqHAuF/7/qopC+w==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr74265667pjn.125.1563768137517;
        Sun, 21 Jul 2019 21:02:17 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 04/11] jbd2: fast-commit commit path changes
Date:   Sun, 21 Jul 2019 21:00:04 -0700
Message-Id: <20190722040011.18892-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
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

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/super.c       |  2 +-
 fs/jbd2/checkpoint.c  |  2 +-
 fs/jbd2/commit.c      | 41 ++++++++++++++++++++++-
 fs/jbd2/journal.c     | 76 ++++++++++++++++++++++++++++++++++---------
 fs/jbd2/transaction.c |  6 ++--
 fs/ocfs2/alloc.c      |  2 +-
 fs/ocfs2/super.c      |  2 +-
 include/linux/jbd2.h  |  8 +++--
 8 files changed, 113 insertions(+), 26 deletions(-)

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
index 132fb92098c7..241581c23aa3 100644
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
+			journal->j_subtid)) {
+			jbd_debug(3, "fast commit success.\n");
+			if (journal->j_fc_cleanup_callback)
+				journal->j_fc_cleanup_callback(journal);
+			write_lock(&journal->j_state_lock);
+			journal->j_subtid++;
+			if (fc)
+				*fc = true;
+			write_unlock(&journal->j_state_lock);
+			return;
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
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 59ad709154a3..6fad7a15ea82 100644
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
@@ -1741,7 +1787,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
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
index 389bc7cd2410..7f832283e4b9 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1363,7 +1363,8 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 
 /* Commit management */
-extern void jbd2_journal_commit_transaction(journal_t *);
+extern void jbd2_journal_commit_transaction(journal_t *journal,
+					    bool *full_commit);
 
 /* Checkpoint list management */
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
@@ -1570,9 +1571,10 @@ extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
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
2.22.0.657.g960e92d24f-goog

