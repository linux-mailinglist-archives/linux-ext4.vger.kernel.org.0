Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE445D8B6
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCA1h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32965 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbfGCA1g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62LTWEr020351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:29:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3FDB742002D; Tue,  2 Jul 2019 17:29:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] ext4: refactor initialize_dirent_tail()
Date:   Tue,  2 Jul 2019 17:29:24 -0400
Message-Id: <20190702212925.29989-2-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702212925.29989-1-tytso@mit.edu>
References: <20190702212925.29989-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move the calculation of the location of the dirent tail into
initialize_dirent_tail().  Also prefix the function with ext4_ to fix
kernel namepsace polution.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  4 ++--
 fs/ext4/inline.c |  9 +++-----
 fs/ext4/namei.c  | 54 +++++++++++++++++++-----------------------------
 3 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5b86df7ec326..83128bdd7abb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3147,8 +3147,8 @@ extern struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 				 struct ext4_dir_entry_2 *de,
 				 int blocksize, int csum_size,
 				 unsigned int parent_ino, int dotdot_real_len);
-extern void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
-				   unsigned int blocksize);
+extern void ext4_initialize_dirent_tail(struct buffer_head *bh,
+					unsigned int blocksize);
 extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 				      struct buffer_head *bh);
 extern int ext4_ci_compare(const struct inode *parent,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f19dd5a08d0d..796137bb7dfa 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1132,7 +1132,6 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 {
 	int err, csum_size = 0, header_size = 0;
 	struct ext4_dir_entry_2 *de;
-	struct ext4_dir_entry_tail *t;
 	void *target = dir_block->b_data;
 
 	/*
@@ -1158,11 +1157,9 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 			inline_size - EXT4_INLINE_DOTDOT_SIZE + header_size,
 			inode->i_sb->s_blocksize - csum_size);
 
-	if (csum_size) {
-		t = EXT4_DIRENT_TAIL(dir_block->b_data,
-				     inode->i_sb->s_blocksize);
-		initialize_dirent_tail(t, inode->i_sb->s_blocksize);
-	}
+	if (csum_size)
+		ext4_initialize_dirent_tail(dir_block,
+					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4f0bcbbcfe96..183ad614ae3d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -293,9 +293,11 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
 /* checksumming functions */
-void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
-			    unsigned int blocksize)
+void ext4_initialize_dirent_tail(struct buffer_head *bh,
+				 unsigned int blocksize)
 {
+	struct ext4_dir_entry_tail *t = EXT4_DIRENT_TAIL(bh->b_data, blocksize);
+
 	memset(t, 0, sizeof(struct ext4_dir_entry_tail));
 	t->det_rec_len = ext4_rec_len_to_disk(
 			sizeof(struct ext4_dir_entry_tail), blocksize);
@@ -370,7 +372,7 @@ int ext4_dirblock_csum_verify(struct inode *inode, struct buffer_head *bh)
 	}
 
 	if (t->det_checksum != ext4_dirblock_csum(inode, bh->b_data,
-						(char *)t - bh->b_data))
+						  (char *)t - bh->b_data))
 		return 0;
 
 	return 1;
@@ -391,7 +393,7 @@ static void ext4_dirblock_csum_set(struct inode *inode,
 	}
 
 	t->det_checksum = ext4_dirblock_csum(inode, bh->b_data,
-					   (char *)t - bh->b_data);
+					     (char *)t - bh->b_data);
 }
 
 int ext4_handle_dirty_dirblock(handle_t *handle,
@@ -1813,7 +1815,6 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	char *data1 = (*bh)->b_data, *data2;
 	unsigned split, move, size;
 	struct ext4_dir_entry_2 *de = NULL, *de2;
-	struct ext4_dir_entry_tail *t;
 	int	csum_size = 0;
 	int	err = 0, i;
 
@@ -1874,11 +1875,8 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 					    (char *) de2,
 					    blocksize);
 	if (csum_size) {
-		t = EXT4_DIRENT_TAIL(data2, blocksize);
-		initialize_dirent_tail(t, blocksize);
-
-		t = EXT4_DIRENT_TAIL(data1, blocksize);
-		initialize_dirent_tail(t, blocksize);
+		ext4_initialize_dirent_tail(*bh, blocksize);
+		ext4_initialize_dirent_tail(bh2, blocksize);
 	}
 
 	dxtrace(dx_show_leaf(dir, hinfo, (struct ext4_dir_entry_2 *) data1,
@@ -2039,8 +2037,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	struct dx_frame	frames[EXT4_HTREE_LEVEL], *frame;
 	struct dx_entry *entries;
 	struct ext4_dir_entry_2	*de, *de2;
-	struct ext4_dir_entry_tail *t;
-	char		*data1, *top;
+	char		*data2, *top;
 	unsigned	len;
 	int		retval;
 	unsigned	blocksize;
@@ -2080,21 +2077,18 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 		return PTR_ERR(bh2);
 	}
 	ext4_set_inode_flag(dir, EXT4_INODE_INDEX);
-	data1 = bh2->b_data;
+	data2 = bh2->b_data;
 
-	memcpy (data1, de, len);
-	de = (struct ext4_dir_entry_2 *) data1;
-	top = data1 + len;
+	memcpy(data2, de, len);
+	de = (struct ext4_dir_entry_2 *) data2;
+	top = data2 + len;
 	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top)
 		de = de2;
-	de->rec_len = ext4_rec_len_to_disk(data1 + (blocksize - csum_size) -
-					   (char *) de,
-					   blocksize);
+	de->rec_len = ext4_rec_len_to_disk(data2 + (blocksize - csum_size) -
+					   (char *) de, blocksize);
 
-	if (csum_size) {
-		t = EXT4_DIRENT_TAIL(data1, blocksize);
-		initialize_dirent_tail(t, blocksize);
-	}
+	if (csum_size)
+		ext4_initialize_dirent_tail(bh2, blocksize);
 
 	/* Initialize the root; the dot dirents already exist */
 	de = (struct ext4_dir_entry_2 *) (&root->dotdot);
@@ -2164,7 +2158,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	struct inode *dir = d_inode(dentry->d_parent);
 	struct buffer_head *bh = NULL;
 	struct ext4_dir_entry_2 *de;
-	struct ext4_dir_entry_tail *t;
 	struct super_block *sb;
 	struct ext4_sb_info *sbi;
 	struct ext4_filename fname;
@@ -2249,10 +2242,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	de->inode = 0;
 	de->rec_len = ext4_rec_len_to_disk(blocksize - csum_size, blocksize);
 
-	if (csum_size) {
-		t = EXT4_DIRENT_TAIL(bh->b_data, blocksize);
-		initialize_dirent_tail(t, blocksize);
-	}
+	if (csum_size)
+		ext4_initialize_dirent_tail(bh, blocksize);
 
 	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, bh);
 out:
@@ -2712,7 +2703,6 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 {
 	struct buffer_head *dir_block = NULL;
 	struct ext4_dir_entry_2 *de;
-	struct ext4_dir_entry_tail *t;
 	ext4_lblk_t block = 0;
 	unsigned int blocksize = dir->i_sb->s_blocksize;
 	int csum_size = 0;
@@ -2736,10 +2726,8 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
 	ext4_init_dot_dotdot(inode, de, blocksize, csum_size, dir->i_ino, 0);
 	set_nlink(inode, 2);
-	if (csum_size) {
-		t = EXT4_DIRENT_TAIL(dir_block->b_data, blocksize);
-		initialize_dirent_tail(t, blocksize);
-	}
+	if (csum_size)
+		ext4_initialize_dirent_tail(dir_block, blocksize);
 
 	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
-- 
2.22.0

