Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6B6DF04F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDLJ0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDLJ0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 05:26:17 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90D6A4E;
        Wed, 12 Apr 2023 02:26:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxHQB3DC8z4f3snB;
        Wed, 12 Apr 2023 17:26:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S17;
        Wed, 12 Apr 2023 17:26:12 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 15/19] ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
Date:   Thu, 13 Apr 2023 01:28:29 +0800
Message-Id: <20230412172833.2317696-16-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
References: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S17
X-Coremail-Antispam: 1UD129KBjvJXoW3XF45Xw1Utr13Ww4kGr1kGrg_yoW7Xr1Dpr
        nIyF1DCr1fWr1DuFWIk34DXF1rKw48Gw1rJ34xGF1fCF12krZ8Cay8ta40ya9rKFZrA3Z0
        vr1Yya4UCr47WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used to:
1. remove repeat code to normally update bitmap and group descriptor
on disk.
2. call ext4_mb_mark_group_bb instead of only setting bits in block bitmap
to fix the bitmap. Function ext4_mb_mark_group_bb will also update
checksum of bitmap and other counter along with the bit change to keep
the cosistent with bit change or block bitmap will be marked corrupted as
checksum of bitmap is in inconsistent state.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 90 +++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fb163b61ac02..3d31ad486a0c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3847,9 +3847,12 @@ static noinline_for_stack int
 ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 				handle_t *handle, unsigned int reserv_clstrs)
 {
-	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_mark_context mc = {
+		.handle = handle,
+		.sb = ac->ac_sb,
+		.state = 1,
+	};
 	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	ext4_fsblk_t block;
@@ -3861,32 +3864,13 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	sb = ac->ac_sb;
 	sbi = EXT4_SB(sb);
 
-	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
-	if (IS_ERR(bitmap_bh)) {
-		return PTR_ERR(bitmap_bh);
-	}
-
-	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
-					    EXT4_JTR_NONE);
-	if (err)
-		goto out_err;
-
-	err = -EIO;
-	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, &gdp_bh);
+	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, NULL);
 	if (!gdp)
-		goto out_err;
-
+		return -EIO;
 	ext4_debug("using block group %u(%d)\n", ac->ac_b_ex.fe_group,
 			ext4_free_group_clusters(sb, gdp));
 
-	BUFFER_TRACE(gdp_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sb, gdp_bh, EXT4_JTR_NONE);
-	if (err)
-		goto out_err;
-
 	block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
-
 	len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
 	if (!ext4_inode_block_valid(ac->ac_inode, block, len)) {
 		ext4_error(sb, "Allocating blocks %llu-%llu which overlap "
@@ -3895,41 +3879,30 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 		 * Fix the bitmap and return EFSCORRUPTED
 		 * We leak some of the blocks here.
 		 */
-		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
-		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
-			      ac->ac_b_ex.fe_len);
-		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
-		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
+		err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
+					    ac->ac_b_ex.fe_start,
+					    ac->ac_b_ex.fe_len,
+					    0);
 		if (!err)
 			err = -EFSCORRUPTED;
-		goto out_err;
+		return err;
 	}
 
-	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
 #ifdef AGGRESSIVE_CHECK
-	{
-		int i;
-		for (i = 0; i < ac->ac_b_ex.fe_len; i++) {
-			BUG_ON(mb_test_bit(ac->ac_b_ex.fe_start + i,
-						bitmap_bh->b_data));
-		}
-	}
+	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
+				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
+				    EXT4_MB_BITMAP_MARKED_CHECK);
+#else
+	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
+				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
+				    0);
 #endif
-	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
-		      ac->ac_b_ex.fe_len);
-	if (ext4_has_group_desc_csum(sb) &&
-	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-		ext4_free_group_clusters_set(sb, gdp,
-					     ext4_free_clusters_after_init(sb,
-						ac->ac_b_ex.fe_group, gdp));
-	}
-	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
-	ext4_free_group_clusters_set(sb, gdp, len);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
+	if (err && mc.changed == 0)
+		return err;
 
-	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(mc.changed != ac->ac_b_ex.fe_len);
+#endif
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
 	/*
 	 * Now reduce the dirty block count also. Should not go negative
@@ -3939,21 +3912,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
 				   reserv_clstrs);
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi,
-							  ac->ac_b_ex.fe_group);
-		atomic64_sub(ac->ac_b_ex.fe_len,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
-	}
-
-	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
-	if (err)
-		goto out_err;
-	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
-
-out_err:
-	brelse(bitmap_bh);
 	return err;
 }
 
-- 
2.30.0

