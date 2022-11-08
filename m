Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273C62164C
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiKHO0t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiKHO0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201F5C767
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:52 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N69NB42dFzRp5p;
        Tue,  8 Nov 2022 22:24:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:50 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 05/12] ext4: add inode I/O fault injection
Date:   Tue, 8 Nov 2022 22:46:10 +0800
Message-ID: <20221108144617.4159381-6-yi.zhang@huawei.com>
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

Add I/O fault injection when reading raw inode from disk, we can
specify the inode to inject, __ext4_get_inode_loc() will return -EIO
immediately instead of submitting I/O, note that it doesn't handle
the readhead case.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/inode.c | 18 ++++++++++++------
 fs/ext4/sysfs.c |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 589d901e8946..29a819a186f7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1521,6 +1521,7 @@ enum ext4_fault_bits {
 	/* inject metadata IO error*/
 	EXT4_FAULT_IBITMAP_EIO,		/* inode bitmap block */
 	EXT4_FAULT_BBITMAP_EIO,		/* block bitmap block */
+	EXT4_FAULT_INODE_EIO,		/* inode */
 	EXT4_FAULT_MAX
 };
 
@@ -1622,6 +1623,7 @@ EXT4_FAULT_INODE_FN(XATTR_CSUM, xattr_csum, 1)
 
 EXT4_FAULT_GRP_FN(IBITMAP_EIO, inode_bitmap_io, -EIO)
 EXT4_FAULT_GRP_FN(BBITMAP_EIO, block_bitmap_io, -EIO)
+EXT4_FAULT_INODE_FN(INODE_EIO, inode_io, -EIO)
 
 /*
  * fourth extended-fs super-block data in memory
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8bfbc8d100b4..8c611ad6dac1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4570,19 +4570,25 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	 * Read the block from disk.
 	 */
 	trace_ext4_load_inode(sb, ino);
+	if (ext4_fault_inode_io(sb, ino)) {
+		unlock_buffer(bh);
+		blk_finish_plug(&plug);
+		goto err;
+	}
 	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
 	blk_finish_plug(&plug);
 	wait_on_buffer(bh);
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
-	if (!buffer_uptodate(bh)) {
-		if (ret_block)
-			*ret_block = block;
-		brelse(bh);
-		return -EIO;
-	}
+	if (!buffer_uptodate(bh))
+		goto err;
 has_buffer:
 	iloc->bh = bh;
 	return 0;
+err:
+	if (ret_block)
+		*ret_block = block;
+	brelse(bh);
+	return -EIO;
 }
 
 static int __ext4_get_inode_loc_noinmem(struct inode *inode,
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 638892046dc8..9c6d9a212d47 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -580,6 +580,7 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"xattr_block_checksum",		/* EXT4_FAULT_XATTR_CSUM */
 	"inode_bitmap_eio",		/* EXT4_FAULT_IBITMAP_EIO */
 	"block_bitmap_eio",		/* EXT4_FAULT_BBITMAP_EIO */
+	"inode_eio",			/* EXT4_FAULT_INODE_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

