Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A540866414A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjAJNJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbjAJNJs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 08:09:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B561339
        for <linux-ext4@vger.kernel.org>; Tue, 10 Jan 2023 05:09:46 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nrrdr4MXRzJq9y;
        Tue, 10 Jan 2023 21:05:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 21:09:42 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 2/2] ext4: call ext4_handle_error when read extent failed in ext4_ext_insert_extent
Date:   Tue, 10 Jan 2023 21:34:07 +0800
Message-ID: <20230110133407.994711-3-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230110133407.994711-1-zhanchengbin1@huawei.com>
References: <20230110133407.994711-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In addition to ext4_find_extent reading extent block return
-EIO, ext4_handle_error will be called when there is a problem that
may cause file system inconsistency in the ext4_ext_insert_extent
function.
So call the ext4_handle_error function when the ext4_find_extent
read fails，and make the filesystem read-only when mount for
`errors=remount-ro`, and Check whether the journal is aborted in
the ext4_split_extent_at function.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..3798b2a8e550 100644
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
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+	if (err && is_handle_aborted(handle))
 		goto out;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-- 
2.31.1

