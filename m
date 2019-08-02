Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587D07FD2F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfHBPOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 11:14:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:35260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbfHBPOS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 11:14:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF0D4B11B;
        Fri,  2 Aug 2019 15:14:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D5D431E43F7; Fri,  2 Aug 2019 17:14:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] jbd2: Move dropping of jh reference out of un/re-filing functions
Date:   Fri,  2 Aug 2019 17:13:52 +0200
Message-Id: <20190802151356.777-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802151356.777-1-jack@suse.cz>
References: <20190802151356.777-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

__jbd2_journal_unfile_buffer() and __jbd2_journal_refile_buffer() drop
transaction's jh reference when they remove jh from a transaction. This
will be however inconvenient once we move state lock into journal_head
itself as we still need to unlock it and we'd need to grab jh reference
just for that. Move dropping of jh reference out of these functions into
the few callers.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c      |  5 ++++-
 fs/jbd2/transaction.c | 23 +++++++++++++++--------
 include/linux/jbd2.h  |  2 +-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 132fb92098c7..a0a191f3df77 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -918,6 +918,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		transaction_t *cp_transaction;
 		struct buffer_head *bh;
 		int try_to_free = 0;
+		bool drop_ref;
 
 		jh = commit_transaction->t_forget;
 		spin_unlock(&journal->j_list_lock);
@@ -1022,8 +1023,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				try_to_free = 1;
 		}
 		JBUFFER_TRACE(jh, "refile or unfile buffer");
-		__jbd2_journal_refile_buffer(jh);
+		drop_ref = __jbd2_journal_refile_buffer(jh);
 		jbd_unlock_bh_state(bh);
+		if (drop_ref)
+			jbd2_journal_put_journal_head(jh);
 		if (try_to_free)
 			release_buffer_page(bh);	/* Drops bh reference */
 		else
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index f9b81cfdd8be..c4fe050e78c6 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1595,6 +1595,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 			__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		} else {
 			__jbd2_journal_unfile_buffer(jh);
+			jbd2_journal_put_journal_head(jh);
 			if (!buffer_jbd(bh)) {
 				spin_unlock(&journal->j_list_lock);
 				goto not_jbd;
@@ -1968,17 +1969,15 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
 }
 
 /*
- * Remove buffer from all transactions.
+ * Remove buffer from all transactions. The caller is responsible for dropping
+ * the jh reference that belonged to the transaction.
  *
  * Called with bh_state lock and j_list_lock
- *
- * jh and bh may be already freed when this function returns.
  */
 static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
 {
 	__jbd2_journal_temp_unlink_buffer(jh);
 	jh->b_transaction = NULL;
-	jbd2_journal_put_journal_head(jh);
 }
 
 void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
@@ -1992,6 +1991,7 @@ void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
 	__jbd2_journal_unfile_buffer(jh);
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
+	jbd2_journal_put_journal_head(jh);
 	__brelse(bh);
 }
 
@@ -2130,6 +2130,7 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
 	} else {
 		JBUFFER_TRACE(jh, "on running transaction");
 		__jbd2_journal_unfile_buffer(jh);
+		jbd2_journal_put_journal_head(jh);
 	}
 	return may_free;
 }
@@ -2493,9 +2494,11 @@ void jbd2_journal_file_buffer(struct journal_head *jh,
  * Called under j_list_lock
  * Called under jbd_lock_bh_state(jh2bh(jh))
  *
- * jh and bh may be already free when this function returns
+ * When this function returns true, there's no next transaction to refile to
+ * and the caller has to drop jh reference through
+ * jbd2_journal_put_journal_head().
  */
-void __jbd2_journal_refile_buffer(struct journal_head *jh)
+bool __jbd2_journal_refile_buffer(struct journal_head *jh)
 {
 	int was_dirty, jlist;
 	struct buffer_head *bh = jh2bh(jh);
@@ -2507,7 +2510,7 @@ void __jbd2_journal_refile_buffer(struct journal_head *jh)
 	/* If the buffer is now unused, just drop it. */
 	if (jh->b_next_transaction == NULL) {
 		__jbd2_journal_unfile_buffer(jh);
-		return;
+		return true;
 	}
 
 	/*
@@ -2535,6 +2538,7 @@ void __jbd2_journal_refile_buffer(struct journal_head *jh)
 
 	if (was_dirty)
 		set_buffer_jbddirty(bh);
+	return false;
 }
 
 /*
@@ -2546,15 +2550,18 @@ void __jbd2_journal_refile_buffer(struct journal_head *jh)
 void jbd2_journal_refile_buffer(journal_t *journal, struct journal_head *jh)
 {
 	struct buffer_head *bh = jh2bh(jh);
+	bool drop;
 
 	/* Get reference so that buffer cannot be freed before we unlock it */
 	get_bh(bh);
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_refile_buffer(jh);
+	drop = __jbd2_journal_refile_buffer(jh);
 	jbd_unlock_bh_state(bh);
 	spin_unlock(&journal->j_list_lock);
 	__brelse(bh);
+	if (drop)
+		jbd2_journal_put_journal_head(jh);
 }
 
 /*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f53b13b20e83..6aa66c42599d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1252,7 +1252,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 
 /* Filing buffers */
 extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
-extern void __jbd2_journal_refile_buffer(struct journal_head *);
+extern bool __jbd2_journal_refile_buffer(struct journal_head *);
 extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
 extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
 extern void __journal_free_buffer(struct journal_head *bh);
-- 
2.16.4

