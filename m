Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF5154FF8
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGBR6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:58 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:60372 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgBGBR6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:58 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9WiUgmc; Thu, 06 Feb 2020 18:09:50 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=ySfo2T4IAAAA:8
 a=RSkUNqeqXmXpIk4qef4A:9 a=4bnzBSHjHzr61jQX:21 a=Z3tS7b3IrKJYlsr4:21
 a=fa_un-3J20JGBB2Tu-mn:22 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 7/9] e2fsck: fix overflow if more than 4B inodes
Date:   Thu,  6 Feb 2020 18:09:44 -0700
Message-Id: <1581037786-62789-7-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfCHFKYyVwTbMSdzILXV/ZzhITSbAJ1orY4M4amqh9Q6vQun2CxmuFZyZXL97gNl2y2ZZiJKkbNJ0ZfSuXxHFdVuxkHQCHGLfB86PTPP1JDBUexb7fH6+
 /OdoHj9ml1MEWVZ+Yehw4JwRhAfgvv01JkbFxqV91muDdZDjnkrtbMlKQ+ivUEMfIjgjUlVPTd4cMzxltj/fYESJ5IQxCGnTjWYsZiXzxAObojX2i9eyBrGK
 UqqCp6jX2MjkZPSD/GRkumZGSdqZOgwvZ6UOzUzRw8A=
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Even though we don't have support for filesystems with over 4B inodes
in the current e2fsprogs, this may happen in the future.  There are
latent overflow bugs when calculating the number of inodes in the
filesystem that can trivially be fixed now, rather than waiting for
them to be hit at some point in the future.  The block number calcs
are already correct in this code.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/pass5.c       | 2 +-
 lib/ext2fs/bitmaps.c | 3 ++-
 lib/ext2fs/imager.c  | 6 ++++--
 misc/fuse2fs.c       | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/e2fsck/pass5.c b/e2fsck/pass5.c
index 3a5c88d..c1d45a5 100644
--- a/e2fsck/pass5.c
+++ b/e2fsck/pass5.c
@@ -842,7 +842,7 @@ static void check_inode_end(e2fsck_t ctx)
 
 	clear_problem_context(&pctx);
 
-	end = EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count;
+	end = (__u64)EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count;
 	pctx.errcode = ext2fs_fudge_inode_bitmap_end(fs->inode_map, end,
 						     &save_inodes_count);
 	if (pctx.errcode) {
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index e25db2c..834a396 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -62,7 +62,8 @@ errcode_t ext2fs_allocate_inode_bitmap(ext2_filsys fs,
 
 	start = 1;
 	end = fs->super->s_inodes_count;
-	real_end = (EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count);
+	real_end = (__u64)EXT2_INODES_PER_GROUP(fs->super) *
+		fs->group_desc_count;
 
 	/* Are we permitted to use new-style bitmaps? */
 	if (fs->flags & EXT2_FLAG_64BITS)
diff --git a/lib/ext2fs/imager.c b/lib/ext2fs/imager.c
index fee27ac..09cd508 100644
--- a/lib/ext2fs/imager.c
+++ b/lib/ext2fs/imager.c
@@ -344,7 +344,8 @@ errcode_t ext2fs_image_bitmap_write(ext2_filsys fs, int fd, int flags)
 		}
 		bmap = fs->inode_map;
 		itr = 1;
-		cnt = EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count;
+		cnt = (__u64)EXT2_INODES_PER_GROUP(fs->super) *
+			fs->group_desc_count;
 		size = (EXT2_INODES_PER_GROUP(fs->super) / 8);
 	} else {
 		if (!fs->block_map) {
@@ -419,7 +420,8 @@ errcode_t ext2fs_image_bitmap_read(ext2_filsys fs, int fd, int flags)
 		}
 		bmap = fs->inode_map;
 		itr = 1;
-		cnt = EXT2_INODES_PER_GROUP(fs->super) * fs->group_desc_count;
+		cnt = (__u64)EXT2_INODES_PER_GROUP(fs->super) *
+			fs->group_desc_count;
 		size = (EXT2_INODES_PER_GROUP(fs->super) / 8);
 	} else {
 		if (!fs->block_map) {
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index be2cd1d..31493e2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2364,7 +2364,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 		overhead = 0;
 	else
 		overhead = fs->desc_blocks +
-			   fs->group_desc_count *
+			   (blk64_t)fs->group_desc_count *
 			   (fs->inode_blocks_per_group + 2);
 	reserved = ext2fs_r_blocks_count(fs->super);
 	if (!reserved)
-- 
1.8.0

