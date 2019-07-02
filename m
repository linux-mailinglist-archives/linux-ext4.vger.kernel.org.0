Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9655D8B5
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGCA1l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbfGCA1k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:40 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62LC4Fi013815
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:12:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0157942002E; Tue,  2 Jul 2019 17:12:03 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     adilger@dilger.ca, artem.blagodarenko@gmail.com,
        "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH -v2] ext4: allow directory holes
Date:   Tue,  2 Jul 2019 17:11:32 -0400
Message-Id: <20190702211132.26626-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702200459.GF3032@mit.edu>
References: <20190702200459.GF3032@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The largedir feature was intended to allow ext4 directories to have
unmapped directory blocks (e.g., directory holes).  And so the
released e2fsprogs no longer enforces this for largedir file systems;
however, the corresponding change to the kernel-side code was not made.

This commit fixes this oversight.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/dir.c   | 19 +++++++++----------
 fs/ext4/namei.c | 45 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 770a1e6d4672..3a77b7affd09 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -112,7 +112,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
-	int dir_has_error = 0;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -148,8 +147,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			return err;
 	}
 
-	offset = ctx->pos & (sb->s_blocksize - 1);
-
 	while (ctx->pos < inode->i_size) {
 		struct ext4_map_blocks map;
 
@@ -158,9 +155,18 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			goto errout;
 		}
 		cond_resched();
+		offset = ctx->pos & (sb->s_blocksize - 1);
 		map.m_lblk = ctx->pos >> EXT4_BLOCK_SIZE_BITS(sb);
 		map.m_len = 1;
 		err = ext4_map_blocks(NULL, inode, &map, 0);
+		if (err == 0) {
+			/* m_len should never be zero but let's avoid
+			 * an infinite loop if it somehow is */
+			if (map.m_len == 0)
+				map.m_len = 1;
+			ctx->pos += map.m_len * sb->s_blocksize;
+			continue;
+		}
 		if (err > 0) {
 			pgoff_t index = map.m_pblk >>
 					(PAGE_SHIFT - inode->i_blkbits);
@@ -179,13 +185,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (!bh) {
-			if (!dir_has_error) {
-				EXT4_ERROR_FILE(file, 0,
-						"directory contains a "
-						"hole at offset %llu",
-					   (unsigned long long) ctx->pos);
-				dir_has_error = 1;
-			}
 			/* corrupt size?  Maybe no more blocks to read */
 			if (ctx->pos > inode->i_blocks << 9)
 				break;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4909ced4e672..0cda080f3fd5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -82,8 +82,18 @@ static struct buffer_head *ext4_append(handle_t *handle,
 static int ext4_dx_csum_verify(struct inode *inode,
 			       struct ext4_dir_entry *dirent);
 
+/*
+ * Hints to ext4_read_dirblock regarding whether we expect a directory
+ * block being read to be an index block, or a block containing
+ * directory entries (and if the latter, whether it was found via a
+ * logical block in an htree index block).  This is used to control
+ * what sort of sanity checkinig ext4_read_dirblock() will do on the
+ * directory block read from the storage device.  EITHER will means
+ * the caller doesn't know what kind of directory block will be read,
+ * so no specific verification will be done.
+ */
 typedef enum {
-	EITHER, INDEX, DIRENT
+	EITHER, INDEX, DIRENT, DIRENT_HTREE
 } dirblock_type_t;
 
 #define ext4_read_dirblock(inode, block, type) \
@@ -109,11 +119,14 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 		return bh;
 	}
-	if (!bh) {
+	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
 		ext4_error_inode(inode, func, line, block,
-				 "Directory hole found");
+				 "Directory hole found for htree %s block",
+				 (type == INDEX) ? "index" : "leaf");
 		return ERR_PTR(-EFSCORRUPTED);
 	}
+	if (!bh)
+		return NULL;
 	dirent = (struct ext4_dir_entry *) bh->b_data;
 	/* Determine whether or not we have an index block */
 	if (is_dx(inode)) {
@@ -980,7 +993,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 
 	dxtrace(printk(KERN_INFO "In htree dirblock_to_tree: block %lu\n",
 							(unsigned long)block));
-	bh = ext4_read_dirblock(dir, block, DIRENT);
+	bh = ext4_read_dirblock(dir, block, DIRENT_HTREE);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -1619,7 +1632,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		return (struct buffer_head *) frame;
 	do {
 		block = dx_get_block(frame->at);
-		bh = ext4_read_dirblock(dir, block, DIRENT);
+		bh = ext4_read_dirblock(dir, block, DIRENT_HTREE);
 		if (IS_ERR(bh))
 			goto errout;
 
@@ -2203,6 +2216,11 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	blocks = dir->i_size >> sb->s_blocksize_bits;
 	for (block = 0; block < blocks; block++) {
 		bh = ext4_read_dirblock(dir, block, DIRENT);
+		if (bh == NULL) {
+			bh = ext4_bread(handle, dir, block,
+					EXT4_GET_BLOCKS_CREATE);
+			goto add_to_new_block;
+		}
 		if (IS_ERR(bh)) {
 			retval = PTR_ERR(bh);
 			bh = NULL;
@@ -2223,6 +2241,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 		brelse(bh);
 	}
 	bh = ext4_append(handle, dir, &block);
+add_to_new_block:
 	if (IS_ERR(bh)) {
 		retval = PTR_ERR(bh);
 		bh = NULL;
@@ -2267,7 +2286,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		return PTR_ERR(frame);
 	entries = frame->entries;
 	at = frame->at;
-	bh = ext4_read_dirblock(dir, dx_get_block(frame->at), DIRENT);
+	bh = ext4_read_dirblock(dir, dx_get_block(frame->at), DIRENT_HTREE);
 	if (IS_ERR(bh)) {
 		err = PTR_ERR(bh);
 		bh = NULL;
@@ -2815,7 +2834,10 @@ bool ext4_empty_dir(struct inode *inode)
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
 	}
-	bh = ext4_read_dirblock(inode, 0, EITHER);
+	/* The first directory block must not be a hole,
+	 * so treat it as DIRENT_HTREE
+	 */
+	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
 	if (IS_ERR(bh))
 		return true;
 
@@ -2837,6 +2859,10 @@ bool ext4_empty_dir(struct inode *inode)
 			brelse(bh);
 			lblock = offset >> EXT4_BLOCK_SIZE_BITS(sb);
 			bh = ext4_read_dirblock(inode, lblock, EITHER);
+			if (bh == NULL) {
+				offset += sb->s_blocksize;
+				continue;
+			}
 			if (IS_ERR(bh))
 				return true;
 			de = (struct ext4_dir_entry_2 *) bh->b_data;
@@ -3402,7 +3428,10 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 	struct buffer_head *bh;
 
 	if (!ext4_has_inline_data(inode)) {
-		bh = ext4_read_dirblock(inode, 0, EITHER);
+		/* The first directory block must not be a hole, so
+		 * treat it as DIRENT_HTREE
+		 */
+		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
 		if (IS_ERR(bh)) {
 			*retval = PTR_ERR(bh);
 			return NULL;
-- 
2.22.0

