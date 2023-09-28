Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F387B1592
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjI1IFC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjI1IE4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76CB3;
        Thu, 28 Sep 2023 01:04:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cK6X23z4f3nJK;
        Thu, 28 Sep 2023 16:04:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S10;
        Thu, 28 Sep 2023 16:04:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_group_add_blocks()
Date:   Fri, 29 Sep 2023 00:04:03 +0800
Message-Id: <20230928160407.142069-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S10
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1fZrWfWr17KryrZw47Jwb_yoW7JFy3pr
        y2krn5Cr1rGrnrZF4xA34jq3W0kw48ua1UKrWfur1xCrZFyFnakFyktFn5ZFWUtFs7A3Zr
        XryY9348ur42gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
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
The reason why this can be sperated is explained in previous submit.
Put the explanation here to simplify the code archeology to
ext4_group_add_blocks():

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
 fs/ext4/mballoc.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 767a975be2ca..27fa3b3b931f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6685,35 +6685,39 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		ext4_warning(sb, "too many blocks added to group %u",
 			     block_group);
 		err = -EINVAL;
-		goto error_return;
+		goto error_out;
+	}
+
+	err = ext4_mb_load_buddy(sb, block_group, &e4b);
+	if (err)
+		goto error_out;
+
+	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
+		ext4_error(sb, "Adding blocks in system zones - "
+			   "Block = %llu, count = %lu",
+			   block, count);
+		err = -EINVAL;
+		goto error_clean;
 	}
 
 	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
 		bitmap_bh = NULL;
-		goto error_return;
+		goto error_clean;
 	}
 
 	desc = ext4_get_group_desc(sb, block_group, &gd_bh);
 	if (!desc) {
 		err = -EIO;
-		goto error_return;
-	}
-
-	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
-		ext4_error(sb, "Adding blocks in system zones - "
-			   "Block = %llu, count = %lu",
-			   block, count);
-		err = -EINVAL;
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
@@ -6723,7 +6727,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	BUFFER_TRACE(gd_bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
 	if (err)
-		goto error_return;
+		goto error_clean;
 
 	for (i = 0, clusters_freed = 0; i < cluster_count; i++) {
 		BUFFER_TRACE(bitmap_bh, "clear bit");
@@ -6736,26 +6740,14 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		}
 	}
 
-	err = ext4_mb_load_buddy(sb, block_group, &e4b);
-	if (err)
-		goto error_return;
-
-	/*
-	 * need to update group_info->bb_free and bitmap
-	 * with group lock held. generate_buddy look at
-	 * them with group lock_held
-	 */
 	ext4_lock_group(sb, block_group);
 	mb_clear_bits(bitmap_bh->b_data, bit, cluster_count);
-	mb_free_blocks(NULL, &e4b, bit, cluster_count);
 	free_clusters_count = clusters_freed +
 		ext4_free_group_clusters(sb, desc);
 	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
 	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
 	ext4_group_desc_csum_set(sb, block_group, desc);
 	ext4_unlock_group(sb, block_group);
-	percpu_counter_add(&sbi->s_freeclusters_counter,
-			   clusters_freed);
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
@@ -6764,8 +6756,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 						  flex_group)->free_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
-
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
 	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
@@ -6776,8 +6766,16 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	if (!err)
 		err = ret;
 
-error_return:
+	ext4_lock_group(sb, block_group);
+	mb_free_blocks(NULL, &e4b, bit, cluster_count);
+	ext4_unlock_group(sb, block_group);
+	percpu_counter_add(&sbi->s_freeclusters_counter,
+			   clusters_freed);
+
+error_clean:
 	brelse(bitmap_bh);
+	ext4_mb_unload_buddy(&e4b);
+error_out:
 	ext4_std_error(sb, err);
 	return err;
 }
-- 
2.30.0

