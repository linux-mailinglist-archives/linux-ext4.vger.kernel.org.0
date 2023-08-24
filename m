Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B45786BEB
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbjHXJa6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbjHXJav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F44610FA
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9b0N26z4f41S8
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S14;
        Thu, 24 Aug 2023 17:30:44 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 10/16] ext4: reserve meta blocks in ext4_da_reserve_space()
Date:   Thu, 24 Aug 2023 17:26:13 +0800
Message-Id: <20230824092619.1327976-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXw18ZFWDtr15uF4UAw47urg_yoWrCryrpF
        n8AFy3W348W34kWFWfZr47Zr4fua4IgFWUtFZrWF1xZFy5J3WSgr1DtF1YvF1YyrZ3Gw1D
        Xa45W34ru3WUWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Prepare to reserve metadata blocks for delay allocation in
ext4_da_reserve_space(), claim reserved space from the global
sbi->s_dirtyclusters_counter, and also updating tracepoints to show the
new reserved metadata blocks. This patch is just a preparation, the
reserved ext_len is always zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c             | 28 ++++++++++++++++------------
 include/trace/events/ext4.h | 10 ++++++++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dda17b3340ce..a189009d20fa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1439,31 +1439,37 @@ static int ext4_journalled_write_end(struct file *file,
 }
 
 /*
- * Reserve space for a single cluster
+ * Reserve space for a 'rsv_dlen' data blocks/clusters and 'rsv_extlen'
+ * extent metadata blocks.
  */
-static int ext4_da_reserve_space(struct inode *inode)
+static int ext4_da_reserve_space(struct inode *inode, unsigned int rsv_dlen,
+				 unsigned int rsv_extlen)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int ret;
 
+	if (!rsv_dlen && !rsv_extlen)
+		return 0;
+
 	/*
 	 * We will charge metadata quota at writeout time; this saves
 	 * us from metadata over-estimation, though we may go over by
 	 * a small amount in the end.  Here we just reserve for data.
 	 */
-	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, 1));
+	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, rsv_dlen));
 	if (ret)
 		return ret;
 
 	spin_lock(&ei->i_block_reservation_lock);
-	if (ext4_claim_free_clusters(sbi, 1, 0)) {
+	if (ext4_claim_free_clusters(sbi, rsv_dlen + rsv_extlen, 0)) {
 		spin_unlock(&ei->i_block_reservation_lock);
-		dquot_release_reservation_block(inode, EXT4_C2B(sbi, 1));
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, rsv_dlen));
 		return -ENOSPC;
 	}
-	ei->i_reserved_data_blocks++;
-	trace_ext4_da_reserve_space(inode);
+	ei->i_reserved_data_blocks += rsv_dlen;
+	ei->i_reserved_ext_blocks += rsv_extlen;
+	trace_ext4_da_reserve_space(inode, rsv_dlen, rsv_extlen);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	return 0;       /* success */
@@ -1659,11 +1665,9 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	if (rsv_dlen > 0) {
-		ret = ext4_da_reserve_space(inode);
-		if (ret)   /* ENOSPC */
-			return ret;
-	}
+	ret = ext4_da_reserve_space(inode, rsv_dlen, 0);
+	if (ret)   /* ENOSPC */
+		return ret;
 
 	ext4_es_insert_delayed_block(inode, lblk, allocated);
 	return 0;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 115f96f444ff..7a9839f2d681 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1251,14 +1251,16 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_reserve_space,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct inode *inode, int data_blocks, int meta_blocks),
 
-	TP_ARGS(inode),
+	TP_ARGS(inode, data_blocks, meta_blocks),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
+		__field(	int,	data_blocks		)
+		__field(	int,	meta_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	int,	reserved_ext_blocks	)
 		__field(	__u16,  mode			)
@@ -1268,16 +1270,20 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
+		__entry->data_blocks = data_blocks;
+		__entry->meta_blocks = meta_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
 	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+		  "data_blocks %d meta_blocks %d "
 		  "reserved_data_blocks %d reserved_ext_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
+		  __entry->data_blocks, __entry->meta_blocks,
 		  __entry->reserved_data_blocks,
 		  __entry->reserved_ext_blocks)
 );
-- 
2.39.2

