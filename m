Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630577CBBD
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjHOLaH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 07:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjHOL3u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 07:29:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079361BE7;
        Tue, 15 Aug 2023 04:29:39 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ8BZ1jJhzVk1g;
        Tue, 15 Aug 2023 19:27:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 19:29:37 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 1/4] ext2: remove ext2_new_block()
Date:   Tue, 15 Aug 2023 19:26:09 +0800
Message-ID: <20230815112612.221145-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815112612.221145-1-yebin10@huawei.com>
References: <20230815112612.221145-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now, only xattr allocate block use ext2_new_block(), so just opencode it in
the xattr code.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 7 -------
 fs/ext2/ext2.h   | 1 -
 fs/ext2/xattr.c  | 4 +++-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c8049c90323d..c8515fc501ec 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1429,13 +1429,6 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 	return 0;
 }
 
-ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
-{
-	unsigned long count = 1;
-
-	return ext2_new_blocks(inode, goal, &count, errp);
-}
-
 #ifdef EXT2FS_DEBUG
 
 unsigned long ext2_count_free(struct buffer_head *map, unsigned int numchars)
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 35a041c47c38..954fb82ab22c 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -695,7 +695,6 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern ext2_fsblk_t ext2_new_block(struct inode *, unsigned long, int *);
 extern ext2_fsblk_t ext2_new_blocks(struct inode *, unsigned long,
 				unsigned long *, int *);
 extern int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 1c9187188d68..e9546cc65db2 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -742,7 +742,9 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block = ext2_new_block(inode, goal, &error);
+			unsigned long count = 1;
+			int block = ext2_new_blocks(inode, goal, &count,
+						    &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
-- 
2.31.1

