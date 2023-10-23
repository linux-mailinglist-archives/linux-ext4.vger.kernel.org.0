Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368F77D27EE
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 03:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjJWB0Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjJWB0V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 21:26:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BDF5;
        Sun, 22 Oct 2023 18:26:19 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SDHTN0PsDzcdV9;
        Mon, 23 Oct 2023 09:21:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 09:26:17 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 4/4] ext4: reduce unnecessary memory allocation in alloc_flex_gd()
Date:   Mon, 23 Oct 2023 09:30:57 +0800
Message-ID: <20231023013057.2117948-5-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231023013057.2117948-1-libaokun1@huawei.com>
References: <20231023013057.2117948-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When a large flex_bg file system is resized, the number of groups to be
added may be small, and a large amount of memory that will not be used will
be allocated. Therefore, resize_bg can be set to the size after the number
of new_group_data to be used is aligned upwards to the power of 2. This
does not affect the disk layout after online resize and saves some memory.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/resize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e168a9f59600..4d4a5a32e310 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -235,8 +235,10 @@ struct ext4_new_flex_group_data {
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
+				ext4_group_t o_group, ext4_group_t n_group)
 {
+	ext4_group_t last_group;
 	struct ext4_new_flex_group_data *flex_gd;
 
 	flex_gd = kmalloc(sizeof(*flex_gd), GFP_NOFS);
@@ -248,6 +250,14 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 	else
 		flex_gd->resize_bg = flexbg_size;
 
+	/* Avoid allocating large 'groups' array if not needed */
+	last_group = o_group | (flex_gd->resize_bg - 1);
+	if (n_group <= last_group)
+		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
+	else if (n_group - last_group < flex_gd->resize_bg)
+		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
+					      fls(n_group - last_group));
+
 	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
@@ -2131,7 +2141,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	if (err)
 		goto out;
 
-	flex_gd = alloc_flex_gd(flexbg_size);
+	flex_gd = alloc_flex_gd(flexbg_size, o_group, n_group);
 	if (flex_gd == NULL) {
 		err = -ENOMEM;
 		goto out;
-- 
2.31.1

