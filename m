Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BB21052C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jul 2020 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGAHjo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jul 2020 03:39:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727836AbgGAHjn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Jul 2020 03:39:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 80B8BD0D26A46366D379;
        Wed,  1 Jul 2020 15:39:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Jul 2020
 15:39:36 +0800
From:   zhengliang <zhengliang6@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH v2] ext4: lost matching-pair of trace in ext4_truncate
Date:   Wed, 1 Jul 2020 16:30:27 +0800
Message-ID: <20200701083027.45996-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It should call trace exit in all return path for ext4_truncate.

v2:
It shoule call trace exit in all return path, and add "out_trace" label to avoid the
multiple copies of the cleanup code in each error case.
 
Signed-off-by: zhengliang <zhengliang6@huawei.com>
---
 fs/ext4/inode.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..6187c8880c02 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4163,7 +4163,7 @@ int ext4_truncate(struct inode *inode)
 	trace_ext4_truncate_enter(inode);
 
 	if (!ext4_can_truncate(inode))
-		return 0;
+		goto out_trace;
 
 	if (inode->i_size == 0 && !test_opt(inode->i_sb, NO_AUTO_DA_ALLOC))
 		ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
@@ -4172,16 +4172,14 @@ int ext4_truncate(struct inode *inode)
 		int has_inline = 1;
 
 		err = ext4_inline_data_truncate(inode, &has_inline);
-		if (err)
-			return err;
-		if (has_inline)
-			return 0;
+		if (err || has_inline)
+			goto out_trace;
 	}
 
 	/* If we zero-out tail of the page, we have to create jinode for jbd2 */
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
 		if (ext4_inode_attach_jinode(inode) < 0)
-			return 0;
+			goto out_trace;
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
@@ -4190,8 +4188,10 @@ int ext4_truncate(struct inode *inode)
 		credits = ext4_blocks_for_truncate(inode);
 
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto out_trace;
+	}
 
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
 		ext4_block_truncate_page(handle, mapping, inode->i_size);
@@ -4242,6 +4242,7 @@ int ext4_truncate(struct inode *inode)
 		err = err2;
 	ext4_journal_stop(handle);
 
+out_trace:
 	trace_ext4_truncate_exit(inode);
 	return err;
 }
-- 
2.17.1

