Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DAD621653
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiKHO1D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiKHO0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7F5B862
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:54 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N69ND6GYszRp5v;
        Tue,  8 Nov 2022 22:24:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:52 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 10/12] ext4: add symlink block I/O fault injection
Date:   Tue, 8 Nov 2022 22:46:15 +0800
Message-ID: <20221108144617.4159381-11-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108144617.4159381-1-yi.zhang@huawei.com>
References: <20221108144617.4159381-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add I/O fault injection when reading symlink block, user could specify
which inode to inject error. It will return -EIO immediately instead of
submitting I/O.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 2 ++
 fs/ext4/symlink.c | 4 ++++
 fs/ext4/sysfs.c   | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 94894daef595..813127cfd3c0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1525,6 +1525,7 @@ enum ext4_fault_bits {
 	EXT4_FAULT_EXTENT_EIO,		/* extent block */
 	EXT4_FAULT_DIRBLOCK_EIO,	/* directory block */
 	EXT4_FAULT_XATTR_EIO,		/* xattr block */
+	EXT4_FAULT_SYMLINK_EIO,		/* symlink block */
 	EXT4_FAULT_MAX
 };
 
@@ -1630,6 +1631,7 @@ EXT4_FAULT_INODE_FN(INODE_EIO, inode_io, -EIO)
 EXT4_FAULT_INODE_PBLOCK_FN(EXTENT_EIO, extent_io, -EIO)
 EXT4_FAULT_INODE_LBLOCK_FN(DIRBLOCK_EIO, dirblock_io, -EIO)
 EXT4_FAULT_INODE_FN(XATTR_EIO, xattr_io, -EIO)
+EXT4_FAULT_INODE_FN(SYMLINK_EIO, symlink_io, -EIO)
 
 /*
  * fourth extended-fs super-block data in memory
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 3d3ed3c38f56..5392e707418e 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -39,6 +39,8 @@ static const char *ext4_encrypted_get_link(struct dentry *dentry,
 		caddr = EXT4_I(inode)->i_data;
 		max_size = sizeof(EXT4_I(inode)->i_data);
 	} else {
+		if (ext4_fault_symlink_io(inode->i_sb, inode->i_ino))
+			return ERR_PTR(-EIO);
 		bh = ext4_bread(NULL, inode, 0, 0);
 		if (IS_ERR(bh))
 			return ERR_CAST(bh);
@@ -97,6 +99,8 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 		if (!bh || !ext4_buffer_uptodate(bh))
 			return ERR_PTR(-ECHILD);
 	} else {
+		if (ext4_fault_symlink_io(inode->i_sb, inode->i_ino))
+			return ERR_PTR(-EIO);
 		bh = ext4_bread(NULL, inode, 0, 0);
 		if (IS_ERR(bh))
 			return ERR_CAST(bh);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f7f8882037a5..aca91ab5b506 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -584,6 +584,7 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"extent_block_eio",		/* EXT4_FAULT_EXTENT_EIO */
 	"dir_block_eio",		/* EXT4_FAULT_DIRBLOCK_EIO */
 	"xattr_block_eio",		/* EXT4_FAULT_XATTR_EIO */
+	"symlink_block_eio",		/* EXT4_FAULT_SYMLINK_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

