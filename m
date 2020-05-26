Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC11E1C07
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgEZHTY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730426AbgEZHTV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 087809FD67E4CC8E91E9;
        Tue, 26 May 2020 15:19:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:10 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 08/10] ext4: replace sb_breadahead() with ext4_sb_breadahead()
Date:   Tue, 26 May 2020 15:17:52 +0800
Message-ID: <20200526071754.33819-9-yi.zhang@huawei.com>
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

For the cases of read ahead blocks, we also need to check the write io
error flag to prevent reading block from disk if it is actually
uptodate. Add a new wrapper ext4_sb_breadahead() to check the uptodate
flag and prevent unnecessary read operation, and replace all
sb_breadahead().

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 11 +++++------
 fs/ext4/inode.c |  2 +-
 fs/ext4/super.c | 19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 81c1bdfb9397..cafa2617a093 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2767,6 +2767,8 @@ extern struct buffer_head *__ext4_sb_getblk(struct super_block *sb,
 extern struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 					       sector_t block, int op_flags,
 					       gfp_t gfp);
+extern void ext4_sb_breadahead_unmovable(struct super_block *sb,
+					 sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
@@ -3533,13 +3535,10 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 {
 	/*
 	 * If the buffer has the write error flag, we have failed
-	 * to write out data in the block.  In this  case, we don't
-	 * have to read the block because we may read the old data
-	 * successfully.
+	 * to write out this metadata block. In this case, the data
+	 * in this block is uptodate.
 	 */
-	if (!buffer_uptodate(bh) && buffer_write_io_error(bh))
-		set_buffer_uptodate(bh);
-	return buffer_uptodate(bh);
+	return buffer_uptodate(bh) || buffer_write_io_error(bh);
 }
 
 #endif	/* __KERNEL__ */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4989a9633fc7..7354edb444c5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4351,7 +4351,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 			if (end > table)
 				end = table;
 			while (b <= end)
-				sb_breadahead_unmovable(sb, b++);
+				ext4_sb_breadahead_unmovable(sb, b++);
 		}
 
 		/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9aab334a5d0..d25a0fe44bec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -218,6 +218,23 @@ __ext4_sb_bread_gfp(struct super_block *sb, sector_t block,
 	return ERR_PTR(-EIO);
 }
 
+/*
+ * This works like sb_breadahead_unmovable() except it use
+ * ext4_buffer_uptodate() instead of buffer_uptodate() to check the
+ * metadata buffer is actually uptodate or not. The buffer should be
+ * considered as actually uptodate for the case of it has been
+ * failed to write out.
+ */
+void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
+{
+	struct buffer_head *bh = ext4_sb_getblk_gfp(sb, block, 0);
+
+	if (likely(bh) && !ext4_buffer_uptodate(bh)) {
+		ll_rw_block(REQ_OP_READ, REQ_META | REQ_RAHEAD, 1, &bh);
+		brelse(bh);
+	}
+}
+
 static int ext4_verify_csum_type(struct super_block *sb,
 				 struct ext4_super_block *es)
 {
@@ -4395,7 +4412,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	/* Pre-read the descriptors into the buffer cache */
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logical_sb_block, i);
-		sb_breadahead_unmovable(sb, block);
+		ext4_sb_breadahead_unmovable(sb, block);
 	}
 
 	for (i = 0; i < db_count; i++) {
-- 
2.21.3

