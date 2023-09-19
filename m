Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A07A6264
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjISMQ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjISMQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B1F4;
        Tue, 19 Sep 2023 05:16:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqgcR6wgmz4f41Sr;
        Tue, 19 Sep 2023 20:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S9;
        Tue, 19 Sep 2023 20:16:09 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
Date:   Wed, 20 Sep 2023 04:15:27 +0800
Message-Id: <20230919201532.310085-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fJw13Xr1DJr4DCF15Jwb_yoWrGF1xpr
        nxtFnrCr45GFnruF40k34UXF1fKw18W3WkJrW3CryfCrW2yr93KFyxtF1FvFW5tFZrX3Za
        qF1Y9348ur47W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Call ext4_mb_mark_context in ext4_mb_clear_bb to remove repeat code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 69 +++++++----------------------------------------
 1 file changed, 10 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8c1127aa7f59..730397af6975 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6402,19 +6402,17 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			       ext4_fsblk_t block, unsigned long count,
 			       int flags)
 {
-	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
-	struct ext4_group_desc *gdp;
 	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
-	struct buffer_head *gd_bh;
 	ext4_group_t block_group;
 	struct ext4_sb_info *sbi;
 	struct ext4_buddy e4b;
 	unsigned int count_clusters;
 	int err = 0;
-	int ret;
+	int mark_flags = 0;
+	ext4_grpblk_t changed;
 
 	sbi = EXT4_SB(sb);
 
@@ -6463,64 +6461,19 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		goto error_clean;
 	}
 
-	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto error_clean;
-	}
-	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
-	if (!gdp) {
-		err = -EIO;
-		goto error_clean;
-	}
-
-	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
-					    EXT4_JTR_NONE);
-	if (err)
-		goto error_clean;
-
-	/*
-	 * We are about to modify some metadata.  Call the journal APIs
-	 * to unshare ->b_data if a currently-committing transaction is
-	 * using it
-	 */
-	BUFFER_TRACE(gd_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
-	if (err)
-		goto error_clean;
 #ifdef AGGRESSIVE_CHECK
-	{
-		int i;
-		for (i = 0; i < count_clusters; i++)
-			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
-	}
+	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
 #endif
-	ext4_lock_group(sb, block_group);
-	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
-	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
-	ext4_free_group_clusters_set(sb, gdp, ret);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
-	ext4_unlock_group(sb, block_group);
+	err = ext4_mb_mark_context(handle, sb, false, block_group, bit,
+				   count_clusters, mark_flags, &changed);
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
-		atomic64_add(count_clusters,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
-	}
 
-	/* We dirtied the bitmap block */
-	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
-	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
+	if (err && changed == 0)
+		goto error_clean;
 
-	/* And the group descriptor block */
-	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
-	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
-	if (!err)
-		err = ret;
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(changed != count_clusters);
+#endif
 
 	/*
 	 * We need to make sure we don't reuse the freed block until after the
@@ -6579,7 +6532,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		block += count;
 		count = overflow;
 		ext4_mb_unload_buddy(&e4b);
-		put_bh(bitmap_bh);
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 		goto do_more;
@@ -6587,7 +6539,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
 error_clean:
 	ext4_mb_unload_buddy(&e4b);
-	brelse(bitmap_bh);
 error_out:
 	ext4_std_error(sb, err);
 }
-- 
2.30.0

