Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38E21E1C06
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEZHTX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730430AbgEZHTW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0CA94D9F7D1941A1AC8D;
        Tue, 26 May 2020 15:19:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:11 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 10/10] ext4: remove unused parameter in jbd2_journal_try_to_free_buffers()
Date:   Tue, 26 May 2020 15:17:54 +0800
Message-ID: <20200526071754.33819-11-yi.zhang@huawei.com>
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

gfp_mask in jbd2_journal_try_to_free_buffers() is no longer used after
commit 536fc240e7147 ("jbd2: clean up jbd2_journal_try_to_free_buffers()"),
just remove it.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/inode.c       | 2 +-
 fs/ext4/super.c       | 4 ++--
 fs/jbd2/transaction.c | 7 +------
 include/linux/jbd2.h  | 3 ++-
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7354edb444c5..8adde60c9b02 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3293,7 +3293,7 @@ static int ext4_releasepage(struct page *page, gfp_t wait)
 	if (PageChecked(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page, wait);
+		return jbd2_journal_try_to_free_buffers(journal, page);
 	else
 		return try_to_free_buffers(page);
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1e15179aa1c4..8a84f52fd67c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1394,8 +1394,8 @@ static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 	if (!page_has_buffers(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page,
-						wait & ~__GFP_DIRECT_RECLAIM);
+		return jbd2_journal_try_to_free_buffers(journal, page);
+
 	return bdev_try_to_free_buffer(sb, page);
 }
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ac6a077afec3..c3ecefdb3abd 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2070,10 +2070,6 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * int jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
- * @gfp_mask: we use the mask to detect how hard should we try to release
- * buffers. If __GFP_DIRECT_RECLAIM and __GFP_FS is set, we wait for commit
- * code to release the buffers.
- *
  *
  * For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
@@ -2104,8 +2100,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  *
  * Return 0 on failure, 1 on success
  */
-int jbd2_journal_try_to_free_buffers(journal_t *journal,
-				struct page *page, gfp_t gfp_mask)
+int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..230bb7767180 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1376,7 +1376,8 @@ extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
-extern int	 jbd2_journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
+extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal,
+						  struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
 extern int	 jbd2_journal_flush (journal_t *);
 extern void	 jbd2_journal_lock_updates (journal_t *);
-- 
2.21.3

