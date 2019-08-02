Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30957FD2E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHBPOT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 11:14:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730695AbfHBPOS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 11:14:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A9C0B601;
        Fri,  2 Aug 2019 15:14:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DBD1A1E440B; Fri,  2 Aug 2019 17:14:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] jbd2: Don't call __bforget() unnecessarily
Date:   Fri,  2 Aug 2019 17:13:54 +0200
Message-Id: <20190802151356.777-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802151356.777-1-jack@suse.cz>
References: <20190802151356.777-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_forget() jumps to 'not_jbd' branch which calls __bforget()
in cases where the buffer is clean which is pointless. In case of failed
assertion, it can be even argued that it is safer not to touch buffer's
dirty bits. Also logically it makes more sense to just jump to 'drop'
and that will make logic also simpler when we switch bh_state_lock to a
spinlock.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 9ccef3d6e817..d752d7f6929e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1547,7 +1547,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 	if (!J_EXPECT_JH(jh, !jh->b_committed_data,
 			 "inconsistent data on disk")) {
 		err = -EIO;
-		goto not_jbd;
+		goto drop;
 	}
 
 	/* keep track of whether or not this transaction modified us */
@@ -1637,7 +1637,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 		if (!jh->b_cp_transaction) {
 			JBUFFER_TRACE(jh, "belongs to none transaction");
 			spin_unlock(&journal->j_list_lock);
-			goto not_jbd;
+			goto drop;
 		}
 
 		/*
@@ -1647,7 +1647,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 		if (!buffer_dirty(bh)) {
 			__jbd2_journal_remove_checkpoint(jh);
 			spin_unlock(&journal->j_list_lock);
-			goto not_jbd;
+			goto drop;
 		}
 
 		/*
@@ -1660,10 +1660,9 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
-
+drop:
 	jbd_unlock_bh_state(bh);
 	__brelse(bh);
-drop:
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
 		handle->h_buffer_credits++;
-- 
2.16.4

