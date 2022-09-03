Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F55ABC74
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Sep 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiICCvB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Sep 2022 22:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiICCu6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Sep 2022 22:50:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FE87688
        for <linux-ext4@vger.kernel.org>; Fri,  2 Sep 2022 19:50:57 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MKK3G0CrTznTsT;
        Sat,  3 Sep 2022 10:48:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 10:50:55 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 04/13] ext4: factor out ext4_handle_clustersize()
Date:   Sat, 3 Sep 2022 11:01:47 +0800
Message-ID: <20220903030156.770313-5-yanaijie@huawei.com>
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

Factor out ext4_handle_clustersize(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 110 +++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7cc499a221ff..09b3c51d472b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4366,6 +4366,64 @@ static void ext4_set_def_opts(struct super_block *sb,
 		set_opt(sb, DELALLOC);
 }
 
+static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	int clustersize;
+
+	/* Handle clustersize */
+	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
+	if (ext4_has_feature_bigalloc(sb)) {
+		if (clustersize < blocksize) {
+			ext4_msg(sb, KERN_ERR,
+				 "cluster size (%d) smaller than "
+				 "block size (%d)", clustersize, blocksize);
+			return -EINVAL;
+		}
+		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
+			le32_to_cpu(es->s_log_block_size);
+		sbi->s_clusters_per_group =
+			le32_to_cpu(es->s_clusters_per_group);
+		if (sbi->s_clusters_per_group > blocksize * 8) {
+			ext4_msg(sb, KERN_ERR,
+				 "#clusters per group too big: %lu",
+				 sbi->s_clusters_per_group);
+			return -EINVAL;
+		}
+		if (sbi->s_blocks_per_group !=
+		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
+			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
+				 "clusters per group (%lu) inconsistent",
+				 sbi->s_blocks_per_group,
+				 sbi->s_clusters_per_group);
+			return -EINVAL;
+		}
+	} else {
+		if (clustersize != blocksize) {
+			ext4_msg(sb, KERN_ERR,
+				 "fragment/cluster size (%d) != "
+				 "block size (%d)", clustersize, blocksize);
+			return -EINVAL;
+		}
+		if (sbi->s_blocks_per_group > blocksize * 8) {
+			ext4_msg(sb, KERN_ERR,
+				 "#blocks per group too big: %lu",
+				 sbi->s_blocks_per_group);
+			return -EINVAL;
+		}
+		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
+		sbi->s_cluster_bits = 0;
+	}
+	sbi->s_cluster_ratio = clustersize / blocksize;
+
+	/* Do we have standard group size of clustersize * 8 blocks ? */
+	if (sbi->s_blocks_per_group == clustersize << 3)
+		set_opt2(sb, STD_GROUP_SIZE);
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4377,7 +4435,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	unsigned long offset = 0;
 	struct inode *root;
 	int ret = -ENOMEM;
-	int blocksize, clustersize;
+	int blocksize;
 	unsigned int db_count;
 	unsigned int i;
 	int needs_recovery, has_huge_files;
@@ -4847,54 +4905,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
-	/* Handle clustersize */
-	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
-	if (ext4_has_feature_bigalloc(sb)) {
-		if (clustersize < blocksize) {
-			ext4_msg(sb, KERN_ERR,
-				 "cluster size (%d) smaller than "
-				 "block size (%d)", clustersize, blocksize);
-			goto failed_mount;
-		}
-		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
-			le32_to_cpu(es->s_log_block_size);
-		sbi->s_clusters_per_group =
-			le32_to_cpu(es->s_clusters_per_group);
-		if (sbi->s_clusters_per_group > blocksize * 8) {
-			ext4_msg(sb, KERN_ERR,
-				 "#clusters per group too big: %lu",
-				 sbi->s_clusters_per_group);
-			goto failed_mount;
-		}
-		if (sbi->s_blocks_per_group !=
-		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
-			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
-				 "clusters per group (%lu) inconsistent",
-				 sbi->s_blocks_per_group,
-				 sbi->s_clusters_per_group);
-			goto failed_mount;
-		}
-	} else {
-		if (clustersize != blocksize) {
-			ext4_msg(sb, KERN_ERR,
-				 "fragment/cluster size (%d) != "
-				 "block size (%d)", clustersize, blocksize);
-			goto failed_mount;
-		}
-		if (sbi->s_blocks_per_group > blocksize * 8) {
-			ext4_msg(sb, KERN_ERR,
-				 "#blocks per group too big: %lu",
-				 sbi->s_blocks_per_group);
-			goto failed_mount;
-		}
-		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
-		sbi->s_cluster_bits = 0;
-	}
-	sbi->s_cluster_ratio = clustersize / blocksize;
-
-	/* Do we have standard group size of clustersize * 8 blocks ? */
-	if (sbi->s_blocks_per_group == clustersize << 3)
-		set_opt2(sb, STD_GROUP_SIZE);
+	if (ext4_handle_clustersize(sb, blocksize))
+		goto failed_mount;
 
 	/*
 	 * Test whether we have more sectors than will fit in sector_t,
-- 
2.31.1

