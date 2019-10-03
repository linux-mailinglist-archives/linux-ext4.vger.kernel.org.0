Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7FCB1B2
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfJCWF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731130AbfJCWFz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EBF5B154;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 554631E4816; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 17/22] jbd2: Drop jbd2_space_needed()
Date:   Fri,  4 Oct 2019 00:06:03 +0200
Message-Id: <20191003220613.10791-17-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The function is now just a trivial wrapper returning
journal->j_max_transaction_buffers. Drop it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c  | 2 +-
 fs/jbd2/transaction.c | 5 +++--
 include/linux/jbd2.h  | 9 ---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index a1909066bde6..8fff6677a5da 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -110,7 +110,7 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 	int nblocks, space_left;
 	/* assert_spin_locked(&journal->j_state_lock); */
 
-	nblocks = jbd2_space_needed(journal);
+	nblocks = journal->j_max_transaction_buffers;
 	while (jbd2_log_space_left(journal) < nblocks) {
 		write_unlock(&journal->j_state_lock);
 		mutex_lock_io(&journal->j_checkpoint_mutex);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a364d0623884..a4ee905db00f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -270,12 +270,13 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 	 * *before* starting to dirty potentially checkpointed buffers
 	 * in the new transaction.
 	 */
-	if (jbd2_log_space_left(journal) < jbd2_space_needed(journal)) {
+	if (jbd2_log_space_left(journal) < journal->j_max_transaction_buffers) {
 		atomic_sub(total, &t->t_outstanding_credits);
 		read_unlock(&journal->j_state_lock);
 		jbd2_might_wait_for_commit(journal);
 		write_lock(&journal->j_state_lock);
-		if (jbd2_log_space_left(journal) < jbd2_space_needed(journal))
+		if (jbd2_log_space_left(journal) <
+					journal->j_max_transaction_buffers)
 			__jbd2_log_wait_for_space(journal);
 		write_unlock(&journal->j_state_lock);
 		return 1;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1bb37d3e3839..dd8905763a3b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1560,15 +1560,6 @@ static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 	return journal->j_chksum_driver != NULL;
 }
 
-/*
- * Return the minimum number of blocks which must be free in the journal
- * before a new transaction may be started.  Must be called under j_state_lock.
- */
-static inline int jbd2_space_needed(journal_t *journal)
-{
-	return journal->j_max_transaction_buffers;
-}
-
 /*
  * Return number of free blocks in the log. Must be called under j_state_lock.
  */
-- 
2.16.4

