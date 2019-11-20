Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406EB1031D8
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKTDCd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 22:02:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33664 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727378AbfKTDCd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Nov 2019 22:02:33 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAK32RRk011243
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 22:02:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 95FBB4202FD; Tue, 19 Nov 2019 22:02:27 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [RFC PATCH] ext4: save the error code which triggered an ext4_error() in the superblock
Date:   Tue, 19 Nov 2019 22:02:24 -0500
Message-Id: <20191120030224.22190-1-tytso@mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This allows the cause of an ext4_error() report to be categorized
based on whether it was triggered due to an I/O error, or an memory
allocation error, or other possible causes.  Most errors are caused by
a detected file system inconsistency, so the default code stored in
the superblock will be EXT4_ERR_EFSCORRUPTED.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c    |  1 +
 fs/ext4/ext4.h      | 30 +++++++++++++++++++-
 fs/ext4/ext4_jbd2.c |  3 ++
 fs/ext4/extents.c   |  1 +
 fs/ext4/ialloc.c    |  2 ++
 fs/ext4/inline.c    |  2 ++
 fs/ext4/inode.c     |  8 +++++-
 fs/ext4/mballoc.c   |  4 +++
 fs/ext4/mmp.c       |  6 +++-
 fs/ext4/namei.c     |  4 +++
 fs/ext4/super.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/xattr.c     |  4 ++-
 12 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..102c38527a10 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -506,6 +506,7 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 		return -EFSCORRUPTED;
 	wait_on_buffer(bh);
 	if (!buffer_uptodate(bh)) {
+		ext4_set_errno(sb, EIO);
 		ext4_error(sb, "Cannot read block bitmap - "
 			   "block_group = %u, block_bitmap = %llu",
 			   block_group, (unsigned long long) bh->b_blocknr);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61987c106511..74967d4772fb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1343,7 +1343,8 @@ struct ext4_super_block {
 	__u8	s_lastcheck_hi;
 	__u8	s_first_error_time_hi;
 	__u8	s_last_error_time_hi;
-	__u8	s_pad[2];
+	__u8	s_first_error_errno;
+	__u8    s_last_error_errno;
 	__le16  s_encoding;		/* Filename charset encoding */
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
 	__le32	s_reserved[95];		/* Padding to the end of the block */
@@ -1574,6 +1575,32 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
 
+/*
+ * Error number codes for s_{first,last}_error_errno
+ *
+ * Linux errno numbers are architecture specific, so we need to translate
+ * them into something which is architecture independent.   We don't define
+ * codes for all errno's; just the ones which are most likely to be the cause
+ * of an ext4_error() call.
+ */
+#define EXT4_ERR_UNKNOWN	 1
+#define EXT4_ERR_EIO		 2
+#define EXT4_ERR_ENOMEM		 3
+#define EXT4_ERR_EFSBADCRC	 4
+#define EXT4_ERR_EFSCORRUPTED	 5
+#define EXT4_ERR_ENOSPC		 6
+#define EXT4_ERR_ENOKEY		 7
+#define EXT4_ERR_EROFS		 8
+#define EXT4_ERR_EFBIG		 9
+#define EXT4_ERR_EEXIST		10
+#define EXT4_ERR_ERANGE		11
+#define EXT4_ERR_EOVERFLOW	12
+#define EXT4_ERR_EBUSY		13
+#define EXT4_ERR_ENOTDIR	14
+#define EXT4_ERR_ENOTEMPTY	15
+#define EXT4_ERR_ESHUTDOWN	16
+#define EXT4_ERR_EFAULT		17
+
 /*
  * Inode dynamic state flags
  */
@@ -2686,6 +2713,7 @@ extern const char *ext4_decode_error(struct super_block *sb, int errno,
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
+extern void ext4_set_errno(struct super_block *sb, int err);
 
 extern __printf(4, 5)
 void __ext4_error(struct super_block *, const char *, unsigned int,
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d3b8cdea5df7..19217a3f1ae4 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -58,6 +58,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 	 * take the FS itself readonly cleanly.
 	 */
 	if (journal && is_journal_aborted(journal)) {
+		ext4_set_errno(sb, -journal->j_errno);
 		ext4_abort(sb, "Detected aborted journal");
 		return -EROFS;
 	}
@@ -249,6 +250,7 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	if (err) {
 		ext4_journal_abort_handle(where, line, __func__,
 					  bh, handle, err);
+		ext4_set_errno(inode->i_sb, -err);
 		__ext4_abort(inode->i_sb, where, line,
 			   "error %d when attempting revoke", err);
 	}
@@ -320,6 +322,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				es = EXT4_SB(inode->i_sb)->s_es;
 				es->s_last_error_block =
 					cpu_to_le64(bh->b_blocknr);
+				ext4_set_errno(inode->i_sb, EIO);
 				ext4_error_inode(inode, where, line,
 						 bh->b_blocknr,
 					"IO error syncing itable block");
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e8708b77da6..ee83fe7c98aa 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -492,6 +492,7 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 	return 0;
 
 corrupted:
+	ext4_set_errno(inode->i_sb, -err);
 	ext4_error_inode(inode, function, line, 0,
 			 "pblk %llu bad header/extent: %s - magic %x, "
 			 "entries %u, max %u(%u), depth %u(%u)",
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index fa8c3c485e4b..31a5fd6f5e6a 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -194,6 +194,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	wait_on_buffer(bh);
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
+		ext4_set_errno(sb, EIO);
 		ext4_error(sb, "Cannot read inode bitmap - "
 			   "block_group = %u, inode_bitmap = %llu",
 			   block_group, bitmap_blk);
@@ -1228,6 +1229,7 @@ struct inode *ext4_orphan_get(struct super_block *sb, unsigned long ino)
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		ext4_set_errno(sb, -err);
 		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
 			   ino, err);
 		return inode;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2fec62d764fa..e61603f47035 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -98,6 +98,7 @@ int ext4_get_max_inline_size(struct inode *inode)
 
 	error = ext4_get_inode_loc(inode, &iloc);
 	if (error) {
+		ext4_set_errno(inode->i_sb, -error);
 		ext4_error_inode(inode, __func__, __LINE__, 0,
 				 "can't get inode location %lu",
 				 inode->i_ino);
@@ -1761,6 +1762,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 
 	err = ext4_get_inode_loc(dir, &iloc);
 	if (err) {
+		ext4_set_errno(dir->i_sb, -err);
 		EXT4_ERROR_INODE(dir, "error %d getting inode %lu block",
 				 err, dir->i_ino);
 		return true;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index de70f19bfa7e..b67ffa24ae0a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -271,6 +271,7 @@ void ext4_evict_inode(struct inode *inode)
 	if (inode->i_blocks) {
 		err = ext4_truncate(inode);
 		if (err) {
+			ext4_set_errno(inode->i_sb, -err);
 			ext4_error(inode->i_sb,
 				   "couldn't truncate inode %lu (err %d)",
 				   inode->i_ino, err);
@@ -2478,10 +2479,12 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			EXT4_I(inode)->i_disksize = disksize;
 		up_write(&EXT4_I(inode)->i_data_sem);
 		err2 = ext4_mark_inode_dirty(handle, inode);
-		if (err2)
+		if (err2) {
+			ext4_set_errno(inode->i_sb, -err2);
 			ext4_error(inode->i_sb,
 				   "Failed to mark inode %lu dirty",
 				   inode->i_ino);
+		}
 		if (!err)
 			err = err2;
 	}
@@ -4338,6 +4341,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
+			ext4_set_errno(inode->i_sb, EIO);
 			EXT4_ERROR_INODE_BLOCK(inode, block,
 					       "unable to read itable block");
 			brelse(bh);
@@ -4552,6 +4556,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
+		ext4_set_errno(inode->i_sb, EFSBADCRC);
 		ext4_error_inode(inode, function, line, 0,
 				 "iget: checksum invalid");
 		ret = -EFSBADCRC;
@@ -5090,6 +5095,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 			sync_dirty_buffer(iloc.bh);
 		if (buffer_req(iloc.bh) && !buffer_uptodate(iloc.bh)) {
+			ext4_set_errno(inode->i_sb, EIO);
 			EXT4_ERROR_INODE_BLOCK(inode, iloc.bh->b_blocknr,
 					 "IO error syncing inode");
 			err = -EIO;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a3e2767bdf2f..f64838187559 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3895,6 +3895,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
+		ext4_set_errno(sb, -err);
 		ext4_error(sb, "Error %d reading block bitmap for %u",
 			   err, group);
 		return 0;
@@ -4063,6 +4064,7 @@ void ext4_discard_preallocations(struct inode *inode)
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
 					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
+			ext4_set_errno(sb, -err);
 			ext4_error(sb, "Error %d loading buddy information for %u",
 				   err, group);
 			continue;
@@ -4071,6 +4073,7 @@ void ext4_discard_preallocations(struct inode *inode)
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			err = PTR_ERR(bitmap_bh);
+			ext4_set_errno(sb, -err);
 			ext4_error(sb, "Error %d reading block bitmap for %u",
 					err, group);
 			ext4_mb_unload_buddy(&e4b);
@@ -4325,6 +4328,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
 					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
+			ext4_set_errno(sb, -err);
 			ext4_error(sb, "Error %d loading buddy information for %u",
 				   err, group);
 			continue;
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 2305b4374fd3..1c44b1a32001 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -173,8 +173,10 @@ static int kmmpd(void *data)
 		 * (s_mmp_update_interval * 60) seconds.
 		 */
 		if (retval) {
-			if ((failed_writes % 60) == 0)
+			if ((failed_writes % 60) == 0) {
+				ext4_set_errno(sb, -retval);
 				ext4_error(sb, "Error writing to MMP block");
+			}
 			failed_writes++;
 		}
 
@@ -205,6 +207,7 @@ static int kmmpd(void *data)
 
 			retval = read_mmp_block(sb, &bh_check, mmp_block);
 			if (retval) {
+				ext4_set_errno(sb, -retval);
 				ext4_error(sb, "error reading MMP data: %d",
 					   retval);
 				goto exit_thread;
@@ -218,6 +221,7 @@ static int kmmpd(void *data)
 					     "Error while updating MMP info. "
 					     "The filesystem seems to have been"
 					     " multiply mounted.");
+				ext4_set_errno(sb, EBUSY);
 				ext4_error(sb, "abort");
 				put_bh(bh_check);
 				retval = -EBUSY;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a67cae3c8ff5..cee7c28e070d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -156,6 +156,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		if (ext4_dx_csum_verify(inode, dirent))
 			set_buffer_verified(bh);
 		else {
+			ext4_set_errno(inode->i_sb, EFSBADCRC);
 			ext4_error_inode(inode, func, line, block,
 					 "Directory index failed checksum");
 			brelse(bh);
@@ -166,6 +167,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		if (ext4_dirblock_csum_verify(inode, bh))
 			set_buffer_verified(bh);
 		else {
+			ext4_set_errno(inode->i_sb, EFSBADCRC);
 			ext4_error_inode(inode, func, line, block,
 					 "Directory block failed checksum");
 			brelse(bh);
@@ -1527,6 +1529,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto next;
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
+			ext4_set_errno(sb, EIO);
 			EXT4_ERROR_INODE(dir, "reading directory lblock %lu",
 					 (unsigned long) block);
 			brelse(bh);
@@ -1537,6 +1540,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		    !is_dx_internal_node(dir, block,
 					 (struct ext4_dir_entry *)bh->b_data) &&
 		    !ext4_dirblock_csum_verify(dir, bh)) {
+			ext4_set_errno(sb, EFSBADCRC);
 			EXT4_ERROR_INODE(dir, "checksumming directory "
 					 "block %lu", (unsigned long)block);
 			brelse(bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7796e2ffc294..32adaa70dde6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -367,6 +367,8 @@ static void __save_error_info(struct super_block *sb, const char *func,
 	ext4_update_tstamp(es, s_last_error_time);
 	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
+	if (es->s_last_error_errno == 0)
+		es->s_last_error_errno = EXT4_ERR_EFSCORRUPTED;
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
 		es->s_first_error_time_hi = es->s_last_error_time_hi;
@@ -631,6 +633,66 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 	return errstr;
 }
 
+void ext4_set_errno(struct super_block *sb, int err)
+{
+	if (err < 0)
+		err = -err;
+
+	switch (err) {
+	case EIO:
+		err = EXT4_ERR_EIO;
+		break;
+	case ENOMEM:
+		err = EXT4_ERR_ENOMEM;
+		break;
+	case EFSBADCRC:
+		err = EXT4_ERR_EFSBADCRC;
+		break;
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
+	EXT4_SB(sb)->s_es->s_last_error_errno = err;
+}
+
 /* __ext4_std_error decodes expected errors from journaling functions
  * automatically and invokes the appropriate error response.  */
 
@@ -655,6 +717,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
+	ext4_set_errno(sb, -errno);
 	save_error_info(sb, function, line);
 	ext4_handle_error(sb);
 }
@@ -982,8 +1045,10 @@ static void ext4_put_super(struct super_block *sb)
 		aborted = is_journal_aborted(sbi->s_journal);
 		err = jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
-		if ((err < 0) && !aborted)
+		if ((err < 0) && !aborted) {
+			ext4_set_errno(sb, -err);
 			ext4_abort(sb, "Couldn't clean up the journal");
+		}
 	}
 
 	ext4_unregister_sysfs(sb);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8966a5439a22..246fbeeb6366 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2879,9 +2879,11 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 		bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
 		if (IS_ERR(bh)) {
 			error = PTR_ERR(bh);
-			if (error == -EIO)
+			if (error == -EIO) {
+				ext4_set_errno(inode->i_sb, EIO);
 				EXT4_ERROR_INODE(inode, "block %llu read error",
 						 EXT4_I(inode)->i_file_acl);
+			}
 			bh = NULL;
 			goto cleanup;
 		}
-- 
2.23.0

