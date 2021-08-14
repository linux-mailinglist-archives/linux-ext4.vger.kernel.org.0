Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E426E3EC369
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhHNO7f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:59:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58114 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235123AbhHNO7e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:59:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEx4R7029556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:59:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 54B9815C37CF; Sat, 14 Aug 2021 10:59:04 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] jbd2: add sparse annotations for add_transaction_credits()
Date:   Sat, 14 Aug 2021 10:59:00 -0400
Message-Id: <20210814145900.500399-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210814145900.500399-1-tytso@mit.edu>
References: <20210814145900.500399-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/transaction.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8804e126805f..5347411ae13e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -223,9 +223,15 @@ static void sub_reserved_credits(journal_t *journal, int blocks)
  * with j_state_lock held for reading. Returns 0 if handle joined the running
  * transaction. Returns 1 if we had to wait, j_state_lock is dropped, and
  * caller must retry.
+ *
+ * Note: because j_state_lock may be dropped depending on the return
+ * value, we need to fake out sparse so ti doesn't complain about a
+ * locking imbalance.  Callers of add_transaction_credits will need to
+ * make a similar accomodation.
  */
 static int add_transaction_credits(journal_t *journal, int blocks,
 				   int rsv_blocks)
+__must_hold(&journal->j_state_lock)
 {
 	transaction_t *t = journal->j_running_transaction;
 	int needed;
@@ -238,6 +244,7 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 	if (t->t_state != T_RUNNING) {
 		WARN_ON_ONCE(t->t_state >= T_FLUSH);
 		wait_transaction_locked(journal);
+		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
 
@@ -266,10 +273,12 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 			wait_event(journal->j_wait_reserved,
 				   atomic_read(&journal->j_reserved_credits) + total <=
 				   journal->j_max_transaction_buffers);
+			__acquire(&journal->j_state_lock); /* fake out sparse */
 			return 1;
 		}
 
 		wait_transaction_locked(journal);
+		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
 
@@ -293,6 +302,7 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 					journal->j_max_transaction_buffers)
 			__jbd2_log_wait_for_space(journal);
 		write_unlock(&journal->j_state_lock);
+		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
 
@@ -310,6 +320,7 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 		wait_event(journal->j_wait_reserved,
 			 atomic_read(&journal->j_reserved_credits) + rsv_blocks
 			 <= journal->j_max_transaction_buffers / 2);
+		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
 	return 0;
@@ -413,8 +424,14 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 
 	if (!handle->h_reserved) {
 		/* We may have dropped j_state_lock - restart in that case */
-		if (add_transaction_credits(journal, blocks, rsv_blocks))
+		if (add_transaction_credits(journal, blocks, rsv_blocks)) {
+			/*
+			 * add_transaction_credits releases
+			 * j_state_lock on a non-zero return
+			 */
+			__release(&journal->j_state_lock);
 			goto repeat;
+		}
 	} else {
 		/*
 		 * We have handle reserved so we are allowed to join T_LOCKED
-- 
2.31.0

