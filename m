Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901EB561569
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiF3IsX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jun 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiF3IsX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Jun 2022 04:48:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B7186CA
        for <linux-ext4@vger.kernel.org>; Thu, 30 Jun 2022 01:48:21 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LYX4L4gFGzkWdZ;
        Thu, 30 Jun 2022 16:46:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 16:48:19 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <openglfreak@googlemail.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: fix reading leftover inlined symlinks
Date:   Thu, 30 Jun 2022 17:01:00 +0800
Message-ID: <20220630090100.2769490-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit 6493792d3299 ("ext4: convert symlink external data block
mapping to bdev"), create new symlink with inline_data is not supported,
but it missing to handle the leftover inlined symlinks, which could
cause below error message and fail to read symlink.

 ls: cannot read symbolic link 'foo': Structure needs cleaning

 EXT4-fs error (device sda): ext4_map_blocks:605: inode #12: block
 2021161080: comm ls: lblock 0 mapped to illegal pblock 2021161080
 (length 1)

Fix this regression by adding ext4_read_inline_link(), which read the
inline data directly and convert it through a kmalloced buffer.

Fixes: 6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
Reported-by: Torge Matthies <openglfreak@googlemail.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/inline.c  | 30 ++++++++++++++++++++++++++++++
 fs/ext4/symlink.c | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..adfc30ee4b7b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3583,6 +3583,7 @@ extern struct buffer_head *ext4_get_first_inline_block(struct inode *inode,
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
 				   int *has_inline, __u64 start, __u64 len);
+extern void *ext4_read_inline_link(struct inode *inode);
 
 struct iomap;
 extern int ext4_inline_data_iomap(struct inode *inode, struct iomap *iomap);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index cff52ff6549d..1fa36cbe09ec 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -6,6 +6,7 @@
 
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
+#include <linux/namei.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
 
@@ -1588,6 +1589,35 @@ int ext4_read_inline_dir(struct file *file,
 	return ret;
 }
 
+void *ext4_read_inline_link(struct inode *inode)
+{
+	struct ext4_iloc iloc;
+	int ret, inline_size;
+	void *link;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = -ENOMEM;
+	inline_size = ext4_get_inline_size(inode);
+	link = kmalloc(inline_size + 1, GFP_NOFS);
+	if (!link)
+		goto out;
+
+	ret = ext4_read_inline_data(inode, link, inline_size, &iloc);
+	if (ret < 0) {
+		kfree(link);
+		goto out;
+	}
+	nd_terminate_link(link, inode->i_size, ret);
+out:
+	if (ret < 0)
+		link = ERR_PTR(ret);
+	brelse(iloc.bh);
+	return link;
+}
+
 struct buffer_head *ext4_get_first_inline_block(struct inode *inode,
 					struct ext4_dir_entry_2 **parent_de,
 					int *retval)
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index d281f5bcc526..3d3ed3c38f56 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -74,6 +74,21 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 				 struct delayed_call *callback)
 {
 	struct buffer_head *bh;
+	char *inline_link;
+
+	/*
+	 * Create a new inlined symlink is not supported, just provide a
+	 * method to read the leftovers.
+	 */
+	if (ext4_has_inline_data(inode)) {
+		if (!dentry)
+			return ERR_PTR(-ECHILD);
+
+		inline_link = ext4_read_inline_link(inode);
+		if (!IS_ERR(inline_link))
+			set_delayed_call(callback, kfree_link, inline_link);
+		return inline_link;
+	}
 
 	if (!dentry) {
 		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
-- 
2.31.1

