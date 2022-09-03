Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC65ABC75
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Sep 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiICCu7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Sep 2022 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiICCu5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Sep 2022 22:50:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D886FE7
        for <linux-ext4@vger.kernel.org>; Fri,  2 Sep 2022 19:50:56 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MKK102vZGzWf6N;
        Sat,  3 Sep 2022 10:46:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 10:50:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 02/13] ext4: remove cantfind_ext4 error handler
Date:   Sat, 3 Sep 2022 11:01:45 +0800
Message-ID: <20220903030156.770313-3-yanaijie@huawei.com>
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

The 'cantfind_ext4' error handler is just a error msg print and then
goto failed_mount. This two level goto makes the code complex and not
easy to read. The only benefit is that is saves a little bit code.
However some branches can merge and some branches dot not even need it.
So do some refactor and remove it.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6126da867b26..6fced457ba3f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4373,8 +4373,12 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	es = (struct ext4_super_block *) (bh->b_data + offset);
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
-	if (sb->s_magic != EXT4_SUPER_MAGIC)
-		goto cantfind_ext4;
+	if (sb->s_magic != EXT4_SUPER_MAGIC) {
+		if (!silent)
+			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
+		goto failed_mount;
+	}
+
 	sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
 
 	/* Warn if metadata_csum and gdt_csum are both set. */
@@ -4387,8 +4391,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (!ext4_verify_csum_type(sb, es)) {
 		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
 			 "unknown checksum algorithm.");
-		silent = 1;
-		goto cantfind_ext4;
+		goto failed_mount;
 	}
 	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
 				ext4_orphan_file_block_trigger);
@@ -4406,9 +4409,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (!ext4_superblock_csum_verify(sb, es)) {
 		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
 			 "invalid superblock checksum.  Run e2fsck?");
-		silent = 1;
 		ret = -EFSBADCRC;
-		goto cantfind_ext4;
+		goto failed_mount;
 	}
 
 	/* Precompute checksum seed for all metadata */
@@ -4798,8 +4800,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
 	sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
-	if (sbi->s_inodes_per_block == 0)
-		goto cantfind_ext4;
+	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {
+		if (!silent)
+			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
+		goto failed_mount;
+	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > blocksize * 8) {
 		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
@@ -4896,9 +4901,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount;
 	}
 
-	if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
-		goto cantfind_ext4;
-
 	/* check blocks count against device size */
 	blocks_count = sb_bdev_nr_blocks(sb);
 	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
@@ -5408,11 +5410,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	return 0;
 
-cantfind_ext4:
-	if (!silent)
-		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
-	goto failed_mount;
-
 failed_mount9:
 	ext4_release_orphan_info(sb);
 failed_mount8:
-- 
2.31.1

