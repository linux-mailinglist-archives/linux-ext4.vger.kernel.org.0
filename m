Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835806EC40A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDXDkH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDXDjv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01142D78;
        Sun, 23 Apr 2023 20:39:47 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q4W4W6rdDznf6g;
        Mon, 24 Apr 2023 11:35:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:45 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 12/12] ext4: make ext4_zeroout_es() return void
Date:   Mon, 24 Apr 2023 11:38:46 +0800
Message-ID: <20230424033846.4732-13-libaokun1@huawei.com>
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

After ext4_es_insert_extent() returns void, the return value in
ext4_zeroout_es() is also unnecessary, so make it return void too.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d555ed924f37..6c3080830b00 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3123,7 +3123,7 @@ void ext4_ext_release(struct super_block *sb)
 #endif
 }
 
-static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
+static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 {
 	ext4_lblk_t  ee_block;
 	ext4_fsblk_t ee_pblock;
@@ -3134,11 +3134,10 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	ee_pblock = ext4_ext_pblock(ex);
 
 	if (ee_len == 0)
-		return 0;
+		return;
 
 	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
 			      EXTENT_STATUS_WRITTEN);
-	return 0;
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
@@ -3288,7 +3287,7 @@ static int ext4_split_extent_at(handle_t *handle,
 			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
 			if (!err)
 				/* update extent status tree */
-				err = ext4_zeroout_es(inode, &zero_ex);
+				ext4_zeroout_es(inode, &zero_ex);
 			/* If we failed at this point, we don't know in which
 			 * state the extent tree exactly is so don't try to fix
 			 * length of the original extent as it may do even more
@@ -3641,9 +3640,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 out:
 	/* If we have gotten a failure, don't zero out status tree */
 	if (!err) {
-		err = ext4_zeroout_es(inode, &zero_ex1);
-		if (!err)
-			err = ext4_zeroout_es(inode, &zero_ex2);
+		ext4_zeroout_es(inode, &zero_ex1);
+		ext4_zeroout_es(inode, &zero_ex2);
 	}
 	return err ? err : allocated;
 }
-- 
2.31.1

