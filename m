Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C663F13C2
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhHSGrP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 02:47:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17048 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhHSGrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 02:47:13 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqwF66vCdzbfMl;
        Thu, 19 Aug 2021 14:42:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 14:46:35 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 4/4] ext4: prevent getting empty inode buffer
Date:   Thu, 19 Aug 2021 14:57:04 +0800
Message-ID: <20210819065704.1248402-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819065704.1248402-1-yi.zhang@huawei.com>
References: <20210819065704.1248402-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

So this patch postpone the init and mark buffer uptodate logic until
before filling correct inode data in ext4_do_update_inode() if skip read
I/O, ensure the buffer is real uptodate.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0d7a5295bf9..02d910c9d8f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4367,9 +4367,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		}
 		brelse(bitmap_bh);
 		if (i == start + inodes_per_block) {
-			/* all other inodes are free, so skip I/O */
-			memset(bh->b_data, 0, bh->b_size);
-			set_buffer_uptodate(bh);
+			/*
+			 * All other inodes are free, skip I/O. Return
+			 * un-inited buffer (which is postponed until
+			 * before filling inode data) immediately.
+			 */
 			unlock_buffer(bh);
 			goto has_buffer;
 		}
@@ -5026,6 +5028,24 @@ static int ext4_do_update_inode(handle_t *handle,
 	gid_t i_gid;
 	projid_t i_projid;
 
+	/*
+	 * If the buffer is not uptodate, it means all information of inode
+	 * in memory and we got this buffer without reading the block. We
+	 * must be cautious that once we mark the buffer as uptodate, we
+	 * rely on filling in the correct inode data later in this function.
+	 * Otherwise if we getting the left falsepositive buffer when
+	 * creating other inode on the same block, it could corrupt the
+	 * inode data on disk.
+	 */
+	if (!buffer_uptodate(bh)) {
+		lock_buffer(bh);
+		if (!buffer_uptodate(bh)) {
+			memset(bh->b_data, 0, bh->b_size);
+			set_buffer_uptodate(bh);
+		}
+		unlock_buffer(bh);
+	}
+
 	spin_lock(&ei->i_raw_lock);
 
 	/* For fields not tracked in the in-memory inode,
-- 
2.31.1

