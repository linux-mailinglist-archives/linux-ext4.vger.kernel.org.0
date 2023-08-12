Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004F779DDF
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Aug 2023 09:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHLHTL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Aug 2023 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLHTL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Aug 2023 03:19:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E29C
        for <linux-ext4@vger.kernel.org>; Sat, 12 Aug 2023 00:19:10 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNBn13w8WzTmNG;
        Sat, 12 Aug 2023 15:17:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 15:19:08 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] ext4: mballoc: Use LIST_HEAD() to initialize the list_head
Date:   Sat, 12 Aug 2023 15:18:39 +0800
Message-ID: <20230812071839.3481909-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use LIST_HEAD() to initialize the list_head instead of open-coding it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 fs/ext4/mballoc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 21b903fe546e..2130a310b784 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3501,11 +3501,10 @@ static void ext4_discard_work(struct work_struct *work)
 	struct super_block *sb = sbi->s_sb;
 	struct ext4_free_data *fd, *nfd;
 	struct ext4_buddy e4b;
-	struct list_head discard_list;
+	LIST_HEAD(discard_list);
 	ext4_group_t grp, load_grp;
 	int err = 0;
 
-	INIT_LIST_HEAD(&discard_list);
 	spin_lock(&sbi->s_md_lock);
 	list_splice_init(&sbi->s_discard_list, &discard_list);
 	spin_unlock(&sbi->s_md_lock);
@@ -3879,12 +3878,10 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_free_data *entry, *tmp;
-	struct list_head freed_data_list;
+	LIST_HEAD(freed_data_list);
 	struct list_head *cut_pos = NULL;
 	bool wake;
 
-	INIT_LIST_HEAD(&freed_data_list);
-
 	spin_lock(&sbi->s_md_lock);
 	list_for_each_entry(entry, &sbi->s_freed_data_list, efd_list) {
 		if (entry->efd_tid != commit_tid)
@@ -5419,7 +5416,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_prealloc_space *pa, *tmp;
-	struct list_head list;
+	LIST_HEAD(list);
 	struct ext4_buddy e4b;
 	struct ext4_inode_info *ei;
 	int err;
@@ -5448,7 +5445,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		goto out_dbg;
 	}
 
-	INIT_LIST_HEAD(&list);
 	ext4_lock_group(sb, group);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
@@ -5529,7 +5525,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_prealloc_space *pa, *tmp;
 	ext4_group_t group = 0;
-	struct list_head list;
+	LIST_HEAD(list);
 	struct ext4_buddy e4b;
 	struct rb_node *iter;
 	int err;
@@ -5546,8 +5542,6 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	trace_ext4_discard_preallocations(inode,
 			atomic_read(&ei->i_prealloc_active), needed);
 
-	INIT_LIST_HEAD(&list);
-
 	if (needed == 0)
 		needed = UINT_MAX;
 
@@ -5865,13 +5859,11 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 {
 	ext4_group_t group = 0;
 	struct ext4_buddy e4b;
-	struct list_head discard_list;
+	LIST_HEAD(discard_list);
 	struct ext4_prealloc_space *pa, *tmp;
 
 	mb_debug(sb, "discard locality group preallocation\n");
 
-	INIT_LIST_HEAD(&discard_list);
-
 	spin_lock(&lg->lg_prealloc_lock);
 	list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[order],
 				pa_node.lg_list,
-- 
2.34.1

