Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175BD717F06
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjEaLvd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEaLvR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 07:51:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FF18B
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 04:51:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWSJt4bjBz4f3v50
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 19:51:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33eqkNHdkE8UXKg--.13786S9;
        Wed, 31 May 2023 19:51:11 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH 5/5] jbd2: fix a race when checking checkpoint buffer busy
Date:   Wed, 31 May 2023 19:51:00 +0800
Message-Id: <20230531115100.2779605-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eqkNHdkE8UXKg--.13786S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5Kw4kWF1kWFWrXFyrWFg_yoWrGrykpF
        Z3KayjvrWv934UuFn2qF45A3yjqF4qvryUG3ykC3Zaya1UJws2qry7tr1ayFn8Krnag3WY
        vryUGrn8C3yjyFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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
same problem, so fix them by introduce a new helper to check the busy
state atomically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c  | 8 ++++----
 fs/jbd2/transaction.c | 4 ++--
 include/linux/jbd2.h  | 3 +++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 620f3d345f3d..2dde5fd1f0dd 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -45,11 +45,11 @@ static inline void __buffer_unlink(struct journal_head *jh)
  *
  * Requires j_list_lock
  */
-static inline bool __cp_buffer_busy(struct journal_head *jh)
+static inline bool cp_buffer_busy(struct journal_head *jh)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
-	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
+	return (jh->b_transaction || __cp_buffer_busy(bh));
 }
 
 /*
@@ -369,7 +369,7 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (!destroy && __cp_buffer_busy(jh))
+		if (!destroy && cp_buffer_busy(jh))
 			return 0;
 
 		if (__jbd2_journal_remove_checkpoint(jh))
@@ -413,7 +413,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		next_jh = jh->b_cpnext;
 
 		(*nr_to_scan)--;
-		if (__cp_buffer_busy(jh))
+		if (cp_buffer_busy(jh))
 			continue;
 
 		nr_freed++;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 18611241f451..04863787c93e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1784,7 +1784,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		 * Otherwise, if the buffer has been written to disk,
 		 * it is safe to remove the checkpoint and drop it.
 		 */
-		if (!buffer_dirty(bh)) {
+		if (!__cp_buffer_busy(bh)) {
 			__jbd2_journal_remove_checkpoint(jh);
 			spin_unlock(&journal->j_list_lock);
 			goto drop;
@@ -2112,7 +2112,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 
 	jh = bh2jh(bh);
 
-	if (buffer_locked(bh) || buffer_dirty(bh))
+	if (__cp_buffer_busy(bh))
 		goto out;
 
 	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 91a2cf4bc575..b17d1efab787 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1440,6 +1440,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 extern void jbd2_journal_commit_transaction(journal_t *);
 
 /* Checkpoint list management */
+#define __cp_buffer_busy(bh) \
+	((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock)))
+
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
-- 
2.31.1

