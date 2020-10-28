Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8111C29DCFE
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 01:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgJ2AeR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 20:34:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6983 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgJ1WUo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 18:20:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CLd586NyCzhchM;
        Wed, 28 Oct 2020 13:52:28 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 13:52:15 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>, <adilger@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>
Subject: [PATCH] ext4: do not use extent after put_bh
Date:   Wed, 28 Oct 2020 13:56:17 +0800
Message-ID: <20201028055617.2569255-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_ext_search_right will read more extent block and call put_bh after
we get the information we need. However ret_ex will break this and may
cause use-after-free once pagecache has been freed. Fix it by dup the
extent we need.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 559100f3e23c..4ba8131a5629 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1471,16 +1471,16 @@ static int ext4_ext_search_left(struct inode *inode,
 }
 
 /*
- * search the closest allocated block to the right for *logical
- * and returns it at @logical + it's physical address at @phys
- * if *logical is the largest allocated block, the function
- * returns 0 at @phys
- * return value contains 0 (success) or error code
+ * Search the closest allocated block to the right for *logical
+ * and returns it at @logical + it's physical address at @phys.
+ * If not exists, return 0 and @phys is set to 0. We will return
+ * 1 which means we found that and ret_ex may be valid. Or return
+ * the error code.
  */
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent **ret_ex)
+				 struct ext4_extent *ret_ex)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1574,10 +1574,11 @@ static int ext4_ext_search_right(struct inode *inode,
 found_extent:
 	*logical = le32_to_cpu(ex->ee_block);
 	*phys = ext4_ext_pblock(ex);
-	*ret_ex = ex;
+	if (ret_ex)
+		*ret_ex = *ex;
 	if (bh)
 		put_bh(bh);
-	return 0;
+	return 1;
 }
 
 /*
@@ -2868,8 +2869,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    &ex);
-			if (err)
+						    NULL);
+			if (err < 0)
 				goto out;
 			if (pblk) {
 				partial.pclu = EXT4_B2C(sbi, pblk);
@@ -4039,7 +4040,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			struct ext4_map_blocks *map, int flags)
 {
 	struct ext4_ext_path *path = NULL;
-	struct ext4_extent newex, *ex, *ex2;
+	struct ext4_extent newex, *ex, ex2;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_fsblk_t newblock = 0, pblk;
 	int err = 0, depth, ret;
@@ -4175,15 +4176,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	ex2 = NULL;
 	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
-	if (err)
+	if (err < 0)
 		goto out;
 
 	/* Check if the extent after searching to the right implies a
 	 * cluster we can use. */
-	if ((sbi->s_cluster_ratio > 1) && ex2 &&
-	    get_implied_cluster_alloc(inode->i_sb, map, ex2, path)) {
+	if ((sbi->s_cluster_ratio > 1) && err &&
+	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		goto got_allocated_blocks;
-- 
2.25.4

