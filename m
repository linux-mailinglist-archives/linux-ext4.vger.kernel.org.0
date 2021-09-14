Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC140B79F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Sep 2021 21:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhINTMt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Sep 2021 15:12:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51813 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233038AbhINTMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Sep 2021 15:12:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18EJBB6o024798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:11:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D957B15C3424; Tue, 14 Sep 2021 15:11:11 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] resize2fs: optimize resize2fs_calculate_summary_stats()
Date:   Tue, 14 Sep 2021 15:11:04 -0400
Message-Id: <20210914191104.2283033-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210914191104.2283033-1-tytso@mit.edu>
References: <20210914191104.2283033-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Speed up an off-line resize of a 10GB file system to 64TB located on
tmpfs from 90 seconds to 16 seconds by extracting block group bitmaps
using a population count function to count the blocks in use instead
checking each bit in the block bitmap.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 resize/resize2fs.c | 74 ++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 5ed0c9ee..f7ffaac5 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -2844,67 +2844,39 @@ errout:
  */
 static errcode_t resize2fs_calculate_summary_stats(ext2_filsys fs)
 {
-	blk64_t		blk;
+	errcode_t	retval;
+	blk64_t		blk = fs->super->s_first_data_block;
 	ext2_ino_t	ino;
-	unsigned int	group = 0;
-	unsigned int	count = 0;
+	unsigned int	n, c, group, count;
 	blk64_t		total_blocks_free = 0;
 	int		total_inodes_free = 0;
 	int		group_free = 0;
 	int		uninit = 0;
-	blk64_t		super_blk, old_desc_blk, new_desc_blk;
-	int		old_desc_blocks;
+	char		*bitmap_buf;
 
 	/*
 	 * First calculate the block statistics
 	 */
-	uninit = ext2fs_bg_flags_test(fs, group, EXT2_BG_BLOCK_UNINIT);
-	ext2fs_super_and_bgd_loc2(fs, group, &super_blk, &old_desc_blk,
-				  &new_desc_blk, 0);
-	if (ext2fs_has_feature_meta_bg(fs->super))
-		old_desc_blocks = fs->super->s_first_meta_bg;
-	else
-		old_desc_blocks = fs->desc_blocks +
-			fs->super->s_reserved_gdt_blocks;
-	for (blk = B2C(fs->super->s_first_data_block);
-	     blk < ext2fs_blocks_count(fs->super);
-	     blk += EXT2FS_CLUSTER_RATIO(fs)) {
-		if ((uninit &&
-		     !(EQ_CLSTR(blk, super_blk) ||
-		       ((old_desc_blk && old_desc_blocks &&
-			 GE_CLSTR(blk, old_desc_blk) &&
-			 LT_CLSTR(blk, old_desc_blk + old_desc_blocks))) ||
-		       ((new_desc_blk && EQ_CLSTR(blk, new_desc_blk))) ||
-		       EQ_CLSTR(blk, ext2fs_block_bitmap_loc(fs, group)) ||
-		       EQ_CLSTR(blk, ext2fs_inode_bitmap_loc(fs, group)) ||
-		       ((GE_CLSTR(blk, ext2fs_inode_table_loc(fs, group)) &&
-			 LT_CLSTR(blk, ext2fs_inode_table_loc(fs, group)
-				  + fs->inode_blocks_per_group))))) ||
-		    (!ext2fs_fast_test_block_bitmap2(fs->block_map, blk))) {
-			group_free++;
-			total_blocks_free++;
-		}
-		count++;
-		if ((count == fs->super->s_clusters_per_group) ||
-		    EQ_CLSTR(blk, ext2fs_blocks_count(fs->super)-1)) {
-			ext2fs_bg_free_blocks_count_set(fs, group, group_free);
-			ext2fs_group_desc_csum_set(fs, group);
-			group++;
-			if (group >= fs->group_desc_count)
-				break;
-			count = 0;
-			group_free = 0;
-			uninit = ext2fs_bg_flags_test(fs, group, EXT2_BG_BLOCK_UNINIT);
-			ext2fs_super_and_bgd_loc2(fs, group, &super_blk,
-						  &old_desc_blk,
-						  &new_desc_blk, 0);
-			if (ext2fs_has_feature_meta_bg(fs->super))
-				old_desc_blocks = fs->super->s_first_meta_bg;
-			else
-				old_desc_blocks = fs->desc_blocks +
-					fs->super->s_reserved_gdt_blocks;
+	bitmap_buf = malloc(fs->blocksize);
+	if (!bitmap_buf)
+		return ENOMEM;
+	for (group = 0; group < fs->group_desc_count;
+	     group++) {
+		retval = ext2fs_get_block_bitmap_range2(fs->block_map,
+			C2B(blk), fs->super->s_clusters_per_group, bitmap_buf);
+		if (retval) {
+			free(bitmap_buf);
+			return retval;
 		}
-	}
+		n = ext2fs_bitcount(bitmap_buf,
+				    fs->super->s_clusters_per_group / 8);
+		group_free = fs->super->s_clusters_per_group - n;
+		total_blocks_free += group_free;
+		ext2fs_bg_free_blocks_count_set(fs, group, group_free);
+		ext2fs_group_desc_csum_set(fs, group);
+		blk += EXT2FS_NUM_B2C(fs, fs->super->s_clusters_per_group);
+	}
+	free(bitmap_buf);
 	total_blocks_free = C2B(total_blocks_free);
 	ext2fs_free_blocks_count_set(fs->super, total_blocks_free);
 
-- 
2.31.0

