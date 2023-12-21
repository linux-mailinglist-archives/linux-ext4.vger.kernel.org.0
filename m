Return-Path: <linux-ext4+bounces-540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4081BA27
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826411C25B1D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF4627F0;
	Thu, 21 Dec 2023 15:02:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CD37168;
	Thu, 21 Dec 2023 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SwtvM1GGXzsSd5;
	Thu, 21 Dec 2023 23:02:23 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id BD5B218001D;
	Thu, 21 Dec 2023 23:02:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 23:02:41 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v2 8/8] ext4: mark the group block bitmap as corrupted before reporting an error
Date: Thu, 21 Dec 2023 23:05:58 +0800
Message-ID: <20231221150558.2740823-9-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231221150558.2740823-1-libaokun1@huawei.com>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Otherwise unlocking the group in ext4_grp_locked_error may allow other
processes to modify the core block bitmap that is known to be corrupt.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b862ca2750fd..c43eefebdaa3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -564,14 +564,14 @@ static void mb_free_blocks_double(struct inode *inode, struct ext4_buddy *e4b,
 
 			blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 			blocknr += EXT4_C2B(EXT4_SB(sb), first + i);
+			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			ext4_grp_locked_error(sb, e4b->bd_group,
 					      inode ? inode->i_ino : 0,
 					      blocknr,
 					      "freeing block already freed "
 					      "(bit %u)",
 					      first + i);
-			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
-					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		}
 		mb_clear_bit(first + i, e4b->bd_info->bb_bitmap);
 	}
@@ -1926,14 +1926,13 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 		blocknr += EXT4_C2B(sbi, block);
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
+			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			ext4_grp_locked_error(sb, e4b->bd_group,
 					      inode ? inode->i_ino : 0,
 					      blocknr,
 					      "freeing already freed block (bit %u); block bitmap corrupt.",
 					      block);
-			ext4_mark_group_bitmap_corrupted(
-				sb, e4b->bd_group,
-				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		} else {
 			mb_regenerate_buddy(e4b);
 			goto check;
@@ -2410,12 +2409,12 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 
 		k = mb_find_next_zero_bit(buddy, max, 0);
 		if (k >= max) {
+			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
+					e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			ext4_grp_locked_error(ac->ac_sb, e4b->bd_group, 0, 0,
 				"%d free clusters of order %d. But found 0",
 				grp->bb_counters[i], i);
-			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
-					 e4b->bd_group,
-					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			break;
 		}
 		ac->ac_found++;
@@ -2466,12 +2465,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			 * free blocks even though group info says we
 			 * have free blocks
 			 */
+			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
 					"%d free clusters as per "
 					"group info. But bitmap says 0",
 					free);
-			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
-					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			break;
 		}
 
@@ -2497,12 +2496,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 		if (WARN_ON(ex.fe_len <= 0))
 			break;
 		if (free < ex.fe_len) {
+			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
 					"%d free clusters as per "
 					"group info. But got %d blocks",
 					free, ex.fe_len);
-			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
-					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 			/*
 			 * The number of free blocks differs. This mostly
 			 * indicate that the bitmap is corrupt. So exit
-- 
2.31.1


