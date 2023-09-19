Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC657A626C
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjISMQa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjISMQU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46564FC;
        Tue, 19 Sep 2023 05:16:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqgcP27C7z4f3s6B;
        Tue, 19 Sep 2023 20:16:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S8;
        Tue, 19 Sep 2023 20:16:09 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
Date:   Wed, 20 Sep 2023 04:15:26 +0800
Message-Id: <20230919201532.310085-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S8
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWDAF4fCry7JFWftry3CFg_yoW3Jr45pr
        9FyFnrCrn5GrnF9F40k34jq3WSkw48ua1DGrW3uryxCr1ayr9akFZ7tF93uFWUtFZ7X3Wq
        qr1Y93y8Cr4ag37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
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
---
 fs/ext4/mballoc.c | 98 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 87e5922997fb..8c1127aa7f59 100644
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

