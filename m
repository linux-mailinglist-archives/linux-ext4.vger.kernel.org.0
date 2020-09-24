Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3761D276AD2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgIXHcv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbgIXHct (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A194B1042D8BA6C4DEE;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:40 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 6/7] ext4: use ext4_sb_bread() instead of sb_bread()
Date:   Thu, 24 Sep 2020 15:33:36 +0800
Message-ID: <20200924073337.861472-7-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924073337.861472-1-yi.zhang@huawei.com>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We have already remove open codes that invoke helpers provide by
fs/buffer.c in all places reading metadata buffers. This patch switch to
use ext4_sb_bread() to replace all sb_bread() helpers, which is
ext4_read_bh() helper back end.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/indirect.c | 6 +++---
 fs/ext4/resize.c   | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 4d7656f4ebc3..ba944d67c1c0 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1012,14 +1012,14 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			}
 
 			/* Go read the buffer for the next level down */
-			bh = sb_bread(inode->i_sb, nr);
+			bh = ext4_sb_bread(inode->i_sb, nr, 0);
 
 			/*
 			 * A read failure? Report error and clear slot
 			 * (should be rare).
 			 */
-			if (!bh) {
-				ext4_error_inode_block(inode, nr, EIO,
+			if (IS_ERR(bh)) {
+				ext4_error_inode_block(inode, nr, -PTR_ERR(bh),
 						       "Read failure");
 				continue;
 			}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 8596bdda304c..5e72849f1df9 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1806,8 +1806,8 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 			     o_blocks_count + add, add);
 
 	/* See if the device is actually as big as what was requested */
-	bh = sb_bread(sb, o_blocks_count + add - 1);
-	if (!bh) {
+	bh = ext4_sb_bread(sb, o_blocks_count + add - 1, 0);
+	if (IS_ERR(bh)) {
 		ext4_warning(sb, "can't read last block, resize aborted");
 		return -ENOSPC;
 	}
@@ -1932,8 +1932,8 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	int meta_bg;
 
 	/* See if the device is actually as big as what was requested */
-	bh = sb_bread(sb, n_blocks_count - 1);
-	if (!bh) {
+	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
+	if (IS_ERR(bh)) {
 		ext4_warning(sb, "can't read last block, resize aborted");
 		return -ENOSPC;
 	}
-- 
2.25.4

