Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6E747302
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGDNoM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGDNoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EFE6B
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwPCQ2Svmz4f3nJt
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:44:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S12;
        Tue, 04 Jul 2023 21:44:03 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 08/12] jbd2: cleanup journal_init_common()
Date:   Tue,  4 Jul 2023 21:42:29 +0800
Message-Id: <20230704134233.110812-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5Jw13XF4DWw13try3XFb_yoWrXw18pr
        y7KasxArW8Zr47Xr1fJF4kJrWjq3y09FyUGr9ruwn5ta1UtrnxXw1Utw1xJayqvFW8W3Wr
        XFyfC34xCw1UKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhLUUUUU
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

Adjust the initialization sequence and error handle of journal_t, moving
load superblock to the begin, and classify others initialization.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 210b532a3673..065b5e789299 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1541,6 +1541,16 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal)
 		return NULL;
 
+	journal->j_blocksize = blocksize;
+	journal->j_dev = bdev;
+	journal->j_fs_dev = fs_dev;
+	journal->j_blk_offset = start;
+	journal->j_total_len = len;
+
+	err = journal_load_superblock(journal);
+	if (err)
+		goto err_cleanup;
+
 	init_waitqueue_head(&journal->j_wait_transaction_locked);
 	init_waitqueue_head(&journal->j_wait_done_commit);
 	init_waitqueue_head(&journal->j_wait_commit);
@@ -1552,12 +1562,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
 	spin_lock_init(&journal->j_list_lock);
+	spin_lock_init(&journal->j_history_lock);
 	rwlock_init(&journal->j_state_lock);
 
 	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
 	journal->j_min_batch_time = 0;
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
+	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
+			 &jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1567,18 +1580,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (err)
 		goto err_cleanup;
 
-	spin_lock_init(&journal->j_history_lock);
-
-	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
-
-	/* journal descriptor can store up to n blocks -bzzz */
-	journal->j_blocksize = blocksize;
-	journal->j_dev = bdev;
-	journal->j_fs_dev = fs_dev;
-	journal->j_blk_offset = start;
-	journal->j_total_len = len;
-	/* We need enough buffers to write out full descriptor block. */
+	/*
+	 * journal descriptor can store up to n blocks, we need enough
+	 * buffers to write out full descriptor block.
+	 */
 	n = journal->j_blocksize / jbd2_min_tag_size();
 	journal->j_wbufsize = n;
 	journal->j_fc_wbuf = NULL;
@@ -1587,7 +1592,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
-	err = journal_load_superblock(journal);
+	err = percpu_counter_init(&journal->j_checkpoint_jh_count, 0,
+				  GFP_KERNEL);
 	if (err)
 		goto err_cleanup;
 
@@ -1596,21 +1602,18 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
 	journal->j_shrinker.seeks = DEFAULT_SEEKS;
 	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
-
-	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
+	err = register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
+				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	if (err)
 		goto err_cleanup;
 
-	if (register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
-			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev))) {
-		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-		goto err_cleanup;
-	}
 	return journal;
 
 err_cleanup:
-	brelse(journal->j_sb_buffer);
+	percpu_counter_destroy(&journal->j_checkpoint_jh_count);
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
+	journal_fail_superblock(journal);
 	kfree(journal);
 	return NULL;
 }
-- 
2.39.2

