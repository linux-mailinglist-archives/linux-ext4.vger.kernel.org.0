Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0044166A
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Nov 2021 10:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhKAJY6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 05:24:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15327 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhKAJXl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 05:23:41 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HjSFR0t87z90f4;
        Mon,  1 Nov 2021 17:20:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 1
 Nov 2021 17:21:05 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.comu>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next RFC] ext2: Add check if block is step over super block
Date:   Mon, 1 Nov 2021 17:33:51 +0800
Message-ID: <20211101093351.1164368-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got an issue that super block is allocated by file system when run syzkaller
test. We add debug information find that origin image super block's block bitmap
is zero. There isn't check whether block is step over super block in ext2_new_blocks.

In order not to make things worse, we'd better to add check if block step over
super block when new blocks.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c17ccc19b938..b93d52e6a17a 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1376,7 +1376,8 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
 		      EXT2_SB(sb)->s_itb_per_group) ||
 	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
-		      EXT2_SB(sb)->s_itb_per_group)) {
+		      EXT2_SB(sb)->s_itb_per_group) ||
+	    in_range(EXT2_SB(sb)->s_sb_block, ret_block, num)) {
 		ext2_error(sb, "ext2_new_blocks",
 			    "Allocating block in system zone - "
 			    "blocks from "E2FSBLK", length %lu",
-- 
2.31.1

