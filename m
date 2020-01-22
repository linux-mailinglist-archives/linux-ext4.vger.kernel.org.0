Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5962F144C73
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2020 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVH10 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jan 2020 02:27:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgAVH10 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jan 2020 02:27:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C741EF551C9C91A0EB7F;
        Wed, 22 Jan 2020 15:27:24 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 15:27:17 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>
Subject: [PATCH] ext4,jbd2: fix comment and code style
Date:   Wed, 22 Jan 2020 02:26:25 -0500
Message-ID: <20200122072625.16487-1-luoshijie1@huawei.com>
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

Fix comment and remove unnecessary blank.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
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

