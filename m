Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601D724516
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjFFOAK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjFFN7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:45 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434E8F
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QbBtG6pxGz4f3lK1
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S5;
        Tue, 06 Jun 2023 21:59:36 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 1/6] jbd2: recheck chechpointing non-dirty buffer
Date:   Tue,  6 Jun 2023 21:59:23 +0800
Message-Id: <20230606135928.434610-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4UAw4ktF15uw4UArWrXwb_yoW7KryUpr
        yS9wnIqr4kWr1UZr1Iqr4UA3y0qF4kZrWUGry5KFn3Aa1jywsIgryrtryIkFyjy3s3WayY
        qF1UCr9xua1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 102 ++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 73 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 51bd38da21cd..25e3c20eb19f 100644
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
@@ -287,28 +271,32 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		}
 		if (!buffer_dirty(bh)) {
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			if (__jbd2_journal_remove_checkpoint(jh))
-				/* The transaction was released; we're done */
+			/*
+			 * If the transaction was released or the checkpoint
+			 * list was empty, we're done.
+			 */
+			if (__jbd2_journal_remove_checkpoint(jh) ||
+			    !transaction->t_checkpoint_list)
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
 
@@ -322,38 +310,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
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

