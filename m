Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F06522F3
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Dec 2022 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiLTOpX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Dec 2022 09:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiLTOpW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Dec 2022 09:45:22 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5601AA19;
        Tue, 20 Dec 2022 06:45:20 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NbzqC5tsLzRq0V;
        Tue, 20 Dec 2022 22:44:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 22:45:17 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <libaokun1@huawei.com>, <zhanchengbin1@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH] [RFC] Fix data missing when reusing bh which is ready to be checkpointed
Date:   Tue, 20 Dec 2022 23:05:51 +0800
Message-ID: <20221220150551.653925-1-chengzhihao1@huawei.com>
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

From: zhanchengbin <zhanchengbin1@huawei.com>

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

In this way we get a corrupted filesystem with bh'data lost.

Fix it by wrapping clear_buffer_dirty(bh) and jh->b_transaction setting
into journal->j_list_lock, so that jbd2_log_do_checkpoint() will wait
until jh's new transaction fininshed even bh is currently not dirty.

Cc: <stable@kernel.org>
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 This is a quick fix, I need some suggestions about this patch, whether
 it will import new problems if this patch is applied.
 Yi suggests that the formal solution could be splitting
 journal->j_list_lock into two locks: one protects checkpoint list and
 the other one for other lists. Besides, jh->b_state_lock should be
 held while traversing transaction->t_checkpoint_list in
 jbd2_log_do_checkpoint()/journal_shrink_one_cp_list().

 fs/jbd2/transaction.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6a404ac1c178..d22460001d6b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -990,6 +990,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
  	start_lock = jiffies;
 	lock_buffer(bh);
 	spin_lock(&jh->b_state_lock);
+	spin_lock(&journal->j_list_lock);
 
 	/* If it takes too long to lock the buffer, trace it */
 	time_lock = jbd2_time_diff(start_lock, jiffies);
@@ -1039,6 +1040,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) {
+		spin_unlock(&journal->j_list_lock);
 		spin_unlock(&jh->b_state_lock);
 		goto out;
 	}
@@ -1049,8 +1051,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 * b_next_transaction points to it
 	 */
 	if (jh->b_transaction == transaction ||
-	    jh->b_next_transaction == transaction)
+	    jh->b_next_transaction == transaction) {
+		spin_unlock(&journal->j_list_lock);
 		goto done;
+	}
 
 	/*
 	 * this is the first time this transaction is touching this buffer,
@@ -1073,11 +1077,11 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 		 * Paired with barrier in jbd2_write_access_granted()
 		 */
 		smp_wmb();
-		spin_lock(&journal->j_list_lock);
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Reserved);
 		spin_unlock(&journal->j_list_lock);
 		goto done;
 	}
+	spin_unlock(&journal->j_list_lock);
 	/*
 	 * If there is already a copy-out version of this buffer, then we don't
 	 * need to make another one
-- 
2.31.1

