Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA571E1C08
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgEZHTY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731286AbgEZHTX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 346004A210CCFCF742F8;
        Tue, 26 May 2020 15:19:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:10 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 07/10] ext4: switch to use ext4_sb_getblk_locked() in ext4_getblk()
Date:   Tue, 26 May 2020 15:17:51 +0800
Message-ID: <20200526071754.33819-8-yi.zhang@huawei.com>
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

For the cases of getting blocks for reading in ext4_getblk()
(e.g. ext4_bread() and ext4_bread_batch()), they are also need to check
the write io error flag before read. Switch to use ext4_sb_getblk_locked()
instead.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  3 ++-
 fs/ext4/inode.c | 22 +++++++++++++---------
 fs/ext4/xattr.c |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 609c2b555d29..81c1bdfb9397 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2642,7 +2642,8 @@ extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
 int ext4_inode_is_fast_symlink(struct inode *inode);
-struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
+struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
+				ext4_lblk_t block, bool lock, int map_flags);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
 int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 		     bool wait, struct buffer_head **bhs);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97dc77ec7c3e..4989a9633fc7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -811,7 +811,8 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
-				ext4_lblk_t block, int map_flags)
+				ext4_lblk_t block, bool lock,
+				int map_flags)
 {
 	struct ext4_map_blocks map;
 	struct buffer_head *bh;
@@ -829,7 +830,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	bh = ext4_sb_getblk(inode->i_sb, map.m_pblk);
+	bh = __ext4_sb_getblk(inode->i_sb, map.m_pblk,
+			      lock && !(map.m_flags & EXT4_MAP_NEW));
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
@@ -872,12 +874,12 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 {
 	struct buffer_head *bh;
 
-	bh = ext4_getblk(handle, inode, block, map_flags);
+	bh = ext4_getblk(handle, inode, block, true, map_flags);
 	if (IS_ERR(bh))
 		return bh;
-	if (!bh || ext4_buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return bh;
-	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
+	ll_rw_one_block(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
 		return bh;
@@ -892,7 +894,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 	int i, err;
 
 	for (i = 0; i < bh_count; i++) {
-		bhs[i] = ext4_getblk(NULL, inode, block + i, 0 /* map_flags */);
+		bhs[i] = ext4_getblk(NULL, inode, block + i, true, 0);
 		if (IS_ERR(bhs[i])) {
 			err = PTR_ERR(bhs[i]);
 			bh_count = i;
@@ -902,9 +904,9 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
-			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
-				    &bhs[i]);
+		if (bhs[i] && !buffer_uptodate(bhs[i]))
+			ll_rw_one_block(REQ_OP_READ, REQ_META | REQ_PRIO,
+					bhs[i]);
 
 	if (!wait)
 		return 0;
@@ -923,6 +925,8 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 out_brelse:
 	for (i = 0; i < bh_count; i++) {
+		if (bhs[i] && buffer_locked(bhs[i]))
+			unlock_buffer(bhs[i]);
 		brelse(bhs[i]);
 		bhs[i] = NULL;
 	}
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e2ba4e631b02..828a23a0e772 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1358,7 +1358,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 			brelse(bh);
 		csize = (bufsize - wsize) > blocksize ? blocksize :
 								bufsize - wsize;
-		bh = ext4_getblk(handle, ea_inode, block, 0);
+		bh = ext4_getblk(handle, ea_inode, block, false, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		if (!bh) {
-- 
2.21.3

