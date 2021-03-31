Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB434FFF9
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhCaMHg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Mar 2021 08:07:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15125 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhCaMH0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Mar 2021 08:07:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9Q4H3cvDz1BFXb;
        Wed, 31 Mar 2021 20:05:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 20:07:15 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: fix check to prevent false positive report of incorrect used inodes
Date:   Wed, 31 Mar 2021 20:15:16 +0800
Message-ID: <20210331121516.2243099-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit <50122847007> ("ext4: fix check to prevent initializing reserved
inodes") check the block group zero and prevent initializing reserved
inodes. But in some special cases, the reserved inode may not all belong
to the group zero, it may exist into the second group if we format
filesystem below.

  mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda

So, it will end up triggering a false positive report of a corrupted
file system. This patch fix it by avoid check reserved inodes if no free
inode blocks will be zeroed.

Fixes: 50122847007 ("ext4: fix check to prevent initializing reserved inodes")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
Changes since v1:
 - Splict check of used_blks and used_inos to make code more
   comprehensible as Jan suggested.

 fs/ext4/ialloc.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 633ae7becd61..5f0c7fe32672 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1513,6 +1513,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	handle_t *handle;
 	ext4_fsblk_t blk;
 	int num, ret = 0, used_blks = 0;
+	unsigned long used_inos = 0;
 
 	/* This should not happen, but just to be sure check this */
 	if (sb_rdonly(sb)) {
@@ -1543,22 +1544,37 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	 * used inodes so we need to skip blocks with used inodes in
 	 * inode table.
 	 */
-	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)))
-		used_blks = DIV_ROUND_UP((EXT4_INODES_PER_GROUP(sb) -
-			    ext4_itable_unused_count(sb, gdp)),
-			    sbi->s_inodes_per_block);
-
-	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
-	    ((group == 0) && ((EXT4_INODES_PER_GROUP(sb) -
-			       ext4_itable_unused_count(sb, gdp)) <
-			      EXT4_FIRST_INO(sb)))) {
-		ext4_error(sb, "Something is wrong with group %u: "
-			   "used itable blocks: %d; "
-			   "itable unused count: %u",
-			   group, used_blks,
-			   ext4_itable_unused_count(sb, gdp));
-		ret = 1;
-		goto err_out;
+	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
+		used_inos = EXT4_INODES_PER_GROUP(sb) -
+			    ext4_itable_unused_count(sb, gdp);
+		used_blks = DIV_ROUND_UP(used_inos, sbi->s_inodes_per_block);
+
+		/* Bogus inode unused count? */
+		if (used_blks < 0 || used_blks > sbi->s_itb_per_group) {
+			ext4_error(sb, "Something is wrong with group %u: "
+				   "used itable blocks: %d; "
+				   "itable unused count: %u",
+				   group, used_blks,
+				   ext4_itable_unused_count(sb, gdp));
+			ret = 1;
+			goto err_out;
+		}
+
+		used_inos += group * EXT4_INODES_PER_GROUP(sb);
+		/*
+		 * Are there some uninitialized inodes in the inode table
+		 * before the first normal inode?
+		 */
+		if ((used_blks != sbi->s_itb_per_group) &&
+		     (used_inos < EXT4_FIRST_INO(sb))) {
+			ext4_error(sb, "Something is wrong with group %u: "
+				   "itable unused count: %u; "
+				   "itables initialized count: %ld",
+				   group, ext4_itable_unused_count(sb, gdp),
+				   used_inos);
+			ret = 1;
+			goto err_out;
+		}
 	}
 
 	blk = ext4_inode_table(sb, gdp) + used_blks;
-- 
2.25.4

