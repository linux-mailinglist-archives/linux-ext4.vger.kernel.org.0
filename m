Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019E95F876
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jul 2019 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGDMpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jul 2019 08:45:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbfGDMpD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 4 Jul 2019 08:45:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B7BCC2F52A1F1CB3ADC;
        Thu,  4 Jul 2019 20:45:00 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 20:44:50 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>, <miaoxie@huawei.com>
Subject: [PATCH] ext4: fix warning when turn on dioread_nolock and inline_data
Date:   Thu, 4 Jul 2019 20:50:32 +0800
Message-ID: <1562244632-134963-1-git-send-email-yangerkun@huawei.com>
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

With upon script, system will trigger
"WARN_ON(!io_end->handle && sbi->s_journal)" since the wrong order
between rsv_blocks calculate and destroy inline data for dealloc.

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

