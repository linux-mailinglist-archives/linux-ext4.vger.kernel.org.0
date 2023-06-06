Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAD724518
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjFFOAM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjFFN7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E010E9
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbBtJ4hlsz4f3wRK
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S7;
        Tue, 06 Jun 2023 21:59:37 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 3/6] jbd2: remove journal_clean_one_cp_list()
Date:   Tue,  6 Jun 2023 21:59:25 +0800
Message-Id: <20230606135928.434610-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15uF1fWFykWryUJF48Xrb_yoWxtrW8pF
        ZxC34jqrZ8u34j9rnYvF48Cr4jvF409ry8K34q9Fn3Aa1UKws7Kry7tr12yFyUCrZ5u3Wa
        qr1UGFyDGw12ya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
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

journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
the same, so merge them into journal_shrink_one_cp_list(), remove the
nr_to_scan parameter, always scan and try to free the whole checkpoint
list.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c        | 75 +++++++++----------------------------
 include/trace/events/jbd2.h | 12 ++----
 2 files changed, 21 insertions(+), 66 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 55d6efdbea64..b94f847960c2 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -347,50 +347,10 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-/*
- * journal_clean_one_cp_list
- *
- * Find all the written-back checkpoint buffers in the given list and
- * release them. If 'destroy' is set, clean all buffers unconditionally.
- *
- * Called with j_list_lock held.
- * Returns 1 if we freed the transaction, 0 otherwise.
- */
-static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
-{
-	struct journal_head *last_jh;
-	struct journal_head *next_jh = jh;
-
-	if (!jh)
-		return 0;
-
-	last_jh = jh->b_cpprev;
-	do {
-		jh = next_jh;
-		next_jh = jh->b_cpnext;
-
-		if (!destroy && __cp_buffer_busy(jh))
-			return 0;
-
-		if (__jbd2_journal_remove_checkpoint(jh))
-			return 1;
-		/*
-		 * This function only frees up some memory
-		 * if possible so we dont have an obligation
-		 * to finish processing. Bail out if preemption
-		 * requested:
-		 */
-		if (need_resched())
-			return 0;
-	} while (jh != last_jh);
-
-	return 0;
-}
-
 /*
  * journal_shrink_one_cp_list
  *
- * Find 'nr_to_scan' written-back checkpoint buffers in the given list
+ * Find all the written-back checkpoint buffers in the given list
  * and try to release them. If the whole transaction is released, set
  * the 'released' parameter. Return the number of released checkpointed
  * buffers.
@@ -398,15 +358,15 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						unsigned long *nr_to_scan,
-						bool *released)
+						bool destroy, bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
 	unsigned long nr_freed = 0;
 	int ret;
 
-	if (!jh || *nr_to_scan == 0)
+	*released = false;
+	if (!jh)
 		return 0;
 
 	last_jh = jh->b_cpprev;
@@ -414,8 +374,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		(*nr_to_scan)--;
-		if (__cp_buffer_busy(jh))
+		if (!destroy && __cp_buffer_busy(jh))
 			continue;
 
 		nr_freed++;
@@ -427,7 +386,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 
 		if (need_resched())
 			break;
-	} while (jh != last_jh && *nr_to_scan);
+	} while (jh != last_jh);
 
 	return nr_freed;
 }
@@ -445,11 +404,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 						  unsigned long *nr_to_scan)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	bool released;
+	bool __maybe_unused released;
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long nr_scanned = *nr_to_scan;
+	unsigned long freed;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -478,10 +437,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
-		released = false;
 
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						       nr_to_scan, &released);
+		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						   false, &released);
+		nr_freed += freed;
+		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -502,9 +462,8 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	if (*nr_to_scan && next_tid)
 		goto again;
 out:
-	nr_scanned -= *nr_to_scan;
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
-					  nr_freed, nr_scanned, next_tid);
+					  nr_freed, next_tid);
 
 	return nr_freed;
 }
@@ -520,7 +479,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	int ret;
+	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
@@ -531,8 +490,8 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
-		ret = journal_clean_one_cp_list(transaction->t_checkpoint_list,
-						destroy);
+		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+					   destroy, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
@@ -545,7 +504,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		 * avoids pointless scanning of transactions which still
 		 * weren't checkpointed.
 		 */
-		if (!ret)
+		if (!released)
 			return;
 	} while (transaction != last_transaction);
 }
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 8f5ee380d309..5646ae15a957 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -462,11 +462,9 @@ TRACE_EVENT(jbd2_shrink_scan_exit,
 TRACE_EVENT(jbd2_shrink_checkpoint_list,
 
 	TP_PROTO(journal_t *journal, tid_t first_tid, tid_t tid, tid_t last_tid,
-		 unsigned long nr_freed, unsigned long nr_scanned,
-		 tid_t next_tid),
+		 unsigned long nr_freed, tid_t next_tid),
 
-	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed,
-		nr_scanned, next_tid),
+	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed, next_tid),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -474,7 +472,6 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__field(tid_t, tid)
 		__field(tid_t, last_tid)
 		__field(unsigned long, nr_freed)
-		__field(unsigned long, nr_scanned)
 		__field(tid_t, next_tid)
 	),
 
@@ -484,15 +481,14 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__entry->tid		= tid;
 		__entry->last_tid	= last_tid;
 		__entry->nr_freed	= nr_freed;
-		__entry->nr_scanned	= nr_scanned;
 		__entry->next_tid	= next_tid;
 	),
 
 	TP_printk("dev %d,%d shrink transaction %u-%u(%u) freed %lu "
-		  "scanned %lu next transaction %u",
+		  "next transaction %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->first_tid, __entry->tid, __entry->last_tid,
-		  __entry->nr_freed, __entry->nr_scanned, __entry->next_tid)
+		  __entry->nr_freed, __entry->next_tid)
 );
 
 #endif /* _TRACE_JBD2_H */
-- 
2.31.1

