Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BD3CB737
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhGPMPP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 08:15:15 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12218 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhGPMPM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 08:15:12 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GR92L00jhz1CK66;
        Fri, 16 Jul 2021 20:06:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 20:12:13 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 3/4] ext4: factor out write end code of inline file
Date:   Fri, 16 Jul 2021 20:20:23 +0800
Message-ID: <20210716122024.1105856-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210716122024.1105856-1-yi.zhang@huawei.com>
References: <20210716122024.1105856-1-yi.zhang@huawei.com>
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

Now that the inline_data file write end procedure are falled into the
common write end functions, it is not clear. Factor them out and do
some cleanup. This patch also drop ext4_da_write_inline_data_end()
and switch to use ext4_write_inline_data_end() instead because we also
need to do the same error processing if we failed to write data into
inline entry.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h   |   3 --
 fs/ext4/inline.c | 117 ++++++++++++++++++++++++-----------------------
 fs/ext4/inode.c  |  73 ++++++++++-------------------
 3 files changed, 84 insertions(+), 109 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..d4799e619048 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3530,9 +3530,6 @@ extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   unsigned flags,
 					   struct page **pagep,
 					   void **fsdata);
-extern int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
-					 unsigned len, unsigned copied,
-					 struct page *page);
 extern int ext4_try_add_inline_entry(handle_t *handle,
 				     struct ext4_filename *fname,
 				     struct inode *dir, struct inode *inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 28b666f25ac2..d30709d42a27 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -729,34 +729,76 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			       unsigned copied, struct page *page)
 {
-	int ret, no_expand;
+	handle_t *handle = ext4_journal_current_handle();
+	int no_expand;
 	void *kaddr;
 	struct ext4_iloc iloc;
+	int ret = 0, ret2;
 
 	if (unlikely(copied < len) && !PageUptodate(page))
-		return 0;
+		copied = 0;
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret) {
-		ext4_std_error(inode->i_sb, ret);
-		return ret;
-	}
+	if (likely(copied)) {
+		ret = ext4_get_inode_loc(inode, &iloc);
+		if (ret) {
+			unlock_page(page);
+			put_page(page);
+			ext4_std_error(inode->i_sb, ret);
+			goto out;
+		}
+		ext4_write_lock_xattr(inode, &no_expand);
+		BUG_ON(!ext4_has_inline_data(inode));
 
-	ext4_write_lock_xattr(inode, &no_expand);
-	BUG_ON(!ext4_has_inline_data(inode));
+		kaddr = kmap_atomic(page);
+		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
+		kunmap_atomic(kaddr);
+		SetPageUptodate(page);
+		/* clear page dirty so that writepages wouldn't work for us. */
+		ClearPageDirty(page);
 
-	kaddr = kmap_atomic(page);
-	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
-	kunmap_atomic(kaddr);
-	SetPageUptodate(page);
-	/* clear page dirty so that writepages wouldn't work for us. */
-	ClearPageDirty(page);
+		ext4_write_unlock_xattr(inode, &no_expand);
+		brelse(iloc.bh);
 
-	ext4_write_unlock_xattr(inode, &no_expand);
-	brelse(iloc.bh);
-	mark_inode_dirty(inode);
+		/*
+		 * It's important to update i_size while still holding page
+		 * lock: page writeout could otherwise come in and zero
+		 * beyond i_size.
+		 */
+		ext4_update_inode_size(inode, pos + copied);
+	}
+	unlock_page(page);
+	put_page(page);
+
+	/*
+	 * Don't mark the inode dirty under page lock. First, it unnecessarily
+	 * makes the holding time of page lock longer. Second, it forces lock
+	 * ordering of page lock and transaction start for journaling
+	 * filesystems.
+	 */
+	if (likely(copied))
+		mark_inode_dirty(inode);
+out:
+	/*
+	 * If we didn't copy as much data as expected, we need to trim back
+	 * size of xattr containing inline data.
+	 */
+	if (pos + len > inode->i_size && ext4_can_truncate(inode))
+		ext4_orphan_add(handle, inode);
 
-	return copied;
+	ret2 = ext4_journal_stop(handle);
+	if (!ret)
+		ret = ret2;
+	if (pos + len > inode->i_size) {
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If truncate failed early the inode might still be
+		 * on the orphan list; we need to make sure the inode
+		 * is removed from the orphan list in that case.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+	return ret ? ret : copied;
 }
 
 struct buffer_head *
@@ -937,43 +979,6 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	return ret;
 }
 
-int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
-				  unsigned len, unsigned copied,
-				  struct page *page)
-{
-	int ret;
-
-	ret = ext4_write_inline_data_end(inode, pos, len, copied, page);
-	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
-		return ret;
-	}
-	copied = ret;
-
-	/*
-	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold i_mutex.
-	 *
-	 * But it's important to update i_size while still holding page lock:
-	 * page writeout could otherwise come in and zero beyond i_size.
-	 */
-	if (pos+copied > inode->i_size)
-		i_size_write(inode, pos+copied);
-	unlock_page(page);
-	put_page(page);
-
-	/*
-	 * Don't mark the inode dirty under page lock. First, it unnecessarily
-	 * makes the holding time of page lock longer. Second, it forces lock
-	 * ordering of page lock and transaction start for journaling
-	 * filesystems.
-	 */
-	mark_inode_dirty(inode);
-
-	return copied;
-}
-
 #ifdef INLINE_DIR_DEBUG
 void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 			  void *inline_start, int inline_size)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5bbf9f3b8b6f..9324353fdb7b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1282,23 +1282,14 @@ static int ext4_write_end(struct file *file,
 	loff_t old_size = inode->i_size;
 	int ret = 0, ret2;
 	int i_size_changed = 0;
-	int inline_data = ext4_has_inline_data(inode);
 	bool verity = ext4_verity_in_progress(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
-	if (inline_data) {
-		ret = ext4_write_inline_data_end(inode, pos, len,
-						 copied, page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
-			goto errout;
-		}
-		copied = ret;
-		ret = 0;
-	} else
-		copied = block_write_end(file, mapping, pos,
-					 len, copied, page, fsdata);
+
+	if (ext4_has_inline_data(inode))
+		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+
+	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
 	 * it's important to update i_size while still holding page lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
@@ -1319,10 +1310,9 @@ static int ext4_write_end(struct file *file,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
-	if (i_size_changed || inline_data)
+	if (i_size_changed)
 		ret = ext4_mark_inode_dirty(handle, inode);
 
-errout:
 	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -1394,7 +1384,6 @@ static int ext4_journalled_write_end(struct file *file,
 	int partial = 0;
 	unsigned from, to;
 	int size_changed = 0;
-	int inline_data = ext4_has_inline_data(inode);
 	bool verity = ext4_verity_in_progress(inode);
 
 	trace_ext4_journalled_write_end(inode, pos, len, copied);
@@ -1403,17 +1392,10 @@ static int ext4_journalled_write_end(struct file *file,
 
 	BUG_ON(!ext4_handle_valid(handle));
 
-	if (inline_data) {
-		ret = ext4_write_inline_data_end(inode, pos, len,
-						 copied, page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
-			goto errout;
-		}
-		copied = ret;
-		ret = 0;
-	} else if (unlikely(copied < len) && !PageUptodate(page)) {
+	if (ext4_has_inline_data(inode))
+		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+
+	if (unlikely(copied < len) && !PageUptodate(page)) {
 		copied = 0;
 		ext4_journalled_zero_new_buffers(handle, page, from, to);
 	} else {
@@ -1436,13 +1418,12 @@ static int ext4_journalled_write_end(struct file *file,
 	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
 
-	if (size_changed || inline_data) {
+	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (!ret)
 			ret = ret2;
 	}
 
-errout:
 	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -3072,7 +3053,7 @@ static int ext4_da_write_end(struct file *file,
 			     struct page *page, void *fsdata)
 {
 	struct inode *inode = mapping->host;
-	int ret = 0, ret2;
+	int ret;
 	handle_t *handle = ext4_journal_current_handle();
 	loff_t new_i_size;
 	unsigned long start, end;
@@ -3083,6 +3064,12 @@ static int ext4_da_write_end(struct file *file,
 				      len, copied, page, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
+
+	if (write_mode != CONVERT_INLINE_DATA &&
+	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
+	    ext4_has_inline_data(inode))
+		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+
 	start = pos & (PAGE_SIZE - 1);
 	end = start + copied - 1;
 
@@ -3102,26 +3089,12 @@ static int ext4_da_write_end(struct file *file,
 	 * ext4_da_write_inline_data_end().
 	 */
 	new_i_size = pos + copied;
-	if (copied && new_i_size > inode->i_size) {
-		if (ext4_has_inline_data(inode) ||
-		    ext4_da_should_update_i_disksize(page, end))
-			ext4_update_i_disksize(inode, new_i_size);
-	}
-
-	if (write_mode != CONVERT_INLINE_DATA &&
-	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
-	    ext4_has_inline_data(inode))
-		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
-						     page);
-	else
-		ret = generic_write_end(file, mapping, pos, len, copied,
-							page, fsdata);
-
-	copied = ret;
-	ret2 = ext4_journal_stop(handle);
-	if (unlikely(ret2 && !ret))
-		ret = ret2;
+	if (copied && new_i_size > inode->i_size &&
+	    ext4_da_should_update_i_disksize(page, end))
+		ext4_update_i_disksize(inode, new_i_size);
 
+	copied = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = ext4_journal_stop(handle);
 	return ret ? ret : copied;
 }
 
-- 
2.31.1

