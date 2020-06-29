Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1420DB3B
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbgF2UEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 16:04:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6877 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388820AbgF2UEv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jun 2020 16:04:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0949B8F81C0E3A2B9D7;
        Mon, 29 Jun 2020 20:19:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 29 Jun 2020
 20:19:18 +0800
From:   Yi Zhuang <zhuangyi1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH v2] ext4: lost matching-pair of trace in ext4_unlink
Date:   Mon, 29 Jun 2020 20:26:21 +0800
Message-ID: <20200629122621.129953-1-zhuangyi1@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If dquot_initialize() return non-zero and trace of ext4_unlink_enter/exit
enabled then the matching-pair of trace_exit will lost in log.

v2:
Change the new label to be "out_trace:", which makes it more clear that
it is undoing the "trace" part of the code. At the same time, fix other
similar problems in this function:

	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
	if (IS_ERR(bh))
		return PTR_ERR(bh);
	if (!bh)
		goto end_unlink;

According to Andreas' suggestion, split up the "end_unlink:" label becomes
two separate labels, and then remove the "if (handle)" check, and then
use out_bh: before the handle is started.

Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>
---
 fs/ext4/namei.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56738b538ddf..941f66f417f0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3193,30 +3193,33 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	 * in separate transaction */
 	retval = dquot_initialize(dir);
 	if (retval)
-		return retval;
+		goto out_trace;
 	retval = dquot_initialize(d_inode(dentry));
 	if (retval)
-		return retval;
+		goto out_trace;
 
-	retval = -ENOENT;
 	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
-	if (IS_ERR(bh))
-		return PTR_ERR(bh);
-	if (!bh)
-		goto end_unlink;
+	if (IS_ERR(bh)) {
+		retval = PTR_ERR(bh);
+		goto out_trace;
+	}
+	if (!bh) {
+		retval = -ENOENT;
+		goto out_trace;
+	}
 
 	inode = d_inode(dentry);
 
-	retval = -EFSCORRUPTED;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
-		goto end_unlink;
+	if (le32_to_cpu(de->inode) != inode->i_ino) {
+		retval = -EFSCORRUPTED;
+		goto out_bh;
+	}
 
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
 				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
-		handle = NULL;
-		goto end_unlink;
+		goto out_bh;
 	}
 
 	if (IS_DIRSYNC(dir))
@@ -3224,12 +3227,12 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 
 	retval = ext4_delete_entry(handle, dir, de, bh);
 	if (retval)
-		goto end_unlink;
+		goto out_handle;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	ext4_update_dx_flag(dir);
 	retval = ext4_mark_inode_dirty(handle, dir);
 	if (retval)
-		goto end_unlink;
+		goto out_handle;
 	if (inode->i_nlink == 0)
 		ext4_warning_inode(inode, "Deleting file '%.*s' with no links",
 				   dentry->d_name.len, dentry->d_name.name);
@@ -3251,10 +3254,11 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		d_invalidate(dentry);
 #endif
 
-end_unlink:
+out_handle:
+	ext4_journal_stop(handle);
+out_bh:
 	brelse(bh);
-	if (handle)
-		ext4_journal_stop(handle);
+out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
 	return retval;
 }
-- 
2.26.0.106.g9fadedd

