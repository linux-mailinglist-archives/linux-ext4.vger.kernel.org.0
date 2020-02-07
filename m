Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB580154FF9
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGBR6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:58 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:60360 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgBGBR6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:58 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9UiUgm7; Thu, 06 Feb 2020 18:09:48 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=lB0dNpNiAAAA:8
 a=ySfo2T4IAAAA:8 a=n5g6tTv5hIqwu9bi9qwA:9 a=SxFnjEeBbgVWZi-6:21
 a=ScjRz5q2cr_2IdMi:21 a=fa_un-3J20JGBB2Tu-mn:22 a=c-ZiYqmG3AbHTdtsH08C:22
 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 2/9] e2fsck: use proper types for variables
Date:   Thu,  6 Feb 2020 18:09:39 -0700
Message-Id: <1581037786-62789-2-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfLK7gBrgKJNGOHfX1CHZbneT2U9JJA3dxlDPySRMNgC2ASvzZ47PYyF9unL9nZncZPi3XguckEEosvJM1QBdXWH3UzpF+FNyFUh+p3zQClhbuVUyWMWj
 r4758mVEYxSdKpNsFB9J54Oa2hH4/lv2QtJ178JLy/zOi12ApnAxVQkc3jmnwubQqBTwlUkfh1B9fPXMTZNStJXjLBwW/FTw30FeTKRnGg93NXUX+0kUfvAx
 8osttYS6SEueqd3b00Q1dEDawpjbTIj2tWq0hXjYEVw=
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use ext2_ino_t instead of ino_t for referencing inode numbers.
Use loff_t for for file offsets, and dgrp_t for group numbers.

Cast products to ssize_t before multiplication to avoid overflow.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Shilong Wang <wshilong@ddn.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/dx_dirinfo.c |  6 +++---
 e2fsck/e2fsck.h     | 11 ++++++-----
 e2fsck/rehash.c     |  2 +-
 e2fsck/super.c      |  2 +-
 lib/ext2fs/imager.c | 34 +++++++++++++++++++---------------
 misc/create_inode.c |  2 +-
 misc/dumpe2fs.c     |  2 +-
 misc/e2fuzz.c       |  8 ++++----
 misc/e2image.c      |  2 +-
 misc/tune2fs.c      |  2 +-
 10 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index 89672b7..f0f6084 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -138,7 +138,7 @@ void e2fsck_free_dx_dir_info(e2fsck_t ctx)
 /*
  * Return the count of number of directories in the dx_dir_info structure
  */
-int e2fsck_get_num_dx_dirinfo(e2fsck_t ctx)
+ext2_ino_t e2fsck_get_num_dx_dirinfo(e2fsck_t ctx)
 {
 	return ctx->dx_dir_info_count;
 }
@@ -146,10 +146,10 @@ int e2fsck_get_num_dx_dirinfo(e2fsck_t ctx)
 /*
  * A simple interator function
  */
-struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx, int *control)
+struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx, ext2_ino_t *control)
 {
 	if (*control >= ctx->dx_dir_info_count)
 		return 0;
 
-	return(ctx->dx_dir_info + (*control)++);
+	return ctx->dx_dir_info + (*control)++;
 }
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 253f8b5..5e7db42 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -235,12 +235,12 @@ struct e2fsck_struct {
 	char	*problem_log_fn;
 	int	flags;		/* E2fsck internal flags */
 	int	options;
-	int	blocksize;	/* blocksize */
+	unsigned blocksize;	/* blocksize */
 	blk64_t	use_superblock;	/* sb requested by user */
 	blk64_t	superblock;	/* sb used to open fs */
 	blk64_t	num_blocks;	/* Total number of blocks */
-	blk64_t free_blocks;
-	ino_t	free_inodes;
+	blk64_t	free_blocks;
+	ext2_ino_t free_inodes;
 	int	mount_flags;
 	int	openfs_flags;
 	blkid_cache blkid;	/* blkid cache */
@@ -478,8 +478,9 @@ extern void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino,
 			      struct ext2_inode *inode, int num_blocks);
 extern struct dx_dir_info *e2fsck_get_dx_dir_info(e2fsck_t ctx, ext2_ino_t ino);
 extern void e2fsck_free_dx_dir_info(e2fsck_t ctx);
-extern int e2fsck_get_num_dx_dirinfo(e2fsck_t ctx);
-extern struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx, int *control);
+extern ext2_ino_t e2fsck_get_num_dx_dirinfo(e2fsck_t ctx);
+extern struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx,
+						   ext2_ino_t *control);
 
 /* ea_refcount.c */
 typedef __u64 ea_key_t;
diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index a5fc1be..c9d667b 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -83,7 +83,7 @@ struct fill_dir_struct {
 	int max_array, num_array;
 	unsigned int dir_size;
 	int compress;
-	ino_t parent;
+	ext2_ino_t parent;
 	ext2_ino_t dir;
 };
 
diff --git a/e2fsck/super.c b/e2fsck/super.c
index e5932be..3aa1e87 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -595,7 +595,7 @@ void check_super_block(e2fsck_t ctx)
 	blk64_t	should_be;
 	struct problem_context	pctx;
 	blk64_t	free_blocks = 0;
-	ino_t	free_inodes = 0;
+	ext2_ino_t free_inodes = 0;
 	int     csum_flag, clear_test_fs_flag;
 
 	inodes_per_block = EXT2_INODES_PER_BLOCK(fs->super);
diff --git a/lib/ext2fs/imager.c b/lib/ext2fs/imager.c
index 7fd06f7..fee27ac 100644
--- a/lib/ext2fs/imager.c
+++ b/lib/ext2fs/imager.c
@@ -61,19 +61,20 @@ static int check_zero_block(char *buf, int blocksize)
 
 errcode_t ext2fs_image_inode_write(ext2_filsys fs, int fd, int flags)
 {
-	unsigned int	group, left, c, d;
+	dgrp_t		group;
+	ssize_t		left, c, d;
 	char		*buf, *cp;
 	blk64_t		blk;
 	ssize_t		actual;
 	errcode_t	retval;
-	off_t		r;
+	loff_t		r;
 
 	buf = malloc(fs->blocksize * BUF_BLOCKS);
 	if (!buf)
 		return ENOMEM;
 
 	for (group = 0; group < fs->group_desc_count; group++) {
-		blk = ext2fs_inode_table_loc(fs, (unsigned)group);
+		blk = ext2fs_inode_table_loc(fs, group);
 		if (!blk) {
 			retval = EXT2_ET_MISSING_INODE_TABLE;
 			goto errout;
@@ -107,23 +108,25 @@ errcode_t ext2fs_image_inode_write(ext2_filsys fs, int fd, int flags)
 					continue;
 				}
 				/* Find non-zero blocks */
-				for (d=1; d < c; d++) {
-					if (check_zero_block(cp + d*fs->blocksize, fs->blocksize))
+				for (d = 1; d < c; d++) {
+					if (check_zero_block(cp +
+							     d * fs->blocksize,
+							     fs->blocksize))
 						break;
 				}
 			skip_sparse:
-				actual = write(fd, cp, fs->blocksize * d);
+				actual = write(fd, cp, d * fs->blocksize);
 				if (actual == -1) {
 					retval = errno;
 					goto errout;
 				}
-				if (actual != (ssize_t) (fs->blocksize * d)) {
+				if (actual != d * fs->blocksize) {
 					retval = EXT2_ET_SHORT_WRITE;
 					goto errout;
 				}
 				blk += d;
 				left -= d;
-				cp += fs->blocksize * d;
+				cp += d * fs->blocksize;
 				c -= d;
 			}
 		}
@@ -141,7 +144,8 @@ errout:
 errcode_t ext2fs_image_inode_read(ext2_filsys fs, int fd,
 				  int flags EXT2FS_ATTR((unused)))
 {
-	unsigned int	group, c, left;
+	dgrp_t		group;
+	ssize_t		c, left;
 	char		*buf;
 	blk64_t		blk;
 	ssize_t		actual;
@@ -152,7 +156,7 @@ errcode_t ext2fs_image_inode_read(ext2_filsys fs, int fd,
 		return ENOMEM;
 
 	for (group = 0; group < fs->group_desc_count; group++) {
-		blk = ext2fs_inode_table_loc(fs, (unsigned)group);
+		blk = ext2fs_inode_table_loc(fs, group);
 		if (!blk) {
 			retval = EXT2_ET_MISSING_INODE_TABLE;
 			goto errout;
@@ -167,7 +171,7 @@ errcode_t ext2fs_image_inode_read(ext2_filsys fs, int fd,
 				retval = errno;
 				goto errout;
 			}
-			if (actual != (ssize_t) (fs->blocksize * c)) {
+			if (actual != fs->blocksize * c) {
 				retval = EXT2_ET_SHORT_READ;
 				goto errout;
 			}
@@ -249,7 +253,7 @@ errcode_t ext2fs_image_super_write(ext2_filsys fs, int fd,
 	}
 #endif
 
-	actual = write(fd, cp, fs->blocksize * fs->desc_blocks);
+	actual = write(fd, cp, (ssize_t)fs->blocksize * fs->desc_blocks);
 
 
 #ifdef WORDS_BIGENDIAN
@@ -265,7 +269,7 @@ errcode_t ext2fs_image_super_write(ext2_filsys fs, int fd,
 		retval = errno;
 		goto errout;
 	}
-	if (actual != (ssize_t) (fs->blocksize * fs->desc_blocks)) {
+	if (actual != (ssize_t)fs->blocksize * fs->desc_blocks) {
 		retval = EXT2_ET_SHORT_WRITE;
 		goto errout;
 	}
@@ -287,7 +291,7 @@ errcode_t ext2fs_image_super_read(ext2_filsys fs, int fd,
 	ssize_t		actual, size;
 	errcode_t	retval;
 
-	size = fs->blocksize * (fs->group_desc_count + 1);
+	size = (ssize_t)fs->blocksize * (fs->group_desc_count + 1);
 	buf = malloc(size);
 	if (!buf)
 		return ENOMEM;
@@ -311,7 +315,7 @@ errcode_t ext2fs_image_super_read(ext2_filsys fs, int fd,
 	memcpy(fs->super, buf, SUPERBLOCK_SIZE);
 
 	memcpy(fs->group_desc, buf + fs->blocksize,
-	       fs->blocksize * fs->group_desc_count);
+	       (ssize_t)fs->blocksize * fs->group_desc_count);
 
 	retval = 0;
 
diff --git a/misc/create_inode.c b/misc/create_inode.c
index 0091b72..6387425 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -599,7 +599,7 @@ out:
 	return err;
 }
 
-static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ino_t ino)
+static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ext2_ino_t ino)
 {
 	int i;
 
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 384ce92..b812c93 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -362,7 +362,7 @@ static void print_inline_journal_information(ext2_filsys fs)
 	struct ext2_inode	inode;
 	ext2_file_t		journal_file;
 	errcode_t		retval;
-	ino_t			ino = fs->super->s_journal_inum;
+	ext2_ino_t		ino = fs->super->s_journal_inum;
 	char			buf[1024];
 
 	if (fs->flags & EXT2_FLAG_IMAGE_FILE)
diff --git a/misc/e2fuzz.c b/misc/e2fuzz.c
index 8576d4e..7c0f776 100644
--- a/misc/e2fuzz.c
+++ b/misc/e2fuzz.c
@@ -181,9 +181,9 @@ static int process_fs(const char *fsname)
 	int flags, fd;
 	ext2_filsys fs = NULL;
 	ext2fs_block_bitmap corrupt_map;
-	off_t hsize, count, off, offset, corrupt_bytes;
+	loff_t hsize, count, off, offset, corrupt_bytes;
 	unsigned char c;
-	off_t i;
+	loff_t i;
 
 	/* If mounted rw, force dryrun mode */
 	ret = ext2fs_check_if_mounted(fsname, &flags);
@@ -277,8 +277,8 @@ static int process_fs(const char *fsname)
 			c |= 0x80;
 		if (verbose)
 			printf("Corrupting byte %lld in block %lld to 0x%x\n",
-			       (long long) off % fs->blocksize,
-			       (long long) off / fs->blocksize, c);
+			       off % fs->blocksize,
+			       off / fs->blocksize, c);
 		if (dryrun)
 			continue;
 #ifdef HAVE_PWRITE64
diff --git a/misc/e2image.c b/misc/e2image.c
index 30f2543..2c0e14d 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -312,7 +312,7 @@ struct process_block_struct {
  * structure, so there's no point in letting the ext2fs library read
  * the inode again.
  */
-static ino_t stashed_ino = 0;
+static ext2_ino_t stashed_ino = 0;
 static struct ext2_inode *stashed_inode;
 
 static errcode_t meta_get_blocks(ext2_filsys fs EXT2FS_ATTR((unused)),
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 7d2d38d..0324cbb 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -365,7 +365,7 @@ static errcode_t remove_journal_inode(ext2_filsys fs)
 {
 	struct ext2_inode	inode;
 	errcode_t		retval;
-	ino_t			ino = fs->super->s_journal_inum;
+	ext2_ino_t		ino = fs->super->s_journal_inum;
 
 	retval = ext2fs_read_inode(fs, ino,  &inode);
 	if (retval) {
-- 
1.8.0

