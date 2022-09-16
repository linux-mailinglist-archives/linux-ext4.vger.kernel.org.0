Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445C5BAEDE
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIPOE6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiIPOEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984051705B
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:45 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTbLG1gTBzNm5r;
        Fri, 16 Sep 2022 22:00:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:43 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 07/16] ext4: factor out ext4_encoding_init()
Date:   Fri, 16 Sep 2022 22:15:18 +0800
Message-ID: <20220916141527.1012715-8-yanaijie@huawei.com>
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

Factor out ext4_encoding_init(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 86 ++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f8806226b796..b1d9395999c2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4521,6 +4521,54 @@ static int ext4_inode_info_init(struct super_block *sb,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_UNICODE)
+static int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *es)
+{
+	const struct ext4_sb_encodings *encoding_info;
+	struct unicode_map *encoding;
+	__u16 encoding_flags = le16_to_cpu(es->s_encoding_flags);
+
+	if (!ext4_has_feature_casefold(sb) || sb->s_encoding)
+		return 0;
+
+	encoding_info = ext4_sb_read_encoding(es);
+	if (!encoding_info) {
+		ext4_msg(sb, KERN_ERR,
+			"Encoding requested by superblock is unknown");
+		return -EINVAL;
+	}
+
+	encoding = utf8_load(encoding_info->version);
+	if (IS_ERR(encoding)) {
+		ext4_msg(sb, KERN_ERR,
+			"can't mount with superblock charset: %s-%u.%u.%u "
+			"not supported by the kernel. flags: 0x%x.",
+			encoding_info->name,
+			unicode_major(encoding_info->version),
+			unicode_minor(encoding_info->version),
+			unicode_rev(encoding_info->version),
+			encoding_flags);
+		return -EINVAL;
+	}
+	ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
+		"%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
+		unicode_major(encoding_info->version),
+		unicode_minor(encoding_info->version),
+		unicode_rev(encoding_info->version),
+		encoding_flags);
+
+	sb->s_encoding = encoding;
+	sb->s_encoding_flags = encoding_flags;
+
+	return 0;
+}
+#else
+static inline int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *es)
+{
+	return 0;
+}
+#endif
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4678,42 +4726,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	ext4_apply_options(fc, sb);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
-		const struct ext4_sb_encodings *encoding_info;
-		struct unicode_map *encoding;
-		__u16 encoding_flags = le16_to_cpu(es->s_encoding_flags);
-
-		encoding_info = ext4_sb_read_encoding(es);
-		if (!encoding_info) {
-			ext4_msg(sb, KERN_ERR,
-				 "Encoding requested by superblock is unknown");
-			goto failed_mount;
-		}
-
-		encoding = utf8_load(encoding_info->version);
-		if (IS_ERR(encoding)) {
-			ext4_msg(sb, KERN_ERR,
-				 "can't mount with superblock charset: %s-%u.%u.%u "
-				 "not supported by the kernel. flags: 0x%x.",
-				 encoding_info->name,
-				 unicode_major(encoding_info->version),
-				 unicode_minor(encoding_info->version),
-				 unicode_rev(encoding_info->version),
-				 encoding_flags);
-			goto failed_mount;
-		}
-		ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
-			 "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
-			 unicode_major(encoding_info->version),
-			 unicode_minor(encoding_info->version),
-			 unicode_rev(encoding_info->version),
-			 encoding_flags);
-
-		sb->s_encoding = encoding;
-		sb->s_encoding_flags = encoding_flags;
-	}
-#endif
+	if (ext4_encoding_init(sb, es))
+		goto failed_mount;
 
 	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
 		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
-- 
2.31.1

