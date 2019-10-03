Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4096ECB1B3
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfJCWF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:49704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387933AbfJCWF5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 887FEB15B;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5925F1E4817; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 18/22] jbd2: Reserve space for revoke descriptor blocks
Date:   Fri,  4 Oct 2019 00:06:04 +0200
Message-Id: <20191003220613.10791-18-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Extend functions for starting, extending, and restarting transaction
handles to take number of revoke records handle must be able to
accommodate. These functions then make sure transaction has enough
credits to be able to store resulting revoke descriptor blocks. Also
revoke code tracks number of revoke records created by a handle to catch
situation where some place didn't reserve enough space for revoke
records. Similarly to standard transaction credits, space for unused
reserved revoke records is released when the handle is stopped.

On the ext4 side we currently take a simplistic approach of reserving
space for 1024 revoke records for any transaction. This grows amount of
credits reserved for each handle only by a few and is enough for any
normal workload so that we don't hit warnings in jbd2. We will refine
the logic in following commits.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c   |  2 +-
 fs/ext4/ext4_jbd2.h   |  4 ++--
 fs/jbd2/journal.c     | 17 +++++++++++++++++
 fs/jbd2/revoke.c      |  2 ++
 fs/jbd2/transaction.c | 39 ++++++++++++++++++++++++++++++++-------
 fs/ocfs2/journal.c    |  4 ++--
 include/linux/jbd2.h  | 27 ++++++++++++++++++++++-----
 7 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 731bbfdbce5b..b81190bee32d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -78,7 +78,7 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 	journal = EXT4_SB(sb)->s_journal;
 	if (!journal)
 		return ext4_get_nojournal();
-	return jbd2__journal_start(journal, blocks, rsv_blocks, GFP_NOFS,
+	return jbd2__journal_start(journal, blocks, rsv_blocks, 1024, GFP_NOFS,
 				   type, line);
 }
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 36aa72599646..aca05e52e317 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -328,14 +328,14 @@ static inline handle_t *ext4_journal_current_handle(void)
 static inline int ext4_journal_extend(handle_t *handle, int nblocks)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_extend(handle, nblocks);
+		return jbd2_journal_extend(handle, nblocks, 1024);
 	return 0;
 }
 
 static inline int ext4_journal_restart(handle_t *handle, int nblocks)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_restart(handle, nblocks);
+		return jbd2__journal_restart(handle, nblocks, 1024, GFP_NOFS);
 	return 0;
 }
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a4ec198b10c5..388f0a8c4a37 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1489,6 +1489,21 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
+static int journal_revoke_records_per_block(journal_t *journal)
+{
+	int record_size;
+	int space = journal->j_blocksize - sizeof(jbd2_journal_revoke_header_t);
+
+	if (jbd2_has_feature_64bit(journal))
+		record_size = 8;
+	else
+		record_size = 4;
+
+	if (jbd2_journal_has_csum_v2or3(journal))
+		space -= sizeof(struct jbd2_journal_block_tail);
+	return space / record_size;
+}
+
 /*
  * Read the superblock for a given journal, performing initial
  * validation of the format.
@@ -1597,6 +1612,8 @@ static int journal_get_superblock(journal_t *journal)
 						   sizeof(sb->s_uuid));
 	}
 
+	journal->j_revoke_records_per_block =
+				journal_revoke_records_per_block(journal);
 	set_buffer_verified(bh);
 
 	return 0;
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index f08073d7bbf5..cba797f1d3f4 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -391,6 +391,8 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 			__brelse(bh);
 		}
 	}
+	WARN_ON_ONCE(handle->h_revoke_credits <= 0);
+	handle->h_revoke_credits--;
 
 	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a4ee905db00f..c59eb08dba3c 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -418,6 +418,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	update_t_max_wait(transaction, ts);
 	handle->h_transaction = transaction;
 	handle->h_requested_credits = blocks;
+	handle->h_revoke_credits_requested = handle->h_revoke_credits;
 	handle->h_start_jiffies = jiffies;
 	atomic_inc(&transaction->t_updates);
 	atomic_inc(&transaction->t_handle_count);
@@ -451,8 +452,8 @@ static handle_t *new_handle(int nblocks)
 }
 
 handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
-			      gfp_t gfp_mask, unsigned int type,
-			      unsigned int line_no)
+			      int revoke_records, gfp_t gfp_mask,
+			      unsigned int type, unsigned int line_no)
 {
 	handle_t *handle = journal_current_handle();
 	int err;
@@ -466,6 +467,8 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		return handle;
 	}
 
+	nblocks += DIV_ROUND_UP(revoke_records,
+				journal->j_revoke_records_per_block);
 	handle = new_handle(nblocks);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
@@ -481,6 +484,7 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		rsv_handle->h_journal = journal;
 		handle->h_rsv_handle = rsv_handle;
 	}
+	handle->h_revoke_credits = revoke_records;
 
 	err = start_this_handle(journal, handle, gfp_mask);
 	if (err < 0) {
@@ -521,7 +525,7 @@ EXPORT_SYMBOL(jbd2__journal_start);
  */
 handle_t *jbd2_journal_start(journal_t *journal, int nblocks)
 {
-	return jbd2__journal_start(journal, nblocks, 0, GFP_NOFS, 0, 0);
+	return jbd2__journal_start(journal, nblocks, 0, 0, GFP_NOFS, 0, 0);
 }
 EXPORT_SYMBOL(jbd2_journal_start);
 
@@ -598,6 +602,7 @@ EXPORT_SYMBOL(jbd2_journal_start_reserved);
  * int jbd2_journal_extend() - extend buffer credits.
  * @handle:  handle to 'extend'
  * @nblocks: nr blocks to try to extend by.
+ * @revoke_records: number of revoke records to try to extend by.
  *
  * Some transactions, such as large extends and truncates, can be done
  * atomically all at once or in several stages.  The operation requests
@@ -614,7 +619,7 @@ EXPORT_SYMBOL(jbd2_journal_start_reserved);
  * return code < 0 implies an error
  * return code > 0 implies normal transaction-full status.
  */
-int jbd2_journal_extend(handle_t *handle, int nblocks)
+int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
@@ -636,6 +641,12 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 		goto error_out;
 	}
 
+	nblocks += DIV_ROUND_UP(
+			handle->h_revoke_credits_requested + revoke_records,
+			journal->j_revoke_records_per_block) -
+		DIV_ROUND_UP(
+			handle->h_revoke_credits_requested,
+			journal->j_revoke_records_per_block);
 	spin_lock(&transaction->t_handle_lock);
 	wanted = atomic_add_return(nblocks,
 				   &transaction->t_outstanding_credits);
@@ -655,6 +666,8 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 
 	handle->h_buffer_credits += nblocks;
 	handle->h_requested_credits += nblocks;
+	handle->h_revoke_credits += revoke_records;
+	handle->h_revoke_credits_requested += revoke_records;
 	result = 0;
 
 	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
@@ -669,10 +682,17 @@ static void stop_this_handle(handle_t *handle)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
+	int revoke_descriptors;
 
 	J_ASSERT(journal_current_handle() == handle);
 	J_ASSERT(atomic_read(&transaction->t_updates) > 0);
 	current->journal_info = NULL;
+	/* Subtract necessary revoke descriptor blocks from handle credits */
+	revoke_descriptors = DIV_ROUND_UP(
+		handle->h_revoke_credits_requested - handle->h_revoke_credits,
+		journal->j_revoke_records_per_block);
+	WARN_ON_ONCE(revoke_descriptors > handle->h_buffer_credits);
+	handle->h_buffer_credits -= revoke_descriptors;
 	atomic_sub(handle->h_buffer_credits,
 		   &transaction->t_outstanding_credits);
 	if (handle->h_rsv_handle)
@@ -692,6 +712,7 @@ static void stop_this_handle(handle_t *handle)
  * int jbd2_journal_restart() - restart a handle .
  * @handle:  handle to restart
  * @nblocks: nr credits requested
+ * @revoke_records: number of revoke record credits requested
  * @gfp_mask: memory allocation flags (for start_this_handle)
  *
  * Restart a handle for a multi-transaction filesystem
@@ -704,7 +725,8 @@ static void stop_this_handle(handle_t *handle)
  * credits. We preserve reserved handle if there's any attached to the
  * passed in handle.
  */
-int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
+int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
+			  gfp_t gfp_mask)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
@@ -731,7 +753,10 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
-	handle->h_buffer_credits = nblocks;
+	handle->h_buffer_credits = nblocks +
+		DIV_ROUND_UP(revoke_records,
+			     journal->j_revoke_records_per_block);
+	handle->h_revoke_credits = revoke_records;
 	return start_this_handle(journal, handle, gfp_mask);
 }
 EXPORT_SYMBOL(jbd2__journal_restart);
@@ -739,7 +764,7 @@ EXPORT_SYMBOL(jbd2__journal_restart);
 
 int jbd2_journal_restart(handle_t *handle, int nblocks)
 {
-	return jbd2__journal_restart(handle, nblocks, GFP_NOFS);
+	return jbd2__journal_restart(handle, nblocks, 0, GFP_NOFS);
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 019aaf2a3f8a..a032f0297dad 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -426,7 +426,7 @@ int ocfs2_extend_trans(handle_t *handle, int nblocks)
 #ifdef CONFIG_OCFS2_DEBUG_FS
 	status = 1;
 #else
-	status = jbd2_journal_extend(handle, nblocks);
+	status = jbd2_journal_extend(handle, nblocks, 0);
 	if (status < 0) {
 		mlog_errno(status);
 		goto bail;
@@ -466,7 +466,7 @@ int ocfs2_allocate_extend_trans(handle_t *handle, int thresh)
 	if (old_nblks < thresh)
 		return 0;
 
-	status = jbd2_journal_extend(handle, OCFS2_MAX_TRANS_DATA);
+	status = jbd2_journal_extend(handle, OCFS2_MAX_TRANS_DATA, 0);
 	if (status < 0) {
 		mlog_errno(status);
 		goto bail;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index dd8905763a3b..36100fe9eab9 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -478,6 +478,7 @@ struct jbd2_revoke_table_s;
  * @h_journal: Which journal handle belongs to - used iff h_reserved set.
  * @h_rsv_handle: Handle reserved for finishing the logical operation.
  * @h_buffer_credits: Number of remaining buffers we are allowed to dirty.
+ * @h_revoke_credits: Number of remaining revoke records available for handle
  * @h_ref: Reference count on this handle.
  * @h_err: Field for caller's use to track errors through large fs operations.
  * @h_sync: Flag for sync-on-close.
@@ -488,6 +489,7 @@ struct jbd2_revoke_table_s;
  * @h_line_no: For handle statistics.
  * @h_start_jiffies: Handle Start time.
  * @h_requested_credits: Holds @h_buffer_credits after handle is started.
+ * @h_revoke_credits_requested: Holds @h_revoke_credits after handle is started.
  * @saved_alloc_context: Saved context while transaction is open.
  **/
 
@@ -505,6 +507,8 @@ struct jbd2_journal_handle
 
 	handle_t		*h_rsv_handle;
 	int			h_buffer_credits;
+	int			h_revoke_credits;
+	int			h_revoke_credits_requested;
 	int			h_ref;
 	int			h_err;
 
@@ -1024,6 +1028,13 @@ struct journal_s
 	 */
 	int			j_max_transaction_buffers;
 
+	/**
+	 * @j_revoke_records_per_block:
+	 *
+	 * Number of revoke records that fit in one descriptor block.
+	 */
+	int			j_revoke_records_per_block;
+
 	/**
 	 * @j_commit_interval:
 	 *
@@ -1358,14 +1369,16 @@ static inline handle_t *journal_current_handle(void)
 
 extern handle_t *jbd2_journal_start(journal_t *, int nblocks);
 extern handle_t *jbd2__journal_start(journal_t *, int blocks, int rsv_blocks,
-				     gfp_t gfp_mask, unsigned int type,
-				     unsigned int line_no);
+				     int revoke_records, gfp_t gfp_mask,
+				     unsigned int type, unsigned int line_no);
 extern int	 jbd2_journal_restart(handle_t *, int nblocks);
-extern int	 jbd2__journal_restart(handle_t *, int nblocks, gfp_t gfp_mask);
+extern int	 jbd2__journal_restart(handle_t *, int nblocks,
+				       int revoke_records, gfp_t gfp_mask);
 extern int	 jbd2_journal_start_reserved(handle_t *handle,
 				unsigned int type, unsigned int line_no);
 extern void	 jbd2_journal_free_reserved(handle_t *handle);
-extern int	 jbd2_journal_extend (handle_t *, int nblocks);
+extern int	 jbd2_journal_extend(handle_t *handle, int nblocks,
+				     int revoke_records);
 extern int	 jbd2_journal_get_write_access(handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_get_create_access (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_get_undo_access(handle_t *, struct buffer_head *);
@@ -1629,7 +1642,11 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 
 static inline int jbd2_handle_buffer_credits(handle_t *handle)
 {
-	return handle->h_buffer_credits;
+	journal_t *journal = handle->h_transaction->t_journal;
+
+	return handle->h_buffer_credits -
+		DIV_ROUND_UP(handle->h_revoke_credits_requested,
+			     journal->j_revoke_records_per_block);
 }
 
 #ifdef __KERNEL__
-- 
2.16.4

