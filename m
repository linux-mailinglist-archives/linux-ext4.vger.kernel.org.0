Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5F789474
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjHZHvT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjHZHut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45972683;
        Sat, 26 Aug 2023 00:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpsC6QdTz4f3jRD;
        Sat, 26 Aug 2023 15:50:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S8;
        Sat, 26 Aug 2023 15:50:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/11] ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
Date:   Sat, 26 Aug 2023 23:50:23 +0800
Message-Id: <20230826155028.4019470-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxCw4rZF4DKr43ArW3Awb_yoW7JryrpF
        n8JFnrCr4rGFnF9F40k34UXF1fKw18W347JrWfCr93Cr1ayr9aka97tFnYvFW5tFZ7X3Wq
        qr1Y93yUur4xW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
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

Call ext4_mb_mark_context in ext4_mb_clear_bb to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 83 +++++++++++------------------------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 01ad36a1cc96..25265531cb6a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6424,21 +6424,20 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			       ext4_fsblk_t block, unsigned long count,
 			       int flags)
 {
-	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_mark_context mc;
 	struct super_block *sb = inode->i_sb;
-	struct ext4_group_desc *gdp;
 	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
-	struct buffer_head *gd_bh;
 	ext4_group_t block_group;
 	struct ext4_sb_info *sbi;
 	struct ext4_buddy e4b;
 	unsigned int count_clusters;
 	int err = 0;
-	int ret;
+	int mark_flags = 0;
 
 	sbi = EXT4_SB(sb);
+	ext4_mb_prepare_mark_context(&mc, handle, sb, 0);
 
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
@@ -6468,18 +6467,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
-	count_clusters = EXT4_NUM_B2C(sbi, count);
-	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto error_return;
-	}
-	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
-	if (!gdp) {
-		err = -EIO;
-		goto error_return;
-	}
 
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
@@ -6489,28 +6476,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		goto error_return;
 	}
 
-	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
-					    EXT4_JTR_NONE);
-	if (err)
-		goto error_return;
-
-	/*
-	 * We are about to modify some metadata.  Call the journal APIs
-	 * to unshare ->b_data if a currently-committing transaction is
-	 * using it
-	 */
-	BUFFER_TRACE(gd_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
-	if (err)
-		goto error_return;
-#ifdef AGGRESSIVE_CHECK
-	{
-		int i;
-		for (i = 0; i < count_clusters; i++)
-			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
-	}
-#endif
+	count_clusters = EXT4_NUM_B2C(sbi, count);
 	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
 
 	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
@@ -6519,13 +6485,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	if (err)
 		goto error_return;
 
-	ext4_lock_group(sb, block_group);
-	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
-	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
-	ext4_free_group_clusters_set(sb, gdp, ret);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
-	ext4_unlock_group(sb, block_group);
+#ifdef AGGRESSIVE_CHECK
+	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
+#endif
+	err = ext4_mb_mark_context(&mc, block_group, bit, count_clusters,
+				   mark_flags);
+
+
+	if (err && mc.changed == 0) {
+		ext4_mb_unload_buddy(&e4b);
+		goto error_return;
+	}
+
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(mc.changed != count_clusters);
+#endif
 
 	/*
 	 * We need to make sure we don't reuse the freed block until after the
@@ -6568,13 +6542,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
 	ext4_unlock_group(sb, block_group);
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
-		atomic64_add(count_clusters,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
-	}
-
 	/*
 	 * on a bigalloc file system, defer the s_freeclusters_counter
 	 * update to the caller (ext4_remove_space and friends) so they
@@ -6589,26 +6556,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
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
 	if (overflow && !err) {
 		block += count;
 		count = overflow;
-		put_bh(bitmap_bh);
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 		goto do_more;
 	}
 error_return:
-	brelse(bitmap_bh);
 	ext4_std_error(sb, err);
 }
 
-- 
2.30.0

