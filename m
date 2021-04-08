Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAC3581B9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhDHL2T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 07:28:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16836 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHL2T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 07:28:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJq63mPpz7txW;
        Thu,  8 Apr 2021 19:25:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:28:00 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 1/3] jbd2: protect buffers release with j_checkpoint_mutex
Date:   Thu, 8 Apr 2021 19:36:16 +0800
Message-ID: <20210408113618.1033785-2-yi.zhang@huawei.com>
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

There is a race between jbd2_journal_try_to_free_buffers() and
jbd2_journal_destroy(), so the jbd2_log_do_checkpoint() may still
missing to detect the buffer write io error flag and lead to filesystem
inconsistency.

jbd2_journal_try_to_free_buffers()     ext4_put_super()
                                        jbd2_journal_destroy()
  __jbd2_journal_remove_checkpoint()
  detect buffer write error              jbd2_log_do_checkpoint()
                                         jbd2_cleanup_journal_tail()
                                           <--- lead to inconsistency
  jbd2_journal_abort()

Fix this issue by add j_checkpoint_mutex to protect journal buffer
release on jbd2_journal_try_to_free_buffers().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/transaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 9396666b7314..b935b20cbae4 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2123,6 +2123,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 
 	J_ASSERT(PageLocked(page));
 
+	mutex_lock(&journal->j_checkpoint_mutex);
 	head = page_buffers(page);
 	bh = head;
 	do {
@@ -2163,6 +2164,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 	if (has_write_io_error)
 		jbd2_journal_abort(journal, -EIO);
 
+	mutex_unlock(&journal->j_checkpoint_mutex);
 	return ret;
 }
 
-- 
2.25.4

