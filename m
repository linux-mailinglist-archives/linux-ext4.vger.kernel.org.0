Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5B4EA046
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbiC1TuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbiC1TsD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 15:48:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2B69732;
        Mon, 28 Mar 2022 12:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C677BB81204;
        Mon, 28 Mar 2022 19:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9994EC36AE3;
        Mon, 28 Mar 2022 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648496607;
        bh=hWdMhmuIfK/e0VCOiuNnU5w+6ZuraPokVQDiivCW8lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUqonVXODw6XbtDdlme78eMRqNLmintYJmbfylB35dx8DojbDU2Zaqnr/O2Svlxnc
         XqoRsGdSskrRwyzZJQUnVKgkMYIfV6gm/pJXUdmNd+W7PyeaKBORXZybFf1yrtPRRU
         3G2kGeEgM6zTHfTftmwfNy8YBuhbVBQNeIT+gw7e3MfnBmhKTVZIUcoMxQfDEZ2fiI
         UAzcSVQfOidz4iHsUJgCIYkJvTwlbdjM7TC7pKUQrXCplifWmYX5BJ3isv74dEl/sp
         /SH7YFq/aKCmmV4oFcHtEaujusN75If3/8TCCSVUQPNDBHXSygTFDETeLKR+cL7a5B
         JNWEdwH1oGL+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/8] ext4: fix ext4_mb_mark_bb() with flex_bg with fast_commit
Date:   Mon, 28 Mar 2022 15:43:17 -0400
Message-Id: <20220328194322.1586401-3-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328194322.1586401-1-sashal@kernel.org>
References: <20220328194322.1586401-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit bfdc502a4a4c058bf4cbb1df0c297761d528f54d ]

In case of flex_bg feature (which is by default enabled), extents for
any given inode might span across blocks from two different block group.
ext4_mb_mark_bb() only reads the buffer_head of block bitmap once for the
starting block group, but it fails to read it again when the extent length
boundary overflows to another block group. Then in this below loop it
accesses memory beyond the block group bitmap buffer_head and results
into a data abort.

	for (i = 0; i < clen; i++)
		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
			already++;

This patch adds this functionality for checking block group boundary in
ext4_mb_mark_bb() and update the buffer_head(bitmap_bh) for every different
block group.

w/o this patch, I was easily able to hit a data access abort using Power platform.

<...>
[   74.327662] EXT4-fs error (device loop3): ext4_mb_generate_buddy:1141: group 11, block bitmap and bg descriptor inconsistent: 21248 vs 23294 free clusters
[   74.533214] EXT4-fs (loop3): shut down requested (2)
[   74.536705] Aborting journal on device loop3-8.
[   74.702705] BUG: Unable to handle kernel data access on read at 0xc00000005e980000
[   74.703727] Faulting instruction address: 0xc0000000007bffb8
cpu 0xd: Vector: 300 (Data Access) at [c000000015db7060]
    pc: c0000000007bffb8: ext4_mb_mark_bb+0x198/0x5a0
    lr: c0000000007bfeec: ext4_mb_mark_bb+0xcc/0x5a0
    sp: c000000015db7300
   msr: 800000000280b033
   dar: c00000005e980000
 dsisr: 40000000
  current = 0xc000000027af6880
  paca    = 0xc00000003ffd5200   irqmask: 0x03   irq_happened: 0x01
    pid   = 5167, comm = mount
<...>
enter ? for help
[c000000015db7380] c000000000782708 ext4_ext_clear_bb+0x378/0x410
[c000000015db7400] c000000000813f14 ext4_fc_replay+0x1794/0x2000
[c000000015db7580] c000000000833f7c do_one_pass+0xe9c/0x12a0
[c000000015db7710] c000000000834504 jbd2_journal_recover+0x184/0x2d0
[c000000015db77c0] c000000000841398 jbd2_journal_load+0x188/0x4a0
[c000000015db7880] c000000000804de8 ext4_fill_super+0x2638/0x3e10
[c000000015db7a40] c0000000005f8404 get_tree_bdev+0x2b4/0x350
[c000000015db7ae0] c0000000007ef058 ext4_get_tree+0x28/0x40
[c000000015db7b00] c0000000005f6344 vfs_get_tree+0x44/0x100
[c000000015db7b70] c00000000063c408 path_mount+0xdd8/0xe70
[c000000015db7c40] c00000000063c8f0 sys_mount+0x450/0x550
[c000000015db7d50] c000000000035770 system_call_exception+0x4a0/0x4e0
[c000000015db7e10] c00000000000c74c system_call_common+0xec/0x250

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/2609bc8f66fc15870616ee416a18a3d392a209c4.1644992609.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 131 +++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 41a115c53bf6..15223b5a3af9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3322,72 +3322,93 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	ext4_grpblk_t blkoff;
 	int i, err;
 	int already;
-	unsigned int clen, clen_changed;
+	unsigned int clen, clen_changed, thisgrp_len;
 
-	clen = EXT4_NUM_B2C(sbi, len);
-
-	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	bitmap_bh = ext4_read_block_bitmap(sb, group);
-	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
-		bitmap_bh = NULL;
-		goto out_err;
-	}
-
-	err = -EIO;
-	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-	if (!gdp)
-		goto out_err;
+	while (len > 0) {
+		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 
-	ext4_lock_group(sb, group);
-	already = 0;
-	for (i = 0; i < clen; i++)
-		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
-			already++;
-
-	clen_changed = clen - already;
-	if (state)
-		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
-	else
-		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
-	if (ext4_has_group_desc_csum(sb) &&
-	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-		ext4_free_group_clusters_set(sb, gdp,
-					     ext4_free_clusters_after_init(sb,
-						group, gdp));
-	}
-	if (state)
-		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
-	else
-		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
+		/*
+		 * Check to see if we are freeing blocks across a group
+		 * boundary.
+		 * In case of flex_bg, this can happen that (block, len) may
+		 * span across more than one group. In that case we need to
+		 * get the corresponding group metadata to work with.
+		 * For this we have goto again loop.
+		 */
+		thisgrp_len = min_t(unsigned int, (unsigned int)len,
+			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
+		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
 
-	ext4_free_group_clusters_set(sb, gdp, clen);
-	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
-	ext4_group_desc_csum_set(sb, group, gdp);
+		bitmap_bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bitmap_bh)) {
+			err = PTR_ERR(bitmap_bh);
+			bitmap_bh = NULL;
+			break;
+		}
 
-	ext4_unlock_group(sb, group);
+		err = -EIO;
+		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+		if (!gdp)
+			break;
 
-	if (sbi->s_log_groups_per_flex) {
-		ext4_group_t flex_group = ext4_flex_group(sbi, group);
-		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
-					   s_flex_groups, flex_group);
+		ext4_lock_group(sb, group);
+		already = 0;
+		for (i = 0; i < clen; i++)
+			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+					 !state)
+				already++;
 
+		clen_changed = clen - already;
 		if (state)
-			atomic64_sub(clen_changed, &fg->free_clusters);
+			ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
 		else
-			atomic64_add(clen_changed, &fg->free_clusters);
+			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
+		if (ext4_has_group_desc_csum(sb) &&
+		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+			ext4_free_group_clusters_set(sb, gdp,
+			     ext4_free_clusters_after_init(sb, group, gdp));
+		}
+		if (state)
+			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
+		else
+			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
+
+		ext4_free_group_clusters_set(sb, gdp, clen);
+		ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+		ext4_group_desc_csum_set(sb, group, gdp);
+
+		ext4_unlock_group(sb, group);
+
+		if (sbi->s_log_groups_per_flex) {
+			ext4_group_t flex_group = ext4_flex_group(sbi, group);
+			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+						   s_flex_groups, flex_group);
+
+			if (state)
+				atomic64_sub(clen_changed, &fg->free_clusters);
+			else
+				atomic64_add(clen_changed, &fg->free_clusters);
+
+		}
+
+		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+		if (err)
+			break;
+		sync_dirty_buffer(bitmap_bh);
+		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+		sync_dirty_buffer(gdp_bh);
+		if (err)
+			break;
+
+		block += thisgrp_len;
+		len -= thisgrp_len;
+		brelse(bitmap_bh);
+		BUG_ON(len < 0);
 	}
 
-	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
 	if (err)
-		goto out_err;
-	sync_dirty_buffer(bitmap_bh);
-	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-	sync_dirty_buffer(gdp_bh);
-
-out_err:
-	brelse(bitmap_bh);
+		brelse(bitmap_bh);
 }
 
 /*
-- 
2.34.1

