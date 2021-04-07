Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2533565C8
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbhDGHun (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 03:50:43 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:39021 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbhDGHun (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 03:50:43 -0400
Received: from webber.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id U2xLlr3EcnRGtU2xMlupkf; Wed, 07 Apr 2021 01:50:33 -0600
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=606d6449
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=hrY3p4x4ZcOkfYPIKFkA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] ext2fs: avoid re-reading inode multiple times
Date:   Wed,  7 Apr 2021 01:50:23 -0600
Message-Id: <20210407075023.44324-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAs8GCVBNhy14cdHccWMsnBYhwLsEKFdU7v+Zp9BdVVNKVEiOzLemll24WZsqTygDjdlCOzWiIxF8za0bs+WSN1gW/jYu/h/p14e0cj7d//UVCDvfPsH
 ZsT1UzPwc/R/9qG1AqauZvD7+CQjjiSBArBEBHILN3iuB84n2qud89cEKTlBJiNJ0r1NJsg/EuFRyiIItKsVnEL5M6ucR0c9xoY3tQlCsSDNLJz9qi6aCWsh
 geyoRrLVVBJAXI3nhOtZIQ==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reduce the number of times that the inode is read from storage.
Factor ext2fs_xattrs_read() into a new ext2fs_xattrs_read_inode()
function that can accept an in-memory inode, and call that from
within ext2fs_xattrs_read() and in e2fsck_pass1() when the inode
is already available.

Similarly, in e2fsck_pass4() avoid re-reading the inode multiple
times in disconnect_inode(), check_ea_inode(), and in the main
function body if possible.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 e2fsck/pass1.c        |  9 ++++---
 e2fsck/pass4.c        | 47 +++++++++++++++++++++--------------
 lib/ext2fs/ext2fs.h   |  2 ++
 lib/ext2fs/ext_attr.c | 57 +++++++++++++++++++++++++------------------
 4 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 9d430895..e22135de 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -911,6 +911,7 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
 }
 
 static errcode_t get_inline_data_ea_size(ext2_filsys fs, ext2_ino_t ino,
+					 struct ext2_inode *inode,
 					 size_t *sz)
 {
 	void *p;
@@ -921,7 +922,8 @@ static errcode_t get_inline_data_ea_size(ext2_filsys fs, ext2_ino_t ino,
 	if (retval)
 		return retval;
 
-	retval = ext2fs_xattrs_read(handle);
+	retval = ext2fs_xattrs_read_inode(handle,
+					  (struct ext2_inode_large *)inode);
 	if (retval)
 		goto err;
 
@@ -1508,7 +1510,8 @@ void e2fsck_pass1(e2fsck_t ctx)
 		    (ino >= EXT2_FIRST_INODE(fs->super))) {
 			size_t size = 0;
 
-			pctx.errcode = get_inline_data_ea_size(fs, ino, &size);
+			pctx.errcode = get_inline_data_ea_size(fs, ino, inode,
+							       &size);
 			if (!pctx.errcode &&
 			    fix_problem(ctx, PR_1_INLINE_DATA_FEATURE, &pctx)) {
 				ext2fs_set_feature_inline_data(sb);
@@ -1531,7 +1534,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 			flags = fs->flags;
 			if (failed_csum)
 				fs->flags |= EXT2_FLAG_IGNORE_CSUM_ERRORS;
-			err = get_inline_data_ea_size(fs, ino, &size);
+			err = get_inline_data_ea_size(fs, ino, inode, &size);
 			fs->flags = (flags & EXT2_FLAG_IGNORE_CSUM_ERRORS) |
 				    (fs->flags & ~EXT2_FLAG_IGNORE_CSUM_ERRORS);
 
diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
index 8c2d2f1f..6e9e8fe8 100644
--- a/e2fsck/pass4.c
+++ b/e2fsck/pass4.c
@@ -26,7 +26,7 @@
  * This subroutine returns 1 then the caller shouldn't bother with the
  * rest of the pass 4 tests.
  */
-static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i,
+static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
 			    struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ctx->fs;
@@ -34,9 +34,12 @@ static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i,
 	__u32 eamagic = 0;
 	int extra_size = 0;
 
-	e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
-			       EXT2_INODE_SIZE(fs->super),
-			       "pass4: disconnect_inode");
+	if (*last_ino != i) {
+		e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
+				       EXT2_INODE_SIZE(fs->super),
+				       "pass4: disconnect_inode");
+		*last_ino = i;
+	}
 	if (EXT2_INODE_SIZE(fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
 		extra_size = inode->i_extra_isize;
 
@@ -75,6 +78,7 @@ static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i,
 	if (fix_problem(ctx, PR_4_UNATTACHED_INODE, &pctx)) {
 		if (e2fsck_reconnect_file(ctx, i))
 			ext2fs_unmark_valid(fs);
+		*last_ino = 0;
 	} else {
 		/*
 		 * If we don't attach the inode, then skip the
@@ -87,20 +91,22 @@ static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i,
 	return 0;
 }
 
-static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i,
+/*
+ * This function is called when link_counted is zero. So this may not be
+ * an xattr inode at all. Return immediately if EA_INODE flag is not set.
+ */
+static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
 			   struct ext2_inode_large *inode, __u16 *link_counted)
 {
 	__u64 actual_refs = 0;
 	__u64 ref_count;
 
-	/*
-	 * This function is called when link_counted is zero. So this may not
-	 * be an xattr inode at all. Return immediately if EA_INODE flag is not
-	 * set.
-	 */
-	e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
-			       EXT2_INODE_SIZE(ctx->fs->super),
-			       "pass4: check_ea_inode");
+	if (*last_ino != i) {
+		e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
+				       EXT2_INODE_SIZE(ctx->fs->super),
+				       "pass4: check_ea_inode");
+		*last_ino = i;
+	}
 	if (!(inode->i_flags & EXT4_EA_INODE_FL))
 		return;
 
@@ -180,7 +186,8 @@ void e2fsck_pass4(e2fsck_t ctx)
 	inode = e2fsck_allocate_memory(ctx, inode_size, "scratch inode");
 
 	/* Protect loop from wrap-around if s_inodes_count maxed */
-	for (i=1; i <= fs->super->s_inodes_count && i > 0; i++) {
+	for (i = 1; i <= fs->super->s_inodes_count && i > 0; i++) {
+		ext2_ino_t last_ino = 0;
 		int isdir;
 
 		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
@@ -210,7 +217,7 @@ void e2fsck_pass4(e2fsck_t ctx)
 			 * check_ea_inode() will update link_counted if
 			 * necessary.
 			 */
-			check_ea_inode(ctx, i, inode, &link_counted);
+			check_ea_inode(ctx, i, &last_ino, inode, &link_counted);
 		}
 
 		if (link_counted == 0) {
@@ -219,7 +226,7 @@ void e2fsck_pass4(e2fsck_t ctx)
 				     fs->blocksize, "bad_inode buffer");
 			if (e2fsck_process_bad_inode(ctx, 0, i, buf))
 				continue;
-			if (disconnect_inode(ctx, i, inode))
+			if (disconnect_inode(ctx, i, &last_ino, inode))
 				continue;
 			ext2fs_icount_fetch(ctx->inode_link_info, i,
 					    &link_count);
@@ -239,8 +246,12 @@ void e2fsck_pass4(e2fsck_t ctx)
 		if (link_counted != link_count) {
 			int fix_nlink = 0;
 
-			e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
-					       inode_size, "pass4");
+			if (last_ino != i) {
+				e2fsck_read_inode_full(ctx, i,
+						       EXT2_INODE(inode),
+						       inode_size, "pass4");
+				last_ino = i;
+			}
 			pctx.ino = i;
 			pctx.inode = EXT2_INODE(inode);
 			if ((link_count != inode->i_links_count) && !isdir &&
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index df150f00..948eb0b2 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1276,6 +1276,8 @@ extern errcode_t ext2fs_adjust_ea_refcount3(ext2_filsys fs, blk64_t blk,
 					   ext2_ino_t inum);
 errcode_t ext2fs_xattrs_write(struct ext2_xattr_handle *handle);
 errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle);
+errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
+				   struct ext2_inode_large *inode);
 errcode_t ext2fs_xattrs_iterate(struct ext2_xattr_handle *h,
 				int (*func)(char *name, char *value,
 					    size_t value_len, void *data),
diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index 148fae5b..1933ca19 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -985,9 +985,11 @@ static void xattrs_free_keys(struct ext2_xattr_handle *h)
 	h->ibody_count = 0;
 }
 
-errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle)
+/* fetch xattrs from an already-loaded inode */
+errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
+				   struct ext2_inode_large *inode)
 {
-	struct ext2_inode_large *inode;
+
 	struct ext2_ext_attr_header *header;
 	__u32 ea_inode_magic;
 	unsigned int storage_size;
@@ -997,18 +999,6 @@ errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle)
 	errcode_t err;
 
 	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
-	i = EXT2_INODE_SIZE(handle->fs->super);
-	if (i < sizeof(*inode))
-		i = sizeof(*inode);
-	err = ext2fs_get_memzero(i, &inode);
-	if (err)
-		return err;
-
-	err = ext2fs_read_inode_full(handle->fs, handle->ino,
-				     (struct ext2_inode *)inode,
-				     EXT2_INODE_SIZE(handle->fs->super));
-	if (err)
-		goto out;
 
 	xattrs_free_keys(handle);
 
@@ -1044,7 +1034,7 @@ errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle)
 
 read_ea_block:
 	/* Look for EA in a separate EA block */
-	blk = ext2fs_file_acl_block(handle->fs, (struct ext2_inode *)inode);
+	blk = ext2fs_file_acl_block(handle->fs, EXT2_INODE(inode));
 	if (blk != 0) {
 		if ((blk < handle->fs->super->s_first_data_block) ||
 		    (blk >= ext2fs_blocks_count(handle->fs->super))) {
@@ -1075,20 +1065,39 @@ read_ea_block:
 		err = read_xattrs_from_buffer(handle, inode,
 					(struct ext2_ext_attr_entry *) start,
 					storage_size, block_buf);
-		if (err)
-			goto out3;
-
-		ext2fs_free_mem(&block_buf);
 	}
 
-	ext2fs_free_mem(&block_buf);
-	ext2fs_free_mem(&inode);
-	return 0;
-
 out3:
-	ext2fs_free_mem(&block_buf);
+	if (block_buf)
+		ext2fs_free_mem(&block_buf);
+out:
+	return err;
+}
+
+errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle)
+{
+	struct ext2_inode_large *inode;
+	size_t inode_size = EXT2_INODE_SIZE(handle->fs->super);
+	errcode_t err;
+
+	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
+
+	if (inode_size < sizeof(*inode))
+		inode_size = sizeof(*inode);
+	err = ext2fs_get_memzero(inode_size, &inode);
+	if (err)
+		return err;
+
+	err = ext2fs_read_inode_full(handle->fs, handle->ino, EXT2_INODE(inode),
+				     EXT2_INODE_SIZE(handle->fs->super));
+	if (err)
+		goto out;
+
+	err = ext2fs_xattrs_read_inode(handle, inode);
+
 out:
 	ext2fs_free_mem(&inode);
+
 	return err;
 }
 
-- 
2.25.1

