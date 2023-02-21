Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2669D9F6
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 04:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBUD6C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 22:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjBUD5q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 22:57:46 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15FF23327;
        Mon, 20 Feb 2023 19:57:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLQV70FJkz4f3wQx;
        Tue, 21 Feb 2023 11:57:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+ktQfRj8VfgDw--.30652S9;
        Tue, 21 Feb 2023 11:57:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 7/7] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
Date:   Tue, 21 Feb 2023 19:59:19 +0800
Message-Id: <20230221115919.1918161-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3q+ktQfRj8VfgDw--.30652S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4rCry5CF4DZry7Cw1rZwb_yoW7WF48pr
        47tF1rJr45WF1qgr4ftr1qgryrGw1rKr4UJa43JF13GF9rZr4Ikr9xJrn8AFyqg3W7Xw1q
        vF1UC34Uu393G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As inode table blocks are contiguous, inode table blocks inside the
block_group can be represented as range [itbl_cluster_start,
itbl_cluster_last]. Then we can simply account inode table cluters and
check cluster overlap with [itbl_cluster_start, itbl_cluster_last] instead
of traverse each block of inode table.
By the way, this patch fixes code style problem of comment for
ext4_num_overhead_clusters.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 90 +++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index dab46274d591..689edfed231a 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -80,32 +80,56 @@ static inline int ext4_block_in_group(struct super_block *sb,
 	return (actual_group == block_group) ? 1 : 0;
 }
 
-/* Return the number of clusters used for file system metadata; this
+/*
+ * Return the number of clusters used for file system metadata; this
  * represents the overhead needed by the file system.
  */
 static unsigned ext4_num_overhead_clusters(struct super_block *sb,
 					   ext4_group_t block_group,
 					   struct ext4_group_desc *gdp)
 {
-	unsigned num_clusters;
-	int block_cluster = -1, inode_cluster = -1, itbl_cluster = -1, i, c;
+	unsigned base_clusters, num_clusters;
+	int block_cluster, inode_cluster;
+	int itbl_cluster_start = -1, itbl_cluster_end = -1;
 	ext4_fsblk_t start = ext4_group_first_block_no(sb, block_group);
-	ext4_fsblk_t itbl_blk;
+	ext4_fsblk_t end = start + EXT4_BLOCKS_PER_GROUP(sb) - 1;
+	ext4_fsblk_t itbl_blk_start, itbl_blk_end;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	/* This is the number of clusters used by the superblock,
 	 * block group descriptors, and reserved block group
 	 * descriptor blocks */
-	num_clusters = ext4_num_base_meta_clusters(sb, block_group);
+	base_clusters = ext4_num_base_meta_clusters(sb, block_group);
+	num_clusters = base_clusters;
 
 	/*
-	 * For the allocation bitmaps and inode table, we first need
-	 * to check to see if the block is in the block group.  If it
-	 * is, then check to see if the cluster is already accounted
-	 * for in the clusters used for the base metadata cluster, or
-	 * if we can increment the base metadata cluster to include
-	 * that block.  Otherwise, we will have to track the cluster
-	 * used for the allocation bitmap or inode table explicitly.
+	 * Account and record inode table clusters if any cluster
+	 * is in the block group, or inode table cluster range is
+	 * [-1, -1] and won't overlap with block/inode bitmap cluster
+	 * accounted below.
+	 */
+	itbl_blk_start = ext4_inode_table(sb, gdp);
+	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
+	if (itbl_blk_start <= end && itbl_blk_end >= start) {
+		itbl_blk_start = itbl_blk_start >= start ?
+			itbl_blk_start : start;
+		itbl_blk_end = itbl_blk_end <= end ?
+			itbl_blk_end : end;
+
+		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
+		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
+
+		num_clusters += itbl_cluster_end - itbl_cluster_start + 1;
+		/* check if border cluster is overlapped */
+		if (itbl_cluster_start == base_clusters - 1)
+			num_clusters--;
+	}
+
+	/*
+	 * For the allocation bitmaps, we first need to check to see
+	 * if the block is in the block group.  If it is, then check
+	 * to see if the cluster is already accounted for in the clusters
+	 * used for the base metadata cluster and inode tables cluster.
 	 * Normally all of these blocks are contiguous, so the special
 	 * case handling shouldn't be necessary except for *very*
 	 * unusual file system layouts.
@@ -113,46 +137,26 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
 	if (ext4_block_in_group(sb, ext4_block_bitmap(sb, gdp), block_group)) {
 		block_cluster = EXT4_B2C(sbi,
 					 ext4_block_bitmap(sb, gdp) - start);
-		if (block_cluster < num_clusters)
-			block_cluster = -1;
-		else if (block_cluster == num_clusters) {
+		if (block_cluster >= base_clusters &&
+		    (block_cluster < itbl_cluster_start ||
+		    block_cluster > itbl_cluster_end))
 			num_clusters++;
-			block_cluster = -1;
-		}
 	}
 
 	if (ext4_block_in_group(sb, ext4_inode_bitmap(sb, gdp), block_group)) {
 		inode_cluster = EXT4_B2C(sbi,
 					 ext4_inode_bitmap(sb, gdp) - start);
-		if (inode_cluster < num_clusters)
-			inode_cluster = -1;
-		else if (inode_cluster == num_clusters) {
-			num_clusters++;
-			inode_cluster = -1;
-		}
-	}
-
-	itbl_blk = ext4_inode_table(sb, gdp);
-	for (i = 0; i < sbi->s_itb_per_group; i++) {
-		if (ext4_block_in_group(sb, itbl_blk + i, block_group)) {
-			c = EXT4_B2C(sbi, itbl_blk + i - start);
-			if ((c < num_clusters) || (c == inode_cluster) ||
-			    (c == block_cluster) || (c == itbl_cluster))
-				continue;
-			if (c == num_clusters) {
-				num_clusters++;
-				continue;
-			}
+		/*
+		 * Additional check if inode bitmap is in just accounted
+		 * block_cluster
+		 */
+		if (inode_cluster != block_cluster &&
+		    inode_cluster >= base_clusters &&
+		    (inode_cluster < itbl_cluster_start ||
+		    inode_cluster > itbl_cluster_end))
 			num_clusters++;
-			itbl_cluster = c;
-		}
 	}
 
-	if (block_cluster != -1)
-		num_clusters++;
-	if (inode_cluster != -1)
-		num_clusters++;
-
 	return num_clusters;
 }
 
-- 
2.30.0

