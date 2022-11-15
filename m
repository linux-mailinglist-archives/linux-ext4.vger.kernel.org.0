Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD46297CB
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Nov 2022 12:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiKOLzZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Nov 2022 06:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKOLzR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Nov 2022 06:55:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0113D09;
        Tue, 15 Nov 2022 03:55:16 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBPjw3hnmzHvrS;
        Tue, 15 Nov 2022 19:54:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 19:55:14 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 3/3] ext4: fix corruption when online resizing a 1K bigalloc fs
Date:   Tue, 15 Nov 2022 20:16:38 +0800
Message-ID: <20221115121638.192349-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115121638.192349-1-libaokun1@huawei.com>
References: <20221115121638.192349-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When a backup superblock is updated in update_backups(), the primary
superblock's offset in the group (that is, sbi->s_sbh->b_blocknr) is used
as the backup superblock's offset in its group. However, when the block
size is 1K and bigalloc is enabled, the two offsets are not equal. This
causes the backup group descriptors to be overwritten by the superblock
in update_backups(). Moreover, if meta_bg is enabled, the file system will
be corrupted because this feature uses backup group descriptors.

To solve this issue, we use a more accurate s_first_data_block as the
offset of the backup superblock in its group.

Fixes: d77147ff443b ("ext4: add support for online resizing with bigalloc")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/resize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 32fbfc173571..cf75fdd3729d 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1591,7 +1591,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int meta_bg = ext4_has_feature_meta_bg(sb);
 		sector_t old_gdb = 0;
 
-		update_backups(sb, sbi->s_sbh->b_blocknr, (char *)es,
+		update_backups(sb, es->s_first_data_block, (char *)es,
 			       sizeof(struct ext4_super_block), 0);
 		for (; gdb_num <= gdb_num_end; gdb_num++) {
 			struct buffer_head *gdb_bh;
@@ -1803,8 +1803,8 @@ static int ext4_group_extend_no_check(struct super_block *sb,
 		if (test_opt(sb, DEBUG))
 			printk(KERN_DEBUG "EXT4-fs: extended group to %llu "
 			       "blocks\n", ext4_blocks_count(es));
-		update_backups(sb, EXT4_SB(sb)->s_sbh->b_blocknr,
-			       (char *)es, sizeof(struct ext4_super_block), 0);
+		update_backups(sb, es->s_first_data_block, (char *)es,
+			       sizeof(struct ext4_super_block), 0);
 	}
 	return err;
 }
-- 
2.31.1

