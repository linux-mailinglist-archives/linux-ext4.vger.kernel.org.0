Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96EA621649
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiKHO0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiKHO0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3055C774
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:51 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N69Ms4TPmzHvcG;
        Tue,  8 Nov 2022 22:24:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:49 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 03/12] ext4: add several checksum fault injection
Date:   Tue, 8 Nov 2022 22:46:08 +0800
Message-ID: <20221108144617.4159381-4-yi.zhang@huawei.com>
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

Add 8 checksum fault injections, include group descriptors, inode
bitmap, block bitmap, inode, extent block, directory leaf block,
directory index block and xattr block. They are visable in
"available_faults" debugfs interface, and can be set and enabled in the
"inject_faults" interface.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/bitmap.c  |  4 ++++
 fs/ext4/ext4.h    | 18 ++++++++++++++++++
 fs/ext4/extents.c |  2 ++
 fs/ext4/inode.c   |  2 ++
 fs/ext4/namei.c   |  4 ++++
 fs/ext4/super.c   |  7 ++++---
 fs/ext4/sysfs.c   |  9 ++++++++-
 fs/ext4/xattr.c   | 15 +++++++++------
 8 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index f63e028c638c..c857cff280bb 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -26,6 +26,8 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 
 	if (!ext4_has_metadata_csum(sb))
 		return 1;
+	if (ext4_fault_inode_bitmap_csum(sb, group))
+		return 0;
 
 	provided = le16_to_cpu(gdp->bg_inode_bitmap_csum_lo);
 	calculated = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
@@ -65,6 +67,8 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 
 	if (!ext4_has_metadata_csum(sb))
 		return 1;
+	if (ext4_fault_block_bitmap_csum(sb, group))
+		return 0;
 
 	provided = le16_to_cpu(gdp->bg_block_bitmap_csum_lo);
 	calculated = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7a030b0b51c7..4c85cf977bea 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1509,6 +1509,15 @@ struct ext4_orphan_info {
 #define FAULT_NOTSET	(U64_MAX)
 
 enum ext4_fault_bits {
+	/* inject checksum error */
+	EXT4_FAULT_GRPDESC_CSUM,	/* group descriptor */
+	EXT4_FAULT_IBITMAP_CSUM,	/* inode bitmap block */
+	EXT4_FAULT_BBITMAP_CSUM,	/* block bitmap block */
+	EXT4_FAULT_INODE_CSUM,		/* inode */
+	EXT4_FAULT_EXTENT_CSUM,		/* extent block */
+	EXT4_FAULT_DIRBLOCK_CSUM,	/* directory block */
+	EXT4_FAULT_DIRIDX_CSUM,		/* directory index block */
+	EXT4_FAULT_XATTR_CSUM,		/* xattr block */
 	EXT4_FAULT_MAX
 };
 
@@ -1599,6 +1608,15 @@ static inline int ext4_fault_##name(struct super_block *sb, unsigned long ino,	\
 
 #endif /* CONFIG_EXT4_FAULT_INJECTION */
 
+EXT4_FAULT_GRP_FN(GRPDESC_CSUM, groupdesc_csum, 1)
+EXT4_FAULT_GRP_FN(IBITMAP_CSUM, inode_bitmap_csum, 1)
+EXT4_FAULT_GRP_FN(BBITMAP_CSUM, block_bitmap_csum, 1)
+EXT4_FAULT_INODE_FN(INODE_CSUM, inode_csum, 1)
+EXT4_FAULT_INODE_FN(EXTENT_CSUM, extent_csum, 1)
+EXT4_FAULT_INODE_FN(DIRBLOCK_CSUM, dirblock_csum, 1)
+EXT4_FAULT_INODE_FN(DIRIDX_CSUM, dirindex_csum, 1)
+EXT4_FAULT_INODE_FN(XATTR_CSUM, xattr_csum, 1)
+
 /*
  * fourth extended-fs super-block data in memory
  */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1956288307f..0d07e5cf4dab 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -65,6 +65,8 @@ static int ext4_extent_block_csum_verify(struct inode *inode,
 
 	if (!ext4_has_metadata_csum(inode->i_sb))
 		return 1;
+	if (ext4_fault_extent_csum(inode->i_sb, inode->i_ino))
+		return 0;
 
 	et = find_ext4_extent_tail(eh);
 	if (et->et_checksum != ext4_extent_block_csum(inode, eh))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..8bfbc8d100b4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -90,6 +90,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 	    cpu_to_le32(EXT4_OS_LINUX) ||
 	    !ext4_has_metadata_csum(inode->i_sb))
 		return 1;
+	if (ext4_fault_inode_csum(inode->i_sb, inode->i_ino))
+		return 0;
 
 	provided = le16_to_cpu(raw->i_checksum_lo);
 	calculated = ext4_inode_csum(inode, raw, ei);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d5daaf41e1fc..4960ef9f05a0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -398,6 +398,8 @@ int ext4_dirblock_csum_verify(struct inode *inode, struct buffer_head *bh)
 
 	if (!ext4_has_metadata_csum(inode->i_sb))
 		return 1;
+	if (ext4_fault_dirblock_csum(inode->i_sb, inode->i_ino))
+		return 0;
 
 	t = get_dirent_tail(inode, bh);
 	if (!t) {
@@ -493,6 +495,8 @@ static int ext4_dx_csum_verify(struct inode *inode,
 
 	if (!ext4_has_metadata_csum(inode->i_sb))
 		return 1;
+	if (ext4_fault_dirindex_csum(inode->i_sb, inode->i_ino))
+		return 0;
 
 	c = get_dx_countlimit(inode, dirent, &count_offset);
 	if (!c) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7950904fbf04..4ab2f1ad0dd4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3194,11 +3194,12 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 int ext4_group_desc_csum_verify(struct super_block *sb, __u32 block_group,
 				struct ext4_group_desc *gdp)
 {
-	if (ext4_has_group_desc_csum(sb) &&
-	    (gdp->bg_checksum != ext4_group_desc_csum(sb, block_group, gdp)))
+	if (!ext4_has_group_desc_csum(sb))
+		return 1;
+	if (ext4_fault_groupdesc_csum(sb, block_group))
 		return 0;
 
-	return 1;
+	return gdp->bg_checksum == ext4_group_desc_csum(sb, block_group, gdp);
 }
 
 void ext4_group_desc_csum_set(struct super_block *sb, __u32 block_group,
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 634768ebea2c..07d2edb4195f 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -570,7 +570,14 @@ void ext4_unregister_sysfs(struct super_block *sb)
 
 #ifdef CONFIG_EXT4_FAULT_INJECTION
 char *ext4_fault_names[EXT4_FAULT_MAX] = {
-	/* empty */
+	"group_desc_checksum",		/* EXT4_FAULT_GRPDESC_CSUM */
+	"inode_bitmap_checksum",	/* EXT4_FAULT_IBITMAP_CSUM */
+	"block_bitmap_checksum",	/* EXT4_FAULT_BBITMAP_CSUM */
+	"inode_checksum",		/* EXT4_FAULT_INODE_CSUM */
+	"extent_block_checksum",	/* EXT4_FAULT_EXTENT_CSUM */
+	"dir_block_checksum",		/* EXT4_FAULT_DIRBLOCK_CSUM */
+	"dir_index_block_checksum",	/* EXT4_FAULT_DIRIDX_CSUM */
+	"xattr_block_checksum",		/* EXT4_FAULT_XATTR_CSUM */
 };
 
 static int ext4_fault_available_show(struct seq_file *m, void *v)
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 36d6ba7190b6..46a87ae9fdc8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -152,14 +152,17 @@ static int ext4_xattr_block_csum_verify(struct inode *inode,
 					struct buffer_head *bh)
 {
 	struct ext4_xattr_header *hdr = BHDR(bh);
-	int ret = 1;
+	int ret;
+
+	if (!ext4_has_metadata_csum(inode->i_sb))
+		return 1;
+	if (ext4_fault_xattr_csum(inode->i_sb, inode->i_ino))
+		return 0;
 
-	if (ext4_has_metadata_csum(inode->i_sb)) {
-		lock_buffer(bh);
-		ret = (hdr->h_checksum == ext4_xattr_block_csum(inode,
+	lock_buffer(bh);
+	ret = (hdr->h_checksum == ext4_xattr_block_csum(inode,
 							bh->b_blocknr, hdr));
-		unlock_buffer(bh);
-	}
+	unlock_buffer(bh);
 	return ret;
 }
 
-- 
2.31.1

