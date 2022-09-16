Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFAA5BAEE7
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIPOFp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiIPOFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:05:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AF481CC
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:05:17 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTbMC5fdQzmVSR;
        Fri, 16 Sep 2022 22:00:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:43 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 08/16] ext4: factor out ext4_init_metadata_csum()
Date:   Fri, 16 Sep 2022 22:15:19 +0800
Message-ID: <20220916141527.1012715-9-yanaijie@huawei.com>
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

Factor out ext4_init_metadata_csum(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 83 +++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b1d9395999c2..94e4045c0e76 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4569,6 +4569,50 @@ static inline int ext4_encoding_init(struct super_block *sb, struct ext4_super_b
 }
 #endif
 
+static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_block *es)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	/* Warn if metadata_csum and gdt_csum are both set. */
+	if (ext4_has_feature_metadata_csum(sb) &&
+	    ext4_has_feature_gdt_csum(sb))
+		ext4_warning(sb, "metadata_csum and uninit_bg are "
+			     "redundant flags; please run fsck.");
+
+	/* Check for a known checksum algorithm */
+	if (!ext4_verify_csum_type(sb, es)) {
+		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
+			 "unknown checksum algorithm.");
+		return -EINVAL;
+	}
+	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
+				ext4_orphan_file_block_trigger);
+
+	/* Load the checksum driver */
+	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
+	if (IS_ERR(sbi->s_chksum_driver)) {
+		int ret = PTR_ERR(sbi->s_chksum_driver);
+		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
+		sbi->s_chksum_driver = NULL;
+		return ret;
+	}
+
+	/* Check superblock checksum */
+	if (!ext4_superblock_csum_verify(sb, es)) {
+		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
+			 "invalid superblock checksum.  Run e2fsck?");
+		return -EFSBADCRC;
+	}
+
+	/* Precompute checksum seed for all metadata */
+	if (ext4_has_feature_csum_seed(sb))
+		sbi->s_csum_seed = le32_to_cpu(es->s_checksum_seed);
+	else if (ext4_has_metadata_csum(sb) || ext4_has_feature_ea_inode(sb))
+		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
+					       sizeof(es->s_uuid));
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4638,44 +4682,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
 
-	/* Warn if metadata_csum and gdt_csum are both set. */
-	if (ext4_has_feature_metadata_csum(sb) &&
-	    ext4_has_feature_gdt_csum(sb))
-		ext4_warning(sb, "metadata_csum and uninit_bg are "
-			     "redundant flags; please run fsck.");
-
-	/* Check for a known checksum algorithm */
-	if (!ext4_verify_csum_type(sb, es)) {
-		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
-			 "unknown checksum algorithm.");
-		goto failed_mount;
-	}
-	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
-				ext4_orphan_file_block_trigger);
-
-	/* Load the checksum driver */
-	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
-	if (IS_ERR(sbi->s_chksum_driver)) {
-		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
-		ret = PTR_ERR(sbi->s_chksum_driver);
-		sbi->s_chksum_driver = NULL;
-		goto failed_mount;
-	}
-
-	/* Check superblock checksum */
-	if (!ext4_superblock_csum_verify(sb, es)) {
-		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
-			 "invalid superblock checksum.  Run e2fsck?");
-		ret = -EFSBADCRC;
+	err = ext4_init_metadata_csum(sb, es);
+	if (err)
 		goto failed_mount;
-	}
-
-	/* Precompute checksum seed for all metadata */
-	if (ext4_has_feature_csum_seed(sb))
-		sbi->s_csum_seed = le32_to_cpu(es->s_checksum_seed);
-	else if (ext4_has_metadata_csum(sb) || ext4_has_feature_ea_inode(sb))
-		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
-					       sizeof(es->s_uuid));
 
 	ext4_set_def_opts(sb, es);
 
-- 
2.31.1

