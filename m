Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0607A5D71
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjISJKD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISJKB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 05:10:01 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB3E6
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 02:09:53 -0700 (PDT)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id iW6bqYP576NwhiWjxqy4ll; Tue, 19 Sep 2023 09:09:53 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWjhqEziq3fOSiWjwqAHyW; Tue, 19 Sep 2023 09:09:53 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=65096561
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=qduZlTpFyxWblrC_1sUA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 7/7] lib: make journal.c more consistent
Date:   Tue, 19 Sep 2023 03:09:33 -0600
Message-Id: <20230919090933.25567-3-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919090933.25567-1-adilger@dilger.ca>
References: <20230919090933.25567-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLDGRXeyqAdcNDI+aWPWOJWXmFi65uyrG45v58bihvZKU4lu0R7h1qISFgwlwagtJBPLgkKuFBYxx2UUXpVQX77mdIUFbKXjnDJVaresZpOW7khGmNZq
 QVAMac6fJmsE76BVGNQMaYzWjMNP9gbyaxHMvmJ1r9lj3LB4NvTG0r4hQLGTzNgAciSyIXlObIsFl0yC8Wa1QrccRFkP02lZpNk91Gp/3439VeRTnT385/Kj
 g8npy1lOz9ETtHopFfiF3w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make the journal.c files more consistent between e2fsck and
debugfs.  Declare a local "ext2_filsys fs" variable in many
functions so that the common use of "ctx->fs" can be removed.

The file cannot be exactly the same, but removing a number of
minor differences makes it more clear where real differences
are when comparing the files with vimdiff, and will simplify
resolution of remaining differences later.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Change-Id: I27fd60e955967665746a6cca60f60e76f23ebbe5
---
 debugfs/journal.c |  65 ++++++++----
 e2fsck/journal.c  | 259 ++++++++++++++++++++++++++--------------------
 2 files changed, 186 insertions(+), 138 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 6e8dec35..bb95e9d1 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -23,8 +23,6 @@
 #endif
 
 #define E2FSCK_INCLUDE_INLINE_FUNCS
-#include "uuid/uuid.h"
-#include "journal.h"
 
 #if EXT2_FLAT_INCLUDES
 #include "blkid.h"
@@ -32,6 +30,9 @@
 #include "blkid/blkid.h"
 #endif
 
+#include "uuid/uuid.h"
+#include "journal.h"
+
 /*
  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
  * This creates a larger static binary, and a smaller binary using
@@ -107,12 +108,14 @@ static errcode_t ext2fs_get_journal(ext2_filsys fs, journal_t **ret_journal)
 	int			tried_backup_jnl = 0;
 
 	retval = ext2fs_get_memzero(sizeof(journal_t), &journal);
-	if (retval)
+	if (retval) {
 		return retval;
+	}
 
 	retval = ext2fs_get_memzero(2 * sizeof(struct kdev_s), &dev_fs);
-	if (retval)
+	if (retval) {
 		goto errout;
+	}
 	dev_journal = dev_fs+1;
 
 	dev_fs->k_fs = dev_journal->k_fs = fs;
@@ -125,13 +128,21 @@ static errcode_t ext2fs_get_journal(ext2_filsys fs, journal_t **ret_journal)
 	journal->j_blocksize = fs->blocksize;
 
 	if (uuid_is_null(sb->s_journal_uuid)) {
-		if (!sb->s_journal_inum) {
+		/*
+		 * The full set of superblock sanity checks haven't
+		 * been performed yet, so we need to do some basic
+		 * checks here to avoid potential array overruns.
+		 */
+		if (!sb->s_journal_inum ||
+		    (sb->s_journal_inum >
+		     (fs->group_desc_count * sb->s_inodes_per_group))) {
 			retval = EXT2_ET_BAD_INODE_NUM;
 			goto errout;
 		}
 		retval = ext2fs_get_memzero(sizeof(*j_inode), &j_inode);
-		if (retval)
+		if (retval) {
 			goto errout;
+		}
 
 		j_inode->i_fs = fs;
 		j_inode->i_ino = sb->s_journal_inum;
@@ -153,7 +164,8 @@ try_backup_journal:
 			tried_backup_jnl++;
 		}
 		if (!j_inode->i_ext2.i_links_count ||
-		    !LINUX_S_ISREG(j_inode->i_ext2.i_mode)) {
+		    !LINUX_S_ISREG(j_inode->i_ext2.i_mode) ||
+		    (j_inode->i_ext2.i_flags & EXT4_ENCRYPT_FL)) {
 			retval = EXT2_ET_NO_JOURNAL;
 			goto try_backup_journal;
 		}
@@ -229,7 +241,8 @@ try_backup_journal:
 	if (ext_journal)
 #endif
 	{
-		retval = io_ptr->open(journal_name, fs->flags & EXT2_FLAG_RW,
+		int flags = fs->flags & EXT2_FLAG_RW;
+		retval = io_ptr->open(journal_name, flags,
 				      &fs->journal_io);
 	}
 	if (retval)
@@ -294,7 +307,7 @@ try_backup_journal:
 
 		maxlen = ext2fs_blocks_count(&jsuper);
 		journal->j_total_len = (maxlen < 1ULL << 32) ? maxlen :
-				    (1ULL << 32) - 1;
+				(1ULL << 32) - 1;
 		start++;
 	}
 
@@ -358,8 +371,9 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	struct buffer_head *jbh = journal->j_sb_buffer;
 
 	ll_rw_block(REQ_OP_READ, 0, 1, &jbh);
-	if (jbh->b_err)
+	if (jbh->b_err) {
 		return jbh->b_err;
+	}
 
 	jsb = journal->j_superblock;
 	/* If we don't even have JBD2_MAGIC, we probably have a wrong inode */
@@ -381,8 +395,9 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 		if (ntohl(jsb->s_nr_users) > 1 &&
 		    uuid_is_null(fs->super->s_journal_uuid))
 			clear_v2_journal_fields(journal);
-		if (ntohl(jsb->s_nr_users) > 1)
+		if (ntohl(jsb->s_nr_users) > 1) {
 			return EXT2_ET_JOURNAL_UNSUPP_VERSION;
+		}
 		break;
 
 	/*
@@ -426,13 +441,15 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	/* We have now checked whether we know enough about the journal
 	 * format to be able to proceed safely, so any other checks that
 	 * fail we should attempt to recover from. */
-	if (jsb->s_blocksize != htonl(journal->j_blocksize))
+	if (jsb->s_blocksize != htonl(journal->j_blocksize)) {
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
+	}
 
 	if (ntohl(jsb->s_maxlen) < journal->j_total_len)
 		journal->j_total_len = ntohl(jsb->s_maxlen);
-	else if (ntohl(jsb->s_maxlen) > journal->j_total_len)
+	else if (ntohl(jsb->s_maxlen) > journal->j_total_len) {
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
+	}
 
 	journal->j_tail_sequence = ntohl(jsb->s_sequence);
 	journal->j_transaction_sequence = journal->j_tail_sequence;
@@ -461,12 +478,14 @@ static errcode_t ext2fs_check_ext3_journal(ext2_filsys fs)
 		return 0;
 
 	retval = ext2fs_get_journal(fs, &journal);
-	if (retval)
+	if (retval) {
 		return retval;
+	}
 
 	retval = ext2fs_journal_load(journal);
-	if (retval)
+	if (retval) {
 		goto err;
+	}
 
 	/*
 	 * We want to make the flags consistent here.  We will not leave with
@@ -552,15 +571,17 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 {
 	ext2_filsys fs = *fsp;
 	io_manager io_ptr = fs->io->manager;
+	int blocksize = fs->blocksize;
 	errcode_t	retval, recover_retval;
 	io_stats	stats = 0;
 	unsigned long long kbytes_written = 0;
-	char *fsname;
-	int fsflags;
-	int fsblocksize;
+	char *fsname = fs->device_name;
+	int fsflags = fs->flags;
+	int superblock = 0;
 
-	if (!(fs->flags & EXT2_FLAG_RW))
+	if (!(fs->flags & EXT2_FLAG_RW)) {
 		return EXT2_ET_FILE_RO;
+	}
 
 	if (fs->flags & EXT2_FLAG_DIRTY)
 		ext2fs_flush(fs);	/* Force out any modifications */
@@ -578,13 +599,11 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 		kbytes_written = stats->bytes_written >> 10;
 
 	ext2fs_mmp_stop(fs);
-	fsname = fs->device_name;
 	fs->device_name = NULL;
-	fsflags = fs->flags;
-	fsblocksize = fs->blocksize;
 	ext2fs_free(fs);
 	*fsp = NULL;
-	retval = ext2fs_open(fsname, fsflags, 0, fsblocksize, io_ptr, fsp);
+	retval = ext2fs_open(fsname, fsflags, superblock, blocksize, io_ptr,
+			     fsp);
 	ext2fs_free_mem(&fsname);
 	if (retval)
 		return retval;
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 02251956..f2db63e5 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -42,12 +42,19 @@
  */
 static void e2fsck_clear_recover(e2fsck_t ctx, int error)
 {
-	ext2fs_clear_feature_journal_needs_recovery(ctx->fs->super);
+	ext2_filsys fs = ctx->fs;
+	ext2fs_clear_feature_journal_needs_recovery(fs->super);
 
 	/* if we had an error doing journal recovery, we need a full fsck */
 	if (error)
-		ctx->fs->super->s_state &= ~EXT2_VALID_FS;
-	ext2fs_mark_super_dirty(ctx->fs);
+		fs->super->s_state &= ~EXT2_VALID_FS;
+	/*
+	 * If we replayed the journal by definition the file system
+	 * was mounted since the last time it was checked
+	 */
+	if (fs->super->s_lastcheck >= fs->super->s_mtime)
+		fs->super->s_lastcheck = fs->super->s_mtime - 1;
+	ext2fs_mark_super_dirty(fs);
 }
 
 /*
@@ -294,8 +301,9 @@ static void ex_sort_and_merge(struct extent_list *list)
 
 /* must free blocks that are released */
 static int ext4_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
-					struct ext2fs_extent *ex, int del)
+				   struct ext2fs_extent *ex, int del)
 {
+	ext2_filsys fs = ctx->fs;
 	int ret, offset;
 	unsigned int i;
 	struct ext2fs_extent add_ex = *ex;
@@ -312,7 +320,7 @@ static int ext4_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
 		 * Unmark all the blocks in bb now. All the blocks get marked
 		 * before we exit this function.
 		 */
-		ext2fs_unmark_block_bitmap_range2(ctx->fs->block_map,
+		ext2fs_unmark_block_bitmap_range2(fs->block_map,
 			list->extents[i].e_pblk, list->extents[i].e_len);
 		/* Case 2: Split */
 		if (list->extents[i].e_lblk < add_ex.e_lblk &&
@@ -362,9 +370,9 @@ static int ext4_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
 
 	/* Mark all occupied blocks allocated */
 	for (i = 0; i < list->count; i++)
-		ext2fs_mark_block_bitmap_range2(ctx->fs->block_map,
+		ext2fs_mark_block_bitmap_range2(fs->block_map,
 			list->extents[i].e_pblk, list->extents[i].e_len);
-	ext2fs_mark_bb_dirty(ctx->fs);
+	ext2fs_mark_bb_dirty(fs);
 
 	return 0;
 }
@@ -447,6 +455,7 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 
 static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl, __u8 *val)
 {
+	ext2_filsys fs = ctx->fs;
 	struct dentry_info_args darg;
 	int ret;
 
@@ -454,7 +463,7 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl, __u8 *val)
 	if (ret)
 		return ret;
 	ext4_fc_flush_extents(ctx, darg.ino);
-	ret = errcode_to_errno(ext2fs_unlink(ctx->fs, darg.parent_ino,
+	ret = errcode_to_errno(ext2fs_unlink(fs, darg.parent_ino,
 					     darg.dname, darg.ino, 0));
 	/* It's okay if the above call fails */
 	free(darg.dname);
@@ -539,6 +548,7 @@ static void ext4_fc_replay_fixup_iblocks(struct ext2_inode_large *ondisk_inode,
 
 static int ext4_fc_handle_inode(e2fsck_t ctx, __u8 *val)
 {
+	ext2_filsys fs = ctx->fs;
 	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE;
 	struct ext2_inode_large *inode = NULL, *fc_inode = NULL;
 	__le32 fc_ino;
@@ -550,13 +560,13 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, __u8 *val)
 	fc_raw_inode = val + sizeof(fc_ino);
 	ino = le32_to_cpu(fc_ino);
 
-	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE) {
+	if (EXT2_INODE_SIZE(fs->super) > EXT2_GOOD_OLD_INODE_SIZE) {
 		__u16 extra_isize = ext2fs_le16_to_cpu(
 			((struct ext2_inode_large *)fc_raw_inode)->i_extra_isize);
 
 		if ((extra_isize < (sizeof(inode->i_extra_isize) +
 				    sizeof(inode->i_checksum_hi))) ||
-		    (extra_isize > (EXT2_INODE_SIZE(ctx->fs->super) -
+		    (extra_isize > (EXT2_INODE_SIZE(fs->super) -
 				    EXT2_GOOD_OLD_INODE_SIZE))) {
 			err = EFSCORRUPTED;
 			goto out;
@@ -571,33 +581,33 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, __u8 *val)
 		goto out;
 	ext4_fc_flush_extents(ctx, ino);
 
-	err = ext2fs_read_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
+	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)inode,
 					inode_len);
 	if (err)
 		goto out;
 	memcpy(fc_inode, fc_raw_inode, inode_len);
 #ifdef WORDS_BIGENDIAN
-	ext2fs_swap_inode_full(ctx->fs, fc_inode, fc_inode, 0, inode_len);
+	ext2fs_swap_inode_full(fs, fc_inode, fc_inode, 0, inode_len);
 #endif
 	memcpy(inode, fc_inode, offsetof(struct ext2_inode_large, i_block));
 	memcpy(&inode->i_generation, &fc_inode->i_generation,
 		inode_len - offsetof(struct ext2_inode_large, i_generation));
 	ext4_fc_replay_fixup_iblocks(inode, fc_inode);
-	err = ext2fs_count_blocks(ctx->fs, ino, EXT2_INODE(inode), &blks);
+	err = ext2fs_count_blocks(fs, ino, EXT2_INODE(inode), &blks);
 	if (err)
 		goto out;
-	ext2fs_iblk_set(ctx->fs, EXT2_INODE(inode), blks);
-	ext2fs_inode_csum_set(ctx->fs, ino, inode);
+	ext2fs_iblk_set(fs, EXT2_INODE(inode), blks);
+	ext2fs_inode_csum_set(fs, ino, inode);
 
-	err = ext2fs_write_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
+	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)inode,
 					inode_len);
 	if (err)
 		goto out;
 	if (inode->i_links_count)
-		ext2fs_mark_inode_bitmap2(ctx->fs->inode_map, ino);
+		ext2fs_mark_inode_bitmap2(fs->inode_map, ino);
 	else
-		ext2fs_unmark_inode_bitmap2(ctx->fs->inode_map, ino);
-	ext2fs_mark_ib_dirty(ctx->fs);
+		ext2fs_unmark_inode_bitmap2(fs->inode_map, ino);
+	ext2fs_mark_ib_dirty(fs);
 
 out:
 	ext2fs_free_mem(&inode);
@@ -664,6 +674,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 				enum passtype pass, int off, tid_t expected_tid)
 {
 	e2fsck_t ctx = journal->j_ctx;
+	ext2_filsys fs = ctx->fs;
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_tl tl;
@@ -681,23 +692,23 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 		/* Starting replay phase */
 		state->fc_current_pass = pass;
 		/* We will reset checksums */
-		ctx->fs->flags |= EXT2_FLAG_IGNORE_CSUM_ERRORS;
-		ret = errcode_to_errno(ext2fs_read_bitmaps(ctx->fs));
+		fs->flags |= EXT2_FLAG_IGNORE_CSUM_ERRORS;
+		ret = errcode_to_errno(ext2fs_read_bitmaps(fs));
 		if (ret) {
 			jbd_debug(1, "Error %d while reading bitmaps\n", ret);
 			return ret;
 		}
-		state->fc_super_state = ctx->fs->super->s_state;
+		state->fc_super_state = fs->super->s_state;
 		/*
 		 * Mark the file system to indicate it contains errors. That's
 		 * because the updates performed by fast commit replay code are
 		 * not atomic and may result in inconsistent file system if it
 		 * crashes before the replay is complete.
 		 */
-		ctx->fs->super->s_state |= EXT2_ERROR_FS;
-		ctx->fs->super->s_state |= EXT4_FC_REPLAY;
-		ext2fs_mark_super_dirty(ctx->fs);
-		ext2fs_flush(ctx->fs);
+		fs->super->s_state |= EXT2_ERROR_FS;
+		fs->super->s_state |= EXT4_FC_REPLAY;
+		ext2fs_mark_super_dirty(fs);
+		ext2fs_flush(fs);
 	}
 
 	start = (__u8 *)bh->b_data;
@@ -748,24 +759,25 @@ replay_done:
 	if (state->fc_current_pass != pass)
 		return JBD2_FC_REPLAY_STOP;
 
-	ext2fs_calculate_summary_stats(ctx->fs, 0 /* update bg also */);
-	ext2fs_write_block_bitmap(ctx->fs);
-	ext2fs_write_inode_bitmap(ctx->fs);
-	ext2fs_mark_super_dirty(ctx->fs);
-	ext2fs_set_gdt_csum(ctx->fs);
-	ctx->fs->super->s_state = state->fc_super_state;
-	ext2fs_flush(ctx->fs);
+	ext2fs_calculate_summary_stats(fs, 0 /* update bg also */);
+	ext2fs_write_block_bitmap(fs);
+	ext2fs_write_inode_bitmap(fs);
+	ext2fs_mark_super_dirty(fs);
+	ext2fs_set_gdt_csum(fs);
+	fs->super->s_state = state->fc_super_state;
+	ext2fs_flush(fs);
 
 	return JBD2_FC_REPLAY_STOP;
 }
 
 static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 {
+	ext2_filsys fs = ctx->fs;
+	struct problem_context	pctx;
 	struct process_block_struct pb;
-	struct ext2_super_block *sb = ctx->fs->super;
+	struct ext2_super_block *sb = fs->super;
 	struct ext2_super_block jsuper;
-	struct problem_context	pctx;
-	struct buffer_head 	*bh;
+	struct buffer_head	*bh;
 	struct inode		*j_inode = NULL;
 	struct kdev_s		*dev_fs = NULL, *dev_journal;
 	const char		*journal_name = 0;
@@ -773,7 +785,6 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	errcode_t		retval = 0;
 	io_manager		io_ptr = 0;
 	unsigned long long	start = 0;
-	int			ret;
 	int			ext_journal = 0;
 	int			tried_backup_jnl = 0;
 
@@ -791,7 +802,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	}
 	dev_journal = dev_fs+1;
 
-	dev_fs->k_fs = dev_journal->k_fs = ctx->fs;
+	dev_fs->k_fs = dev_journal->k_fs = fs;
 	dev_fs->k_dev = K_DEV_FS;
 	dev_journal->k_dev = K_DEV_JOURNAL;
 
@@ -799,7 +810,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	journal->j_dev = dev_journal;
 	journal->j_fs_dev = dev_fs;
 	journal->j_inode = NULL;
-	journal->j_blocksize = ctx->fs->blocksize;
+	journal->j_blocksize = fs->blocksize;
 
 	if (uuid_is_null(sb->s_journal_uuid)) {
 		/*
@@ -809,7 +820,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		 */
 		if (!sb->s_journal_inum ||
 		    (sb->s_journal_inum >
-		     (ctx->fs->group_desc_count * sb->s_inodes_per_group))) {
+		     (fs->group_desc_count * sb->s_inodes_per_group))) {
 			retval = EXT2_ET_BAD_INODE_NUM;
 			goto errout;
 		}
@@ -820,13 +831,13 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			goto errout;
 		}
 
-		j_inode->i_fs = ctx->fs;
+		j_inode->i_fs = fs;
 		j_inode->i_ino = sb->s_journal_inum;
 
-		if ((retval = ext2fs_read_inode(ctx->fs,
-						sb->s_journal_inum,
-						&j_inode->i_ext2))) {
-		try_backup_journal:
+		retval = ext2fs_read_inode(fs, sb->s_journal_inum,
+					   &j_inode->i_ext2);
+		if (retval) {
+try_backup_journal:
 			if (sb->s_jnl_backup_type != EXT3_JNL_BACKUP_BLOCKS ||
 			    tried_backup_jnl)
 				goto errout;
@@ -854,16 +865,16 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			goto try_backup_journal;
 		}
 		pb.last_block = -1;
-		retval = ext2fs_block_iterate3(ctx->fs, j_inode->i_ino,
+		retval = ext2fs_block_iterate3(fs, j_inode->i_ino,
 					       BLOCK_FLAG_HOLE, 0,
 					       process_journal_block, &pb);
-		if ((pb.last_block + 1) * ctx->fs->blocksize <
+		if ((pb.last_block + 1) * fs->blocksize <
 		    (int) EXT2_I_SIZE(&j_inode->i_ext2)) {
 			retval = EXT2_ET_JOURNAL_TOO_SMALL;
 			goto try_backup_journal;
 		}
-		if (tried_backup_jnl && !(ctx->options & E2F_OPT_READONLY)) {
-			retval = ext2fs_write_inode(ctx->fs, sb->s_journal_inum,
+		if (tried_backup_jnl && (fs->flags & EXT2_FLAG_RW)) {
+			retval = ext2fs_write_inode(fs, sb->s_journal_inum,
 						    &j_inode->i_ext2);
 			if (retval)
 				goto errout;
@@ -873,7 +884,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			journal->j_blocksize;
 
 #ifdef USE_INODE_IO
-		retval = ext2fs_inode_io_intern2(ctx->fs, sb->s_journal_inum,
+		retval = ext2fs_inode_io_intern2(fs, sb->s_journal_inum,
 						 &j_inode->i_ext2,
 						 &journal_name);
 		if (retval)
@@ -882,11 +893,10 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		io_ptr = inode_io_manager;
 #else
 		journal->j_inode = j_inode;
-		ctx->fs->journal_io = ctx->fs->io;
-		if ((ret = jbd2_journal_bmap(journal, 0, &start)) != 0) {
-			retval = (errcode_t) (-1 * ret);
+		fs->journal_io = fs->io;
+		retval = (errcode_t)-jbd2_journal_bmap(journal, 0, &start);
+		if (retval)
 			goto errout;
-		}
 #endif
 	} else {
 		ext_journal = 1;
@@ -929,28 +939,30 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 
 		retval = io_ptr->open(journal_name, flags,
-				      &ctx->fs->journal_io);
+				      &fs->journal_io);
 	}
 	if (retval)
 		goto errout;
 
-	io_channel_set_blksize(ctx->fs->journal_io, ctx->fs->blocksize);
+	io_channel_set_blksize(fs->journal_io, fs->blocksize);
 
 	if (ext_journal) {
 		blk64_t maxlen;
 
-		start = ext2fs_journal_sb_start(ctx->fs->blocksize) - 1;
-		bh = getblk(dev_journal, start, ctx->fs->blocksize);
+		start = ext2fs_journal_sb_start(fs->blocksize) - 1;
+		bh = getblk(dev_journal, start, fs->blocksize);
 		if (!bh) {
 			retval = EXT2_ET_NO_MEMORY;
 			goto errout;
 		}
 		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-		if ((retval = bh->b_err) != 0) {
+		retval = bh->b_err;
+		if (retval) {
 			brelse(bh);
 			goto errout;
 		}
-		memcpy(&jsuper, start ? bh->b_data :  bh->b_data + SUPERBLOCK_OFFSET,
+		memcpy(&jsuper, start ? bh->b_data :
+				bh->b_data + SUPERBLOCK_OFFSET,
 		       sizeof(jsuper));
 #ifdef WORDS_BIGENDIAN
 		if (jsuper.s_magic == ext2fs_swab16(EXT2_SUPER_MAGIC))
@@ -964,7 +976,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			goto errout;
 		}
 		/* Make sure the journal UUID is correct */
-		if (memcmp(jsuper.s_uuid, ctx->fs->super->s_journal_uuid,
+		if (memcmp(jsuper.s_uuid, fs->super->s_journal_uuid,
 			   sizeof(jsuper.s_uuid))) {
 			fix_problem(ctx, PR_0_JOURNAL_BAD_UUID, &pctx);
 			retval = EXT2_ET_LOAD_EXT_JOURNAL;
@@ -979,8 +991,8 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			void *p;
 
 			p = start ? bh->b_data : bh->b_data + SUPERBLOCK_OFFSET;
-			memcpy(&fsx, ctx->fs, sizeof(fsx));
-			memcpy(&superx, ctx->fs->super, sizeof(superx));
+			memcpy(&fsx, fs, sizeof(fsx));
+			memcpy(&superx, fs->super, sizeof(superx));
 			fsx.super = &superx;
 			ext2fs_set_feature_metadata_csum(fsx.super);
 			if (!ext2fs_superblock_csum_verify(&fsx, p) &&
@@ -993,18 +1005,20 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		brelse(bh);
 
 		maxlen = ext2fs_blocks_count(&jsuper);
-		journal->j_total_len = (maxlen < 1ULL << 32) ? maxlen : (1ULL << 32) - 1;
+		journal->j_total_len = (maxlen < 1ULL << 32) ? maxlen :
+				(1ULL << 32) - 1;
 		start++;
 	}
 
-	if (!(bh = getblk(dev_journal, start, journal->j_blocksize))) {
+	bh = getblk(dev_journal, start, journal->j_blocksize);
+	if (!bh) {
 		retval = EXT2_ET_NO_MEMORY;
 		goto errout;
 	}
 
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
-	if (ext2fs_has_feature_fast_commit(ctx->fs->super))
+	if (ext2fs_has_feature_fast_commit(fs->super))
 		journal->j_fc_replay_callback = ext4_fc_replay;
 	else
 		journal->j_fc_replay_callback = NULL;
@@ -1032,9 +1046,10 @@ errout:
 static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 					      struct problem_context *pctx)
 {
-	struct ext2_super_block *sb = ctx->fs->super;
-	int recover = ext2fs_has_feature_journal_needs_recovery(ctx->fs->super);
-	int has_journal = ext2fs_has_feature_journal(ctx->fs->super);
+	ext2_filsys fs = ctx->fs;
+	struct ext2_super_block *sb = fs->super;
+	int recover = ext2fs_has_feature_journal_needs_recovery(fs->super);
+	int has_journal = ext2fs_has_feature_journal(fs->super);
 
 	if (has_journal || sb->s_journal_inum) {
 		/* The journal inode is bogus, remove and force full fsck */
@@ -1046,7 +1061,7 @@ static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 			sb->s_journal_inum = 0;
 			memset(sb->s_jnl_blocks, 0, sizeof(sb->s_jnl_blocks));
 			ctx->flags |= E2F_FLAG_JOURNAL_INODE;
-			ctx->fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
+			fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
 			e2fsck_clear_recover(ctx, 1);
 			return 0;
 		}
@@ -1062,8 +1077,10 @@ static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 }
 
 #define V1_SB_SIZE	0x0024
-static void clear_v2_journal_fields(e2fsck_t ctx, journal_t *journal)
+static void clear_v2_journal_fields(journal_t *journal)
 {
+	e2fsck_t ctx = journal->j_ctx; 
+	ext2_filsys fs = ctx->fs;
 	struct problem_context pctx;
 
 	clear_problem_context(&pctx);
@@ -1073,13 +1090,15 @@ static void clear_v2_journal_fields(e2fsck_t ctx, journal_t *journal)
 
 	ctx->flags |= E2F_FLAG_PROBLEMS_FIXED;
 	memset(((char *) journal->j_superblock) + V1_SB_SIZE, 0,
-	       ctx->fs->blocksize-V1_SB_SIZE);
+	       fs->blocksize-V1_SB_SIZE);
 	mark_buffer_dirty(journal->j_sb_buffer);
 }
 
 
-static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t *journal)
+static errcode_t e2fsck_journal_load(journal_t *journal)
 {
+	e2fsck_t ctx = journal->j_ctx; 
+	ext2_filsys fs = ctx->fs;
 	journal_superblock_t *jsb;
 	struct buffer_head *jbh = journal->j_sb_buffer;
 	struct problem_context pctx;
@@ -1105,14 +1124,14 @@ static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t *journal)
 		    jsb->s_feature_incompat ||
 		    jsb->s_feature_ro_compat ||
 		    jsb->s_nr_users)
-			clear_v2_journal_fields(ctx, journal);
+			clear_v2_journal_fields(journal);
 		break;
 
 	case JBD2_SUPERBLOCK_V2:
 		journal->j_format_version = 2;
 		if (ntohl(jsb->s_nr_users) > 1 &&
-		    uuid_is_null(ctx->fs->super->s_journal_uuid))
-			clear_v2_journal_fields(ctx, journal);
+		    uuid_is_null(fs->super->s_journal_uuid))
+			clear_v2_journal_fields(journal);
 		if (ntohl(jsb->s_nr_users) > 1) {
 			fix_problem(ctx, PR_0_JOURNAL_UNSUPP_MULTIFS, &pctx);
 			return EXT2_ET_JOURNAL_UNSUPP_VERSION;
@@ -1199,9 +1218,11 @@ static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t *journal)
 	return 0;
 }
 
-static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
+static void e2fsck_journal_reset_super(journal_superblock_t *jsb,
 				       journal_t *journal)
 {
+	e2fsck_t ctx = journal->j_ctx; 
+	ext2_filsys fs = ctx->fs;
 	char *p;
 	union {
 		uuid_t uuid;
@@ -1223,9 +1244,9 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	/* Zero out everything else beyond the superblock header */
 
 	p = ((char *) jsb) + sizeof(journal_header_t);
-	memset (p, 0, ctx->fs->blocksize-sizeof(journal_header_t));
+	memset (p, 0, fs->blocksize-sizeof(journal_header_t));
 
-	jsb->s_blocksize = htonl(ctx->fs->blocksize);
+	jsb->s_blocksize = htonl(fs->blocksize);
 	jsb->s_maxlen = htonl(journal->j_total_len);
 	jsb->s_first = htonl(1);
 
@@ -1248,12 +1269,13 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
 						  journal_t *journal,
 						  struct problem_context *pctx)
 {
-	struct ext2_super_block *sb = ctx->fs->super;
-	int recover = ext2fs_has_feature_journal_needs_recovery(ctx->fs->super);
+	ext2_filsys fs = ctx->fs;
+	struct ext2_super_block *sb = fs->super;
+	int recover = ext2fs_has_feature_journal_needs_recovery(fs->super);
 
 	if (ext2fs_has_feature_journal(sb)) {
 		if (fix_problem(ctx, PR_0_JOURNAL_BAD_SUPER, pctx)) {
-			e2fsck_journal_reset_super(ctx, journal->j_superblock,
+			e2fsck_journal_reset_super(journal->j_superblock,
 						   journal);
 			journal->j_transaction_sequence = 1;
 			e2fsck_clear_recover(ctx, recover);
@@ -1272,9 +1294,10 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
  */
 errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 {
-	struct ext2_super_block *sb = ctx->fs->super;
+	ext2_filsys fs = ctx->fs;
+	struct ext2_super_block *sb = fs->super;
 	journal_t *journal;
-	int recover = ext2fs_has_feature_journal_needs_recovery(ctx->fs->super);
+	int recover = ext2fs_has_feature_journal_needs_recovery(fs->super);
 	struct problem_context pctx;
 	problem_t problem;
 	int reset = 0, force_fsck = 0;
@@ -1284,7 +1307,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 	if (!ext2fs_has_feature_journal(sb) &&
 	    !recover && sb->s_journal_inum == 0 && sb->s_journal_dev == 0 &&
 	    uuid_is_null(sb->s_journal_uuid))
- 		return 0;
+		return 0;
 
 	clear_problem_context(&pctx);
 	pctx.num = sb->s_journal_inum;
@@ -1299,7 +1322,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		return retval;
 	}
 
-	retval = e2fsck_journal_load(ctx, journal);
+	retval = e2fsck_journal_load(journal);
 	if (retval) {
 		if ((retval == EXT2_ET_CORRUPT_JOURNAL_SB) ||
 		    ((retval == EXT2_ET_UNSUPP_FEATURE) &&
@@ -1312,7 +1335,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, &pctx))))
 			retval = e2fsck_journal_fix_corrupt_super(ctx, journal,
 								  &pctx);
-		ext2fs_journal_release(ctx->fs, journal, 0, 1);
+		ext2fs_journal_release(fs, journal, 0, 1);
 		return retval;
 	}
 
@@ -1342,8 +1365,8 @@ no_has_journal:
 			e2fsck_clear_recover(ctx, force_fsck);
 		} else if (!(ctx->options & E2F_OPT_READONLY)) {
 			ext2fs_set_feature_journal(sb);
-			ctx->fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
-			ext2fs_mark_super_dirty(ctx->fs);
+			fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
+			ext2fs_mark_super_dirty(fs);
 		}
 	}
 
@@ -1359,12 +1382,12 @@ no_has_journal:
 		if (fix_problem(ctx, problem, &pctx)) {
 			ctx->options |= E2F_OPT_FORCE;
 			ext2fs_set_feature_journal_needs_recovery(sb);
-			ext2fs_mark_super_dirty(ctx->fs);
+			ext2fs_mark_super_dirty(fs);
 		} else if (fix_problem(ctx,
 				       PR_0_JOURNAL_RESET_JOURNAL, &pctx)) {
 			reset = 1;
 			sb->s_state &= ~EXT2_VALID_FS;
-			ext2fs_mark_super_dirty(ctx->fs);
+			ext2fs_mark_super_dirty(fs);
 		}
 		/*
 		 * If the user answers no to the above question, we
@@ -1386,19 +1409,20 @@ no_has_journal:
 	 */
 	if (!ext2fs_has_feature_journal_needs_recovery(sb) &&
 	    journal->j_superblock->s_errno) {
-		ctx->fs->super->s_state |= EXT2_ERROR_FS;
-		ext2fs_mark_super_dirty(ctx->fs);
+		fs->super->s_state |= EXT2_ERROR_FS;
+		ext2fs_mark_super_dirty(fs);
 		journal->j_superblock->s_errno = 0;
 		ext2fs_journal_sb_csum_set(journal, journal->j_superblock);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
-	ext2fs_journal_release(ctx->fs, journal, reset, 0);
+	ext2fs_journal_release(fs, journal, reset, 0);
 	return retval;
 }
 
 static errcode_t recover_ext3_journal(e2fsck_t ctx)
 {
+	ext2_filsys fs = ctx->fs;
 	struct problem_context	pctx;
 	journal_t *journal;
 	errcode_t retval;
@@ -1417,7 +1441,7 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	if (retval)
 		return retval;
 
-	retval = e2fsck_journal_load(ctx, journal);
+	retval = e2fsck_journal_load(journal);
 	if (retval)
 		goto errout;
 
@@ -1442,17 +1466,21 @@ errout:
 	jbd2_journal_destroy_revoke(journal);
 	jbd2_journal_destroy_revoke_record_cache();
 	jbd2_journal_destroy_revoke_table_cache();
-	ext2fs_journal_release(ctx->fs, journal, 1, 0);
+	ext2fs_journal_release(fs, journal, 1, 0);
 	return retval;
 }
 
 errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 {
-	io_manager io_ptr = ctx->fs->io->manager;
-	int blocksize = ctx->fs->blocksize;
+	ext2_filsys fs = ctx->fs;
+	io_manager io_ptr = fs->io->manager;
+	int blocksize = fs->blocksize;
 	errcode_t	retval, recover_retval;
 	io_stats	stats = 0;
 	unsigned long long kbytes_written = 0;
+	char *fsname = ctx->filesystem_name;
+	int fsflags = ctx->openfs_flags;
+	int superblock = ctx->superblock;
 
 	printf(_("%s: recovering journal\n"), ctx->device_name);
 	if (ctx->options & E2F_OPT_READONLY) {
@@ -1461,8 +1489,8 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 		return EXT2_ET_FILE_RO;
 	}
 
-	if (ctx->fs->flags & EXT2_FLAG_DIRTY)
-		ext2fs_flush(ctx->fs);	/* Force out any modifications */
+	if (fs->flags & EXT2_FLAG_DIRTY)
+		ext2fs_flush(fs);	/* Force out any modifications */
 
 	recover_retval = recover_ext3_journal(ctx);
 
@@ -1470,16 +1498,15 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 	 * Reload the filesystem context to get up-to-date data from disk
 	 * because journal recovery will change the filesystem under us.
 	 */
-	if (ctx->fs->super->s_kbytes_written &&
-	    ctx->fs->io->manager->get_stats)
-		ctx->fs->io->manager->get_stats(ctx->fs->io, &stats);
+	if (fs->super->s_kbytes_written &&
+	    fs->io->manager->get_stats)
+		fs->io->manager->get_stats(fs->io, &stats);
 	if (stats && stats->bytes_written)
 		kbytes_written = stats->bytes_written >> 10;
 
-	ext2fs_mmp_stop(ctx->fs);
-	ext2fs_free(ctx->fs);
-	retval = ext2fs_open(ctx->filesystem_name, ctx->openfs_flags,
-			     ctx->superblock, blocksize, io_ptr,
+	ext2fs_mmp_stop(fs);
+	ext2fs_free(fs);
+	retval = ext2fs_open(fsname, fsflags, superblock, blocksize, io_ptr,
 			     &ctx->fs);
 	if (retval) {
 		com_err(ctx->program_name, retval,
@@ -1487,10 +1514,11 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 			ctx->device_name);
 		fatal_error(ctx, 0);
 	}
-	ctx->fs->priv_data = ctx;
-	ctx->fs->now = ctx->now;
-	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
-	ctx->fs->super->s_kbytes_written += kbytes_written;
+	fs = ctx->fs;
+	fs->priv_data = ctx;
+	fs->now = ctx->now;
+	fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
+	fs->super->s_kbytes_written += kbytes_written;
 
 	/* Set the superblock flags */
 	e2fsck_clear_recover(ctx, recover_retval != 0);
@@ -1512,10 +1540,10 @@ static const char * const journal_names[] = {
 
 void e2fsck_move_ext3_journal(e2fsck_t ctx)
 {
-	struct ext2_super_block *sb = ctx->fs->super;
+	ext2_filsys fs = ctx->fs;
+	struct ext2_super_block *sb = fs->super;
 	struct problem_context	pctx;
 	struct ext2_inode 	inode;
-	ext2_filsys		fs = ctx->fs;
 	ext2_ino_t		ino;
 	errcode_t		retval;
 	const char * const *	cpp;
@@ -1637,7 +1665,8 @@ err_out:
  */
 int e2fsck_fix_ext3_journal_hint(e2fsck_t ctx)
 {
-	struct ext2_super_block *sb = ctx->fs->super;
+	ext2_filsys fs = ctx->fs;
+	struct ext2_super_block *sb = fs->super;
 	struct problem_context pctx;
 	char uuid[37], *journal_name;
 	struct stat st;
@@ -1661,7 +1690,7 @@ int e2fsck_fix_ext3_journal_hint(e2fsck_t ctx)
 		pctx.num = st.st_rdev;
 		if (fix_problem(ctx, PR_0_EXTERNAL_JOURNAL_HINT, &pctx)) {
 			sb->s_journal_dev = st.st_rdev;
-			ext2fs_mark_super_dirty(ctx->fs);
+			ext2fs_mark_super_dirty(fs);
 		}
 	}
 
-- 
2.25.1

