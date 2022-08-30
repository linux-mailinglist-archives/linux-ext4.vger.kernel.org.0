Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E208C5A6277
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiH3LxL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 07:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiH3LxE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 07:53:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54EC9A98C
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 04:53:03 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH5Fb0JGfzlWS5;
        Tue, 30 Aug 2022 19:49:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 19:53:01 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 03/13] ext4: factor out ext4_set_def_opts()
Date:   Tue, 30 Aug 2022 20:04:01 +0800
Message-ID: <20220830120411.2371968-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830120411.2371968-1-yanaijie@huawei.com>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Factor out ext4_set_def_opts(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 105 ++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7341340e3c98..66a128e5a9c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4311,6 +4311,61 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	return NULL;
 }
 
+static void ext4_set_def_opts(struct super_block *sb,
+			      struct ext4_super_block *es)
+{
+	unsigned long def_mount_opts;
+
+	/* Set defaults before we parse the mount options */
+	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
+	set_opt(sb, INIT_INODE_TABLE);
+	if (def_mount_opts & EXT4_DEFM_DEBUG)
+		set_opt(sb, DEBUG);
+	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
+		set_opt(sb, GRPID);
+	if (def_mount_opts & EXT4_DEFM_UID16)
+		set_opt(sb, NO_UID32);
+	/* xattr user namespace & acls are now defaulted on */
+	set_opt(sb, XATTR_USER);
+#ifdef CONFIG_EXT4_FS_POSIX_ACL
+	set_opt(sb, POSIX_ACL);
+#endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
+	/* don't forget to enable journal_csum when metadata_csum is enabled. */
+	if (ext4_has_metadata_csum(sb))
+		set_opt(sb, JOURNAL_CHECKSUM);
+
+	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
+		set_opt(sb, JOURNAL_DATA);
+	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
+		set_opt(sb, ORDERED_DATA);
+	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
+		set_opt(sb, WRITEBACK_DATA);
+
+	if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_PANIC)
+		set_opt(sb, ERRORS_PANIC);
+	else if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_CONTINUE)
+		set_opt(sb, ERRORS_CONT);
+	else
+		set_opt(sb, ERRORS_RO);
+	/* block_validity enabled by default; disable with noblock_validity */
+	set_opt(sb, BLOCK_VALIDITY);
+	if (def_mount_opts & EXT4_DEFM_DISCARD)
+		set_opt(sb, DISCARD);
+
+	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
+		set_opt(sb, BARRIER);
+
+	/*
+	 * enable delayed allocation by default
+	 * Use -o nodelalloc to turn it off
+	 */
+	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
+	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
+		set_opt(sb, DELALLOC);
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4320,7 +4375,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t block;
 	ext4_fsblk_t logical_sb_block;
 	unsigned long offset = 0;
-	unsigned long def_mount_opts;
 	struct inode *root;
 	int ret = -ENOMEM;
 	int blocksize, clustersize;
@@ -4420,43 +4474,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
 					       sizeof(es->s_uuid));
 
-	/* Set defaults before we parse the mount options */
-	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
-	set_opt(sb, INIT_INODE_TABLE);
-	if (def_mount_opts & EXT4_DEFM_DEBUG)
-		set_opt(sb, DEBUG);
-	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
-		set_opt(sb, GRPID);
-	if (def_mount_opts & EXT4_DEFM_UID16)
-		set_opt(sb, NO_UID32);
-	/* xattr user namespace & acls are now defaulted on */
-	set_opt(sb, XATTR_USER);
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
-	set_opt(sb, POSIX_ACL);
-#endif
-	if (ext4_has_feature_fast_commit(sb))
-		set_opt2(sb, JOURNAL_FAST_COMMIT);
-	/* don't forget to enable journal_csum when metadata_csum is enabled. */
-	if (ext4_has_metadata_csum(sb))
-		set_opt(sb, JOURNAL_CHECKSUM);
-
-	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
-		set_opt(sb, JOURNAL_DATA);
-	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
-		set_opt(sb, ORDERED_DATA);
-	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
-		set_opt(sb, WRITEBACK_DATA);
-
-	if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_PANIC)
-		set_opt(sb, ERRORS_PANIC);
-	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_CONTINUE)
-		set_opt(sb, ERRORS_CONT);
-	else
-		set_opt(sb, ERRORS_RO);
-	/* block_validity enabled by default; disable with noblock_validity */
-	set_opt(sb, BLOCK_VALIDITY);
-	if (def_mount_opts & EXT4_DEFM_DISCARD)
-		set_opt(sb, DISCARD);
+	ext4_set_def_opts(sb, es);
 
 	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
 	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
@@ -4464,17 +4482,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
 
-	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
-		set_opt(sb, BARRIER);
-
-	/*
-	 * enable delayed allocation by default
-	 * Use -o nodelalloc to turn it off
-	 */
-	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
-	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
-		set_opt(sb, DELALLOC);
-
 	/*
 	 * set default s_li_wait_mult for lazyinit, for the case there is
 	 * no mount option specified.
-- 
2.31.1

