Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B077CBBA
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjHOLaC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjHOL3v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 07:29:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF821984;
        Tue, 15 Aug 2023 04:29:40 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ8CR4lk4z1GDW4;
        Tue, 15 Aug 2023 19:28:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 19:29:38 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/4] ext2: introduce flag argument for ext2_new_blocks()
Date:   Tue, 15 Aug 2023 19:26:10 +0800
Message-ID: <20230815112612.221145-3-yebin10@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch introduce introduce flag argument for ext2_new_blocks(), and also
introduce EXT2_ALLOC_NORESERVE flags.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 3 ++-
 fs/ext2/ext2.h   | 7 ++++++-
 fs/ext2/inode.c  | 2 +-
 fs/ext2/xattr.c  | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c8515fc501ec..99a19f2ecd6f 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1193,6 +1193,7 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
  * @goal:		given target block(filesystem wide)
  * @count:		target number of blocks to allocate
  * @errp:		error code
+ * @flag                allocate flags
  *
  * ext2_new_blocks uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
@@ -1202,7 +1203,7 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
  * This function also updates quota and i_blocks field.
  */
 ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
-		    unsigned long *count, int *errp)
+		    unsigned long *count, int *errp, unsigned int flag)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 954fb82ab22c..36c8ed5dd0a0 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -398,6 +398,11 @@ struct ext2_inode {
 #define EXT2_ERRORS_PANIC		3	/* Panic */
 #define EXT2_ERRORS_DEFAULT		EXT2_ERRORS_CONTINUE
 
+/*
+ * Behaviour if use reservation window in ext2_new_blocks()
+ */
+#define EXT2_ALLOC_NORESERVE            0x1
+
 /*
  * Structure of the super block
  */
@@ -696,7 +701,7 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
 extern ext2_fsblk_t ext2_new_blocks(struct inode *, unsigned long,
-				unsigned long *, int *);
+				unsigned long *, int *, unsigned int);
 extern int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
 				 unsigned int count);
 extern void ext2_free_blocks (struct inode *, unsigned long,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index acbab27fe957..462b4e873dc7 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -415,7 +415,7 @@ static int ext2_alloc_blocks(struct inode *inode,
 	while (1) {
 		count = target;
 		/* allocating blocks for indirect blocks and direct blocks */
-		current_block = ext2_new_blocks(inode,goal,&count,err);
+		current_block = ext2_new_blocks(inode, goal, &count, err, 0);
 		if (*err)
 			goto failed_out;
 
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index e9546cc65db2..e076386a26f4 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -744,7 +744,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 						EXT2_I(inode)->i_block_group);
 			unsigned long count = 1;
 			int block = ext2_new_blocks(inode, goal, &count,
-						    &error);
+						    &error, 0);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
-- 
2.31.1

