Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E66DF5BD
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDLMmh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjDLMmS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEA7ABA;
        Wed, 12 Apr 2023 05:42:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PxMjH2NfLzKxhw;
        Wed, 12 Apr 2023 20:39:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 20:42:05 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 5/8] ext4: make ext4_es_remove_extent return void
Date:   Wed, 12 Apr 2023 20:41:23 +0800
Message-ID: <20230412124126.2286716-6-libaokun1@huawei.com>
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

After __es_remove_extent returns void, the return value in
ext4_es_remove_extent is also unnecessary, so make it return void too.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	New added.

 fs/ext4/extents.c        | 34 ++++++----------------------------
 fs/ext4/extents_status.c | 12 +++++-------
 fs/ext4/extents_status.h |  4 ++--
 fs/ext4/inline.c         | 12 ++----------
 fs/ext4/inode.c          |  8 ++------
 5 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..e6695fec59af 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4403,15 +4403,8 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 
 	last_block = (inode->i_size + sb->s_blocksize - 1)
 			>> EXT4_BLOCK_SIZE_BITS(sb);
-retry:
-	err = ext4_es_remove_extent(inode, last_block,
-				    EXT_MAX_BLOCKS - last_block);
-	if (err == -ENOMEM) {
-		memalloc_retry_wait(GFP_ATOMIC);
-		goto retry;
-	}
-	if (err)
-		return err;
+	ext4_es_remove_extent(inode, last_block, EXT_MAX_BLOCKS - last_block);
+
 retry_remove_space:
 	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
 	if (err == -ENOMEM) {
@@ -5363,13 +5356,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode, 0);
-
-	ret = ext4_es_remove_extent(inode, punch_start,
-				    EXT_MAX_BLOCKS - punch_start);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
 
 	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
 	if (ret) {
@@ -5554,12 +5541,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		ext4_free_ext_path(path);
 	}
 
-	ret = ext4_es_remove_extent(inode, offset_lblk,
-			EXT_MAX_BLOCKS - offset_lblk);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
 
 	/*
 	 * if offset_lblk lies in a hole which is at start of file, use
@@ -5617,12 +5599,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 	BUG_ON(!inode_is_locked(inode1));
 	BUG_ON(!inode_is_locked(inode2));
 
-	*erp = ext4_es_remove_extent(inode1, lblk1, count);
-	if (unlikely(*erp))
-		return 0;
-	*erp = ext4_es_remove_extent(inode2, lblk2, count);
-	if (unlikely(*erp))
-		return 0;
+	ext4_es_remove_extent(inode1, lblk1, count);
+	ext4_es_remove_extent(inode2, lblk2, count);
 
 	while (count) {
 		struct ext4_extent *ex1, *ex2, tmp_ex;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 5207d3a9c1ad..1ba2dd14367c 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1435,24 +1435,23 @@ static void __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
  * @len - number of blocks to remove
  *
  * Reduces block/cluster reservation count and for bigalloc cancels pending
- * reservations as needed. Returns 0 on success, error code on failure.
+ * reservations as needed.
  */
-int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len)
+void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
-	int err = 0;
 	int reserved = 0;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
 
 	if (!len)
-		return err;
+		return;
 
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
@@ -1467,7 +1466,6 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return err;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a798260..526a68890aa6 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -133,8 +133,8 @@ extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
-extern int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len);
+extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len);
 extern void ext4_es_find_extent_range(struct inode *inode,
 				      int (*match_fn)(struct extent_status *es),
 				      ext4_lblk_t lblk, ext4_lblk_t end,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1602d74b5eeb..dc88ec0e6611 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1955,16 +1955,8 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		 * the extent status cache must be cleared to avoid leaving
 		 * behind stale delayed allocated extent entries
 		 */
-		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-retry:
-			err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
-			if (err == -ENOMEM) {
-				memalloc_retry_wait(GFP_ATOMIC);
-				goto retry;
-			}
-			if (err)
-				goto out_error;
-		}
+		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+			ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 
 		/* Clear the content in the xattr space. */
 		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 33ae92f0ddfb..3bd4d5bbf0aa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4026,12 +4026,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode, 0);
 
-		ret = ext4_es_remove_extent(inode, first_block,
-					    stop_block - first_block);
-		if (ret) {
-			up_write(&EXT4_I(inode)->i_data_sem);
-			goto out_stop;
-		}
+		ext4_es_remove_extent(inode, first_block,
+				      stop_block - first_block);
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 			ret = ext4_ext_remove_space(inode, first_block,
-- 
2.31.1

