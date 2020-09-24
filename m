Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F7276AD0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIXHcu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbgIXHct (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E64DF2D350F5F98635B;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:40 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 7/7] ext4: introduce ext4_sb_bread_unmovable() to replace sb_bread_unmovable()
Date:   Thu, 24 Sep 2020 15:33:37 +0800
Message-ID: <20200924073337.861472-8-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924073337.861472-1-yi.zhang@huawei.com>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now we only use sb_bread_unmovable() to read superblock and descriptor
block at mount time, so there is no opportunity that we need to clear
buffer verified bit and also handle buffer write_io error bit. But for
the sake of unification, let's introduce ext4_sb_bread_unmovable() to
replace all sb_bread_unmovable(). After this patch, we stop using read
helpers in fs/buffer.c.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6da1419f6ee7..28b135a536b5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2824,6 +2824,8 @@ extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
 /* super.c */
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, int op_flags);
+extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
+						   sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
 				bh_end_io_t *end_io);
 extern int ext4_read_bh(struct buffer_head *bh, int op_flags,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b24e68eff48d..2b5b6033b8e6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -204,18 +204,19 @@ int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait)
 }
 
 /*
- * This works like sb_bread() except it uses ERR_PTR for error
+ * This works like __bread_gfp() except it uses ERR_PTR for error
  * returns.  Currently with sb_bread it's impossible to distinguish
  * between ENOMEM and EIO situations (since both result in a NULL
  * return.
  */
-struct buffer_head *
-ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
+static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
+					       sector_t block, int op_flags,
+					       gfp_t gfp)
 {
 	struct buffer_head *bh;
 	int ret;
 
-	bh = sb_getblk(sb, block);
+	bh = sb_getblk_gfp(sb, block, gfp);
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (ext4_buffer_uptodate(bh))
@@ -229,6 +230,18 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 	return bh;
 }
 
+struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
+				   int op_flags)
+{
+	return __ext4_sb_bread_gfp(sb, block, op_flags, __GFP_MOVABLE);
+}
+
+struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
+					    sector_t block)
+{
+	return __ext4_sb_bread_gfp(sb, block, 0, 0);
+}
+
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
@@ -3943,8 +3956,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		logical_sb_block = sb_block;
 	}
 
-	if (!(bh = sb_bread_unmovable(sb, logical_sb_block))) {
+	bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
+	if (IS_ERR(bh)) {
 		ext4_msg(sb, KERN_ERR, "unable to read superblock");
+		ret = PTR_ERR(bh);
+		bh = NULL;
 		goto out_fail;
 	}
 	/*
@@ -4340,10 +4356,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		brelse(bh);
 		logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset = do_div(logical_sb_block, blocksize);
-		bh = sb_bread_unmovable(sb, logical_sb_block);
-		if (!bh) {
+		bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
+		if (IS_ERR(bh)) {
 			ext4_msg(sb, KERN_ERR,
 			       "Can't read superblock on 2nd try");
+			ret = PTR_ERR(bh);
+			bh = NULL;
 			goto failed_mount;
 		}
 		es = (struct ext4_super_block *)(bh->b_data + offset);
@@ -4562,11 +4580,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		struct buffer_head *bh;
 
 		block = descriptor_loc(sb, logical_sb_block, i);
-		bh = sb_bread_unmovable(sb, block);
-		if (!bh) {
+		bh = ext4_sb_bread_unmovable(sb, block);
+		if (IS_ERR(bh)) {
 			ext4_msg(sb, KERN_ERR,
 			       "can't read group descriptor %d", i);
 			db_count = i;
+			ret = PTR_ERR(bh);
+			bh = NULL;
 			goto failed_mount2;
 		}
 		rcu_read_lock();
-- 
2.25.4

