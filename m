Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16A786BF1
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjHXJbF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbjHXJav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA732198A
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9d4Dw4z4f3kpL
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S19;
        Thu, 24 Aug 2023 17:30:46 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 15/16] ext4: flush delalloc blocks if no free space
Date:   Thu, 24 Aug 2023 17:26:18 +0800
Message-Id: <20230824092619.1327976-16-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S19
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Ar1DAr18Cw1rZF47Arb_yoW7CryDpa
        98C3WrGr40vw1DWa13XFsxXFyS9w40kFyUGr4fu34jvrZIqF1rWF9rtFy0yF15trWrJw1x
        uFWUKryUurWjk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

For delalloc, the reserved metadata blocks count is calculated in the
worst case, so the reservation could be larger than the real needs, that
could lead to return false positive -ENOSPC when claiming free space. So
start a worker to flush delalloc blocks in ext4_should_retry_alloc().
If the s_dirtyclusters_counter is not zero, there may have some delalloc
metadata blocks that could be freed.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/balloc.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 fs/ext4/ext4.h   |  5 +++++
 fs/ext4/super.c  | 12 ++++++++++++
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 79b20d6ae39e..e8acc21ef56d 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -667,6 +667,30 @@ int ext4_claim_free_clusters(struct ext4_sb_info *sbi,
 		return -ENOSPC;
 }
 
+void ext4_writeback_da_blocks(struct work_struct *work)
+{
+	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
+						s_da_flush_work);
+
+	try_to_writeback_inodes_sb(sbi->s_sb, WB_REASON_FS_FREE_SPACE);
+}
+
+/*
+ * Writeback delallocated blocks and try to free unused reserved extent
+ * blocks, return 0 if no delalloc blocks need to writeback, 1 otherwise.
+ */
+static int ext4_flush_da_blocks(struct ext4_sb_info *sbi)
+{
+	if (!percpu_counter_read_positive(&sbi->s_dirtyclusters_counter) &&
+	    !percpu_counter_sum(&sbi->s_dirtyclusters_counter))
+		return 0;
+
+	if (!work_busy(&sbi->s_da_flush_work))
+		queue_work(sbi->s_da_flush_wq, &sbi->s_da_flush_work);
+	flush_work(&sbi->s_da_flush_work);
+	return 1;
+}
+
 /**
  * ext4_should_retry_alloc() - check if a block allocation should be retried
  * @sb:			superblock
@@ -681,15 +705,22 @@ int ext4_claim_free_clusters(struct ext4_sb_info *sbi,
 int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-
-	if (!sbi->s_journal)
-		return 0;
+	int result = 0;
 
 	if (++(*retries) > 3) {
 		percpu_counter_inc(&sbi->s_sra_exceeded_retry_limit);
 		return 0;
 	}
 
+	/*
+	 * Flush allocated delalloc blocks and try to free unused
+	 * reserved extent blocks.
+	 */
+	if (test_opt(sb, DELALLOC))
+		result += ext4_flush_da_blocks(sbi);
+
+	if (!sbi->s_journal)
+		goto out;
 	/*
 	 * if there's no indication that blocks are about to be freed it's
 	 * possible we just missed a transaction commit that did so
@@ -701,16 +732,20 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 			flush_work(&sbi->s_discard_work);
 			atomic_dec(&sbi->s_retry_alloc_pending);
 		}
-		return ext4_has_free_clusters(sbi, 1, 0);
+		result += ext4_has_free_clusters(sbi, 1, 0);
+		goto out;
 	}
 
 	/*
 	 * it's possible we've just missed a transaction commit here,
 	 * so ignore the returned status
 	 */
-	ext4_debug("%s: retrying operation after ENOSPC\n", sb->s_id);
+	result += 1;
 	(void) jbd2_journal_force_commit_nested(sbi->s_journal);
-	return 1;
+out:
+	if (result)
+		ext4_debug("%s: retrying operation after ENOSPC\n", sb->s_id);
+	return result;
 }
 
 /*
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 67b12f9ffc50..6f4259ea6751 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1627,6 +1627,10 @@ struct ext4_sb_info {
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
 
+	/* workqueue for delalloc buffer IO flushing */
+	struct workqueue_struct *s_da_flush_wq;
+	struct work_struct s_da_flush_work;
+
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
 
@@ -2716,6 +2720,7 @@ extern int ext4_wait_block_bitmap(struct super_block *sb,
 				  struct buffer_head *bh);
 extern struct buffer_head *ext4_read_block_bitmap(struct super_block *sb,
 						  ext4_group_t block_group);
+extern void ext4_writeback_da_blocks(struct work_struct *work);
 extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      ext4_group_t block_group,
 					      struct ext4_group_desc *gdp);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7bc7c8c0ed71..6f50975ba42e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1335,6 +1335,8 @@ static void ext4_put_super(struct super_block *sb)
 
 	flush_work(&sbi->s_sb_upd_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
+	flush_work(&sbi->s_da_flush_work);
+	destroy_workqueue(sbi->s_da_flush_wq);
 	ext4_release_orphan_info(sb);
 
 	if (sbi->s_journal) {
@@ -5491,6 +5493,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount4;
 	}
 
+	INIT_WORK(&sbi->s_da_flush_work, ext4_writeback_da_blocks);
+	sbi->s_da_flush_wq = alloc_workqueue("ext4_delalloc_flush", WQ_UNBOUND, 1);
+	if (!sbi->s_da_flush_wq) {
+		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
+		err = -ENOMEM;
+		goto failed_mount4;
+	}
+
 	/*
 	 * The jbd2_journal_load will have done any necessary log recovery,
 	 * so we can safely mount the rest of the filesystem now.
@@ -5660,6 +5670,8 @@ failed_mount9: __maybe_unused
 	sb->s_root = NULL;
 failed_mount4:
 	ext4_msg(sb, KERN_ERR, "mount failed");
+	if (sbi->s_da_flush_wq)
+		destroy_workqueue(sbi->s_da_flush_wq);
 	if (EXT4_SB(sb)->rsv_conversion_wq)
 		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
 failed_mount_wq:
-- 
2.39.2

