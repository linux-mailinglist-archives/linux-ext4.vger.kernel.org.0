Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D956F10C4
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjD1DQs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 23:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbjD1DQj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 23:16:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E13C32
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 20:16:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33S3GI8q012421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 23:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682651779; bh=Xax54atyXlWFCcnUv7JwyfDGm1KLpt7aN1wsp/rFaRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FSJvwNTYUU3Pys5unn35oO8gvKp5GeGA01oTCixwS9A5sgGyZEU5uAehfwSw9wyI5
         SC7xaAo0H7k8EJVpczzREVl51mFWUGzDaTIA0z2GnJYYKyoI+t8fC3P5kIFzsS7EF3
         8iJwbAtths/+PaeWIz4HdzLU8HyPYLc6CtAlYWEmysPEmhSGevPzr3sUZihww4nOpN
         bKv1PiSgkRN8EYV+61QWBOH9vheEJPsxVt4NM2KFOd995klRges4u1h1BTDD73Hagv
         D9oMaZvIVc5VfN1TvysoefV6uvVUBFr21PjjfnNVVlhLLMdJkjmDXucdXi5QNHCwLF
         H5FBjcOnS9joA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 47C6915C5337; Thu, 27 Apr 2023 23:16:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Jason Yan <yanaijie@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] ext4: clean up error handling in __ext4_fill_super()
Date:   Thu, 27 Apr 2023 23:16:02 -0400
Message-Id: <20230428031602.242297-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230428031602.242297-1-tytso@mit.edu>
References: <20230428031602.242297-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There were two ways to return an error code; one was via setting the
'err' variable, and the second, if err was zero, was via the 'ret'
variable.  This was both confusing and fragile, and when code was
factored out of __ext4_fill_super(), some of the error codes returned
by the original code was replaced by -EINVAL, and in one case, the
error code was placed by 0, triggering a kernel null pointer
dereference.

Clean this up by removing the 'ret' variable, leaving only one way to
setfthe error code to be returned, and restore the errno codes that
were returned via the the mount system call as they were before we
started refactoring __ext4_fill_super().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 51 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a8af70815b1..662e49195b65 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5196,10 +5196,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
-	int ret = -ENOMEM;
 	unsigned int i;
 	int needs_recovery;
-	int err = 0;
+	int err;
 	ext4_group_t first_not_zeroed;
 	struct ext4_fs_context *ctx = fc->fs_private;
 	int silent = fc->sb_flags & SB_SILENT;
@@ -5212,8 +5211,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_sectors_written_start =
 		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
 
-	/* -EINVAL is default */
-	ret = -EINVAL;
 	err = ext4_load_super(sb, &logical_sb_block, silent);
 	if (err)
 		goto out_fail;
@@ -5239,7 +5236,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 */
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
-	if (ext4_inode_info_init(sb, es))
+	err = ext4_inode_info_init(sb, es);
+	if (err)
 		goto failed_mount;
 
 	err = parse_apply_sb_mount_options(sb, ctx);
@@ -5255,10 +5253,12 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	ext4_apply_options(fc, sb);
 
-	if (ext4_encoding_init(sb, es))
+	err = ext4_encoding_init(sb, es);
+	if (err)
 		goto failed_mount;
 
-	if (ext4_check_journal_data_mode(sb))
+	err = ext4_check_journal_data_mode(sb);
+	if (err)
 		goto failed_mount;
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
@@ -5267,18 +5267,22 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	/* i_version is always enabled now */
 	sb->s_flags |= SB_I_VERSION;
 
-	if (ext4_check_feature_compatibility(sb, es, silent))
+	err = ext4_check_feature_compatibility(sb, es, silent);
+	if (err)
 		goto failed_mount;
 
-	if (ext4_block_group_meta_init(sb, silent))
+	err = ext4_block_group_meta_init(sb, silent);
+	if (err)
 		goto failed_mount;
 
 	ext4_hash_info_init(sb);
 
-	if (ext4_handle_clustersize(sb))
+	err = ext4_handle_clustersize(sb);
+	if (err)
 		goto failed_mount;
 
-	if (ext4_check_geometry(sb, es))
+	err = ext4_check_geometry(sb, es);
+	if (err)
 		goto failed_mount;
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
@@ -5289,8 +5293,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount3;
 
-	/* Register extent status tree shrinker */
-	if (ext4_es_register_shrinker(sbi))
+	err = ext4_es_register_shrinker(sbi);
+	if (err)
 		goto failed_mount3;
 
 	sbi->s_stripe = ext4_get_stripe_size(sbi);
@@ -5335,6 +5339,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount3a;
 	}
 
+	err = -EINVAL;
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
 	 * root first: it may be modified in the journal!
@@ -5386,6 +5391,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		if (!sbi->s_ea_block_cache) {
 			ext4_msg(sb, KERN_ERR,
 				 "Failed to create ea_block_cache");
+			err = -EINVAL;
 			goto failed_mount_wq;
 		}
 
@@ -5394,6 +5400,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			if (!sbi->s_ea_inode_cache) {
 				ext4_msg(sb, KERN_ERR,
 					 "Failed to create ea_inode_cache");
+				err = -EINVAL;
 				goto failed_mount_wq;
 			}
 		}
@@ -5428,7 +5435,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
 	if (!EXT4_SB(sb)->rsv_conversion_wq) {
 		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto failed_mount4;
 	}
 
@@ -5440,28 +5447,28 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(root)) {
 		ext4_msg(sb, KERN_ERR, "get root inode failed");
-		ret = PTR_ERR(root);
+		err = PTR_ERR(root);
 		root = NULL;
 		goto failed_mount4;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		ext4_msg(sb, KERN_ERR, "corrupt root inode, run e2fsck");
 		iput(root);
+		err = -EFSCORRUPTED;
 		goto failed_mount4;
 	}
 
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		ext4_msg(sb, KERN_ERR, "get root dentry failed");
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto failed_mount4;
 	}
 
-	ret = ext4_setup_super(sb, es, sb_rdonly(sb));
-	if (ret == -EROFS) {
+	err = ext4_setup_super(sb, es, sb_rdonly(sb));
+	if (err == -EROFS) {
 		sb->s_flags |= SB_RDONLY;
-		ret = 0;
-	} else if (ret)
+	} else if (err)
 		goto failed_mount4a;
 
 	ext4_set_resv_clusters(sb);
@@ -5514,7 +5521,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			ext4_msg(sb, KERN_ERR,
 			       "unable to initialize "
 			       "flex_bg meta info!");
-			ret = -ENOMEM;
+			err = -ENOMEM;
 			goto failed_mount6;
 		}
 
@@ -5640,7 +5647,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_blkdev_remove(sbi);
 out_fail:
 	sb->s_fs_info = NULL;
-	return err ? err : ret;
+	return err;
 }
 
 static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
-- 
2.31.0

