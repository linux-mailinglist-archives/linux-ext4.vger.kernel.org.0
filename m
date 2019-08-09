Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8987A5C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406833AbfHIMmm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 08:42:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406735AbfHIMmm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Aug 2019 08:42:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE1DCAFBE;
        Fri,  9 Aug 2019 12:42:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 75F7E1E47C8; Fri,  9 Aug 2019 14:42:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>
Subject: [PATCH 6/7] jbd2: Make state lock a spinlock
Date:   Fri,  9 Aug 2019 14:42:32 +0200
Message-Id: <20190809124233.13277-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190809124233.13277-1-jack@suse.cz>
References: <20190809124233.13277-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Bit-spinlocks are problematic on PREEMPT_RT if functions which might sleep
on RT, e.g. spin_lock(), alloc/free(), are invoked inside the lock held
region because bit spinlocks disable preemption even on RT.

A first attempt was to replace state lock with a spinlock placed in struct
buffer_head and make the locking conditional on PREEMPT_RT and
DEBUG_BIT_SPINLOCKS.

Jan pointed out that there is a 4 byte hole in struct journal_head where a
regular spinlock fits in and he would not object to convert the state lock
to a spinlock unconditionally.

Aside of solving the RT problem, this also gains lockdep coverage for the
journal head state lock (bit-spinlocks are not covered by lockdep as it's
hard to fit a lockdep map into a single bit).

The trivial change would have been to convert the jbd_*lock_bh_state()
inlines, but that comes with the downside that these functions take a
buffer head pointer which needs to be converted to a journal head pointer
which adds another level of indirection.

As almost all functions which use this lock have a journal head pointer
readily available, it makes more sense to remove the lock helper inlines
and write out spin_*lock() at all call sites.

Fixup all locking comments as well.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
---
 fs/jbd2/commit.c             |   8 ++--
 fs/jbd2/journal.c            |  10 +++--
 fs/jbd2/transaction.c        | 100 ++++++++++++++++++++-----------------------
 fs/ocfs2/suballoc.c          |  19 ++++----
 include/linux/jbd2.h         |  20 +--------
 include/linux/journal-head.h |  21 ++++++---
 6 files changed, 84 insertions(+), 94 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index a0a191f3df77..8e1ff875de43 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -482,10 +482,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (jh->b_committed_data) {
 			struct buffer_head *bh = jh2bh(jh);
 
-			jbd_lock_bh_state(bh);
+			spin_lock(&jh->b_state_lock);
 			jbd2_free(jh->b_committed_data, bh->b_size);
 			jh->b_committed_data = NULL;
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->b_state_lock);
 		}
 		jbd2_journal_refile_buffer(journal, jh);
 	}
@@ -928,7 +928,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 * done with it.
 		 */
 		get_bh(bh);
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->b_state_lock);
 		J_ASSERT_JH(jh,	jh->b_transaction == commit_transaction);
 
 		/*
@@ -1024,7 +1024,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		}
 		JBUFFER_TRACE(jh, "refile or unfile buffer");
 		drop_ref = __jbd2_journal_refile_buffer(jh);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->b_state_lock);
 		if (drop_ref)
 			jbd2_journal_put_journal_head(jh);
 		if (try_to_free)
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990eb70a9..eee350fef339 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -365,7 +365,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	/* keep subsequent assertions sane */
 	atomic_set(&new_bh->b_count, 1);
 
-	jbd_lock_bh_state(bh_in);
+	spin_lock(&jh_in->b_state_lock);
 repeat:
 	/*
 	 * If a new transaction has already done a buffer copy-out, then
@@ -407,13 +407,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	if (need_copy_out && !done_copy_out) {
 		char *tmp;
 
-		jbd_unlock_bh_state(bh_in);
+		spin_unlock(&jh_in->b_state_lock);
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
 			return -ENOMEM;
 		}
-		jbd_lock_bh_state(bh_in);
+		spin_lock(&jh_in->b_state_lock);
 		if (jh_in->b_frozen_data) {
 			jbd2_free(tmp, bh_in->b_size);
 			goto repeat;
@@ -466,7 +466,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	__jbd2_journal_file_buffer(jh_in, transaction, BJ_Shadow);
 	spin_unlock(&journal->j_list_lock);
 	set_buffer_shadow(bh_in);
-	jbd_unlock_bh_state(bh_in);
+	spin_unlock(&jh_in->b_state_lock);
 
 	return do_escape | (done_copy_out << 1);
 }
@@ -2412,6 +2412,8 @@ static struct journal_head *journal_alloc_journal_head(void)
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
 	}
+	if (ret)
+		spin_lock_init(&ret->b_state_lock);
 	return ret;
 }
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index d752d7f6929e..1db5be820816 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -876,7 +876,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
  	start_lock = jiffies;
 	lock_buffer(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 
 	/* If it takes too long to lock the buffer, trace it */
 	time_lock = jbd2_time_diff(start_lock, jiffies);
@@ -926,7 +926,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) {
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->b_state_lock);
 		goto out;
 	}
 	error = 0;
@@ -990,7 +990,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 */
 	if (buffer_shadow(bh)) {
 		JBUFFER_TRACE(jh, "on shadow: sleep");
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->b_state_lock);
 		wait_on_bit_io(&bh->b_state, BH_Shadow, TASK_UNINTERRUPTIBLE);
 		goto repeat;
 	}
@@ -1011,7 +1011,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 		JBUFFER_TRACE(jh, "generate frozen data");
 		if (!frozen_buffer) {
 			JBUFFER_TRACE(jh, "allocate memory for buffer");
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->b_state_lock);
 			frozen_buffer = jbd2_alloc(jh2bh(jh)->b_size,
 						   GFP_NOFS | __GFP_NOFAIL);
 			goto repeat;
@@ -1030,7 +1030,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	jh->b_next_transaction = transaction;
 
 done:
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 
 	/*
 	 * If we are about to journal a buffer, then any revoke pending on it is
@@ -1169,7 +1169,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	 * that case: the transaction must have deleted the buffer for it to be
 	 * reused here.
 	 */
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
 		jh->b_transaction == NULL ||
 		(jh->b_transaction == journal->j_committing_transaction &&
@@ -1204,7 +1204,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 		jh->b_next_transaction = transaction;
 		spin_unlock(&journal->j_list_lock);
 	}
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 
 	/*
 	 * akpm: I added this.  ext3_alloc_branch can pick up new indirect
@@ -1272,13 +1272,13 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 		committed_data = jbd2_alloc(jh2bh(jh)->b_size,
 					    GFP_NOFS|__GFP_NOFAIL);
 
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 	if (!jh->b_committed_data) {
 		/* Copy out the current buffer contents into the
 		 * preserved, committed copy. */
 		JBUFFER_TRACE(jh, "generate b_committed data");
 		if (!committed_data) {
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->b_state_lock);
 			goto repeat;
 		}
 
@@ -1286,7 +1286,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 		committed_data = NULL;
 		memcpy(jh->b_committed_data, bh->b_data, bh->b_size);
 	}
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 out:
 	jbd2_journal_put_journal_head(jh);
 	if (unlikely(committed_data))
@@ -1387,16 +1387,16 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	 */
 	if (jh->b_transaction != transaction &&
 	    jh->b_next_transaction != transaction) {
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->b_state_lock);
 		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_next_transaction == transaction);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->b_state_lock);
 	}
 	if (jh->b_modified == 1) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata) {
-			jbd_lock_bh_state(bh);
+			spin_lock(&jh->b_state_lock);
 			if (jh->b_transaction == transaction &&
 			    jh->b_jlist != BJ_Metadata)
 				pr_err("JBD2: assertion failure: h_type=%u "
@@ -1406,13 +1406,13 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 				       jh->b_jlist);
 			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
 					jh->b_jlist == BJ_Metadata);
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->b_state_lock);
 		}
 		goto out;
 	}
 
 	journal = transaction->t_journal;
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 
 	if (jh->b_modified == 0) {
 		/*
@@ -1498,7 +1498,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	__jbd2_journal_file_buffer(jh, transaction, BJ_Metadata);
 	spin_unlock(&journal->j_list_lock);
 out_unlock_bh:
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 out:
 	JBUFFER_TRACE(jh, "exit");
 	return ret;
@@ -1536,11 +1536,13 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 
 	BUFFER_TRACE(bh, "entry");
 
-	jbd_lock_bh_state(bh);
+	jh = jbd2_journal_grab_journal_head(bh);
+	if (!jh) {
+		__bforget(bh);
+		return 0;
+	}
 
-	if (!buffer_jbd(bh))
-		goto not_jbd;
-	jh = bh2jh(bh);
+	spin_lock(&jh->b_state_lock);
 
 	/* Critical error: attempting to delete a bitmap buffer, maybe?
 	 * Don't do any jbd operations, and return an error. */
@@ -1661,18 +1663,14 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
-	jbd_unlock_bh_state(bh);
 	__brelse(bh);
+	spin_unlock(&jh->b_state_lock);
+	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
 		handle->h_buffer_credits++;
 	}
 	return err;
-
-not_jbd:
-	jbd_unlock_bh_state(bh);
-	__bforget(bh);
-	goto drop;
 }
 
 /**
@@ -1871,7 +1869,7 @@ int jbd2_journal_stop(handle_t *handle)
  *
  * j_list_lock is held.
  *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
+ * jh->b_state_lock is held.
  */
 
 static inline void
@@ -1895,7 +1893,7 @@ __blist_add_buffer(struct journal_head **list, struct journal_head *jh)
  *
  * Called with j_list_lock held, and the journal may not be locked.
  *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
+ * jh->b_state_lock is held.
  */
 
 static inline void
@@ -1927,7 +1925,7 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
 	transaction_t *transaction;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	lockdep_assert_held(&jh->b_state_lock);
 	transaction = jh->b_transaction;
 	if (transaction)
 		assert_spin_locked(&transaction->t_journal->j_list_lock);
@@ -1981,11 +1979,11 @@ void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
 
 	/* Get reference so that buffer cannot be freed before we unlock it */
 	get_bh(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 	spin_lock(&journal->j_list_lock);
 	__jbd2_journal_unfile_buffer(jh);
 	spin_unlock(&journal->j_list_lock);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 	jbd2_journal_put_journal_head(jh);
 	__brelse(bh);
 }
@@ -1993,7 +1991,7 @@ void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
 /*
  * Called from jbd2_journal_try_to_free_buffers().
  *
- * Called under jbd_lock_bh_state(bh)
+ * Called under jh->b_state_lock
  */
 static void
 __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
@@ -2080,10 +2078,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 		if (!jh)
 			continue;
 
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->b_state_lock);
 		__journal_try_to_free_buffer(journal, bh);
+		spin_unlock(&jh->b_state_lock);
 		jbd2_journal_put_journal_head(jh);
-		jbd_unlock_bh_state(bh);
 		if (buffer_jbd(bh))
 			goto busy;
 	} while ((bh = bh->b_this_page) != head);
@@ -2104,7 +2102,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
  *
  * Called under j_list_lock.
  *
- * Called under jbd_lock_bh_state(bh).
+ * Called under jh->b_state_lock.
  */
 static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
 {
@@ -2198,7 +2196,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 
 	/* OK, we have data buffer in journaled mode */
 	write_lock(&journal->j_state_lock);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 	spin_lock(&journal->j_list_lock);
 
 	/*
@@ -2279,10 +2277,10 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 		 * for commit and try again.
 		 */
 		if (partial_page) {
-			jbd2_journal_put_journal_head(jh);
 			spin_unlock(&journal->j_list_lock);
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->b_state_lock);
 			write_unlock(&journal->j_state_lock);
+			jbd2_journal_put_journal_head(jh);
 			return -EBUSY;
 		}
 		/*
@@ -2294,10 +2292,10 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 		set_buffer_freed(bh);
 		if (journal->j_running_transaction && buffer_jbddirty(bh))
 			jh->b_next_transaction = journal->j_running_transaction;
-		jbd2_journal_put_journal_head(jh);
 		spin_unlock(&journal->j_list_lock);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->b_state_lock);
 		write_unlock(&journal->j_state_lock);
+		jbd2_journal_put_journal_head(jh);
 		return 0;
 	} else {
 		/* Good, the buffer belongs to the running transaction.
@@ -2321,10 +2319,10 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	 * here.
 	 */
 	jh->b_modified = 0;
-	jbd2_journal_put_journal_head(jh);
 	spin_unlock(&journal->j_list_lock);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_put_journal_head(jh);
 zap_buffer_unlocked:
 	clear_buffer_dirty(bh);
 	J_ASSERT_BH(bh, !buffer_jbddirty(bh));
@@ -2411,7 +2409,7 @@ void __jbd2_journal_file_buffer(struct journal_head *jh,
 	int was_dirty = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	lockdep_assert_held(&jh->b_state_lock);
 	assert_spin_locked(&transaction->t_journal->j_list_lock);
 
 	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);
@@ -2473,11 +2471,11 @@ void __jbd2_journal_file_buffer(struct journal_head *jh,
 void jbd2_journal_file_buffer(struct journal_head *jh,
 				transaction_t *transaction, int jlist)
 {
-	jbd_lock_bh_state(jh2bh(jh));
+	spin_lock(&jh->b_state_lock);
 	spin_lock(&transaction->t_journal->j_list_lock);
 	__jbd2_journal_file_buffer(jh, transaction, jlist);
 	spin_unlock(&transaction->t_journal->j_list_lock);
-	jbd_unlock_bh_state(jh2bh(jh));
+	spin_unlock(&jh->b_state_lock);
 }
 
 /*
@@ -2487,7 +2485,7 @@ void jbd2_journal_file_buffer(struct journal_head *jh,
  * buffer on that transaction's metadata list.
  *
  * Called under j_list_lock
- * Called under jbd_lock_bh_state(jh2bh(jh))
+ * Called under jh->b_state_lock
  *
  * When this function returns true, there's no next transaction to refile to
  * and the caller has to drop jh reference through
@@ -2498,7 +2496,7 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
 	int was_dirty, jlist;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	lockdep_assert_held(&jh->b_state_lock);
 	if (jh->b_transaction)
 		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
 
@@ -2544,17 +2542,13 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
  */
 void jbd2_journal_refile_buffer(journal_t *journal, struct journal_head *jh)
 {
-	struct buffer_head *bh = jh2bh(jh);
 	bool drop;
 
-	/* Get reference so that buffer cannot be freed before we unlock it */
-	get_bh(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->b_state_lock);
 	spin_lock(&journal->j_list_lock);
 	drop = __jbd2_journal_refile_buffer(jh);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->b_state_lock);
 	spin_unlock(&journal->j_list_lock);
-	__brelse(bh);
 	if (drop)
 		jbd2_journal_put_journal_head(jh);
 }
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 69c21a3843af..4180c3ef0a68 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1252,6 +1252,7 @@ static int ocfs2_test_bg_bit_allocatable(struct buffer_head *bg_bh,
 					 int nr)
 {
 	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
+	struct journal_head *jh;
 	int ret;
 
 	if (ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap))
@@ -1260,13 +1261,14 @@ static int ocfs2_test_bg_bit_allocatable(struct buffer_head *bg_bh,
 	if (!buffer_jbd(bg_bh))
 		return 1;
 
-	jbd_lock_bh_state(bg_bh);
-	bg = (struct ocfs2_group_desc *) bh2jh(bg_bh)->b_committed_data;
+	jh = bh2jh(bg_bh);
+	spin_lock(&jh->b_state_lock);
+	bg = (struct ocfs2_group_desc *) jh->b_committed_data;
 	if (bg)
 		ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
 	else
 		ret = 1;
-	jbd_unlock_bh_state(bg_bh);
+	spin_unlock(&jh->b_state_lock);
 
 	return ret;
 }
@@ -2387,6 +2389,7 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 	int status;
 	unsigned int tmp;
 	struct ocfs2_group_desc *undo_bg = NULL;
+	struct journal_head *jh;
 
 	/* The caller got this descriptor from
 	 * ocfs2_read_group_descriptor().  Any corruption is a code bug. */
@@ -2405,10 +2408,10 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 		goto bail;
 	}
 
+	jh = bh2jh(group_bh);
 	if (undo_fn) {
-		jbd_lock_bh_state(group_bh);
-		undo_bg = (struct ocfs2_group_desc *)
-					bh2jh(group_bh)->b_committed_data;
+		spin_lock(&jh->b_state_lock);
+		undo_bg = (struct ocfs2_group_desc *) jh->b_committed_data;
 		BUG_ON(!undo_bg);
 	}
 
@@ -2423,7 +2426,7 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 	le16_add_cpu(&bg->bg_free_bits_count, num_bits);
 	if (le16_to_cpu(bg->bg_free_bits_count) > le16_to_cpu(bg->bg_bits)) {
 		if (undo_fn)
-			jbd_unlock_bh_state(group_bh);
+			spin_unlock(&jh->b_state_lock);
 		return ocfs2_error(alloc_inode->i_sb, "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
 				   (unsigned long long)le64_to_cpu(bg->bg_blkno),
 				   le16_to_cpu(bg->bg_bits),
@@ -2432,7 +2435,7 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 	}
 
 	if (undo_fn)
-		jbd_unlock_bh_state(group_bh);
+		spin_unlock(&jh->b_state_lock);
 
 	ocfs2_journal_dirty(handle, group_bh);
 bail:
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6aa66c42599d..00d6a69f4e74 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -313,7 +313,6 @@ enum jbd_state_bits {
 	BH_Revoked,		/* Has been revoked from the log */
 	BH_RevokeValid,		/* Revoked flag is valid */
 	BH_JBDDirty,		/* Is dirty but journaled */
-	BH_State,		/* Pins most journal_head state */
 	BH_JournalHead,		/* Pins bh->b_private and jh->b_bh */
 	BH_Shadow,		/* IO on shadow buffer is running */
 	BH_Verified,		/* Metadata block has been verified ok */
@@ -342,21 +341,6 @@ static inline struct journal_head *bh2jh(struct buffer_head *bh)
 	return bh->b_private;
 }
 
-static inline void jbd_lock_bh_state(struct buffer_head *bh)
-{
-	bit_spin_lock(BH_State, &bh->b_state);
-}
-
-static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
-{
-	return bit_spin_is_locked(BH_State, &bh->b_state);
-}
-
-static inline void jbd_unlock_bh_state(struct buffer_head *bh)
-{
-	bit_spin_unlock(BH_State, &bh->b_state);
-}
-
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_JournalHead, &bh->b_state);
@@ -551,9 +535,9 @@ struct transaction_chp_stats_s {
  *      ->jbd_lock_bh_journal_head()	(This is "innermost")
  *
  *    j_state_lock
- *    ->jbd_lock_bh_state()
+ *    ->b_state_lock
  *
- *    jbd_lock_bh_state()
+ *    b_state_lock
  *    ->j_list_lock
  *
  *    j_state_lock
diff --git a/include/linux/journal-head.h b/include/linux/journal-head.h
index 9fb870524314..75bc56109031 100644
--- a/include/linux/journal-head.h
+++ b/include/linux/journal-head.h
@@ -11,6 +11,8 @@
 #ifndef JOURNAL_HEAD_H_INCLUDED
 #define JOURNAL_HEAD_H_INCLUDED
 
+#include <linux/spinlock.h>
+
 typedef unsigned int		tid_t;		/* Unique transaction ID */
 typedef struct transaction_s	transaction_t;	/* Compound transaction type */
 
@@ -23,6 +25,11 @@ struct journal_head {
 	 */
 	struct buffer_head *b_bh;
 
+	/*
+	 * Protect the buffer head state
+	 */
+	spinlock_t b_state_lock;
+
 	/*
 	 * Reference count - see description in journal.c
 	 * [jbd_lock_bh_journal_head()]
@@ -30,7 +37,7 @@ struct journal_head {
 	int b_jcount;
 
 	/*
-	 * Journalling list for this buffer [jbd_lock_bh_state()]
+	 * Journalling list for this buffer [b_state_lock]
 	 * NOTE: We *cannot* combine this with b_modified into a bitfield
 	 * as gcc would then (which the C standard allows but which is
 	 * very unuseful) make 64-bit accesses to the bitfield and clobber
@@ -41,20 +48,20 @@ struct journal_head {
 	/*
 	 * This flag signals the buffer has been modified by
 	 * the currently running transaction
-	 * [jbd_lock_bh_state()]
+	 * [b_state_lock]
 	 */
 	unsigned b_modified;
 
 	/*
 	 * Copy of the buffer data frozen for writing to the log.
-	 * [jbd_lock_bh_state()]
+	 * [b_state_lock]
 	 */
 	char *b_frozen_data;
 
 	/*
 	 * Pointer to a saved copy of the buffer containing no uncommitted
 	 * deallocation references, so that allocations can avoid overwriting
-	 * uncommitted deletes. [jbd_lock_bh_state()]
+	 * uncommitted deletes. [b_state_lock]
 	 */
 	char *b_committed_data;
 
@@ -63,7 +70,7 @@ struct journal_head {
 	 * metadata: either the running transaction or the committing
 	 * transaction (if there is one).  Only applies to buffers on a
 	 * transaction's data or metadata journaling list.
-	 * [j_list_lock] [jbd_lock_bh_state()]
+	 * [j_list_lock] [b_state_lock]
 	 * Either of these locks is enough for reading, both are needed for
 	 * changes.
 	 */
@@ -73,13 +80,13 @@ struct journal_head {
 	 * Pointer to the running compound transaction which is currently
 	 * modifying the buffer's metadata, if there was already a transaction
 	 * committing it when the new transaction touched it.
-	 * [t_list_lock] [jbd_lock_bh_state()]
+	 * [t_list_lock] [b_state_lock]
 	 */
 	transaction_t *b_next_transaction;
 
 	/*
 	 * Doubly-linked list of buffers on a transaction's data, metadata or
-	 * forget queue. [t_list_lock] [jbd_lock_bh_state()]
+	 * forget queue. [t_list_lock] [b_state_lock]
 	 */
 	struct journal_head *b_tnext, *b_tprev;
 
-- 
2.16.4

