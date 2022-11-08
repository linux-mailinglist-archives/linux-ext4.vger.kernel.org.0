Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5D62164D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiKHO0u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiKHO0M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AA5C76C
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:53 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N69N81jH9z15MQy;
        Tue,  8 Nov 2022 22:24:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:51 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 07/12] ext4: add dirblock I/O fault injection
Date:   Tue, 8 Nov 2022 22:46:12 +0800
Message-ID: <20221108144617.4159381-8-yi.zhang@huawei.com>
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

Add directory block reading I/O fault injection, we can specify the
inode and logical block to inject. It will return -EIO immediately
instead of submitting I/O in readdir cases, but in the
__ext4_find_entry() procedure, it's hard to inject error precisely due
to the batch count reading, so it simulate error by clearing the
buffer's uptodate flag after I/O complete.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/dir.c   | 3 +++
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/namei.c | 4 ++++
 fs/ext4/sysfs.c | 1 +
 4 files changed, 10 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..1cf2b89c9dcd 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -196,6 +196,9 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
+			err = ext4_fault_dirblock_io(inode, map.m_lblk);
+			if (err)
+				goto errout;
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
 				err = PTR_ERR(bh);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9c1dcbed59e6..aaa3a29cd0e7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1523,6 +1523,7 @@ enum ext4_fault_bits {
 	EXT4_FAULT_BBITMAP_EIO,		/* block bitmap block */
 	EXT4_FAULT_INODE_EIO,		/* inode */
 	EXT4_FAULT_EXTENT_EIO,		/* extent block */
+	EXT4_FAULT_DIRBLOCK_EIO,	/* directory block */
 	EXT4_FAULT_MAX
 };
 
@@ -1626,6 +1627,7 @@ EXT4_FAULT_GRP_FN(IBITMAP_EIO, inode_bitmap_io, -EIO)
 EXT4_FAULT_GRP_FN(BBITMAP_EIO, block_bitmap_io, -EIO)
 EXT4_FAULT_INODE_FN(INODE_EIO, inode_io, -EIO)
 EXT4_FAULT_INODE_PBLOCK_FN(EXTENT_EIO, extent_io, -EIO)
+EXT4_FAULT_INODE_LBLOCK_FN(DIRBLOCK_EIO, dirblock_io, -EIO)
 
 /*
  * fourth extended-fs super-block data in memory
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4960ef9f05a0..fa754f1ba4a6 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -140,6 +140,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 	if (ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_EIO))
 		bh = ERR_PTR(-EIO);
+	else if (ext4_fault_dirblock_io(inode, block))
+		bh = ERR_PTR(-EIO);
 	else
 		bh = ext4_bread(NULL, inode, block, 0);
 	if (IS_ERR(bh)) {
@@ -1663,6 +1665,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		if ((bh = bh_use[ra_ptr++]) == NULL)
 			goto next;
 		wait_on_buffer(bh);
+		if (ext4_fault_dirblock_io(dir, bh->b_blocknr))
+			clear_buffer_uptodate(bh);
 		if (!buffer_uptodate(bh)) {
 			EXT4_ERROR_INODE_ERR(dir, EIO,
 					     "reading directory lblock %lu",
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index bad4885399dd..0329205a9958 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -582,6 +582,7 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"block_bitmap_eio",		/* EXT4_FAULT_BBITMAP_EIO */
 	"inode_eio",			/* EXT4_FAULT_INODE_EIO */
 	"extent_block_eio",		/* EXT4_FAULT_EXTENT_EIO */
+	"dir_block_eio",		/* EXT4_FAULT_DIRBLOCK_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

