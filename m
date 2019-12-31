Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29D912DACA
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLaSGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfLaSGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5930206E4
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815561;
        bh=e7ACdQo2fnfmJK+6lxMvmOKfQ172Hl5KZ2CUDEZ55HY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r9mN2kL3zo+N+b6PUpsJa5AnezoRlu09CYyIurFYaJTQ5hlXR51V2n8VkwcL6Zcgm
         j6enEo2SrUG7sMOln8Mizxh10eqNJp7vFM+q58z3r0f9AaqezHBWp+X/m7ttL5eZkB
         Dotq0lg+ajo/YLzhtOdFAkXWcNXsL143UCDavCqo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/8] ext4: remove ext4_{ind,ext}_calc_metadata_amount()
Date:   Tue, 31 Dec 2019 12:04:37 -0600
Message-Id: <20191231180444.46586-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Remove the ext4_ind_calc_metadata_amount() and
ext4_ext_calc_metadata_amount() functions, which have been unused since
commit 71d4f7d03214 ("ext4: remove metadata reservation checks").

Also remove the i_da_metadata_calc_last_lblock and
i_da_metadata_calc_len fields from struct ext4_inode_info, as these were
only used by these removed functions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h     |  5 -----
 fs/ext4/extents.c  | 47 ----------------------------------------------
 fs/ext4/indirect.c | 26 -------------------------
 fs/ext4/super.c    |  2 --
 4 files changed, 80 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..0fdc913b0d6c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1052,8 +1052,6 @@ struct ext4_inode_info {
 	/* allocation reservation info for delalloc */
 	/* In case of bigalloc, this refer to clusters rather than blocks */
 	unsigned int i_reserved_data_blocks;
-	ext4_lblk_t i_da_metadata_calc_last_lblock;
-	int i_da_metadata_calc_len;
 
 	/* pending cluster reservations for bigalloc file systems */
 	struct ext4_pending_tree i_pending_tree;
@@ -2628,7 +2626,6 @@ extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 				struct ext4_map_blocks *map, int flags);
-extern int ext4_ind_calc_metadata_amount(struct inode *inode, sector_t lblock);
 extern int ext4_ind_trans_blocks(struct inode *inode, int nrblocks);
 extern void ext4_ind_truncate(handle_t *, struct inode *inode);
 extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
@@ -3271,8 +3268,6 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
-extern int ext4_ext_calc_metadata_amount(struct inode *inode,
-					 ext4_lblk_t lblocks);
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fee19c9f5fe3..c6c89e38f43a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -309,53 +309,6 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 			(nofail ? EXT4_GET_BLOCKS_METADATA_NOFAIL:0));
 }
 
-/*
- * Calculate the number of metadata blocks needed
- * to allocate @blocks
- * Worse case is one block per extent
- */
-int ext4_ext_calc_metadata_amount(struct inode *inode, ext4_lblk_t lblock)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	int idxs;
-
-	idxs = ((inode->i_sb->s_blocksize - sizeof(struct ext4_extent_header))
-		/ sizeof(struct ext4_extent_idx));
-
-	/*
-	 * If the new delayed allocation block is contiguous with the
-	 * previous da block, it can share index blocks with the
-	 * previous block, so we only need to allocate a new index
-	 * block every idxs leaf blocks.  At ldxs**2 blocks, we need
-	 * an additional index block, and at ldxs**3 blocks, yet
-	 * another index blocks.
-	 */
-	if (ei->i_da_metadata_calc_len &&
-	    ei->i_da_metadata_calc_last_lblock+1 == lblock) {
-		int num = 0;
-
-		if ((ei->i_da_metadata_calc_len % idxs) == 0)
-			num++;
-		if ((ei->i_da_metadata_calc_len % (idxs*idxs)) == 0)
-			num++;
-		if ((ei->i_da_metadata_calc_len % (idxs*idxs*idxs)) == 0) {
-			num++;
-			ei->i_da_metadata_calc_len = 0;
-		} else
-			ei->i_da_metadata_calc_len++;
-		ei->i_da_metadata_calc_last_lblock++;
-		return num;
-	}
-
-	/*
-	 * In the worst case we need a new set of index blocks at
-	 * every level of the inode's extent tree.
-	 */
-	ei->i_da_metadata_calc_len = 1;
-	ei->i_da_metadata_calc_last_lblock = lblock;
-	return ext_depth(inode) + 1;
-}
-
 static int
 ext4_ext_max_entries(struct inode *inode, int depth)
 {
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 3a4ab70fe9e0..569fc68e8975 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -659,32 +659,6 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	return err;
 }
 
-/*
- * Calculate the number of metadata blocks need to reserve
- * to allocate a new block at @lblocks for non extent file based file
- */
-int ext4_ind_calc_metadata_amount(struct inode *inode, sector_t lblock)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	sector_t dind_mask = ~((sector_t)EXT4_ADDR_PER_BLOCK(inode->i_sb) - 1);
-	int blk_bits;
-
-	if (lblock < EXT4_NDIR_BLOCKS)
-		return 0;
-
-	lblock -= EXT4_NDIR_BLOCKS;
-
-	if (ei->i_da_metadata_calc_len &&
-	    (lblock & dind_mask) == ei->i_da_metadata_calc_last_lblock) {
-		ei->i_da_metadata_calc_len++;
-		return 0;
-	}
-	ei->i_da_metadata_calc_last_lblock = lblock & dind_mask;
-	ei->i_da_metadata_calc_len = 1;
-	blk_bits = order_base_2(lblock);
-	return (blk_bits / EXT4_ADDR_PER_BLOCK_BITS(inode->i_sb)) + 1;
-}
-
 /*
  * Calculate number of indirect blocks touched by mapping @nrblocks logically
  * contiguous blocks
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2937a8873fe1..518e74b93548 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1085,8 +1085,6 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_es_shk_nr = 0;
 	ei->i_es_shrink_lblk = 0;
 	ei->i_reserved_data_blocks = 0;
-	ei->i_da_metadata_calc_len = 0;
-	ei->i_da_metadata_calc_last_lblock = 0;
 	spin_lock_init(&(ei->i_block_reservation_lock));
 	ext4_init_pending_tree(&ei->i_pending_tree);
 #ifdef CONFIG_QUOTA
-- 
2.24.1

