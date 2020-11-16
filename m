Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC612B40B3
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Nov 2020 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKPKSo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Nov 2020 05:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbgKPKSe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:34 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECFF223AB;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=etIanj9l03l4xGXT0KcfpOSZbNAsd1do42lIuT+N14k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrEMDOVecgRARBjj1C3UUbqQtZefqkX47VadXYyXDo2vEwdBAij6STuD1q892XrQs
         gAojRSxfiFx+1wpufYNCB0vKQb5dtwNkN2QWDd3qmsA2ZBSGb7VIkso31CGzbwrIRt
         Uz7IkgmLrh/ub0IJ3VMOTZFmTSz2St3HQoJKDPss=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEG-8q; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 12/27] jbd2: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:08 +0100
Message-Id: <72f5c6628f5f278d67625f60893ffbc2ca28d46e.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kernel-doc markup should use this format:
        identifier - description

They should not have any type before that, as otherwise
the parser won't do the right thing.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/jbd2/journal.c     | 34 ++++++++++++++++++----------------
 fs/jbd2/transaction.c | 31 ++++++++++++++++---------------
 include/linux/jbd2.h  |  2 +-
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0c3d5e3b24b2..188f79d76988 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -549,57 +549,59 @@ static int __jbd2_journal_force_commit(journal_t *journal)
 	} else if (journal->j_committing_transaction)
 		transaction = journal->j_committing_transaction;
 
 	if (!transaction) {
 		/* Nothing to commit */
 		read_unlock(&journal->j_state_lock);
 		return 0;
 	}
 	tid = transaction->t_tid;
 	read_unlock(&journal->j_state_lock);
 	if (need_to_start)
 		jbd2_log_start_commit(journal, tid);
 	ret = jbd2_log_wait_commit(journal, tid);
 	if (!ret)
 		ret = 1;
 
 	return ret;
 }
 
 /**
- * Force and wait upon a commit if the calling process is not within
- * transaction.  This is used for forcing out undo-protected data which contains
- * bitmaps, when the fs is running out of space.
+ * jbd2_journal_force_commit_nested - Force and wait upon a commit if the
+ * calling process is not within transaction.
  *
  * @journal: journal to force
  * Returns true if progress was made.
+ *
+ * This is used for forcing out undo-protected data which contains
+ * bitmaps, when the fs is running out of space.
  */
 int jbd2_journal_force_commit_nested(journal_t *journal)
 {
 	int ret;
 
 	ret = __jbd2_journal_force_commit(journal);
 	return ret > 0;
 }
 
 /**
- * int journal_force_commit() - force any uncommitted transactions
+ * jbd2_journal_force_commit() - force any uncommitted transactions
  * @journal: journal to force
  *
  * Caller want unconditional commit. We can only force the running transaction
  * if we don't have an active handle, otherwise, we will deadlock.
  */
 int jbd2_journal_force_commit(journal_t *journal)
 {
 	int ret;
 
 	J_ASSERT(!current->journal_info);
 	ret = __jbd2_journal_force_commit(journal);
 	if (ret > 0)
 		ret = 0;
 	return ret;
 }
 
 /*
  * Start a commit of the current running transaction (if any).  Returns true
  * if a transaction is going to be committed (or is currently already
  * committing), and fills its tid in at *ptid
@@ -1864,41 +1866,41 @@ static int load_superblock(journal_t *journal)
 	journal->j_first = be32_to_cpu(sb->s_first);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 	journal->j_last = be32_to_cpu(sb->s_maxlen);
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
 		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
 		if (!num_fc_blocks)
 			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
 		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
 			journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
 		journal->j_fc_off = 0;
 	}
 
 	return 0;
 }
 
 
 /**
- * int jbd2_journal_load() - Read journal from disk.
+ * jbd2_journal_load() - Read journal from disk.
  * @journal: Journal to act on.
  *
  * Given a journal_t structure which tells us which disk blocks contain
  * a journal, read the journal from disk to initialise the in-memory
  * structures.
  */
 int jbd2_journal_load(journal_t *journal)
 {
 	int err;
 	journal_superblock_t *sb;
 
 	err = load_superblock(journal);
 	if (err)
 		return err;
 
 	sb = journal->j_superblock;
 	/* If this is a V2 superblock, then we have to check the
 	 * features flags on it. */
 
 	if (journal->j_format_version >= 2) {
@@ -1934,41 +1936,41 @@ int jbd2_journal_load(journal_t *journal)
 	 * clear JBD2_ABORT flag initialized in journal_init_common
 	 * here to update log tail information with the newest seq.
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
 	if (journal_reset(journal))
 		goto recovery_error;
 
 	journal->j_flags |= JBD2_LOADED;
 	return 0;
 
 recovery_error:
 	printk(KERN_WARNING "JBD2: recovery failed\n");
 	return -EIO;
 }
 
 /**
- * void jbd2_journal_destroy() - Release a journal_t structure.
+ * jbd2_journal_destroy() - Release a journal_t structure.
  * @journal: Journal to act on.
  *
  * Release a journal_t structure once it is no longer in use by the
  * journaled object.
  * Return <0 if we couldn't clean up the journal.
  */
 int jbd2_journal_destroy(journal_t *journal)
 {
 	int err = 0;
 
 	/* Wait for the commit thread to wake up and die. */
 	journal_kill_thread(journal);
 
 	/* Force a final log commit */
 	if (journal->j_running_transaction)
 		jbd2_journal_commit_transaction(journal);
 
 	/* Force any old transactions to disk */
 
 	/* Totally anal locking here... */
@@ -2011,76 +2013,76 @@ int jbd2_journal_destroy(journal_t *journal)
 			err = -EIO;
 		brelse(journal->j_sb_buffer);
 	}
 
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
 	iput(journal->j_inode);
 	if (journal->j_revoke)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
 	return err;
 }
 
 
 /**
- *int jbd2_journal_check_used_features() - Check if features specified are used.
+ * jbd2_journal_check_used_features() - Check if features specified are used.
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
  *
  * Check whether the journal uses all of a given set of
  * features.  Return true (non-zero) if it does.
  **/
 
 int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 				 unsigned long ro, unsigned long incompat)
 {
 	journal_superblock_t *sb;
 
 	if (!compat && !ro && !incompat)
 		return 1;
 	/* Load journal superblock if it is not loaded yet. */
 	if (journal->j_format_version == 0 &&
 	    journal_get_superblock(journal) != 0)
 		return 0;
 	if (journal->j_format_version == 1)
 		return 0;
 
 	sb = journal->j_superblock;
 
 	if (((be32_to_cpu(sb->s_feature_compat) & compat) == compat) &&
 	    ((be32_to_cpu(sb->s_feature_ro_compat) & ro) == ro) &&
 	    ((be32_to_cpu(sb->s_feature_incompat) & incompat) == incompat))
 		return 1;
 
 	return 0;
 }
 
 /**
- * int jbd2_journal_check_available_features() - Check feature set in journalling layer
+ * jbd2_journal_check_available_features() - Check feature set in journalling layer
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
  *
  * Check whether the journaling code supports the use of
  * all of a given set of features on this journal.  Return true
  * (non-zero) if it can. */
 
 int jbd2_journal_check_available_features(journal_t *journal, unsigned long compat,
 				      unsigned long ro, unsigned long incompat)
 {
 	if (!compat && !ro && !incompat)
 		return 1;
 
 	/* We can support any known requested features iff the
 	 * superblock is in version 2.  Otherwise we fail to support any
 	 * extended sb features. */
 
 	if (journal->j_format_version != 2)
@@ -2109,41 +2111,41 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	/* Are we called twice? */
 	WARN_ON(journal->j_fc_wbuf != NULL);
 	journal->j_fc_wbuf = kmalloc_array(num_fc_blks,
 				sizeof(struct buffer_head *), GFP_KERNEL);
 	if (!journal->j_fc_wbuf)
 		return -ENOMEM;
 
 	journal->j_fc_wbufsize = num_fc_blks;
 	journal->j_fc_last = journal->j_last;
 	journal->j_last = journal->j_fc_last - num_fc_blks;
 	journal->j_fc_first = journal->j_last + 1;
 	journal->j_fc_off = 0;
 	journal->j_free = journal->j_last - journal->j_first;
 	journal->j_max_transaction_buffers =
 		jbd2_journal_get_max_txn_bufs(journal);
 
 	return 0;
 }
 
 /**
- * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
+ * jbd2_journal_set_features() - Mark a given journal feature in the superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
  *
  * Mark a given journal feature as present on the
  * superblock.  Returns true if the requested features could be set.
  *
  */
 
 int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 			  unsigned long ro, unsigned long incompat)
 {
 #define INCOMPAT_FEATURE_ON(f) \
 		((incompat & (f)) && !(sb->s_feature_incompat & cpu_to_be32(f)))
 #define COMPAT_FEATURE_ON(f) \
 		((compat & (f)) && !(sb->s_feature_compat & cpu_to_be32(f)))
 	journal_superblock_t *sb;
 
 	if (jbd2_journal_check_used_features(journal, compat, ro, incompat))
@@ -2200,70 +2202,70 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 
 	/* If enabling v1 checksums, downgrade superblock */
 	if (COMPAT_FEATURE_ON(JBD2_FEATURE_COMPAT_CHECKSUM))
 		sb->s_feature_incompat &=
 			~cpu_to_be32(JBD2_FEATURE_INCOMPAT_CSUM_V2 |
 				     JBD2_FEATURE_INCOMPAT_CSUM_V3);
 
 	sb->s_feature_compat    |= cpu_to_be32(compat);
 	sb->s_feature_ro_compat |= cpu_to_be32(ro);
 	sb->s_feature_incompat  |= cpu_to_be32(incompat);
 	unlock_buffer(journal->j_sb_buffer);
 	journal->j_revoke_records_per_block =
 				journal_revoke_records_per_block(journal);
 
 	return 1;
 #undef COMPAT_FEATURE_ON
 #undef INCOMPAT_FEATURE_ON
 }
 
 /*
- * jbd2_journal_clear_features () - Clear a given journal feature in the
+ * jbd2_journal_clear_features() - Clear a given journal feature in the
  * 				    superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
  *
  * Clear a given journal feature as present on the
  * superblock.
  */
 void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 				unsigned long ro, unsigned long incompat)
 {
 	journal_superblock_t *sb;
 
 	jbd_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
 
 	sb->s_feature_compat    &= ~cpu_to_be32(compat);
 	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
 	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
 	journal->j_revoke_records_per_block =
 				journal_revoke_records_per_block(journal);
 }
 EXPORT_SYMBOL(jbd2_journal_clear_features);
 
 /**
- * int jbd2_journal_flush () - Flush journal
+ * jbd2_journal_flush() - Flush journal
  * @journal: Journal to act on.
  *
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
  * recovery does not need to happen on remount.
  */
 
 int jbd2_journal_flush(journal_t *journal)
 {
 	int err = 0;
 	transaction_t *transaction = NULL;
 
 	write_lock(&journal->j_state_lock);
 
 	/* Force everything buffered to the log... */
 	if (journal->j_running_transaction) {
 		transaction = journal->j_running_transaction;
 		__jbd2_log_start_commit(journal, transaction->t_tid);
 	} else if (journal->j_committing_transaction)
 		transaction = journal->j_committing_transaction;
@@ -2304,82 +2306,82 @@ int jbd2_journal_flush(journal_t *journal)
 
 	/* Finally, mark the journal as really needing no recovery.
 	 * This sets s_start==0 in the underlying superblock, which is
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
 	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
 	mutex_unlock(&journal->j_checkpoint_mutex);
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(!journal->j_running_transaction);
 	J_ASSERT(!journal->j_committing_transaction);
 	J_ASSERT(!journal->j_checkpoint_transactions);
 	J_ASSERT(journal->j_head == journal->j_tail);
 	J_ASSERT(journal->j_tail_sequence == journal->j_transaction_sequence);
 	write_unlock(&journal->j_state_lock);
 out:
 	return err;
 }
 
 /**
- * int jbd2_journal_wipe() - Wipe journal contents
+ * jbd2_journal_wipe() - Wipe journal contents
  * @journal: Journal to act on.
  * @write: flag (see below)
  *
  * Wipe out all of the contents of a journal, safely.  This will produce
  * a warning if the journal contains any valid recovery information.
  * Must be called between journal_init_*() and jbd2_journal_load().
  *
  * If 'write' is non-zero, then we wipe out the journal on disk; otherwise
  * we merely suppress recovery.
  */
 
 int jbd2_journal_wipe(journal_t *journal, int write)
 {
 	int err = 0;
 
 	J_ASSERT (!(journal->j_flags & JBD2_LOADED));
 
 	err = load_superblock(journal);
 	if (err)
 		return err;
 
 	if (!journal->j_tail)
 		goto no_recovery;
 
 	printk(KERN_WARNING "JBD2: %s recovery information on journal\n",
 		write ? "Clearing" : "Ignoring");
 
 	err = jbd2_journal_skip_recovery(journal);
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock_io(&journal->j_checkpoint_mutex);
 		jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
  no_recovery:
 	return err;
 }
 
 /**
- * void jbd2_journal_abort () - Shutdown the journal immediately.
+ * jbd2_journal_abort () - Shutdown the journal immediately.
  * @journal: the journal to shutdown.
  * @errno:   an error number to record in the journal indicating
  *           the reason for the shutdown.
  *
  * Perform a complete, immediate shutdown of the ENTIRE
  * journal (not of a single transaction).  This operation cannot be
  * undone without closing and reopening the journal.
  *
  * The jbd2_journal_abort function is intended to support higher level error
  * recovery mechanisms such as the ext2/ext3 remount-readonly error
  * mode.
  *
  * Journal abort has very specific semantics.  Any existing dirty,
  * unjournaled buffers in the main filesystem will still be written to
  * disk by bdflush, but the journaling mechanism will be suspended
  * immediately and no further transaction commits will be honoured.
  *
  * Any dirty, journaled buffers will be written back to disk without
  * hitting the journal.  Atomicity cannot be guaranteed on an aborted
  * filesystem, but we _do_ attempt to leave as much data as possible
@@ -2436,85 +2438,85 @@ void jbd2_journal_abort(journal_t *journal, int errno)
 	 * to release all journaled buffer.
 	 */
 	pr_err("Aborting journal on device %s.\n", journal->j_devname);
 
 	journal->j_flags |= JBD2_ABORT;
 	journal->j_errno = errno;
 	transaction = journal->j_running_transaction;
 	if (transaction)
 		__jbd2_log_start_commit(journal, transaction->t_tid);
 	write_unlock(&journal->j_state_lock);
 
 	/*
 	 * Record errno to the journal super block, so that fsck and jbd2
 	 * layer could realise that a filesystem check is needed.
 	 */
 	jbd2_journal_update_sb_errno(journal);
 	mutex_unlock(&journal->j_abort_mutex);
 }
 
 /**
- * int jbd2_journal_errno () - returns the journal's error state.
+ * jbd2_journal_errno() - returns the journal's error state.
  * @journal: journal to examine.
  *
  * This is the errno number set with jbd2_journal_abort(), the last
  * time the journal was mounted - if the journal was stopped
  * without calling abort this will be 0.
  *
  * If the journal has been aborted on this mount time -EROFS will
  * be returned.
  */
 int jbd2_journal_errno(journal_t *journal)
 {
 	int err;
 
 	read_lock(&journal->j_state_lock);
 	if (journal->j_flags & JBD2_ABORT)
 		err = -EROFS;
 	else
 		err = journal->j_errno;
 	read_unlock(&journal->j_state_lock);
 	return err;
 }
 
 /**
- * int jbd2_journal_clear_err () - clears the journal's error state
+ * jbd2_journal_clear_err() - clears the journal's error state
  * @journal: journal to act on.
  *
  * An error must be cleared or acked to take a FS out of readonly
  * mode.
  */
 int jbd2_journal_clear_err(journal_t *journal)
 {
 	int err = 0;
 
 	write_lock(&journal->j_state_lock);
 	if (journal->j_flags & JBD2_ABORT)
 		err = -EROFS;
 	else
 		journal->j_errno = 0;
 	write_unlock(&journal->j_state_lock);
 	return err;
 }
 
 /**
- * void jbd2_journal_ack_err() - Ack journal err.
+ * jbd2_journal_ack_err() - Ack journal err.
  * @journal: journal to act on.
  *
  * An error must be cleared or acked to take a FS out of readonly
  * mode.
  */
 void jbd2_journal_ack_err(journal_t *journal)
 {
 	write_lock(&journal->j_state_lock);
 	if (journal->j_errno)
 		journal->j_flags |= JBD2_ACK_ERR;
 	write_unlock(&journal->j_state_lock);
 }
 
 int jbd2_journal_blocks_per_page(struct inode *inode)
 {
 	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
 }
 
 /*
  * helper functions to deal with 32 or 64bit block numbers.
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index d54f04674e8e..9396666b7314 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -502,41 +502,41 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 
 	err = start_this_handle(journal, handle, gfp_mask);
 	if (err < 0) {
 		if (handle->h_rsv_handle)
 			jbd2_free_handle(handle->h_rsv_handle);
 		jbd2_free_handle(handle);
 		return ERR_PTR(err);
 	}
 	handle->h_type = type;
 	handle->h_line_no = line_no;
 	trace_jbd2_handle_start(journal->j_fs_dev->bd_dev,
 				handle->h_transaction->t_tid, type,
 				line_no, nblocks);
 
 	return handle;
 }
 EXPORT_SYMBOL(jbd2__journal_start);
 
 
 /**
- * handle_t *jbd2_journal_start() - Obtain a new handle.
+ * jbd2_journal_start() - Obtain a new handle.
  * @journal: Journal to start transaction on.
  * @nblocks: number of block buffer we might modify
  *
  * We make sure that the transaction can guarantee at least nblocks of
  * modified buffers in the log.  We block until the log can guarantee
  * that much space. Additionally, if rsv_blocks > 0, we also create another
  * handle with rsv_blocks reserved blocks in the journal. This handle is
  * stored in h_rsv_handle. It is not attached to any particular transaction
  * and thus doesn't block transaction commit. If the caller uses this reserved
  * handle, it has to set h_rsv_handle to NULL as otherwise jbd2_journal_stop()
  * on the parent handle will dispose the reserved one. Reserved handle has to
  * be converted to a normal handle using jbd2_journal_start_reserved() before
  * it can be used.
  *
  * Return a pointer to a newly allocated handle, or an ERR_PTR() value
  * on failure.
  */
 handle_t *jbd2_journal_start(journal_t *journal, int nblocks)
 {
 	return jbd2__journal_start(journal, nblocks, 0, 0, GFP_NOFS, 0, 0);
@@ -549,41 +549,41 @@ static void __jbd2_journal_unreserve_handle(handle_t *handle, transaction_t *t)
 
 	WARN_ON(!handle->h_reserved);
 	sub_reserved_credits(journal, handle->h_total_credits);
 	if (t)
 		atomic_sub(handle->h_total_credits, &t->t_outstanding_credits);
 }
 
 void jbd2_journal_free_reserved(handle_t *handle)
 {
 	journal_t *journal = handle->h_journal;
 
 	/* Get j_state_lock to pin running transaction if it exists */
 	read_lock(&journal->j_state_lock);
 	__jbd2_journal_unreserve_handle(handle, journal->j_running_transaction);
 	read_unlock(&journal->j_state_lock);
 	jbd2_free_handle(handle);
 }
 EXPORT_SYMBOL(jbd2_journal_free_reserved);
 
 /**
- * int jbd2_journal_start_reserved() - start reserved handle
+ * jbd2_journal_start_reserved() - start reserved handle
  * @handle: handle to start
  * @type: for handle statistics
  * @line_no: for handle statistics
  *
  * Start handle that has been previously reserved with jbd2_journal_reserve().
  * This attaches @handle to the running transaction (or creates one if there's
  * not transaction running). Unlike jbd2_journal_start() this function cannot
  * block on journal commit, checkpointing, or similar stuff. It can block on
  * memory allocation or frozen journal though.
  *
  * Return 0 on success, non-zero on error - handle is freed in that case.
  */
 int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
 				unsigned int line_no)
 {
 	journal_t *journal = handle->h_journal;
 	int ret = -EIO;
 
 	if (WARN_ON(!handle->h_reserved)) {
 		/* Someone passed in normal handle? Just stop it. */
@@ -603,41 +603,41 @@ int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
 	/*
 	 * GFP_NOFS is here because callers are likely from writeback or
 	 * similarly constrained call sites
 	 */
 	ret = start_this_handle(journal, handle, GFP_NOFS);
 	if (ret < 0) {
 		handle->h_journal = journal;
 		jbd2_journal_free_reserved(handle);
 		return ret;
 	}
 	handle->h_type = type;
 	handle->h_line_no = line_no;
 	trace_jbd2_handle_start(journal->j_fs_dev->bd_dev,
 				handle->h_transaction->t_tid, type,
 				line_no, handle->h_total_credits);
 	return 0;
 }
 EXPORT_SYMBOL(jbd2_journal_start_reserved);
 
 /**
- * int jbd2_journal_extend() - extend buffer credits.
+ * jbd2_journal_extend() - extend buffer credits.
  * @handle:  handle to 'extend'
  * @nblocks: nr blocks to try to extend by.
  * @revoke_records: number of revoke records to try to extend by.
  *
  * Some transactions, such as large extends and truncates, can be done
  * atomically all at once or in several stages.  The operation requests
  * a credit for a number of buffer modifications in advance, but can
  * extend its credit if it needs more.
  *
  * jbd2_journal_extend tries to give the running handle more buffer credits.
  * It does not guarantee that allocation - this is a best-effort only.
  * The calling process MUST be able to deal cleanly with a failure to
  * extend here.
  *
  * Return 0 on success, non-zero on failure.
  *
  * return code < 0 implies an error
  * return code > 0 implies normal transaction-full status.
  */
 int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
@@ -728,41 +728,41 @@ static void stop_this_handle(handle_t *handle)
 			DIV_ROUND_UP(t_revokes - revokes, rr_per_blk);
 		handle->h_total_credits -= revoke_descriptors;
 	}
 	atomic_sub(handle->h_total_credits,
 		   &transaction->t_outstanding_credits);
 	if (handle->h_rsv_handle)
 		__jbd2_journal_unreserve_handle(handle->h_rsv_handle,
 						transaction);
 	if (atomic_dec_and_test(&transaction->t_updates))
 		wake_up(&journal->j_wait_updates);
 
 	rwsem_release(&journal->j_trans_commit_map, _THIS_IP_);
 	/*
 	 * Scope of the GFP_NOFS context is over here and so we can restore the
 	 * original alloc context.
 	 */
 	memalloc_nofs_restore(handle->saved_alloc_context);
 }
 
 /**
- * int jbd2_journal_restart() - restart a handle .
+ * jbd2__journal_restart() - restart a handle .
  * @handle:  handle to restart
  * @nblocks: nr credits requested
  * @revoke_records: number of revoke record credits requested
  * @gfp_mask: memory allocation flags (for start_this_handle)
  *
  * Restart a handle for a multi-transaction filesystem
  * operation.
  *
  * If the jbd2_journal_extend() call above fails to grant new buffer credits
  * to a running handle, a call to jbd2_journal_restart will commit the
  * handle's transaction so far and reattach the handle to a new
  * transaction capable of guaranteeing the requested number of
  * credits. We preserve reserved handle if there's any attached to the
  * passed in handle.
  */
 int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 			  gfp_t gfp_mask)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
@@ -798,41 +798,41 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 		DIV_ROUND_UP(revoke_records,
 			     journal->j_revoke_records_per_block);
 	handle->h_revoke_credits = revoke_records;
 	ret = start_this_handle(journal, handle, gfp_mask);
 	trace_jbd2_handle_restart(journal->j_fs_dev->bd_dev,
 				 ret ? 0 : handle->h_transaction->t_tid,
 				 handle->h_type, handle->h_line_no,
 				 handle->h_total_credits);
 	return ret;
 }
 EXPORT_SYMBOL(jbd2__journal_restart);
 
 
 int jbd2_journal_restart(handle_t *handle, int nblocks)
 {
 	return jbd2__journal_restart(handle, nblocks, 0, GFP_NOFS);
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
 /**
- * void jbd2_journal_lock_updates () - establish a transaction barrier.
+ * jbd2_journal_lock_updates () - establish a transaction barrier.
  * @journal:  Journal to establish a barrier on.
  *
  * This locks out any further updates from being started, and blocks
  * until all existing updates have completed, returning only once the
  * journal is in a quiescent state with no updates running.
  *
  * The journal lock should not be held on entry.
  */
 void jbd2_journal_lock_updates(journal_t *journal)
 {
 	DEFINE_WAIT(wait);
 
 	jbd2_might_wait_for_commit(journal);
 
 	write_lock(&journal->j_state_lock);
 	++journal->j_barrier_count;
 
 	/* Wait until there are no reserved handles */
 	if (atomic_read(&journal->j_reserved_credits)) {
 		write_unlock(&journal->j_state_lock);
@@ -857,41 +857,41 @@ void jbd2_journal_lock_updates(journal_t *journal)
 			break;
 		}
 		spin_unlock(&transaction->t_handle_lock);
 		write_unlock(&journal->j_state_lock);
 		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
 		write_lock(&journal->j_state_lock);
 	}
 	write_unlock(&journal->j_state_lock);
 
 	/*
 	 * We have now established a barrier against other normal updates, but
 	 * we also need to barrier against other jbd2_journal_lock_updates() calls
 	 * to make sure that we serialise special journal-locked operations
 	 * too.
 	 */
 	mutex_lock(&journal->j_barrier);
 }
 
 /**
- * void jbd2_journal_unlock_updates (journal_t* journal) - release barrier
+ * jbd2_journal_unlock_updates () - release barrier
  * @journal:  Journal to release the barrier on.
  *
  * Release a transaction barrier obtained with jbd2_journal_lock_updates().
  *
  * Should be called without the journal lock held.
  */
 void jbd2_journal_unlock_updates (journal_t *journal)
 {
 	J_ASSERT(journal->j_barrier_count != 0);
 
 	mutex_unlock(&journal->j_barrier);
 	write_lock(&journal->j_state_lock);
 	--journal->j_barrier_count;
 	write_unlock(&journal->j_state_lock);
 	wake_up(&journal->j_wait_transaction_locked);
 }
 
 static void warn_dirty_buffer(struct buffer_head *bh)
 {
 	printk(KERN_WARNING
@@ -1165,41 +1165,42 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
 		goto out;
 	/*
 	 * There are two reasons for the barrier here:
 	 * 1) Make sure to fetch b_bh after we did previous checks so that we
 	 * detect when jh went through free, realloc, attach to transaction
 	 * while we were checking. Paired with implicit barrier in that path.
 	 * 2) So that access to bh done after jbd2_write_access_granted()
 	 * doesn't get reordered and see inconsistent state of concurrent
 	 * do_get_write_access().
 	 */
 	smp_mb();
 	if (unlikely(jh->b_bh != bh))
 		goto out;
 	ret = true;
 out:
 	rcu_read_unlock();
 	return ret;
 }
 
 /**
- * int jbd2_journal_get_write_access() - notify intent to modify a buffer for metadata (not data) update.
+ * jbd2_journal_get_write_access() - notify intent to modify a buffer
+ *				     for metadata (not data) update.
  * @handle: transaction to add buffer modifications to
  * @bh:     bh to be used for metadata writes
  *
  * Returns: error code or 0 on success.
  *
  * In full data journalling mode the buffer may be of type BJ_AsyncData,
  * because we're ``write()ing`` a buffer which is also part of a shared mapping.
  */
 
 int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 {
 	struct journal_head *jh;
 	int rc;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
 
 	if (jbd2_write_access_granted(handle, bh, false))
 		return 0;
 
@@ -1209,41 +1210,41 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 	 * completes any outstanding IO before proceeding. */
 	rc = do_get_write_access(handle, jh, 0);
 	jbd2_journal_put_journal_head(jh);
 	return rc;
 }
 
 
 /*
  * When the user wants to journal a newly created buffer_head
  * (ie. getblk() returned a new buffer and we are going to populate it
  * manually rather than reading off disk), then we need to keep the
  * buffer_head locked until it has been completely filled with new
  * data.  In this case, we should be able to make the assertion that
  * the bh is not already part of an existing transaction.
  *
  * The buffer should already be locked by the caller by this point.
  * There is no lock ranking violation: it was a newly created,
  * unlocked buffer beforehand. */
 
 /**
- * int jbd2_journal_get_create_access () - notify intent to use newly created bh
+ * jbd2_journal_get_create_access () - notify intent to use newly created bh
  * @handle: transaction to new buffer to
  * @bh: new buffer.
  *
  * Call this if you create a new bh.
  */
 int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
 	struct journal_head *jh = jbd2_journal_add_journal_head(bh);
 	int err;
 
 	jbd_debug(5, "journal_head %p\n", jh);
 	err = -EROFS;
 	if (is_handle_aborted(handle))
 		goto out;
 	journal = transaction->t_journal;
 	err = 0;
 
 	JBUFFER_TRACE(jh, "entry");
@@ -1289,41 +1290,41 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 		jh->b_next_transaction = transaction;
 		spin_unlock(&journal->j_list_lock);
 	}
 	spin_unlock(&jh->b_state_lock);
 
 	/*
 	 * akpm: I added this.  ext3_alloc_branch can pick up new indirect
 	 * blocks which contain freed but then revoked metadata.  We need
 	 * to cancel the revoke in case we end up freeing it yet again
 	 * and the reallocating as data - this would cause a second revoke,
 	 * which hits an assertion error.
 	 */
 	JBUFFER_TRACE(jh, "cancelling revoke");
 	jbd2_journal_cancel_revoke(handle, jh);
 out:
 	jbd2_journal_put_journal_head(jh);
 	return err;
 }
 
 /**
- * int jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
+ * jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
  *     non-rewindable consequences
  * @handle: transaction
  * @bh: buffer to undo
  *
  * Sometimes there is a need to distinguish between metadata which has
  * been committed to disk and that which has not.  The ext3fs code uses
  * this for freeing and allocating space, we have to make sure that we
  * do not reuse freed space until the deallocation has been committed,
  * since if we overwrote that space we would make the delete
  * un-rewindable in case of a crash.
  *
  * To deal with that, jbd2_journal_get_undo_access requests write access to a
  * buffer for parts of non-rewindable operations such as delete
  * operations on the bitmaps.  The journaling code must keep a copy of
  * the buffer's contents prior to the undo_access call until such time
  * as we know that the buffer has definitely been committed to disk.
  *
  * We never need to know which transaction the committed data is part
  * of, buffers touched here are guaranteed to be dirtied later and so
  * will be committed to a new transaction in due course, at which point
@@ -1366,41 +1367,41 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 		 * preserved, committed copy. */
 		JBUFFER_TRACE(jh, "generate b_committed data");
 		if (!committed_data) {
 			spin_unlock(&jh->b_state_lock);
 			goto repeat;
 		}
 
 		jh->b_committed_data = committed_data;
 		committed_data = NULL;
 		memcpy(jh->b_committed_data, bh->b_data, bh->b_size);
 	}
 	spin_unlock(&jh->b_state_lock);
 out:
 	jbd2_journal_put_journal_head(jh);
 	if (unlikely(committed_data))
 		jbd2_free(committed_data, bh->b_size);
 	return err;
 }
 
 /**
- * void jbd2_journal_set_triggers() - Add triggers for commit writeout
+ * jbd2_journal_set_triggers() - Add triggers for commit writeout
  * @bh: buffer to trigger on
  * @type: struct jbd2_buffer_trigger_type containing the trigger(s).
  *
  * Set any triggers on this journal_head.  This is always safe, because
  * triggers for a committing buffer will be saved off, and triggers for
  * a running transaction will match the buffer in that transaction.
  *
  * Call with NULL to clear the triggers.
  */
 void jbd2_journal_set_triggers(struct buffer_head *bh,
 			       struct jbd2_buffer_trigger_type *type)
 {
 	struct journal_head *jh = jbd2_journal_grab_journal_head(bh);
 
 	if (WARN_ON(!jh))
 		return;
 	jh->b_triggers = type;
 	jbd2_journal_put_journal_head(jh);
 }
 
@@ -1408,41 +1409,41 @@ void jbd2_buffer_frozen_trigger(struct journal_head *jh, void *mapped_data,
 				struct jbd2_buffer_trigger_type *triggers)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
 	if (!triggers || !triggers->t_frozen)
 		return;
 
 	triggers->t_frozen(triggers, bh, mapped_data, bh->b_size);
 }
 
 void jbd2_buffer_abort_trigger(struct journal_head *jh,
 			       struct jbd2_buffer_trigger_type *triggers)
 {
 	if (!triggers || !triggers->t_abort)
 		return;
 
 	triggers->t_abort(triggers, jh2bh(jh));
 }
 
 /**
- * int jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
+ * jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
  * @handle: transaction to add buffer to.
  * @bh: buffer to mark
  *
  * mark dirty metadata which needs to be journaled as part of the current
  * transaction.
  *
  * The buffer must have previously had jbd2_journal_get_write_access()
  * called so that it has a valid journal_head attached to the buffer
  * head.
  *
  * The buffer is placed on the transaction's metadata list and is marked
  * as belonging to the transaction.
  *
  * Returns error number or 0 on success.
  *
  * Special care needs to be taken if the buffer already belongs to the
  * current committing transaction (in which case we should have frozen
  * data present for that commit).  In that case, we don't relink the
  * buffer: that only gets done when the old transaction finally
  * completes its commit.
@@ -1576,41 +1577,41 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		/* And this case is illegal: we can't reuse another
 		 * transaction's data buffer, ever. */
 		goto out_unlock_bh;
 	}
 
 	/* That test should have eliminated the following case: */
 	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
 	spin_lock(&journal->j_list_lock);
 	__jbd2_journal_file_buffer(jh, transaction, BJ_Metadata);
 	spin_unlock(&journal->j_list_lock);
 out_unlock_bh:
 	spin_unlock(&jh->b_state_lock);
 out:
 	JBUFFER_TRACE(jh, "exit");
 	return ret;
 }
 
 /**
- * void jbd2_journal_forget() - bforget() for potentially-journaled buffers.
+ * jbd2_journal_forget() - bforget() for potentially-journaled buffers.
  * @handle: transaction handle
  * @bh:     bh to 'forget'
  *
  * We can only do the bforget if there are no commits pending against the
  * buffer.  If the buffer is dirty in the current running transaction we
  * can safely unlink it.
  *
  * bh may not be a journalled buffer at all - it may be a non-JBD
  * buffer which came off the hashtable.  Check for this.
  *
  * Decrements bh->b_count by one.
  *
  * Allow this call even if the handle has aborted --- it may be part of
  * the caller's cleanup after an abort.
  */
 int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
 	struct journal_head *jh;
@@ -1745,41 +1746,41 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		 * attach this buffer to current transaction so that the
 		 * buffer can be checkpointed only after the current
 		 * transaction commits.
 		 */
 		clear_buffer_dirty(bh);
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
 	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
 		handle->h_total_credits++;
 	}
 	return err;
 }
 
 /**
- * int jbd2_journal_stop() - complete a transaction
+ * jbd2_journal_stop() - complete a transaction
  * @handle: transaction to complete.
  *
  * All done for a particular handle.
  *
  * There is not much action needed here.  We just return any remaining
  * buffer credits to the transaction and remove the handle.  The only
  * complication is that we need to start a commit operation if the
  * filesystem is marked for synchronous update.
  *
  * jbd2_journal_stop itself will not usually return an error, but it may
  * do so in unusual circumstances.  In particular, expect it to
  * return -EIO if a jbd2_journal_abort has been executed since the
  * transaction began.
  */
 int jbd2_journal_stop(handle_t *handle)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
 	int err = 0, wait_for_commit = 0;
 	tid_t tid;
@@ -2063,41 +2064,41 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 	jh = bh2jh(bh);
 
 	if (buffer_locked(bh) || buffer_dirty(bh))
 		goto out;
 
 	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
 		goto out;
 
 	spin_lock(&journal->j_list_lock);
 	if (jh->b_cp_transaction != NULL) {
 		/* written-back checkpointed metadata buffer */
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		__jbd2_journal_remove_checkpoint(jh);
 	}
 	spin_unlock(&journal->j_list_lock);
 out:
 	return;
 }
 
 /**
- * int jbd2_journal_try_to_free_buffers() - try to free page buffers.
+ * jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
  *
  * For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
  * so try_to_free_buffers() can reap them.
  *
  * This function returns non-zero if we wish try_to_free_buffers()
  * to be called. We do this if the page is releasable by try_to_free_buffers().
  * We also do it if the page has locked or dirty buffers and the caller wants
  * us to perform sync or async writeout.
  *
  * This complicates JBD locking somewhat.  We aren't protected by the
  * BKL here.  We wish to remove the buffer from its committing or
  * running transaction's ->t_datalist via __jbd2_journal_unfile_buffer.
  *
  * This may *change* the value of transaction_t->t_datalist, so anyone
  * who looks at t_datalist needs to lock against this function.
  *
  * Even worse, someone may be doing a jbd2_journal_dirty_data on this
@@ -2394,41 +2395,41 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	 * here.
 	 */
 	jh->b_modified = 0;
 	spin_unlock(&journal->j_list_lock);
 	spin_unlock(&jh->b_state_lock);
 	write_unlock(&journal->j_state_lock);
 	jbd2_journal_put_journal_head(jh);
 zap_buffer_unlocked:
 	clear_buffer_dirty(bh);
 	J_ASSERT_BH(bh, !buffer_jbddirty(bh));
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
 	clear_buffer_delay(bh);
 	clear_buffer_unwritten(bh);
 	bh->b_bdev = NULL;
 	return may_free;
 }
 
 /**
- * void jbd2_journal_invalidatepage()
+ * jbd2_journal_invalidatepage()
  * @journal: journal to use for flush...
  * @page:    page to flush
  * @offset:  start of the range to invalidate
  * @length:  length of the range to invalidate
  *
  * Reap page buffers containing data after in the specified range in page.
  * Can return -EBUSY if buffers are part of the committing transaction and
  * the page is straddling i_size. Caller then has to wait for current commit
  * and try again.
  */
 int jbd2_journal_invalidatepage(journal_t *journal,
 				struct page *page,
 				unsigned int offset,
 				unsigned int length)
 {
 	struct buffer_head *head, *bh, *next;
 	unsigned int stop = offset + length;
 	unsigned int curr_off = 0;
 	int partial_page = (offset || length < PAGE_SIZE);
 	int may_free = 1;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1c49fd62ff2e..578ff196b3ce 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -384,41 +384,41 @@ static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 #define J_EXPECT_JH(jh, expr, why...)	__journal_expect(expr, ## why)
 #endif
 
 /* Flags in jbd_inode->i_flags */
 #define __JI_COMMIT_RUNNING 0
 #define __JI_WRITE_DATA 1
 #define __JI_WAIT_DATA 2
 
 /*
  * Commit of the inode data in progress. We use this flag to protect us from
  * concurrent deletion of inode. We cannot use reference to inode for this
  * since we cannot afford doing last iput() on behalf of kjournald
  */
 #define JI_COMMIT_RUNNING (1 << __JI_COMMIT_RUNNING)
 /* Write allocated dirty buffers in this inode before commit */
 #define JI_WRITE_DATA (1 << __JI_WRITE_DATA)
 /* Wait for outstanding data writes for this inode before commit */
 #define JI_WAIT_DATA (1 << __JI_WAIT_DATA)
 
 /**
- * struct jbd_inode - The jbd_inode type is the structure linking inodes in
+ * struct jbd2_inode - The jbd_inode type is the structure linking inodes in
  * ordered mode present in a transaction so that we can sync them during commit.
  */
 struct jbd2_inode {
 	/**
 	 * @i_transaction:
 	 *
 	 * Which transaction does this inode belong to? Either the running
 	 * transaction or the committing one. [j_list_lock]
 	 */
 	transaction_t *i_transaction;
 
 	/**
 	 * @i_next_transaction:
 	 *
 	 * Pointer to the running transaction modifying inode's data in case
 	 * there is already a committing transaction touching it. [j_list_lock]
 	 */
 	transaction_t *i_next_transaction;
 
 	/**
-- 
2.28.0

