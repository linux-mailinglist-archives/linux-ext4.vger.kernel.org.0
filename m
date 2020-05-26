Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3481E1C03
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgEZHTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgEZHTV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4E1D8E00C4CC26B7F8E;
        Tue, 26 May 2020 15:19:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:09 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 05/10] ext4: replace sb_bread*() with ext4_sb_bread*()
Date:   Tue, 26 May 2020 15:17:49 +0800
Message-ID: <20200526071754.33819-6-yi.zhang@huawei.com>
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

For the cases of sb_bread() and sb_bread_unmovable(), we also need to
check the buffer is actually uptodate or not and fix the uptodate flag.

Add a wrapper function ext4_sb_bread_unmovable() and replace all
sb_bread*() with ext4_sb_bread*().

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h     | 17 +++++++++++++++--
 fs/ext4/indirect.c |  6 +++---
 fs/ext4/resize.c   | 12 ++++++------
 fs/ext4/super.c    | 33 +++++++++++++++++++--------------
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2ee76efd029b..609c2b555d29 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2763,8 +2763,9 @@ extern struct buffer_head *__ext4_sb_getblk_gfp(struct super_block *sb,
 						gfp_t gfp);
 extern struct buffer_head *__ext4_sb_getblk(struct super_block *sb,
 					     sector_t block, bool lock);
-extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
-					 sector_t block, int op_flags);
+extern struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
+					       sector_t block, int op_flags,
+					       gfp_t gfp);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
@@ -2969,6 +2970,18 @@ ext4_sb_getblk_locked(struct super_block *sb, sector_t block)
 	return __ext4_sb_getblk(sb, block, true);
 }
 
+static inline struct buffer_head *
+ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
+{
+	return __ext4_sb_bread_gfp(sb, block, op_flags, __GFP_MOVABLE);
+}
+
+static inline struct buffer_head *
+ext4_sb_bread_unmovable(struct super_block *sb, sector_t block)
+{
+	return __ext4_sb_bread_gfp(sb, block, 0, 0);
+}
+
 static inline int ext4_has_metadata_csum(struct super_block *sb)
 {
 	WARN_ON_ONCE(ext4_has_feature_metadata_csum(sb) &&
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 8dcbf21439c1..bd4d86211ab8 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1012,14 +1012,14 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			}
 
 			/* Go read the buffer for the next level down */
-			bh = sb_bread(inode->i_sb, nr);
+			bh = ext4_sb_bread(inode->i_sb, nr, 0);
 
 			/*
 			 * A read failure? Report error and clear slot
 			 * (should be rare).
 			 */
-			if (!bh) {
-				ext4_error_inode_block(inode, nr, EIO,
+			if (IS_ERR(bh)) {
+				ext4_error_inode_block(inode, nr, PTR_ERR(bh),
 						       "Read failure");
 				continue;
 			}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 414198e4d873..ff018e63bb55 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1806,10 +1806,10 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 			     o_blocks_count + add, add);
 
 	/* See if the device is actually as big as what was requested */
-	bh = sb_bread(sb, o_blocks_count + add - 1);
-	if (!bh) {
+	bh = ext4_sb_bread(sb, o_blocks_count + add - 1, 0);
+	if (IS_ERR(bh)) {
 		ext4_warning(sb, "can't read last block, resize aborted");
-		return -ENOSPC;
+		return PTR_ERR(bh);
 	}
 	brelse(bh);
 
@@ -1932,10 +1932,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	int meta_bg;
 
 	/* See if the device is actually as big as what was requested */
-	bh = sb_bread(sb, n_blocks_count - 1);
-	if (!bh) {
+	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
+	if (IS_ERR(bh)) {
 		ext4_warning(sb, "can't read last block, resize aborted");
-		return -ENOSPC;
+		return PTR_ERR(bh);
 	}
 	brelse(bh);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 111fff55fada..b9aab334a5d0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -194,17 +194,18 @@ __ext4_sb_getblk(struct super_block *sb, sector_t block, bool lock)
 }
 
 /*
- * This works like sb_bread() except it uses ERR_PTR for error
- * returns.  Currently with sb_bread it's impossible to distinguish
- * between ENOMEM and EIO situations (since both result in a NULL
- * return.
+ * This works like __bread_gfp() except it allow to pass op_flags and
+ * uses ERR_PTR for error returns.  Currently with sb_bread it's
+ * impossible to distinguish between ENOMEM and EIO situations (since
+ * both result in a NULL return.
  */
 struct buffer_head *
-ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
+__ext4_sb_bread_gfp(struct super_block *sb, sector_t block,
+		    int op_flags, gfp_t gfp)
 {
 	struct buffer_head *bh;
 
-	bh = ext4_sb_getblk_locked(sb, block);
+	bh = ext4_sb_getblk_locked_gfp(sb, block, gfp);
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (buffer_uptodate(bh))
@@ -3777,8 +3778,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		logical_sb_block = sb_block;
 	}
 
-	if (!(bh = sb_bread_unmovable(sb, logical_sb_block))) {
-		ext4_msg(sb, KERN_ERR, "unable to read superblock");
+	bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
+	if (IS_ERR(bh)) {
+		ext4_msg(sb, KERN_ERR,
+			 "unable to read superblock: %ld", PTR_ERR(bh));
 		goto out_fail;
 	}
 	/*
@@ -4175,10 +4178,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		brelse(bh);
 		logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset = do_div(logical_sb_block, blocksize);
-		bh = sb_bread_unmovable(sb, logical_sb_block);
-		if (!bh) {
+		bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
+		if (IS_ERR(bh)) {
 			ext4_msg(sb, KERN_ERR,
-			       "Can't read superblock on 2nd try");
+				 "Can't read superblock on 2nd try: %ld",
+				 PTR_ERR(bh));
 			goto failed_mount;
 		}
 		es = (struct ext4_super_block *)(bh->b_data + offset);
@@ -4398,10 +4402,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		struct buffer_head *bh;
 
 		block = descriptor_loc(sb, logical_sb_block, i);
-		bh = sb_bread_unmovable(sb, block);
-		if (!bh) {
+		bh = ext4_sb_bread_unmovable(sb, block);
+		if (IS_ERR(bh)) {
 			ext4_msg(sb, KERN_ERR,
-			       "can't read group descriptor %d", i);
+				 "can't read group descriptor %d: %ld",
+				 i, PTR_ERR(bh));
 			db_count = i;
 			goto failed_mount2;
 		}
-- 
2.21.3

