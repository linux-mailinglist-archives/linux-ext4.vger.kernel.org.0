Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277B7A6251
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjISMQV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjISMQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F61F7;
        Tue, 19 Sep 2023 05:16:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqgcQ5kwHz4f41SW;
        Tue, 19 Sep 2023 20:16:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S5;
        Tue, 19 Sep 2023 20:16:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/12] ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
Date:   Wed, 20 Sep 2023 04:15:23 +0800
Message-Id: <20230919201532.310085-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5trWDKFWkWF15GF13CFg_yoW8Zr4kpr
        ZxAr1xCr1fGr1q9F4xJ34xX3W8Kw18W3WDGrWfW3s5CFW3Ar9agF48KF1Fva4YkFZrZ3ZI
        vF1Y93y7Zr15W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jgsqAUUUUU=
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

call ext4_mb_mark_context in ext4_free_blocks_simple to:
1. remove repeat code
2. pair update of free_clusters in ext4_mb_new_blocks_simple.
3. add missing ext4_lock_group/ext4_unlock_group protection.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e1320eea46e9..cd2fd5dbfcdd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6393,43 +6393,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 					unsigned long count)
 {
-	struct buffer_head *bitmap_bh;
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
+	ext4_mb_mark_context(sb, false, group, blkoff, count);
 }
 
 /**
-- 
2.30.0

