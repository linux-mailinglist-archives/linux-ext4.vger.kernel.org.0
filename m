Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15F86EF531
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjDZNLO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbjDZNLM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 09:11:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A65B8A
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 06:11:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5zlB2wJpz4f50wC
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 21:11:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgDHuujRIklkvd9jIA--.13149S4;
        Wed, 26 Apr 2023 21:11:03 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH] jbd2: recheck chechpointing non-dirty buffer
Date:   Wed, 26 Apr 2023 21:10:41 +0800
Message-Id: <20230426131041.1004383-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHuujRIklkvd9jIA--.13149S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3WF1xtw1UWw4fGFW3Wrg_yoWrWw4rpr
        Wakw1YqrWvgFy7urnaqF4UZ3yYqF4kZry7Gry3G3ZxAa1UtwsagFy8Kr9FkF1jkrn3Wa4f
        Xr1UCas3Wa1jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
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

The fix is subtle because we can't trust the chechpointing buffers and
transactions once we release the j_list_lock, they could be written back
and checkpointed by some others, or they could have been added to a new
transaction. So we have to re-add them on the checkpoint list and
recheck their status if they are clean and don't need to write out.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/checkpoint.c | 52 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 51bd38da21cd..1aca860eb0f6 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -77,8 +77,31 @@ static inline void __buffer_relink_io(struct journal_head *jh)
 		jh->b_cpnext->b_cpprev = jh;
 	}
 	transaction->t_checkpoint_io_list = jh;
+	transaction->t_chp_stats.cs_written++;
 }
 
+/*
+ * Move a buffer from the checkpoint io list back to the checkpoint list
+ *
+ * Called with j_list_lock held
+ */
+static inline void __buffer_relink_cp(struct journal_head *jh)
+{
+	transaction_t *transaction = jh->b_cp_transaction;
+
+	__buffer_unlink(jh);
+
+	if (!transaction->t_checkpoint_list) {
+		jh->b_cpnext = jh->b_cpprev = jh;
+	} else {
+		jh->b_cpnext = transaction->t_checkpoint_list;
+		jh->b_cpprev = transaction->t_checkpoint_list->b_cpprev;
+		jh->b_cpprev->b_cpnext = jh;
+		jh->b_cpnext->b_cpprev = jh;
+	}
+	transaction->t_checkpoint_list = jh;
+	transaction->t_chp_stats.cs_written--;
+}
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -175,8 +198,31 @@ __flush_batch(journal_t *journal, int *batch_count)
 	struct blk_plug plug;
 
 	blk_start_plug(&plug);
-	for (i = 0; i < *batch_count; i++)
-		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
+	for (i = 0; i < *batch_count; i++) {
+		struct buffer_head *bh = journal->j_chkpt_bhs[i];
+		struct journal_head *jh = bh2jh(bh);
+
+		lock_buffer(bh);
+		/*
+		 * This buffer isn't dirty, it could be getten write access
+		 * again by a new transaction, re-add it on the checkpoint
+		 * list if it still needs to be checkpointed, and wait
+		 * until that transaction finished to write out.
+		 */
+		if (!test_clear_buffer_dirty(bh)) {
+			unlock_buffer(bh);
+			spin_lock(&journal->j_list_lock);
+			if (jh->b_cp_transaction)
+				__buffer_relink_cp(jh);
+			spin_unlock(&journal->j_list_lock);
+			jbd2_journal_put_journal_head(jh);
+			continue;
+		}
+		jbd2_journal_put_journal_head(jh);
+		bh->b_end_io = end_buffer_write_sync;
+		get_bh(bh);
+		submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+	}
 	blk_finish_plug(&plug);
 
 	for (i = 0; i < *batch_count; i++) {
@@ -303,9 +349,9 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		BUFFER_TRACE(bh, "queue");
 		get_bh(bh);
 		J_ASSERT_BH(bh, !buffer_jwrite(bh));
+		jbd2_journal_grab_journal_head(bh);
 		journal->j_chkpt_bhs[batch_count++] = bh;
 		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
 		if ((batch_count == JBD2_NR_BATCH) ||
 		    need_resched() ||
 		    spin_needbreak(&journal->j_list_lock))
-- 
2.31.1

