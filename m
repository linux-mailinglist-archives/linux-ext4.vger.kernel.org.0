Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C350B6DF5B8
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDLMmY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDLMmR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF737AAE;
        Wed, 12 Apr 2023 05:42:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PxMh724xXz17Rrt;
        Wed, 12 Apr 2023 20:38:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 20:42:04 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 3/8] ext4: use __GFP_NOFAIL if allocating extents_status cannot fail
Date:   Wed, 12 Apr 2023 20:41:21 +0800
Message-ID: <20230412124126.2286716-4-libaokun1@huawei.com>
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

If extent status tree update fails, we have inconsistency between what is
stored in the extent status tree and what is stored on disk. And that can
cause even data corruption issues in some cases.

For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
And with the above logic, the undo operation in __es_remove_extent that
may cause inconsistency if the split extent fails is unnecessary, so we
remove it as well.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	Define helper as a preparatory patch and simplify the code.

 fs/ext4/extents_status.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index f9dab2510bdc..a7c3200f9cbe 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -464,10 +464,15 @@ static inline int ext4_es_must_keep(struct extent_status *es)
 
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
@@ -804,7 +809,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 	}
 
 	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
+				  newes->es_pblk, ext4_es_must_keep(newes));
 	if (!es)
 		return -ENOMEM;
 	rb_link_node(&es->rb_node, parent, p);
@@ -1361,8 +1366,6 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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

