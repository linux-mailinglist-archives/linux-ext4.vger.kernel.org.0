Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1995ABC7B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Sep 2022 04:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiICCvV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Sep 2022 22:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiICCvH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Sep 2022 22:51:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA4AB051
        for <linux-ext4@vger.kernel.org>; Fri,  2 Sep 2022 19:50:59 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MKK1v130FzkWKS;
        Sat,  3 Sep 2022 10:47:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 10:50:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 10/13] ext4: factor out ext4_geometry_check()
Date:   Sat, 3 Sep 2022 11:01:53 +0800
Message-ID: <20220903030156.770313-11-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220903030156.770313-1-yanaijie@huawei.com>
References: <20220903030156.770313-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_geometry_check(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 111 ++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 50 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5f0e7c5188a3..69921a850644 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4683,6 +4683,66 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
 	return 0;
 }
 
+static int ext4_geometry_check(struct super_block *sb,
+			       struct ext4_super_block *es)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	__u64 blocks_count;
+
+	/* check blocks count against device size */
+	blocks_count = sb_bdev_nr_blocks(sb);
+	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
+		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
+		       "exceeds size of device (%llu blocks)",
+		       ext4_blocks_count(es), blocks_count);
+		return -EINVAL;
+	}
+
+	/*
+	 * It makes no sense for the first data block to be beyond the end
+	 * of the filesystem.
+	 */
+	if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
+		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
+			 "block %u is beyond end of filesystem (%llu)",
+			 le32_to_cpu(es->s_first_data_block),
+			 ext4_blocks_count(es));
+		return -EINVAL;
+	}
+	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
+	    (sbi->s_cluster_ratio == 1)) {
+		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
+			 "block is 0 with a 1k block and cluster size");
+		return -EINVAL;
+	}
+
+	blocks_count = (ext4_blocks_count(es) -
+			le32_to_cpu(es->s_first_data_block) +
+			EXT4_BLOCKS_PER_GROUP(sb) - 1);
+	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
+	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
+		ext4_msg(sb, KERN_WARNING, "groups count too large: %llu "
+		       "(block count %llu, first data block %u, "
+		       "blocks per group %lu)", blocks_count,
+		       ext4_blocks_count(es),
+		       le32_to_cpu(es->s_first_data_block),
+		       EXT4_BLOCKS_PER_GROUP(sb));
+		return -EINVAL;
+	}
+	sbi->s_groups_count = blocks_count;
+	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
+			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
+	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4698,7 +4758,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	unsigned int db_count;
 	unsigned int i;
 	int needs_recovery, has_huge_files;
-	__u64 blocks_count;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
 	struct ext4_fs_context *ctx = fc->fs_private;
@@ -4984,57 +5043,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount;
 	}
 
-	/* check blocks count against device size */
-	blocks_count = sb_bdev_nr_blocks(sb);
-	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
-		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
-		       "exceeds size of device (%llu blocks)",
-		       ext4_blocks_count(es), blocks_count);
+	if (ext4_geometry_check(sb, es))
 		goto failed_mount;
-	}
 
-	/*
-	 * It makes no sense for the first data block to be beyond the end
-	 * of the filesystem.
-	 */
-	if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
-		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
-			 "block %u is beyond end of filesystem (%llu)",
-			 le32_to_cpu(es->s_first_data_block),
-			 ext4_blocks_count(es));
-		goto failed_mount;
-	}
-	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
-	    (sbi->s_cluster_ratio == 1)) {
-		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
-			 "block is 0 with a 1k block and cluster size");
-		goto failed_mount;
-	}
-
-	blocks_count = (ext4_blocks_count(es) -
-			le32_to_cpu(es->s_first_data_block) +
-			EXT4_BLOCKS_PER_GROUP(sb) - 1);
-	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
-	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
-		ext4_msg(sb, KERN_WARNING, "groups count too large: %llu "
-		       "(block count %llu, first data block %u, "
-		       "blocks per group %lu)", blocks_count,
-		       ext4_blocks_count(es),
-		       le32_to_cpu(es->s_first_data_block),
-		       EXT4_BLOCKS_PER_GROUP(sb));
-		goto failed_mount;
-	}
-	sbi->s_groups_count = blocks_count;
-	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
-			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
-	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
-	    le32_to_cpu(es->s_inodes_count)) {
-		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
-			 le32_to_cpu(es->s_inodes_count),
-			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
-		ret = -EINVAL;
-		goto failed_mount;
-	}
 	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
 		   EXT4_DESC_PER_BLOCK(sb);
 	if (ext4_has_feature_meta_bg(sb)) {
-- 
2.31.1

