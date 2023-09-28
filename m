Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50727B1595
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjI1IFG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjI1IE5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:57 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E9AC;
        Thu, 28 Sep 2023 01:04:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cK2QnZz4f3n6p;
        Thu, 28 Sep 2023 16:04:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S8;
        Thu, 28 Sep 2023 16:04:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
Date:   Fri, 29 Sep 2023 00:04:01 +0800
Message-Id: <20230928160407.142069-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S8
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWDAF4fCryrKw1fXF4ruFg_yoW3JFyxpr
        9FyFnrCrn5GrnF9F40k34jq3WSkw48ua1DGrW3uryxCr1ayr9akFZ7tF93ZFWUtFZ7X3Z0
        qr1Y93y8Cr4ag37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch separates block bitmap and buddy bitmap freeing in order to
update block bitmap with ext4_mb_mark_context in following patch.

Separated freeing is safe with concurrent allocation as long as:
1. Firstly allocate block in buddy bitmap, and then in block bitmap.
2. Firstly free block in block bitmap, and then buddy bitmap.
Then freed block will only be available to allocation when both buddy
bitmap and block bitmap are updated by freeing.
Allocation obeys rule 1 already, just do sperated freeing with rule 2.

Separated freeing has no race with generate_buddy as:
Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
buddy page can be found in sbi->s_buddy_cache and no more buddy
initialization of the buddy page will be executed concurrently until
buddy page is unloaded. As we always do free in "load buddy, free,
unload buddy" sequence, separated freeing has no race with generate_buddy.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 98 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 236540a178ff..79d62078da9a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6423,7 +6423,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		ext4_error(sb, "Freeing blocks in system zone - "
 			   "Block = %llu, count = %lu", block, count);
 		/* err = 0. ext4_std_error should be a no op */
-		goto error_return;
+		goto error_out;
 	}
 	flags |= EXT4_FREE_BLOCKS_VALIDATED;
 
@@ -6447,31 +6447,39 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
 	count_clusters = EXT4_NUM_B2C(sbi, count);
+	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
+
+	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
+	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
+				     GFP_NOFS|__GFP_NOFAIL);
+	if (err)
+		goto error_out;
+
+	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
+	    !ext4_inode_block_valid(inode, block, count)) {
+		ext4_error(sb, "Freeing blocks in system zone - "
+			   "Block = %llu, count = %lu", block, count);
+		/* err = 0. ext4_std_error should be a no op */
+		goto error_clean;
+	}
+
 	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
 		bitmap_bh = NULL;
-		goto error_return;
+		goto error_clean;
 	}
 	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
 	if (!gdp) {
 		err = -EIO;
-		goto error_return;
-	}
-
-	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
-	    !ext4_inode_block_valid(inode, block, count)) {
-		ext4_error(sb, "Freeing blocks in system zone - "
-			   "Block = %llu, count = %lu", block, count);
-		/* err = 0. ext4_std_error should be a no op */
-		goto error_return;
+		goto error_clean;
 	}
 
 	BUFFER_TRACE(bitmap_bh, "getting write access");
 	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
 					    EXT4_JTR_NONE);
 	if (err)
-		goto error_return;
+		goto error_clean;
 
 	/*
 	 * We are about to modify some metadata.  Call the journal APIs
@@ -6481,7 +6489,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	BUFFER_TRACE(gd_bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
 	if (err)
-		goto error_return;
+		goto error_clean;
 #ifdef AGGRESSIVE_CHECK
 	{
 		int i;
@@ -6489,13 +6497,30 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
 	}
 #endif
-	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
+	ext4_lock_group(sb, block_group);
+	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
+	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
+	ext4_free_group_clusters_set(sb, gdp, ret);
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, block_group, gdp);
+	ext4_unlock_group(sb, block_group);
 
-	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
-	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
-				     GFP_NOFS|__GFP_NOFAIL);
-	if (err)
-		goto error_return;
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
+		atomic64_add(count_clusters,
+			     &sbi_array_rcu_deref(sbi, s_flex_groups,
+						  flex_group)->free_clusters);
+	}
+
+	/* We dirtied the bitmap block */
+	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
+	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
+
+	/* And the group descriptor block */
+	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
+	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
+	if (!err)
+		err = ret;
 
 	/*
 	 * We need to make sure we don't reuse the freed block until after the
@@ -6519,13 +6544,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		new_entry->efd_tid = handle->h_transaction->t_tid;
 
 		ext4_lock_group(sb, block_group);
-		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
 		ext4_mb_free_metadata(handle, &e4b, new_entry);
 	} else {
-		/* need to update group_info->bb_free and bitmap
-		 * with group lock held. generate_buddy look at
-		 * them with group lock_held
-		 */
 		if (test_opt(sb, DISCARD)) {
 			err = ext4_issue_discard(sb, block_group, bit,
 						 count_clusters, NULL);
@@ -6538,23 +6558,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
 
 		ext4_lock_group(sb, block_group);
-		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
 		mb_free_blocks(inode, &e4b, bit, count_clusters);
 	}
 
-	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
-	ext4_free_group_clusters_set(sb, gdp, ret);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
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
@@ -6567,28 +6575,20 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 				   count_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
-
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
+		ext4_mb_unload_buddy(&e4b);
 		put_bh(bitmap_bh);
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 		goto do_more;
 	}
-error_return:
+
+error_clean:
+	ext4_mb_unload_buddy(&e4b);
 	brelse(bitmap_bh);
+error_out:
 	ext4_std_error(sb, err);
 }
 
-- 
2.30.0

