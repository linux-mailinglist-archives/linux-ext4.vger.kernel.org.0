Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3D6DF5C7
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDLMmn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjDLMmS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8047DBB;
        Wed, 12 Apr 2023 05:42:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PxMgk395czSrt2;
        Wed, 12 Apr 2023 20:38:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 20:42:06 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return void
Date:   Wed, 12 Apr 2023 20:41:24 +0800
Message-ID: <20230412124126.2286716-7-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230412124126.2286716-1-libaokun1@huawei.com>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now it never fails when inserting a delay extent, so the return value in
ext4_es_insert_delayed_block is no longer necessary, let it return void.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	New added.

 fs/ext4/extents_status.c | 23 ++++++-----------------
 fs/ext4/extents_status.h |  4 ++--
 fs/ext4/inode.c          |  7 ++-----
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 1ba2dd14367c..047ec2fc4899 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1980,17 +1980,14 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
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
-	int err = 0;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
 		 lblk, inode->i_ino);
@@ -2005,24 +2002,16 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
 	__es_remove_extent(inode, lblk, lblk, NULL);
-retry:
-	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err != 0)
-		goto error;
+
+	/* We never return an error when inserting a delayed extent. */
+	(void) __es_insert_extent(inode, &newes);
 
 	if (allocated)
 		__insert_pending(inode, lblk);
-
-error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
-
-	return err;
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
index 3bd4d5bbf0aa..9fd3d526f591 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1635,7 +1635,7 @@ static void ext4_print_free_blocks(struct inode *inode)
 static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int ret;
+	int ret = 0;
 	bool allocated = false;
 	bool reserved = false;
 
@@ -1677,10 +1677,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
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

