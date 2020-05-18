Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5491D73D1
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgERJVY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 05:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgERJVY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 May 2020 05:21:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 292CBAFFB;
        Mon, 18 May 2020 09:21:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C98FC1E126F; Mon, 18 May 2020 11:21:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] jbd2: Avoid leaking transaction credits when unreserving handle
Date:   Mon, 18 May 2020 11:21:20 +0200
Message-Id: <20200518092120.10322-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200518092120.10322-1-jack@suse.cz>
References: <20200518092120.10322-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When reserved transaction handle is unused, we subtract its reserved
credits in __jbd2_journal_unreserve_handle() called from
jbd2_journal_stop(). However this function forgets to remove reserved
credits from transaction->t_outstanding_credits and thus the transaction
space that was reserved remains effectively leaked. The leaked
transaction space can be quite significant in some cases and leads to
unnecessarily small transactions and thus reducing throughput of the
journalling machinery. E.g. fsmark workload creating lots of 4k files
was observed to have about 20% lower throughput due to this when ext4 is
mounted with dioread_nolock mount option.

Subtract reserved credits from t_outstanding_credits as well.

CC: stable@vger.kernel.org
Fixes: 8f7d89f36829 ("jbd2: transaction reservation support")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3dccc23cf010..b49a103cff1f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -541,17 +541,24 @@ handle_t *jbd2_journal_start(journal_t *journal, int nblocks)
 }
 EXPORT_SYMBOL(jbd2_journal_start);
 
-static void __jbd2_journal_unreserve_handle(handle_t *handle)
+static void __jbd2_journal_unreserve_handle(handle_t *handle, transaction_t *t)
 {
 	journal_t *journal = handle->h_journal;
 
 	WARN_ON(!handle->h_reserved);
 	sub_reserved_credits(journal, handle->h_total_credits);
+	if (t)
+		atomic_sub(handle->h_total_credits, &t->t_outstanding_credits);
 }
 
 void jbd2_journal_free_reserved(handle_t *handle)
 {
-	__jbd2_journal_unreserve_handle(handle);
+	journal_t *journal = handle->h_journal;
+
+	/* Get j_state_lock to pin running transaction if it exists */
+	read_lock(&journal->j_state_lock);
+	__jbd2_journal_unreserve_handle(handle, journal->j_running_transaction);
+	read_unlock(&journal->j_state_lock);
 	jbd2_free_handle(handle);
 }
 EXPORT_SYMBOL(jbd2_journal_free_reserved);
@@ -721,8 +728,10 @@ static void stop_this_handle(handle_t *handle)
 	}
 	atomic_sub(handle->h_total_credits,
 		   &transaction->t_outstanding_credits);
-	if (handle->h_rsv_handle)
-		__jbd2_journal_unreserve_handle(handle->h_rsv_handle);
+	if (handle->h_rsv_handle) {
+		__jbd2_journal_unreserve_handle(handle->h_rsv_handle,
+						transaction);
+	}
 	if (atomic_dec_and_test(&transaction->t_updates))
 		wake_up(&journal->j_wait_updates);
 
-- 
2.16.4

