Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3366E3DCC
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 05:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDQDEe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDQDED (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 23:04:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E352716;
        Sun, 16 Apr 2023 20:04:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q0Bht1tXWz4f47kM;
        Mon, 17 Apr 2023 11:03:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODIXtzxkfzJgHA--.17426S19;
        Mon, 17 Apr 2023 11:03:59 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 17/19] ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
Date:   Mon, 17 Apr 2023 19:06:15 +0800
Message-Id: <20230417110617.2664129-18-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODIXtzxkfzJgHA--.17426S19
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDZw43tF1xXFyxKFyDZFb_yoWrKr4Dpw
        nIyFnrCryfGrnrWF48Aa4jq3WFkw48C3W7GrW3CryfCF9IyFn3CF9rtFnY9ayUtFZ7ZFnr
        Xw1Y934UursrWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVb
        yDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

call ext4_mb_mark_group_bb in ext4_group_add_blocks to remove repeat code
to update block bitmap and group descriptor on disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 87 +++++++++--------------------------------------
 1 file changed, 17 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1dad154c9b22..6aac3ee1bb6d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6342,23 +6342,23 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
@@ -6373,19 +6373,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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
@@ -6394,75 +6381,35 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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
 
+	if (mc.changed != cluster_count)
+		ext4_error(sb, "bit already cleared in group %u",
+			   block_group);
 	/*
 	 * need to update group_info->bb_free and bitmap
 	 * with group lock held. generate_buddy look at
 	 * them with group lock_held
 	 */
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

