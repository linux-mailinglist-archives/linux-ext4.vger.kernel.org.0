Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760F1196A90
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 04:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgC2CEO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 22:04:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbgC2CEO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 22:04:14 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02T246YN016881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Mar 2020 22:04:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3E156420EBA; Sat, 28 Mar 2020 22:04:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: save all error info in save_error_info() and drop ext4_set_errno()
Date:   Sat, 28 Mar 2020 22:04:04 -0400
Message-Id: <20200329020404.686965-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Using a separate function, ext4_set_errno() to set the errno is
problematic because it doesn't do the right thing once
s_last_error_errorcode is non-zero.  It's also less racy to set all of
the error information all at once.  (Also, as a bonus, it shrinks code
size slightly.)

Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c         |   7 +-
 fs/ext4/block_validity.c |  18 ++---
 fs/ext4/ext4.h           |  40 ++++++----
 fs/ext4/ext4_jbd2.c      |  13 +--
 fs/ext4/extents.c        |  27 +++----
 fs/ext4/ialloc.c         |  13 ++-
 fs/ext4/indirect.c       |   2 +-
 fs/ext4/inline.c         |  13 ++-
 fs/ext4/inode.c          |  29 +++----
 fs/ext4/mballoc.c        |  21 +++--
 fs/ext4/mmp.c            |  13 ++-
 fs/ext4/move_extent.c    |   4 +-
 fs/ext4/namei.c          |  24 +++---
 fs/ext4/super.c          | 166 ++++++++++++++++++---------------------
 fs/ext4/xattr.c          |  10 +--
 15 files changed, 187 insertions(+), 213 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8fd0b3cdab4c..0e0a4d6209c7 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -516,10 +516,9 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 	wait_on_buffer(bh);
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
-		ext4_set_errno(sb, EIO);
-		ext4_error(sb, "Cannot read block bitmap - "
-			   "block_group = %u, block_bitmap = %llu",
-			   block_group, (unsigned long long) bh->b_blocknr);
+		ext4_error_err(sb, EIO, "Cannot read block bitmap - "
+			       "block_group = %u, block_bitmap = %llu",
+			       block_group, (unsigned long long) bh->b_blocknr);
 		ext4_mark_group_bitmap_corrupted(sb, block_group,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EIO;
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 0a734ffb4310..16e9b2fda03a 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -166,10 +166,8 @@ static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
 
 	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
 	    (start_blk + count < start_blk) ||
-	    (start_blk + count > ext4_blocks_count(sbi->s_es))) {
-		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
+	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
 		return 0;
-	}
 
 	if (system_blks == NULL)
 		return 1;
@@ -181,10 +179,8 @@ static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
 			n = n->rb_left;
 		else if (start_blk >= (entry->start_blk + entry->count))
 			n = n->rb_right;
-		else {
-			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
+		else
 			return 0;
-		}
 	}
 	return 1;
 }
@@ -220,10 +216,12 @@ static int ext4_protect_reserved_inode(struct super_block *sb,
 		} else {
 			if (!ext4_data_block_valid_rcu(sbi, system_blks,
 						map.m_pblk, n)) {
-				ext4_error(sb, "blocks %llu-%llu from inode %u "
-					   "overlap system zone", map.m_pblk,
-					   map.m_pblk + map.m_len - 1, ino);
 				err = -EFSCORRUPTED;
+				__ext4_error(sb, __func__, __LINE__, -err,
+					     map.m_pblk, "blocks %llu-%llu "
+					     "from inode %u overlap system zone",
+					     map.m_pblk,
+					     map.m_pblk + map.m_len - 1, ino);
 				break;
 			}
 			err = add_system_zone(system_blks, map.m_pblk, n);
@@ -365,7 +363,6 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 int ext4_check_blockref(const char *function, unsigned int line,
 			struct inode *inode, __le32 *p, unsigned int max)
 {
-	struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
 	__le32 *bref = p;
 	unsigned int blk;
 
@@ -379,7 +376,6 @@ int ext4_check_blockref(const char *function, unsigned int line,
 		if (blk &&
 		    unlikely(!ext4_data_block_valid(EXT4_SB(inode->i_sb),
 						    blk, 1))) {
-			es->s_last_error_block = cpu_to_le64(blk);
 			ext4_error_inode(inode, function, line, blk,
 					 "invalid block");
 			return -EFSCORRUPTED;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 54f0a003053b..eacd2f9cc833 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2770,21 +2770,20 @@ extern const char *ext4_decode_error(struct super_block *sb, int errno,
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
-extern void ext4_set_errno(struct super_block *sb, int err);
 
-extern __printf(4, 5)
-void __ext4_error(struct super_block *, const char *, unsigned int,
+extern __printf(6, 7)
+void __ext4_error(struct super_block *, const char *, unsigned int, int, __u64,
 		  const char *, ...);
-extern __printf(5, 6)
-void __ext4_error_inode(struct inode *, const char *, unsigned int, ext4_fsblk_t,
-		      const char *, ...);
+extern __printf(6, 7)
+void __ext4_error_inode(struct inode *, const char *, unsigned int,
+			ext4_fsblk_t, int, const char *, ...);
 extern __printf(5, 6)
 void __ext4_error_file(struct file *, const char *, unsigned int, ext4_fsblk_t,
 		     const char *, ...);
 extern void __ext4_std_error(struct super_block *, const char *,
 			     unsigned int, int);
-extern __printf(4, 5)
-void __ext4_abort(struct super_block *, const char *, unsigned int,
+extern __printf(5, 6)
+void __ext4_abort(struct super_block *, const char *, unsigned int, int,
 		  const char *, ...);
 extern __printf(4, 5)
 void __ext4_warning(struct super_block *, const char *, unsigned int,
@@ -2805,8 +2804,12 @@ void __ext4_grp_locked_error(const char *, unsigned int,
 #define EXT4_ERROR_INODE(inode, fmt, a...) \
 	ext4_error_inode((inode), __func__, __LINE__, 0, (fmt), ## a)
 
-#define EXT4_ERROR_INODE_BLOCK(inode, block, fmt, a...)			\
-	ext4_error_inode((inode), __func__, __LINE__, (block), (fmt), ## a)
+#define EXT4_ERROR_INODE_ERR(inode, err, fmt, a...)			\
+	__ext4_error_inode((inode), __func__, __LINE__, 0, (err), (fmt), ## a)
+
+#define ext4_error_inode_block(inode, block, err, fmt, a...)		\
+	__ext4_error_inode((inode), __func__, __LINE__, (block), (err),	\
+			   (fmt), ## a)
 
 #define EXT4_ERROR_FILE(file, block, fmt, a...)				\
 	ext4_error_file((file), __func__, __LINE__, (block), (fmt), ## a)
@@ -2814,13 +2817,18 @@ void __ext4_grp_locked_error(const char *, unsigned int,
 #ifdef CONFIG_PRINTK
 
 #define ext4_error_inode(inode, func, line, block, fmt, ...)		\
-	__ext4_error_inode(inode, func, line, block, fmt, ##__VA_ARGS__)
+	__ext4_error_inode(inode, func, line, block, 0, fmt, ##__VA_ARGS__)
+#define ext4_error_inode_err(inode, func, line, block, err, fmt, ...)	\
+	__ext4_error_inode((inode), (func), (line), (block), 		\
+			   (err), (fmt), ##__VA_ARGS__)
 #define ext4_error_file(file, func, line, block, fmt, ...)		\
 	__ext4_error_file(file, func, line, block, fmt, ##__VA_ARGS__)
 #define ext4_error(sb, fmt, ...)					\
-	__ext4_error(sb, __func__, __LINE__, fmt, ##__VA_ARGS__)
-#define ext4_abort(sb, fmt, ...)					\
-	__ext4_abort(sb, __func__, __LINE__, fmt, ##__VA_ARGS__)
+	__ext4_error((sb), __func__, __LINE__, 0, 0, (fmt), ##__VA_ARGS__)
+#define ext4_error_err(sb, err, fmt, ...)				\
+	__ext4_error((sb), __func__, __LINE__, (err), 0, (fmt), ##__VA_ARGS__)
+#define ext4_abort(sb, err, fmt, ...)					\
+	__ext4_abort((sb), __func__, __LINE__, (err), (fmt), ##__VA_ARGS__)
 #define ext4_warning(sb, fmt, ...)					\
 	__ext4_warning(sb, __func__, __LINE__, fmt, ##__VA_ARGS__)
 #define ext4_warning_inode(inode, fmt, ...)				\
@@ -2838,7 +2846,7 @@ void __ext4_grp_locked_error(const char *, unsigned int,
 #define ext4_error_inode(inode, func, line, block, fmt, ...)		\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_error_inode(inode, "", 0, block, " ");			\
+	__ext4_error_inode(inode, "", 0, block, 0, " ");		\
 } while (0)
 #define ext4_error_file(file, func, line, block, fmt, ...)		\
 do {									\
@@ -2848,7 +2856,7 @@ do {									\
 #define ext4_error(sb, fmt, ...)					\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_error(sb, "", 0, " ");					\
+	__ext4_error(sb, "", 0, 0, 0, " ");				\
 } while (0)
 #define ext4_abort(sb, fmt, ...)					\
 do {									\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index ee3755c3110a..7f16e1af8d5c 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -80,8 +80,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 	 * take the FS itself readonly cleanly.
 	 */
 	if (journal && is_journal_aborted(journal)) {
-		ext4_set_errno(sb, -journal->j_errno);
-		ext4_abort(sb, "Detected aborted journal");
+		ext4_abort(sb, -journal->j_errno, "Detected aborted journal");
 		return -EROFS;
 	}
 	return 0;
@@ -272,8 +271,7 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	if (err) {
 		ext4_journal_abort_handle(where, line, __func__,
 					  bh, handle, err);
-		ext4_set_errno(inode->i_sb, -err);
-		__ext4_abort(inode->i_sb, where, line,
+		__ext4_abort(inode->i_sb, where, line, -err,
 			   "error %d when attempting revoke", err);
 	}
 	BUFFER_TRACE(bh, "exit");
@@ -343,11 +341,8 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				struct ext4_super_block *es;
 
 				es = EXT4_SB(inode->i_sb)->s_es;
-				es->s_last_error_block =
-					cpu_to_le64(bh->b_blocknr);
-				ext4_set_errno(inode->i_sb, EIO);
-				ext4_error_inode(inode, where, line,
-						 bh->b_blocknr,
+				ext4_error_inode_err(inode, where, line,
+						     bh->b_blocknr, EIO,
 					"IO error syncing itable block");
 				err = -EIO;
 			}
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e86bc611f07..031752cfb6f7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -349,8 +349,8 @@ static int ext4_valid_extent_idx(struct inode *inode,
 }
 
 static int ext4_valid_extent_entries(struct inode *inode,
-				struct ext4_extent_header *eh,
-				int depth)
+				     struct ext4_extent_header *eh,
+				     ext4_fsblk_t *pblk, int depth)
 {
 	unsigned short entries;
 	if (eh->eh_entries == 0)
@@ -361,8 +361,6 @@ static int ext4_valid_extent_entries(struct inode *inode,
 	if (depth == 0) {
 		/* leaf entries */
 		struct ext4_extent *ext = EXT_FIRST_EXTENT(eh);
-		struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
-		ext4_fsblk_t pblock = 0;
 		ext4_lblk_t lblock = 0;
 		ext4_lblk_t prev = 0;
 		int len = 0;
@@ -374,8 +372,7 @@ static int ext4_valid_extent_entries(struct inode *inode,
 			lblock = le32_to_cpu(ext->ee_block);
 			len = ext4_ext_get_actual_len(ext);
 			if ((lblock <= prev) && prev) {
-				pblock = ext4_ext_pblock(ext);
-				es->s_last_error_block = cpu_to_le64(pblock);
+				*pblk = ext4_ext_pblock(ext);
 				return 0;
 			}
 			ext++;
@@ -422,7 +419,7 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 		error_msg = "invalid eh_entries";
 		goto corrupted;
 	}
-	if (!ext4_valid_extent_entries(inode, eh, depth)) {
+	if (!ext4_valid_extent_entries(inode, eh, &pblk, depth)) {
 		error_msg = "invalid extent entries";
 		goto corrupted;
 	}
@@ -440,14 +437,14 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 	return 0;
 
 corrupted:
-	ext4_set_errno(inode->i_sb, -err);
-	ext4_error_inode(inode, function, line, 0,
-			 "pblk %llu bad header/extent: %s - magic %x, "
-			 "entries %u, max %u(%u), depth %u(%u)",
-			 (unsigned long long) pblk, error_msg,
-			 le16_to_cpu(eh->eh_magic),
-			 le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max),
-			 max, le16_to_cpu(eh->eh_depth), depth);
+	ext4_error_inode_err(inode, function, line, 0, -err,
+			     "pblk %llu bad header/extent: %s - magic %x, "
+			     "entries %u, max %u(%u), depth %u(%u)",
+			     (unsigned long long) pblk, error_msg,
+			     le16_to_cpu(eh->eh_magic),
+			     le16_to_cpu(eh->eh_entries),
+			     le16_to_cpu(eh->eh_max),
+			     max, le16_to_cpu(eh->eh_depth), depth);
 	return err;
 }
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9652a0eadd1c..b420c9dc444d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -196,10 +196,9 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
-		ext4_set_errno(sb, EIO);
-		ext4_error(sb, "Cannot read inode bitmap - "
-			   "block_group = %u, inode_bitmap = %llu",
-			   block_group, bitmap_blk);
+		ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
+			       "block_group = %u, inode_bitmap = %llu",
+			       block_group, bitmap_blk);
 		ext4_mark_group_bitmap_corrupted(sb, block_group,
 				EXT4_GROUP_INFO_IBITMAP_CORRUPT);
 		return ERR_PTR(-EIO);
@@ -1244,9 +1243,9 @@ struct inode *ext4_orphan_get(struct super_block *sb, unsigned long ino)
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ext4_set_errno(sb, -err);
-		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
-			   ino, err);
+		ext4_error_err(sb, -err,
+			       "couldn't read orphan inode %lu (err %d)",
+			       ino, err);
 		return inode;
 	}
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 569fc68e8975..107f0043f67f 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1019,7 +1019,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			 * (should be rare).
 			 */
 			if (!bh) {
-				EXT4_ERROR_INODE_BLOCK(inode, nr,
+				ext4_error_inode_block(inode, nr, EIO,
 						       "Read failure");
 				continue;
 			}
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7db6ee23277..f35e289e17aa 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -98,10 +98,9 @@ int ext4_get_max_inline_size(struct inode *inode)
 
 	error = ext4_get_inode_loc(inode, &iloc);
 	if (error) {
-		ext4_set_errno(inode->i_sb, -error);
-		ext4_error_inode(inode, __func__, __LINE__, 0,
-				 "can't get inode location %lu",
-				 inode->i_ino);
+		ext4_error_inode_err(inode, __func__, __LINE__, 0, -error,
+				     "can't get inode location %lu",
+				     inode->i_ino);
 		return 0;
 	}
 
@@ -1762,9 +1761,9 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 
 	err = ext4_get_inode_loc(dir, &iloc);
 	if (err) {
-		ext4_set_errno(dir->i_sb, -err);
-		EXT4_ERROR_INODE(dir, "error %d getting inode %lu block",
-				 err, dir->i_ino);
+		EXT4_ERROR_INODE_ERR(dir, -err,
+				     "error %d getting inode %lu block",
+				     err, dir->i_ino);
 		return true;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f6aebb792178..e416096fc081 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -269,10 +269,9 @@ void ext4_evict_inode(struct inode *inode)
 	if (inode->i_blocks) {
 		err = ext4_truncate(inode);
 		if (err) {
-			ext4_set_errno(inode->i_sb, -err);
-			ext4_error(inode->i_sb,
-				   "couldn't truncate inode %lu (err %d)",
-				   inode->i_ino, err);
+			ext4_error_err(inode->i_sb, -err,
+				       "couldn't truncate inode %lu (err %d)",
+				       inode->i_ino, err);
 			goto stop_handle;
 		}
 	}
@@ -2478,10 +2477,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		up_write(&EXT4_I(inode)->i_data_sem);
 		err2 = ext4_mark_inode_dirty(handle, inode);
 		if (err2) {
-			ext4_set_errno(inode->i_sb, -err2);
-			ext4_error(inode->i_sb,
-				   "Failed to mark inode %lu dirty",
-				   inode->i_ino);
+			ext4_error_err(inode->i_sb, -err2,
+				       "Failed to mark inode %lu dirty",
+				       inode->i_ino);
 		}
 		if (!err)
 			err = err2;
@@ -4382,8 +4380,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 		simulate_eio:
-			ext4_set_errno(inode->i_sb, EIO);
-			EXT4_ERROR_INODE_BLOCK(inode, block,
+			ext4_error_inode_block(inode, block, EIO,
 					       "unable to read itable block");
 			brelse(bh);
 			return -EIO;
@@ -4535,7 +4532,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
 		if (flags & EXT4_IGET_HANDLE)
 			return ERR_PTR(-ESTALE);
-		__ext4_error(sb, function, line,
+		__ext4_error(sb, function, line, EFSCORRUPTED, 0,
 			     "inode #%lu: comm %s: iget: illegal inode #",
 			     ino, current->comm);
 		return ERR_PTR(-EFSCORRUPTED);
@@ -4598,9 +4595,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei) ||
 	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) {
-		ext4_set_errno(inode->i_sb, EFSBADCRC);
-		ext4_error_inode(inode, function, line, 0,
-				 "iget: checksum invalid");
+		ext4_error_inode_err(inode, function, line, 0, EFSBADCRC,
+				     "iget: checksum invalid");
 		ret = -EFSBADCRC;
 		goto bad_inode;
 	}
@@ -5149,9 +5145,8 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 			sync_dirty_buffer(iloc.bh);
 		if (buffer_req(iloc.bh) && !buffer_uptodate(iloc.bh)) {
-			ext4_set_errno(inode->i_sb, EIO);
-			EXT4_ERROR_INODE_BLOCK(inode, iloc.bh->b_blocknr,
-					 "IO error syncing inode");
+			ext4_error_inode_block(inode, iloc.bh->b_blocknr, EIO,
+					       "IO error syncing inode");
 			err = -EIO;
 		}
 		brelse(iloc.bh);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 97cd1a2201a2..87c85be4c12e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3921,9 +3921,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
-		ext4_set_errno(sb, -err);
-		ext4_error(sb, "Error %d reading block bitmap for %u",
-			   err, group);
+		ext4_error_err(sb, -err,
+			       "Error %d reading block bitmap for %u",
+			       err, group);
 		return 0;
 	}
 
@@ -4090,18 +4090,16 @@ void ext4_discard_preallocations(struct inode *inode)
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
 					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
-			ext4_set_errno(sb, -err);
-			ext4_error(sb, "Error %d loading buddy information for %u",
-				   err, group);
+			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
+				       err, group);
 			continue;
 		}
 
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			err = PTR_ERR(bitmap_bh);
-			ext4_set_errno(sb, -err);
-			ext4_error(sb, "Error %d reading block bitmap for %u",
-					err, group);
+			ext4_error_err(sb, -err, "Error %d reading block bitmap for %u",
+				       err, group);
 			ext4_mb_unload_buddy(&e4b);
 			continue;
 		}
@@ -4355,9 +4353,8 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
 					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
-			ext4_set_errno(sb, -err);
-			ext4_error(sb, "Error %d loading buddy information for %u",
-				   err, group);
+			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
+				       err, group);
 			continue;
 		}
 		ext4_lock_group(sb, group);
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 87f7551c5132..d34cb8c46655 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -175,8 +175,8 @@ static int kmmpd(void *data)
 		 */
 		if (retval) {
 			if ((failed_writes % 60) == 0) {
-				ext4_set_errno(sb, -retval);
-				ext4_error(sb, "Error writing to MMP block");
+				ext4_error_err(sb, -retval,
+					       "Error writing to MMP block");
 			}
 			failed_writes++;
 		}
@@ -208,9 +208,9 @@ static int kmmpd(void *data)
 
 			retval = read_mmp_block(sb, &bh_check, mmp_block);
 			if (retval) {
-				ext4_set_errno(sb, -retval);
-				ext4_error(sb, "error reading MMP data: %d",
-					   retval);
+				ext4_error_err(sb, -retval,
+					       "error reading MMP data: %d",
+					       retval);
 				goto exit_thread;
 			}
 
@@ -222,8 +222,7 @@ static int kmmpd(void *data)
 					     "Error while updating MMP info. "
 					     "The filesystem seems to have been"
 					     " multiply mounted.");
-				ext4_set_errno(sb, EBUSY);
-				ext4_error(sb, "abort");
+				ext4_error_err(sb, EBUSY, "abort");
 				put_bh(bh_check);
 				retval = -EBUSY;
 				goto exit_thread;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 30ce3dc69378..1ed86fb6c302 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -422,8 +422,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 					   block_len_in_page, 0, &err2);
 	ext4_double_up_write_data_sem(orig_inode, donor_inode);
 	if (replaced_count != block_len_in_page) {
-		EXT4_ERROR_INODE_BLOCK(orig_inode, (sector_t)(orig_blk_offset),
-				       "Unable to copy data block,"
+		ext4_error_inode_block(orig_inode, (sector_t)(orig_blk_offset),
+				       EIO, "Unable to copy data block,"
 				       " data will be lost.");
 		*err = -EIO;
 	}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5f0a758956f6..a8aca4772aaa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -160,9 +160,9 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
 			set_buffer_verified(bh);
 		else {
-			ext4_set_errno(inode->i_sb, EFSBADCRC);
-			ext4_error_inode(inode, func, line, block,
-					 "Directory index failed checksum");
+			ext4_error_inode_err(inode, func, line, block,
+					     EFSBADCRC,
+					     "Directory index failed checksum");
 			brelse(bh);
 			return ERR_PTR(-EFSBADCRC);
 		}
@@ -172,9 +172,9 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
 			set_buffer_verified(bh);
 		else {
-			ext4_set_errno(inode->i_sb, EFSBADCRC);
-			ext4_error_inode(inode, func, line, block,
-					 "Directory block failed checksum");
+			ext4_error_inode_err(inode, func, line, block,
+					     EFSBADCRC,
+					     "Directory block failed checksum");
 			brelse(bh);
 			return ERR_PTR(-EFSBADCRC);
 		}
@@ -1532,9 +1532,9 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto next;
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
-			ext4_set_errno(sb, EIO);
-			EXT4_ERROR_INODE(dir, "reading directory lblock %lu",
-					 (unsigned long) block);
+			EXT4_ERROR_INODE_ERR(dir, EIO,
+					     "reading directory lblock %lu",
+					     (unsigned long) block);
 			brelse(bh);
 			ret = ERR_PTR(-EIO);
 			goto cleanup_and_exit;
@@ -1543,9 +1543,9 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		    !is_dx_internal_node(dir, block,
 					 (struct ext4_dir_entry *)bh->b_data) &&
 		    !ext4_dirblock_csum_verify(dir, bh)) {
-			ext4_set_errno(sb, EFSBADCRC);
-			EXT4_ERROR_INODE(dir, "checksumming directory "
-					 "block %lu", (unsigned long)block);
+			EXT4_ERROR_INODE_ERR(dir, EFSBADCRC,
+					     "checksumming directory "
+					     "block %lu", (unsigned long)block);
 			brelse(bh);
 			ret = ERR_PTR(-EFSBADCRC);
 			goto cleanup_and_exit;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4d460747cca7..038f685d30a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -335,10 +335,12 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
 #define ext4_get_tstamp(es, tstamp) \
 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
 
-static void __save_error_info(struct super_block *sb, const char *func,
-			    unsigned int line)
+static void __save_error_info(struct super_block *sb, int error,
+			      __u32 ino, __u64 block,
+			      const char *func, unsigned int line)
 {
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	int err;
 
 	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	if (bdev_read_only(sb->s_bdev))
@@ -347,8 +349,62 @@ static void __save_error_info(struct super_block *sb, const char *func,
 	ext4_update_tstamp(es, s_last_error_time);
 	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
-	if (es->s_last_error_errcode == 0)
-		es->s_last_error_errcode = EXT4_ERR_EFSCORRUPTED;
+	es->s_last_error_ino = cpu_to_le32(ino);
+	es->s_last_error_block = cpu_to_le64(block);
+	switch (error) {
+	case EIO:
+		err = EXT4_ERR_EIO;
+		break;
+	case ENOMEM:
+		err = EXT4_ERR_ENOMEM;
+		break;
+	case EFSBADCRC:
+		err = EXT4_ERR_EFSBADCRC;
+		break;
+	case 0:
+	case EFSCORRUPTED:
+		err = EXT4_ERR_EFSCORRUPTED;
+		break;
+	case ENOSPC:
+		err = EXT4_ERR_ENOSPC;
+		break;
+	case ENOKEY:
+		err = EXT4_ERR_ENOKEY;
+		break;
+	case EROFS:
+		err = EXT4_ERR_EROFS;
+		break;
+	case EFBIG:
+		err = EXT4_ERR_EFBIG;
+		break;
+	case EEXIST:
+		err = EXT4_ERR_EEXIST;
+		break;
+	case ERANGE:
+		err = EXT4_ERR_ERANGE;
+		break;
+	case EOVERFLOW:
+		err = EXT4_ERR_EOVERFLOW;
+		break;
+	case EBUSY:
+		err = EXT4_ERR_EBUSY;
+		break;
+	case ENOTDIR:
+		err = EXT4_ERR_ENOTDIR;
+		break;
+	case ENOTEMPTY:
+		err = EXT4_ERR_ENOTEMPTY;
+		break;
+	case ESHUTDOWN:
+		err = EXT4_ERR_ESHUTDOWN;
+		break;
+	case EFAULT:
+		err = EXT4_ERR_EFAULT;
+		break;
+	default:
+		err = EXT4_ERR_UNKNOWN;
+	}
+	es->s_last_error_errcode = err;
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
 		es->s_first_error_time_hi = es->s_last_error_time_hi;
@@ -368,10 +424,11 @@ static void __save_error_info(struct super_block *sb, const char *func,
 	le32_add_cpu(&es->s_error_count, 1);
 }
 
-static void save_error_info(struct super_block *sb, const char *func,
-			    unsigned int line)
+static void save_error_info(struct super_block *sb, int error,
+			    __u32 ino, __u64 block,
+			    const char *func, unsigned int line)
 {
-	__save_error_info(sb, func, line);
+	__save_error_info(sb, error, ino, block, func, line);
 	if (!bdev_read_only(sb->s_bdev))
 		ext4_commit_super(sb, 1);
 }
@@ -478,7 +535,8 @@ static void ext4_handle_error(struct super_block *sb)
 			     "EXT4-fs error")
 
 void __ext4_error(struct super_block *sb, const char *function,
-		  unsigned int line, const char *fmt, ...)
+		  unsigned int line, int error, __u64 block,
+		  const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -496,24 +554,21 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
-	save_error_info(sb, function, line);
+	save_error_info(sb, error, 0, block, function, line);
 	ext4_handle_error(sb);
 }
 
 void __ext4_error_inode(struct inode *inode, const char *function,
-			unsigned int line, ext4_fsblk_t block,
+			unsigned int line, ext4_fsblk_t block, int error,
 			const char *fmt, ...)
 {
 	va_list args;
 	struct va_format vaf;
-	struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
-	es->s_last_error_ino = cpu_to_le32(inode->i_ino);
-	es->s_last_error_block = cpu_to_le64(block);
 	if (ext4_error_ratelimit(inode->i_sb)) {
 		va_start(args, fmt);
 		vaf.fmt = fmt;
@@ -530,7 +585,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, function, line);
+	save_error_info(inode->i_sb, error, inode->i_ino, block,
+			function, line);
 	ext4_handle_error(inode->i_sb);
 }
 
@@ -549,7 +605,6 @@ void __ext4_error_file(struct file *file, const char *function,
 
 	trace_ext4_error(inode->i_sb, function, line);
 	es = EXT4_SB(inode->i_sb)->s_es;
-	es->s_last_error_ino = cpu_to_le32(inode->i_ino);
 	if (ext4_error_ratelimit(inode->i_sb)) {
 		path = file_path(file, pathname, sizeof(pathname));
 		if (IS_ERR(path))
@@ -571,7 +626,8 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, function, line);
+	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
+			function, line);
 	ext4_handle_error(inode->i_sb);
 }
 
@@ -615,66 +671,6 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 	return errstr;
 }
 
-void ext4_set_errno(struct super_block *sb, int err)
-{
-	if (err < 0)
-		err = -err;
-
-	switch (err) {
-	case EIO:
-		err = EXT4_ERR_EIO;
-		break;
-	case ENOMEM:
-		err = EXT4_ERR_ENOMEM;
-		break;
-	case EFSBADCRC:
-		err = EXT4_ERR_EFSBADCRC;
-		break;
-	case EFSCORRUPTED:
-		err = EXT4_ERR_EFSCORRUPTED;
-		break;
-	case ENOSPC:
-		err = EXT4_ERR_ENOSPC;
-		break;
-	case ENOKEY:
-		err = EXT4_ERR_ENOKEY;
-		break;
-	case EROFS:
-		err = EXT4_ERR_EROFS;
-		break;
-	case EFBIG:
-		err = EXT4_ERR_EFBIG;
-		break;
-	case EEXIST:
-		err = EXT4_ERR_EEXIST;
-		break;
-	case ERANGE:
-		err = EXT4_ERR_ERANGE;
-		break;
-	case EOVERFLOW:
-		err = EXT4_ERR_EOVERFLOW;
-		break;
-	case EBUSY:
-		err = EXT4_ERR_EBUSY;
-		break;
-	case ENOTDIR:
-		err = EXT4_ERR_ENOTDIR;
-		break;
-	case ENOTEMPTY:
-		err = EXT4_ERR_ENOTEMPTY;
-		break;
-	case ESHUTDOWN:
-		err = EXT4_ERR_ESHUTDOWN;
-		break;
-	case EFAULT:
-		err = EXT4_ERR_EFAULT;
-		break;
-	default:
-		err = EXT4_ERR_UNKNOWN;
-	}
-	EXT4_SB(sb)->s_es->s_last_error_errcode = err;
-}
-
 /* __ext4_std_error decodes expected errors from journaling functions
  * automatically and invokes the appropriate error response.  */
 
@@ -699,8 +695,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
-	ext4_set_errno(sb, -errno);
-	save_error_info(sb, function, line);
+	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
 
@@ -715,7 +710,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
  */
 
 void __ext4_abort(struct super_block *sb, const char *function,
-		unsigned int line, const char *fmt, ...)
+		  unsigned int line, int error, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -723,7 +718,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return;
 
-	save_error_info(sb, function, line);
+	save_error_info(sb, error, 0, 0, function, line);
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
@@ -742,7 +737,6 @@ void __ext4_abort(struct super_block *sb, const char *function,
 		sb->s_flags |= SB_RDONLY;
 		if (EXT4_SB(sb)->s_journal)
 			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
-		save_error_info(sb, function, line);
 	}
 	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
 		if (EXT4_SB(sb)->s_journal &&
@@ -816,15 +810,12 @@ __acquires(bitlock)
 {
 	struct va_format vaf;
 	va_list args;
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return;
 
 	trace_ext4_error(sb, function, line);
-	es->s_last_error_ino = cpu_to_le32(ino);
-	es->s_last_error_block = cpu_to_le64(block);
-	__save_error_info(sb, function, line);
+	__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 
 	if (ext4_error_ratelimit(sb)) {
 		va_start(args, fmt);
@@ -1037,8 +1028,7 @@ static void ext4_put_super(struct super_block *sb)
 		err = jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
 		if ((err < 0) && !aborted) {
-			ext4_set_errno(sb, -err);
-			ext4_abort(sb, "Couldn't clean up the journal");
+			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
 	}
 
@@ -5441,7 +5431,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
-		ext4_abort(sb, "Abort forced by user");
+		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8cac7d95c3ad..21df43a25328 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -245,7 +245,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 					 bh->b_data);
 errout:
 	if (error)
-		__ext4_error_inode(inode, function, line, 0,
+		__ext4_error_inode(inode, function, line, 0, -error,
 				   "corrupted xattr block %llu",
 				   (unsigned long long) bh->b_blocknr);
 	else
@@ -269,7 +269,7 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	error = ext4_xattr_check_entries(IFIRST(header), end, IFIRST(header));
 errout:
 	if (error)
-		__ext4_error_inode(inode, function, line, 0,
+		__ext4_error_inode(inode, function, line, 0, -error,
 				   "corrupted in-inode xattr");
 	return error;
 }
@@ -2880,9 +2880,9 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 		if (IS_ERR(bh)) {
 			error = PTR_ERR(bh);
 			if (error == -EIO) {
-				ext4_set_errno(inode->i_sb, EIO);
-				EXT4_ERROR_INODE(inode, "block %llu read error",
-						 EXT4_I(inode)->i_file_acl);
+				EXT4_ERROR_INODE_ERR(inode, EIO,
+						     "block %llu read error",
+						     EXT4_I(inode)->i_file_acl);
 			}
 			bh = NULL;
 			goto cleanup;
-- 
2.24.1

