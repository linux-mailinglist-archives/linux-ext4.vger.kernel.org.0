Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B676D159E81
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 02:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBLBHY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 20:07:24 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:46144 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgBLBHX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 20:07:23 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id 1gUqjIpJe17ZD1gUrjho6O; Tue, 11 Feb 2020 18:07:22 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ySfo2T4IAAAA:8 a=OgE5IYk6dBAGL2vbqO0A:9
 a=WqaHDVXMCiFsuVM0:21 a=G7kWGAVe6IRKcX36:21 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] e2fsck: avoid overflow with very large dirs
Date:   Tue, 11 Feb 2020 18:07:21 -0700
Message-Id: <1581469641-85696-1-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfMsNDvW6dL2vHcd3xOpAA6P863fxwckTtH7kNOII257R35GYuwWgSzk1HdO/CIfMB9y11EnR9amm8r4V0I5v4lJexJsvnBJvnBYQTJBTqpx9Po35d0ip
 GxttMR0AgkIeiZ1BW0xCVkWVEgbBR0/2WXohOp0tmpi29iCOvXQATj3O/X00OnxPTIGmf9yeWfg7i0HGkr3b1F/onUOUD1xMuq60mHGKv5Z0OLWLqNpVi4NU
 1LQ8shuSuY8/9LLFgi3QJg==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In alloc_size_dir() it multiples signed ints when allocating the
buffer for rehashing an htree-indexed directory.  This will overflow
when the directory size is above 4GB, which is possible with largedir
directories having about 100M entries, assuming an average 3/4 leaf
fullness and 24-byte filenames, or fewer with longer filenames.
The same problem exisgs in get_next_block().

Similarly, the out_dir struct used a signed int for the number of
blocks in the directory, which may result in a negative size if the
directory is over 2GB (about 50M entries or fewer).

Use appropriate unsigned variables for block counts, and use larger
types for calculating the byte count for memory offsets/sizes.

Such large directories not been seen yet, but are not too far away.
The ext2fs_get_array() function will properly calculate the needed
memory allocation, and detect overflow on 32-bit systems.
Add ext2fs_resize_array() to do the same for array resize.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/pass2.c      | 10 ++++----
 e2fsck/rehash.c     | 72 +++++++++++++++++++++++++++++------------------------
 lib/ext2fs/ext2fs.h | 44 ++++++++++++++++++++++++++------
 3 files changed, 81 insertions(+), 45 deletions(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 0fa6233..a280619 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -88,7 +88,7 @@ struct check_dir_struct {
 static void update_parents(struct dx_dir_info *dx_dir, int type)
 {
 	struct dx_dirblock_info *dx_db, *dx_parent, *dx_previous;
-	int b;
+	blk_t b;
 
 	for (b = 0, dx_db = dx_dir->dx_block;
 	     b < dx_dir->numblocks;
@@ -130,7 +130,7 @@ void e2fsck_pass2(e2fsck_t ctx)
 	struct check_dir_struct cd;
 	struct dx_dir_info	*dx_dir;
 	struct dx_dirblock_info	*dx_db;
-	int			b;
+	blk_t			b;
 	ext2_ino_t		i;
 	short			depth;
 	problem_t		code;
@@ -570,8 +570,8 @@ static void parse_int_node(ext2_filsys fs,
 			   struct dx_dir_info	*dx_dir,
 			   char *block_buf, int failed_csum)
 {
-	struct 		ext2_dx_root_info  *root;
-	struct 		ext2_dx_entry *ent;
+	struct		ext2_dx_root_info  *root;
+	struct		ext2_dx_entry *ent;
 	struct		ext2_dx_countlimit *limit;
 	struct dx_dirblock_info	*dx_db;
 	int		i, expect_limit, count;
@@ -646,7 +646,7 @@ static void parse_int_node(ext2_filsys fs,
 #endif
 		blk = ext2fs_le32_to_cpu(ent[i].block) & EXT4_DX_BLOCK_MASK;
 		/* Check to make sure the block is valid */
-		if (blk >= (blk_t) dx_dir->numblocks) {
+		if (blk >= dx_dir->numblocks) {
 			cd->pctx.blk = blk;
 			if (fix_problem(cd->ctx, PR_2_HTREE_BADBLK,
 					&cd->pctx))
diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index c9d667b..6cb1c8e 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -80,8 +80,8 @@ struct fill_dir_struct {
 	errcode_t err;
 	e2fsck_t ctx;
 	struct hash_entry *harray;
-	int max_array, num_array;
-	unsigned int dir_size;
+	blk_t max_array, num_array;
+	ext2_off64_t dir_size;
 	int compress;
 	ext2_ino_t parent;
 	ext2_ino_t dir;
@@ -95,8 +95,8 @@ struct hash_entry {
 };
 
 struct out_dir {
-	int		num;
-	int		max;
+	blk_t		num;
+	blk_t		max;
 	char		*buf;
 	ext2_dirhash_t	*hashes;
 };
@@ -169,13 +169,16 @@ static int fill_dir_block(ext2_filsys fs,
 			continue;
 		}
 		if (fd->num_array >= fd->max_array) {
-			new_array = realloc(fd->harray,
-			    sizeof(struct hash_entry) * (fd->max_array+500));
-			if (!new_array) {
-				fd->err = ENOMEM;
+			errcode_t retval;
+
+			retval = ext2fs_resize_array(sizeof(struct hash_entry),
+						     fd->max_array,
+						     fd->max_array + 500,
+						     &fd->harray);
+			if (retval) {
+				fd->err = retval;
 				return BLOCK_ABORT;
 			}
-			fd->harray = new_array;
 			fd->max_array += 500;
 		}
 		ent = fd->harray + fd->num_array++;
@@ -256,23 +259,28 @@ static EXT2_QSORT_TYPE hash_cmp(const void *a, const void *b)
 }
 
 static errcode_t alloc_size_dir(ext2_filsys fs, struct out_dir *outdir,
-				int blocks)
+				blk_t blocks)
 {
-	void			*new_mem;
+	errcode_t retval;
 
 	if (outdir->max) {
-		new_mem = realloc(outdir->buf, blocks * fs->blocksize);
-		if (!new_mem)
-			return ENOMEM;
-		outdir->buf = new_mem;
-		new_mem = realloc(outdir->hashes,
-				  blocks * sizeof(ext2_dirhash_t));
-		if (!new_mem)
-			return ENOMEM;
-		outdir->hashes = new_mem;
+		retval = ext2fs_resize_array(fs->blocksize, outdir->max, blocks,
+					     &outdir->buf);
+		if (retval)
+			return retval;
+		retval = ext2fs_resize_array(sizeof(ext2_dirhash_t),
+					     outdir->max, blocks,
+					     &outdir->hashes);
+		if (retval)
+			return retval;
 	} else {
-		outdir->buf = malloc(blocks * fs->blocksize);
-		outdir->hashes = malloc(blocks * sizeof(ext2_dirhash_t));
+		retval = ext2fs_get_array(fs->blocksize, blocks, &outdir->buf);
+		if (retval)
+			return retval;
+		retval = ext2fs_get_array(sizeof(ext2_dirhash_t), blocks,
+					  &outdir->hashes);
+		if (retval)
+			return retval;
 		outdir->num = 0;
 	}
 	outdir->max = blocks;
@@ -297,7 +305,7 @@ static errcode_t get_next_block(ext2_filsys fs, struct out_dir *outdir,
 		if (retval)
 			return retval;
 	}
-	*ret = outdir->buf + (outdir->num++ * fs->blocksize);
+	*ret = outdir->buf + (size_t)outdir->num++ * fs->blocksize;
 	memset(*ret, 0, fs->blocksize);
 	return 0;
 }
@@ -367,8 +375,8 @@ static int duplicate_search_and_fix(e2fsck_t ctx, ext2_filsys fs,
 				    struct fill_dir_struct *fd)
 {
 	struct problem_context	pctx;
-	struct hash_entry 	*ent, *prev;
-	int			i, j;
+	struct hash_entry	*ent, *prev;
+	blk_t			i, j;
 	int			fixed = 0;
 	char			new_name[256];
 	unsigned int		new_len;
@@ -869,14 +877,14 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 	   (inode.i_flags & EXT4_INLINE_DATA_FL))
 		return 0;
 
-	retval = ENOMEM;
-	dir_buf = malloc(inode.i_size);
-	if (!dir_buf)
+	retval = ext2fs_get_mem(inode.i_size, &dir_buf);
+	if (retval)
 		goto errout;
 
 	fd.max_array = inode.i_size / 32;
-	fd.harray = malloc(fd.max_array * sizeof(struct hash_entry));
-	if (!fd.harray)
+	retval = ext2fs_get_array(sizeof(struct hash_entry),
+				  fd.max_array, &fd.harray);
+	if (retval)
 		goto errout;
 
 	fd.ino = ino;
@@ -965,8 +973,8 @@ resort:
 	else
 		retval = e2fsck_check_rebuild_extents(ctx, ino, &inode, pctx);
 errout:
-	free(dir_buf);
-	free(fd.harray);
+	ext2fs_free_mem(&dir_buf);
+	ext2fs_free_mem(&fd.harray);
 
 	free_out_dir(&outdir);
 	return retval;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 59fd974..452af6a 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1760,6 +1760,8 @@ extern errcode_t ext2fs_get_arrayzero(unsigned long count,
 extern errcode_t ext2fs_free_mem(void *ptr);
 extern errcode_t ext2fs_resize_mem(unsigned long old_size,
 				   unsigned long size, void *ptr);
+extern errcode_t ext2fs_resize_array(unsigned long old_count, unsigned long count,
+				     unsigned long size, void *ptr);
 extern void ext2fs_mark_super_dirty(ext2_filsys fs);
 extern void ext2fs_mark_changed(ext2_filsys fs);
 extern int ext2fs_test_changed(ext2_filsys fs);
@@ -1837,7 +1839,8 @@ _INLINE_ errcode_t ext2fs_get_memzero(unsigned long size, void *ptr)
 	return 0;
 }
 
-_INLINE_ errcode_t ext2fs_get_array(unsigned long count, unsigned long size, void *ptr)
+_INLINE_ errcode_t ext2fs_get_array(unsigned long count, unsigned long size,
+				    void *ptr)
 {
 	if (count && (~0UL)/count < size)
 		return EXT2_ET_NO_MEMORY;
@@ -1847,15 +1850,10 @@ _INLINE_ errcode_t ext2fs_get_array(unsigned long count, unsigned long size, voi
 _INLINE_ errcode_t ext2fs_get_arrayzero(unsigned long count,
 					unsigned long size, void *ptr)
 {
-	void *pp;
-
 	if (count && (~0UL)/count < size)
 		return EXT2_ET_NO_MEMORY;
-	pp = calloc(count, size);
-	if (!pp)
-		return EXT2_ET_NO_MEMORY;
-	memcpy(ptr, &pp, sizeof(pp));
-	return 0;
+
+	return ext2fs_get_memzero((size_t)count * size, ptr);
 }
 
 /*
@@ -1889,6 +1887,36 @@ _INLINE_ errcode_t ext2fs_resize_mem(unsigned long EXT2FS_ATTR((unused)) old_siz
 	memcpy(ptr, &p, sizeof(p));
 	return 0;
 }
+
+/*
+ *  Resize array.  The 'ptr' arg must point to a pointer.
+ */
+_INLINE_ errcode_t ext2fs_resize_array(unsigned long size,
+				       unsigned long old_count,
+				       unsigned long count, void *ptr)
+{
+	unsigned long old_size;
+	errcode_t retval;
+
+	if (count && (~0UL)/count < size)
+		return EXT2_ET_NO_MEMORY;
+
+	size *= count;
+	old_size = size * old_count;
+	retval = ext2fs_resize_mem(old_size, size, ptr);
+	if (retval)
+		return retval;
+
+	if (size > old_size) {
+		void *p;
+
+		memcpy(&p, ptr, sizeof(p));
+		memset((char *)p + old_size, 0, size - old_size);
+		memcpy(ptr, &p, sizeof(p));
+	}
+
+	return 0;
+}
 #endif	/* Custom memory routines */
 
 /*
-- 
1.8.0

