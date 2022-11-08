Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E335462164E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiKHO0v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiKHO0M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C15C75F
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:51 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N69N6687gz15MNt;
        Tue,  8 Nov 2022 22:24:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:49 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 04/12] ext4: add bitmaps I/O fault injection
Date:   Tue, 8 Nov 2022 22:46:09 +0800
Message-ID: <20221108144617.4159381-5-yi.zhang@huawei.com>
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

Add inode and block bitmap reading I/O fault injections, we can specify
the group to inject, the reading function will return -EIO immediately
instead of submitting I/O.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/balloc.c | 10 ++++++++++
 fs/ext4/ext4.h   |  6 ++++++
 fs/ext4/ialloc.c | 20 +++++++++++++-------
 fs/ext4/sysfs.c  |  2 ++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..ff5c90f4386d 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -501,6 +501,16 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	 */
 	set_buffer_new(bh);
 	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
+	err = ext4_fault_block_bitmap_io(sb, block_group);
+	if (err) {
+		unlock_buffer(bh);
+		ext4_error_err(sb, -err, "Cannot read block bitmap - "
+			       "block_group = %u, block_bitmap = %llu",
+			       block_group, bitmap_blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		goto out;
+	}
 	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO |
 			    (ignore_locked ? REQ_RAHEAD : 0),
 			    ext4_end_bitmap_read);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4c85cf977bea..589d901e8946 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1518,6 +1518,9 @@ enum ext4_fault_bits {
 	EXT4_FAULT_DIRBLOCK_CSUM,	/* directory block */
 	EXT4_FAULT_DIRIDX_CSUM,		/* directory index block */
 	EXT4_FAULT_XATTR_CSUM,		/* xattr block */
+	/* inject metadata IO error*/
+	EXT4_FAULT_IBITMAP_EIO,		/* inode bitmap block */
+	EXT4_FAULT_BBITMAP_EIO,		/* block bitmap block */
 	EXT4_FAULT_MAX
 };
 
@@ -1617,6 +1620,9 @@ EXT4_FAULT_INODE_FN(DIRBLOCK_CSUM, dirblock_csum, 1)
 EXT4_FAULT_INODE_FN(DIRIDX_CSUM, dirindex_csum, 1)
 EXT4_FAULT_INODE_FN(XATTR_CSUM, xattr_csum, 1)
 
+EXT4_FAULT_GRP_FN(IBITMAP_EIO, inode_bitmap_io, -EIO)
+EXT4_FAULT_GRP_FN(BBITMAP_EIO, block_bitmap_io, -EIO)
+
 /*
  * fourth extended-fs super-block data in memory
  */
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bc46684106..e299aa80a718 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -194,16 +194,16 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	 * submit the buffer_head for reading
 	 */
 	trace_ext4_load_inode_bitmap(sb, block_group);
+	err = ext4_fault_inode_bitmap_io(sb, block_group);
+	if (err) {
+		unlock_buffer(bh);
+		goto read_err;
+	}
 	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
-		put_bh(bh);
-		ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
-			       "block_group = %u, inode_bitmap = %llu",
-			       block_group, bitmap_blk);
-		ext4_mark_group_bitmap_corrupted(sb, block_group,
-				EXT4_GROUP_INFO_IBITMAP_CORRUPT);
-		return ERR_PTR(-EIO);
+		err = -EIO;
+		goto read_err;
 	}
 
 verify:
@@ -211,6 +211,12 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	if (err)
 		goto out;
 	return bh;
+read_err:
+	ext4_error_err(sb, -err, "Cannot read inode bitmap - "
+		       "block_group = %u, inode_bitmap = %llu",
+		       block_group, bitmap_blk);
+	ext4_mark_group_bitmap_corrupted(sb, block_group,
+					 EXT4_GROUP_INFO_IBITMAP_CORRUPT);
 out:
 	put_bh(bh);
 	return ERR_PTR(err);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 07d2edb4195f..638892046dc8 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -578,6 +578,8 @@ char *ext4_fault_names[EXT4_FAULT_MAX] = {
 	"dir_block_checksum",		/* EXT4_FAULT_DIRBLOCK_CSUM */
 	"dir_index_block_checksum",	/* EXT4_FAULT_DIRIDX_CSUM */
 	"xattr_block_checksum",		/* EXT4_FAULT_XATTR_CSUM */
+	"inode_bitmap_eio",		/* EXT4_FAULT_IBITMAP_EIO */
+	"block_bitmap_eio",		/* EXT4_FAULT_BBITMAP_EIO */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
-- 
2.31.1

