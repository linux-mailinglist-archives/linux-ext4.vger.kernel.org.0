Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1714621C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAWGoP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 01:44:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbgAWGoN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 01:44:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0810743B516CAC720386;
        Thu, 23 Jan 2020 14:44:12 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 14:44:02 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>
Subject: [PATCH v2] ext4,jbd2: fix comment and code style
Date:   Thu, 23 Jan 2020 01:43:25 -0500
Message-ID: <20200123064325.36358-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix comment and remove unneccessary blank.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c      | 2 +-
 fs/jbd2/transaction.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2fec62d764fa..a6695e1d246c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -849,7 +849,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 
 /*
  * Prepare the write for the inline data.
- * If the the data can be written into the inode, we just read
+ * If the data can be written into the inode, we just read
  * the page and make it uptodate, and start the journal.
  * Otherwise read the page, makes it dirty so that it can be
  * handle in writepages(the i_disksize update is left to the
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 27b9f9dee434..f7a9da75b160 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1595,7 +1595,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
  * Allow this call even if the handle has aborted --- it may be part of
  * the caller's cleanup after an abort.
  */
-int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
+int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
-- 
2.19.1

