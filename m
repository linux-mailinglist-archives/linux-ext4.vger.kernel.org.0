Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D891E1C05
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgEZHTX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgEZHTW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10D071020B11556A5CFD;
        Tue, 26 May 2020 15:19:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:09 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 06/10] ext4: replace sb_getblk() with ext4_sb_getblk()
Date:   Tue, 26 May 2020 15:17:50 +0800
Message-ID: <20200526071754.33819-7-yi.zhang@huawei.com>
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

For the cases of newly allocated block and get block for write buffer,
checking the buffer's write_io_error and uptodate flag is optional.
Replace all sb_getblk() with ext4_sb_getblk(), it works the same as
before.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/extents.c  | 8 +++++---
 fs/ext4/indirect.c | 3 ++-
 fs/ext4/inline.c   | 2 +-
 fs/ext4/inode.c    | 2 +-
 fs/ext4/mmp.c      | 2 +-
 fs/ext4/resize.c   | 8 ++++----
 fs/ext4/xattr.c    | 2 +-
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 5db76b46fad5..25a7a8389291 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1066,7 +1066,8 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		err = -EFSCORRUPTED;
 		goto cleanup;
 	}
-	bh = sb_getblk_gfp(inode->i_sb, newblock, __GFP_MOVABLE | GFP_NOFS);
+	bh = ext4_sb_getblk_gfp(inode->i_sb, newblock,
+				__GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh)) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -1143,7 +1144,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	while (k--) {
 		oldblock = newblock;
 		newblock = ablocks[--a];
-		bh = sb_getblk(inode->i_sb, newblock);
+		bh = ext4_sb_getblk(inode->i_sb, newblock);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			goto cleanup;
@@ -1270,7 +1271,8 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 	if (newblock == 0)
 		return err;
 
-	bh = sb_getblk_gfp(inode->i_sb, newblock, __GFP_MOVABLE | GFP_NOFS);
+	bh = ext4_sb_getblk_gfp(inode->i_sb, newblock,
+				__GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh))
 		return -ENOMEM;
 	lock_buffer(bh);
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index bd4d86211ab8..e4c2a8e1afbb 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -347,7 +347,8 @@ static int ext4_alloc_branch(handle_t *handle,
 		if (i == 0)
 			continue;
 
-		bh = branch[i].bh = sb_getblk(ar->inode->i_sb, new_blocks[i-1]);
+		bh = branch[i].bh = ext4_sb_getblk(ar->inode->i_sb,
+						   new_blocks[i-1]);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			goto failed;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f35e289e17aa..94424ea011a5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1216,7 +1216,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 		goto out_restore;
 	}
 
-	data_bh = sb_getblk(inode->i_sb, map.m_pblk);
+	data_bh = ext4_sb_getblk(inode->i_sb, map.m_pblk);
 	if (!data_bh) {
 		error = -ENOMEM;
 		goto out_restore;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c374870f6bb1..97dc77ec7c3e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -829,7 +829,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	bh = sb_getblk(inode->i_sb, map.m_pblk);
+	bh = ext4_sb_getblk(inode->i_sb, map.m_pblk);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index d34cb8c46655..2aa1dbe44e9d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -78,7 +78,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 	 * that the MD RAID device cache has been bypassed, and that the read
 	 * is not blocked in the elevator. */
 	if (!*bh) {
-		*bh = sb_getblk(sb, mmp_block);
+		*bh = ext4_sb_getblk(sb, mmp_block);
 		if (!*bh) {
 			ret = -ENOMEM;
 			goto warn_exit;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index ff018e63bb55..27073c715228 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -400,7 +400,7 @@ static struct buffer_head *bclean(handle_t *handle, struct super_block *sb,
 	struct buffer_head *bh;
 	int err;
 
-	bh = sb_getblk(sb, blk);
+	bh = ext4_sb_getblk(sb, blk);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	BUFFER_TRACE(bh, "get_write_access");
@@ -464,7 +464,7 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 		if (err < 0)
 			return err;
 
-		bh = sb_getblk(sb, flex_gd->groups[group].block_bitmap);
+		bh = ext4_sb_getblk(sb, flex_gd->groups[group].block_bitmap);
 		if (unlikely(!bh))
 			return -ENOMEM;
 
@@ -557,7 +557,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 			if (err < 0)
 				goto out;
 
-			gdb = sb_getblk(sb, block);
+			gdb = ext4_sb_getblk(sb, block);
 			if (unlikely(!gdb)) {
 				err = -ENOMEM;
 				goto out;
@@ -1130,7 +1130,7 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 			backup_block = (ext4_group_first_block_no(sb, group) +
 					ext4_bg_has_super(sb, group));
 
-		bh = sb_getblk(sb, backup_block);
+		bh = ext4_sb_getblk(sb, backup_block);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			break;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 21df43a25328..e2ba4e631b02 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2056,7 +2056,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			ea_idebug(inode, "creating block %llu",
 				  (unsigned long long)block);
 
-			new_bh = sb_getblk(sb, block);
+			new_bh = ext4_sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
 				error = -ENOMEM;
 getblk_failed:
-- 
2.21.3

