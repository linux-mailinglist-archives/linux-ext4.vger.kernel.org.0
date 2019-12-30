Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1D12D41D
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfL3Twi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 14:52:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48893 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727278AbfL3Twi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 14:52:38 -0500
Received: from callcc.thunk.org ([173.239.199.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBUJqKV1030102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 14:52:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E84F3420485; Mon, 30 Dec 2019 14:52:18 -0500 (EST)
Date:   Mon, 30 Dec 2019 14:52:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lixi@ddn.com, dongyangli@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] e2fsprogs: fix to use inode i_blocks correctly
Message-ID: <20191230195218.GC125106@mit.edu>
References: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
 <20191230151921.GA125106@mit.edu>
 <37689479-8118-4ED1-A98C-4A3E982B4575@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37689479-8118-4ED1-A98C-4A3E982B4575@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 30, 2019 at 11:37:40AM -0700, Andreas Dilger wrote:
> 
> No patch is attached?

Oops, here you go.

				- Ted

commit c90cea86eeef89f29f7bd5535fbaa5809a812cc7
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Mon Dec 30 10:12:58 2019 -0500

    ext2fs: add ext2fs_get_stat_i_blocks() function
    
    The function ext2fs_inode_i_blocks() is a bit confusing whether it is
    returning the inode's i_blocks value, or whether it is returning the
    value ala the stat(2) system call, which returns i_blocks in units of
    512 byte sectors.  This caused ext2fs_inode_i_blocks() to be
    incorrectly used in fuse2fs and the function quota_compute_usage().
    
    To address this, we add a new function, ext2fs_get_stat_i_blocks()
    which is clearly labelled what it is returning, and use it in fuse2fs
    and quota_compute_usage().  It's also a bit more convenient to use it
    in e2fsck, so use it there too.
    
    Reported-by: Wang Shilong <wangshilong1991@gmail.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 3073725a..e9af1bbe 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -264,7 +264,7 @@ extents_loaded:
 		goto err;
 
 	ext_written = 0;
-	start_val = ext2fs_inode_i_blocks(ctx->fs, EXT2_INODE(&inode));
+	start_val = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode));
 	for (i = 0, ex = list->extents; i < list->count; i++, ex++) {
 		memcpy(&extent, ex, sizeof(struct ext2fs_extent));
 		extent.e_flags &= EXT2_EXTENT_FLAGS_UNINIT;
@@ -302,15 +302,10 @@ extents_loaded:
 		ext_written++;
 	}
 
-	delta = ext2fs_inode_i_blocks(ctx->fs, EXT2_INODE(&inode)) - start_val;
-	if (delta) {
-		if (!ext2fs_has_feature_huge_file(ctx->fs->super) ||
-		    !(inode.i_flags & EXT4_HUGE_FILE_FL))
-			delta <<= 9;
-		else
-			delta *= ctx->fs->blocksize;
-		quota_data_add(ctx->qctx, &inode, ino, delta);
-	}
+	delta = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode)) -
+		start_val;
+	if (delta)
+		quota_data_add(ctx->qctx, &inode, ino, delta << 9);
 
 #if defined(DEBUG) || defined(DEBUG_SUMMARY)
 	printf("rebuild: ino=%d extents=%d->%d\n", ino, list->ext_read,
diff --git a/lib/ext2fs/blknum.c b/lib/ext2fs/blknum.c
index 9ee5c66e..31055c34 100644
--- a/lib/ext2fs/blknum.c
+++ b/lib/ext2fs/blknum.c
@@ -85,6 +85,22 @@ blk64_t ext2fs_inode_i_blocks(ext2_filsys fs,
 		 (__u64)inode->osd2.linux2.l_i_blocks_hi << 32 : 0));
 }
 
+/*
+ * Return the inode i_blocks in stat (512 byte) units
+ */
+blk64_t ext2fs_get_stat_i_blocks(ext2_filsys fs,
+				 struct ext2_inode *inode)
+{
+	blk64_t	ret = inode->i_blocks;
+
+	if (ext2fs_has_feature_huge_file(fs->super)) {
+		ret += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
+		if (inode->i_flags & EXT4_HUGE_FILE_FL)
+			ret *= (fs->blocksize / 512);
+	}
+	return ret;
+}
+
 /*
  * Return the fs block count
  */
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 59fd9742..ca5e3321 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -908,7 +908,9 @@ extern int ext2fs_group_blocks_count(ext2_filsys fs, dgrp_t group);
 extern blk64_t ext2fs_inode_data_blocks2(ext2_filsys fs,
 					 struct ext2_inode *inode);
 extern blk64_t ext2fs_inode_i_blocks(ext2_filsys fs,
-					 struct ext2_inode *inode);
+				     struct ext2_inode *inode);
+extern blk64_t ext2fs_get_stat_i_blocks(ext2_filsys fs,
+					struct ext2_inode *inode);
 extern blk64_t ext2fs_blocks_count(struct ext2_super_block *super);
 extern void ext2fs_blocks_count_set(struct ext2_super_block *super,
 				    blk64_t blk);
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index ddb53124..6f7ae6d6 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -503,8 +503,8 @@ errcode_t quota_compute_usage(quota_ctx_t qctx)
 		if (inode->i_links_count &&
 		    (ino == EXT2_ROOT_INO ||
 		     ino >= EXT2_FIRST_INODE(fs->super))) {
-			space = ext2fs_inode_i_blocks(fs,
-						      EXT2_INODE(inode)) << 9;
+			space = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(inode)) << 9;
 			quota_data_add(qctx, inode, ino, space);
 			quota_data_inodes(qctx, inode, ino, +1);
 		}
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 94cd5f67..2cfc6af3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -754,23 +754,6 @@ static void *op_init(struct fuse_conn_info *conn)
 	return ff;
 }
 
-static blkcnt_t blocks_from_inode(ext2_filsys fs,
-				  struct ext2_inode_large *inode)
-{
-	blkcnt_t b;
-
-	b = inode->i_blocks;
-	if (ext2fs_has_feature_huge_file(fs->super))
-		b += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
-
-	if (!ext2fs_has_feature_huge_file(fs->super) ||
-	    !(inode->i_flags & EXT4_HUGE_FILE_FL))
-		b *= fs->blocksize / 512;
-	b *= EXT2FS_CLUSTER_RATIO(fs);
-
-	return b;
-}
-
 static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 {
 	struct ext2_inode_large inode;
@@ -794,7 +777,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	statbuf->st_gid = inode_gid(inode);
 	statbuf->st_size = EXT2_I_SIZE(&inode);
 	statbuf->st_blksize = fs->blocksize;
-	statbuf->st_blocks = blocks_from_inode(fs, &inode);
+	statbuf->st_blocks = ext2fs_get_stat_i_blocks(fs, &inode);
 	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
 	statbuf->st_atime = tv.tv_sec;
 	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
