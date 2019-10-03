Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB46CB1B4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfJCWF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387938AbfJCWF6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84FF7B15A;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CEF81E4814; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 19/22] jbd2: Rename h_buffer_credits to h_total_credits
Date:   Fri,  4 Oct 2019 00:06:05 +0200
Message-Id: <20191003220613.10791-19-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The credit counter now contains both buffer and revoke descriptor block
credits. Rename to counter to h_total_credits to reflect that. No
functional change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 30 +++++++++++++++---------------
 include/linux/jbd2.h  |  9 +++++----
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c59eb08dba3c..8851cbbe3579 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -312,12 +312,12 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 			     gfp_t gfp_mask)
 {
 	transaction_t	*transaction, *new_transaction = NULL;
-	int		blocks = handle->h_buffer_credits;
+	int		blocks = handle->h_total_credits;
 	int		rsv_blocks = 0;
 	unsigned long ts = jiffies;
 
 	if (handle->h_rsv_handle)
-		rsv_blocks = handle->h_rsv_handle->h_buffer_credits;
+		rsv_blocks = handle->h_rsv_handle->h_total_credits;
 
 	/*
 	 * Limit the number of reserved credits to 1/2 of maximum transaction
@@ -445,7 +445,7 @@ static handle_t *new_handle(int nblocks)
 	handle_t *handle = jbd2_alloc_handle(GFP_NOFS);
 	if (!handle)
 		return NULL;
-	handle->h_buffer_credits = nblocks;
+	handle->h_total_credits = nblocks;
 	handle->h_ref = 1;
 
 	return handle;
@@ -534,7 +534,7 @@ static void __jbd2_journal_unreserve_handle(handle_t *handle)
 	journal_t *journal = handle->h_journal;
 
 	WARN_ON(!handle->h_reserved);
-	sub_reserved_credits(journal, handle->h_buffer_credits);
+	sub_reserved_credits(journal, handle->h_total_credits);
 }
 
 void jbd2_journal_free_reserved(handle_t *handle)
@@ -593,7 +593,7 @@ int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
 	handle->h_line_no = line_no;
 	trace_jbd2_handle_start(journal->j_fs_dev->bd_dev,
 				handle->h_transaction->t_tid, type,
-				line_no, handle->h_buffer_credits);
+				line_no, handle->h_total_credits);
 	return 0;
 }
 EXPORT_SYMBOL(jbd2_journal_start_reserved);
@@ -661,10 +661,10 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
 				 transaction->t_tid,
 				 handle->h_type, handle->h_line_no,
-				 handle->h_buffer_credits,
+				 handle->h_total_credits,
 				 nblocks);
 
-	handle->h_buffer_credits += nblocks;
+	handle->h_total_credits += nblocks;
 	handle->h_requested_credits += nblocks;
 	handle->h_revoke_credits += revoke_records;
 	handle->h_revoke_credits_requested += revoke_records;
@@ -691,9 +691,9 @@ static void stop_this_handle(handle_t *handle)
 	revoke_descriptors = DIV_ROUND_UP(
 		handle->h_revoke_credits_requested - handle->h_revoke_credits,
 		journal->j_revoke_records_per_block);
-	WARN_ON_ONCE(revoke_descriptors > handle->h_buffer_credits);
-	handle->h_buffer_credits -= revoke_descriptors;
-	atomic_sub(handle->h_buffer_credits,
+	WARN_ON_ONCE(revoke_descriptors > handle->h_total_credits);
+	handle->h_total_credits -= revoke_descriptors;
+	atomic_sub(handle->h_total_credits,
 		   &transaction->t_outstanding_credits);
 	if (handle->h_rsv_handle)
 		__jbd2_journal_unreserve_handle(handle->h_rsv_handle);
@@ -753,7 +753,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
-	handle->h_buffer_credits = nblocks +
+	handle->h_total_credits = nblocks +
 		DIV_ROUND_UP(revoke_records,
 			     journal->j_revoke_records_per_block);
 	handle->h_revoke_credits = revoke_records;
@@ -1458,12 +1458,12 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		 * of the transaction. This needs to be done
 		 * once a transaction -bzzz
 		 */
-		if (handle->h_buffer_credits <= 0) {
+		if (handle->h_total_credits <= 0) {
 			ret = -ENOSPC;
 			goto out_unlock_bh;
 		}
 		jh->b_modified = 1;
-		handle->h_buffer_credits--;
+		handle->h_total_credits--;
 	}
 
 	/*
@@ -1707,7 +1707,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 drop:
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
-		handle->h_buffer_credits++;
+		handle->h_total_credits++;
 	}
 	return err;
 
@@ -1768,7 +1768,7 @@ int jbd2_journal_stop(handle_t *handle)
 				jiffies - handle->h_start_jiffies,
 				handle->h_sync, handle->h_requested_credits,
 				(handle->h_requested_credits -
-				 handle->h_buffer_credits));
+				 handle->h_total_credits));
 
 	/*
 	 * Implement synchronous transaction batching.  If the handle
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 36100fe9eab9..94116b1ff274 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -477,7 +477,8 @@ struct jbd2_revoke_table_s;
  * @h_transaction: Which compound transaction is this update a part of?
  * @h_journal: Which journal handle belongs to - used iff h_reserved set.
  * @h_rsv_handle: Handle reserved for finishing the logical operation.
- * @h_buffer_credits: Number of remaining buffers we are allowed to dirty.
+ * @h_total_credits: Number of remaining buffers we are allowed to add to
+	journal. These are dirty buffers and revoke descriptor blocks.
  * @h_revoke_credits: Number of remaining revoke records available for handle
  * @h_ref: Reference count on this handle.
  * @h_err: Field for caller's use to track errors through large fs operations.
@@ -488,7 +489,7 @@ struct jbd2_revoke_table_s;
  * @h_type: For handle statistics.
  * @h_line_no: For handle statistics.
  * @h_start_jiffies: Handle Start time.
- * @h_requested_credits: Holds @h_buffer_credits after handle is started.
+ * @h_requested_credits: Holds @h_total_credits after handle is started.
  * @h_revoke_credits_requested: Holds @h_revoke_credits after handle is started.
  * @saved_alloc_context: Saved context while transaction is open.
  **/
@@ -506,7 +507,7 @@ struct jbd2_journal_handle
 	};
 
 	handle_t		*h_rsv_handle;
-	int			h_buffer_credits;
+	int			h_total_credits;
 	int			h_revoke_credits;
 	int			h_revoke_credits_requested;
 	int			h_ref;
@@ -1644,7 +1645,7 @@ static inline int jbd2_handle_buffer_credits(handle_t *handle)
 {
 	journal_t *journal = handle->h_transaction->t_journal;
 
-	return handle->h_buffer_credits -
+	return handle->h_total_credits -
 		DIV_ROUND_UP(handle->h_revoke_credits_requested,
 			     journal->j_revoke_records_per_block);
 }
-- 
2.16.4

