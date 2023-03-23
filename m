Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537016C6A74
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWOIZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCWOIU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C8C2BECE
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:01 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Z95yZpzrWYH;
        Thu, 23 Mar 2023 22:05:53 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:55 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/8] ext4: factor out ext4_hash_info_init()
Date:   Thu, 23 Mar 2023 22:05:10 +0800
Message-ID: <20230323140517.1070239-2-yanaijie@huawei.com>
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

Factor out ext4_hash_info_init() to simplify __ext4_fill_super(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f43e526112ae..ec71b5fb1dca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5024,6 +5024,35 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	return ret;
 }
 
+static void ext4_hash_info_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
+
+	sbi->s_def_hash_version = es->s_def_hash_version;
+	if (ext4_has_feature_dir_index(sb)) {
+		i = le32_to_cpu(es->s_flags);
+		if (i & EXT2_FLAGS_UNSIGNED_HASH)
+			sbi->s_hash_unsigned = 3;
+		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
+#ifdef __CHAR_UNSIGNED__
+			if (!sb_rdonly(sb))
+				es->s_flags |=
+					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
+			sbi->s_hash_unsigned = 3;
+#else
+			if (!sb_rdonly(sb))
+				es->s_flags |=
+					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
+#endif
+		}
+	}
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5179,26 +5208,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
-	for (i = 0; i < 4; i++)
-		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
-	sbi->s_def_hash_version = es->s_def_hash_version;
-	if (ext4_has_feature_dir_index(sb)) {
-		i = le32_to_cpu(es->s_flags);
-		if (i & EXT2_FLAGS_UNSIGNED_HASH)
-			sbi->s_hash_unsigned = 3;
-		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
-#ifdef __CHAR_UNSIGNED__
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
-			sbi->s_hash_unsigned = 3;
-#else
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
-#endif
-		}
-	}
+	ext4_hash_info_init(sb);
 
 	if (ext4_handle_clustersize(sb))
 		goto failed_mount;
-- 
2.31.1

