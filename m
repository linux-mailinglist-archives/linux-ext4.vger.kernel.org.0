Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774065B93A
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 03:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjACCDp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 21:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjACCDh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 21:03:37 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4E8FC1
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 18:03:37 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NmGBc6gj9zJpWv;
        Tue,  3 Jan 2023 09:59:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 10:03:35 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] ext4: fix inode tree inconsistency caused by ENOMEM
Date:   Tue, 3 Jan 2023 10:28:12 +0800
Message-ID: <20230103022812.130603-1-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
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
In the ext4_split_extent_at function, only in ext4_ext_create_new_leaf will
it alloc memory and change the shape of the extent tree,even if an ENOMEM
is returned at this time, the extent tree is still self-consistent, Just
restore the split extent lens in the function ext4_split_extent_at.

ext4_split_extent_at
 ext4_ext_insert_extent
  ext4_ext_create_new_leaf
   1)ext4_ext_split
     ext4_find_extent
   2)ext4_ext_grow_indepth
     ext4_find_extent

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 Another solution is to add the __GFP_NOFAIL flag when allocating memory.

 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..3559ea6b0781 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3251,7 +3251,7 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT)
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-- 
2.31.1

