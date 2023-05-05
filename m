Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498D6F82FF
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjEEMcq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjEEMco (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 08:32:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA01CFE5
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 05:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QCVSf0Mdgz4f48Js
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 20:32:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33epT91RkDvzXIg--.37253S4;
        Fri, 05 May 2023 20:32:35 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v2 1/3] jbd2: recheck chechpointing non-dirty buffer
Date:   Fri,  5 May 2023 20:32:17 +0800
Message-Id: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33epT91RkDvzXIg--.37253S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4UAw4ktF15ury7ZFWkZwb_yoW7uFyDp3
        4a9wnxtr4kWr18Zr1IqF4UZrW0qF4kZrWUGry5KFn3Aa1jywsIgryrtryIkFyjyr93ua1F
        qF1UCr9rua1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

There is a long-standing metadata corruption issue that happens from
time to time, but it's very difficult to reproduce and analyse, benefit
from the JBD2_CYCLE_RECORD option, we found out that the problem is the
checkpointing process miss to write out some buffers which are raced by
another do_get_write_access(). Looks below for detail.

jbd2_log_do_checkpoint() //transaction X
 //buffer A is dirty and not belones to any transaction
 __buffer_relink_io() //move it to the IO list
 __flush_batch()
  write_dirty_buffer()
                             do_get_write_access()
                             clear_buffer_dirty
                             __jbd2_journal_file_buffer()
                             //add buffer A to a new transaction Y
   lock_buffer(bh)
   //doesn't write out
 __jbd2_journal_remove_checkpoint()
 //finish checkpoint except buffer A
 //filesystem corrupt if the new transaction Y isn't fully write out.

Due to the t_checkpoint_list walking loop in jbd2_log_do_checkpoint()
have already handles waiting for buffers under IO and re-added new
transaction to complete commit, and it also removing cleaned buffers,
this makes sure the list will eventually get empty. So it's fine to
leave buffers on the t_checkpoint_list while flushing out and completely
stop using the t_checkpoint_io_list.

Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
v1->v2:
 - Leave flushing checkpointing buffers on the t_checkpoint_list and
   stop using t_checkpoint_io_list.

 fs/jbd2/checkpoint.c | 94 +++++++++++---------------------------------
 1 file changed, 23 insertions(+), 71 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 51bd38da21cd..ae1ebfb8bc86 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -57,28 +57,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
 	}
 }
 
-/*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -183,6 +161,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 		struct buffer_head *bh = journal->j_chkpt_bhs[i];
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
+		journal->j_chkpt_bhs[i] = NULL;
 	}
 	*batch_count = 0;
 }
@@ -242,6 +221,11 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
+		/*
+		 * The buffer may be writing back, or flushing out in the
+		 * last couple of cycles, or re-adding into a new transaction,
+		 * need to check it again until it's unlocked.
+		 */
 		if (buffer_locked(bh)) {
 			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
@@ -290,25 +274,25 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			if (__jbd2_journal_remove_checkpoint(jh))
 				/* The transaction was released; we're done */
 				goto out;
-			continue;
+		} else {
+			/*
+			 * We are about to write the buffer, it could be
+			 * raced by some other transaction shrink or buffer
+			 * re-log logic once we release the j_list_lock,
+			 * leave it on the checkpoint list and check status
+			 * again to make sure it's clean.
+			 */
+			BUFFER_TRACE(bh, "queue");
+			get_bh(bh);
+			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			journal->j_chkpt_bhs[batch_count++] = bh;
+			transaction->t_chp_stats.cs_written++;
+			transaction->t_checkpoint_list = jh->b_cpnext;
 		}
-		/*
-		 * Important: we are about to write the buffer, and
-		 * possibly block, while still holding the journal
-		 * lock.  We cannot afford to let the transaction
-		 * logic start messing around with this buffer before
-		 * we write it to disk, as that would break
-		 * recoverability.
-		 */
-		BUFFER_TRACE(bh, "queue");
-		get_bh(bh);
-		J_ASSERT_BH(bh, !buffer_jwrite(bh));
-		journal->j_chkpt_bhs[batch_count++] = bh;
-		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
+
 		if ((batch_count == JBD2_NR_BATCH) ||
-		    need_resched() ||
-		    spin_needbreak(&journal->j_list_lock))
+		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
+		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
 			goto unlock_and_flush;
 	}
 
@@ -322,38 +306,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 	}
 
-	/*
-	 * Now we issued all of the transaction's buffers, let's deal
-	 * with the buffers that are out for I/O.
-	 */
-restart2:
-	/* Did somebody clean up the transaction in the meanwhile? */
-	if (journal->j_checkpoint_transactions != transaction ||
-	    transaction->t_tid != this_tid)
-		goto out;
-
-	while (transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart2;
-		}
-
-		/*
-		 * Now in whatever state the buffer currently is, we
-		 * know that it has been written out and so we can
-		 * drop it from the list
-		 */
-		if (__jbd2_journal_remove_checkpoint(jh))
-			break;
-	}
 out:
 	spin_unlock(&journal->j_list_lock);
 	result = jbd2_cleanup_journal_tail(journal);
-- 
2.31.1

