Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC340AC2A
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Sep 2021 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhINLFm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Sep 2021 07:05:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9866 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhINLFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Sep 2021 07:05:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H80jm20yLz8yPL;
        Tue, 14 Sep 2021 18:59:56 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:04:22 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:04:21 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: update last_pos for the case ext4_htree_fill_tree return fail
Date:   Tue, 14 Sep 2021 19:14:15 +0800
Message-ID: <20210914111415.3921954-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Or the ls for ext4 dir can run into a deadloop since info->last_pos !=
ctx->pos which will reset the world and start read the entry which has
already got before. Details see below:

1. a dx_dir which has 3 block, block 0 as dx_root block, block 1/2 as
   leaf block which own the ext4_dir_entry_2
2. block 1 read ok and call_filldir which will fill the dirent and update
   the ctx->pos
3. block 2 read fail, but we has already fill some dirent, so we will
   return back to userspace will a positive return val(see ksys_getdents64)
4. the second ext4_dx_readdir will reset the world since info->last_pos
   != ctx->pos, and will also init the curr_hash which pos to block 1
5. So we will read block1 too, and once block2 still read fail, we can
   only fill one dirent because the hash of the entry in block1(besides
   the last one) won't greater than curr_hash
6. this time, we forget update last_pos too since the read for block2
   will fail, and since we has got the one entry, ksys_getdents64 can
   return success
7. Latter we will trapped in a loop with step 4~6

Fix it by update last_pos too once ext4_htree_fill_tree return fail.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ffb295aa891c..74b172a4adda 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -551,7 +551,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 	struct dir_private_info *info = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct fname *fname;
-	int	ret;
+	int ret = 0;
 
 	if (!info) {
 		info = ext4_htree_create_dir_info(file, ctx->pos);
@@ -599,7 +599,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 						   info->curr_minor_hash,
 						   &info->next_hash);
 			if (ret < 0)
-				return ret;
+				goto finished;
 			if (ret == 0) {
 				ctx->pos = ext4_get_htree_eof(file);
 				break;
@@ -630,7 +630,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 	}
 finished:
 	info->last_pos = ctx->pos;
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static int ext4_release_dir(struct inode *inode, struct file *filp)
-- 
2.31.1

