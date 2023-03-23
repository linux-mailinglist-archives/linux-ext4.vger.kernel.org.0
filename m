Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2856C6A7A
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCWOId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjCWOI3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4F1B33C
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:09 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Wq0hwRz17Nb5;
        Thu, 23 Mar 2023 22:03:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:58 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 7/8] ext4: factor out ext4_block_group_meta_init()
Date:   Thu, 23 Mar 2023 22:05:16 +0800
Message-ID: <20230323140517.1070239-8-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323140517.1070239-1-yanaijie@huawei.com>
References: <20230323140517.1070239-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_block_group_meta_init(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 90 ++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6c9ffbe5095f..282f8e853893 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5113,6 +5113,55 @@ static void ext4_hash_info_init(struct super_block *sb)
 	}
 }
 
+static int ext4_block_group_meta_init(struct super_block *sb, int silent)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	int has_huge_files;
+
+	has_huge_files = ext4_has_feature_huge_file(sb);
+	sbi->s_bitmap_maxbytes = ext4_max_bitmap_size(sb->s_blocksize_bits,
+						      has_huge_files);
+	sb->s_maxbytes = ext4_max_size(sb->s_blocksize_bits, has_huge_files);
+
+	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
+	if (ext4_has_feature_64bit(sb)) {
+		if (sbi->s_desc_size < EXT4_MIN_DESC_SIZE_64BIT ||
+		    sbi->s_desc_size > EXT4_MAX_DESC_SIZE ||
+		    !is_power_of_2(sbi->s_desc_size)) {
+			ext4_msg(sb, KERN_ERR,
+			       "unsupported descriptor size %lu",
+			       sbi->s_desc_size);
+			return -EINVAL;
+		}
+	} else
+		sbi->s_desc_size = EXT4_MIN_DESC_SIZE;
+
+	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
+	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
+
+	sbi->s_inodes_per_block = sb->s_blocksize / EXT4_INODE_SIZE(sb);
+	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {
+		if (!silent)
+			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
+		return -EINVAL;
+	}
+	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
+	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
+		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
+			 sbi->s_inodes_per_group);
+		return -EINVAL;
+	}
+	sbi->s_itb_per_group = sbi->s_inodes_per_group /
+					sbi->s_inodes_per_block;
+	sbi->s_desc_per_block = sb->s_blocksize / EXT4_DESC_SIZE(sb);
+	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
+	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
+	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5121,7 +5170,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct inode *root;
 	int ret = -ENOMEM;
 	unsigned int i;
-	int needs_recovery, has_huge_files;
+	int needs_recovery;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
 	struct ext4_fs_context *ctx = fc->fs_private;
@@ -5219,45 +5268,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount;
 	}
 
-	has_huge_files = ext4_has_feature_huge_file(sb);
-	sbi->s_bitmap_maxbytes = ext4_max_bitmap_size(sb->s_blocksize_bits,
-						      has_huge_files);
-	sb->s_maxbytes = ext4_max_size(sb->s_blocksize_bits, has_huge_files);
-
-	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
-	if (ext4_has_feature_64bit(sb)) {
-		if (sbi->s_desc_size < EXT4_MIN_DESC_SIZE_64BIT ||
-		    sbi->s_desc_size > EXT4_MAX_DESC_SIZE ||
-		    !is_power_of_2(sbi->s_desc_size)) {
-			ext4_msg(sb, KERN_ERR,
-			       "unsupported descriptor size %lu",
-			       sbi->s_desc_size);
-			goto failed_mount;
-		}
-	} else
-		sbi->s_desc_size = EXT4_MIN_DESC_SIZE;
-
-	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
-
-	sbi->s_inodes_per_block = sb->s_blocksize / EXT4_INODE_SIZE(sb);
-	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {
-		if (!silent)
-			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
+	if (ext4_block_group_meta_init(sb, silent))
 		goto failed_mount;
-	}
-	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
-	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
-		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
-			 sbi->s_inodes_per_group);
-		goto failed_mount;
-	}
-	sbi->s_itb_per_group = sbi->s_inodes_per_group /
-					sbi->s_inodes_per_block;
-	sbi->s_desc_per_block = sb->s_blocksize / EXT4_DESC_SIZE(sb);
-	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
-	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
-	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
 	ext4_hash_info_init(sb);
 
-- 
2.31.1

