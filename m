Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809B6EC401
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDXDj4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDXDjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F542132;
        Sun, 23 Apr 2023 20:39:44 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q4W73071nzsRr1;
        Mon, 24 Apr 2023 11:38:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:42 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 05/12] ext4: use pre-allocated es in __es_remove_extent()
Date:   Mon, 24 Apr 2023 11:38:39 +0800
Message-ID: <20230424033846.4732-6-libaokun1@huawei.com>
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

When splitting extent, if the second extent can not be dropped, we return
-ENOMEM and use GFP_NOFAIL to preallocate an extent_status outside of
i_es_lock and pass it to __es_remove_extent() to be used as the second
extent. This ensures that __es_remove_extent() is executed successfully,
thus ensuring consistency in the extent status tree. If the second extent
is not undroppable, we simply drop it and return 0. Then retry is no longer
necessary, remove it.

Now, __es_remove_extent() will always remove what it should, maybe more.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a6a62a744e83..7219116e0d68 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -147,7 +147,8 @@ static struct kmem_cache *ext4_pending_cachep;
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved);
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
@@ -869,7 +870,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_es_insert_extent_check(inode, &newes);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL);
+	err = __es_remove_extent(inode, lblk, end, NULL, NULL);
 	if (err != 0)
 		goto error;
 retry:
@@ -1315,6 +1316,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @lblk - first block in range
  * @end - last block in range
  * @reserved - number of cluster reservations released
+ * @prealloc - pre-allocated es to avoid memory allocation failures
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
@@ -1322,7 +1324,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved)
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -1330,14 +1333,12 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status orig_es;
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
-	int err;
+	int err = 0;
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
-retry:
-	err = 0;
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1371,14 +1372,13 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 					orig_es.es_len - len2;
 			ext4_es_store_pblock_status(&newes, block,
 						    ext4_es_status(&orig_es));
-			err = __es_insert_extent(inode, &newes, NULL);
+			err = __es_insert_extent(inode, &newes, prealloc);
 			if (err) {
+				if (!ext4_es_must_keep(&newes))
+					return 0;
+
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
-				if ((err == -ENOMEM) &&
-				    __es_shrink(EXT4_SB(inode->i_sb),
-							128, EXT4_I(inode)))
-					goto retry;
 				goto out;
 			}
 		} else {
@@ -1478,7 +1478,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved);
+	err = __es_remove_extent(inode, lblk, end, &reserved, NULL);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
@@ -2021,7 +2021,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk, NULL);
+	err = __es_remove_extent(inode, lblk, lblk, NULL, NULL);
 	if (err != 0)
 		goto error;
 retry:
-- 
2.31.1

