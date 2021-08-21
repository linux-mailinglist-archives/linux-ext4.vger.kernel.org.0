Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287CB3F3927
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHUGpM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 02:45:12 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14307 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhHUGpK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 02:45:10 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gs89s6slmz88Gs;
        Sat, 21 Aug 2021 14:44:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 14:44:28 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 2/4] ext4: remove an unnecessary if statement in __ext4_get_inode_loc()
Date:   Sat, 21 Aug 2021 14:54:48 +0800
Message-ID: <20210821065450.1397451-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210821065450.1397451-1-yi.zhang@huawei.com>
References: <20210821065450.1397451-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The "if (!buffer_uptodate(bh))" hunk covered almost the whole code after
getting buffer in __ext4_get_inode_loc() which seems unnecessary, remove
it and switch to check ext4_buffer_uptodate(), it simplify code and make
it more readable.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 162 +++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 84 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eb2526a35254..eae1b2d0b550 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4330,99 +4330,93 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
-	if (!buffer_uptodate(bh)) {
-		lock_buffer(bh);
-
-		if (ext4_buffer_uptodate(bh)) {
-			/* someone brought it uptodate while we waited */
-			unlock_buffer(bh);
-			goto has_buffer;
-		}
+	if (ext4_buffer_uptodate(bh))
+		goto has_buffer;
 
-		/*
-		 * If we have all information of the inode in memory and this
-		 * is the only valid inode in the block, we need not read the
-		 * block.
-		 */
-		if (in_mem) {
-			struct buffer_head *bitmap_bh;
-			int i, start;
+	lock_buffer(bh);
+	/*
+	 * If we have all information of the inode in memory and this
+	 * is the only valid inode in the block, we need not read the
+	 * block.
+	 */
+	if (in_mem) {
+		struct buffer_head *bitmap_bh;
+		int i, start;
 
-			start = inode_offset & ~(inodes_per_block - 1);
+		start = inode_offset & ~(inodes_per_block - 1);
 
-			/* Is the inode bitmap in cache? */
-			bitmap_bh = sb_getblk(sb, ext4_inode_bitmap(sb, gdp));
-			if (unlikely(!bitmap_bh))
-				goto make_io;
+		/* Is the inode bitmap in cache? */
+		bitmap_bh = sb_getblk(sb, ext4_inode_bitmap(sb, gdp));
+		if (unlikely(!bitmap_bh))
+			goto make_io;
 
-			/*
-			 * If the inode bitmap isn't in cache then the
-			 * optimisation may end up performing two reads instead
-			 * of one, so skip it.
-			 */
-			if (!buffer_uptodate(bitmap_bh)) {
-				brelse(bitmap_bh);
-				goto make_io;
-			}
-			for (i = start; i < start + inodes_per_block; i++) {
-				if (i == inode_offset)
-					continue;
-				if (ext4_test_bit(i, bitmap_bh->b_data))
-					break;
-			}
+		/*
+		 * If the inode bitmap isn't in cache then the
+		 * optimisation may end up performing two reads instead
+		 * of one, so skip it.
+		 */
+		if (!buffer_uptodate(bitmap_bh)) {
 			brelse(bitmap_bh);
-			if (i == start + inodes_per_block) {
-				/* all other inodes are free, so skip I/O */
-				memset(bh->b_data, 0, bh->b_size);
-				set_buffer_uptodate(bh);
-				unlock_buffer(bh);
-				goto has_buffer;
-			}
+			goto make_io;
+		}
+		for (i = start; i < start + inodes_per_block; i++) {
+			if (i == inode_offset)
+				continue;
+			if (ext4_test_bit(i, bitmap_bh->b_data))
+				break;
 		}
+		brelse(bitmap_bh);
+		if (i == start + inodes_per_block) {
+			/* all other inodes are free, so skip I/O */
+			memset(bh->b_data, 0, bh->b_size);
+			set_buffer_uptodate(bh);
+			unlock_buffer(bh);
+			goto has_buffer;
+		}
+	}
 
 make_io:
-		/*
-		 * If we need to do any I/O, try to pre-readahead extra
-		 * blocks from the inode table.
-		 */
-		blk_start_plug(&plug);
-		if (EXT4_SB(sb)->s_inode_readahead_blks) {
-			ext4_fsblk_t b, end, table;
-			unsigned num;
-			__u32 ra_blks = EXT4_SB(sb)->s_inode_readahead_blks;
-
-			table = ext4_inode_table(sb, gdp);
-			/* s_inode_readahead_blks is always a power of 2 */
-			b = block & ~((ext4_fsblk_t) ra_blks - 1);
-			if (table > b)
-				b = table;
-			end = b + ra_blks;
-			num = EXT4_INODES_PER_GROUP(sb);
-			if (ext4_has_group_desc_csum(sb))
-				num -= ext4_itable_unused_count(sb, gdp);
-			table += num / inodes_per_block;
-			if (end > table)
-				end = table;
-			while (b <= end)
-				ext4_sb_breadahead_unmovable(sb, b++);
-		}
+	/*
+	 * If we need to do any I/O, try to pre-readahead extra
+	 * blocks from the inode table.
+	 */
+	blk_start_plug(&plug);
+	if (EXT4_SB(sb)->s_inode_readahead_blks) {
+		ext4_fsblk_t b, end, table;
+		unsigned num;
+		__u32 ra_blks = EXT4_SB(sb)->s_inode_readahead_blks;
+
+		table = ext4_inode_table(sb, gdp);
+		/* s_inode_readahead_blks is always a power of 2 */
+		b = block & ~((ext4_fsblk_t) ra_blks - 1);
+		if (table > b)
+			b = table;
+		end = b + ra_blks;
+		num = EXT4_INODES_PER_GROUP(sb);
+		if (ext4_has_group_desc_csum(sb))
+			num -= ext4_itable_unused_count(sb, gdp);
+		table += num / inodes_per_block;
+		if (end > table)
+			end = table;
+		while (b <= end)
+			ext4_sb_breadahead_unmovable(sb, b++);
+	}
 
-		/*
-		 * There are other valid inodes in the buffer, this inode
-		 * has in-inode xattrs, or we don't have this inode in memory.
-		 * Read the block from disk.
-		 */
-		trace_ext4_load_inode(sb, ino);
-		ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
-		blk_finish_plug(&plug);
-		wait_on_buffer(bh);
-		ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
-		if (!buffer_uptodate(bh)) {
-			if (ret_block)
-				*ret_block = block;
-			brelse(bh);
-			return -EIO;
-		}
+	/*
+	 * There are other valid inodes in the buffer, this inode
+	 * has in-inode xattrs, or we don't have this inode in memory.
+	 * Read the block from disk.
+	 */
+	trace_ext4_load_inode(sb, ino);
+	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
+	blk_finish_plug(&plug);
+	wait_on_buffer(bh);
+	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
+	if (!buffer_uptodate(bh)) {
+		if (ret_block)
+			*ret_block = block;
+		brelse(bh);
+		return -EIO;
 	}
 has_buffer:
 	iloc->bh = bh;
-- 
2.31.1

