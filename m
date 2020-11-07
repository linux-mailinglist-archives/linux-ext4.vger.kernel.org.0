Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C496E2AA27A
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 06:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgKGFKR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 00:10:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55207 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbgKGFKQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 00:10:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A75ABXS005961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Nov 2020 00:10:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 02AE5420107; Sat,  7 Nov 2020 00:10:10 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     harshads@google.com, "Theodore Ts'o" <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 2/2] jbd2: fix up sparse warnings in checkpoint code
Date:   Sat,  7 Nov 2020 00:09:59 -0500
Message-Id: <20201107050959.2561329-2-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107050959.2561329-1-tytso@mit.edu>
References: <20201107050959.2561329-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add missing __acquires() and __releases() annotations.  Also, in an
"this should never happen" WARN_ON check, if it *does* actually
happen, we need to release j_state_lock since this function is always
supposed to release that lock.  Otherwise, things will quickly grind
to a halt after the WARN_ON trips.

Fixes: 96f1e0974575 ("jbd2: avoid long hold times of j_state_lock...")
Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/checkpoint.c  | 2 ++
 fs/jbd2/transaction.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 263f02ad8ebf..472932b9e6bc 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -106,6 +106,8 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
  * for a checkpoint to free up some space in the log.
  */
 void __jbd2_log_wait_for_space(journal_t *journal)
+__acquires(&journal->j_state_lock)
+__releases(&journal->j_state_lock)
 {
 	int nblocks, space_left;
 	/* assert_spin_locked(&journal->j_state_lock); */
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 43985738aa86..d54f04674e8e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -195,8 +195,10 @@ static void wait_transaction_switching(journal_t *journal)
 	DEFINE_WAIT(wait);
 
 	if (WARN_ON(!journal->j_running_transaction ||
-		    journal->j_running_transaction->t_state != T_SWITCH))
+		    journal->j_running_transaction->t_state != T_SWITCH)) {
+		read_unlock(&journal->j_state_lock);
 		return;
+	}
 	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
 			TASK_UNINTERRUPTIBLE);
 	read_unlock(&journal->j_state_lock);
-- 
2.28.0

