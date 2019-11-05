Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D87F0347
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbfKEQop (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390386AbfKEQon (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D869B462;
        Tue,  5 Nov 2019 16:44:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5EE471E4ABF; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 16/25] jbd2: Drop pointless wakeup from jbd2_journal_stop()
Date:   Tue,  5 Nov 2019 17:44:22 +0100
Message-Id: <20191105164437.32602-16-jack@suse.cz>
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

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
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

