Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7A6C6A73
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCWOIY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCWOIU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C52B297
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:02 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj6ZB29vfzrTCp;
        Thu, 23 Mar 2023 22:05:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:56 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 2/8] ext4: factor out ext4_percpu_param_init() and ext4_percpu_param_destroy()
Date:   Thu, 23 Mar 2023 22:05:11 +0800
Message-ID: <20230323140517.1070239-3-yanaijie@huawei.com>
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

Factor out ext4_percpu_param_init() and ext4_percpu_param_destroy(). And
also use ext4_percpu_param_destroy() in ext4_put_super() to avoid
duplicated code. No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 85 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ec71b5fb1dca..e346b1f908ed 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1183,6 +1183,49 @@ static inline void ext4_quota_off_umount(struct super_block *sb)
 }
 #endif
 
+static int ext4_percpu_param_init(struct ext4_sb_info *sbi)
+{
+	ext4_fsblk_t block;
+	int err;
+
+	block = ext4_count_free_clusters(sbi->s_sb);
+	ext4_free_blocks_count_set(sbi->s_es, EXT4_C2B(sbi, block));
+	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
+				  GFP_KERNEL);
+	if (!err) {
+		unsigned long freei = ext4_count_free_inodes(sbi->s_sb);
+		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
+		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
+					  GFP_KERNEL);
+	}
+	if (!err)
+		err = percpu_counter_init(&sbi->s_dirs_counter,
+					  ext4_count_dirs(sbi->s_sb), GFP_KERNEL);
+	if (!err)
+		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
+					  GFP_KERNEL);
+	if (!err)
+		err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
+					  GFP_KERNEL);
+	if (!err)
+		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
+
+	if (err)
+		ext4_msg(sbi->s_sb, KERN_ERR, "insufficient memory");
+
+	return err;
+}
+
+static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
+{
+	percpu_counter_destroy(&sbi->s_freeclusters_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1250,12 +1293,7 @@ static void ext4_put_super(struct super_block *sb)
 		kvfree(flex_groups);
 	}
 	rcu_read_unlock();
-	percpu_counter_destroy(&sbi->s_freeclusters_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
-	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
-	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
@@ -5058,7 +5096,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct ext4_super_block *es = NULL;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **flex_groups;
-	ext4_fsblk_t block;
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
@@ -5450,33 +5487,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	block = ext4_count_free_clusters(sb);
-	ext4_free_blocks_count_set(sbi->s_es,
-				   EXT4_C2B(sbi, block));
-	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
-				  GFP_KERNEL);
-	if (!err) {
-		unsigned long freei = ext4_count_free_inodes(sb);
-		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
-		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
-					  GFP_KERNEL);
-	}
-	if (!err)
-		err = percpu_counter_init(&sbi->s_dirs_counter,
-					  ext4_count_dirs(sb), GFP_KERNEL);
-	if (!err)
-		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
-					  GFP_KERNEL);
-	if (!err)
-		err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
-					  GFP_KERNEL);
-	if (!err)
-		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
-
-	if (err) {
-		ext4_msg(sb, KERN_ERR, "insufficient memory");
+	if (ext4_percpu_param_init(sbi))
 		goto failed_mount6;
-	}
 
 	if (ext4_has_feature_flex_bg(sb))
 		if (!ext4_fill_flex_info(sb)) {
@@ -5566,12 +5578,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		kvfree(flex_groups);
 	}
 	rcu_read_unlock();
-	percpu_counter_destroy(&sbi->s_freeclusters_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
-	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
-	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+	ext4_percpu_param_destroy(sbi);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
-- 
2.31.1

