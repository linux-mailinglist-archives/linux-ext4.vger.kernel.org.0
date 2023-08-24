Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A3786BEF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjHXJbF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbjHXJat (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921D10F9
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9c12Vsz4f3q39
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S15;
        Thu, 24 Aug 2023 17:30:44 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 11/16] ext4: factor out common part of ext4_da_{release|update_reserve}_space()
Date:   Thu, 24 Aug 2023 17:26:14 +0800
Message-Id: <20230824092619.1327976-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S15
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWrXF1xJryxtry3Cr1rZwb_yoW5tF17pr
        y3CFW3Wa48WrykuFWfXr4UZr1F9aySqFWUtrZ7WFnrZrW5Ga4Sgr18tF1FvF1YkrZ3Jr4j
        qa45G34ru3WDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

The reserve blocks updating part in ext4_da_release_space() and
ext4_da_update_reserve_space() are almost the same, so factor them out
to a common helper.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 60 +++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a189009d20fa..13036cecbcc0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -325,6 +325,27 @@ qsize_t *ext4_get_reserved_space(struct inode *inode)
 }
 #endif
 
+static void __ext4_da_update_reserve_space(const char *where,
+					   struct inode *inode,
+					   int data_len)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (unlikely(data_len > ei->i_reserved_data_blocks)) {
+		ext4_warning(inode->i_sb, "%s: ino %lu, clear %d "
+			     "with only %d reserved data blocks",
+			     where, inode->i_ino, data_len,
+			     ei->i_reserved_data_blocks);
+		WARN_ON(1);
+		data_len = ei->i_reserved_data_blocks;
+	}
+
+	/* Update per-inode reservations */
+	ei->i_reserved_data_blocks -= data_len;
+	percpu_counter_sub(&sbi->s_dirtyclusters_counter, data_len);
+}
+
 /*
  * Called with i_data_sem down, which is important since we can call
  * ext4_discard_preallocations() from here.
@@ -340,19 +361,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 
 	spin_lock(&ei->i_block_reservation_lock);
 	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
-	if (unlikely(used > ei->i_reserved_data_blocks)) {
-		ext4_warning(inode->i_sb, "%s: ino %lu, used %d "
-			 "with only %d reserved data blocks",
-			 __func__, inode->i_ino, used,
-			 ei->i_reserved_data_blocks);
-		WARN_ON(1);
-		used = ei->i_reserved_data_blocks;
-	}
-
-	/* Update per-inode reservations */
-	ei->i_reserved_data_blocks -= used;
-	percpu_counter_sub(&sbi->s_dirtyclusters_counter, used);
-
+	__ext4_da_update_reserve_space(__func__, inode, used);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	/* Update quota subsystem for data blocks */
@@ -1483,29 +1492,10 @@ void ext4_da_release_space(struct inode *inode, int to_free)
 	if (!to_free)
 		return;		/* Nothing to release, exit */
 
-	spin_lock(&EXT4_I(inode)->i_block_reservation_lock);
-
+	spin_lock(&ei->i_block_reservation_lock);
 	trace_ext4_da_release_space(inode, to_free);
-	if (unlikely(to_free > ei->i_reserved_data_blocks)) {
-		/*
-		 * if there aren't enough reserved blocks, then the
-		 * counter is messed up somewhere.  Since this
-		 * function is called from invalidate page, it's
-		 * harmless to return without any action.
-		 */
-		ext4_warning(inode->i_sb, "ext4_da_release_space: "
-			 "ino %lu, to_free %d with only %d reserved "
-			 "data blocks", inode->i_ino, to_free,
-			 ei->i_reserved_data_blocks);
-		WARN_ON(1);
-		to_free = ei->i_reserved_data_blocks;
-	}
-	ei->i_reserved_data_blocks -= to_free;
-
-	/* update fs dirty data blocks counter */
-	percpu_counter_sub(&sbi->s_dirtyclusters_counter, to_free);
-
-	spin_unlock(&EXT4_I(inode)->i_block_reservation_lock);
+	__ext4_da_update_reserve_space(__func__, inode, to_free);
+	spin_unlock(&ei->i_block_reservation_lock);
 
 	dquot_release_reservation_block(inode, EXT4_C2B(sbi, to_free));
 }
-- 
2.39.2

