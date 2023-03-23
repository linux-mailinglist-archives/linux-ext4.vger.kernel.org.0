Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0456C6A78
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCWOIa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCWOIZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936772B60C
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:06 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pj6WQ4F31zSnxK;
        Thu, 23 Mar 2023 22:03:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 4/8] ext4: factor out ext4_flex_groups_free()
Date:   Thu, 23 Mar 2023 22:05:13 +0800
Message-ID: <20230323140517.1070239-5-yanaijie@huawei.com>
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

Factor out ext4_flex_groups_free() and it can be used both in
__ext4_fill_super() and ext4_put_super().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0b354a6e4f41..ed7bd3bb45f2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1239,11 +1239,25 @@ static void ext4_group_desc_free(struct ext4_sb_info *sbi)
 	rcu_read_unlock();
 }
 
+static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
+{
+	struct flex_groups **flex_groups;
+	int i;
+
+	rcu_read_lock();
+	flex_groups = rcu_dereference(sbi->s_flex_groups);
+	if (flex_groups) {
+		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
+			kvfree(flex_groups[i]);
+		kvfree(flex_groups);
+	}
+	rcu_read_unlock();
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	struct flex_groups **flex_groups;
 	int aborted = 0;
 	int i, err;
 
@@ -1294,14 +1308,7 @@ static void ext4_put_super(struct super_block *sb)
 		ext4_commit_super(sb);
 
 	ext4_group_desc_free(sbi);
-	rcu_read_lock();
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
-	if (flex_groups) {
-		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
-			kvfree(flex_groups[i]);
-		kvfree(flex_groups);
-	}
-	rcu_read_unlock();
+	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
@@ -5091,7 +5098,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct flex_groups **flex_groups;
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
@@ -5566,14 +5572,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_unregister_li_request(sb);
 failed_mount6:
 	ext4_mb_release(sb);
-	rcu_read_lock();
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
-	if (flex_groups) {
-		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
-			kvfree(flex_groups[i]);
-		kvfree(flex_groups);
-	}
-	rcu_read_unlock();
+	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 failed_mount5:
 	ext4_ext_release(sb);
-- 
2.31.1

