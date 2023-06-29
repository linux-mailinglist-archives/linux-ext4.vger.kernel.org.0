Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543E974207F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 08:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjF2GjT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2GjQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 02:39:16 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4C270A;
        Wed, 28 Jun 2023 23:39:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs81V1NScz4f4YHK;
        Thu, 29 Jun 2023 14:39:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnUy4LJ51kJfVfMA--.3175S3;
        Thu, 29 Jun 2023 14:39:10 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v5 1/8] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
Date:   Thu, 29 Jun 2023 22:40:00 +0800
Message-Id: <20230629144007.1263510-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
References: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUy4LJ51kJfVfMA--.3175S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4rZw47WF43Jr4xXry7Wrg_yoW7KF1UpF
        9IyF1DCr43Jrnrur43W342q3WrKw109w1kGryfC345CF4ayr95WF1xKFyF9as0yFZrJFnF
        qr1YkrWxur1furDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VCY1x0262k0Y48FwI0_Jr0_
        Gr1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjTRClksUUUUU
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

There are several reasons to add a general function to update block
bitmap and group descriptor on disk:
1. pair behavior of alloc/free bits. For example,
ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
2. remove repeat code to read from disk, update and write back to disk.
3. reduce future unit test mocks to catch real IO to update structure
on disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 157 +++++++++++++++++++++++++---------------------
 1 file changed, 87 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..58864a9116c0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3948,6 +3948,86 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+struct ext4_mark_context {
+	struct super_block *sb;
+	int state;
+};
+
+static int
+ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
+		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
+{
+	struct super_block *sb = mc->sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	int err;
+	unsigned int i, already, changed;
+
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh))
+		return PTR_ERR(bitmap_bh);
+
+	err = -EIO;
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		goto out_err;
+
+	ext4_lock_group(sb, group);
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_clusters_after_init(sb, group, gdp));
+	}
+
+	already = 0;
+	for (i = 0; i < len; i++)
+		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+				mc->state)
+			already++;
+	changed = len - already;
+
+	if (mc->state) {
+		mb_set_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) - changed);
+	} else {
+		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) + changed);
+	}
+
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+	ext4_unlock_group(sb, group);
+
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+					   s_flex_groups, flex_group);
+
+		if (mc->state)
+			atomic64_sub(changed, &fg->free_clusters);
+		else
+			atomic64_add(changed, &fg->free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	if (err)
+		goto out_err;
+
+	sync_dirty_buffer(bitmap_bh);
+	sync_dirty_buffer(gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+	return err;
+}
 
 /*
  * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
@@ -4074,15 +4154,15 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			int len, int state)
 {
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
+	struct ext4_mark_context mc = {
+		.sb = sb,
+		.state = state,
+	};
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, err;
-	int already;
-	unsigned int clen, clen_changed, thisgrp_len;
+	int err;
+	unsigned int clen, thisgrp_len;
 
 	while (len > 0) {
 		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
@@ -4103,80 +4183,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			ext4_error(sb, "Marking blocks in system zone - "
 				   "Block = %llu, len = %u",
 				   block, thisgrp_len);
-			bitmap_bh = NULL;
 			break;
 		}
 
-		bitmap_bh = ext4_read_block_bitmap(sb, group);
-		if (IS_ERR(bitmap_bh)) {
-			err = PTR_ERR(bitmap_bh);
-			bitmap_bh = NULL;
-			break;
-		}
-
-		err = -EIO;
-		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-		if (!gdp)
-			break;
-
-		ext4_lock_group(sb, group);
-		already = 0;
-		for (i = 0; i < clen; i++)
-			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
-					 !state)
-				already++;
-
-		clen_changed = clen - already;
-		if (state)
-			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
-		else
-			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
-		if (ext4_has_group_desc_csum(sb) &&
-		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-			ext4_free_group_clusters_set(sb, gdp,
-			     ext4_free_clusters_after_init(sb, group, gdp));
-		}
-		if (state)
-			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
-		else
-			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
-
-		ext4_free_group_clusters_set(sb, gdp, clen);
-		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-		ext4_group_desc_csum_set(sb, group, gdp);
-
-		ext4_unlock_group(sb, group);
-
-		if (sbi->s_log_groups_per_flex) {
-			ext4_group_t flex_group = ext4_flex_group(sbi, group);
-			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
-						   s_flex_groups, flex_group);
-
-			if (state)
-				atomic64_sub(clen_changed, &fg->free_clusters);
-			else
-				atomic64_add(clen_changed, &fg->free_clusters);
-
-		}
-
-		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-		if (err)
-			break;
-		sync_dirty_buffer(bitmap_bh);
-		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-		sync_dirty_buffer(gdp_bh);
+		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
 		if (err)
 			break;
 
 		block += thisgrp_len;
 		len -= thisgrp_len;
-		brelse(bitmap_bh);
 		BUG_ON(len < 0);
 	}
-
-	if (err)
-		brelse(bitmap_bh);
 }
 
 /*
-- 
2.30.0

