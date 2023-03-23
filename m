Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94576C6A79
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCWOIb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCWOI1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E429A15142
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:07 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Wn64GJzbcSY;
        Thu, 23 Mar 2023 22:03:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:58 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 6/8] ext4: move s_reserved_gdt_blocks and addressable checking into ext4_check_geometry()
Date:   Thu, 23 Mar 2023 22:05:15 +0800
Message-ID: <20230323140517.1070239-7-yanaijie@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These two checkings are more suitable to be put into
ext4_check_geometry() rather than spreading outside.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 66f0da764d58..6c9ffbe5095f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4718,6 +4718,25 @@ static int ext4_check_geometry(struct super_block *sb,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u64 blocks_count;
+	int err;
+
+	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (sb->s_blocksize / 4)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Number of reserved GDT blocks insanely large: %d",
+			 le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks));
+		return -EINVAL;
+	}
+	/*
+	 * Test whether we have more sectors than will fit in sector_t,
+	 * and whether the max offset is addressable by the page cache.
+	 */
+	err = generic_check_addressable(sb->s_blocksize_bits,
+					ext4_blocks_count(es));
+	if (err) {
+		ext4_msg(sb, KERN_ERR, "filesystem"
+			 " too large to mount safely on this system");
+		return err;
+	}
 
 	/* check blocks count against device size */
 	blocks_count = sb_bdev_nr_blocks(sb);
@@ -5174,13 +5193,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
-	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (sb->s_blocksize / 4)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Number of reserved GDT blocks insanely large: %d",
-			 le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks));
-		goto failed_mount;
-	}
-
 	if (sbi->s_daxdev) {
 		if (sb->s_blocksize == PAGE_SIZE)
 			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
@@ -5252,18 +5264,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_handle_clustersize(sb))
 		goto failed_mount;
 
-	/*
-	 * Test whether we have more sectors than will fit in sector_t,
-	 * and whether the max offset is addressable by the page cache.
-	 */
-	err = generic_check_addressable(sb->s_blocksize_bits,
-					ext4_blocks_count(es));
-	if (err) {
-		ext4_msg(sb, KERN_ERR, "filesystem"
-			 " too large to mount safely on this system");
-		goto failed_mount;
-	}
-
 	if (ext4_check_geometry(sb, es))
 		goto failed_mount;
 
-- 
2.31.1

