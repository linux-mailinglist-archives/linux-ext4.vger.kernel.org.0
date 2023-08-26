Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6C789481
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHZHvZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjHZHuv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:51 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083971FF0;
        Sat, 26 Aug 2023 00:50:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpsD2xJzz4f3jXr;
        Sat, 26 Aug 2023 15:50:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S10;
        Sat, 26 Aug 2023 15:50:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/11] ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
Date:   Sat, 26 Aug 2023 23:50:25 +0800
Message-Id: <20230826155028.4019470-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Cry5uw43Xr15tw45trb_yoWrtw1fpr
        nIyFnrCryrGrnruF48Aa4jq3WrKw48C3W7WrW3CryfCFy2yFn3CF97tFnY9FWDtFZ7ZFnr
        Xw1Y9348ursxW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIVyIUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call ext4_mb_mark_context in ext4_group_add_blocks() to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 84 +++++++----------------------------------------
 1 file changed, 12 insertions(+), 72 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bb08a71a6e61..fdffa3b40bcd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6681,25 +6681,22 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 			 ext4_fsblk_t block, unsigned long count)
 {
-	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *gd_bh;
+	struct ext4_mark_context mc;
 	ext4_group_t block_group;
 	ext4_grpblk_t bit;
-	unsigned int i;
-	struct ext4_group_desc *desc;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_buddy e4b;
-	int err = 0, ret, free_clusters_count;
-	ext4_grpblk_t clusters_freed;
+	int err = 0;
 	ext4_fsblk_t first_cluster = EXT4_B2C(sbi, block);
 	ext4_fsblk_t last_cluster = EXT4_B2C(sbi, block + count - 1);
 	unsigned long cluster_count = last_cluster - first_cluster + 1;
 
 	ext4_debug("Adding block(s) %llu-%llu\n", block, block + count - 1);
 
-	if (count == 0)
+	if (cluster_count == 0)
 		return 0;
 
+	ext4_mb_prepare_mark_context(&mc, handle, sb, 0);
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 	/*
 	 * Check to see if we are freeing blocks across a group
@@ -6712,19 +6709,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		goto error_return;
 	}
 
-	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto error_return;
-	}
-
-	desc = ext4_get_group_desc(sb, block_group, &gd_bh);
-	if (!desc) {
-		err = -EIO;
-		goto error_return;
-	}
-
 	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
 		ext4_error(sb, "Adding blocks in system zones - "
 			   "Block = %llu, count = %lu",
@@ -6733,74 +6717,30 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		goto error_return;
 	}
 
-	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
-					    EXT4_JTR_NONE);
+	err = ext4_mb_load_buddy(sb, block_group, &e4b);
 	if (err)
 		goto error_return;
 
-	/*
-	 * We are about to modify some metadata.  Call the journal APIs
-	 * to unshare ->b_data if a currently-committing transaction is
-	 * using it
-	 */
-	BUFFER_TRACE(gd_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
-	if (err)
+	err = ext4_mb_mark_context(&mc, block_group, bit, cluster_count,
+				   EXT4_MB_BITMAP_MARKED_CHECK);
+	if (err && mc.changed == 0) {
+		ext4_mb_unload_buddy(&e4b);
 		goto error_return;
-
-	for (i = 0, clusters_freed = 0; i < cluster_count; i++) {
-		BUFFER_TRACE(bitmap_bh, "clear bit");
-		if (!mb_test_bit(bit + i, bitmap_bh->b_data)) {
-			ext4_error(sb, "bit already cleared for block %llu",
-				   (ext4_fsblk_t)(block + i));
-			BUFFER_TRACE(bitmap_bh, "bit already cleared");
-		} else {
-			clusters_freed++;
-		}
 	}
 
-	err = ext4_mb_load_buddy(sb, block_group, &e4b);
-	if (err)
-		goto error_return;
-
-	ext4_lock_group(sb, block_group);
-	mb_clear_bits(bitmap_bh->b_data, bit, cluster_count);
-	free_clusters_count = clusters_freed +
-		ext4_free_group_clusters(sb, desc);
-	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
-	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, desc);
-	ext4_unlock_group(sb, block_group);
+	if (mc.changed != cluster_count)
+		ext4_error(sb, "bit already cleared in group %u", block_group);
 
 	ext4_lock_group(sb, block_group);
 	mb_free_blocks(NULL, &e4b, bit, cluster_count);
 	ext4_unlock_group(sb, block_group);
 
 	percpu_counter_add(&sbi->s_freeclusters_counter,
-			   clusters_freed);
-
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
-		atomic64_add(clusters_freed,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
-	}
+			   mc.changed);
 
 	ext4_mb_unload_buddy(&e4b);
 
-	/* We dirtied the bitmap block */
-	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
-	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
-
-	/* And the group descriptor block */
-	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
-	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
-	if (!err)
-		err = ret;
-
 error_return:
-	brelse(bitmap_bh);
 	ext4_std_error(sb, err);
 	return err;
 }
-- 
2.30.0

