Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD82742084
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjF2GjZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2GjR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 02:39:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D42D55;
        Wed, 28 Jun 2023 23:39:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs81W35qcz4f4rKL;
        Thu, 29 Jun 2023 14:39:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnUy4LJ51kJfVfMA--.3175S7;
        Thu, 29 Jun 2023 14:39:12 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v5 5/8] ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
Date:   Thu, 29 Jun 2023 22:40:04 +0800
Message-Id: <20230629144007.1263510-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
References: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUy4LJ51kJfVfMA--.3175S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUJw4UWrWUtFWxGw4fAFb_yoWxAw4Dpr
        yDAFnFkr15GwnF9F40k345XF1fKw18Way7JrWfCr93Cr1avr93KFWktFn3ZFWUtFZ7X3WD
        XF1Y9rWUur4xW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
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

call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
to update block bitmap and group descriptor on disk.

Note: ext4_mb_clear_bb will update buddy and bitmap in two critical
sections instead of update in the same critical section.

Original lock behavior introduced in commit 7a2fcbf7f8573 ("ext4: don't
use blocks freed but not yet committed in buddy cache init") to avoid
race betwwen ext4_mb_free_blocks and ext4_mb_init_cache:
ext4_mb_load_buddy_gfp
ext4_lock_group
mb_clear_bits(bitmap_bh, ...)
mb_free_blocks/ext4_mb_free_metadata
ext4_unlock_group
ext4_mb_unload_buddy

New lock behavior in this patch:
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
 fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 67 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 34fd12aeaf8d..57cc304b724e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6325,19 +6325,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			       ext4_fsblk_t block, unsigned long count,
 			       int flags)
 {
-	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_mark_context mc = {
+		.handle = handle,
+		.sb = inode->i_sb,
+		.state = 0,
+	};
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
 
 	sbi = EXT4_SB(sb);
 
@@ -6369,18 +6371,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
-	count_clusters = EXT4_NUM_B2C(sbi, count);
-	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto error_return;
-	}
-	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
-	if (!gdp) {
-		err = -EIO;
-		goto error_return;
-	}
 
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
@@ -6390,28 +6380,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
-	if (err)
-		goto error_return;
-#ifdef AGGRESSIVE_CHECK
-	{
-		int i;
-		for (i = 0; i < count_clusters; i++)
-			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
-	}
-#endif
+	count_clusters = EXT4_NUM_B2C(sbi, count);
 	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
 
 	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
@@ -6420,6 +6389,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	if (err)
 		goto error_return;
 
+#ifdef AGGRESSIVE_CHECK
+	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
+#endif
+	err = ext4_mb_mark_group_bb(&mc, block_group, bit, count_clusters,
+				    mark_flags);
+
+
+	if (err && mc.changed == 0) {
+		ext4_mb_unload_buddy(&e4b);
+		goto error_return;
+	}
+
+#ifdef AGGRESSIVE_CHECK
+	BUG_ON(mc.changed != count_clusters);
+#endif
+
 	/*
 	 * We need to make sure we don't reuse the freed block until after the
 	 * transaction is committed. We make an exception if the inode is to be
@@ -6442,13 +6427,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		new_entry->efd_tid = handle->h_transaction->t_tid;
 
 		ext4_lock_group(sb, block_group);
-		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
 		ext4_mb_free_metadata(handle, &e4b, new_entry);
 	} else {
-		/* need to update group_info->bb_free and bitmap
-		 * with group lock held. generate_buddy look at
-		 * them with group lock_held
-		 */
 		if (test_opt(sb, DISCARD)) {
 			err = ext4_issue_discard(sb, block_group, bit,
 						 count_clusters, NULL);
@@ -6461,23 +6441,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
 
 		ext4_lock_group(sb, block_group);
-		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
 		mb_free_blocks(inode, &e4b, bit, count_clusters);
 	}
 
-	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
-	ext4_free_group_clusters_set(sb, gdp, ret);
-	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
-		atomic64_add(count_clusters,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
-	}
-
 	/*
 	 * on a bigalloc file system, defer the s_freeclusters_counter
 	 * update to the caller (ext4_remove_space and friends) so they
@@ -6492,26 +6460,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
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
 	if (overflow && !err) {
 		block += count;
 		count = overflow;
-		put_bh(bitmap_bh);
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 		goto do_more;
 	}
 error_return:
-	brelse(bitmap_bh);
 	ext4_std_error(sb, err);
 	return;
 }
-- 
2.30.0

