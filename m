Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB77FD2C
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfHBPOR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 11:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730717AbfHBPOR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 11:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C181EAF3F;
        Fri,  2 Aug 2019 15:14:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCDBA1E2F9E; Fri,  2 Aug 2019 17:14:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] jbd2: Simplify journal_unmap_buffer()
Date:   Fri,  2 Aug 2019 17:13:50 +0200
Message-Id: <20190802151356.777-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802151356.777-1-jack@suse.cz>
References: <20190802151356.777-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

journal_unmap_buffer() checks first whether the buffer head is a journal.
If so it takes locks and then invokes jbd2_journal_grab_journal_head()
followed by another check whether this is journal head buffer.

The double checking is pointless.

Replace the initial check with jbd2_journal_grab_journal_head() which
alredy checks whether the buffer head is actually a journal.

Allows also early access to the journal head pointer for the upcoming
conversion of state lock to a regular spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..f9b81cfdd8be 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2196,7 +2196,8 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	 * holding the page lock. --sct
 	 */
 
-	if (!buffer_jbd(bh))
+	jh = jbd2_journal_grab_journal_head(bh);
+	if (!jh)
 		goto zap_buffer_unlocked;
 
 	/* OK, we have data buffer in journaled mode */
@@ -2204,10 +2205,6 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
 
-	jh = jbd2_journal_grab_journal_head(bh);
-	if (!jh)
-		goto zap_buffer_no_jh;
-
 	/*
 	 * We cannot remove the buffer from checkpoint lists until the
 	 * transaction adding inode to orphan list (let's call it T)
@@ -2329,7 +2326,6 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	 */
 	jh->b_modified = 0;
 	jbd2_journal_put_journal_head(jh);
-zap_buffer_no_jh:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
 	write_unlock(&journal->j_state_lock);
-- 
2.16.4

