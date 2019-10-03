Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C616CB1BA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfJCWGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:06:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387909AbfJCWF4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 831D1B158;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B1DD1E4812; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 14/22] jbd2: Drop pointless wakeup from jbd2_journal_stop()
Date:   Fri,  4 Oct 2019 00:06:00 +0200
Message-Id: <20191003220613.10791-14-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we drop last handle from a transaction and journal->j_barrier_count
> 0, jbd2_journal_stop() wakes up journal->j_wait_transaction_locked
wait queue. This looks pointless - wait for outstanding handles always
happens on journal->j_wait_updates waitqueue.
journal->j_wait_transaction_locked is used to wait for transaction state
changes and by start_this_handle() for waiting until
journal->j_barrier_count drops to 0. The first case is clearly
irrelevant here since only jbd2 thread changes transaction state. The
second case looks related but jbd2_journal_unlock_updates() is
responsible for the wakeup in this case. So just drop the wakeup.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a160c3f665f9..d648cec3f90f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1831,11 +1831,8 @@ int jbd2_journal_stop(handle_t *handle)
 	 * once we do this, we must not dereference transaction
 	 * pointer again.
 	 */
-	if (atomic_dec_and_test(&transaction->t_updates)) {
+	if (atomic_dec_and_test(&transaction->t_updates))
 		wake_up(&journal->j_wait_updates);
-		if (journal->j_barrier_count)
-			wake_up(&journal->j_wait_transaction_locked);
-	}
 
 	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
 
-- 
2.16.4

