Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B92724514
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjFFN7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjFFN7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA210D4
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbBtL1GSkz4f3wtR
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S9;
        Tue, 06 Jun 2023 21:59:38 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 5/6] jbd2: fix a race when checking checkpoint buffer busy
Date:   Tue,  6 Jun 2023 21:59:27 +0800
Message-Id: <20230606135928.434610-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1kGF1UZw4kur43Kr45ZFb_yoW7GFWDpF
        9xK34F9rWv934UZr1SqF4UArWYqF4v9ryUGr9ru3Zaya1UXwsIqry7G3WjyryYyFZYga1Y
        qr15GFs8Gw42kFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

Before removing checkpoint buffer from the t_checkpoint_list, we have to
check both BH_Dirty and BH_Lock bits together to distinguish buffers
have not been or were being written back. But __cp_buffer_busy() checks
them separately, it first check lock state and then check dirty, the
window between these two checks could be raced by writing back
procedure, which locks buffer and clears buffer dirty before I/O
completes. So it cannot guarantee checkpointing buffers been written
back to disk if some error happens later. Finally, it may clean
checkpoint transactions and lead to inconsistent filesystem.

jbd2_journal_forget() and __journal_try_to_free_buffer() also have the
same problem (journal_unmap_buffer() escape from this issue since it's
running under the buffer lock), so fix them through introducing a new
helper to try holding the buffer lock and remove really clean buffer.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c  | 38 +++++++++++++++++++++++++++++++++++---
 fs/jbd2/transaction.c | 17 +++++------------
 include/linux/jbd2.h  |  1 +
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 42b34cab64fb..9ec91017a7f3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -376,11 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (!destroy && __cp_buffer_busy(jh))
-			continue;
+		if (destroy) {
+			ret = __jbd2_journal_remove_checkpoint(jh);
+		} else {
+			ret = jbd2_journal_try_remove_checkpoint(jh);
+			if (ret < 0)
+				continue;
+		}
 
 		nr_freed++;
-		ret = __jbd2_journal_remove_checkpoint(jh);
 		if (ret) {
 			*released = true;
 			break;
@@ -616,6 +620,34 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	return 1;
 }
 
+/*
+ * Check the checkpoint buffer and try to remove it from the checkpoint
+ * list if it's clean. Returns -EBUSY if it is not clean, returns 1 if
+ * it frees the transaction, 0 otherwise.
+ *
+ * This function is called with j_list_lock held.
+ */
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+
+	if (!trylock_buffer(bh))
+		return -EBUSY;
+	if (buffer_dirty(bh)) {
+		unlock_buffer(bh);
+		return -EBUSY;
+	}
+	unlock_buffer(bh);
+
+	/*
+	 * Buffer is clean and the IO has finished (we held the buffer
+	 * lock) so the checkpoint is done. We can safely remove the
+	 * buffer from this transaction.
+	 */
+	JBUFFER_TRACE(jh, "remove from checkpoint list");
+	return __jbd2_journal_remove_checkpoint(jh);
+}
+
 /*
  * journal_insert_checkpoint: put a committed buffer onto a checkpoint
  * list so that we know when it is safe to clean the transaction out of
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 18611241f451..6ef5022949c4 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1784,8 +1784,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		 * Otherwise, if the buffer has been written to disk,
 		 * it is safe to remove the checkpoint and drop it.
 		 */
-		if (!buffer_dirty(bh)) {
-			__jbd2_journal_remove_checkpoint(jh);
+		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
 			spin_unlock(&journal->j_list_lock);
 			goto drop;
 		}
@@ -2112,20 +2111,14 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 
 	jh = bh2jh(bh);
 
-	if (buffer_locked(bh) || buffer_dirty(bh))
-		goto out;
-
 	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
-		goto out;
+		return;
 
 	spin_lock(&journal->j_list_lock);
-	if (jh->b_cp_transaction != NULL) {
-		/* written-back checkpointed metadata buffer */
-		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		__jbd2_journal_remove_checkpoint(jh);
-	}
+	/* Remove written-back checkpointed metadata buffer */
+	if (jh->b_cp_transaction != NULL)
+		jbd2_journal_try_remove_checkpoint(jh);
 	spin_unlock(&journal->j_list_lock);
-out:
 	return;
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 91a2cf4bc575..c212da35a052 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1443,6 +1443,7 @@ extern void jbd2_journal_commit_transaction(journal_t *);
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
 void jbd2_journal_destroy_checkpoint(journal_t *journal);
 void __jbd2_journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
-- 
2.31.1

