Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C55A627F
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiH3LxX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 07:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiH3LxK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 07:53:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C15A7A92
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 04:53:07 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH5DV6xdhzYcxg;
        Tue, 30 Aug 2022 19:48:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 19:53:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 11/13] ext4: factor out ext4_group_desc_init() and ext4_group_desc_free()
Date:   Tue, 30 Aug 2022 20:04:09 +0800
Message-ID: <20220830120411.2371968-12-yanaijie@huawei.com>
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

Factor out ext4_group_desc_init() and ext4_group_desc_free(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 143 ++++++++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4c6c4930e11b..40f155543df0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4743,9 +4743,89 @@ static int ext4_geometry_check(struct super_block *sb,
 	return 0;
 }
 
+static void ext4_group_desc_free(struct ext4_sb_info *sbi)
+{
+	struct buffer_head **group_desc;
+	int i;
+
+	rcu_read_lock();
+	group_desc = rcu_dereference(sbi->s_group_desc);
+	for (i = 0; i < sbi->s_gdb_count; i++)
+		brelse(group_desc[i]);
+	kvfree(group_desc);
+	rcu_read_unlock();
+}
+
+static int ext4_group_desc_init(struct super_block *sb,
+				struct ext4_super_block *es,
+				ext4_fsblk_t logical_sb_block,
+				ext4_group_t *first_not_zeroed)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	unsigned int db_count;
+	ext4_fsblk_t block;
+	int ret;
+	int i;
+
+	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
+		   EXT4_DESC_PER_BLOCK(sb);
+	if (ext4_has_feature_meta_bg(sb)) {
+		if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
+			ext4_msg(sb, KERN_WARNING,
+				 "first meta block group too large: %u "
+				 "(group descriptor block count %u)",
+				 le32_to_cpu(es->s_first_meta_bg), db_count);
+			return -EINVAL;
+		}
+	}
+	rcu_assign_pointer(sbi->s_group_desc,
+			   kvmalloc_array(db_count,
+					  sizeof(struct buffer_head *),
+					  GFP_KERNEL));
+	if (sbi->s_group_desc == NULL) {
+		ext4_msg(sb, KERN_ERR, "not enough memory");
+		return -ENOMEM;
+	}
+
+	bgl_lock_init(sbi->s_blockgroup_lock);
+
+	/* Pre-read the descriptors into the buffer cache */
+	for (i = 0; i < db_count; i++) {
+		block = descriptor_loc(sb, logical_sb_block, i);
+		ext4_sb_breadahead_unmovable(sb, block);
+	}
+
+	for (i = 0; i < db_count; i++) {
+		struct buffer_head *bh;
+
+		block = descriptor_loc(sb, logical_sb_block, i);
+		bh = ext4_sb_bread_unmovable(sb, block);
+		if (IS_ERR(bh)) {
+			ext4_msg(sb, KERN_ERR,
+			       "can't read group descriptor %d", i);
+			sbi->s_gdb_count = i;
+			ret = PTR_ERR(bh);
+			goto out;
+		}
+		rcu_read_lock();
+		rcu_dereference(sbi->s_group_desc)[i] = bh;
+		rcu_read_unlock();
+	}
+	sbi->s_gdb_count = db_count;
+	if (!ext4_check_descriptors(sb, logical_sb_block, first_not_zeroed)) {
+		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+	return 0;
+out:
+	ext4_group_desc_free(sbi);
+	return ret;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
-	struct buffer_head *bh, **group_desc;
+	struct buffer_head *bh;
 	struct ext4_super_block *es = NULL;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **flex_groups;
@@ -4755,7 +4835,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct inode *root;
 	int ret = -ENOMEM;
 	int blocksize;
-	unsigned int db_count;
 	unsigned int i;
 	int needs_recovery, has_huge_files;
 	int err = 0;
@@ -5046,57 +5125,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_geometry_check(sb, es))
 		goto failed_mount;
 
-	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
-		   EXT4_DESC_PER_BLOCK(sb);
-	if (ext4_has_feature_meta_bg(sb)) {
-		if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
-			ext4_msg(sb, KERN_WARNING,
-				 "first meta block group too large: %u "
-				 "(group descriptor block count %u)",
-				 le32_to_cpu(es->s_first_meta_bg), db_count);
-			goto failed_mount;
-		}
-	}
-	rcu_assign_pointer(sbi->s_group_desc,
-			   kvmalloc_array(db_count,
-					  sizeof(struct buffer_head *),
-					  GFP_KERNEL));
-	if (sbi->s_group_desc == NULL) {
-		ext4_msg(sb, KERN_ERR, "not enough memory");
-		ret = -ENOMEM;
+	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
+	if (err)
 		goto failed_mount;
-	}
-
-	bgl_lock_init(sbi->s_blockgroup_lock);
-
-	/* Pre-read the descriptors into the buffer cache */
-	for (i = 0; i < db_count; i++) {
-		block = descriptor_loc(sb, logical_sb_block, i);
-		ext4_sb_breadahead_unmovable(sb, block);
-	}
-
-	for (i = 0; i < db_count; i++) {
-		struct buffer_head *bh;
-
-		block = descriptor_loc(sb, logical_sb_block, i);
-		bh = ext4_sb_bread_unmovable(sb, block);
-		if (IS_ERR(bh)) {
-			ext4_msg(sb, KERN_ERR,
-			       "can't read group descriptor %d", i);
-			db_count = i;
-			ret = PTR_ERR(bh);
-			goto failed_mount2;
-		}
-		rcu_read_lock();
-		rcu_dereference(sbi->s_group_desc)[i] = bh;
-		rcu_read_unlock();
-	}
-	sbi->s_gdb_count = db_count;
-	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
-		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
-		ret = -EFSCORRUPTED;
-		goto failed_mount2;
-	}
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
 	spin_lock_init(&sbi->s_error_lock);
@@ -5540,13 +5571,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
-failed_mount2:
-	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
-	for (i = 0; i < db_count; i++)
-		brelse(group_desc[i]);
-	kvfree(group_desc);
-	rcu_read_unlock();
+	ext4_group_desc_free(sbi);
 failed_mount:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-- 
2.31.1

