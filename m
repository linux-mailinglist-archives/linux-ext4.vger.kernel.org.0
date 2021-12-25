Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C047F2B5
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Dec 2021 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhLYI6O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Dec 2021 03:58:14 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15974 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhLYI6N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Dec 2021 03:58:13 -0500
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JLd6V0kNVzVhMD;
        Sat, 25 Dec 2021 16:54:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 25 Dec
 2021 16:58:10 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext4: fix an use-after-free issue about data=journal writeback mode
Date:   Sat, 25 Dec 2021 17:09:37 +0800
Message-ID: <20211225090937.712867-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Our syzkaller report an use-after-free issue that accessing the freed
buffer_head on the writeback page in __ext4_journalled_writepage(). The
problem is that if there was a truncate racing with the data=journalled
writeback procedure, the writeback length could become zero and
bget_one() refuse to get buffer_head's refcount, then the truncate
procedure release buffer once we drop page lock, finally, the last
ext4_walk_page_buffers() trigger the use-after-free problem.

sync                               truncate
ext4_sync_file()
 file_write_and_wait_range()
                                   ext4_setattr(0)
                                    inode->i_size = 0
  ext4_writepage()
   len = 0
   __ext4_journalled_writepage()
    page_bufs = page_buffers(page)
    ext4_walk_page_buffers(bget_one) <- does not get refcount
                                    do_invalidatepage()
                                      free_buffer_head()
    ext4_walk_page_buffers(page_bufs) <- trigger use-after-free

After commit bdf96838aea6 ("ext4: fix race between truncate and
__ext4_journalled_writepage()"), we have already handled the racing
case, so the bget_one() and bput_one() are not needed. So this patch
simply remove these hunk, and recheck the i_size to make it safe.

Fixes: bdf96838aea6 ("ext4: fix race between truncate and __ext4_journalled_writepage()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/inode.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..cd94a70dd3d5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1844,30 +1844,16 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int bget_one(handle_t *handle, struct inode *inode,
-		    struct buffer_head *bh)
-{
-	get_bh(bh);
-	return 0;
-}
-
-static int bput_one(handle_t *handle, struct inode *inode,
-		    struct buffer_head *bh)
-{
-	put_bh(bh);
-	return 0;
-}
-
 static int __ext4_journalled_writepage(struct page *page,
 				       unsigned int len)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
-	struct buffer_head *page_bufs = NULL;
 	handle_t *handle = NULL;
 	int ret = 0, err = 0;
 	int inline_data = ext4_has_inline_data(inode);
 	struct buffer_head *inode_bh = NULL;
+	loff_t size;
 
 	ClearPageChecked(page);
 
@@ -1877,14 +1863,6 @@ static int __ext4_journalled_writepage(struct page *page,
 		inode_bh = ext4_journalled_write_inline_data(inode, len, page);
 		if (inode_bh == NULL)
 			goto out;
-	} else {
-		page_bufs = page_buffers(page);
-		if (!page_bufs) {
-			BUG();
-			goto out;
-		}
-		ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
-				       NULL, bget_one);
 	}
 	/*
 	 * We need to release the page lock before we start the
@@ -1905,7 +1883,8 @@ static int __ext4_journalled_writepage(struct page *page,
 
 	lock_page(page);
 	put_page(page);
-	if (page->mapping != mapping) {
+	size = i_size_read(inode);
+	if (page->mapping != mapping || page_offset(page) > size) {
 		/* The page got truncated from under us */
 		ext4_journal_stop(handle);
 		ret = 0;
@@ -1915,6 +1894,13 @@ static int __ext4_journalled_writepage(struct page *page,
 	if (inline_data) {
 		ret = ext4_mark_inode_dirty(handle, inode);
 	} else {
+		struct buffer_head *page_bufs = page_buffers(page);
+
+		if (page->index == size >> PAGE_SHIFT)
+			len = size & ~PAGE_MASK;
+		else
+			len = PAGE_SIZE;
+
 		ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
 					     NULL, do_journal_get_write_access);
 
@@ -1935,9 +1921,6 @@ static int __ext4_journalled_writepage(struct page *page,
 out:
 	unlock_page(page);
 out_no_pagelock:
-	if (!inline_data && page_bufs)
-		ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len,
-				       NULL, bput_one);
 	brelse(inode_bh);
 	return ret;
 }
-- 
2.31.1

