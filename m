Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613FB5D8B7
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGCA1k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfGCA1h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:37 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62LTWZr020347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:29:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3CC4142002E; Tue,  2 Jul 2019 17:29:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] ext4: rename "dirent_csum" functions to use "dirblock"
Date:   Tue,  2 Jul 2019 17:29:23 -0400
Message-Id: <20190702212925.29989-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Functions such as ext4_dirent_csum_verify() and ext4_dirent_csum_set()
don't actually operate on a directory entry, but a directory block.
And while they take a struct ext4_dir_entry *dirent as an argument, it
had better be the first directory at the beginning of the direct
block, or things will go very wrong.

Rename the following functions so that things make more sense, and
remove a lot of confusing casts along the way:

   ext4_dirent_csum_verify	 -> ext4_dirblock_csum_verify
   ext4_dirent_csum_set		 -> ext4_dirblock_csum_set
   ext4_dirent_csum		 -> ext4_dirblock_csum
   ext4_handle_dirty_dirent_node -> ext4_handle_dirty_dirblock

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/dir.c    |  3 +--
 fs/ext4/ext4.h   |  9 ++++---
 fs/ext4/inline.c |  2 +-
 fs/ext4/namei.c  | 62 ++++++++++++++++++++++--------------------------
 4 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3a77b7affd09..86054f31fe4d 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -194,8 +194,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 
 		/* Check the checksum */
 		if (!buffer_verified(bh) &&
-		    !ext4_dirent_csum_verify(inode,
-				(struct ext4_dir_entry *)bh->b_data)) {
+		    !ext4_dirblock_csum_verify(inode, bh)) {
 			EXT4_ERROR_FILE(file, 0, "directory fails checksum "
 					"at offset %llu",
 					(unsigned long long)ctx->pos);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7215a2a2a0de..5b86df7ec326 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2602,8 +2602,8 @@ extern int ext4_ext_migrate(struct inode *);
 extern int ext4_ind_migrate(struct inode *inode);
 
 /* namei.c */
-extern int ext4_dirent_csum_verify(struct inode *inode,
-				   struct ext4_dir_entry *dirent);
+extern int ext4_dirblock_csum_verify(struct inode *inode,
+				     struct buffer_head *bh);
 extern int ext4_orphan_add(handle_t *, struct inode *);
 extern int ext4_orphan_del(handle_t *, struct inode *);
 extern int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
@@ -3149,9 +3149,8 @@ extern struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 				 unsigned int parent_ino, int dotdot_real_len);
 extern void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
 				   unsigned int blocksize);
-extern int ext4_handle_dirty_dirent_node(handle_t *handle,
-					 struct inode *inode,
-					 struct buffer_head *bh);
+extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
+				      struct buffer_head *bh);
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
 			   const struct qstr *entry, bool quick);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f73bc3925282..f19dd5a08d0d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1164,7 +1164,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		initialize_dirent_tail(t, inode->i_sb->s_blocksize);
 	}
 	set_buffer_uptodate(dir_block);
-	err = ext4_handle_dirty_dirent_node(handle, inode, dir_block);
+	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
 	set_buffer_verified(dir_block);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0cda080f3fd5..4f0bcbbcfe96 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -163,7 +163,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		}
 	}
 	if (!is_dx_block) {
-		if (ext4_dirent_csum_verify(inode, dirent))
+		if (ext4_dirblock_csum_verify(inode, bh))
 			set_buffer_verified(bh);
 		else {
 			ext4_error_inode(inode, func, line, block,
@@ -304,17 +304,17 @@ void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
 
 /* Walk through a dirent block to find a checksum "dirent" at the tail */
 static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
-						   struct ext4_dir_entry *de)
+						   struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
 
-	d = de;
-	top = (struct ext4_dir_entry *)(((void *)de) +
+	d = (struct ext4_dir_entry *)bh->b_data;
+	top = (struct ext4_dir_entry *)(bh->b_data +
 		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		sizeof(struct ext4_dir_entry_tail)));
+		 sizeof(struct ext4_dir_entry_tail)));
 	while (d < top && d->rec_len)
 		d = (struct ext4_dir_entry *)(((void *)d) +
 		    le16_to_cpu(d->rec_len));
@@ -324,7 +324,7 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 
 	t = (struct ext4_dir_entry_tail *)d;
 #else
-	t = EXT4_DIRENT_TAIL(de, EXT4_BLOCK_SIZE(inode->i_sb));
+	t = EXT4_DIRENT_TAIL(bh->b_data, EXT4_BLOCK_SIZE(inode->i_sb));
 #endif
 
 	if (t->det_reserved_zero1 ||
@@ -336,8 +336,7 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 	return t;
 }
 
-static __le32 ext4_dirent_csum(struct inode *inode,
-			       struct ext4_dir_entry *dirent, int size)
+static __le32 ext4_dirblock_csum(struct inode *inode, void *dirent, int size)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -357,49 +356,49 @@ static void __warn_no_space_for_csum(struct inode *inode, const char *func,
 		"No space for directory leaf checksum. Please run e2fsck -D.");
 }
 
-int ext4_dirent_csum_verify(struct inode *inode, struct ext4_dir_entry *dirent)
+int ext4_dirblock_csum_verify(struct inode *inode, struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
 
 	if (!ext4_has_metadata_csum(inode->i_sb))
 		return 1;
 
-	t = get_dirent_tail(inode, dirent);
+	t = get_dirent_tail(inode, bh);
 	if (!t) {
 		warn_no_space_for_csum(inode);
 		return 0;
 	}
 
-	if (t->det_checksum != ext4_dirent_csum(inode, dirent,
-						(void *)t - (void *)dirent))
+	if (t->det_checksum != ext4_dirblock_csum(inode, bh->b_data,
+						(char *)t - bh->b_data))
 		return 0;
 
 	return 1;
 }
 
-static void ext4_dirent_csum_set(struct inode *inode,
-				 struct ext4_dir_entry *dirent)
+static void ext4_dirblock_csum_set(struct inode *inode,
+				 struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
 
 	if (!ext4_has_metadata_csum(inode->i_sb))
 		return;
 
-	t = get_dirent_tail(inode, dirent);
+	t = get_dirent_tail(inode, bh);
 	if (!t) {
 		warn_no_space_for_csum(inode);
 		return;
 	}
 
-	t->det_checksum = ext4_dirent_csum(inode, dirent,
-					   (void *)t - (void *)dirent);
+	t->det_checksum = ext4_dirblock_csum(inode, bh->b_data,
+					   (char *)t - bh->b_data);
 }
 
-int ext4_handle_dirty_dirent_node(handle_t *handle,
-				  struct inode *inode,
-				  struct buffer_head *bh)
+int ext4_handle_dirty_dirblock(handle_t *handle,
+			       struct inode *inode,
+			       struct buffer_head *bh)
 {
-	ext4_dirent_csum_set(inode, (struct ext4_dir_entry *)bh->b_data);
+	ext4_dirblock_csum_set(inode, bh);
 	return ext4_handle_dirty_metadata(handle, inode, bh);
 }
 
@@ -1530,8 +1529,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		if (!buffer_verified(bh) &&
 		    !is_dx_internal_node(dir, block,
 					 (struct ext4_dir_entry *)bh->b_data) &&
-		    !ext4_dirent_csum_verify(dir,
-				(struct ext4_dir_entry *)bh->b_data)) {
+		    !ext4_dirblock_csum_verify(dir, bh)) {
 			EXT4_ERROR_INODE(dir, "checksumming directory "
 					 "block %lu", (unsigned long)block);
 			brelse(bh);
@@ -1894,7 +1892,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		de = de2;
 	}
 	dx_insert_block(frame, hash2 + continued, newblock);
-	err = ext4_handle_dirty_dirent_node(handle, dir, bh2);
+	err = ext4_handle_dirty_dirblock(handle, dir, bh2);
 	if (err)
 		goto journal_error;
 	err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
@@ -2022,7 +2020,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	inode_inc_iversion(dir);
 	ext4_mark_inode_dirty(handle, dir);
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
-	err = ext4_handle_dirty_dirent_node(handle, dir, bh);
+	err = ext4_handle_dirty_dirblock(handle, dir, bh);
 	if (err)
 		ext4_std_error(dir->i_sb, err);
 	return 0;
@@ -2126,7 +2124,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	retval = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
 	if (retval)
 		goto out_frames;	
-	retval = ext4_handle_dirty_dirent_node(handle, dir, bh2);
+	retval = ext4_handle_dirty_dirblock(handle, dir, bh2);
 	if (retval)
 		goto out_frames;	
 
@@ -2512,7 +2510,7 @@ static int ext4_delete_entry(handle_t *handle,
 		goto out;
 
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
-	err = ext4_handle_dirty_dirent_node(handle, dir, bh);
+	err = ext4_handle_dirty_dirblock(handle, dir, bh);
 	if (unlikely(err))
 		goto out;
 
@@ -2744,7 +2742,7 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	}
 
 	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
-	err = ext4_handle_dirty_dirent_node(handle, inode, dir_block);
+	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		goto out;
 	set_buffer_verified(dir_block);
@@ -3492,9 +3490,8 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
 							   ent->inode,
 							   ent->dir_bh);
 		} else {
-			retval = ext4_handle_dirty_dirent_node(handle,
-							       ent->inode,
-							       ent->dir_bh);
+			retval = ext4_handle_dirty_dirblock(handle, ent->inode,
+							    ent->dir_bh);
 		}
 	} else {
 		retval = ext4_mark_inode_dirty(handle, ent->inode);
@@ -3524,8 +3521,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	ext4_mark_inode_dirty(handle, ent->dir);
 	BUFFER_TRACE(ent->bh, "call ext4_handle_dirty_metadata");
 	if (!ent->inlined) {
-		retval = ext4_handle_dirty_dirent_node(handle,
-						       ent->dir, ent->bh);
+		retval = ext4_handle_dirty_dirblock(handle, ent->dir, ent->bh);
 		if (unlikely(retval)) {
 			ext4_std_error(ent->dir->i_sb, retval);
 			return retval;
-- 
2.22.0

