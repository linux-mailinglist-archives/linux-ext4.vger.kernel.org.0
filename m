Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BCD6D9833
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjDFN3T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbjDFN3N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 09:29:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB5659E;
        Thu,  6 Apr 2023 06:29:11 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Psj2L4nyDzKwxp;
        Thu,  6 Apr 2023 21:26:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 21:29:04 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/2] ext4: use __GFP_NOFAIL if allocating extents_status cannot fail
Date:   Thu, 6 Apr 2023 21:28:34 +0800
Message-ID: <20230406132834.1669710-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230406132834.1669710-1-libaokun1@huawei.com>
References: <20230406132834.1669710-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If extent status tree update fails, we have inconsistency between what is
stored in the extent status tree and what is stored on disk. And that can
cause even data corruption issues in some cases.

In the extent status tree, we have extents which we can just drop without
issues and extents we must not drop - this depends on the extent's status
- currently ext4_es_is_delayed() extents must stay, others may be dropped.

For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
A helper function is also added to help determine if the current extent can
be dropped, although only ext4_es_is_delayed() extents cannot be dropped
currently. In addition, with the above logic, the undo operation in
__es_remove_extent that may cause inconsistency if the split extent fails
is unnecessary, so we remove it as well.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Add the patch 2 as suggested by Jan Kara.

 fs/ext4/extents_status.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..8eed17f35b11 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -448,12 +448,29 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
+/*
+ * Helper function to help determine if memory allocation for this
+ * extent_status is allowed to fail.
+ */
+static inline bool ext4_es_alloc_should_nofail(struct extent_status *es)
+{
+	if (ext4_es_is_delayed(es))
+		return true;
+
+	return false;
+}
+
 static struct extent_status *
 ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
-		     ext4_fsblk_t pblk)
+		     ext4_fsblk_t pblk, int nofail)
 {
 	struct extent_status *es;
-	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
+	gfp_t gfp_flags = GFP_ATOMIC;
+
+	if (nofail)
+		gfp_flags |= __GFP_NOFAIL;
+
+	es = kmem_cache_alloc(ext4_es_cachep, gfp_flags);
 	if (es == NULL)
 		return NULL;
 	es->es_lblk = lblk;
@@ -792,9 +809,16 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 	}
 
 	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
-	if (!es)
-		return -ENOMEM;
+				  newes->es_pblk, 0);
+	if (!es) {
+		/* Use GFP_NOFAIL if the allocation cannot fail. */
+		if (ext4_es_alloc_should_nofail(newes))
+			es = ext4_es_alloc_extent(inode, newes->es_lblk,
+					newes->es_len, newes->es_pblk, 1);
+		else
+			return -ENOMEM;
+	}
+
 	rb_link_node(&es->rb_node, parent, p);
 	rb_insert_color(&es->rb_node, &tree->root);
 
@@ -1349,8 +1373,6 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 						    ext4_es_status(&orig_es));
 			err = __es_insert_extent(inode, &newes);
 			if (err) {
-				es->es_lblk = orig_es.es_lblk;
-				es->es_len = orig_es.es_len;
 				if ((err == -ENOMEM) &&
 				    __es_shrink(EXT4_SB(inode->i_sb),
 							128, EXT4_I(inode)))
-- 
2.31.1

