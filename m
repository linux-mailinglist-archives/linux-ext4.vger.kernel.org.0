Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384D6704333
	for <lists+linux-ext4@lfdr.de>; Tue, 16 May 2023 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEPCCx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 May 2023 22:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEPCCw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 May 2023 22:02:52 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA63586
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 19:02:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QKzyr2yyYz4f3tNT
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 10:02:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAHrusy5GJkLBS5JQ--.48186S6;
        Tue, 16 May 2023 10:02:45 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 3/3] jbd2: remove released parameter in journal_shrink_one_cp_list()
Date:   Tue, 16 May 2023 10:02:26 +0800
Message-Id: <20230516020226.2813588-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230516020226.2813588-1-yi.zhang@huaweicloud.com>
References: <20230516020226.2813588-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAHrusy5GJkLBS5JQ--.48186S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15Ww1fJFyfXFW7Gw18Grg_yoW8tFy7pF
        yfu34jqrZYv34DCrn2qF48CrW0vFWj9ry7KF9FkF9aya1UKw4fKFy2yr17tFyUJryrWa1a
        q34UKFn8Ww1Yya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

After t_checkpoint_io_list is gone, the 'released' parameter in
journal_shrink_one_cp_list() becomes useless, just remove it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 55d6efdbea64..3f52560912a9 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -391,15 +391,13 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
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
@@ -420,10 +418,8 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 
 		nr_freed++;
 		ret = __jbd2_journal_remove_checkpoint(jh);
-		if (ret) {
-			*released = true;
+		if (ret)
 			break;
-		}
 
 		if (need_resched())
 			break;
@@ -445,7 +441,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 						  unsigned long *nr_to_scan)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	bool released;
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
@@ -478,10 +473,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
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

