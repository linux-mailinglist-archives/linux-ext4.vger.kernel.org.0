Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7A596F86
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiHQNQU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiHQNPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 09:15:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85F86FE4;
        Wed, 17 Aug 2022 06:15:29 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M77gk3m1czXdqH;
        Wed, 17 Aug 2022 21:11:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 21:15:26 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH 1/2] ext4: fix GDT corruption after online resizing with bigalloc enable and blocksize is 1024
Date:   Wed, 17 Aug 2022 21:27:00 +0800
Message-ID: <20220817132701.3015912-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220817132701.3015912-1-libaokun1@huawei.com>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

When the backup superblock is updated in update_backups, the offset of
the current superblock in the group (that is, sbi->s_sbh->b_blocknr)
is used as the offset of the backup superblock in the group where the
backup superblock resides.

When blocksize==1024, sbi->s_sbh->b_blocknr is 1. Their block distribution
of groups is {0: 1-8192, 1:8193-16384...}, so the location of the backup
superblock is still the first block in each group.

If bigalloc is enabled at the same time, the block distribution of each
group changes to {0: 0-131071, 1:131072-262143...}. In this case,
update_backups overwrites the second block instead of the first block in
each group that contains backup superblocks with the current superblock.
As a result, both the backup superblock and the backup GDT are incorrect.
This is nothing, after all, the backup GDT is only used when the disk is
repaired.

However, in some cases, this may cause file system corruption, data loss,
and even some programs stuck in the D state. We can easily reproduce this
problem with the following commands:

  mkfs.ext4 -F -O ^resize_inode,^sparse_super,bigalloc -b 1024 /dev/sdb 4M
  mount /dev/sdb /tmp/test
  resize2fs /dev/sdb 4G

This is because the GDT for each meta_bg is placed in its first group. When
sparse_super is disabled, backup superblocks exist in each group. In this
case, the GDT of the new meta_bg obtained by online resizing is corrupt.

To solve this issue, we only need to specify the offset of the backup
superblock in the group to 0 when bigalloc is enabled.

Fixes: d77147ff443b ("ext4: add support for online resizing with bigalloc")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/resize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index fea2a68d067b..0146a11efd06 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1590,8 +1590,12 @@ static int ext4_flex_group_add(struct super_block *sb,
 				   EXT4_DESC_PER_BLOCK(sb));
 		int meta_bg = ext4_has_feature_meta_bg(sb);
 		sector_t old_gdb = 0;
+		sector_t blk_off = sbi->s_sbh->b_blocknr;
 
-		update_backups(sb, sbi->s_sbh->b_blocknr, (char *)es,
+		if (ext4_has_feature_bigalloc(sb))
+			blk_off = 0;
+
+		update_backups(sb, blk_off, (char *)es,
 			       sizeof(struct ext4_super_block), 0);
 		for (; gdb_num <= gdb_num_end; gdb_num++) {
 			struct buffer_head *gdb_bh;
-- 
2.31.1

