Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCB742082
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjF2GjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjF2GjR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 02:39:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D62705;
        Wed, 28 Jun 2023 23:39:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs81W0fBXz4f4YHM;
        Thu, 29 Jun 2023 14:39:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnUy4LJ51kJfVfMA--.3175S6;
        Thu, 29 Jun 2023 14:39:11 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v5 4/8] ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
Date:   Thu, 29 Jun 2023 22:40:03 +0800
Message-Id: <20230629144007.1263510-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
References: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUy4LJ51kJfVfMA--.3175S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF45Xw17tF48ArWfJr17trb_yoW7XFyUpF
        nIyF1DCr1fWr1DuFWIk34qqF1rKw48Gw1rJ34xGr1fCF12krs8Aay8ta40vasrKFW7A3Z0
        vr1Yya4UCr47WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VCY1x0262k0Y48FwI0_
        Jr0_Gr1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjTRtR6wUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 89 ++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b1d8e140a3fa..34fd12aeaf8d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4064,13 +4064,17 @@ static noinline_for_stack int
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
 	int err, len;
+	int flags = 0;
 
 	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
 	BUG_ON(ac->ac_b_ex.fe_len <= 0);
@@ -4078,32 +4082,13 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
@@ -4112,41 +4097,28 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
+	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
+				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
+				    flags);
+
+	if (err && mc.changed == 0)
+		return err;
 
-	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(mc.changed != ac->ac_b_ex.fe_len);
+#endif
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
 	/*
 	 * Now reduce the dirty block count also. Should not go negative
@@ -4156,21 +4128,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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

