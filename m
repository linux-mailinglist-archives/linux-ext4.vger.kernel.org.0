Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CC621650
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiKHO04 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiKHO0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7B5C77F
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:54 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N69Jw09TLzHqRP;
        Tue,  8 Nov 2022 22:21:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:52 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 09/12] ext4: add xattr block I/O fault injection
Date:   Tue, 8 Nov 2022 22:46:14 +0800
Message-ID: <20221108144617.4159381-10-yi.zhang@huawei.com>
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

Add I/O fault injection when reading xattr block, we can specify the
inode to inject. ext4_xattr_get_block() will return -EIO immediately
instead of submitting I/O.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/sysfs.c | 1 +
 fs/ext4/xattr.c | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index aaa3a29cd0e7..94894daef595 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1524,6 +1524,7 @@ enum ext4_fault_bits {
 	EXT4_FAULT_INODE_EIO,		/* inode */
 	EXT4_FAULT_EXTENT_EIO,		/* extent block */
 	EXT4_FAULT_DIRBLOCK_EIO,	/* directory block */
+	EXT4_FAULT_XATTR_EIO,		/* xattr block */
 	EXT4_FAULT_MAX
 };
 
@@ -1628,6 +1629,7 @@ EXT4_FAULT_GRP_FN(BBITMAP_EIO, block_bitmap_io, -EIO)
 EXT4_FAULT_INODE_FN(INODE_EIO, inode_io, -EIO)
 EXT4_FAULT_INODE_PBLOCK_FN(EXTENT_EIO, extent_io, -EIO)
 EXT4_FAULT_INODE_LBLOCK_FN(DIRBLOCK_EIO, dirblock_io, -EIO)
+EXT4_FAULT_INODE_FN(XATTR_EIO, xattr_io, -EIO)
 
 /*
  * fourth extended-fs super-block data in memory
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 0329205a9958..f7f8882037a5 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -583,6 +583,7 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"inode_eio",			/* EXT4_FAULT_INODE_EIO */
 	"extent_block_eio",		/* EXT4_FAULT_EXTENT_EIO */
 	"dir_block_eio",		/* EXT4_FAULT_DIRBLOCK_EIO */
+	"xattr_block_eio",		/* EXT4_FAULT_XATTR_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 39c80565c65d..3a066c1ddd5c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2231,6 +2231,10 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 	if (!EXT4_I(inode)->i_file_acl)
 		return NULL;
 
+	error = ext4_fault_xattr_io(inode->i_sb, inode->i_ino);
+	if (error)
+		return ERR_PTR(error);
+
 	ea_idebug(inode, "reading block %llu",
 		  (unsigned long long)EXT4_I(inode)->i_file_acl);
 	bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-- 
2.31.1

