Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82C05BAEE4
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiIPOFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiIPOEw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B1315818
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:49 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTbM25xKVzlVkF;
        Fri, 16 Sep 2022 22:00:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 15/16] ext4: remove useless local variable 'blocksize'
Date:   Fri, 16 Sep 2022 22:15:26 +0800
Message-ID: <20220916141527.1012715-16-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916141527.1012715-1-yanaijie@huawei.com>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since sb->s_blocksize is now initialized at the very beginning, the
local variable 'blocksize' in __ext4_fill_super() is not needed now.
Remove it and use sb->s_blocksize instead.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2301de8bddcb..25813758a53c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4366,7 +4366,7 @@ static void ext4_set_def_opts(struct super_block *sb,
 		set_opt(sb, DELALLOC);
 }
 
-static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
+static int ext4_handle_clustersize(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -4375,24 +4375,24 @@ static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
 	/* Handle clustersize */
 	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
 	if (ext4_has_feature_bigalloc(sb)) {
-		if (clustersize < blocksize) {
+		if (clustersize < sb->s_blocksize) {
 			ext4_msg(sb, KERN_ERR,
 				 "cluster size (%d) smaller than "
-				 "block size (%d)", clustersize, blocksize);
+				 "block size (%lu)", clustersize, sb->s_blocksize);
 			return -EINVAL;
 		}
 		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
 			le32_to_cpu(es->s_log_block_size);
 		sbi->s_clusters_per_group =
 			le32_to_cpu(es->s_clusters_per_group);
-		if (sbi->s_clusters_per_group > blocksize * 8) {
+		if (sbi->s_clusters_per_group > sb->s_blocksize * 8) {
 			ext4_msg(sb, KERN_ERR,
 				 "#clusters per group too big: %lu",
 				 sbi->s_clusters_per_group);
 			return -EINVAL;
 		}
 		if (sbi->s_blocks_per_group !=
-		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
+		    (sbi->s_clusters_per_group * (clustersize / sb->s_blocksize))) {
 			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
 				 "clusters per group (%lu) inconsistent",
 				 sbi->s_blocks_per_group,
@@ -4400,13 +4400,13 @@ static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
 			return -EINVAL;
 		}
 	} else {
-		if (clustersize != blocksize) {
+		if (clustersize != sb->s_blocksize) {
 			ext4_msg(sb, KERN_ERR,
 				 "fragment/cluster size (%d) != "
-				 "block size (%d)", clustersize, blocksize);
+				 "block size (%lu)", clustersize, sb->s_blocksize);
 			return -EINVAL;
 		}
-		if (sbi->s_blocks_per_group > blocksize * 8) {
+		if (sbi->s_blocks_per_group > sb->s_blocksize * 8) {
 			ext4_msg(sb, KERN_ERR,
 				 "#blocks per group too big: %lu",
 				 sbi->s_blocks_per_group);
@@ -4415,7 +4415,7 @@ static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
 		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
 		sbi->s_cluster_bits = 0;
 	}
-	sbi->s_cluster_ratio = clustersize / blocksize;
+	sbi->s_cluster_ratio = clustersize / sb->s_blocksize;
 
 	/* Do we have standard group size of clustersize * 8 blocks ? */
 	if (sbi->s_blocks_per_group == clustersize << 3)
@@ -4449,8 +4449,7 @@ static void ext4_fast_commit_init(struct super_block *sb)
 }
 
 static int ext4_inode_info_init(struct super_block *sb,
-				struct ext4_super_block *es,
-				int blocksize)
+				struct ext4_super_block *es)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
@@ -4467,11 +4466,11 @@ static int ext4_inode_info_init(struct super_block *sb,
 		}
 		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
 		    (!is_power_of_2(sbi->s_inode_size)) ||
-		    (sbi->s_inode_size > blocksize)) {
+		    (sbi->s_inode_size > sb->s_blocksize)) {
 			ext4_msg(sb, KERN_ERR,
 			       "unsupported inode size: %d",
 			       sbi->s_inode_size);
-			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
+			ext4_msg(sb, KERN_ERR, "blocksize: %lu", sb->s_blocksize);
 			return -EINVAL;
 		}
 		/*
@@ -5068,7 +5067,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
-	int blocksize;
 	unsigned int i;
 	int needs_recovery, has_huge_files;
 	int err = 0;
@@ -5091,7 +5089,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto out_fail;
 
 	es = sbi->s_es;
-	blocksize = sb->s_blocksize;
 	sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
 
 	err = ext4_init_metadata_csum(sb, es);
@@ -5112,10 +5109,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 */
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
-	if (blocksize == PAGE_SIZE)
+	if (sb->s_blocksize == PAGE_SIZE)
 		set_opt(sb, DIOREAD_NOLOCK);
 
-	if (ext4_inode_info_init(sb, es, blocksize))
+	if (ext4_inode_info_init(sb, es))
 		goto failed_mount;
 
 	err = parse_apply_sb_mount_options(sb, ctx);
@@ -5142,7 +5139,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
-	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
+	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (sb->s_blocksize / 4)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Number of reserved GDT blocks insanely large: %d",
 			 le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks));
@@ -5150,7 +5147,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	}
 
 	if (sbi->s_daxdev) {
-		if (blocksize == PAGE_SIZE)
+		if (sb->s_blocksize == PAGE_SIZE)
 			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
 		else
 			ext4_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
@@ -5196,21 +5193,21 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
-	sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
+	sbi->s_inodes_per_block = sb->s_blocksize / EXT4_INODE_SIZE(sb);
 	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {
 		if (!silent)
 			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
 		goto failed_mount;
 	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
-	    sbi->s_inodes_per_group > blocksize * 8) {
+	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
 			 sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /
 					sbi->s_inodes_per_block;
-	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
+	sbi->s_desc_per_block = sb->s_blocksize / EXT4_DESC_SIZE(sb);
 	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
@@ -5236,7 +5233,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
-	if (ext4_handle_clustersize(sb, blocksize))
+	if (ext4_handle_clustersize(sb))
 		goto failed_mount;
 
 	/*
@@ -5369,7 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
-	if (ext4_has_feature_verity(sb) && blocksize != PAGE_SIZE) {
+	if (ext4_has_feature_verity(sb) && sb->s_blocksize != PAGE_SIZE) {
 		ext4_msg(sb, KERN_ERR, "Unsupported blocksize for fs-verity");
 		goto failed_mount_wq;
 	}
-- 
2.31.1

