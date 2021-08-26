Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7283F8824
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbhHZMzF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 08:55:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8782 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbhHZMyt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 08:54:49 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwN7V3M6LzYtBh;
        Thu, 26 Aug 2021 20:53:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 26
 Aug 2021 20:54:00 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v4 6/6] ext4: prevent getting empty inode buffer
Date:   Thu, 26 Aug 2021 21:04:12 +0800
Message-ID: <20210826130412.3921207-7-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826130412.3921207-1-yi.zhang@huawei.com>
References: <20210826130412.3921207-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
inode buffer when the inode monopolize an inode block for performance
reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
buffer to make it fine, but we could miss this call if something bad
happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
empty inode buffer and trigger ext4 error.

For example, if we remove a nonexistent xattr on inode A,
ext4_xattr_set_handle() will return ENODATA before invoking
ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
will get checksum error message in ext4_iget() when getting inode again.

  EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat:
iget: checksum invalid

Even worse, if we allocate another inode B at the same inode block, it
will corrupt the inode A on disk when write back inode B.

So this patch initialize the inode buffer by filling the in-mem inode
contents if we skip read I/O, ensure that the buffer is really uptodate.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3c36e701e30e..8b37f55b04ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4446,8 +4446,8 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
  * inode.
  */
 static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
-				struct ext4_iloc *iloc, int in_mem,
-				ext4_fsblk_t *ret_block)
+				struct inode *inode, struct ext4_iloc *iloc,
+				int in_mem, ext4_fsblk_t *ret_block)
 {
 	struct ext4_group_desc	*gdp;
 	struct buffer_head	*bh;
@@ -4514,8 +4514,13 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		}
 		brelse(bitmap_bh);
 		if (i == start + inodes_per_block) {
+			struct ext4_inode *raw_inode =
+				(struct ext4_inode *) (bh->b_data + iloc->offset);
+
 			/* all other inodes are free, so skip I/O */
 			memset(bh->b_data, 0, bh->b_size);
+			if (!ext4_test_inode_state(inode, EXT4_STATE_NEW))
+				ext4_fill_raw_inode(inode, raw_inode);
 			set_buffer_uptodate(bh);
 			unlock_buffer(bh);
 			goto has_buffer;
@@ -4576,7 +4581,7 @@ static int __ext4_get_inode_loc_noinmem(struct inode *inode,
 	ext4_fsblk_t err_blk;
 	int ret;
 
-	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc, 0,
+	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL, iloc, 0,
 					&err_blk);
 
 	if (ret == -EIO)
@@ -4592,8 +4597,13 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 	int ret;
 
 	/* We have all inode data except xattrs in memory here. */
-	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
-		!ext4_test_inode_state(inode, EXT4_STATE_XATTR), &err_blk);
+	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
+		ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL,
+					   iloc, false, &err_blk);
+	} else {
+		ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, inode,
+					   iloc, true, &err_blk);
+	}
 
 	if (ret == -EIO)
 		ext4_error_inode_block(inode, err_blk, EIO,
@@ -4606,7 +4616,7 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
 			  struct ext4_iloc *iloc)
 {
-	return __ext4_get_inode_loc(sb, ino, iloc, 0, NULL);
+	return __ext4_get_inode_loc(sb, ino, NULL, iloc, 0, NULL);
 }
 
 static bool ext4_should_enable_dax(struct inode *inode)
-- 
2.31.1

