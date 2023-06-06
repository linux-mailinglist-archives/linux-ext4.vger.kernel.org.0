Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEC724515
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjFFN7s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbjFFN7m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A983EA
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbBtJ0cyRz4f3jqM
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S6;
        Tue, 06 Jun 2023 21:59:37 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 2/6] jbd2: remove t_checkpoint_io_list
Date:   Tue,  6 Jun 2023 21:59:24 +0800
Message-Id: <20230606135928.434610-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfGw1kCw48Wr4rZFW3trb_yoWrtw4rpr
        93uw1xtrWkuryUCr10qF4UArW0qF48uryUGryY93Z3Aa17twn2gas7tr1IyFyqyrZ5ua45
        XF15Crn8GF4jka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Since t_checkpoint_io_list was stop using in jbd2_log_do_checkpoint()
now, it's time to remove the whole t_checkpoint_io_list logic.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 42 ++----------------------------------------
 fs/jbd2/commit.c     |  3 +--
 include/linux/jbd2.h |  6 ------
 3 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 25e3c20eb19f..55d6efdbea64 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -27,7 +27,7 @@
  *
  * Called with j_list_lock held.
  */
-static inline void __buffer_unlink_first(struct journal_head *jh)
+static inline void __buffer_unlink(struct journal_head *jh)
 {
 	transaction_t *transaction = jh->b_cp_transaction;
 
@@ -40,23 +40,6 @@ static inline void __buffer_unlink_first(struct journal_head *jh)
 	}
 }
 
-/*
- * Unlink a buffer from a transaction checkpoint(io) list.
- *
- * Called with j_list_lock held.
- */
-static inline void __buffer_unlink(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-	if (transaction->t_checkpoint_io_list == jh) {
-		transaction->t_checkpoint_io_list = jh->b_cpnext;
-		if (transaction->t_checkpoint_io_list == jh)
-			transaction->t_checkpoint_io_list = NULL;
-	}
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -503,15 +486,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
 			break;
-		if (released)
-			continue;
-
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_io_list,
-						       nr_to_scan, &released);
-		if (*nr_to_scan == 0)
-			break;
-		if (need_resched() || spin_needbreak(&journal->j_list_lock))
-			break;
 	} while (transaction != last_transaction);
 
 	if (transaction != last_transaction) {
@@ -566,17 +540,6 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		 */
 		if (need_resched())
 			return;
-		if (ret)
-			continue;
-		/*
-		 * It is essential that we are as careful as in the case of
-		 * t_checkpoint_list with removing the buffer from the list as
-		 * we can possibly see not yet submitted buffers on io_list
-		 */
-		ret = journal_clean_one_cp_list(transaction->
-				t_checkpoint_io_list, destroy);
-		if (need_resched())
-			return;
 		/*
 		 * Stop scanning if we couldn't free the transaction. This
 		 * avoids pointless scanning of transactions which still
@@ -661,7 +624,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	jbd2_journal_put_journal_head(jh);
 
 	/* Is this transaction empty? */
-	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
+	if (transaction->t_checkpoint_list)
 		return 0;
 
 	/*
@@ -753,7 +716,6 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 	J_ASSERT(transaction->t_forget == NULL);
 	J_ASSERT(transaction->t_shadow_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
-	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(atomic_read(&transaction->t_updates) == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b33155dd7001..1073259902a6 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1141,8 +1141,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
-	if (commit_transaction->t_checkpoint_list == NULL &&
-	    commit_transaction->t_checkpoint_io_list == NULL) {
+	if (commit_transaction->t_checkpoint_list == NULL) {
 		__jbd2_journal_drop_transaction(journal, commit_transaction);
 		jbd2_journal_free_transaction(commit_transaction);
 	}
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f619bae1dcc5..91a2cf4bc575 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -622,12 +622,6 @@ struct transaction_s
 	 */
 	struct journal_head	*t_checkpoint_list;
 
-	/*
-	 * Doubly-linked circular list of all buffers submitted for IO while
-	 * checkpointing. [j_list_lock]
-	 */
-	struct journal_head	*t_checkpoint_io_list;
-
 	/*
 	 * Doubly-linked circular list of metadata buffers being
 	 * shadowed by log IO.  The IO buffers on the iobuf list and
-- 
2.31.1

