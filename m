Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F292FC1F69
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfI3Knb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730822AbfI3KnZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F73EB12F;
        Mon, 30 Sep 2019 10:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F14101E4834; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 14/19] jbd2: Account descriptor blocks into t_outstanding_credits
Date:   Mon, 30 Sep 2019 12:43:32 +0200
Message-Id: <20190930104339.24919-14-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently, journal descriptor blocks were not accounted in
transaction->t_outstanding_credits and we were just leaving some slack
space in the journal for them (in jbd2_log_space_left() and
jbd2_space_needed()). This is making proper accounting (and reservation
we want to add) of descriptor blocks difficult so switch to accounting
descriptor blocks in transaction->t_outstanding_credits and just reserve
the same amount of credits in t_outstanding credits for journal
descriptor blocks when creating transaction.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c      |  3 +++
 fs/jbd2/journal.c     |  1 +
 fs/jbd2/transaction.c | 20 ++++++++++++--------
 include/linux/jbd2.h  | 16 +++-------------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b67e2d0cff88..43f2dde5bb47 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -889,6 +889,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (err)
 		jbd2_journal_abort(journal, err);
 
+	WARN_ON_ONCE(
+		atomic_read(&commit_transaction->t_outstanding_credits) < 0);
+
 	/*
 	 * Now disk caches for filesystem device are flushed so we are safe to
 	 * erase checkpointed transactions from the log by updating journal
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990eb70a9..810363443df4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -842,6 +842,7 @@ jbd2_journal_get_descriptor_buffer(transaction_t *transaction, int type)
 	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
 	if (!bh)
 		return NULL;
+	atomic_dec(&transaction->t_outstanding_credits);
 	lock_buffer(bh);
 	memset(bh->b_data, 0, journal->j_blocksize);
 	header = (journal_header_t *)bh->b_data;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8a42c717e260..d580a9ce9ec7 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -62,6 +62,17 @@ void jbd2_journal_free_transaction(transaction_t *transaction)
 	kmem_cache_free(transaction_cache, transaction);
 }
 
+/*
+ * We reserve t_outstanding_credits >> JBD2_CONTROL_BLOCKS_SHIFT for
+ * transaction descriptor blocks.
+ */
+#define JBD2_CONTROL_BLOCKS_SHIFT 5
+
+static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
+{
+	return journal->j_max_transaction_buffers >> JBD2_CONTROL_BLOCKS_SHIFT;
+}
+
 /*
  * jbd2_get_transaction: obtain a new transaction_t object.
  *
@@ -88,6 +99,7 @@ static void jbd2_get_transaction(journal_t *journal,
 	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
+		   jbd2_descriptor_blocks_per_trans(journal) +
 		   atomic_read(&journal->j_reserved_credits));
 	atomic_set(&transaction->t_handle_count, 0);
 	INIT_LIST_HEAD(&transaction->t_inode_list);
@@ -631,14 +643,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 		goto unlock;
 	}
 
-	if (wanted + (wanted >> JBD2_CONTROL_BLOCKS_SHIFT) >
-	    jbd2_log_space_left(journal)) {
-		jbd_debug(3, "denied handle %p %d blocks: "
-			  "insufficient log space\n", handle, nblocks);
-		atomic_sub(nblocks, &transaction->t_outstanding_credits);
-		goto unlock;
-	}
-
 	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
 				 transaction->t_tid,
 				 handle->h_type, handle->h_line_no,
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index c2ad74ea6015..dd9541a9d3c4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1562,20 +1562,13 @@ static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 	return journal->j_chksum_driver != NULL;
 }
 
-/*
- * We reserve t_outstanding_credits >> JBD2_CONTROL_BLOCKS_SHIFT for
- * transaction control blocks.
- */
-#define JBD2_CONTROL_BLOCKS_SHIFT 5
-
 /*
  * Return the minimum number of blocks which must be free in the journal
  * before a new transaction may be started.  Must be called under j_state_lock.
  */
 static inline int jbd2_space_needed(journal_t *journal)
 {
-	int nblocks = journal->j_max_transaction_buffers;
-	return nblocks + (nblocks >> JBD2_CONTROL_BLOCKS_SHIFT);
+	return journal->j_max_transaction_buffers;
 }
 
 /*
@@ -1587,11 +1580,8 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 	long free = journal->j_free - 32;
 
 	if (journal->j_committing_transaction) {
-		unsigned long committing = atomic_read(&journal->
-			j_committing_transaction->t_outstanding_credits);
-
-		/* Transaction + control blocks */
-		free -= committing + (committing >> JBD2_CONTROL_BLOCKS_SHIFT);
+		free -= atomic_read(&journal->
+                        j_committing_transaction->t_outstanding_credits);
 	}
 	return max_t(long, free, 0);
 }
-- 
2.16.4

