Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10290C03FB
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2019 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfI0LQP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Sep 2019 07:16:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfI0LQG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Sep 2019 07:16:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5017B134;
        Fri, 27 Sep 2019 11:16:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 461651E4808; Fri, 27 Sep 2019 13:16:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/15] jbd2: Reorganize jbd2_journal_stop()
Date:   Fri, 27 Sep 2019 13:15:26 +0200
Message-Id: <20190927111536.16455-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190927111536.16455-1-jack@suse.cz>
References: <20190927111536.16455-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move code in jbd2_journal_stop() around a bit. It removes some
unnecessary code duplication and will make factoring out parts common
with jbd2__journal_restart() easier.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..5987dc8273db 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1703,41 +1703,34 @@ int jbd2_journal_stop(handle_t *handle)
 	tid_t tid;
 	pid_t pid;
 
+	if (--handle->h_ref > 0) {
+		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
+						 handle->h_ref);
+		if (is_handle_aborted(handle))
+			return -EIO;
+		return 0;
+	}
 	if (!transaction) {
 		/*
-		 * Handle is already detached from the transaction so
-		 * there is nothing to do other than decrease a refcount,
-		 * or free the handle if refcount drops to zero
+		 * Handle is already detached from the transaction so there is
+		 * nothing to do other than free the handle.
 		 */
-		if (--handle->h_ref > 0) {
-			jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
-							 handle->h_ref);
-			return err;
-		} else {
-			if (handle->h_rsv_handle)
-				jbd2_free_handle(handle->h_rsv_handle);
-			goto free_and_exit;
-		}
+		if (handle->h_rsv_handle)
+			jbd2_free_handle(handle->h_rsv_handle);
+		goto free_and_exit;
 	}
 	journal = transaction->t_journal;
+	tid = transaction->t_tid;
 
 	J_ASSERT(journal_current_handle() == handle);
+	J_ASSERT(atomic_read(&transaction->t_updates) > 0);
 
 	if (is_handle_aborted(handle))
 		err = -EIO;
-	else
-		J_ASSERT(atomic_read(&transaction->t_updates) > 0);
-
-	if (--handle->h_ref > 0) {
-		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
-			  handle->h_ref);
-		return err;
-	}
 
 	jbd_debug(4, "Handle %p going down\n", handle);
 	trace_jbd2_handle_stats(journal->j_fs_dev->bd_dev,
-				transaction->t_tid,
-				handle->h_type, handle->h_line_no,
+				tid, handle->h_type, handle->h_line_no,
 				jiffies - handle->h_start_jiffies,
 				handle->h_sync, handle->h_requested_credits,
 				(handle->h_requested_credits -
@@ -1822,7 +1815,7 @@ int jbd2_journal_stop(handle_t *handle)
 		jbd_debug(2, "transaction too old, requesting commit for "
 					"handle %p\n", handle);
 		/* This is non-blocking */
-		jbd2_log_start_commit(journal, transaction->t_tid);
+		jbd2_log_start_commit(journal, tid);
 
 		/*
 		 * Special case: JBD2_SYNC synchronous updates require us
@@ -1838,7 +1831,6 @@ int jbd2_journal_stop(handle_t *handle)
 	 * once we do this, we must not dereference transaction
 	 * pointer again.
 	 */
-	tid = transaction->t_tid;
 	if (atomic_dec_and_test(&transaction->t_updates)) {
 		wake_up(&journal->j_wait_updates);
 		if (journal->j_barrier_count)
-- 
2.16.4

