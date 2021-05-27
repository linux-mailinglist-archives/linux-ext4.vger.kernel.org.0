Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4F39300D
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhE0Ns5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 09:48:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2064 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbhE0Nsx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 09:48:53 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrTXL1gg0zWp4T;
        Thu, 27 May 2021 21:42:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 21:47:17 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH v3 1/8] jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
Date:   Thu, 27 May 2021 21:56:34 +0800
Message-ID: <20210527135641.420514-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210527135641.420514-1-yi.zhang@huawei.com>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The 'out' lable just return the 'ret' value and seems not required, so
remove this label and switch to return appropriate value immediately.
This patch also do some minor cleanup, no logical change.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 63b526d44886..bf5511d19ac5 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -564,13 +564,13 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	struct transaction_chp_stats_s *stats;
 	transaction_t *transaction;
 	journal_t *journal;
-	int ret = 0;
 
 	JBUFFER_TRACE(jh, "entry");
 
-	if ((transaction = jh->b_cp_transaction) == NULL) {
+	transaction = jh->b_cp_transaction;
+	if (!transaction) {
 		JBUFFER_TRACE(jh, "not on transaction");
-		goto out;
+		return 0;
 	}
 	journal = transaction->t_journal;
 
@@ -579,9 +579,9 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	jh->b_cp_transaction = NULL;
 	jbd2_journal_put_journal_head(jh);
 
-	if (transaction->t_checkpoint_list != NULL ||
-	    transaction->t_checkpoint_io_list != NULL)
-		goto out;
+	/* Is this transaction empty? */
+	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
+		return 0;
 
 	/*
 	 * There is one special case to worry about: if we have just pulled the
@@ -593,10 +593,12 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	 * See the comment at the end of jbd2_journal_commit_transaction().
 	 */
 	if (transaction->t_state != T_FINISHED)
-		goto out;
+		return 0;
 
-	/* OK, that was the last buffer for the transaction: we can now
-	   safely remove this transaction from the log */
+	/*
+	 * OK, that was the last buffer for the transaction, we can now
+	 * safely remove this transaction from the log.
+	 */
 	stats = &transaction->t_chp_stats;
 	if (stats->cs_chp_time)
 		stats->cs_chp_time = jbd2_time_diff(stats->cs_chp_time,
@@ -606,9 +608,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 
 	__jbd2_journal_drop_transaction(journal, transaction);
 	jbd2_journal_free_transaction(transaction);
-	ret = 1;
-out:
-	return ret;
+	return 1;
 }
 
 /*
-- 
2.25.4

