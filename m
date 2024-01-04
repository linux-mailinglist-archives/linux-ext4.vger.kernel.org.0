Return-Path: <linux-ext4+bounces-699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20D82438B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E381C2099E
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0524B41;
	Thu,  4 Jan 2024 14:17:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0824A14;
	Thu,  4 Jan 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T5TCj6PV3z29jXp;
	Thu,  4 Jan 2024 22:16:17 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id B50271A0172;
	Thu,  4 Jan 2024 22:17:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 22:17:44 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v3 8/8] ext4: mark the group block bitmap as corrupted before reporting an error
Date: Thu, 4 Jan 2024 22:20:40 +0800
Message-ID: <20240104142040.2835097-9-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240104142040.2835097-1-libaokun1@huawei.com>
References: <20240104142040.2835097-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Otherwise unlocking the group in ext4_grp_locked_error may allow other
processes to modify the core block bitmap that is known to be corrupt.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 90fcf22db098..e2a63cf854a8 100644
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
@@ -1934,12 +1934,12 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
 		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 		blocknr += EXT4_C2B(sbi, block);
+		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		ext4_grp_locked_error(sb, e4b->bd_group,
 				      inode ? inode->i_ino : 0, blocknr,
 				      "freeing already freed block (bit %u); block bitmap corrupt.",
 				      block);
-		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
-				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return;
 	}
 
@@ -2412,12 +2412,12 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 
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
@@ -2468,12 +2468,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
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
 
@@ -2499,12 +2499,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
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


