Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FDA6C6A75
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCWOI1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWOIX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6B2B602
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:03 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj6ZB5Rn0zrWYZ;
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
Subject: [PATCH 3/8] ext4: use ext4_group_desc_free() in ext4_put_super() to save some duplicated code
Date:   Thu, 23 Mar 2023 22:05:12 +0800
Message-ID: <20230323140517.1070239-4-yanaijie@huawei.com>
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

The only difference here is that ->s_group_desc and ->s_flex_groups share
the same rcu read lock here but it is not necessary. In other places they
do not share the lock at all.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e346b1f908ed..0b354a6e4f41 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1226,11 +1226,23 @@ static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
 	percpu_free_rwsem(&sbi->s_writepages_rwsem);
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
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	struct buffer_head **group_desc;
 	struct flex_groups **flex_groups;
 	int aborted = 0;
 	int i, err;
@@ -1281,11 +1293,8 @@ static void ext4_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		ext4_commit_super(sb);
 
+	ext4_group_desc_free(sbi);
 	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
-	for (i = 0; i < sbi->s_gdb_count; i++)
-		brelse(group_desc[i]);
-	kvfree(group_desc);
 	flex_groups = rcu_dereference(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
@@ -4757,19 +4766,6 @@ static int ext4_geometry_check(struct super_block *sb,
 	return 0;
 }
 
-static void ext4_group_desc_free(struct ext4_sb_info *sbi)
-{
-	struct buffer_head **group_desc;
-	int i;
-
-	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
-	for (i = 0; i < sbi->s_gdb_count; i++)
-		brelse(group_desc[i]);
-	kvfree(group_desc);
-	rcu_read_unlock();
-}
-
 static int ext4_group_desc_init(struct super_block *sb,
 				struct ext4_super_block *es,
 				ext4_fsblk_t logical_sb_block,
-- 
2.31.1

