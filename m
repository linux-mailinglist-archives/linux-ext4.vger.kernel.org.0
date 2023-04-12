Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831D56DF5C2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDLMmj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjDLMmT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB87EC4;
        Wed, 12 Apr 2023 05:42:09 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PxMh92qvYz17S81;
        Wed, 12 Apr 2023 20:38:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 20:42:07 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 7/8] ext4: make ext4_es_insert_extent return void
Date:   Wed, 12 Apr 2023 20:41:25 +0800
Message-ID: <20230412124126.2286716-8-libaokun1@huawei.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_es_insert_extent, for extents that are not must be kept, the return
value is set to 0 even if the allocation returns -ENOMEM, and now inserting
an extent that must be kept never fails, hence ext4_es_insert_extent never
returns an error either, so let it return void.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	New added.

 fs/ext4/extents.c        |  5 +++--
 fs/ext4/extents_status.c | 16 +++++-----------
 fs/ext4/extents_status.h |  6 +++---
 fs/ext4/inode.c          | 21 ++++++---------------
 4 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e6695fec59af..d555ed924f37 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3136,8 +3136,9 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	if (ee_len == 0)
 		return 0;
 
-	return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-				     EXTENT_STATUS_WRITTEN);
+	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
+			      EXTENT_STATUS_WRITTEN);
+	return 0;
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 047ec2fc4899..ab345523c8b1 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -823,12 +823,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 /*
  * ext4_es_insert_extent() adds information to an inode's extent
  * status tree.
- *
- * Return 0 on success, error code on failure.
  */
-int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len, ext4_fsblk_t pblk,
-			  unsigned int status)
+void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len, ext4_fsblk_t pblk,
+			   unsigned int status)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -836,13 +834,13 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
 
 	if (!len)
-		return 0;
+		return;
 
 	BUG_ON(end < lblk);
 
@@ -868,8 +866,6 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
-	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
-		err = 0;
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
 	    (status & EXTENT_STATUS_WRITTEN ||
@@ -879,8 +875,6 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 
 	ext4_es_print_tree(inode);
-
-	return err;
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index c22edb931f1b..d9847a4a25db 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -127,9 +127,9 @@ extern int __init ext4_init_es(void);
 extern void ext4_exit_es(void);
 extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
-extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len, ext4_fsblk_t pblk,
-				 unsigned int status);
+extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len, ext4_fsblk_t pblk,
+				  unsigned int status);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9fd3d526f591..fc80791c239c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -594,10 +594,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk,
-					    map->m_len, map->m_pblk, status);
-		if (ret < 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -706,12 +704,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret < 0) {
-			retval = ret;
-			goto out_sem;
-		}
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 
 out_sem:
@@ -1776,7 +1770,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		set_buffer_new(bh);
 		set_buffer_delay(bh);
 	} else if (retval > 0) {
-		int ret;
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
@@ -1789,10 +1782,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret != 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 
 out_unlock:
-- 
2.31.1

