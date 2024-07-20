Return-Path: <linux-ext4+bounces-3336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A629381E5
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599AC1C21658
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2E144D21;
	Sat, 20 Jul 2024 15:53:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B061304AB;
	Sat, 20 Jul 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490836; cv=none; b=XeSK5gGqnqiCoghFjo1NMjdfpVnGvLaj2x7hAUU6x7XS3MFE5L6KSiiA1+k8ped/3+cpcJ3qMsHnuCrP8SOd5kiukVUcMtRsH5r4b17Ur7kc7KQ1tW7y6iSPn9P6Z4ubhuNKUU+p2akCIhrBNManGT9Es9u4HHifPhWkLxCMVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490836; c=relaxed/simple;
	bh=blw9D1LR99bgljEVdKIjewDAwaBTODrPRMO4kFwWmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQw4Ul1pVAxHrNsJ2QrGKrWd3S8uRoxKvKOVy+MV43O3My7onGpEva/Jbf6/ErKiYjoErFMQg2WvqJHnIuRp1PWgFakQclas8kHzGiBGHmr7q1RvNMrAbNfnWFTFrq2uP6mLHcL850jmXuE+/6W8ZzebaO4VcwnRQXxCW6YTIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp84t1721490820t2br6czg
X-QQ-Originating-IP: WsZIj1MEyDcmp6p/m9u+7NJzty0/9QyMFTqeV6/0QEQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Jul 2024 23:53:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17886644706957566695
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yi.zhang@huawei.com
Cc: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	niecheng1@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 3/4] ext4: factor out write end code of inline file
Date: Sat, 20 Jul 2024 23:52:02 +0800
Message-ID: <4FE3D7C60FFE378C+20240720155234.573790-4-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240720155234.573790-1-wangyuli@uniontech.com>
References: <20240720155234.573790-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Zhang Yi <yi.zhang@huawei.com>

Now that the inline_data file write end procedure are falled into the
common write end functions, it is not clear. Factor them out and do
some cleanup. This patch also drop ext4_da_write_inline_data_end()
and switch to use ext4_write_inline_data_end() instead because we also
need to do the same error processing if we failed to write data into
inline entry.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20210716122024.1105856-4-yi.zhang@huawei.com
Reviewed-by: Cheng Nie <niecheng1@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/ext4/ext4.h   |   3 --
 fs/ext4/inline.c | 127 ++++++++++++++++++++++++-----------------------
 fs/ext4/inode.c  |  74 +++++++++------------------
 3 files changed, 89 insertions(+), 115 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fa2579abea7d..6394c8a3803c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3083,9 +3083,6 @@ extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
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
index de04bd5fb551..eeb696c85a61 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -741,40 +741,82 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
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
 
-	/*
-	 * ei->i_inline_off may have changed since ext4_write_begin()
-	 * called ext4_try_to_write_inline_data()
-	 */
-	(void) ext4_find_inline_data_nolock(inode);
+		/*
+		 * ei->i_inline_off may have changed since ext4_write_begin()
+		 * called ext4_try_to_write_inline_data()
+		 */
+		(void) ext4_find_inline_data_nolock(inode);
 
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
 
-	return copied;
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
+
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
@@ -955,43 +997,6 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
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
index 44a715e6aae1..1e6753084a00 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1415,23 +1415,13 @@ static int ext4_write_end(struct file *file,
 	loff_t old_size = inode->i_size;
 	int ret = 0, ret2;
 	int i_size_changed = 0;
-	int inline_data = ext4_has_inline_data(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
-	if (inline_data &&
-	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
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
@@ -1448,10 +1438,9 @@ static int ext4_write_end(struct file *file,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
-	if (i_size_changed || inline_data)
+	if (i_size_changed)
 		ext4_mark_inode_dirty(handle, inode);
 
-errout:
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -1523,7 +1512,6 @@ static int ext4_journalled_write_end(struct file *file,
 	int partial = 0;
 	unsigned from, to;
 	int size_changed = 0;
-	int inline_data = ext4_has_inline_data(inode);
 
 	trace_ext4_journalled_write_end(inode, pos, len, copied);
 	from = pos & (PAGE_SIZE - 1);
@@ -1531,17 +1519,10 @@ static int ext4_journalled_write_end(struct file *file,
 
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
@@ -1563,13 +1544,12 @@ static int ext4_journalled_write_end(struct file *file,
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 
-	if (size_changed || inline_data) {
+	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (!ret)
 			ret = ret2;
 	}
 
-errout:
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -3195,7 +3175,7 @@ static int ext4_da_write_end(struct file *file,
 			     struct page *page, void *fsdata)
 {
 	struct inode *inode = mapping->host;
-	int ret = 0, ret2;
+	int ret;
 	handle_t *handle = ext4_journal_current_handle();
 	loff_t new_i_size;
 	unsigned long start, end;
@@ -3206,6 +3186,12 @@ static int ext4_da_write_end(struct file *file,
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
 
@@ -3225,26 +3211,12 @@ static int ext4_da_write_end(struct file *file,
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
-	if (!ret)
-		ret = ret2;
+	if (copied && new_i_size > inode->i_size &&
+	    ext4_da_should_update_i_disksize(page, end))
+		ext4_update_i_disksize(inode, new_i_size);
 
+	copied = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = ext4_journal_stop(handle);
 	return ret ? ret : copied;
 }
 
-- 
2.43.4


