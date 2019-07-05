Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDA601DC
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2019 09:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfGEH5M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jul 2019 03:57:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfGEH5M (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jul 2019 03:57:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E9BC33A2414B546C86F8;
        Fri,  5 Jul 2019 15:57:09 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 5 Jul 2019 15:55:52 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>, <miaoxie@huawei.com>
Subject: [PATCH v2] ext4: fix warning when turn on dioread_nolock and inline_data
Date:   Fri, 5 Jul 2019 16:01:34 +0800
Message-ID: <1562313694-60126-1-git-send-email-yangerkun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mkfs.ext4 -O inline_data /dev/vdb
mount -o dioread_nolock /dev/vdb /mnt
echo "some inline data..." >> /mnt/test-file
echo "some inline data..." >> /mnt/test-file
sync

The above script will trigger "WARN_ON(!io_end->handle && sbi->s_journal)"
because ext4_should_dioread_nolock() returns false for a file with inline
data. Move the check to a place after we have already removed the inline
data and prepared inode to write normal pages.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c7f77c6..3f2a366 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2769,15 +2769,6 @@ static int ext4_writepages(struct address_space *mapping,
 		goto out_writepages;
 	}
 
-	if (ext4_should_dioread_nolock(inode)) {
-		/*
-		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
-		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
-	}
-
 	/*
 	 * If we have inline data and arrive here, it means that
 	 * we will soon create the block for the 1st page, so
@@ -2796,6 +2787,15 @@ static int ext4_writepages(struct address_space *mapping,
 		ext4_journal_stop(handle);
 	}
 
+	if (ext4_should_dioread_nolock(inode)) {
+		/*
+		 * We may need to convert up to one extent per block in
+		 * the page and we may dirty the inode.
+		 */
+		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
+						PAGE_SIZE >> inode->i_blkbits);
+	}
+
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 		range_whole = 1;
 
-- 
2.7.4

