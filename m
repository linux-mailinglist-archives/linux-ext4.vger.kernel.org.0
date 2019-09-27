Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16832C03F7
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2019 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfI0LQL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Sep 2019 07:16:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbfI0LQH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Sep 2019 07:16:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 052EDB14B;
        Fri, 27 Sep 2019 11:16:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DC8F1E4830; Fri, 27 Sep 2019 13:16:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/15] jbd2: Reserve space for revoke descriptor blocks
Date:   Fri, 27 Sep 2019 13:15:32 +0200
Message-Id: <20190927111536.16455-12-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190927111536.16455-1-jack@suse.cz>
References: <20190927111536.16455-1-jack@suse.cz>
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
 fs/jbd2/journal.c     | 18 ++++++++++++++++++
 fs/jbd2/revoke.c      |  2 ++
 fs/jbd2/transaction.c | 35 ++++++++++++++++++++++++++++-------
 fs/ocfs2/journal.c    |  4 ++--
 include/linux/jbd2.h  | 20 ++++++++++++++++----
 7 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c70b08d104c..6dcbce19294f 100644
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
index ef8fcf7d0d3b..3eced2f6f84b 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -335,14 +335,14 @@ static inline handle_t *ext4_journal_current_handle(void)
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
index 810363443df4..bc5ce834e8eb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1101,6 +1101,21 @@ static void jbd2_stats_proc_exit(journal_t *journal)
 	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
 }
 
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
  * Management for journal control blocks: functions to create and
  * destroy journal_t structures, and to initialise and read existing
@@ -1175,6 +1190,9 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
+	journal->j_revoke_records_per_block =
+				journal_revoke_records_per_block(journal);
+
 	return journal;
 
 err_cleanup:
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 69b9bc329964..f74f73a003b7 100644
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
index 767f062b4893..76e96e557c1d 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -99,7 +99,7 @@ static void jbd2_get_transaction(journal_t *journal,
 	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
-		   jbd2_decriptor_blocks_per_trans(journal) +
+		   jbd2_descriptor_blocks_per_trans(journal) +
 		   atomic_read(&journal->j_reserved_credits));
 	atomic_set(&transaction->t_handle_count, 0);
 	INIT_LIST_HEAD(&transaction->t_inode_list);
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
 
@@ -611,7 +615,7 @@ EXPORT_SYMBOL(jbd2_journal_start_reserved);
  * return code < 0 implies an error
  * return code > 0 implies normal transaction-full status.
  */
-int jbd2_journal_extend(handle_t *handle, int nblocks)
+int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
@@ -633,6 +637,12 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
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
@@ -652,6 +662,8 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 
 	handle->h_buffer_credits += nblocks;
 	handle->h_requested_credits += nblocks;
+	handle->h_revoke_credits += revoke_records;
+	handle->h_revoke_credits_requested += revoke_records;
 	result = 0;
 
 	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
@@ -666,10 +678,17 @@ static void stop_this_handle(handle_t *handle)
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
@@ -701,7 +720,8 @@ static void stop_this_handle(handle_t *handle)
  * credits. We preserve reserved handle if there's any attached to the
  * passed in handle.
  */
-int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
+int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
+			  gfp_t gfp_mask)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
@@ -729,6 +749,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
 	handle->h_buffer_credits = nblocks;
+	handle->h_revoke_credits = revoke_records;
 	return start_this_handle(journal, handle, gfp_mask);
 }
 EXPORT_SYMBOL(jbd2__journal_restart);
@@ -736,7 +757,7 @@ EXPORT_SYMBOL(jbd2__journal_restart);
 
 int jbd2_journal_restart(handle_t *handle, int nblocks)
 {
-	return jbd2__journal_restart(handle, nblocks, GFP_NOFS);
+	return jbd2__journal_restart(handle, nblocks, 0, GFP_NOFS);
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 930e3d388579..0acffe5886d4 100644
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
index 8e9a9d24d746..eb87f322d407 100644
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
@@ -505,6 +506,8 @@ struct jbd2_journal_handle
 
 	handle_t		*h_rsv_handle;
 	int			h_buffer_credits;
+	int			h_revoke_credits;
+	int			h_revoke_credits_requested;
 	int			h_ref;
 	int			h_err;
 
@@ -1024,6 +1027,13 @@ struct journal_s
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
@@ -1358,14 +1368,16 @@ static inline handle_t *journal_current_handle(void)
 
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
-- 
2.16.4

