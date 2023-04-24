Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470A6EC3FC
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDXDjs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDXDjo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82325212D;
        Sun, 23 Apr 2023 20:39:43 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q4W401m0ZzSvRY;
        Mon, 24 Apr 2023 11:35:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:41 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 04/12] ext4: use pre-allocated es in __es_insert_extent()
Date:   Mon, 24 Apr 2023 11:38:38 +0800
Message-ID: <20230424033846.4732-5-libaokun1@huawei.com>
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

Pass a extent_status pointer prealloc to __es_insert_extent(). If the
pointer is non-null, it is used directly when a new extent_status is
needed to avoid memory allocation failures.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 18665394392f..a6a62a744e83 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -144,7 +144,8 @@
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_lblk_t end, int *reserved);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
@@ -768,7 +769,8 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
 }
 #endif
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node **p = &tree->root.rb_node;
@@ -808,7 +810,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 		}
 	}
 
-	es = __es_alloc_extent(false);
+	if (prealloc)
+		es = prealloc;
+	else
+		es = __es_alloc_extent(false);
 	if (!es)
 		return -ENOMEM;
 	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
@@ -868,7 +873,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (err != 0)
 		goto error;
 retry:
-	err = __es_insert_extent(inode, &newes);
+	err = __es_insert_extent(inode, &newes, NULL);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
@@ -918,7 +923,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
 	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes);
+		__es_insert_extent(inode, &newes, NULL);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
@@ -1366,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 					orig_es.es_len - len2;
 			ext4_es_store_pblock_status(&newes, block,
 						    ext4_es_status(&orig_es));
-			err = __es_insert_extent(inode, &newes);
+			err = __es_insert_extent(inode, &newes, NULL);
 			if (err) {
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
@@ -2020,7 +2025,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	if (err != 0)
 		goto error;
 retry:
-	err = __es_insert_extent(inode, &newes);
+	err = __es_insert_extent(inode, &newes, NULL);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
-- 
2.31.1

