Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADA1590EB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2020 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgBKN4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 08:56:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbgBKN4a (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 11 Feb 2020 08:56:30 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 13EB22BD6302A6A38040;
        Tue, 11 Feb 2020 21:56:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 21:56:22 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.cz>, <tytso@mit.edu>, <luoshijie1@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 1/2] jbd2: move the clearing of b_modified flag to the journal_unmap_buffer()
Date:   Tue, 11 Feb 2020 21:54:59 +0800
Message-ID: <20200211135500.40524-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200211135500.40524-1-yi.zhang@huawei.com>
References: <20200211135500.40524-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no need to delay the clearing of b_modified flag to the
transaction committing time when unmapping the journalled buffer, so
just move it to the journal_unmap_buffer().

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/commit.c      | 43 +++++++++++++++----------------------------
 fs/jbd2/transaction.c | 10 ++++++----
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7f0b362b3842..ecc2ea5f1b59 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -976,34 +976,21 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 * it. */
 
 		/*
-		* A buffer which has been freed while still being journaled by
-		* a previous transaction.
-		*/
-		if (buffer_freed(bh)) {
-			/*
-			 * If the running transaction is the one containing
-			 * "add to orphan" operation (b_next_transaction !=
-			 * NULL), we have to wait for that transaction to
-			 * commit before we can really get rid of the buffer.
-			 * So just clear b_modified to not confuse transaction
-			 * credit accounting and refile the buffer to
-			 * BJ_Forget of the running transaction. If the just
-			 * committed transaction contains "add to orphan"
-			 * operation, we can completely invalidate the buffer
-			 * now. We are rather through in that since the
-			 * buffer may be still accessible when blocksize <
-			 * pagesize and it is attached to the last partial
-			 * page.
-			 */
-			jh->b_modified = 0;
-			if (!jh->b_next_transaction) {
-				clear_buffer_freed(bh);
-				clear_buffer_jbddirty(bh);
-				clear_buffer_mapped(bh);
-				clear_buffer_new(bh);
-				clear_buffer_req(bh);
-				bh->b_bdev = NULL;
-			}
+		 * A buffer which has been freed while still being journaled
+		 * by a previous transaction, refile the buffer to BJ_Forget of
+		 * the running transaction. If the just committed transaction
+		 * contains "add to orphan" operation, we can completely
+		 * invalidate the buffer now. We are rather through in that
+		 * since the buffer may be still accessible when blocksize <
+		 * pagesize and it is attached to the last partial page.
+		 */
+		if (buffer_freed(bh) && !jh->b_next_transaction) {
+			clear_buffer_freed(bh);
+			clear_buffer_jbddirty(bh);
+			clear_buffer_mapped(bh);
+			clear_buffer_new(bh);
+			clear_buffer_req(bh);
+			bh->b_bdev = NULL;
 		}
 
 		if (buffer_jbddirty(bh)) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 27b9f9dee434..0603dfa9ad90 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2329,14 +2329,16 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			return -EBUSY;
 		}
 		/*
-		 * OK, buffer won't be reachable after truncate. We just set
-		 * j_next_transaction to the running transaction (if there is
-		 * one) and mark buffer as freed so that commit code knows it
-		 * should clear dirty bits when it is done with the buffer.
+		 * OK, buffer won't be reachable after truncate. We just clear
+		 * b_modified to not confuse transaction credit accounting, and
+		 * set j_next_transaction to the running transaction (if there
+		 * is one) and mark buffer as freed so that commit code knows
+		 * it should clear dirty bits when it is done with the buffer.
 		 */
 		set_buffer_freed(bh);
 		if (journal->j_running_transaction && buffer_jbddirty(bh))
 			jh->b_next_transaction = journal->j_running_transaction;
+		jh->b_modified = 0;
 		spin_unlock(&journal->j_list_lock);
 		spin_unlock(&jh->b_state_lock);
 		write_unlock(&journal->j_state_lock);
-- 
2.17.2

