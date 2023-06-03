Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C01720E51
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 09:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjFCHCe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjFCHCO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 03:02:14 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC283E5D;
        Sat,  3 Jun 2023 00:02:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QY9lv0mZSz4f3nqP;
        Sat,  3 Jun 2023 15:02:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCHOKxk5Xpk+MxPKw--.30174S15;
        Sat, 03 Jun 2023 15:02:04 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v4 13/19] ext4: call ext4_mb_mark_group_bb in ext4_free_blocks_simple
Date:   Sat,  3 Jun 2023 23:03:21 +0800
Message-Id: <20230603150327.3596033-14-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHOKxk5Xpk+MxPKw--.30174S15
X-Coremail-Antispam: 1UD129KBjvJXoWxXrykJF4fGF1DJFWxZFyUtrb_yoW5JFWDpr
        ZIyr17Gr1fGr1Dur4xJ34jq3W8Kw18u3WUGryfC3s5CFW3Ar9YgFWxKF1Fvas0yFZrZ3Zx
        ZF1Y93yUur1fW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
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

call ext4_mb_mark_group_bb in ext4_free_blocks_simple to:
1. remove repeat code
2. pair update of free_clusters in ext4_mb_new_blocks_simple.
3. add missing ext4_lock_group/ext4_unlock_group protection.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 685dcc17bf7c..dae4533411f7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3798,6 +3798,8 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
 	ext4_lock_group(sb, group);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		WARN_ON(mc->state == 0);
+
 		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 		ext4_free_group_clusters_set(sb, gdp,
 			ext4_free_clusters_after_init(sb, group, gdp));
@@ -6120,43 +6122,16 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 					unsigned long count)
 {
-	struct buffer_head *bitmap_bh;
+	struct ext4_mark_context mc = {
+		.sb = inode->i_sb,
+		.state = 0,
+	};
 	struct super_block *sb = inode->i_sb;
-	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int already_freed = 0, err, i;
 
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	bitmap_bh = ext4_read_block_bitmap(sb, group);
-	if (IS_ERR(bitmap_bh)) {
-		pr_warn("Failed to read block bitmap\n");
-		return;
-	}
-	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-	if (!gdp)
-		goto err_out;
-
-	for (i = 0; i < count; i++) {
-		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
-			already_freed++;
-	}
-	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
-	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-	if (err)
-		goto err_out;
-	ext4_free_group_clusters_set(
-		sb, gdp, ext4_free_group_clusters(sb, gdp) +
-		count - already_freed);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, group, gdp);
-	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-	sync_dirty_buffer(bitmap_bh);
-	sync_dirty_buffer(gdp_bh);
-
-err_out:
-	brelse(bitmap_bh);
+	ext4_mb_mark_group_bb(&mc, group, blkoff, count);
 }
 
 /**
-- 
2.30.0

