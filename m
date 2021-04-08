Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40953581B8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhDHL2U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 07:28:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16835 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHL2T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 07:28:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJq63ZjRz7txS;
        Thu,  8 Apr 2021 19:25:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:28:00 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/3] jbd2: do not free buffers in jbd2_journal_try_to_free_buffers()
Date:   Thu, 8 Apr 2021 19:36:17 +0800
Message-ID: <20210408113618.1033785-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210408113618.1033785-1-yi.zhang@huawei.com>
References: <20210408113618.1033785-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch move try_to_free_buffers() out from
jbd2_journal_try_to_free_buffers() to the caller function, it just check
the buffers are JBD2 journal busy or not, and the caller should invoke
try_to_free_buffers() if it want to release page.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c       |  6 ++++--
 fs/ext4/super.c       |  8 +++++---
 fs/jbd2/transaction.c | 18 ++++++++----------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..3211af9c969f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3301,6 +3301,7 @@ static void ext4_journalled_invalidatepage(struct page *page,
 static int ext4_releasepage(struct page *page, gfp_t wait)
 {
 	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
+	int ret = 0;
 
 	trace_ext4_releasepage(page);
 
@@ -3308,9 +3309,10 @@ static int ext4_releasepage(struct page *page, gfp_t wait)
 	if (PageChecked(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
-	else
+		ret = jbd2_journal_try_to_free_buffers(journal, page);
+	if (!ret)
 		return try_to_free_buffers(page);
+	return 0;
 }
 
 static bool ext4_inode_datasync_dirty(struct inode *inode)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2a33c53b57d8..02ba47a5bc70 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1450,14 +1450,16 @@ static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 				 gfp_t wait)
 {
 	journal_t *journal = EXT4_SB(sb)->s_journal;
+	int ret = 0;
 
 	WARN_ON(PageChecked(page));
 	if (!page_has_buffers(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
-
-	return try_to_free_buffers(page);
+		ret = jbd2_journal_try_to_free_buffers(journal, page);
+	if (!ret)
+		return try_to_free_buffers(page);
+	return 0;
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index b935b20cbae4..e4acc84a95fa 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2089,10 +2089,9 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * if they are fully written out ordered data, move them onto BUF_CLEAN
  * so try_to_free_buffers() can reap them.
  *
- * This function returns non-zero if we wish try_to_free_buffers()
- * to be called. We do this if the page is releasable by try_to_free_buffers().
- * We also do it if the page has locked or dirty buffers and the caller wants
- * us to perform sync or async writeout.
+ * This function returns zero if all the buffers on this page are
+ * journal cleaned and the caller should invoke try_to_free_buffers() and
+ * could release page if the page is releasable by try_to_free_buffers().
  *
  * This complicates JBD locking somewhat.  We aren't protected by the
  * BKL here.  We wish to remove the buffer from its committing or
@@ -2112,7 +2111,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
  *
- * Return 0 on failure, 1 on success
+ * Return 0 on success, -EBUSY if any buffer is still journal busy.
  */
 int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
@@ -2142,8 +2141,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 		__journal_try_to_free_buffer(journal, bh);
 		spin_unlock(&jh->b_state_lock);
 		jbd2_journal_put_journal_head(jh);
-		if (buffer_jbd(bh))
-			goto busy;
+		if (buffer_jbd(bh)) {
+			ret = -EBUSY;
+			break;
+		}
 
 		/*
 		 * If we free a metadata buffer which has been failed to
@@ -2158,9 +2159,6 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 		}
 	} while ((bh = bh->b_this_page) != head);
 
-	ret = try_to_free_buffers(page);
-
-busy:
 	if (has_write_io_error)
 		jbd2_journal_abort(journal, -EIO);
 
-- 
2.25.4

