Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F46112B73
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfLDMZ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 07:25:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727845AbfLDMZ2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 07:25:28 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 651B52258A56AF8FFAB0;
        Wed,  4 Dec 2019 20:25:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 20:25:19 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v3 4/4] jbd2: clean __jbd2_journal_abort_hard() and __journal_abort_soft()
Date:   Wed, 4 Dec 2019 20:46:14 +0800
Message-ID: <20191204124614.45424-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191204124614.45424-1-yi.zhang@huawei.com>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

__jbd2_journal_abort_hard() has never been used, now we can merge
__jbd2_journal_abort_hard() and __journal_abort_soft() these two
functions into jbd2_journal_abort() and remove them.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c    | 103 ++++++++++++++++++-------------------------
 include/linux/jbd2.h |   1 -
 2 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 93be6e0311da..e59d9b6e4596 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -96,7 +96,6 @@ EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
 EXPORT_SYMBOL(jbd2_inode_cache);
 
-static void __journal_abort_soft (journal_t *journal, int errno);
 static int jbd2_journal_create_slab(size_t slab_size);
 
 #ifdef CONFIG_JBD2_DEBUG
@@ -805,7 +804,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 					"at offset %lu on %s\n",
 			       __func__, blocknr, journal->j_devname);
 			err = -EIO;
-			__journal_abort_soft(journal, err);
+			jbd2_journal_abort(journal, err);
 		}
 	} else {
 		*retp = blocknr; /* +journal->j_blk_offset */
@@ -2065,64 +2064,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	return err;
 }
 
-/*
- * Journal abort has very specific semantics, which we describe
- * for journal abort.
- *
- * Two internal functions, which provide abort to the jbd layer
- * itself are here.
- */
-
-/*
- * Quick version for internal journal use (doesn't lock the journal).
- * Aborts hard --- we mark the abort as occurred, but do _nothing_ else,
- * and don't attempt to make any other journal updates.
- */
-void __jbd2_journal_abort_hard(journal_t *journal)
-{
-	transaction_t *transaction;
-
-	if (journal->j_flags & JBD2_ABORT)
-		return;
-
-	printk(KERN_ERR "Aborting journal on device %s.\n",
-	       journal->j_devname);
-
-	write_lock(&journal->j_state_lock);
-	journal->j_flags |= JBD2_ABORT;
-	transaction = journal->j_running_transaction;
-	if (transaction)
-		__jbd2_log_start_commit(journal, transaction->t_tid);
-	write_unlock(&journal->j_state_lock);
-}
-
-/* Soft abort: record the abort error status in the journal superblock,
- * but don't do any other IO. */
-static void __journal_abort_soft (journal_t *journal, int errno)
-{
-	int old_errno;
-
-	write_lock(&journal->j_state_lock);
-	old_errno = journal->j_errno;
-	if (!journal->j_errno || errno == -ESHUTDOWN)
-		journal->j_errno = errno;
-
-	if (journal->j_flags & JBD2_ABORT) {
-		write_unlock(&journal->j_state_lock);
-		if (old_errno != -ESHUTDOWN && errno == -ESHUTDOWN)
-			jbd2_journal_update_sb_errno(journal);
-		return;
-	}
-	write_unlock(&journal->j_state_lock);
-
-	__jbd2_journal_abort_hard(journal);
-
-	jbd2_journal_update_sb_errno(journal);
-	write_lock(&journal->j_state_lock);
-	journal->j_flags |= JBD2_REC_ERR;
-	write_unlock(&journal->j_state_lock);
-}
-
 /**
  * void jbd2_journal_abort () - Shutdown the journal immediately.
  * @journal: the journal to shutdown.
@@ -2166,7 +2107,47 @@ static void __journal_abort_soft (journal_t *journal, int errno)
 
 void jbd2_journal_abort(journal_t *journal, int errno)
 {
-	__journal_abort_soft(journal, errno);
+	transaction_t *transaction;
+
+	/*
+	 * ESHUTDOWN always takes precedence because a file system check
+	 * caused by any other journal abort error is not required after
+	 * a shutdown triggered.
+	 */
+	write_lock(&journal->j_state_lock);
+	if (journal->j_flags & JBD2_ABORT) {
+		int old_errno = journal->j_errno;
+
+		write_unlock(&journal->j_state_lock);
+		if (old_errno != -ESHUTDOWN && errno == -ESHUTDOWN) {
+			journal->j_errno = errno;
+			jbd2_journal_update_sb_errno(journal);
+		}
+		return;
+	}
+
+	/*
+	 * Mark the abort as occurred and start current running transaction
+	 * to release all journaled buffer.
+	 */
+	pr_err("Aborting journal on device %s.\n", journal->j_devname);
+
+	journal->j_flags |= JBD2_ABORT;
+	journal->j_errno = errno;
+	transaction = journal->j_running_transaction;
+	if (transaction)
+		__jbd2_log_start_commit(journal, transaction->t_tid);
+	write_unlock(&journal->j_state_lock);
+
+	/*
+	 * Record errno to the journal super block, so that fsck and jbd2
+	 * layer could realise that a filesystem check is needed.
+	 */
+	jbd2_journal_update_sb_errno(journal);
+
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_REC_ERR;
+	write_unlock(&journal->j_state_lock);
 }
 
 /**
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 603fbc4e2f70..e3e271bfb0e7 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1402,7 +1402,6 @@ extern int	   jbd2_journal_skip_recovery	(journal_t *);
 extern void	   jbd2_journal_update_sb_errno(journal_t *);
 extern int	   jbd2_journal_update_sb_log_tail	(journal_t *, tid_t,
 				unsigned long, int);
-extern void	   __jbd2_journal_abort_hard	(journal_t *);
 extern void	   jbd2_journal_abort      (journal_t *, int);
 extern int	   jbd2_journal_errno      (journal_t *);
 extern void	   jbd2_journal_ack_err    (journal_t *);
-- 
2.17.2

