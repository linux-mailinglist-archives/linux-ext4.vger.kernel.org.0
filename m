Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8040FC1F6F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfI3Kne (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730762AbfI3KnY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE1F9AF5D;
        Mon, 30 Sep 2019 10:43:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E752C1E4831; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/19] jbd2: Drop pointless check from jbd2_journal_stop()
Date:   Mon, 30 Sep 2019 12:43:29 +0200
Message-Id: <20190930104339.24919-11-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If a transaction is larger than journal->j_max_transaction_buffers, that
is a bug and not a trigger for transaction commit. Also the very next
attempt to start new handle will start transaction commit anyway. So
just remove the pointless check. Arguably, we could start transaction
commit whenever the transaction size is *close* to
journal->j_max_transaction_buffers. This has a potential to reduce
latency of the next jbd2_journal_start() at the cost of somewhat smaller
transactions. However for this to have any effect, it would mean that
there isn't someone already waiting in jbd2_journal_start() which means
metadata load for the fs is pretty light anyway so probably this
optimization is not worth it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5987dc8273db..cd00b20bc692 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1800,13 +1800,10 @@ int jbd2_journal_stop(handle_t *handle)
 
 	/*
 	 * If the handle is marked SYNC, we need to set another commit
-	 * going!  We also want to force a commit if the current
-	 * transaction is occupying too much of the log, or if the
-	 * transaction is too old now.
+	 * going!  We also want to force a commit if the transaction is too
+	 * old now.
 	 */
 	if (handle->h_sync ||
-	    (atomic_read(&transaction->t_outstanding_credits) >
-	     journal->j_max_transaction_buffers) ||
 	    time_after_eq(jiffies, transaction->t_expires)) {
 		/* Do this even for aborted journals: an abort still
 		 * completes the commit thread, it just doesn't write
-- 
2.16.4

