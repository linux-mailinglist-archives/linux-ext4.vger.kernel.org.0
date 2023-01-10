Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382CA6636AF
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 02:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjAJB3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 20:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAJB3L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 20:29:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46165395E3;
        Mon,  9 Jan 2023 17:29:09 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NrY8Q1WJ3z16MbG;
        Tue, 10 Jan 2023 09:27:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:29:01 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <libaokun1@huawei.com>, <zhanchengbin1@huawei.com>
Subject: [PATCH v4] jbd2: Fix data missing when reusing bh which is ready to be checkpointed
Date:   Tue, 10 Jan 2023 09:53:27 +0800
Message-ID: <20230110015327.1181863-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following process will make data lost and could lead to a filesystem
corrupted problem:

1. jh(bh) is inserted into T1->t_checkpoint_list, bh is dirty, and
   jh->b_transaction = NULL
2. T1 is added into journal->j_checkpoint_transactions.
3. Get bh prepare to write while doing checkpoing:
           PA				    PB
   do_get_write_access             jbd2_log_do_checkpoint
    spin_lock(&jh->b_state_lock)
     if (buffer_dirty(bh))
      clear_buffer_dirty(bh)   // clear buffer dirty
       set_buffer_jbddirty(bh)
				    transaction =
				    journal->j_checkpoint_transactions
				    jh = transaction->t_checkpoint_list
				    if (!buffer_dirty(bh))
		                      __jbd2_journal_remove_checkpoint(jh)
				      // bh won't be flushed
		                    jbd2_cleanup_journal_tail
    __jbd2_journal_file_buffer(jh, transaction, BJ_Reserved)
4. Aborting journal/Power-cut before writing latest bh on journal area.

In this way we get a corrupted filesystem with bh's data lost.

Fix it by moving the clearing of buffer_dirty bit just before the call
to __jbd2_journal_file_buffer(), both bit clearing and jh->b_transaction
assignment are under journal->j_list_lock locked, so that
jbd2_log_do_checkpoint() will wait until jh's new transaction fininshed
even bh is currently not dirty. And journal_shrink_one_cp_list() won't
remove jh from checkpoint list if the buffer head is reused in
do_get_write_access().

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216898
Cc: <stable@kernel.org>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 v1->v2: Adopt Jan's suggestion, move the clearing of buffer_dirty bit
	 and __jbd2_journal_file_buffer() inside journal->j_list_lock
	 locking area.
 v2->v3: Remove redundant assertions in in branch 'if (jh->b_transaction)'
         Add reproducer link in commit message.
 v3->v4: Rephrase the comment for set_buffer_jbddirty().
 fs/jbd2/transaction.c | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6a404ac1c178..15de1385012e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1010,36 +1010,28 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 * ie. locked but not dirty) or tune2fs (which may actually have
 	 * the buffer dirtied, ugh.)  */
 
-	if (buffer_dirty(bh)) {
+	if (buffer_dirty(bh) && jh->b_transaction) {
+		warn_dirty_buffer(bh);
 		/*
-		 * First question: is this buffer already part of the current
-		 * transaction or the existing committing transaction?
-		 */
-		if (jh->b_transaction) {
-			J_ASSERT_JH(jh,
-				jh->b_transaction == transaction ||
-				jh->b_transaction ==
-					journal->j_committing_transaction);
-			if (jh->b_next_transaction)
-				J_ASSERT_JH(jh, jh->b_next_transaction ==
-							transaction);
-			warn_dirty_buffer(bh);
-		}
-		/*
-		 * In any case we need to clean the dirty flag and we must
-		 * do it under the buffer lock to be sure we don't race
-		 * with running write-out.
+		 * We need to clean the dirty flag and we must do it under the
+		 * buffer lock to be sure we don't race with running write-out.
 		 */
 		JBUFFER_TRACE(jh, "Journalling dirty buffer");
 		clear_buffer_dirty(bh);
+		/*
+		 * The buffer is going to be added to BJ_Reserved list now and
+		 * nothing guarantees jbd2_journal_dirty_metadata() will be
+		 * ever called for it. So we need to set jbddirty bit here to
+		 * make sure the buffer is dirtied and written out when the
+		 * journaling machinery is done with it.
+		 */
 		set_buffer_jbddirty(bh);
 	}
 
-	unlock_buffer(bh);
-
 	error = -EROFS;
 	if (is_handle_aborted(handle)) {
 		spin_unlock(&jh->b_state_lock);
+		unlock_buffer(bh);
 		goto out;
 	}
 	error = 0;
@@ -1049,8 +1041,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 * b_next_transaction points to it
 	 */
 	if (jh->b_transaction == transaction ||
-	    jh->b_next_transaction == transaction)
+	    jh->b_next_transaction == transaction) {
+		unlock_buffer(bh);
 		goto done;
+	}
 
 	/*
 	 * this is the first time this transaction is touching this buffer,
@@ -1074,10 +1068,24 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 		 */
 		smp_wmb();
 		spin_lock(&journal->j_list_lock);
+		if (test_clear_buffer_dirty(bh)) {
+			/*
+			 * Execute buffer dirty clearing and jh->b_transaction
+			 * assignment under journal->j_list_lock locked to
+			 * prevent bh being removed from checkpoint list if
+			 * the buffer is in an intermediate state (not dirty
+			 * and jh->b_transaction is NULL).
+			 */
+			JBUFFER_TRACE(jh, "Journalling dirty buffer");
+			set_buffer_jbddirty(bh);
+		}
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Reserved);
 		spin_unlock(&journal->j_list_lock);
+		unlock_buffer(bh);
 		goto done;
 	}
+	unlock_buffer(bh);
+
 	/*
 	 * If there is already a copy-out version of this buffer, then we don't
 	 * need to make another one
-- 
2.31.1

