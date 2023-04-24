Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302F46EC409
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDXDkG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjDXDju (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C3C2D50;
        Sun, 23 Apr 2023 20:39:46 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q4W7r5ZzxzKtYv;
        Mon, 24 Apr 2023 11:38:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:44 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block() return void
Date:   Mon, 24 Apr 2023 11:38:44 +0800
Message-ID: <20230424033846.4732-11-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230424033846.4732-1-libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now it never fails when inserting a delay extent, so the return value in
ext4_es_insert_delayed_block is no longer necessary, let it return void.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 10 ++++------
 fs/ext4/extents_status.h |  4 ++--
 fs/ext4/inode.c          | 10 ++--------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 2a394c40f4b7..b12c5cfdf601 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2020,11 +2020,9 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
  * @lblk - logical block to be added
  * @allocated - indicates whether a physical cluster has been allocated for
  *              the logical cluster that contains the block
- *
- * Returns 0 on success, negative error code on failure.
  */
-int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-				 bool allocated)
+void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
+				  bool allocated)
 {
 	struct extent_status newes;
 	int err1 = 0;
@@ -2033,7 +2031,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status *es2 = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
 		 lblk, inode->i_ino);
@@ -2075,7 +2073,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
-	return 0;
+	return;
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 526a68890aa6..c22edb931f1b 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -249,8 +249,8 @@ extern void ext4_exit_pending(void);
 extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
 extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
 extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
-extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-					bool allocated);
+extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
+					 bool allocated);
 extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a0bfe77d5537..4221b2dafeb5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1641,9 +1641,8 @@ static void ext4_print_free_blocks(struct inode *inode)
 static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int ret;
+	int ret = 0;
 	bool allocated = false;
-	bool reserved = false;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1660,7 +1659,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		ret = ext4_da_reserve_space(inode);
 		if (ret != 0)   /* ENOSPC */
 			goto errout;
-		reserved = true;
 	} else {   /* bigalloc */
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
@@ -1673,7 +1671,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 					ret = ext4_da_reserve_space(inode);
 					if (ret != 0)   /* ENOSPC */
 						goto errout;
-					reserved = true;
 				} else {
 					allocated = true;
 				}
@@ -1683,10 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
-	if (ret && reserved)
-		ext4_da_release_space(inode, 1);
-
+	ext4_es_insert_delayed_block(inode, lblk, allocated);
 errout:
 	return ret;
 }
-- 
2.31.1

