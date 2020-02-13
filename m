Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55C15B9AC
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 07:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgBMGjh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 01:39:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbgBMGjh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 01:39:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50EF229A9E062636A5FA;
        Thu, 13 Feb 2020 14:39:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 14:39:26 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <jack@suse.cz>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <luoshijie1@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH v3 2/2] jbd2: do not clear the BH_Mapped flag when forgetting a metadata buffer
Date:   Thu, 13 Feb 2020 14:38:21 +0800
Message-ID: <20200213063821.30455-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200213063821.30455-1-yi.zhang@huawei.com>
References: <20200213063821.30455-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from
an older transaction") set the BH_Freed flag when forgetting a metadata
buffer which belongs to the committing transaction, it indicate the
committing process clear dirty bits when it is done with the buffer. But
it also clear the BH_Mapped flag at the same time, which may trigger
below NULL pointer oops when block_size < PAGE_SIZE.

rmdir 1             kjournald2                 mkdir 2
                    jbd2_journal_commit_transaction
		    commit transaction N
jbd2_journal_forget
set_buffer_freed(bh1)
                    jbd2_journal_commit_transaction
                     commit transaction N+1
                     ...
                     clear_buffer_mapped(bh1)
                                               ext4_getblk(bh2 ummapped)
                                               ...
                                               grow_dev_page
                                                init_page_buffers
                                                 bh1->b_private=NULL
                                                 bh2->b_private=NULL
                     jbd2_journal_put_journal_head(jh1)
                      __journal_remove_journal_head(hb1)
		       jh1 is NULL and trigger oops

*) Dir entry block bh1 and bh2 belongs to one page, and the bh2 has
   already been unmapped.

For the metadata buffer we forgetting, we should always keep the mapped
flag and clear the dirty flags is enough, so this patch pick out the
these buffers and keep their BH_Mapped flag.

Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/commit.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6396fe70085b..27373f5792a4 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -985,12 +985,29 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 * pagesize and it is attached to the last partial page.
 		 */
 		if (buffer_freed(bh) && !jh->b_next_transaction) {
+			struct address_space *mapping;
+
 			clear_buffer_freed(bh);
 			clear_buffer_jbddirty(bh);
-			clear_buffer_mapped(bh);
-			clear_buffer_new(bh);
-			clear_buffer_req(bh);
-			bh->b_bdev = NULL;
+
+			/*
+			 * Block device buffers need to stay mapped all the
+			 * time, so it is enough to clear buffer_jbddirty and
+			 * buffer_freed bits. For the file mapping buffers (i.e.
+			 * journalled data) we need to unmap buffer and clear
+			 * more bits. We also need to be careful about the check
+			 * because the data page mapping can get cleared under
+			 * out hands, which alse need not to clear more bits
+			 * because the page and buffers will be freed and can
+			 * never be reused once we are done with them.
+			 */
+			mapping = READ_ONCE(bh->b_page->mapping);
+			if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
+				clear_buffer_mapped(bh);
+				clear_buffer_new(bh);
+				clear_buffer_req(bh);
+				bh->b_bdev = NULL;
+			}
 		}
 
 		if (buffer_jbddirty(bh)) {
-- 
2.17.2

