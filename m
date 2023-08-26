Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FCB78947D
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHZHvX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHZHus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:48 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC0F1FF0;
        Sat, 26 Aug 2023 00:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpsB6KsTz4f3jMP;
        Sat, 26 Aug 2023 15:50:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S4;
        Sat, 26 Aug 2023 15:50:42 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/11] ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
Date:   Sat, 26 Aug 2023 23:50:19 +0800
Message-Id: <20230826155028.4019470-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5trWDKFy5CF47Zry8AFb_yoW8Zw17pr
        ZxAr1xCr1fGr1DuF4xJ342q3W8Kw18W3WDGryfW34rCFW3Ar93WF48KF1FvFyYkFZrZ3ZI
        vr1Y9rW7Zw15W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUsknYUUUUU
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

call ext4_mb_mark_context in ext4_free_blocks_simple to:
1. remove repeat code
2. pair update of free_clusters in ext4_mb_new_blocks_simple.
3. add missing ext4_lock_group/ext4_unlock_group protection.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e2be572deb75..c803f74aaf63 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6414,43 +6414,14 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 					unsigned long count)
 {
-	struct buffer_head *bitmap_bh;
+	struct ext4_mark_context mc;
 	struct super_block *sb = inode->i_sb;
-	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int already_freed = 0, err, i;
 
+	ext4_mb_prepare_mark_context(&mc, sb, 0);
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
+	ext4_mb_mark_context(&mc, group, blkoff, count);
 }
 
 /**
-- 
2.30.0

