Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E46403949
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbhIHMAJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 08:00:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15395 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351594AbhIHMAI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 08:00:08 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4LD21VxXzQtjn;
        Wed,  8 Sep 2021 19:54:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 19:58:58 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH 2/3] ext4: check for inconsistent extents between index and leaf block
Date:   Wed, 8 Sep 2021 20:08:49 +0800
Message-ID: <20210908120850.4012324-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908120850.4012324-1-yi.zhang@huawei.com>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that we can check out overlapping extents in leaf block and
out-of-order index extents in index block. But the .ee_block in the
first extent of one leaf block should equal to the .ei_block in it's
parent index extent entry. This patch add a check to verify such
inconsistent between the index and leaf block.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 59 +++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4bb1153c01b3..d2601194b462 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -354,7 +354,8 @@ static int ext4_valid_extent_idx(struct inode *inode,
 
 static int ext4_valid_extent_entries(struct inode *inode,
 				     struct ext4_extent_header *eh,
-				     ext4_fsblk_t *pblk, int depth)
+				     ext4_lblk_t lblk, ext4_fsblk_t *pblk,
+				     int depth)
 {
 	unsigned short entries;
 	ext4_lblk_t lblock = 0;
@@ -368,6 +369,14 @@ static int ext4_valid_extent_entries(struct inode *inode,
 	if (depth == 0) {
 		/* leaf entries */
 		struct ext4_extent *ext = EXT_FIRST_EXTENT(eh);
+
+		/*
+		 * The logical block in the first entry should equal to
+		 * the number in the index block.
+		 */
+		if (depth != ext_depth(inode) &&
+		    lblk != le32_to_cpu(ext->ee_block))
+			return 0;
 		while (entries) {
 			if (!ext4_valid_extent(inode, ext))
 				return 0;
@@ -384,6 +393,14 @@ static int ext4_valid_extent_entries(struct inode *inode,
 		}
 	} else {
 		struct ext4_extent_idx *ext_idx = EXT_FIRST_INDEX(eh);
+
+		/*
+		 * The logical block in the first entry should equal to
+		 * the number in the parent index block.
+		 */
+		if (depth != ext_depth(inode) &&
+		    lblk != le32_to_cpu(ext_idx->ei_block))
+			return 0;
 		while (entries) {
 			if (!ext4_valid_extent_idx(inode, ext_idx))
 				return 0;
@@ -404,7 +421,7 @@ static int ext4_valid_extent_entries(struct inode *inode,
 
 static int __ext4_ext_check(const char *function, unsigned int line,
 			    struct inode *inode, struct ext4_extent_header *eh,
-			    int depth, ext4_fsblk_t pblk)
+			    int depth, ext4_fsblk_t pblk, ext4_lblk_t lblk)
 {
 	const char *error_msg;
 	int max = 0, err = -EFSCORRUPTED;
@@ -430,7 +447,7 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 		error_msg = "invalid eh_entries";
 		goto corrupted;
 	}
-	if (!ext4_valid_extent_entries(inode, eh, &pblk, depth)) {
+	if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
 		error_msg = "invalid extent entries";
 		goto corrupted;
 	}
@@ -460,7 +477,7 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 }
 
 #define ext4_ext_check(inode, eh, depth, pblk)			\
-	__ext4_ext_check(__func__, __LINE__, (inode), (eh), (depth), (pblk))
+	__ext4_ext_check(__func__, __LINE__, (inode), (eh), (depth), (pblk), 0)
 
 int ext4_ext_check_inode(struct inode *inode)
 {
@@ -493,16 +510,18 @@ static void ext4_cache_extents(struct inode *inode,
 
 static struct buffer_head *
 __read_extent_tree_block(const char *function, unsigned int line,
-			 struct inode *inode, ext4_fsblk_t pblk, int depth,
-			 int flags)
+			 struct inode *inode, struct ext4_extent_idx *idx,
+			 int depth, int flags)
 {
 	struct buffer_head		*bh;
 	int				err;
 	gfp_t				gfp_flags = __GFP_MOVABLE | GFP_NOFS;
+	ext4_fsblk_t			pblk;
 
 	if (flags & EXT4_EX_NOFAIL)
 		gfp_flags |= __GFP_NOFAIL;
 
+	pblk = ext4_idx_pblock(idx);
 	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
@@ -515,8 +534,8 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	}
 	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
 		return bh;
-	err = __ext4_ext_check(function, line, inode,
-			       ext_block_hdr(bh), depth, pblk);
+	err = __ext4_ext_check(function, line, inode, ext_block_hdr(bh),
+			       depth, pblk, le32_to_cpu(idx->ei_block));
 	if (err)
 		goto errout;
 	set_buffer_verified(bh);
@@ -534,8 +553,8 @@ __read_extent_tree_block(const char *function, unsigned int line,
 
 }
 
-#define read_extent_tree_block(inode, pblk, depth, flags)		\
-	__read_extent_tree_block(__func__, __LINE__, (inode), (pblk),   \
+#define read_extent_tree_block(inode, idx, depth, flags)		\
+	__read_extent_tree_block(__func__, __LINE__, (inode), (idx),	\
 				 (depth), (flags))
 
 /*
@@ -585,8 +604,7 @@ int ext4_ext_precache(struct inode *inode)
 			i--;
 			continue;
 		}
-		bh = read_extent_tree_block(inode,
-					    ext4_idx_pblock(path[i].p_idx++),
+		bh = read_extent_tree_block(inode, path[i].p_idx++,
 					    depth - i - 1,
 					    EXT4_EX_FORCE_CACHE);
 		if (IS_ERR(bh)) {
@@ -891,8 +909,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		path[ppos].p_depth = i;
 		path[ppos].p_ext = NULL;
 
-		bh = read_extent_tree_block(inode, path[ppos].p_block, --i,
-					    flags);
+		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
 		if (IS_ERR(bh)) {
 			ret = PTR_ERR(bh);
 			goto err;
@@ -1501,7 +1518,6 @@ static int ext4_ext_search_right(struct inode *inode,
 	struct ext4_extent_header *eh;
 	struct ext4_extent_idx *ix;
 	struct ext4_extent *ex;
-	ext4_fsblk_t block;
 	int depth;	/* Note, NOT eh_depth; depth from top of tree */
 	int ee_len;
 
@@ -1568,20 +1584,17 @@ static int ext4_ext_search_right(struct inode *inode,
 	 * follow it and find the closest allocated
 	 * block to the right */
 	ix++;
-	block = ext4_idx_pblock(ix);
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
-		bh = read_extent_tree_block(inode, block,
-					    path->p_depth - depth, 0);
+		bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
 		ix = EXT_FIRST_INDEX(eh);
-		block = ext4_idx_pblock(ix);
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, block, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2960,9 +2973,9 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			ext_debug(inode, "move to level %d (block %llu)\n",
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
-			bh = read_extent_tree_block(inode,
-				ext4_idx_pblock(path[i].p_idx), depth - i - 1,
-				EXT4_EX_NOCACHE);
+			bh = read_extent_tree_block(inode, path[i].p_idx,
+						    depth - i - 1,
+						    EXT4_EX_NOCACHE);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
-- 
2.31.1

