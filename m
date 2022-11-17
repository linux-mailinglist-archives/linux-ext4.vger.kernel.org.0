Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B362D1CB
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 04:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKQDmZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 22:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiKQDmX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 22:42:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2CF54B0A;
        Wed, 16 Nov 2022 19:42:23 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCQhQ6GgLz15MZk;
        Thu, 17 Nov 2022 11:41:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 11:42:20 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 3/3] ext4: fix corruption when online resizing a 1K bigalloc fs
Date:   Thu, 17 Nov 2022 12:03:41 +0800
Message-ID: <20221117040341.1380702-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221117040341.1380702-1-libaokun1@huawei.com>
References: <20221117040341.1380702-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

To solve this issue, we use a more accurate ext4_group_first_block_no() as
the offset of the backup superblock in its group.

Fixes: d77147ff443b ("ext4: add support for online resizing with bigalloc")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
V1->V2:
    Replace s_first_data_block with ext4_group_first_block_no() to avoid
    type warning.(Reported-by: kernel test robot <lkp@intel.com>)

 fs/ext4/resize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 66ceabbd83ad..b493233750ab 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1604,8 +1604,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int meta_bg = ext4_has_feature_meta_bg(sb);
 		sector_t old_gdb = 0;
 
-		update_backups(sb, sbi->s_sbh->b_blocknr, (char *)es,
-			       sizeof(struct ext4_super_block), 0);
+		update_backups(sb, ext4_group_first_block_no(sb, 0),
+			       (char *)es, sizeof(struct ext4_super_block), 0);
 		for (; gdb_num <= gdb_num_end; gdb_num++) {
 			struct buffer_head *gdb_bh;
 
@@ -1816,7 +1816,7 @@ static int ext4_group_extend_no_check(struct super_block *sb,
 		if (test_opt(sb, DEBUG))
 			printk(KERN_DEBUG "EXT4-fs: extended group to %llu "
 			       "blocks\n", ext4_blocks_count(es));
-		update_backups(sb, EXT4_SB(sb)->s_sbh->b_blocknr,
+		update_backups(sb, ext4_group_first_block_no(sb, 0),
 			       (char *)es, sizeof(struct ext4_super_block), 0);
 	}
 	return err;
-- 
2.31.1

