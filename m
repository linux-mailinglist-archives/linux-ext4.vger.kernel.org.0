Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446646C6A7B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCWOIi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCWOIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15725E33
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:11 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Xn23z8zLNyb;
        Thu, 23 Mar 2023 22:04:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 8/8] ext4: move dax and encrypt checking into ext4_check_feature_compatibility()
Date:   Thu, 23 Mar 2023 22:05:17 +0800
Message-ID: <20230323140517.1070239-9-yanaijie@huawei.com>
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

These checkings are also related with feature compatibility checkings.
So move them into ext4_check_feature_compatibility(). No functional
change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 54 +++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 282f8e853893..faba8c17aa95 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4641,6 +4641,8 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
 					    struct ext4_super_block *es,
 					    int silent)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
 	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
 	    (ext4_has_compat_features(sb) ||
 	     ext4_has_ro_compat_features(sb) ||
@@ -4710,6 +4712,32 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
 	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
 		return -EINVAL;
 
+	if (sbi->s_daxdev) {
+		if (sb->s_blocksize == PAGE_SIZE)
+			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
+		else
+			ext4_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
+	}
+
+	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
+		if (ext4_has_feature_inline_data(sb)) {
+			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
+					" that may contain inline data");
+			return -EINVAL;
+		}
+		if (!test_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags)) {
+			ext4_msg(sb, KERN_ERR,
+				"DAX unsupported by block device.");
+			return -EINVAL;
+		}
+	}
+
+	if (ext4_has_feature_encrypt(sb) && es->s_encryption_level) {
+		ext4_msg(sb, KERN_ERR, "Unsupported encryption level %d",
+			 es->s_encryption_level);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -5242,32 +5270,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
-	if (sbi->s_daxdev) {
-		if (sb->s_blocksize == PAGE_SIZE)
-			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
-		else
-			ext4_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
-	}
-
-	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
-		if (ext4_has_feature_inline_data(sb)) {
-			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
-					" that may contain inline data");
-			goto failed_mount;
-		}
-		if (!test_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags)) {
-			ext4_msg(sb, KERN_ERR,
-				"DAX unsupported by block device.");
-			goto failed_mount;
-		}
-	}
-
-	if (ext4_has_feature_encrypt(sb) && es->s_encryption_level) {
-		ext4_msg(sb, KERN_ERR, "Unsupported encryption level %d",
-			 es->s_encryption_level);
-		goto failed_mount;
-	}
-
 	if (ext4_block_group_meta_init(sb, silent))
 		goto failed_mount;
 
-- 
2.31.1

