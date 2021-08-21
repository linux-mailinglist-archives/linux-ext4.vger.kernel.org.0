Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862643F3928
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhHUGpL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 02:45:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8757 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhHUGpK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 02:45:10 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gs89Y2z5DzYrvc;
        Sat, 21 Aug 2021 14:44:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 14:44:28 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 4/4] ext4: prevent getting empty inode buffer
Date:   Sat, 21 Aug 2021 14:54:50 +0800
Message-ID: <20210821065450.1397451-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210821065450.1397451-1-yi.zhang@huawei.com>
References: <20210821065450.1397451-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

So this patch postpone the initialization and mark buffer uptodate logic
until shortly before we fill correct inode data in ext4_do_update_inode()
if skip read I/O, ensure the buffer is really uptodate.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8323d3e8f393..000abb5696b0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4367,9 +4367,12 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		}
 		brelse(bitmap_bh);
 		if (i == start + inodes_per_block) {
-			/* all other inodes are free, so skip I/O */
-			memset(bh->b_data, 0, bh->b_size);
-			set_buffer_uptodate(bh);
+			/*
+			 * All other inodes are free, skip I/O. Return
+			 * uninitialized buffer immediately, initialization
+			 * is postponed until shortly before we fill inode
+			 * contents.
+			 */
 			unlock_buffer(bh);
 			goto has_buffer;
 		}
@@ -5028,6 +5031,24 @@ static int ext4_do_update_inode(handle_t *handle,
 	gid_t i_gid;
 	projid_t i_projid;
 
+	/*
+	 * If the buffer is not uptodate, it means all information of the
+	 * inode is in memory and we got this buffer without reading the
+	 * block. We must be cautious that once we mark the buffer as
+	 * uptodate, we rely on filling in the correct inode data later
+	 * in this function. Otherwise if we left uptodate buffer without
+	 * copying proper inode contents, we could corrupt the inode on
+	 * disk after allocating another inode in the same block.
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
 
 	/*
-- 
2.31.1

