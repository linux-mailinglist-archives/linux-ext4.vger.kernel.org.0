Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1464B150804
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2020 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBCOGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Feb 2020 09:06:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbgBCOGO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Feb 2020 09:06:14 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C5F56262F3DF42470F2;
        Mon,  3 Feb 2020 22:06:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Feb 2020
 22:06:02 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <jack@suse.cz>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <luoshijie1@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 2/2] jbd2: do not clear the BH_Mapped flag when forgetting a metadata buffer
Date:   Mon, 3 Feb 2020 22:04:58 +0800
Message-ID: <20200203140458.37397-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200203140458.37397-1-yi.zhang@huawei.com>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
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

For the metadata buffer we forgetting, clear the dirty flags is enough,
so this patch add BH_Unmap flag for the journal_unmap_buffer() case and
keep the mapped flag for the metadata buffer.

Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/commit.c      | 11 +++++++----
 fs/jbd2/transaction.c |  1 +
 include/linux/jbd2.h  |  2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6396fe70085b..a649cdd1c5e5 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -987,10 +987,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (buffer_freed(bh) && !jh->b_next_transaction) {
 			clear_buffer_freed(bh);
 			clear_buffer_jbddirty(bh);
-			clear_buffer_mapped(bh);
-			clear_buffer_new(bh);
-			clear_buffer_req(bh);
-			bh->b_bdev = NULL;
+			if (buffer_unmap(bh)) {
+				clear_buffer_unmap(bh);
+				clear_buffer_mapped(bh);
+				clear_buffer_new(bh);
+				clear_buffer_req(bh);
+				bh->b_bdev = NULL;
+			}
 		}
 
 		if (buffer_jbddirty(bh)) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a479cbf8ae54..717964eec9d3 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2335,6 +2335,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 		 * should clear dirty bits when it is done with the buffer.
 		 */
 		set_buffer_freed(bh);
+		set_buffer_unmap(bh);
 		if (journal->j_running_transaction && buffer_jbddirty(bh))
 			jh->b_next_transaction = journal->j_running_transaction;
 		may_free = 0;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..f74906ebc73a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -310,6 +310,7 @@ enum jbd_state_bits {
 	  = BH_PrivateStart,
 	BH_JWrite,		/* Being written to log (@@@ DEBUGGING) */
 	BH_Freed,		/* Has been freed (truncated) */
+	BH_Unmap,		/* Has been freed and need to unmap */
 	BH_Revoked,		/* Has been revoked from the log */
 	BH_RevokeValid,		/* Revoked flag is valid */
 	BH_JBDDirty,		/* Is dirty but journaled */
@@ -328,6 +329,7 @@ TAS_BUFFER_FNS(Revoked, revoked)
 BUFFER_FNS(RevokeValid, revokevalid)
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)
+BUFFER_FNS(Unmap, unmap)
 BUFFER_FNS(Shadow, shadow)
 BUFFER_FNS(Verified, verified)
 
-- 
2.17.2

