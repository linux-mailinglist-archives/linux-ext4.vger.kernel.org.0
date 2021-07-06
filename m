Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D83BC4CA
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 04:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGFCg2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 22:36:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10303 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhGFCgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 22:36:25 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJmj11kxJz75sN;
        Tue,  6 Jul 2021 10:29:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Jul
 2021 10:33:44 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH 2/4] ext4: correct the error path of ext4_write_inline_data_end()
Date:   Tue, 6 Jul 2021 10:42:08 +0800
Message-ID: <20210706024210.746788-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706024210.746788-1-yi.zhang@huawei.com>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
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

Current error path of ext4_write_inline_data_end() is not correct.

Firstly, it should pass out the error value if ext4_get_inode_loc()
return fail, or else it could trigger infinite loop if we inject error
here. And then it's better to add inode to orphan list if it return fail
in ext4_journal_stop(), otherwise we could not restore inline xattr
entry after power failure. Finally, we need to reset the 'ret' value if
ext4_write_inline_data_end() return success in ext4_write_end() and
ext4_journalled_write_end(), otherwise we could not get the error return
value of ext4_journal_stop().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inline.c | 15 +++++----------
 fs/ext4/inode.c  |  7 +++++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 70cb64db33f7..28b666f25ac2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -733,25 +733,20 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	void *kaddr;
 	struct ext4_iloc iloc;
 
-	if (unlikely(copied < len)) {
-		if (!PageUptodate(page)) {
-			copied = 0;
-			goto out;
-		}
-	}
+	if (unlikely(copied < len) && !PageUptodate(page))
+		return 0;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret) {
 		ext4_std_error(inode->i_sb, ret);
-		copied = 0;
-		goto out;
+		return ret;
 	}
 
 	ext4_write_lock_xattr(inode, &no_expand);
 	BUG_ON(!ext4_has_inline_data(inode));
 
 	kaddr = kmap_atomic(page);
-	ext4_write_inline_data(inode, &iloc, kaddr, pos, len);
+	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
 	kunmap_atomic(kaddr);
 	SetPageUptodate(page);
 	/* clear page dirty so that writepages wouldn't work for us. */
@@ -760,7 +755,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
 	mark_inode_dirty(inode);
-out:
+
 	return copied;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6f6a61f3ae5f..4efd50a844b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1295,6 +1295,7 @@ static int ext4_write_end(struct file *file,
 			goto errout;
 		}
 		copied = ret;
+		ret = 0;
 	} else
 		copied = block_write_end(file, mapping, pos,
 					 len, copied, page, fsdata);
@@ -1321,13 +1322,14 @@ static int ext4_write_end(struct file *file,
 	if (i_size_changed || inline_data)
 		ret = ext4_mark_inode_dirty(handle, inode);
 
+errout:
 	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
 		 * inode->i_size. So truncate them
 		 */
 		ext4_orphan_add(handle, inode);
-errout:
+
 	ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
@@ -1410,6 +1412,7 @@ static int ext4_journalled_write_end(struct file *file,
 			goto errout;
 		}
 		copied = ret;
+		ret = 0;
 	} else if (unlikely(copied < len) && !PageUptodate(page)) {
 		copied = 0;
 		ext4_journalled_zero_new_buffers(handle, page, from, to);
@@ -1439,6 +1442,7 @@ static int ext4_journalled_write_end(struct file *file,
 			ret = ret2;
 	}
 
+errout:
 	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -1446,7 +1450,6 @@ static int ext4_journalled_write_end(struct file *file,
 		 */
 		ext4_orphan_add(handle, inode);
 
-errout:
 	ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
-- 
2.31.1

