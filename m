Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90AF3FD0FB
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Sep 2021 04:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhIACBC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 22:01:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15277 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241668AbhIACBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 22:01:02 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GznLP0dGmz8D5B;
        Wed,  1 Sep 2021 09:59:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 1 Sep
 2021 10:00:02 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v5 3/3] ext4: prevent getting empty inode buffer
Date:   Wed, 1 Sep 2021 10:09:55 +0800
Message-ID: <20210901020955.1657340-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901020955.1657340-1-yi.zhang@huawei.com>
References: <20210901020955.1657340-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

  EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid

Even worse, if we allocate another inode B at the same inode block, it
will corrupt the inode A on disk when write back inode B.

So this patch initialize the inode buffer by filling the in-mem inode
contents if we skip read I/O, ensure that the buffer is really uptodate.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3c36e701e30e..a8388ec91f9f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4441,12 +4441,12 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 
 /*
  * ext4_get_inode_loc returns with an extra refcount against the inode's
- * underlying buffer_head on success. If 'in_mem' is true, we have all
- * data in memory that is needed to recreate the on-disk version of this
- * inode.
+ * underlying buffer_head on success. If we pass 'inode' and it does not
+ * have in-inode xattr, we have all inode data in memory that is needed
+ * to recreate the on-disk version of this inode.
  */
 static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
-				struct ext4_iloc *iloc, int in_mem,
+				struct inode *inode, struct ext4_iloc *iloc,
 				ext4_fsblk_t *ret_block)
 {
 	struct ext4_group_desc	*gdp;
@@ -4486,7 +4486,7 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	 * is the only valid inode in the block, we need not read the
 	 * block.
 	 */
-	if (in_mem) {
+	if (inode && !ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		struct buffer_head *bitmap_bh;
 		int i, start;
 
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
+	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL, iloc,
 					&err_blk);
 
 	if (ret == -EIO)
@@ -4591,9 +4596,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 	ext4_fsblk_t err_blk;
 	int ret;
 
-	/* We have all inode data except xattrs in memory here. */
-	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
-		!ext4_test_inode_state(inode, EXT4_STATE_XATTR), &err_blk);
+	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, inode, iloc,
+					&err_blk);
 
 	if (ret == -EIO)
 		ext4_error_inode_block(inode, err_blk, EIO,
@@ -4606,7 +4610,7 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
 			  struct ext4_iloc *iloc)
 {
-	return __ext4_get_inode_loc(sb, ino, iloc, 0, NULL);
+	return __ext4_get_inode_loc(sb, ino, NULL, iloc, NULL);
 }
 
 static bool ext4_should_enable_dax(struct inode *inode)
-- 
2.31.1

