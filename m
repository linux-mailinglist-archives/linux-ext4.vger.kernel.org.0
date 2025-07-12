Return-Path: <linux-ext4+bounces-8962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C3B02C52
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0651749F6
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0E28A1F5;
	Sat, 12 Jul 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UMu8qozB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F51442E8
	for <linux-ext4@vger.kernel.org>; Sat, 12 Jul 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343997; cv=none; b=rmTelN1x7B74Kwe6XqM/jMBpqql4V2NstAnbWLoFMzBhxvbg7dnrP0pu8cQ6sQYyuNWEWS9dYTkNV9i6rVCDx4MefcUpLhy+dlLwryyJ/5AnqQzuRR5UH+3/7xjnmYhn7YTWxDS3W205ctB9VPcJ/AAUOgH/TDvxzmxmBJEd8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343997; c=relaxed/simple;
	bh=Ml31Uyh+G9/39veowJbCqEz9OoGZmLwMbw5rqkbqmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyd1qs5QNd9hs/Ul8CKLk6GQOtjgA9CDR/22FD9AZmtqkbTaybNYnwyodZEKnXczdCW8kHg3xlu9v/lEeA6JpqKq0IKKtzhwqHIoRVI0xi3ssXv7CX6T7dc/7D/vTsz+InWM7psts72gLDn0sGxvqpY5JZgJDUKCUcTXUJXFNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UMu8qozB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56CICwMv029945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752343980; bh=ulUcR+R9dEHXuX1QUsyTk4alpYp2dtEhjq41yE8aySg=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=UMu8qozBS+WpPtOcnDv4OIFTdMgpW6S0FGjLGUEeR4hQlLLazeNfXvXaQX2Kg0UT5
	 vl8nQSzqorlg0t3pzetA5Byfle5kfPUS2KUgEClmaSg7XCNNVbB0nziu0CUsnzJx12
	 V0vahxtOzxJbFqvIxR0lFfwKD35nzGkC9lyXha6ZQ51BI55OwGkXpg5e/fT/BHGh/m
	 CszOJw6MEHfQUn4K0E0n6Zu/e38uwI/6m863t7kHx2pscBJenAnLWN0xUOmlFegdoG
	 kmLOCHjgiPjM167QfLwnaXprwRQNhnRkl6TOVNXGUHX1rCVTrzJY1f3pG77QhqNKg2
	 GpXHH0KCLbpvQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C74B52E00D7; Sat, 12 Jul 2025 14:12:58 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: linux-hardening@vger.kernel.org, ethan@ethancedwards.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] ext4: refactor the inline directory conversion and new directory codepaths
Date: Sat, 12 Jul 2025 14:12:49 -0400
Message-ID: <20250712181249.434530-3-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250712181249.434530-1-tytso@mit.edu>
References: <20250712181249.434530-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a lot of common code in the codepaths used to convert an
inline directory and to creaet a new directory.  To address this,
rename ext4_init_dot_dotdot() to ext4_init_dirblock() and then move
common code into that function.

This reduces the lines of code count in fs/ext4/inline.c and
fs/ext4/namei.c, as well as reducing the size of their object files.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  9 ++++----
 fs/ext4/inline.c | 60 ++++++++++--------------------------------------
 fs/ext4/namei.c  | 56 ++++++++++++++++++++++++--------------------
 3 files changed, 48 insertions(+), 77 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..4d1d3eff2418 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3612,6 +3612,7 @@ extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
 extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
+extern void ext4_update_final_de(void *de_buf, int old_size, int new_size);
 
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
@@ -3671,10 +3672,10 @@ static inline int ext4_has_inline_data(struct inode *inode)
 extern const struct inode_operations ext4_dir_inode_operations;
 extern const struct inode_operations ext4_special_inode_operations;
 extern struct dentry *ext4_get_parent(struct dentry *child);
-extern struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
-				 struct ext4_dir_entry_2 *de,
-				 int blocksize, int csum_size,
-				 unsigned int parent_ino, int dotdot_real_len);
+extern int ext4_init_dirblock(handle_t *handle, struct inode *inode,
+			      struct buffer_head *dir_block,
+			      unsigned int parent_ino, void *inline_buf,
+			      int inline_size);
 extern void ext4_initialize_dirent_tail(struct buffer_head *bh,
 					unsigned int blocksize);
 extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index eeee007251e0..4ad3255e45cb 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -995,7 +995,7 @@ static void *ext4_get_inline_xattr_pos(struct inode *inode,
 }
 
 /* Set the final de to cover the whole block. */
-static void ext4_update_final_de(void *de_buf, int old_size, int new_size)
+void ext4_update_final_de(void *de_buf, int old_size, int new_size)
 {
 	struct ext4_dir_entry_2 *de, *prev_de;
 	void *limit;
@@ -1059,51 +1059,6 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 }
 
-static int ext4_finish_convert_inline_dir(handle_t *handle,
-					  struct inode *inode,
-					  struct buffer_head *dir_block,
-					  void *buf,
-					  int inline_size)
-{
-	int err, csum_size = 0, header_size = 0;
-	struct ext4_dir_entry_2 *de;
-	void *target = dir_block->b_data;
-
-	/*
-	 * First create "." and ".." and then copy the dir information
-	 * back to the block.
-	 */
-	de = target;
-	de = ext4_init_dot_dotdot(inode, de,
-		inode->i_sb->s_blocksize, csum_size,
-		le32_to_cpu(((struct ext4_dir_entry_2 *)buf)->inode), 1);
-	header_size = (void *)de - target;
-
-	memcpy((void *)de, buf + EXT4_INLINE_DOTDOT_SIZE,
-		inline_size - EXT4_INLINE_DOTDOT_SIZE);
-
-	if (ext4_has_feature_metadata_csum(inode->i_sb))
-		csum_size = sizeof(struct ext4_dir_entry_tail);
-
-	inode->i_size = inode->i_sb->s_blocksize;
-	i_size_write(inode, inode->i_sb->s_blocksize);
-	EXT4_I(inode)->i_disksize = inode->i_sb->s_blocksize;
-	ext4_update_final_de(dir_block->b_data,
-			inline_size - EXT4_INLINE_DOTDOT_SIZE + header_size,
-			inode->i_sb->s_blocksize - csum_size);
-
-	if (csum_size)
-		ext4_initialize_dirent_tail(dir_block,
-					    inode->i_sb->s_blocksize);
-	set_buffer_uptodate(dir_block);
-	unlock_buffer(dir_block);
-	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
-	if (err)
-		return err;
-	set_buffer_verified(dir_block);
-	return ext4_mark_inode_dirty(handle, inode);
-}
-
 static int ext4_convert_inline_data_nolock(handle_t *handle,
 					   struct inode *inode,
 					   struct ext4_iloc *iloc)
@@ -1175,8 +1130,17 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
-		error = ext4_finish_convert_inline_dir(handle, inode, data_bh,
-						       buf, inline_size);
+		unlock_buffer(data_bh);
+		inode->i_size = inode->i_sb->s_blocksize;
+		i_size_write(inode, inode->i_sb->s_blocksize);
+		EXT4_I(inode)->i_disksize = inode->i_sb->s_blocksize;
+
+		error = ext4_init_dirblock(handle, inode, data_bh,
+			  le32_to_cpu(((struct ext4_dir_entry_2 *)buf)->inode),
+			  buf + EXT4_INLINE_DOTDOT_SIZE,
+			  inline_size - EXT4_INLINE_DOTDOT_SIZE);
+		if (!error)
+			error = ext4_mark_inode_dirty(handle, inode);
 	}
 
 out_restore:
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9913a94b6a6d..d83f91b62317 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2915,11 +2915,17 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
-			  struct ext4_dir_entry_2 *de,
-			  int blocksize, int csum_size,
-			  unsigned int parent_ino, int dotdot_real_len)
+int ext4_init_dirblock(handle_t *handle, struct inode *inode,
+		       struct buffer_head *bh, unsigned int parent_ino,
+		       void *inline_buf, int inline_size)
 {
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *) bh->b_data;
+	size_t			blocksize = bh->b_size;
+	int			csum_size = 0, header_size;
+
+	if (ext4_has_feature_metadata_csum(inode->i_sb))
+		csum_size = sizeof(struct ext4_dir_entry_tail);
+
 	de->inode = cpu_to_le32(inode->i_ino);
 	de->name_len = 1;
 	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
@@ -2930,18 +2936,29 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de = ext4_next_entry(de, blocksize);
 	de->inode = cpu_to_le32(parent_ino);
 	de->name_len = 2;
-	if (!dotdot_real_len)
-		de->rec_len = ext4_rec_len_to_disk(blocksize -
-					(csum_size + ext4_dir_rec_len(1, NULL)),
-					blocksize);
-	else
+	memcpy(de->name, "..", 3);
+	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
+	if (inline_buf) {
 		de->rec_len = ext4_rec_len_to_disk(
 					ext4_dir_rec_len(de->name_len, NULL),
 					blocksize);
-	memcpy(de->name, "..", 3);
-	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
+		de = ext4_next_entry(de, blocksize);
+		header_size = (char *)de - bh->b_data;
+		memcpy((void *)de, inline_buf, inline_size);
+		ext4_update_final_de(bh->b_data, inline_size + header_size,
+			blocksize - csum_size);
+	} else {
+		de->rec_len = ext4_rec_len_to_disk(blocksize -
+					(csum_size + ext4_dir_rec_len(1, NULL)),
+					blocksize);
+	}
 
-	return ext4_next_entry(de, blocksize);
+	if (csum_size)
+		ext4_initialize_dirent_tail(bh, blocksize);
+	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
+	set_buffer_uptodate(bh);
+	set_buffer_verified(bh);
+	return ext4_handle_dirty_dirblock(handle, inode, bh);
 }
 
 int ext4_init_new_dir(handle_t *handle, struct inode *dir,
@@ -2950,13 +2967,8 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	struct buffer_head *dir_block = NULL;
 	struct ext4_dir_entry_2 *de;
 	ext4_lblk_t block = 0;
-	unsigned int blocksize = dir->i_sb->s_blocksize;
-	int csum_size = 0;
 	int err;
 
-	if (ext4_has_feature_metadata_csum(dir->i_sb))
-		csum_size = sizeof(struct ext4_dir_entry_tail);
-
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		err = ext4_try_create_inline_dir(handle, dir, inode);
 		if (err < 0 && err != -ENOSPC)
@@ -2965,21 +2977,15 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 			goto out;
 	}
 
+	set_nlink(inode, 2);
 	inode->i_size = 0;
 	dir_block = ext4_append(handle, inode, &block);
 	if (IS_ERR(dir_block))
 		return PTR_ERR(dir_block);
 	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
-	ext4_init_dot_dotdot(inode, de, blocksize, csum_size, dir->i_ino, 0);
-	set_nlink(inode, 2);
-	if (csum_size)
-		ext4_initialize_dirent_tail(dir_block, blocksize);
-
-	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
-	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
+	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
 	if (err)
 		goto out;
-	set_buffer_verified(dir_block);
 out:
 	brelse(dir_block);
 	return err;
-- 
2.47.2


