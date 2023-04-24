Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5C6EC3FD
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjDXDjt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDXDjo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819C2684;
        Sun, 23 Apr 2023 20:39:43 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q4W3z5G3ZzSvRf;
        Mon, 24 Apr 2023 11:35:27 +0800 (CST)
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
Subject: [PATCH v4 03/12] ext4: factor out __es_alloc_extent() and __es_free_extent()
Date:   Mon, 24 Apr 2023 11:38:37 +0800
Message-ID: <20230424033846.4732-4-libaokun1@huawei.com>
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

Factor out __es_alloc_extent() and __es_free_extent(), which only allocate
and free extent_status in these two helpers.

The ext4_es_alloc_extent() function is split into __es_alloc_extent()
and ext4_es_init_extent(). In __es_alloc_extent() we allocate memory using
GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO if the memory allocation cannot
fail, otherwise we use GFP_ATOMIC. and the ext4_es_init_extent() is used to
initialize extent_status and update related variables after a successful
allocation.

This is to prepare for the use of pre-allocated extent_status later.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 573723b23d19..18665394392f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -461,14 +461,17 @@ static inline bool ext4_es_must_keep(struct extent_status *es)
 	return false;
 }
 
-static struct extent_status *
-ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
-		     ext4_fsblk_t pblk)
+static inline struct extent_status *__es_alloc_extent(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static void ext4_es_init_extent(struct inode *inode, struct extent_status *es,
+		ext4_lblk_t lblk, ext4_lblk_t len, ext4_fsblk_t pblk)
 {
-	struct extent_status *es;
-	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
-	if (es == NULL)
-		return NULL;
 	es->es_lblk = lblk;
 	es->es_len = len;
 	es->es_pblk = pblk;
@@ -483,8 +486,11 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 
 	EXT4_I(inode)->i_es_all_nr++;
 	percpu_counter_inc(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
+}
 
-	return es;
+static inline void __es_free_extent(struct extent_status *es)
+{
+	kmem_cache_free(ext4_es_cachep, es);
 }
 
 static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
@@ -501,7 +507,7 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 					s_es_stats.es_stats_shk_cnt);
 	}
 
-	kmem_cache_free(ext4_es_cachep, es);
+	__es_free_extent(es);
 }
 
 /*
@@ -802,10 +808,12 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 		}
 	}
 
-	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
+	es = __es_alloc_extent(false);
 	if (!es)
 		return -ENOMEM;
+	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
+			    newes->es_pblk);
+
 	rb_link_node(&es->rb_node, parent, p);
 	rb_insert_color(&es->rb_node, &tree->root);
 
-- 
2.31.1

