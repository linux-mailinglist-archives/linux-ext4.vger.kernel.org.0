Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680174DCB62
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Mar 2022 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiCQQ1g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Mar 2022 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCQQ1f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Mar 2022 12:27:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533BC100E2F
        for <linux-ext4@vger.kernel.org>; Thu, 17 Mar 2022 09:26:18 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KKC7c4dZxz1GC1T;
        Fri, 18 Mar 2022 00:21:16 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 00:26:16 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 00:26:15 +0800
Message-ID: <711fad84-951d-d2e7-a866-45375ce73217@huawei.com>
Date:   Fri, 18 Mar 2022 00:26:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] e2fsck: handle->level is overflow in scan_extent_node
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100002.china.huawei.com (7.185.36.130) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In function check_blocks_extents, program call scan_extent_node 
recursively until
leaf extent is found, and if this leaf extent is the last one in this 
extent_idx,
it will delete the parent extent_idx of this leaf extent in 
ext2fs_extent_delete,
and do handle->level--. After scan_extent_node return, program allways 
to get up extent,
but level was already decreased.
So calling ext2fs_extent_get(EXT2_EXTENT_UP) again will return 
EXT2_ET_EXTENT_NO_UP,
and then print failed.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  e2fsck/pass1.c      | 18 +++++++++++-------
  lib/ext2fs/ext2fs.h |  1 +
  lib/ext2fs/extent.c |  5 +++++
  3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 26b9ab71..e4395709 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3050,6 +3050,7 @@ report_problem:
  					goto report_problem;
  				return;
  			}
+			int level_bak = ext2fs_current_level_get(ehandle);
  			/* The next extent should match this index's logical start */
  			if (extent.e_lblk != lblk) {
  				struct ext2_extent_info e_info;
@@ -3079,14 +3080,17 @@ report_problem:
  					 next_try_repairs);
  			if (pctx->errcode)
  				return;
-			pctx->errcode = ext2fs_extent_get(ehandle,
-						  EXT2_EXTENT_UP, &extent);
-			if (pctx->errcode) {
-				pctx->str = "EXT2_EXTENT_UP";
-				return;
+
+			if (level_bak == ext2fs_current_level_get(ehandle)) {
+				pctx->errcode = ext2fs_extent_get(ehandle,
+							  EXT2_EXTENT_UP, &extent);
+				if (pctx->errcode) {
+					pctx->str = "EXT2_EXTENT_UP";
+					return;
+				}
+				mark_block_used(ctx, blk);
+				pb->num_blocks++;
  			}
-			mark_block_used(ctx, blk);
-			pb->num_blocks++;
  			goto next;
  		}

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 68f9c1fe..d0468f11 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1333,6 +1333,7 @@ extern errcode_t ext2fs_extent_open2(ext2_filsys 
fs, ext2_ino_t ino,
  extern void ext2fs_extent_free(ext2_extent_handle_t handle);
  extern errcode_t ext2fs_extent_get(ext2_extent_handle_t handle,
  				   int flags, struct ext2fs_extent *extent);
+extern int ext2fs_current_level_get(ext2_extent_handle_t handle);
  extern errcode_t ext2fs_extent_node_split(ext2_extent_handle_t handle);
  extern errcode_t ext2fs_extent_replace(ext2_extent_handle_t handle, 
int flags,
  				       struct ext2fs_extent *extent);
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index b324c7b0..07acd4e0 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -575,6 +575,11 @@ retry:
  	return 0;
  }

+int ext2fs_current_level_get(ext2_extent_handle_t handle)
+{
+	return handle->level;
+}
+
  static errcode_t update_path(ext2_extent_handle_t handle)
  {
  	blk64_t				blk;
-- 
2.27.0

