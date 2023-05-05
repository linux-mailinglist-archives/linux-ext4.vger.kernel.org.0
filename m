Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2816F8348
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEEMvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjEEMvh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 08:51:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E5C1FFE
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 05:51:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QCVSf6ZG1z4f3m7Y
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 20:32:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33epT91RkDvzXIg--.37253S6;
        Fri, 05 May 2023 20:32:36 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v2 3/3] jbd2: remove released parameter in journal_shrink_one_cp_list()
Date:   Fri,  5 May 2023 20:32:19 +0800
Message-Id: <20230505123219.4135141-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
References: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33epT91RkDvzXIg--.37253S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15Ww1fJF18KFWDJry5Arb_yoW8trW8pF
        yfC3yjqrWku34DCr1vvF48ArW0vFWj9ryUKF9FkF93Aa1UKw4fKFy7tw17tFyUAryrWa1a
        q34UWFn8Gw1Yva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
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

After t_checkpoint_io_list is gone, the 'released' parameter in
journal_shrink_one_cp_list() becomes useless, just remove it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 2b62154e9f1e..7b6320081f11 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -387,15 +387,13 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
  * journal_shrink_one_cp_list
  *
  * Find 'nr_to_scan' written-back checkpoint buffers in the given list
- * and try to release them. If the whole transaction is released, set
- * the 'released' parameter. Return the number of released checkpointed
+ * and try to release them. Return the number of released checkpointed
  * buffers.
  *
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						unsigned long *nr_to_scan,
-						bool *released)
+						unsigned long *nr_to_scan)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
@@ -416,10 +414,8 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 
 		nr_freed++;
 		ret = __jbd2_journal_remove_checkpoint(jh);
-		if (ret) {
-			*released = true;
+		if (ret)
 			break;
-		}
 
 		if (need_resched())
 			break;
@@ -441,7 +437,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 						  unsigned long *nr_to_scan)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	bool released;
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
@@ -474,10 +469,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
-		released = false;
 
 		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						       nr_to_scan, &released);
+						       nr_to_scan);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
-- 
2.31.1

