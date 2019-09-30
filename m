Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73856C1F65
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfI3Kna (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730819AbfI3Kn0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AEACAF8E;
        Mon, 30 Sep 2019 10:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED5DE1E4833; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 13/19] jbd2: Factor out common parts of stopping and restarting a handle
Date:   Mon, 30 Sep 2019 12:43:31 +0200
Message-Id: <20190930104339.24919-13-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2__journal_restart() has quite some code that is common with
jbd2_journal_stop(). Factor this functionality into stop_this_handle()
helper and use it from both functions. Note that this also drops
t_handle_lock protection from jbd2__journal_restart() as
jbd2_journal_stop() does the same thing without it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 94 +++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ece3e97279c2..8a42c717e260 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -512,12 +512,17 @@ handle_t *jbd2_journal_start(journal_t *journal, int nblocks)
 }
 EXPORT_SYMBOL(jbd2_journal_start);
 
-void jbd2_journal_free_reserved(handle_t *handle)
+static void __jbd2_journal_unreserve_handle(handle_t *handle)
 {
 	journal_t *journal = handle->h_journal;
 
 	WARN_ON(!handle->h_reserved);
 	sub_reserved_credits(journal, handle->h_buffer_credits);
+}
+
+void jbd2_journal_free_reserved(handle_t *handle)
+{
+	__jbd2_journal_unreserve_handle(handle);
 	jbd2_free_handle(handle);
 }
 EXPORT_SYMBOL(jbd2_journal_free_reserved);
@@ -652,6 +657,28 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 	return result;
 }
 
+static void stop_this_handle(handle_t *handle)
+{
+	transaction_t *transaction = handle->h_transaction;
+	journal_t *journal = transaction->t_journal;
+
+	J_ASSERT(journal_current_handle() == handle);
+	J_ASSERT(atomic_read(&transaction->t_updates) > 0);
+	current->journal_info = NULL;
+	atomic_sub(handle->h_buffer_credits,
+		   &transaction->t_outstanding_credits);
+	if (handle->h_rsv_handle)
+		__jbd2_journal_unreserve_handle(handle->h_rsv_handle);
+	if (atomic_dec_and_test(&transaction->t_updates))
+		wake_up(&journal->j_wait_updates);
+
+	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
+	/*
+	 * Scope of the GFP_NOFS context is over here and so we can restore the
+	 * original alloc context.
+	 */
+	memalloc_nofs_restore(handle->saved_alloc_context);
+}
 
 /**
  * int jbd2_journal_restart() - restart a handle .
@@ -674,52 +701,30 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
 	tid_t		tid;
-	int		need_to_start, ret;
+	int		need_to_start;
 
 	/* If we've had an abort of any type, don't even think about
 	 * actually doing the restart! */
 	if (is_handle_aborted(handle))
 		return 0;
 	journal = transaction->t_journal;
+	tid = transaction->t_tid;
 
 	/*
 	 * First unlink the handle from its current transaction, and start the
 	 * commit on that.
 	 */
-	J_ASSERT(atomic_read(&transaction->t_updates) > 0);
-	J_ASSERT(journal_current_handle() == handle);
-
-	read_lock(&journal->j_state_lock);
-	spin_lock(&transaction->t_handle_lock);
-	atomic_sub(handle->h_buffer_credits,
-		   &transaction->t_outstanding_credits);
-	if (handle->h_rsv_handle) {
-		sub_reserved_credits(journal,
-				     handle->h_rsv_handle->h_buffer_credits);
-	}
-	if (atomic_dec_and_test(&transaction->t_updates))
-		wake_up(&journal->j_wait_updates);
-	tid = transaction->t_tid;
-	spin_unlock(&transaction->t_handle_lock);
+	jbd_debug(2, "restarting handle %p\n", handle);
+	stop_this_handle(handle);
 	handle->h_transaction = NULL;
-	current->journal_info = NULL;
 
-	jbd_debug(2, "restarting handle %p\n", handle);
+	read_lock(&journal->j_state_lock);
 	need_to_start = !tid_geq(journal->j_commit_request, tid);
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
-
-	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
 	handle->h_buffer_credits = nblocks;
-	/*
-	 * Restore the original nofs context because the journal restart
-	 * is basically the same thing as journal stop and start.
-	 * start_this_handle will start a new nofs context.
-	 */
-	memalloc_nofs_restore(handle->saved_alloc_context);
-	ret = start_this_handle(journal, handle, gfp_mask);
-	return ret;
+	return start_this_handle(journal, handle, gfp_mask);
 }
 EXPORT_SYMBOL(jbd2__journal_restart);
 
@@ -1715,16 +1720,12 @@ int jbd2_journal_stop(handle_t *handle)
 		 * Handle is already detached from the transaction so there is
 		 * nothing to do other than free the handle.
 		 */
-		if (handle->h_rsv_handle)
-			jbd2_free_handle(handle->h_rsv_handle);
+		memalloc_nofs_restore(handle->saved_alloc_context);
 		goto free_and_exit;
 	}
 	journal = transaction->t_journal;
 	tid = transaction->t_tid;
 
-	J_ASSERT(journal_current_handle() == handle);
-	J_ASSERT(atomic_read(&transaction->t_updates) > 0);
-
 	if (is_handle_aborted(handle))
 		err = -EIO;
 
@@ -1794,9 +1795,6 @@ int jbd2_journal_stop(handle_t *handle)
 
 	if (handle->h_sync)
 		transaction->t_synchronous_commit = 1;
-	current->journal_info = NULL;
-	atomic_sub(handle->h_buffer_credits,
-		   &transaction->t_outstanding_credits);
 
 	/*
 	 * If the handle is marked SYNC, we need to set another commit
@@ -1823,27 +1821,19 @@ int jbd2_journal_stop(handle_t *handle)
 	}
 
 	/*
-	 * Once we drop t_updates, if it goes to zero the transaction
-	 * could start committing on us and eventually disappear.  So
-	 * once we do this, we must not dereference transaction
-	 * pointer again.
+	 * Once stop_this_handle() drops t_updates, the transaction could start
+	 * committing on us and eventually disappear.  So we must not
+	 * dereference transaction pointer again after calling
+	 * stop_this_handle().
 	 */
-	if (atomic_dec_and_test(&transaction->t_updates))
-		wake_up(&journal->j_wait_updates);
-
-	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
+	stop_this_handle(handle);
 
 	if (wait_for_commit)
 		err = jbd2_log_wait_commit(journal, tid);
 
-	if (handle->h_rsv_handle)
-		jbd2_journal_free_reserved(handle->h_rsv_handle);
 free_and_exit:
-	/*
-	 * Scope of the GFP_NOFS context is over here and so we can restore the
-	 * original alloc context.
-	 */
-	memalloc_nofs_restore(handle->saved_alloc_context);
+	if (handle->h_rsv_handle)
+		jbd2_free_handle(handle->h_rsv_handle);
 	jbd2_free_handle(handle);
 	return err;
 }
-- 
2.16.4

