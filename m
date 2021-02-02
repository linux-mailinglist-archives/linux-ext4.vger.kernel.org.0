Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291D130BA07
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBBIfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 03:35:06 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:36884 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhBBIei (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 03:34:38 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 03:34:37 EST
Received: from webber.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id 6r0alcxTNnRGt6r0bl92vJ; Tue, 02 Feb 2021 01:26:02 -0700
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=60190c9a
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=tajLFHiu4riO9EAO7D8A:9 a=SKPVngMpTpbfxUAx:21 a=aakXOJV7ul9CyihV:21
 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] e2fsck: fix check of directories over 4GB
Date:   Tue,  2 Feb 2021 01:25:49 -0700
Message-Id: <20210202082549.2936-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJe0M4VHwZTmzQ1PUJCQ93UzTrkhOV+pj88TEnjx8o5BmmkTK4ONQzDqmM0LULTTYWeCB545o9ftZZsge1UfC9NoHRIfTX7l26Q34hP2izH4gm/OaCv5
 798IQ1ox2gx+fqR+D+9jyzvOuTMTlVr5n7jz1V5XiD2mdIvPs1gJJpiAQqgMogmkBzv2QMzz0Ysp6iKDLFfDI9r2yhKlVTwPIvmLrJBNmwZbmbdkpUP7Ej9r
 PTh2zJ5TAuOc8GmkFrex2A==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If directories grow larger than 4GB in size with the large_dir
feature, e2fsck will consider them to be corrupted and clear
the high bits of the size.

Since it isn't very common to have directories this large, and
unlike sparse files that don't have ill effects if the size is
too large, an too-large directory will have all of the sparse
blocks filled in by e2fsck, so huge directories should still
be viewed with suspicion.  Check for consistency between two of
the three among block count, inode size, and superblock large_dir
flag before deciding whether the directory inode should be fixed
or cleared, or if large_dir should be set in the superblock.

Update the f_recnect_bad test case to match new output.

Fixes: 49f28a06b738 ("e2fsck: allow to check >2GB sized directory")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-14345
Change-Id: I1b898cdab95d239ba1a7b37eb96255acadce7057
---
 e2fsck/e2fsck.c              |  1 +
 e2fsck/e2fsck.h              |  1 +
 e2fsck/message.c             |  5 +---
 e2fsck/pass1.c               | 51 ++++++++++++++++++++++++++++++------
 e2fsck/pass2.c               | 13 ++++++---
 e2fsck/problem.c             |  9 +++++--
 e2fsck/problem.h             |  4 +--
 lib/ext2fs/blknum.c          | 33 +++++++++++++++--------
 lib/ext2fs/expanddir.c       |  5 +++-
 lib/ext2fs/punch.c           |  4 +--
 lib/ext2fs/res_gdt.c         |  4 +--
 tests/f_recnect_bad/expect.1 |  5 ++--
 12 files changed, 97 insertions(+), 38 deletions(-)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 929bd78d..71305392 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -181,6 +181,7 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 	ctx->fs_fragmented = 0;
 	ctx->fs_fragmented_dir = 0;
 	ctx->large_files = 0;
+	ctx->large_dirs = 0;
 
 	for (i=0; i < MAX_EXTENT_DEPTH_COUNT; i++)
 		ctx->extent_depth_count[i] = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 7e0895c2..9ad49410 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -379,6 +379,7 @@ struct e2fsck_struct {
 	__u32 fs_fragmented;
 	__u32 fs_fragmented_dir;
 	__u32 large_files;
+	__u32 large_dirs;
 	__u32 fs_ext_attr_inodes;
 	__u32 fs_ext_attr_blocks;
 	__u32 extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
diff --git a/e2fsck/message.c b/e2fsck/message.c
index 727f71d5..05d914dd 100644
--- a/e2fsck/message.c
+++ b/e2fsck/message.c
@@ -281,10 +281,7 @@ static _INLINE_ void expand_inode_expression(FILE *f, ext2_filsys fs, char ch,
 
 	switch (ch) {
 	case 's':
-		if (LINUX_S_ISDIR(inode->i_mode))
-			fprintf(f, "%u", inode->i_size);
-		else
-			fprintf(f, "%llu", EXT2_I_SIZE(inode));
+		fprintf(f, "%llu", EXT2_I_SIZE(inode));
 		break;
 	case 'S':
 		fprintf(f, "%u", large_inode->i_extra_isize);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 38afda48..9cf83df4 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2051,6 +2051,21 @@ void e2fsck_pass1(e2fsck_t ctx)
 		goto endit;
 	}
 
+	if (ctx->large_dirs && !ext2fs_has_feature_largedir(ctx->fs->super)) {
+		ext2_filsys fs = ctx->fs;
+
+		if (fix_problem(ctx, PR_2_FEATURE_LARGE_DIRS, &pctx)) {
+			ext2fs_set_feature_largedir(fs->super);
+			fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
+			ext2fs_mark_super_dirty(fs);
+		}
+		if (fs->super->s_rev_level == EXT2_GOOD_OLD_REV &&
+		    fix_problem(ctx, PR_1_FS_REV_LEVEL, &pctx)) {
+			ext2fs_update_dynamic_rev(fs);
+			ext2fs_mark_super_dirty(fs);
+		}
+	}
+
 	if (ctx->block_dup_map) {
 		if (ctx->options & E2F_OPT_PREEN) {
 			clear_problem_context(&pctx);
@@ -2685,10 +2700,30 @@ static int handle_htree(e2fsck_t ctx, struct problem_context *pctx,
 		return 1;
 
 	pctx->num = root->indirect_levels;
-	if ((root->indirect_levels >= ext2_dir_htree_level(fs)) &&
+	/* if htree level is clearly too high, consider it to be broken */
+	if (root->indirect_levels > EXT4_HTREE_LEVEL &&
 	    fix_problem(ctx, PR_1_HTREE_DEPTH, pctx))
 		return 1;
 
+	/* if level is only maybe too high, LARGE_DIR feature could be unset */
+	if (root->indirect_levels > ext2_dir_htree_level(fs) &&
+	    !ext2fs_has_feature_largedir(fs->super)) {
+		int blockbits = EXT2_BLOCK_SIZE_BITS(fs->super) + 10;
+		int idx_pb = 1 << (blockbits - 3);
+
+		/* compare inode size/blocks vs. max-sized 2-level htree */
+		if (EXT2_I_SIZE(pctx->inode) <
+		    (idx_pb - 1) * (idx_pb - 2) << blockbits &&
+		    pctx->inode->i_blocks <
+		    (idx_pb - 1) * (idx_pb - 2) << (blockbits - 9) &&
+		    fix_problem(ctx, PR_1_HTREE_DEPTH, pctx))
+			return 1;
+	}
+
+	if (root->indirect_levels > EXT4_HTREE_LEVEL_COMPAT ||
+	    ext2fs_needs_large_file_feature(EXT2_I_SIZE(inode)))
+		ctx->large_dirs++;
+
 	return 0;
 }
 
@@ -2835,7 +2870,8 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
 			 (extent.e_pblk + extent.e_len) >
 			 ext2fs_blocks_count(ctx->fs->super))
 			problem = PR_1_EXTENT_ENDS_BEYOND;
-		else if (is_leaf && is_dir &&
+		else if (is_leaf && is_dir && !pctx->inode->i_size_high &&
+			 !ext2fs_has_feature_largedir(ctx->fs->super) &&
 			 ((extent.e_lblk + extent.e_len) >
 			  (1U << (21 - ctx->fs->super->s_log_block_size))))
 			problem = PR_1_TOOBIG_DIR;
@@ -3430,8 +3466,9 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	       ino, inode->i_size, pb.last_block, ext2fs_inode_i_blocks(fs, inode),
 	       pb.num_blocks);
 #endif
+	size = EXT2_I_SIZE(inode);
 	if (pb.is_dir) {
-		unsigned nblock = inode->i_size >> EXT2_BLOCK_SIZE_BITS(fs->super);
+		unsigned nblock = size >> EXT2_BLOCK_SIZE_BITS(fs->super);
 		if (inode->i_flags & EXT4_INLINE_DATA_FL) {
 			int flags;
 			size_t sz = 0;
@@ -3445,11 +3482,11 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 					  EXT2_FLAG_IGNORE_CSUM_ERRORS) |
 					 (ctx->fs->flags &
 					  ~EXT2_FLAG_IGNORE_CSUM_ERRORS);
-			if (err || sz != inode->i_size) {
+			if (err || sz != size) {
 				bad_size = 7;
 				pctx->num = sz;
 			}
-		} else if (inode->i_size & (fs->blocksize - 1))
+		} else if (size & (fs->blocksize - 1))
 			bad_size = 5;
 		else if (nblock > (pb.last_block + 1))
 			bad_size = 1;
@@ -3459,7 +3496,6 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 				bad_size = 2;
 		}
 	} else {
-		size = EXT2_I_SIZE(inode);
 		if ((pb.last_init_lblock >= 0) &&
 		    /* Do not allow initialized allocated blocks past i_size*/
 		    (size < (__u64)pb.last_init_lblock * fs->blocksize) &&
@@ -3482,8 +3518,6 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 			pctx->num = (pb.last_block + 1) * fs->blocksize;
 		pctx->group = bad_size;
 		if (fix_problem(ctx, PR_1_BAD_I_SIZE, pctx)) {
-			if (LINUX_S_ISDIR(inode->i_mode))
-				pctx->num &= 0xFFFFFFFFULL;
 			ext2fs_inode_size_set(fs, inode, pctx->num);
 			if (EXT2_I_SIZE(inode) == 0 &&
 			    (inode->i_flags & EXT4_INLINE_DATA_FL)) {
@@ -3662,6 +3696,7 @@ static int process_block(ext2_filsys fs,
 	}
 
 	if (p->is_dir && !ext2fs_has_feature_largedir(fs->super) &&
+	    !pctx->inode->i_size_high &&
 	    blockcnt > (1 << (21 - fs->super->s_log_block_size)))
 		problem = PR_1_TOOBIG_DIR;
 	if (p->is_dir && p->num_blocks + 1 >= p->max_blocks)
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index cb1e5875..5f7cd644 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1095,6 +1095,9 @@ inline_read_fail:
 			root = (struct ext2_dx_root_info *) (buf + 24);
 			dx_db->type = DX_DIRBLOCK_ROOT;
 			dx_db->flags |= DX_FLAG_FIRST | DX_FLAG_LAST;
+
+			/* large_dir was set in pass1 if large dirs were found,
+			 * so ext2_dir_htree_level() should now be correct */
 			if ((root->reserved_zero ||
 			     root->info_length < 8 ||
 			     root->indirect_levels >=
@@ -1703,9 +1706,12 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
 	if (inode.i_flags & EXT4_INLINE_DATA_FL)
 		goto clear_inode;
 
-	if (LINUX_S_ISREG(inode.i_mode) &&
-	    ext2fs_needs_large_file_feature(EXT2_I_SIZE(&inode)))
-		ctx->large_files--;
+	if (ext2fs_needs_large_file_feature(EXT2_I_SIZE(&inode))) {
+		if (LINUX_S_ISREG(inode.i_mode))
+		    ctx->large_files--;
+		else if (LINUX_S_ISDIR(inode.i_mode))
+		    ctx->large_dirs--;
+	}
 
 	del_block.ctx = ctx;
 	del_block.num = 0;
@@ -1865,6 +1871,7 @@ int e2fsck_process_bad_inode(e2fsck_t ctx, ext2_ino_t dir,
 			not_fixed++;
 	}
 	if (inode.i_size_high && !ext2fs_has_feature_largedir(fs->super) &&
+	    inode.i_blocks < 1ULL << (29 - EXT2_BLOCK_SIZE_BITS(fs->super)) &&
 	    LINUX_S_ISDIR(inode.i_mode)) {
 		if (fix_problem(ctx, PR_2_DIR_SIZE_HIGH_ZERO, &pctx)) {
 			inode.i_size_high = 0;
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 78d66891..011e2c90 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1639,7 +1639,7 @@ static struct e2fsck_problem problem_table[] = {
 	/* Filesystem contains large files, but has no such flag in sb */
 	{ PR_2_FEATURE_LARGE_FILES,
 	  N_("@f contains large files, but lacks LARGE_FILE flag in @S.\n"),
-	  PROMPT_FIX, 0, 0, 0, 0 },
+	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
 
 	/* Node in HTREE directory not referenced */
 	{ PR_2_HTREE_NOTREF,
@@ -1665,6 +1665,11 @@ static struct e2fsck_problem problem_table[] = {
 	{ PR_2_HTREE_CLEAR,
 	  N_("@n @h %d (%q).  "), PROMPT_CLEAR_HTREE, 0, 0, 0, 0 },
 
+	/* Filesystem has large directories, but has no such flag in sb */
+	{ PR_2_FEATURE_LARGE_DIRS,
+	  N_("@f has large directories, but lacks LARGE_DIR flag in @S.\n"),
+	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
+
 	/* Bad block in htree interior node */
 	{ PR_2_HTREE_BADBLK,
 	  N_("@p @h %d (%q): bad @b number %b.\n"),
@@ -1675,7 +1680,7 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Error adjusting refcount for @a @b %b (@i %i): %m\n"),
 	  PROMPT_NONE, PR_FATAL, 0, 0, 0 },
 
-	/* Invalid HTREE root node */
+	/* Problem in HTREE directory inode: root node is invalid */
 	{ PR_2_HTREE_BAD_ROOT,
 	  /* xgettext:no-c-format */
 	  N_("@p @h %d: root node is @n\n"),
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 7a7294dc..4f114a92 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -948,8 +948,8 @@ struct problem_context {
 /* Clear invalid HTREE directory */
 #define PR_2_HTREE_CLEAR	0x020038
 
-/* Clear the htree flag forcibly */
-/* #define PR_2_HTREE_FCLR	0x020039 */
+/* Filesystem has large directories, but has no such flag in superblock */
+#define PR_2_FEATURE_LARGE_DIRS	0x020039
 
 /* Bad block in htree interior node */
 #define PR_2_HTREE_BADBLK	0x02003A
diff --git a/lib/ext2fs/blknum.c b/lib/ext2fs/blknum.c
index ec77a067..ea9b4bd6 100644
--- a/lib/ext2fs/blknum.c
+++ b/lib/ext2fs/blknum.c
@@ -540,18 +540,29 @@ errcode_t ext2fs_inode_size_set(ext2_filsys fs, struct ext2_inode *inode,
 	if (size < 0)
 		return EINVAL;
 
-	/* Only regular files get to be larger than 4GB */
-	if (!LINUX_S_ISREG(inode->i_mode) && (size >> 32))
-		return EXT2_ET_FILE_TOO_BIG;
+	/* If writing a large inode, set the large_file or large_dir flag */
+	if (ext2fs_needs_large_file_feature(size)) {
+		int dirty_sb = 0;
 
-	/* If we're writing a large file, set the large_file flag */
-	if (LINUX_S_ISREG(inode->i_mode) &&
-	    ext2fs_needs_large_file_feature(size) &&
-	    (!ext2fs_has_feature_large_file(fs->super) ||
-	     fs->super->s_rev_level == EXT2_GOOD_OLD_REV)) {
-		ext2fs_set_feature_large_file(fs->super);
-		ext2fs_update_dynamic_rev(fs);
-		ext2fs_mark_super_dirty(fs);
+		if (LINUX_S_ISREG(inode->i_mode)) {
+			if (!ext2fs_has_feature_large_file(fs->super)) {
+				ext2fs_set_feature_large_file(fs->super);
+				dirty_sb = 1;
+			}
+		} else if (LINUX_S_ISDIR(inode->i_mode)) {
+			if (!ext2fs_has_feature_largedir(fs->super)) {
+				ext2fs_set_feature_largedir(fs->super);
+				dirty_sb = 1;
+			}
+		} else {
+			/* Only regular files get to be larger than 4GB */
+			return EXT2_ET_FILE_TOO_BIG;
+		}
+		if (dirty_sb) {
+			if (fs->super->s_rev_level == EXT2_GOOD_OLD_REV)
+				ext2fs_update_dynamic_rev(fs);
+			ext2fs_mark_super_dirty(fs);
+		}
 	}
 
 	inode->i_size = size & 0xffffffff;
diff --git a/lib/ext2fs/expanddir.c b/lib/ext2fs/expanddir.c
index 9f023120..b5d5abd7 100644
--- a/lib/ext2fs/expanddir.c
+++ b/lib/ext2fs/expanddir.c
@@ -129,7 +129,10 @@ errcode_t ext2fs_expand_dir(ext2_filsys fs, ext2_ino_t dir)
 	if (retval)
 		return retval;
 
-	inode.i_size += fs->blocksize;
+	retval = ext2fs_inode_size_set(fs, &inode,
+				       EXT2_I_SIZE(&inode) + fs->blocksize);
+	if (retval)
+		return retval;
 	ext2fs_iblk_add_blocks(fs, &inode, es.newblocks);
 
 	retval = ext2fs_write_inode(fs, dir, &inode);
diff --git a/lib/ext2fs/punch.c b/lib/ext2fs/punch.c
index c704bf32..effa1e2d 100644
--- a/lib/ext2fs/punch.c
+++ b/lib/ext2fs/punch.c
@@ -502,8 +502,8 @@ errcode_t ext2fs_punch(ext2_filsys fs, ext2_ino_t ino,
 		return retval;
 
 #ifdef PUNCH_DEBUG
-	printf("%u: write inode size now %u blocks %u\n",
-		ino, inode->i_size, inode->i_blocks);
+	printf("%u: write inode size now %lu blocks %u\n",
+		ino, EXT2_I_SIZE(inode), inode->i_blocks);
 #endif
 	return ext2fs_write_inode(fs, ino, inode);
 }
diff --git a/lib/ext2fs/res_gdt.c b/lib/ext2fs/res_gdt.c
index 6bcf01e1..fa8d8d6b 100644
--- a/lib/ext2fs/res_gdt.c
+++ b/lib/ext2fs/res_gdt.c
@@ -223,8 +223,8 @@ out_dindir:
 	}
 out_inode:
 #ifdef RES_GDT_DEBUG
-	printf("inode.i_blocks = %u, i_size = %u\n", inode.i_blocks,
-	       inode.i_size);
+	printf("inode.i_blocks = %u, i_size = %lu\n", inode.i_blocks,
+	       EXT2_I_SIZE(&inode));
 #endif
 	if (inode_dirty) {
 		inode.i_atime = inode.i_mtime = fs->now ? fs->now : time(0);
diff --git a/tests/f_recnect_bad/expect.1 b/tests/f_recnect_bad/expect.1
index d4f72a1c..97ffcc52 100644
--- a/tests/f_recnect_bad/expect.1
+++ b/tests/f_recnect_bad/expect.1
@@ -1,11 +1,10 @@
 Pass 1: Checking inodes, blocks, and sizes
+Inode 15, i_size is 51539608576, should be 1024.  Fix? yes
+
 Pass 2: Checking directory structure
 i_faddr for inode 15 (/test/quux) is 23, should be zero.
 Clear? yes
 
-i_size_high for inode 15 (/test/quux) is 12, should be zero.
-Clear? yes
-
 i_file_acl for inode 13 (/test/???) is 12, should be zero.
 Clear? yes
 
-- 
2.25.1

