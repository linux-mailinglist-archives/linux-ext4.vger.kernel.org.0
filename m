Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E8720E55
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjFCHCm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjFCHCO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 03:02:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16540134;
        Sat,  3 Jun 2023 00:02:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QY9lx0BlMz4f3pr6;
        Sat,  3 Jun 2023 15:02:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCHOKxk5Xpk+MxPKw--.30174S19;
        Sat, 03 Jun 2023 15:02:06 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v4 17/19] ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
Date:   Sat,  3 Jun 2023 23:03:25 +0800
Message-Id: <20230603150327.3596033-18-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHOKxk5Xpk+MxPKw--.30174S19
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4DJFWfAFyfKrWfurWDXFb_yoW7ZFW7pr
        9IkFnrCr1fGrnruF4xCa4jq3W8Kw48u3W3GrWfCryfCFy2yFnakF97tFnY9F4UtFZ7ZFnr
        Xr1Y9348ursrW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

call ext4_mb_mark_group_bb in ext4_group_add_blocks to remove repeat code
to update block bitmap and group descriptor on disk.

Note: ext4_group_add_blocks will update buddy and bitmap in two critical
sections instead of update in the same critical.

Originally:
ext4_mb_load_buddy_gfp
ext4_lock_group
mb_clear_bits(bitmap_bh, ...)
mb_free_blocks/ext4_mb_free_metadata
ext4_unlock_group
ext4_mb_unload_buddy

Now:
ext4_mb_load_buddy_gfp
ext4_lock_group
mb_clear_bits(bitmap_bh, ...)
ext4_unlock_group

/* no ext4_mb_init_cache for the same group will be called as
ext4_mb_load_buddy_gfp will ensure buddy page is update-to-date */

ext4_lock_group
mb_free_blocks/ext4_mb_free_metadata
ext4_unlock_group
ext4_mb_unload_buddy

As buddy page for group is always update-to-date between
ext4_mb_load_buddy_gfp and ext4_mb_unload_buddy. Then no
ext4_mb_init_cache will be called for the same group concurrentlly when
we update bitmap and buddy page betwwen buddy load and unload.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 92 +++++++++--------------------------------------
 1 file changed, 17 insertions(+), 75 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f1b34448e3..18713b671e46 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6397,23 +6397,23 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 			 ext4_fsblk_t block, unsigned long count)
 {
-	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *gd_bh;
+	struct ext4_mark_context mc = {
+		.handle = handle,
+		.sb = sb,
+		.state = 0,
+	};
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
 
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
@@ -6428,19 +6428,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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
@@ -6449,75 +6436,30 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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
+	err = ext4_mb_load_buddy(sb, block_group, &e4b);
 	if (err)
 		goto error_return;
 
-	for (i = 0, clusters_freed = 0; i < cluster_count; i++) {
-		BUFFER_TRACE(bitmap_bh, "clear bit");
-		if (!mb_test_bit(bit + i, bitmap_bh->b_data)) {
-			ext4_error(sb, "bit already cleared for block %llu",
-				   (ext4_fsblk_t)(block + i));
-			BUFFER_TRACE(bitmap_bh, "bit already cleared");
-		} else {
-			clusters_freed++;
-		}
-	}
+	err = ext4_mb_mark_group_bb(&mc, block_group, bit, cluster_count,
+				    EXT4_MB_BITMAP_MARKED_CHECK);
 
-	err = ext4_mb_load_buddy(sb, block_group, &e4b);
-	if (err)
+	if (err && mc.changed == 0) {
+		ext4_mb_unload_buddy(&e4b);
 		goto error_return;
+	}
 
-	/*
-	 * need to update group_info->bb_free and bitmap
-	 * with group lock held. generate_buddy look at
-	 * them with group lock_held
-	 */
+	if (mc.changed != cluster_count)
+		ext4_error(sb, "bit already cleared in group %u",
+			   block_group);
 	ext4_lock_group(sb, block_group);
-	mb_clear_bits(bitmap_bh->b_data, bit, cluster_count);
 	mb_free_blocks(NULL, &e4b, bit, cluster_count);
-	free_clusters_count = clusters_freed +
-		ext4_free_group_clusters(sb, desc);
-	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
-	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, desc);
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

