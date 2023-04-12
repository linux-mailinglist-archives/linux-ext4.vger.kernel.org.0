Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B666DF5BC
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjDLMmg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDLMmR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A557ABD;
        Wed, 12 Apr 2023 05:42:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PxMlP69SxzDsrS;
        Wed, 12 Apr 2023 20:41:21 +0800 (CST)
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
Subject: [PATCH v3 4/8] ext4: make __es_remove_extent return void
Date:   Wed, 12 Apr 2023 20:41:22 +0800
Message-ID: <20230412124126.2286716-5-libaokun1@huawei.com>
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

Now __es_remove_extent() cannot fail (it will always remove what it should,
maybe more) so just make it return void.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	New added.

 fs/ext4/extents_status.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a7c3200f9cbe..5207d3a9c1ad 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -145,8 +145,8 @@ static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
-static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved);
+static void __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+			       ext4_lblk_t end, int *reserved);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
@@ -862,9 +862,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_es_insert_extent_check(inode, &newes);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL);
-	if (err != 0)
-		goto error;
+	__es_remove_extent(inode, lblk, end, NULL);
 retry:
 	err = __es_insert_extent(inode, &newes);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
@@ -878,7 +876,6 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	     status & EXTENT_STATUS_UNWRITTEN))
 		__revise_pending(inode, lblk, len);
 
-error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 
 	ext4_es_print_tree(inode);
@@ -1311,11 +1308,10 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
- * enabled cancels pending reservations as needed. Returns 0 on success,
- * error code on failure.
+ * enabled cancels pending reservations as needed.
  */
-static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved)
+static void __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+			       ext4_lblk_t end, int *reserved)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -1334,9 +1330,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
-		goto out;
+		return;
 	if (es->es_lblk > end)
-		goto out;
+		return;
 
 	/* Simply invalidate cache_es. */
 	tree->cache_es = NULL;
@@ -1370,7 +1366,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 				    __es_shrink(EXT4_SB(inode->i_sb),
 							128, EXT4_I(inode)))
 					goto retry;
-				goto out;
+				return;
 			}
 		} else {
 			es->es_lblk = end + 1;
@@ -1429,8 +1425,6 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 out_get_reserved:
 	if (count_reserved)
 		*reserved = get_rsvd(inode, end, es, &rc);
-out:
-	return err;
 }
 
 /*
@@ -1469,7 +1463,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved);
+	__es_remove_extent(inode, lblk, end, &reserved);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
@@ -2012,9 +2006,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk, NULL);
-	if (err != 0)
-		goto error;
+	__es_remove_extent(inode, lblk, lblk, NULL);
 retry:
 	err = __es_insert_extent(inode, &newes);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-- 
2.31.1

