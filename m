Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAD723764
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjFFGPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjFFGPB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 02:15:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E2187
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 23:15:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qb0Z82dqlz4f3kpX
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 14:14:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33erXzn5kkHrZKw--.1805S8;
        Tue, 06 Jun 2023 14:14:55 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v2 4/6] jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint
Date:   Tue,  6 Jun 2023 14:14:45 +0800
Message-Id: <20230606061447.1125036-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33erXzn5kkHrZKw--.1805S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7Kw48tF1UWFWxZr4Utwb_yoW5Cr15pr
        WfKrWagr4kWr1UuFn3tFW5X3y0qa1DZrWUGr45K3Wvya1jvwsagFy3trnFyry5tr93Wayr
        ZFy5Cr97CF10ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
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

From: Zhihao Cheng <chengzhihao1@huawei.com>

Following process,

jbd2_journal_commit_transaction
// there are several dirty buffer heads in transaction->t_checkpoint_list
          P1                   wb_workfn
jbd2_log_do_checkpoint
 if (buffer_locked(bh)) // false
                            __block_write_full_page
                             trylock_buffer(bh)
                             test_clear_buffer_dirty(bh)
 if (!buffer_dirty(bh))
  __jbd2_journal_remove_checkpoint(jh)
   if (buffer_write_io_error(bh)) // false
                             >> bh IO error occurs <<
 jbd2_cleanup_journal_tail
  __jbd2_update_log_tail
   jbd2_write_superblock
   // The bh won't be replayed in next mount.
, which could corrupt the ext4 image, fetch a reproducer in [Link].

Since writeback process clears buffer dirty after locking buffer head,
we can fix it by try locking buffer and check dirtiness while buffer is
locked, the buffer head can be removed if it is neither dirty nor locked.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 3eb5b01a7e84..32f86bfbca69 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -204,20 +204,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
-		/*
-		 * The buffer may be writing back, or flushing out in the
-		 * last couple of cycles, or re-adding into a new transaction,
-		 * need to check it again until it's unlocked.
-		 */
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			goto retry;
-		}
 		if (jh->b_transaction != NULL) {
 			transaction_t *t = jh->b_transaction;
 			tid_t tid = t->t_tid;
@@ -252,7 +238,22 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 		}
-		if (!buffer_dirty(bh)) {
+		if (!trylock_buffer(bh)) {
+			/*
+			 * The buffer is locked, it may be writing back, or
+			 * flushing out in the last couple of cycles, or
+			 * re-adding into a new transaction, need to check
+			 * it again until it's unlocked.
+			 */
+			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			/* the journal_head may have gone by now */
+			BUFFER_TRACE(bh, "brelse");
+			__brelse(bh);
+			goto retry;
+		} else if (!buffer_dirty(bh)) {
+			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			/*
 			 * If the transaction was released or the checkpoint
@@ -262,6 +263,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			    !transaction->t_checkpoint_list)
 				goto out;
 		} else {
+			unlock_buffer(bh);
 			/*
 			 * We are about to write the buffer, it could be
 			 * raced by some other transaction shrink or buffer
-- 
2.31.1

