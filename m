Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5037D1E1C00
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgEZHTT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgEZHTT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 07F43683536799CDC3DC;
        Tue, 26 May 2020 15:19:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:08 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 04/10] ext4: replace sb_getblk() with ext4_sb_getblk_locked()
Date:   Tue, 26 May 2020 15:17:48 +0800
Message-ID: <20200526071754.33819-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For the read buffer cases, now we invoke sb_getblk() and submit read
bio if the buffer is not uptodate, but the uptodate checking is not
accurate which may lead to read old metadata from the disk if the
buffer has been failed to write out.

Replace all sb_getblk() with ext4_sb_getblk_locked(), this function
will check and fix the buffer's uptodate flag if it has write io error
flag, and lock the buffer if it is actually not uptodate, so the caller
don't need to lock the buffer after ext4_sb_getblk_locked() return.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/balloc.c   |  6 ++++--
 fs/ext4/extents.c  |  5 +++--
 fs/ext4/ialloc.c   |  6 ++++--
 fs/ext4/indirect.c |  4 ++--
 fs/ext4/inode.c    | 23 ++++-------------------
 fs/ext4/resize.c   |  4 ++--
 fs/ext4/super.c    |  7 ++++---
 7 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a32e5f7b5385..806959644247 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -433,14 +433,15 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
-	bh = sb_getblk(sb, bitmap_blk);
+	bh = ext4_sb_getblk_locked(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_warning(sb, "Cannot get buffer for block bitmap - "
 			     "block_group = %u, block_bitmap = %llu",
 			     block_group, bitmap_blk);
 		return ERR_PTR(-ENOMEM);
 	}
-
+	if (!buffer_uptodate(bh))
+		goto submit;
 	if (bitmap_uptodate(bh))
 		goto verify;
 
@@ -449,6 +450,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 		unlock_buffer(bh);
 		goto verify;
 	}
+submit:
 	ext4_lock_group(sb, block_group);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..5db76b46fad5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -488,11 +488,12 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	struct buffer_head		*bh;
 	int				err;
 
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = ext4_sb_getblk_locked_gfp(inode->i_sb, pblk,
+				       __GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
-	if (!bh_uptodate_or_lock(bh)) {
+	if (!buffer_uptodate(bh)) {
 		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
 		err = bh_submit_read(bh);
 		if (err < 0)
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 4b8c9a9bdf0c..a386b9126101 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -137,13 +137,15 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
-	bh = sb_getblk(sb, bitmap_blk);
+	bh = ext4_sb_getblk_locked(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_warning(sb, "Cannot read inode bitmap - "
 			     "block_group = %u, inode_bitmap = %llu",
 			     block_group, bitmap_blk);
 		return ERR_PTR(-ENOMEM);
 	}
+	if (!buffer_uptodate(bh))
+		goto submit;
 	if (bitmap_uptodate(bh))
 		goto verify;
 
@@ -152,7 +154,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 		unlock_buffer(bh);
 		goto verify;
 	}
-
+submit:
 	ext4_lock_group(sb, block_group);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 107f0043f67f..8dcbf21439c1 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -156,13 +156,13 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 	if (!p->key)
 		goto no_block;
 	while (--depth) {
-		bh = sb_getblk(sb, le32_to_cpu(p->key));
+		bh = ext4_sb_getblk_locked(sb, le32_to_cpu(p->key));
 		if (unlikely(!bh)) {
 			ret = -ENOMEM;
 			goto failure;
 		}
 
-		if (!bh_uptodate_or_lock(bh)) {
+		if (!buffer_uptodate(bh)) {
 			if (bh_submit_read(bh) < 0) {
 				put_bh(bh);
 				goto failure;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e0f7e824b3b9..c374870f6bb1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4276,27 +4276,10 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
 	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
 
-	bh = sb_getblk(sb, block);
+	bh = ext4_sb_getblk_locked(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
 	if (!buffer_uptodate(bh)) {
-		lock_buffer(bh);
-
-		/*
-		 * If the buffer has the write error flag, we have failed
-		 * to write out another inode in the same block.  In this
-		 * case, we don't have to read the block because we may
-		 * read the old inode data successfully.
-		 */
-		if (buffer_write_io_error(bh) && !buffer_uptodate(bh))
-			set_buffer_uptodate(bh);
-
-		if (buffer_uptodate(bh)) {
-			/* someone brought it uptodate while we waited */
-			unlock_buffer(bh);
-			goto has_buffer;
-		}
-
 		/*
 		 * If we have all information of the inode in memory and this
 		 * is the only valid inode in the block, we need not read the
@@ -4309,7 +4292,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 			start = inode_offset & ~(inodes_per_block - 1);
 
 			/* Is the inode bitmap in cache? */
-			bitmap_bh = sb_getblk(sb, ext4_inode_bitmap(sb, gdp));
+			bitmap_bh = ext4_sb_getblk_locked(sb,
+						ext4_inode_bitmap(sb, gdp));
 			if (unlikely(!bitmap_bh))
 				goto make_io;
 
@@ -4319,6 +4303,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 			 * of one, so skip it.
 			 */
 			if (!buffer_uptodate(bitmap_bh)) {
+				unlock_buffer(bitmap_bh);
 				brelse(bitmap_bh);
 				goto make_io;
 			}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a50b51270ea9..414198e4d873 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1239,10 +1239,10 @@ static int ext4_add_new_descs(handle_t *handle, struct super_block *sb,
 
 static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
 {
-	struct buffer_head *bh = sb_getblk(sb, block);
+	struct buffer_head *bh = ext4_sb_getblk_locked(sb, block);
 	if (unlikely(!bh))
 		return NULL;
-	if (!bh_uptodate_or_lock(bh)) {
+	if (!buffer_uptodate(bh)) {
 		if (bh_submit_read(bh) < 0) {
 			brelse(bh);
 			return NULL;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ddc46dbcd5ce..111fff55fada 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -202,13 +202,14 @@ __ext4_sb_getblk(struct super_block *sb, sector_t block, bool lock)
 struct buffer_head *
 ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 {
-	struct buffer_head *bh = sb_getblk(sb, block);
+	struct buffer_head *bh;
 
+	bh = ext4_sb_getblk_locked(sb, block);
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
-	if (ext4_buffer_uptodate(bh))
+	if (buffer_uptodate(bh))
 		return bh;
-	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
+	ll_rw_one_block(REQ_OP_READ, REQ_META | op_flags, bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
 		return bh;
-- 
2.21.3

