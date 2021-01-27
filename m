Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1730559B
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 09:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhA0IZu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 03:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhA0IXf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 03:23:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315AEC061756;
        Wed, 27 Jan 2021 00:22:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h15so620310pli.8;
        Wed, 27 Jan 2021 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+o++uQoGBJsTibH+2Cl/GaWZ3sJUCm3Xg9PNQlViHc0=;
        b=fm7Uzj7pg33F4XeArqO0tkHlu5eAG3jI+GeqbEdpkxJbBHX5NZfqBXD4FSzbueCzzD
         cm3XtuaOpYY0m1dRkKin4Q7t0t+tveFUFmpRctXP6P8NdQrs5g6mlm/f5yejLB5V+OtT
         ydqXbBLFc5CWXVpizBaPmr4ig8H/x8/JoV/F3qaHETlMHHkzs8BJ07N5TeoXFhtoxuF3
         6qujH3wr6mUyA9B+YxO6KizP4AVikyzm0zT4x8faZa0r3A3fLDY4QAsERQeNxKiSOTN2
         ztpzHoTDi6CiQfUmg5gDADCz+UAFjTiO5vZLlmqD5xe1fPCxPC2rmBZ5b+c/ZmnKMVkm
         /gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+o++uQoGBJsTibH+2Cl/GaWZ3sJUCm3Xg9PNQlViHc0=;
        b=RqGVG4V3bZKIdw4Q2+CsAFczdkk8dmXojxtDdYqQmmW7P+HjkAf6S1rYOcQosL8Sa3
         Z+3w+H0qM9WfaGejvr+2WrSdJofUldeF4FdfaeI3Ri/tomZerURs0+VohNlJXGqcd+on
         DkLJvjFTas8xH1Sw9uvyaS3n5y8FiXy3RPeM9pp8lADP3mbLIb1isByX8XmBT16A38kA
         fsKpzOBq1MmS5WwWBY7JiNY9xGH1zNWi8UELYl/hhrSgqUiJQNg5mys/QWCNHyaaY8Pu
         /b3wve2x+6GgSzhx6aztOzgQUWX3HQyo/qmqsrcBQkd0WKFDMyhD3wLeFcRZZPIowiXI
         TDOQ==
X-Gm-Message-State: AOAM531POhzup3no89ydRXZo+wZVdczqDaDIg3/MBV1FprTo9ZIo/CU7
        d4ysGAEvAOjcEFm4yOV6v3Y=
X-Google-Smtp-Source: ABdhPJy+yPDpTDSNBODjuFjgcn9FMwYuJy4tlhoWs9sH/5fVSZtS4YpWCPVVJzGuYtk5ImV8CyvSSQ==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr4615559pjh.127.1611735774651;
        Wed, 27 Jan 2021 00:22:54 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id q17sm1499902pfl.143.2021.01.27.00.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:22:54 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/3] jbd2: update the arguments of jbd_debug()
Date:   Wed, 27 Jan 2021 16:22:05 +0800
Message-Id: <01c6819522f087c7be6f91b625a9211831fa39bc.1611733806.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to support jbd2 per device debugging switch, here we need
to replace jbd_debug with a new log interface. But there is a small
disadvantage here. Because the debugging switch is placed in the
journal_t object, the log before the object is initialized will be
lost. However, usually this will not have much impact on debugging.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/jbd2/checkpoint.c  |  6 +++---
 fs/jbd2/commit.c      | 32 ++++++++++++++++----------------
 fs/jbd2/journal.c     | 37 ++++++++++++++++---------------------
 fs/jbd2/recovery.c    | 32 ++++++++++++++++----------------
 fs/jbd2/revoke.c      |  8 ++++----
 fs/jbd2/transaction.c | 28 ++++++++++++++--------------
 6 files changed, 69 insertions(+), 74 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 472932b9e6bc..332a208991a0 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -211,7 +211,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	tid_t			this_tid;
 	int			result, batch_count = 0;
 
-	jbd_debug(1, "Start checkpoint\n");
+	jbd_debug(journal, 1, "Start checkpoint\n");
 
 	/*
 	 * First thing: if there are any transactions in the log which
@@ -220,7 +220,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 */
 	result = jbd2_cleanup_journal_tail(journal);
 	trace_jbd2_checkpoint(journal, result);
-	jbd_debug(1, "cleanup_journal_tail returned %d\n", result);
+	jbd_debug(journal, 1, "cleanup_journal_tail returned %d\n", result);
 	if (result <= 0)
 		return result;
 
@@ -676,5 +676,5 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 
 	trace_jbd2_drop_transaction(journal, transaction);
 
-	jbd_debug(1, "Dropping transaction %d, all done\n", transaction->t_tid);
+	jbd_debug(journal, 1, "Dropping transaction %d, all done\n", transaction->t_tid);
 }
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b121d7d434c6..ccd510faf3f3 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -419,7 +419,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Do we need to erase the effects of a prior jbd2_journal_flush? */
 	if (journal->j_flags & JBD2_FLUSHED) {
-		jbd_debug(3, "super block updated\n");
+		jbd_debug(journal, 3, "super block updated\n");
 		mutex_lock_io(&journal->j_checkpoint_mutex);
 		/*
 		 * We hold j_checkpoint_mutex so tail cannot change under us.
@@ -433,7 +433,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 						REQ_SYNC);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
-		jbd_debug(3, "superblock not updated\n");
+		jbd_debug(journal, 3, "superblock not updated\n");
 	}
 
 	J_ASSERT(journal->j_running_transaction != NULL);
@@ -465,8 +465,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: starting commit of transaction %d\n",
-			commit_transaction->t_tid);
+	jbd_debug(journal, 1, "JBD2: starting commit of transaction %d\n",
+		  commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
 	journal->j_fc_off = 0;
@@ -549,7 +549,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	__jbd2_journal_clean_checkpoint_list(journal, false);
 	spin_unlock(&journal->j_list_lock);
 
-	jbd_debug(3, "JBD2: commit phase 1\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 1\n");
 
 	/*
 	 * Clear revoked flag to reflect there is no revoked buffers
@@ -582,7 +582,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	wake_up(&journal->j_wait_transaction_locked);
 	write_unlock(&journal->j_state_lock);
 
-	jbd_debug(3, "JBD2: commit phase 2a\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 2a\n");
 
 	/*
 	 * Now start flushing things to disk, in the order they appear
@@ -595,7 +595,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	blk_start_plug(&plug);
 	jbd2_journal_write_revoke_records(commit_transaction, &log_bufs);
 
-	jbd_debug(3, "JBD2: commit phase 2b\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 2b\n");
 
 	/*
 	 * Way to go: we have now written out all of the data for a
@@ -651,7 +651,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (!descriptor) {
 			J_ASSERT (bufs == 0);
 
-			jbd_debug(4, "JBD2: get descriptor\n");
+			jbd_debug(journal, 4, "JBD2: get descriptor\n");
 
 			descriptor = jbd2_journal_get_descriptor_buffer(
 							commit_transaction,
@@ -661,7 +661,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				continue;
 			}
 
-			jbd_debug(4, "JBD2: got buffer %llu (%p)\n",
+			jbd_debug(journal, 4, "JBD2: got buffer %llu (%p)\n",
 				(unsigned long long)descriptor->b_blocknr,
 				descriptor->b_data);
 			tagp = &descriptor->b_data[sizeof(journal_header_t)];
@@ -746,7 +746,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		    commit_transaction->t_buffers == NULL ||
 		    space_left < tag_bytes + 16 + csum_size) {
 
-			jbd_debug(4, "JBD2: Submit %d IOs\n", bufs);
+			jbd_debug(journal, 4, "JBD2: Submit %d IOs\n", bufs);
 
 			/* Write an end-of-descriptor marker before
                            submitting the IOs.  "tag" still points to
@@ -848,7 +848,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	   so we incur less scheduling load.
 	*/
 
-	jbd_debug(3, "JBD2: commit phase 3\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 3\n");
 
 	while (!list_empty(&io_bufs)) {
 		struct buffer_head *bh = list_entry(io_bufs.prev,
@@ -891,7 +891,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	J_ASSERT (commit_transaction->t_shadow_list == NULL);
 
-	jbd_debug(3, "JBD2: commit phase 4\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 4\n");
 
 	/* Here we wait for the revoke record and descriptor record buffers */
 	while (!list_empty(&log_bufs)) {
@@ -915,7 +915,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (err)
 		jbd2_journal_abort(journal, err);
 
-	jbd_debug(3, "JBD2: commit phase 5\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 5\n");
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_DFLUSH);
 	commit_transaction->t_state = T_COMMIT_JFLUSH;
@@ -954,7 +954,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
            transaction can be removed from any checkpoint list it was on
            before. */
 
-	jbd_debug(3, "JBD2: commit phase 6\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 6\n");
 
 	J_ASSERT(list_empty(&commit_transaction->t_inode_list));
 	J_ASSERT(commit_transaction->t_buffers == NULL);
@@ -1131,7 +1131,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Done with this transaction! */
 
-	jbd_debug(3, "JBD2: commit phase 7\n");
+	jbd_debug(journal, 3, "JBD2: commit phase 7\n");
 
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_JFLUSH);
 
@@ -1173,7 +1173,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		journal->j_fc_cleanup_callback(journal, 1);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
+	jbd_debug(journal, 1, "JBD2: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 5aca2aee96e5..c84ece7584f6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -204,11 +204,11 @@ static int kjournald2(void *arg)
 	if (journal->j_flags & JBD2_UNMOUNT)
 		goto end_loop;
 
-	jbd_debug(1, "commit_sequence=%u, commit_request=%u\n",
-		journal->j_commit_sequence, journal->j_commit_request);
+	jbd_debug(journal, 1, "commit_sequence=%u, commit_request=%u\n",
+		  journal->j_commit_sequence, journal->j_commit_request);
 
 	if (journal->j_commit_sequence != journal->j_commit_request) {
-		jbd_debug(1, "OK, requests differ\n");
+		jbd_debug(journal, 1, "OK, requests differ\n");
 		write_unlock(&journal->j_state_lock);
 		del_timer_sync(&journal->j_commit_timer);
 		jbd2_journal_commit_transaction(journal);
@@ -223,7 +223,7 @@ static int kjournald2(void *arg)
 		 * good idea, because that depends on threads that may
 		 * be already stopped.
 		 */
-		jbd_debug(1, "Now suspending kjournald2\n");
+		jbd_debug(journal, 1, "Now suspending kjournald2\n");
 		write_unlock(&journal->j_state_lock);
 		try_to_freeze();
 		write_lock(&journal->j_state_lock);
@@ -253,7 +253,7 @@ static int kjournald2(void *arg)
 		finish_wait(&journal->j_wait_commit, &wait);
 	}
 
-	jbd_debug(1, "kjournald2 wakes\n");
+	jbd_debug(journal, 1, "kjournald2 wakes\n");
 
 	/*
 	 * Were we woken up by a commit wakeup event?
@@ -261,7 +261,7 @@ static int kjournald2(void *arg)
 	transaction = journal->j_running_transaction;
 	if (transaction && time_after_eq(jiffies, transaction->t_expires)) {
 		journal->j_commit_request = transaction->t_tid;
-		jbd_debug(1, "woke because of timeout\n");
+		jbd_debug(journal, 1, "woke because of timeout\n");
 	}
 	goto loop;
 
@@ -269,7 +269,7 @@ static int kjournald2(void *arg)
 	del_timer_sync(&journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
-	jbd_debug(1, "Journal thread exiting.\n");
+	jbd_debug(journal, 1, "Journal thread exiting.\n");
 	write_unlock(&journal->j_state_lock);
 	return 0;
 }
@@ -501,7 +501,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 		 */
 
 		journal->j_commit_request = target;
-		jbd_debug(1, "JBD2: requesting commit %u/%u\n",
+		jbd_debug(journal, 1, "JBD2: requesting commit %u/%u\n",
 			  journal->j_commit_request,
 			  journal->j_commit_sequence);
 		journal->j_running_transaction->t_requested = jiffies;
@@ -706,7 +706,7 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
+		jbd_debug(journal, 1, "JBD2: want %u, j_commit_sequence=%u\n",
 				  tid, journal->j_commit_sequence);
 		read_unlock(&journal->j_state_lock);
 		wake_up(&journal->j_wait_commit);
@@ -1124,7 +1124,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 		freed += journal->j_last - journal->j_first;
 
 	trace_jbd2_update_log_tail(journal, tid, block, freed);
-	jbd_debug(1,
+	jbd_debug(journal, 1,
 		  "Cleaning journal tail from %u to %u (offset %lu), "
 		  "freeing %lu\n",
 		  journal->j_tail_sequence, tid, block, freed);
@@ -1500,10 +1500,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		return NULL;
 	}
 
-	jbd_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
-		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
-		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
-
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
 			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
 			inode->i_sb->s_blocksize);
@@ -1579,7 +1575,7 @@ static int journal_reset(journal_t *journal)
 	 * attempting a write to a potential-readonly device.
 	 */
 	if (sb->s_start == 0) {
-		jbd_debug(1, "JBD2: Skipping superblock update on recovered sb "
+		jbd_debug(journal, 1, "JBD2: Skipping superblock update on recovered sb "
 			"(start %ld, seq %u, errno %d)\n",
 			journal->j_tail, journal->j_tail_sequence,
 			journal->j_errno);
@@ -1678,7 +1674,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 		return -EIO;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
-	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
+	jbd_debug(journal, 1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
 
 	lock_buffer(journal->j_sb_buffer);
@@ -1719,7 +1715,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 		return;
 	}
 
-	jbd_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
+	jbd_debug(journal, 1, "JBD2: Marking journal as empty (seq %u)\n",
 		  journal->j_tail_sequence);
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
@@ -1761,7 +1757,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	errcode = journal->j_errno;
 	if (errcode == -ESHUTDOWN)
 		errcode = 0;
-	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
+	jbd_debug(journal, 1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
 	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
@@ -2219,7 +2215,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	    compat & JBD2_FEATURE_COMPAT_CHECKSUM)
 		compat &= ~JBD2_FEATURE_COMPAT_CHECKSUM;
 
-	jbd_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
+	jbd_debug(journal, 1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2288,7 +2284,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 {
 	journal_superblock_t *sb;
 
-	jbd_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
+	jbd_debug(journal, 1, "Clear features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2736,7 +2732,6 @@ static struct journal_head *journal_alloc_journal_head(void)
 #endif
 	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
 	if (!ret) {
-		jbd_debug(1, "out of memory for journal_head\n");
 		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index dc0694fcfcd1..7f91090876f5 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -245,15 +245,15 @@ static int fc_do_one_pass(journal_t *journal,
 		return 0;
 
 	while (next_fc_block <= journal->j_fc_last) {
-		jbd_debug(3, "Fast commit replay: next block %ld",
+		jbd_debug(journal, 3, "Fast commit replay: next block %ld",
 			  next_fc_block);
 		err = jread(&bh, journal, next_fc_block);
 		if (err) {
-			jbd_debug(3, "Fast commit replay: read error");
+			jbd_debug(journal, 3, "Fast commit replay: read error");
 			break;
 		}
 
-		jbd_debug(3, "Processing fast commit blk with seq %d");
+		jbd_debug(journal, 3, "Processing fast commit blk with seq %d");
 		err = journal->j_fc_replay_callback(journal, bh, pass,
 					next_fc_block - journal->j_fc_first,
 					expected_commit_id);
@@ -264,7 +264,7 @@ static int fc_do_one_pass(journal_t *journal,
 	}
 
 	if (err)
-		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+		jbd_debug(journal, 3, "Fast commit replay failed, err = %d\n", err);
 
 	return err;
 }
@@ -298,7 +298,7 @@ int jbd2_journal_recover(journal_t *journal)
 	 */
 
 	if (!sb->s_start) {
-		jbd_debug(1, "No recovery required, last transaction %d\n",
+		jbd_debug(journal, 1, "No recovery required, last transaction %d\n",
 			  be32_to_cpu(sb->s_sequence));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
 		return 0;
@@ -310,10 +310,10 @@ int jbd2_journal_recover(journal_t *journal)
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REPLAY);
 
-	jbd_debug(1, "JBD2: recovery, exit status %d, "
+	jbd_debug(journal, 1, "JBD2: recovery, exit status %d, "
 		  "recovered transactions %u to %u\n",
 		  err, info.start_transaction, info.end_transaction);
-	jbd_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
+	jbd_debug(journal, 1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
 		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);
 
 	/* Restart the log at the next transaction ID, thus invalidating
@@ -363,7 +363,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 #ifdef CONFIG_JBD2_DEBUG
 		int dropped = info.end_transaction - 
 			be32_to_cpu(journal->j_superblock->s_sequence);
-		jbd_debug(1,
+		jbd_debug(journal, 1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
 			  dropped, (dropped == 1) ? "" : "s");
 #endif
@@ -485,7 +485,7 @@ static int do_one_pass(journal_t *journal,
 	if (pass == PASS_SCAN)
 		info->start_transaction = first_commit_ID;
 
-	jbd_debug(1, "Starting recovery pass %d\n", pass);
+	jbd_debug(journal, 1, "Starting recovery pass %d\n", pass);
 
 	/*
 	 * Now we walk through the log, transaction by transaction,
@@ -511,7 +511,7 @@ static int do_one_pass(journal_t *journal,
 			if (tid_geq(next_commit_ID, info->end_transaction))
 				break;
 
-		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
+		jbd_debug(journal, 2, "Scanning for sequence ID %u at %lu/%lu\n",
 			  next_commit_ID, next_log_block,
 			  jbd2_has_feature_fast_commit(journal) ?
 			  journal->j_fc_last : journal->j_last);
@@ -520,7 +520,7 @@ static int do_one_pass(journal_t *journal,
 		 * either the next descriptor block or the final commit
 		 * record. */
 
-		jbd_debug(3, "JBD2: checking block %ld\n", next_log_block);
+		jbd_debug(journal, 3, "JBD2: checking block %ld\n", next_log_block);
 		err = jread(&bh, journal, next_log_block);
 		if (err)
 			goto failed;
@@ -543,7 +543,7 @@ static int do_one_pass(journal_t *journal,
 
 		blocktype = be32_to_cpu(tmp->h_blocktype);
 		sequence = be32_to_cpu(tmp->h_sequence);
-		jbd_debug(3, "Found magic %d, sequence %d\n",
+		jbd_debug(journal, 3, "Found magic %d, sequence %d\n",
 			  blocktype, sequence);
 
 		if (sequence != next_commit_ID) {
@@ -576,7 +576,7 @@ static int do_one_pass(journal_t *journal,
 					goto failed;
 				}
 				need_check_commit_time = true;
-				jbd_debug(1,
+				jbd_debug(journal, 1,
 					"invalid descriptor block found in %lu\n",
 					next_log_block);
 			}
@@ -759,7 +759,7 @@ static int do_one_pass(journal_t *journal,
 				 * It likely does not belong to same journal,
 				 * just end this recovery with success.
 				 */
-				jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
+				jbd_debug(journal, 1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
 					  next_commit_ID);
 				err = 0;
 				brelse(bh);
@@ -828,7 +828,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
+				jbd_debug(journal, 1, "JBD2: invalid revoke block found in %lu\n",
 					  next_log_block);
 				need_check_commit_time = true;
 			}
@@ -847,7 +847,7 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		default:
-			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
+			jbd_debug(journal, 3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
 			brelse(bh);
 			goto done;
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index fa608788b93d..c806c190f347 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -398,7 +398,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 	}
 	handle->h_revoke_credits--;
 
-	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
+	jbd_debug(journal, 2, "insert revoke for block %llu, bh_in=%p\n", blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
 				handle->h_transaction->t_tid);
 	BUFFER_TRACE(bh_in, "exit");
@@ -428,7 +428,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	int did_revoke = 0;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
 
-	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
+	jbd_debug(journal, 4, "journal_head %p, cancelling revoke\n", jh);
 
 	/* Is the existing Revoke bit valid?  If so, we trust it, and
 	 * only perform the full cancel if the revoke bit is set.  If
@@ -444,7 +444,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	if (need_cancel) {
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
-			jbd_debug(4, "cancelled existing revoke on "
+			jbd_debug(journal, 4, "cancelled existing revoke on "
 				  "blocknr %llu\n", (unsigned long long)bh->b_blocknr);
 			spin_lock(&journal->j_revoke_lock);
 			list_del(&record->hash);
@@ -560,7 +560,7 @@ void jbd2_journal_write_revoke_records(transaction_t *transaction,
 	}
 	if (descriptor)
 		flush_descriptor(journal, descriptor, offset);
-	jbd_debug(1, "Wrote %d revoke records\n", count);
+	jbd_debug(journal, 1, "Wrote %d revoke records\n", count);
 }
 
 /*
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3956fbc97fc4..e7072f311eb1 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -362,7 +362,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 			return -ENOMEM;
 	}
 
-	jbd_debug(3, "New handle %p going live.\n", handle);
+	jbd_debug(journal, 3, "New handle %p going live.\n", handle);
 
 	/*
 	 * We need to hold j_state_lock until t_updates has been incremented,
@@ -436,7 +436,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	handle->h_start_jiffies = jiffies;
 	atomic_inc(&transaction->t_updates);
 	atomic_inc(&transaction->t_handle_count);
-	jbd_debug(4, "Handle %p given %d credits (total %d, free %lu)\n",
+	jbd_debug(journal, 4, "Handle %p given %d credits (total %d, free %lu)\n",
 		  handle, blocks,
 		  atomic_read(&transaction->t_outstanding_credits),
 		  jbd2_log_space_left(journal));
@@ -657,7 +657,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 
 	/* Don't extend a locked-down transaction! */
 	if (transaction->t_state != T_RUNNING) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd_debug(journal, 3, "denied handle %p %d blocks: "
 			  "transaction not running\n", handle, nblocks);
 		goto error_out;
 	}
@@ -673,7 +673,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 				   &transaction->t_outstanding_credits);
 
 	if (wanted > journal->j_max_transaction_buffers) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd_debug(journal, 3, "denied handle %p %d blocks: "
 			  "transaction too large\n", handle, nblocks);
 		atomic_sub(nblocks, &transaction->t_outstanding_credits);
 		goto unlock;
@@ -691,7 +691,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	handle->h_revoke_credits_requested += revoke_records;
 	result = 0;
 
-	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
+	jbd_debug(journal, 3, "extended handle %p by %d\n", handle, nblocks);
 unlock:
 	spin_unlock(&transaction->t_handle_lock);
 error_out:
@@ -781,7 +781,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	 * First unlink the handle from its current transaction, and start the
 	 * commit on that.
 	 */
-	jbd_debug(2, "restarting handle %p\n", handle);
+	jbd_debug(journal, 2, "restarting handle %p\n", handle);
 	stop_this_handle(handle);
 	handle->h_transaction = NULL;
 
@@ -948,7 +948,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
 	journal = transaction->t_journal;
 
-	jbd_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
+	jbd_debug(journal, 5, "journal_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
@@ -1240,13 +1240,13 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	struct journal_head *jh = jbd2_journal_add_journal_head(bh);
 	int err;
 
-	jbd_debug(5, "journal_head %p\n", jh);
 	err = -EROFS;
 	if (is_handle_aborted(handle))
 		goto out;
 	journal = transaction->t_journal;
 	err = 0;
 
+	jbd_debug(journal, 5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 	/*
 	 * The buffer may already belong to this transaction due to pre-zeroing
@@ -1465,7 +1465,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	 * of the running transaction.
 	 */
 	jh = bh2jh(bh);
-	jbd_debug(5, "journal_head %p\n", jh);
+	jbd_debug(transaction->t_journal, 5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 
 	/*
@@ -1787,8 +1787,8 @@ int jbd2_journal_stop(handle_t *handle)
 	pid_t pid;
 
 	if (--handle->h_ref > 0) {
-		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
-						 handle->h_ref);
+		jbd_debug(transaction->t_journal, 4, "h_ref %d -> %d\n",
+			  handle->h_ref + 1, handle->h_ref);
 		if (is_handle_aborted(handle))
 			return -EIO;
 		return 0;
@@ -1807,7 +1807,7 @@ int jbd2_journal_stop(handle_t *handle)
 	if (is_handle_aborted(handle))
 		err = -EIO;
 
-	jbd_debug(4, "Handle %p going down\n", handle);
+	jbd_debug(journal, 4, "Handle %p going down\n", handle);
 	trace_jbd2_handle_stats(journal->j_fs_dev->bd_dev,
 				tid, handle->h_type, handle->h_line_no,
 				jiffies - handle->h_start_jiffies,
@@ -1885,7 +1885,7 @@ int jbd2_journal_stop(handle_t *handle)
 		 * completes the commit thread, it just doesn't write
 		 * anything to disk. */
 
-		jbd_debug(2, "transaction too old, requesting commit for "
+		jbd_debug(journal, 2, "transaction too old, requesting commit for "
 					"handle %p\n", handle);
 		/* This is non-blocking */
 		jbd2_log_start_commit(journal, tid);
@@ -2649,7 +2649,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 		return -EROFS;
 	journal = transaction->t_journal;
 
-	jbd_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
+	jbd_debug(journal, 4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 			transaction->t_tid);
 
 	spin_lock(&journal->j_list_lock);
-- 
2.30.0

