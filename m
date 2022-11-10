Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFA623983
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiKJCFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiKJCEg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:04:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814EE10B51
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:04:35 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N74s056Wfz15MWV;
        Thu, 10 Nov 2022 10:04:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:04:33 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 06/12] ext4: add extent block I/O fault injection
Date:   Thu, 10 Nov 2022 10:25:52 +0800
Message-ID: <20221110022558.7844-7-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110022558.7844-1-yi.zhang@huawei.com>
References: <20221110022558.7844-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add inode extent block reading I/O fault injection, we can specify the
inode and physical metadata block to inject, it will return -EIO
immediately instead of submitting I/O.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 2 ++
 fs/ext4/extents.c | 5 +++++
 fs/ext4/sysfs.c   | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 29a819a186f7..9c1dcbed59e6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1522,6 +1522,7 @@ enum ext4_fault_bits {
 	EXT4_FAULT_IBITMAP_EIO,		/* inode bitmap block */
 	EXT4_FAULT_BBITMAP_EIO,		/* block bitmap block */
 	EXT4_FAULT_INODE_EIO,		/* inode */
+	EXT4_FAULT_EXTENT_EIO,		/* extent block */
 	EXT4_FAULT_MAX
 };
 
@@ -1624,6 +1625,7 @@ EXT4_FAULT_INODE_FN(XATTR_CSUM, xattr_csum, 1)
 EXT4_FAULT_GRP_FN(IBITMAP_EIO, inode_bitmap_io, -EIO)
 EXT4_FAULT_GRP_FN(BBITMAP_EIO, block_bitmap_io, -EIO)
 EXT4_FAULT_INODE_FN(INODE_EIO, inode_io, -EIO)
+EXT4_FAULT_INODE_PBLOCK_FN(EXTENT_EIO, extent_io, -EIO)
 
 /*
  * fourth extended-fs super-block data in memory
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0d07e5cf4dab..504ed35ffeaf 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -566,6 +566,11 @@ __read_extent_tree_block(const char *function, unsigned int line,
 
 	if (!bh_uptodate_or_lock(bh)) {
 		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
+		err = ext4_fault_extent_io(inode->i_sb, inode->i_ino, pblk);
+		if (err) {
+			unlock_buffer(bh);
+			goto errout;
+		}
 		err = ext4_read_bh(bh, 0, NULL);
 		if (err < 0)
 			goto errout;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 68b2c02bb266..871da7c8c2c6 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -581,6 +581,7 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"inode_bitmap_eio",		/* EXT4_FAULT_IBITMAP_EIO */
 	"block_bitmap_eio",		/* EXT4_FAULT_BBITMAP_EIO */
 	"inode_eio",			/* EXT4_FAULT_INODE_EIO */
+	"extent_block_eio",		/* EXT4_FAULT_EXTENT_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

