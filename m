Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0639300F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhE0NtA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 09:49:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2319 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhE0Nsy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 09:48:54 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrTXM1qyVz1BFMy;
        Thu, 27 May 2021 21:42:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 21:47:17 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH v3 3/8] jbd2: don't abort the journal when freeing buffers
Date:   Thu, 27 May 2021 21:56:36 +0800
Message-ID: <20210527135641.420514-4-yi.zhang@huawei.com>
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

Now that we can be sure the journal is aborted once a buffer has failed
to be written back to disk, we can remove the journal abort logic in
jbd2_journal_try_to_free_buffers() which was introduced in
commit c044f3d8360d ("jbd2: abort journal if free a async write error
metadata buffer"), because it may cost and propably is not safe.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e8fc45fd751f..8804e126805f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2123,7 +2123,6 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
-	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2148,26 +2147,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 		jbd2_journal_put_journal_head(jh);
 		if (buffer_jbd(bh))
 			goto busy;
-
-		/*
-		 * If we free a metadata buffer which has been failed to
-		 * write out, the jbd2 checkpoint procedure will not detect
-		 * this failure and may lead to filesystem inconsistency
-		 * after cleanup journal tail.
-		 */
-		if (buffer_write_io_error(bh)) {
-			pr_err("JBD2: Error while async write back metadata bh %llu.",
-			       (unsigned long long)bh->b_blocknr);
-			has_write_io_error = true;
-		}
 	} while ((bh = bh->b_this_page) != head);
 
 	ret = try_to_free_buffers(page);
-
 busy:
-	if (has_write_io_error)
-		jbd2_journal_abort(journal, -EIO);
-
 	return ret;
 }
 
-- 
2.25.4

