Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726921E1C04
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgEZHTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4899 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731340AbgEZHTW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0434FCE7620702D08BEF;
        Tue, 26 May 2020 15:19:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:11 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 09/10] ext4: abort the filesystem while freeing the write error io buffer
Date:   Tue, 26 May 2020 15:17:53 +0800
Message-ID: <20200526071754.33819-10-yi.zhang@huawei.com>
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

Now we can prevent reading old metadata buffer from the disk which has
been failed to write out through checking write io error when getting
the buffer. One more thing need to do is to prevent freeing the write
io error buffer. If the buffer was freed, we lose the latest data and
buffer stats, finally it will also lead to inconsistency.

So, this patch abort the journal in journal mode and invoke
ext4_error_err() in nojournal mode to prevent further inconsistency.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/super.c       | 32 +++++++++++++++++++++++++++++++-
 fs/jbd2/transaction.c | 13 +++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d25a0fe44bec..1e15179aa1c4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1349,6 +1349,36 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
 	return ext4_write_inode(inode, &wbc);
 }
 
+static int bdev_try_to_free_buffer(struct super_block *sb, struct page *page)
+{
+	struct buffer_head *head, *bh;
+	bool has_write_io_error = false;
+
+	head = page_buffers(page);
+	bh = head;
+	do {
+		/*
+		 * If the buffer has been failed to write out, the metadata
+		 * in this buffer is uptodate but which on disk is old, may
+		 * lead to inconsistency while reading the old data
+		 * successfully.
+		 */
+		if (buffer_write_io_error(bh) && !buffer_uptodate(bh)) {
+			has_write_io_error = true;
+			break;
+		}
+	} while ((bh = bh->b_this_page) != head);
+
+	if (has_write_io_error)
+		ext4_error_err(sb, EIO, "Free metadata buffer (%llu) that has "
+			       "been failed to write out. There is a risk of "
+			       "filesystem inconsistency in case of reading "
+			       "metadata from this block subsequently.",
+			       (unsigned long long) bh->b_blocknr);
+
+	return try_to_free_buffers(page);
+}
+
 /*
  * Try to release metadata pages (indirect blocks, directories) which are
  * mapped via the block device.  Since these pages could have journal heads
@@ -1366,7 +1396,7 @@ static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 	if (journal)
 		return jbd2_journal_try_to_free_buffers(journal, page,
 						wait & ~__GFP_DIRECT_RECLAIM);
-	return try_to_free_buffers(page);
+	return bdev_try_to_free_buffer(sb, page);
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3dccc23cf010..ac6a077afec3 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2109,6 +2109,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
+	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2133,11 +2134,23 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 		jbd2_journal_put_journal_head(jh);
 		if (buffer_jbd(bh))
 			goto busy;
+
+		/*
+		 * If the buffer has been failed to write out, the metadata
+		 * in this buffer is uptodate but which on disk is old,
+		 * abort journal to prevent subsequent inconsistency while
+		 * reading the old data successfully.
+		 */
+		if (buffer_write_io_error(bh) && !buffer_uptodate(bh))
+			has_write_io_error = true;
 	} while ((bh = bh->b_this_page) != head);
 
 	ret = try_to_free_buffers(page);
 
 busy:
+	if (has_write_io_error)
+		jbd2_journal_abort(journal, -EIO);
+
 	return ret;
 }
 
-- 
2.21.3

