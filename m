Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A203C95B4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jul 2021 03:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhGOBtb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 21:49:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11305 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhGOBta (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jul 2021 21:49:30 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQHDH0yHKz7tZ3;
        Thu, 15 Jul 2021 09:42:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 09:46:36 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 1/4] ext4: check and update i_disksize properly
Date:   Thu, 15 Jul 2021 09:54:49 +0800
Message-ID: <20210715015452.2542505-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715015452.2542505-1-yi.zhang@huawei.com>
References: <20210715015452.2542505-1-yi.zhang@huawei.com>
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

After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
isize"), i_disksize could always be updated to i_size in ext4_setattr(),
and we could sure that i_disksize <= i_size since holding inode lock and
if i_disksize < i_size there are delalloc writes pending in the range
upto i_size. If the end of the current write is <= i_size, there's no
need to touch i_disksize since writeback will push i_disksize upto
i_size eventually. So we can switch to check i_size instead of
i_disksize in ext4_da_write_end() when write to the end of the file.
we also could remove ext4_mark_inode_dirty() together because we defer
inode dirtying to generic_write_end() or ext4_da_write_inline_data_end().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..dca8e3810443 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3084,35 +3084,37 @@ static int ext4_da_write_end(struct file *file,
 	end = start + copied - 1;
 
 	/*
-	 * generic_write_end() will run mark_inode_dirty() if i_size
-	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
-	 * into that.
+	 * Since we are holding inode lock, we are sure i_disksize <=
+	 * i_size. We also know that if i_disksize < i_size, there are
+	 * delalloc writes pending in the range upto i_size. If the end of
+	 * the current write is <= i_size, there's no need to touch
+	 * i_disksize since writeback will push i_disksize upto i_size
+	 * eventually. If the end of the current write is > i_size and
+	 * inside an allocated block (ext4_da_should_update_i_disksize()
+	 * check), we need to update i_disksize here as neither
+	 * ext4_writepage() nor certain ext4_writepages() paths not
+	 * allocating blocks update i_disksize.
+	 *
+	 * Note that we defer inode dirtying to generic_write_end() /
+	 * ext4_da_write_inline_data_end().
 	 */
 	new_i_size = pos + copied;
-	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
+	if (copied && new_i_size > inode->i_size) {
 		if (ext4_has_inline_data(inode) ||
-		    ext4_da_should_update_i_disksize(page, end)) {
+		    ext4_da_should_update_i_disksize(page, end))
 			ext4_update_i_disksize(inode, new_i_size);
-			/* We need to mark inode dirty even if
-			 * new_i_size is less that inode->i_size
-			 * bu greater than i_disksize.(hint delalloc)
-			 */
-			ret = ext4_mark_inode_dirty(handle, inode);
-		}
 	}
 
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
-		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
+		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
 						     page);
 	else
-		ret2 = generic_write_end(file, mapping, pos, len, copied,
+		ret = generic_write_end(file, mapping, pos, len, copied,
 							page, fsdata);
 
-	copied = ret2;
-	if (ret2 < 0)
-		ret = ret2;
+	copied = ret;
 	ret2 = ext4_journal_stop(handle);
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
-- 
2.31.1

