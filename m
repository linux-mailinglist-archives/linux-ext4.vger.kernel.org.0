Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242F693D17
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 04:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBMDlw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Feb 2023 22:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBMDlt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Feb 2023 22:41:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB3DBE0
        for <linux-ext4@vger.kernel.org>; Sun, 12 Feb 2023 19:41:43 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PFVSq0pQZznW79;
        Mon, 13 Feb 2023 11:39:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 13 Feb
 2023 11:41:41 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v4 1/2] ext4: fix inode tree inconsistency caused by ENOMEM in ext4_split_extent_at
Date:   Mon, 13 Feb 2023 12:05:21 +0800
Message-ID: <20230213040522.3339406-2-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ENOMEM fails when the extent is splitting, we need to restore the length
of the split extent.
In the call stack of the ext4_split_extent_at function, only in
ext4_ext_create_new_leaf will it alloc memory and change the shape of the
extent tree,even if an ENOMEM is returned at this time, the extent tree is
still self-consistent, Just restore the split extent lens in the function
ext4_split_extent_at.

ext4_split_extent_at
 ext4_ext_insert_extent
  ext4_ext_create_new_leaf
   1)ext4_ext_split
     ext4_find_extent
   2)ext4_ext_grow_indepth
     ext4_find_extent

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..0f95e857089e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
 		if (IS_ERR(bh)) {
+			EXT4_ERROR_INODE(inode, "IO error reading extent block");
 			ret = PTR_ERR(bh);
 			goto err;
 		}
@@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT)
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-- 
2.31.1

