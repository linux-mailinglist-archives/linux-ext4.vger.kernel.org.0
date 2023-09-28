Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1907B1591
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI1IFD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjI1IE4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD109F;
        Thu, 28 Sep 2023 01:04:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cL1NkKz4f3kkD;
        Thu, 28 Sep 2023 16:04:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S7;
        Thu, 28 Sep 2023 16:04:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
Date:   Fri, 29 Sep 2023 00:04:00 +0800
Message-Id: <20230928160407.142069-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKry8Gw15tw18GF43JF15XFb_yoW7Xr1fpF
        nxtF1UCr1fWr1DuFZ29w1DXF1rKw48G3WrJ34xGr1fuF12krZ8Aa18ta4Iya9rKFW7A3Wq
        vF4Yya4UCr47WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Call ext4_mb_mark_context in ext4_mb_mark_diskspace_used to:
1. Remove repeat code to normally update bitmap and group descriptor
on disk.
2. Now that we have a common API for marking blocks inuse/free in block
bitmap, use that instead of open coding it in function
ext4_mb_mark_diskspace_used(). The current code was not updating
checksum and other counters. ext4_mb_mark_context() should fix these
consistency problems.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 86 +++++++++++------------------------------------
 1 file changed, 20 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b3e418c0f3d5..236540a178ff 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4063,13 +4063,13 @@ static noinline_for_stack int
 ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 				handle_t *handle, unsigned int reserv_clstrs)
 {
-	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	ext4_fsblk_t block;
 	int err, len;
+	int flags = 0;
+	ext4_grpblk_t changed;
 
 	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
 	BUG_ON(ac->ac_b_ex.fe_len <= 0);
@@ -4077,32 +4077,13 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
@@ -4111,41 +4092,29 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 		 * Fix the bitmap and return EFSCORRUPTED
 		 * We leak some of the blocks here.
 		 */
-		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
-		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
-			      ac->ac_b_ex.fe_len);
-		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
-		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
+		err = ext4_mb_mark_context(handle, sb, true,
+					   ac->ac_b_ex.fe_group,
+					   ac->ac_b_ex.fe_start,
+					   ac->ac_b_ex.fe_len,
+					   0, NULL);
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
+	flags |= EXT4_MB_BITMAP_MARKED_CHECK;
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
+	err = ext4_mb_mark_context(handle, sb, true, ac->ac_b_ex.fe_group,
+				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
+				   flags, &changed);
+
+	if (err && changed == 0)
+		return err;
 
-	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(changed != ac->ac_b_ex.fe_len);
+#endif
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
 	/*
 	 * Now reduce the dirty block count also. Should not go negative
@@ -4155,21 +4124,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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

