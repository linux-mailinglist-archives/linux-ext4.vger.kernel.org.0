Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1008ABE8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 02:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHMAVs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 20:21:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33918 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHMAVs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 20:21:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so28282pfp.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2019 17:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FDShCFn3kcOVP6IJUamKuL5nhgvNJaI00Bq8+7CwD8=;
        b=M6xj1FvP2iR3CekUi9PYa8hDn13SDursnitPxBZdUa1uOn8POGyBw6vc7QH6iQo23y
         Cg0u1NQV6m5XYBO84LuWQPKLiiMCh7uKWofcPN1ggs+LaOuLNjOTHb0UHVeC5YPSoJW9
         393AlzZ0wcBQRaTLJLXlQt0CmafdZ0+J3bIMEHQOLZfFkk4/PXaLMsZe2H8edCu7Tmq6
         NuN63zWRBmRAZLVFh/MhK9xf/TB+acIyttrA8me9c5baAW/k5tzBJwAf58dhiCMxnR1p
         +a8PsGQsvS9//zCXvyCl0S2RYTX6gxQGt5m3MiBe8uaYPoI5COt5XFBJsywAYL8babmR
         cLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FDShCFn3kcOVP6IJUamKuL5nhgvNJaI00Bq8+7CwD8=;
        b=V+NwQPCfBHwpMqVfzIqdPV0wpcdNokeg1FTwPZh9MJyM+DrcJdayZM6bWKRPT5Kmft
         cKAHD3nhnNkW/URzv8Up3v9h6QjJKg3eBPdFdMg66BZ8ptxvxRr1h0j8NqKLPOtLfD1+
         YP8rfR1vLcuJaICfv+J1n4ctkiyOwgn4IuFsWXBE5HiZD7DFvS+rlsH5CKFe3Ph7WPnW
         hzr5XrVrHf2+LP/Izui8XdZrqL4ODuYnDiRxnPx888VUzEelAo3Up6Ip8558Yb8OsKKF
         miArj93KYV3qVhLtFxMDWrGjLBDGJipceR0QVtHVmVuew7acwZb2QU0iJBtMDSx3+gpD
         R31g==
X-Gm-Message-State: APjAAAVhwmP4rX07JTGxjIkjuP4JLBO0Mqtbvq8Kp5N931o9BPOzn2WB
        UrsLU7go4QnF6tT42qkUwNE37fig
X-Google-Smtp-Source: APXvYqx7EZIo885VXKdSaCCy/SElHwGUKwrNV30q6qp/0zqEuqmWHgRbyhCE2GNm+RWuyGIaR7FTOQ==
X-Received: by 2002:a62:584:: with SMTP id 126mr38353397pff.73.1565655706834;
        Mon, 12 Aug 2019 17:21:46 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id b24sm34761709pgw.66.2019.08.12.17.21.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 17:21:46 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4] ext4: shrink directory when last block is empty
Date:   Mon, 12 Aug 2019 17:21:26 -0700
Message-Id: <20190813002126.23326-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch is the first step towards shrinking htree based directories
when files are deleted. We truncate directory inode when a directory
entry removal causes last directory block to be empty. In order to be
backwards compatible, we don't remove empty last directory block if it
results in one of the intermediate htree nodes to be empty.

This optimization by itself doesn't shrink directory that much. That's
because in order for this optimization to be effective, the order of
deletion of dirents matters. If dirents are deleted in such a way that
the directory inode blocks become empty in the reverse logical offset
order, then this optimization shrinks directory inode to a large
extent. However, if that order is not followed, this optimization
hardly shrinks the inode. But, with this code in place, we could add
quick optimizations allowing us to make this much more effective.

Ran kvm-xfstests smoke test-suite and verified that there are no
failures. Also, verified that when all the files are deleted in a
directory, directory shrinks by 1 block at least for both non-indexed
and indexed directories.

Changes since v3:
- Cleaned up some code based on Ted's comments on V3.
- Added handling for non-indexed dirs as well.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/namei.c | 161 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129029534075..e3c13ddbdec9 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -258,6 +258,13 @@ struct dx_tail {
 	__le32 dt_checksum;	/* crc32c(uuid+inum+dirblock) */
 };
 
+struct ext4_dirent_blk_ctx {
+	/* Lblk of the dirent block where this entry was found */
+	ext4_lblk_t dir_lblk;
+	/* Corresponding dx_frame. Valid only for dx dirs */
+	struct dx_frame dx_frame;
+};
+
 static inline ext4_lblk_t dx_get_block(struct dx_entry *entry);
 static void dx_set_block(struct dx_entry *entry, ext4_lblk_t value);
 static inline unsigned dx_get_hash(struct dx_entry *entry);
@@ -288,7 +295,8 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 				 __u32 *start_hash);
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
-		struct ext4_dir_entry_2 **res_dir);
+		struct ext4_dir_entry_2 **res_dir,
+		struct ext4_dirent_blk_ctx *dctx);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
@@ -882,6 +890,52 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	return ret_err;
 }
 
+/*
+ * This function tries to remove the entry of a dirent block (which was just
+ * emptied by the caller) from the dx frame. It does so by reducing the count by
+ * 1 and left shifting all the entries after the deleted entry.
+ */
+static bool
+ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
+		     struct dx_frame *dx_frame)
+{
+	struct dx_entry *entries;
+	unsigned int count;
+	int err, i;
+
+	entries = dx_frame->entries;
+	count = dx_get_count(entries);
+
+	if (count == 1)
+		return false;
+
+	for (i = 0; i < count; i++)
+		if (entries[i].block == cpu_to_le64(dx_get_block(dx_frame->at)))
+			break;
+
+	if (i >= count)
+		return false;
+
+	err = ext4_journal_get_write_access(handle, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return false;
+	}
+
+	for (; i < count - 1; i++)
+		entries[i] = entries[i + 1];
+
+	dx_set_count(entries, count - 1);
+
+	err = ext4_handle_dirty_dx_node(handle, dir, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return false;
+	}
+
+	return true;
+}
+
 static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
@@ -1409,6 +1463,19 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 	return 0;
 }
 
+static inline bool is_empty_dirent_block(struct inode *dir,
+					 struct buffer_head *bh)
+{
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
+	int	csum_size = 0;
+
+	if (ext4_has_metadata_csum(dir->i_sb))
+		csum_size = sizeof(struct ext4_dir_entry_tail);
+
+	return ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize) ==
+			dir->i_sb->s_blocksize - csum_size && de->inode == 0;
+}
+
 static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 			       struct ext4_dir_entry *de)
 {
@@ -1435,11 +1502,16 @@ static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
  *
  * The returned buffer_head has ->b_count elevated.  The caller is expected
  * to brelse() it when appropriate.
+ *
+ * If dctx is passed, __ext4_find_entry stores search context for this dentry in
+ * dctx. dctx is useful if caller wants to delete dentry and potentially
+ * truncate the directory.
  */
 static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     struct ext4_filename *fname,
 					     struct ext4_dir_entry_2 **res_dir,
-					     int *inlined)
+					     int *inlined,
+					     struct ext4_dirent_blk_ctx *dctx)
 {
 	struct super_block *sb;
 	struct buffer_head *bh_use[NAMEI_RA_SIZE];
@@ -1481,7 +1553,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		goto restart;
 	}
 	if (is_dx(dir)) {
-		ret = ext4_dx_find_entry(dir, fname, res_dir);
+		ret = ext4_dx_find_entry(dir, fname, res_dir, dctx);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -1547,6 +1619,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		i = search_dirblock(bh, dir, fname,
 			    block << EXT4_BLOCK_SIZE_BITS(sb), res_dir);
 		if (i == 1) {
+			if (dctx)
+				dctx->dir_lblk = block;
 			EXT4_I(dir)->i_dir_start_lookup = block;
 			ret = bh;
 			goto cleanup_and_exit;
@@ -1581,7 +1655,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 static struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
-					   int *inlined)
+					   int *inlined,
+					   struct ext4_dirent_blk_ctx *dctx)
 {
 	int err;
 	struct ext4_filename fname;
@@ -1593,7 +1668,7 @@ static struct buffer_head *ext4_find_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, inlined);
+	bh = __ext4_find_entry(dir, &fname, res_dir, inlined, dctx);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1613,15 +1688,16 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, NULL);
+	bh = __ext4_find_entry(dir, &fname, res_dir, NULL, NULL);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
 }
 
-static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
-			struct ext4_filename *fname,
-			struct ext4_dir_entry_2 **res_dir)
+static struct buffer_head *ext4_dx_find_entry(struct inode *dir,
+					      struct ext4_filename *fname,
+					      struct ext4_dir_entry_2 **res_dir,
+					      struct ext4_dirent_blk_ctx *dctx)
 {
 	struct super_block * sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
@@ -1644,8 +1720,14 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		retval = search_dirblock(bh, dir, fname,
 					 block << EXT4_BLOCK_SIZE_BITS(sb),
 					 res_dir);
-		if (retval == 1)
+		if (retval == 1) {
+			if (dctx) {
+				dctx->dx_frame = *frame;
+				dctx->dir_lblk = block;
+				get_bh(frame->bh);
+			}
 			goto success;
+		}
 		brelse(bh);
 		if (retval == -1) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
@@ -1736,7 +1818,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 	struct ext4_dir_entry_2 * de;
 	struct buffer_head *bh;
 
-	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL);
+	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL, NULL);
 	if (IS_ERR(bh))
 		return ERR_CAST(bh);
 	if (!bh)
@@ -2479,9 +2561,11 @@ int ext4_generic_delete_entry(handle_t *handle,
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
-			     struct buffer_head *bh)
+			     struct buffer_head *bh,
+			     struct ext4_dirent_blk_ctx *dctx)
 {
 	int err, csum_size = 0;
+	bool should_truncate = false;
 
 	if (ext4_has_inline_data(dir)) {
 		int has_inline_data = 1;
@@ -2505,11 +2589,32 @@ static int ext4_delete_entry(handle_t *handle,
 	if (err)
 		goto out;
 
+	if (dctx) {
+		/*
+		 * If after deletion of the dentry, the dirent block became
+		 * empty and if it was the last block in the directory, we
+		 * should truncate non-dx directories.
+		 */
+		if (is_empty_dirent_block(dir, bh) &&
+		    ((dir->i_size - 1) >> dir->i_sb->s_blocksize_bits) ==
+		    dctx->dir_lblk)
+			should_truncate = true;
+
+		if (should_truncate && is_dx(dir) && dctx->dx_frame.bh)
+			should_truncate = ext4_remove_dx_entry(handle, dir,
+							       &dctx->dx_frame);
+	}
+
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
 	err = ext4_handle_dirty_dirblock(handle, dir, bh);
 	if (unlikely(err))
 		goto out;
 
+	if (should_truncate) {
+		dir->i_size -= dir->i_sb->s_blocksize;
+		ext4_truncate(dir);
+	}
+
 	return 0;
 out:
 	if (err != -ENOENT)
@@ -3057,6 +3162,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	struct ext4_dirent_blk_ctx dctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3071,7 +3177,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	memset(&dctx, 0, sizeof(dctx));
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &dctx);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3098,7 +3205,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, bh, &dctx);
 	if (retval)
 		goto end_rmdir;
 	if (!EXT4_DIR_LINK_EMPTY(inode))
@@ -3144,6 +3251,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	struct ext4_dirent_blk_ctx dctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3159,7 +3267,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	memset(&dctx, 0, sizeof(dctx));
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &dctx);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3187,7 +3296,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 				   dentry->d_name.len, dentry->d_name.name);
 		set_nlink(inode, 1);
 	}
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, bh, &dctx);
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3212,6 +3321,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 
 end_unlink:
 	brelse(bh);
+	if (dctx.dx_frame.bh)
+		brelse(dctx.dx_frame.bh);
 	if (handle)
 		ext4_journal_stop(handle);
 	trace_ext4_unlink_exit(dentry, retval);
@@ -3532,12 +3643,14 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 	int retval = -ENOENT;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
+	struct ext4_dirent_blk_ctx dctx;
 
-	bh = ext4_find_entry(dir, d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL, &dctx);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (bh) {
-		retval = ext4_delete_entry(handle, dir, de, bh);
+		memset(&dctx, 0, sizeof(dctx));
+		retval = ext4_delete_entry(handle, dir, de, bh, &dctx);
 		brelse(bh);
 	}
 	return retval;
@@ -3561,7 +3674,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_find_delete_entry(handle, ent->dir,
 						&ent->dentry->d_name);
 	} else {
-		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
+		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh,
+					   NULL);
 		if (retval == -ENOENT) {
 			retval = ext4_find_delete_entry(handle, ent->dir,
 							&ent->dentry->d_name);
@@ -3674,7 +3788,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return retval;
 	}
 
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL,
+				 NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3688,7 +3803,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
@@ -3868,7 +3983,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return retval;
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
-				 &old.de, &old.inlined);
+				 &old.de, &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3882,7 +3997,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
-- 
2.23.0.rc1.153.gdeed80330f-goog

