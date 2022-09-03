Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA795ABC79
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Sep 2022 04:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiICCvT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Sep 2022 22:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiICCvH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Sep 2022 22:51:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E70797D5E
        for <linux-ext4@vger.kernel.org>; Fri,  2 Sep 2022 19:50:59 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MKK3J2N5SznTsZ;
        Sat,  3 Sep 2022 10:48:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 10:50:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 09/13] ext4: factor out ext4_check_feature_compatibility()
Date:   Sat, 3 Sep 2022 11:01:52 +0800
Message-ID: <20220903030156.770313-10-yanaijie@huawei.com>
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

Factor out ext4_check_feature_compatibility(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 144 ++++++++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 09a1eef24cdc..5f0e7c5188a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4607,6 +4607,82 @@ static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_blo
 	return 0;
 }
 
+static int ext4_check_feature_compatibility(struct super_block *sb,
+					    struct ext4_super_block *es,
+					    int silent)
+{
+	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
+	    (ext4_has_compat_features(sb) ||
+	     ext4_has_ro_compat_features(sb) ||
+	     ext4_has_incompat_features(sb)))
+		ext4_msg(sb, KERN_WARNING,
+		       "feature flags set on rev 0 fs, "
+		       "running e2fsck is recommended");
+
+	if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
+		set_opt2(sb, HURD_COMPAT);
+		if (ext4_has_feature_64bit(sb)) {
+			ext4_msg(sb, KERN_ERR,
+				 "The Hurd can't support 64-bit file systems");
+			return -EINVAL;
+		}
+
+		/*
+		 * ea_inode feature uses l_i_version field which is not
+		 * available in HURD_COMPAT mode.
+		 */
+		if (ext4_has_feature_ea_inode(sb)) {
+			ext4_msg(sb, KERN_ERR,
+				 "ea_inode feature is not supported for Hurd");
+			return -EINVAL;
+		}
+	}
+
+	if (IS_EXT2_SB(sb)) {
+		if (ext2_feature_set_ok(sb))
+			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
+				 "using the ext4 subsystem");
+		else {
+			/*
+			 * If we're probing be silent, if this looks like
+			 * it's actually an ext[34] filesystem.
+			 */
+			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
+				return -EINVAL;
+			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
+				 "to feature incompatibilities");
+			return -EINVAL;
+		}
+	}
+
+	if (IS_EXT3_SB(sb)) {
+		if (ext3_feature_set_ok(sb))
+			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
+				 "using the ext4 subsystem");
+		else {
+			/*
+			 * If we're probing be silent, if this looks like
+			 * it's actually an ext4 filesystem.
+			 */
+			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
+				return -EINVAL;
+			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
+				 "to feature incompatibilities");
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Check feature flags regardless of the revision level, since we
+	 * previously didn't change the revision level when setting the flags,
+	 * so there is a chance incompat flags are set on a rev 0 filesystem.
+	 */
+	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4761,73 +4837,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
-	    (ext4_has_compat_features(sb) ||
-	     ext4_has_ro_compat_features(sb) ||
-	     ext4_has_incompat_features(sb)))
-		ext4_msg(sb, KERN_WARNING,
-		       "feature flags set on rev 0 fs, "
-		       "running e2fsck is recommended");
-
-	if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
-		set_opt2(sb, HURD_COMPAT);
-		if (ext4_has_feature_64bit(sb)) {
-			ext4_msg(sb, KERN_ERR,
-				 "The Hurd can't support 64-bit file systems");
-			goto failed_mount;
-		}
-
-		/*
-		 * ea_inode feature uses l_i_version field which is not
-		 * available in HURD_COMPAT mode.
-		 */
-		if (ext4_has_feature_ea_inode(sb)) {
-			ext4_msg(sb, KERN_ERR,
-				 "ea_inode feature is not supported for Hurd");
-			goto failed_mount;
-		}
-	}
-
-	if (IS_EXT2_SB(sb)) {
-		if (ext2_feature_set_ok(sb))
-			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
-				 "using the ext4 subsystem");
-		else {
-			/*
-			 * If we're probing be silent, if this looks like
-			 * it's actually an ext[34] filesystem.
-			 */
-			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
-				goto failed_mount;
-			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
-				 "to feature incompatibilities");
-			goto failed_mount;
-		}
-	}
-
-	if (IS_EXT3_SB(sb)) {
-		if (ext3_feature_set_ok(sb))
-			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
-				 "using the ext4 subsystem");
-		else {
-			/*
-			 * If we're probing be silent, if this looks like
-			 * it's actually an ext4 filesystem.
-			 */
-			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
-				goto failed_mount;
-			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
-				 "to feature incompatibilities");
-			goto failed_mount;
-		}
-	}
-
-	/*
-	 * Check feature flags regardless of the revision level, since we
-	 * previously didn't change the revision level when setting the flags,
-	 * so there is a chance incompat flags are set on a rev 0 filesystem.
-	 */
-	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
+	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
 	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
-- 
2.31.1

