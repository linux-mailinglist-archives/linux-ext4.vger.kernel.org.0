Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520AC3C5F8D
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhGLPqQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhGLPqL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C67DF1FFBD;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6MbunCDC0mcYrygF8aNRb4BugNufSTyQsaricO3SiM=;
        b=lk1ovGCm67Y6agd9spZ2uxn9MImgCmZLFbA/YIsAJvcevUHYqGHLgEzTdEbnpSjvmzay2R
        PMI5RDRnI4x549d679/+EbVWMJ4IAgeyTDSbL8EHjfnjzYVkb4S8KYSLr3ykpDDSDAJzf8
        8DGKyeY+vPgVWRPcUteIGGqqFTuC/PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6MbunCDC0mcYrygF8aNRb4BugNufSTyQsaricO3SiM=;
        b=0YZmu0uxTzHB+4t/OXuR82BktnNOq3a0BJbQA3tcE+7suCLE9J26KpX09Fbb4hDOW8jw5T
        RgrUFlLNW3YgbkDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B7AF4A3BA7;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9D13D1F2CD6; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/9] e2fsck: Add support for handling orphan file
Date:   Mon, 12 Jul 2021 17:43:12 +0200
Message-Id: <20210712154315.9606-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24088; h=from:subject; bh=1+IP14IZ3VDy9KH85Na9z7NL7Sb9R5Kl4hOl48llGK4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMPpk2/OxVjCfiEThq8r2/TF/dSuyfk+IOUU3Qq NoLoQKKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjDwAKCRCcnaoHP2RA2faoCA Df+1NanWDmREnzor7vQGPHyTC6oNaGYgT2cRT2sW0/9VVsFyOgHaS5KdhZGGufruSt6HSnjVSBUxo4 CrPwjq8cLbKNGdoWN5pSbOn10S69MTkyB1qKF3sj6Fdfce2dKmNZvWB+yhWqXMYFfwpW3S2zavIThY gZNiVuGdji7+liIPFSUYF47Aqp1+zV2rpUPGSqkTVfIGLGayeWt5Vb9mQpDmRV0+BdbLGJS1g2nYbu jWH+cZ+939t/r6jIPIjAmyx1cK/rEf2gcTSzKWF6wLCNxSCauc+AUxtXcBlJTgc9aEJomtQxZBfGqQ s2tHKGkQmGVQR7iLwC0xpp6eMQvyxk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/e2fsck.h  |   1 +
 e2fsck/pass1.c   |  27 ++++
 e2fsck/pass4.c   |   2 +-
 e2fsck/problem.c |  80 +++++++++++
 e2fsck/problem.h |  50 +++++++
 e2fsck/super.c   | 358 +++++++++++++++++++++++++++++++++++++++++------
 e2fsck/unix.c    |  72 +++++++++-
 7 files changed, 546 insertions(+), 44 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 15d043ee4692..979cdfcb2740 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -649,6 +649,7 @@ void sigcatcher_setup(void);
 void check_super_block(e2fsck_t ctx);
 int check_backup_super_block(e2fsck_t ctx);
 void check_resize_inode(e2fsck_t ctx);
+int check_init_orphan_file(e2fsck_t ctx);
 
 /* util.c */
 extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 9d4308956773..b8d8dd109096 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1778,6 +1778,32 @@ void e2fsck_pass1(e2fsck_t ctx)
 							inode_size, "pass1");
 				failed_csum = 0;
 			}
+		} else if (ino == fs->super->s_orphan_file_inum) {
+			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
+			if (ext2fs_has_feature_orphan_file(fs->super)) {
+				if (!LINUX_S_ISREG(inode->i_mode) &&
+				    fix_problem(ctx, PR_1_ORPHAN_FILE_BAD_MODE,
+						&pctx)) {
+					inode->i_mode = LINUX_S_IFREG;
+					e2fsck_write_inode(ctx, ino, inode,
+							   "pass1");
+					failed_csum = 0;
+				}
+				check_blocks(ctx, &pctx, block_buf, NULL);
+				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				continue;
+			}
+			if ((inode->i_links_count ||
+			     inode->i_blocks || inode->i_block[0]) &&
+			    fix_problem(ctx, PR_1_ORPHAN_FILE_NOT_CLEAR,
+					&pctx)) {
+				memset(inode, 0, inode_size);
+				ext2fs_icount_store(ctx->inode_link_info, ino,
+						    0);
+				e2fsck_write_inode_full(ctx, ino, inode,
+							inode_size, "pass1");
+				failed_csum = 0;
+			}
 		} else if (ino < EXT2_FIRST_INODE(fs->super)) {
 			problem_t problem = 0;
 
@@ -3484,6 +3510,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	}
 
 	if (ino != quota_type2inum(PRJQUOTA, fs->super) &&
+	    ino != fs->super->s_orphan_file_inum &&
 	    (ino == EXT2_ROOT_INO || ino >= EXT2_FIRST_INODE(ctx->fs->super)) &&
 	    !(inode->i_flags & EXT4_EA_INODE_FL)) {
 		quota_data_add(ctx->qctx, (struct ext2_inode_large *) inode,
diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
index 8c2d2f1fca12..f41eb849e567 100644
--- a/e2fsck/pass4.c
+++ b/e2fsck/pass4.c
@@ -192,7 +192,7 @@ void e2fsck_pass4(e2fsck_t ctx)
 					goto errout;
 		}
 		if (i == quota_type2inum(PRJQUOTA, ctx->fs->super) ||
-		    i == EXT2_BAD_INO ||
+		    i == fs->super->s_orphan_file_inum || i == EXT2_BAD_INO ||
 		    (i > EXT2_ROOT_INO && i < EXT2_FIRST_INODE(fs->super)))
 			continue;
 		if (!(ext2fs_test_inode_bitmap2(ctx->inode_used_map, i)) ||
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index eb2824f31684..0935fe30fc5b 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -526,6 +526,26 @@ static struct e2fsck_problem problem_table[] = {
 	     "not compatible. Resize @i should be disabled.  "),
 	  PROMPT_FIX, 0, 0, 0, 0 },
 
+	/* Orphan file contains holes */
+	{ PR_0_ORPHAN_FILE_HOLE,
+	  N_("Orphan file (@i %i) contains hole at @b %b. Terminating orphan file recovery.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file block has wrong magic */
+	{ PR_0_ORPHAN_FILE_BAD_MAGIC,
+	  N_("Orphan file (@i %i) @b %b contains wrong magic. Terminating orphan file recovery.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file block has wrong checksum */
+	{ PR_0_ORPHAN_FILE_BAD_CHECKSUM,
+	  N_("Orphan file (@i %i) @b %b contains wrong checksum. Terminating orphan file recovery.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file size isn't multiple of blocks size */
+	{ PR_0_ORPHAN_FILE_WRONG_SIZE,
+	  N_("Orphan file (@i %i) size is not multiple of block size. Terminating orphan file recovery.\n"),
+	  PROMPT_NONE, 0 },
+
 	/* Pass 1 errors */
 
 	/* Pass 1: Checking inodes, blocks, and sizes */
@@ -1280,6 +1300,16 @@ static struct e2fsck_problem problem_table[] = {
 	  PROMPT_CLEAR_HTREE, PR_PREEN_OK, 0, 0, 0 },
 
 
+	/* Orphan file has bad mode */
+	{ PR_1_ORPHAN_FILE_BAD_MODE,
+	  N_("Orphan file @i %i is not regular file.  "),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
+	/* Orphan file inode is not in use, but contains data */
+	{ PR_1_ORPHAN_FILE_NOT_CLEAR,
+	  N_("Orphan file @i %i is not in use, but contains data.  "),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
 	/* Pass 1b errors */
 
 	/* Pass 1B: Rescan for duplicate/bad blocks */
@@ -2259,6 +2289,56 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Error writing quota info for quota type %N: %m\n"),
 	  PROMPT_NULL, 0, 0, 0, 0 },
 
+	/* Orphan file without a journal */
+	{ PR_6_ORPHAN_FILE_WITHOUT_JOURNAL,
+	  N_("@S has orphan file without @j.\n"),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
+	/* Orphan file truncation failed */
+	{ PR_6_ORPHAN_FILE_TRUNC_FAILED,
+	  N_("Failed to truncate orphan file.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Failed to initialize orphan file */
+	{ PR_6_ORPHAN_FILE_CORRUPTED,
+	  N_("Failed to initialize orphan file.\n"),
+	  PROMPT_RECREATE, PR_PREEN_OK },
+
+	/* Cannot fix corrupted orphan file with invalid bitmaps */
+	{ PR_6_ORPHAN_FILE_BITMAP_INVALID,
+	  N_("Cannot fix corrupted orphan file with invalid bitmaps.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file creation failed */
+	{ PR_6_ORPHAN_FILE_CREATE_FAILED,
+	  N_("Failed to truncate orphan file (@i %i).\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file block contains data */
+	{ PR_6_ORPHAN_BLOCK_DIRTY,
+	  N_("Orphan file (@i %i) @b %b is not clean.\n"),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
+	/* orphan_present set but orphan file is empty */
+	{ PR_6_ORPHAN_PRESENT_CLEAN_FILE,
+	  N_("Flag orphan_present is set but orphan file is clean.\n"),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
+	/* orphan_present set but orphan_file is not */
+	{ PR_6_ORPHAN_PRESENT_NO_FILE,
+	  N_("Flag orphan_present is set but flag orphan_file is not.\n"),
+	  PROMPT_CLEAR, PR_PREEN_OK },
+
+	/* Orphan file size isn't multiple of blocks size */
+	{ PR_6_ORPHAN_FILE_WRONG_SIZE,
+	  N_("Orphan file (@i %i) size is not multiple of block size.\n"),
+	  PROMPT_NONE, 0 },
+
+	/* Orphan file contains holes */
+	{ PR_6_ORPHAN_FILE_HOLE,
+	  N_("Orphan file (@i %i) contains hole at @b %b.\n"),
+	  PROMPT_NONE, 0 },
+
 	{ 0 }
 };
 
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 24cdcf9b90f7..0611d71f9e03 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -288,6 +288,18 @@ struct problem_context {
 /* Meta_bg and resize_inode are not compatible, remove resize_inode*/
 #define PR_0_DISABLE_RESIZE_INODE		0x000051
 
+/* Orphan file contains holes */
+#define PR_0_ORPHAN_FILE_HOLE			0x000052
+
+/* Orphan file block has wrong magic */
+#define PR_0_ORPHAN_FILE_BAD_MAGIC		0x000053
+
+/* Orphan file block has wrong checksum */
+#define PR_0_ORPHAN_FILE_BAD_CHECKSUM		0x000054
+
+/* Orphan file size isn't multiple of blocks size */
+#define PR_0_ORPHAN_FILE_WRONG_SIZE		0x000055
+
 /*
  * Pass 1 errors
  */
@@ -717,6 +729,15 @@ struct problem_context {
 #define PR_1_HTREE_CANNOT_SIPHASH		0x01008E
 
 
+/* Orphan file inode is not a regular file */
+#define PR_1_ORPHAN_FILE_BAD_MODE		0x01007F
+
+/* Orphan file inode is not in use, but contains data */
+#define PR_1_ORPHAN_FILE_NOT_CLEAR		0x010080
+
+/* Orphan file inode is not clear */
+#define PR_1_ORPHAN_INODE_NOT_CLEAR		0x01007F
+
 /*
  * Pass 1b errors
  */
@@ -1293,6 +1314,35 @@ struct problem_context {
 /* Error updating quota information */
 #define PR_6_WRITE_QUOTAS		0x060006
 
+/* Orphan file without a journal */
+#define PR_6_ORPHAN_FILE_WITHOUT_JOURNAL	0x060007
+
+/* Orphan file truncation failed */
+#define PR_6_ORPHAN_FILE_TRUNC_FAILED	0x060008
+
+/* Failed to initialize orphan file */
+#define PR_6_ORPHAN_FILE_CORRUPTED	0x060009
+
+/* Cannot fix corrupted orphan file with invalid bitmaps */
+#define PR_6_ORPHAN_FILE_BITMAP_INVALID	0x06000A
+
+/* Orphan file creation failed */
+#define PR_6_ORPHAN_FILE_CREATE_FAILED	0x06000B
+
+/* Orphan file block contains data */
+#define PR_6_ORPHAN_BLOCK_DIRTY		0x06000C
+
+/* orphan_present set but orphan file is empty */
+#define PR_6_ORPHAN_PRESENT_CLEAN_FILE	0x06000D
+
+/* orphan_present set but orphan_file is not */
+#define PR_6_ORPHAN_PRESENT_NO_FILE	0x06000E
+
+/* Orphan file size isn't multiple of blocks size */
+#define PR_6_ORPHAN_FILE_WRONG_SIZE	0x06000F
+
+/* Orphan file contains holes */
+#define PR_6_ORPHAN_FILE_HOLE		0x060010
 
 /*
  * Function declarations
diff --git a/e2fsck/super.c b/e2fsck/super.c
index e1c3f93572f4..cff556e790f8 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -313,6 +313,180 @@ static errcode_t e2fsck_write_all_quotas(e2fsck_t ctx)
 	return pctx.errcode;
 }
 
+static int release_orphan_inode(e2fsck_t ctx, ext2_ino_t *ino, char *block_buf)
+{
+	ext2_filsys fs = ctx->fs;
+	struct problem_context pctx;
+	struct ext2_inode_large inode;
+	ext2_ino_t next_ino;
+
+	e2fsck_read_inode_full(ctx, *ino, EXT2_INODE(&inode),
+				sizeof(inode), "release_orphan_inode");
+	clear_problem_context(&pctx);
+	pctx.ino = *ino;
+	pctx.inode = EXT2_INODE(&inode);
+	pctx.str = inode.i_links_count ? _("Truncating") : _("Clearing");
+
+	fix_problem(ctx, PR_0_ORPHAN_CLEAR_INODE, &pctx);
+
+	next_ino = inode.i_dtime;
+	if (next_ino &&
+	    ((next_ino < EXT2_FIRST_INODE(fs->super)) ||
+	     (next_ino > fs->super->s_inodes_count))) {
+		pctx.ino = next_ino;
+		fix_problem(ctx, PR_0_ORPHAN_ILLEGAL_INODE, &pctx);
+		return 1;
+	}
+
+	if (release_inode_blocks(ctx, *ino, &inode, block_buf, &pctx))
+		return 1;
+
+	if (!inode.i_links_count) {
+		if (ctx->qctx)
+			quota_data_inodes(ctx->qctx, &inode, *ino, -1);
+		ext2fs_inode_alloc_stats2(fs, *ino, -1,
+					  LINUX_S_ISDIR(inode.i_mode));
+		ctx->free_inodes++;
+		inode.i_dtime = ctx->now;
+	} else {
+		inode.i_dtime = 0;
+	}
+	e2fsck_write_inode_full(ctx, *ino, EXT2_INODE(&inode),
+				sizeof(inode), "delete_file");
+	*ino = next_ino;
+	return 0;
+}
+
+struct process_orphan_block_data {
+	e2fsck_t 	ctx;
+	char 		*buf;
+	char		*block_buf;
+	e2_blkcnt_t	blocks;
+	int		abort;
+	int		clear;
+	errcode_t	errcode;
+	ext2_ino_t	ino;
+	__u32		generation;
+};
+
+static int process_orphan_block(ext2_filsys fs,
+			       blk64_t	*block_nr,
+			       e2_blkcnt_t blockcnt,
+			       blk64_t	ref_blk EXT2FS_ATTR((unused)),
+			       int	ref_offset EXT2FS_ATTR((unused)),
+			       void *priv_data)
+{
+	struct process_orphan_block_data *pd;
+	e2fsck_t 		ctx;
+	struct problem_context	pctx;
+	blk64_t			blk = *block_nr;
+	struct ext4_orphan_block_tail *tail;
+	int			j;
+	int			inodes_per_ob;
+	__u32			*bdata;
+	ext2_ino_t		ino;
+
+	pd = priv_data;
+	ctx = pd->ctx;
+	clear_problem_context(&pctx);
+	pctx.ino = fs->super->s_orphan_file_inum;
+	pctx.blk = blockcnt;
+
+	/* Orphan file must not have holes */
+	if (!blk) {
+		if (blockcnt == pd->blocks)
+			return BLOCK_ABORT;
+		fix_problem(ctx, PR_0_ORPHAN_FILE_HOLE, &pctx);
+return_abort:
+		pd->abort = 1;
+		return BLOCK_ABORT;
+	}
+	inodes_per_ob = ext2fs_inodes_per_orphan_block(fs);
+	pd->errcode = io_channel_read_blk64(fs->io, blk, 1, pd->buf);
+	if (pd->errcode)
+		goto return_abort;
+	tail = ext2fs_orphan_block_tail(fs, pd->buf);
+	if (ext2fs_le32_to_cpu(tail->ob_magic) !=
+	    EXT4_ORPHAN_BLOCK_MAGIC) {
+		fix_problem(ctx, PR_0_ORPHAN_FILE_BAD_MAGIC, &pctx);
+		goto return_abort;
+	}
+	if (!ext2fs_orphan_file_block_csum_verify(fs,
+			fs->super->s_orphan_file_inum, blk, pd->buf)) {
+		fix_problem(ctx, PR_0_ORPHAN_FILE_BAD_CHECKSUM, &pctx);
+		goto return_abort;
+	}
+	bdata = (__u32 *)pd->buf;
+	for (j = 0; j < inodes_per_ob; j++) {
+		if (!bdata[j])
+			continue;
+		ino = ext2fs_le32_to_cpu(bdata[j]);
+		if (release_orphan_inode(ctx, &ino, pd->block_buf))
+			goto return_abort;
+	}
+	return 0;
+}
+
+static int process_orphan_file(e2fsck_t ctx, char *block_buf)
+{
+	ext2_filsys fs = ctx->fs;
+	char *orphan_buf;
+	struct process_orphan_block_data pd;
+	int ret = 0;
+	ext2_ino_t orphan_inum = fs->super->s_orphan_file_inum;
+	struct ext2_inode orphan_inode;
+	struct problem_context	pctx;
+	errcode_t retval;
+
+	if (!ext2fs_has_feature_orphan_file(fs->super))
+		return 0;
+
+	clear_problem_context(&pctx);
+	pctx.ino = orphan_inum;
+
+	orphan_buf = (char *) e2fsck_allocate_memory(ctx, fs->blocksize * 4,
+						    "orphan block buffer");
+	retval = ext2fs_read_inode(fs, orphan_inum, &orphan_inode);
+	if (retval < 0) {
+		com_err("process_orphan_file", retval,
+			_("while reading inode %d"), orphan_inum);
+		ret = 1;
+		goto out;
+	}
+	if (EXT2_I_SIZE(&orphan_inode) & (fs->blocksize - 1)) {
+		fix_problem(ctx, PR_0_ORPHAN_FILE_WRONG_SIZE, &pctx);
+		ret = 1;
+		goto out;
+	}
+	pd.buf = orphan_buf + 3 * fs->blocksize;
+	pd.block_buf = block_buf;
+	pd.blocks = EXT2_I_SIZE(&orphan_inode) / fs->blocksize;
+	pd.ctx = ctx;
+	pd.abort = 0;
+	pd.errcode = 0;
+	retval = ext2fs_block_iterate3(fs, orphan_inum,
+				       BLOCK_FLAG_DATA_ONLY | BLOCK_FLAG_HOLE,
+				       orphan_buf, process_orphan_block, &pd);
+	if (retval) {
+		com_err("process_orphan_block", retval,
+			_("while calling ext2fs_block_iterate for inode %d"),
+			orphan_inum);
+		ret = 1;
+		goto out;
+	}
+	if (pd.abort) {
+		if (pd.errcode) {
+			com_err("process_orphan_block", pd.errcode,
+				_("while reading blocks of inode %d"),
+				orphan_inum);
+		}
+		ret = 1;
+	}
+out:
+	ext2fs_free_mem(&orphan_buf);
+	return ret;
+}
+
 /*
  * This function releases all of the orphan inodes.  It returns 1 if
  * it hit some error, and 0 on success.
@@ -325,10 +499,13 @@ static int release_orphan_inodes(e2fsck_t ctx)
 	struct problem_context pctx;
 	char *block_buf;
 
-	if ((ino = fs->super->s_last_orphan) == 0)
+	if (fs->super->s_last_orphan == 0 &&
+	    !ext2fs_has_feature_orphan_present(fs->super))
 		return 0;
 
 	clear_problem_context(&pctx);
+	ino = fs->super->s_last_orphan;
+	pctx.ino = ino;
 	pctx.errcode = e2fsck_read_all_quotas(ctx);
 	if (pctx.errcode) {
 		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
@@ -343,9 +520,10 @@ static int release_orphan_inodes(e2fsck_t ctx)
 	ext2fs_mark_super_dirty(fs);
 
 	/*
-	 * If the filesystem contains errors, don't run the orphan
-	 * list, since the orphan list can't be trusted; and we're
-	 * going to be running a full e2fsck run anyway...
+	 * If the filesystem contains errors, don't process the orphan list
+	 * or orphan file, since neither can be trusted; and we're going to
+	 * be running a full e2fsck run anyway... We clear orphan file contents
+	 * after filesystem is checked to avoid clearing someone else's data.
 	 */
 	if (fs->super->s_state & EXT2_ERROR_FS) {
 		if (ctx->qctx)
@@ -353,10 +531,8 @@ static int release_orphan_inodes(e2fsck_t ctx)
 		return 0;
 	}
 
-	if ((ino < EXT2_FIRST_INODE(fs->super)) ||
-	    (ino > fs->super->s_inodes_count)) {
-		clear_problem_context(&pctx);
-		pctx.ino = ino;
+	if (ino && ((ino < EXT2_FIRST_INODE(fs->super)) ||
+	    (ino > fs->super->s_inodes_count))) {
 		fix_problem(ctx, PR_0_ORPHAN_ILLEGAL_HEAD_INODE, &pctx);
 		goto err_qctx;
 	}
@@ -365,43 +541,19 @@ static int release_orphan_inodes(e2fsck_t ctx)
 						    "block iterate buffer");
 	e2fsck_read_bitmaps(ctx);
 
+	/* First process orphan list */
 	while (ino) {
-		e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
-				sizeof(inode), "release_orphan_inodes");
-		clear_problem_context(&pctx);
-		pctx.ino = ino;
-		pctx.inode = EXT2_INODE(&inode);
-		pctx.str = inode.i_links_count ? _("Truncating") :
-			_("Clearing");
-
-		fix_problem(ctx, PR_0_ORPHAN_CLEAR_INODE, &pctx);
-
-		next_ino = inode.i_dtime;
-		if (next_ino &&
-		    ((next_ino < EXT2_FIRST_INODE(fs->super)) ||
-		     (next_ino > fs->super->s_inodes_count))) {
-			pctx.ino = next_ino;
-			fix_problem(ctx, PR_0_ORPHAN_ILLEGAL_INODE, &pctx);
+		if (release_orphan_inode(ctx, &ino, block_buf))
 			goto err_buf;
-		}
+	}
 
-		if (release_inode_blocks(ctx, ino, &inode, block_buf, &pctx))
-			goto err_buf;
+	/* Next process orphan file */
+	if (ext2fs_has_feature_orphan_present(fs->super) &&
+	    !ext2fs_has_feature_orphan_file(fs->super))
+		goto err_buf;
+	if (process_orphan_file(ctx, block_buf))
+		goto err_buf;
 
-		if (!inode.i_links_count) {
-			if (ctx->qctx)
-				quota_data_inodes(ctx->qctx, &inode, ino, -1);
-			ext2fs_inode_alloc_stats2(fs, ino, -1,
-						  LINUX_S_ISDIR(inode.i_mode));
-			ctx->free_inodes++;
-			inode.i_dtime = ctx->now;
-		} else {
-			inode.i_dtime = 0;
-		}
-		e2fsck_write_inode_full(ctx, ino, EXT2_INODE(&inode),
-				sizeof(inode), "delete_file");
-		ino = next_ino;
-	}
 	ext2fs_free_mem(&block_buf);
 	pctx.errcode = e2fsck_write_all_quotas(ctx);
 	if (pctx.errcode)
@@ -416,6 +568,130 @@ err:
 	return 1;
 }
 
+static int reinit_orphan_block(ext2_filsys fs,
+			       blk64_t	*block_nr,
+			       e2_blkcnt_t blockcnt,
+			       blk64_t	ref_blk EXT2FS_ATTR((unused)),
+			       int	ref_offset EXT2FS_ATTR((unused)),
+			       void *priv_data)
+{
+	struct process_orphan_block_data *pd;
+	e2fsck_t 		ctx;
+	blk64_t			blk = *block_nr;
+	struct problem_context	pctx;
+	struct ext4_orphan_block_tail *tail;
+
+	pd = priv_data;
+	ctx = pd->ctx;
+	tail = ext2fs_orphan_block_tail(fs, pd->buf);
+
+	/* Orphan file must not have holes */
+	if (!blk) {
+		if (blockcnt == pd->blocks)
+			return BLOCK_ABORT;
+
+		clear_problem_context(&pctx);
+		pctx.ino = fs->super->s_orphan_file_inum;
+		pctx.blk = blockcnt;
+		fix_problem(ctx, PR_6_ORPHAN_FILE_HOLE, &pctx);
+return_abort:
+		pd->abort = 1;
+		return BLOCK_ABORT;
+	}
+	/*
+	 * Update checksum to match expected buffer contents with appropriate
+	 * block number.
+	 */
+	tail->ob_checksum = ext2fs_do_orphan_file_block_csum(fs, pd->ino,
+						pd->generation, blk, pd->buf);
+	if (!pd->clear) {
+		pd->errcode = io_channel_read_blk64(fs->io, blk, 1,
+						    pd->block_buf);
+		/* Block is already cleanly initialized? */
+		if (!memcmp(pd->block_buf, pd->buf, fs->blocksize))
+			return 0;
+
+		clear_problem_context(&pctx);
+		pctx.ino = fs->super->s_orphan_file_inum;
+		pctx.blk = blockcnt;
+		if (!fix_problem(ctx, PR_6_ORPHAN_BLOCK_DIRTY, &pctx))
+			goto return_abort;
+		pd->clear = 1;
+	}
+	pd->errcode = io_channel_write_blk64(fs->io, blk, 1, pd->buf);
+	if (pd->errcode)
+		goto return_abort;
+	return 0;
+}
+
+/*
+ * Check and clear orphan file. We just return non-zero if we hit some
+ * inconsistency. Caller will truncate & recreate new orphan file.
+ */
+int check_init_orphan_file(e2fsck_t ctx)
+{
+	ext2_filsys fs = ctx->fs;
+	char *orphan_buf;
+	struct process_orphan_block_data pd;
+	struct ext4_orphan_block_tail *tail;
+	ext2_ino_t orphan_inum = fs->super->s_orphan_file_inum;
+	struct ext2_inode orphan_inode;
+	int ret = 0;
+	errcode_t retval;
+
+	orphan_buf = (char *) e2fsck_allocate_memory(ctx, fs->blocksize * 5,
+						    "orphan block buffer");
+	e2fsck_read_inode(ctx, orphan_inum, &orphan_inode, "orphan inode");
+	if (EXT2_I_SIZE(&orphan_inode) & (fs->blocksize - 1)) {
+		struct problem_context	pctx;
+
+		clear_problem_context(&pctx);
+		pctx.ino = orphan_inum;
+		fix_problem(ctx, PR_6_ORPHAN_FILE_WRONG_SIZE, &pctx);
+		ret = 1;
+		goto out;
+	}
+	pd.buf = orphan_buf + 3 * fs->blocksize;
+	pd.block_buf = orphan_buf + 4 * fs->blocksize;
+	pd.blocks = EXT2_I_SIZE(&orphan_inode) / fs->blocksize;
+	pd.ctx = ctx;
+	pd.abort = 0;
+	pd.clear = 0;
+	pd.errcode = 0;
+	pd.ino = orphan_inum;
+	pd.generation = orphan_inode.i_generation;
+	/* Initialize buffer to write */
+	memset(pd.buf, 0, fs->blocksize);
+	tail = ext2fs_orphan_block_tail(fs, pd.buf);
+	tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
+
+	retval = ext2fs_block_iterate3(fs, orphan_inum,
+				       BLOCK_FLAG_DATA_ONLY | BLOCK_FLAG_HOLE,
+				       orphan_buf, reinit_orphan_block, &pd);
+	if (retval) {
+		com_err("reinit_orphan_block", retval,
+			_("while calling ext2fs_block_iterate for inode %d"),
+			orphan_inum);
+		ret = 1;
+		goto out;
+	}
+	if (pd.abort) {
+		if (pd.errcode) {
+			com_err("process_orphan_block", pd.errcode,
+				_("while reading blocks of inode %d"),
+				orphan_inum);
+		}
+		ret = 1;
+	}
+
+	/* We had to clear some blocks. Report it up. */
+	if (ret == 0 && pd.clear)
+		ret = 2;
+out:
+	ext2fs_free_mem(&orphan_buf);
+	return ret;
+}
+
 /*
  * Check the resize inode to make sure it is sane.  We check both for
  * the case where on-line resizing is not enabled (in which case the
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index c5f9e4415f8f..bf9b0bf2ecb8 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1945,15 +1945,82 @@ print_unsupp_features:
 				_("\n*** journal has been regenerated ***\n"));
 		}
 	}
-no_journal:
 
+no_journal:
 	if (run_result & E2F_FLAG_ABORT) {
 		fatal_error(ctx, _("aborted"));
 	} else if (run_result & E2F_FLAG_CANCEL) {
 		log_out(ctx, _("%s: e2fsck canceled.\n"), ctx->device_name ?
 			ctx->device_name : ctx->filesystem_name);
 		exit_value |= FSCK_CANCELED;
-	} else if (ctx->qctx && !ctx->invalid_bitmaps) {
+		goto cleanup;
+	}
+
+	if (ext2fs_has_feature_orphan_file(fs->super)) {
+		int ret;
+
+		/* No point in orphan file without a journal... */
+		if (!ext2fs_has_feature_journal(fs->super) &&
+		    fix_problem(ctx, PR_6_ORPHAN_FILE_WITHOUT_JOURNAL, &pctx)) {
+			retval = ext2fs_truncate_orphan_file(fs);
+			if (retval) {
+				/* Huh, failed to delete file */
+				fix_problem(ctx, PR_6_ORPHAN_FILE_TRUNC_FAILED,
+					    &pctx);
+				goto check_quotas;
+			}
+			ext2fs_clear_feature_orphan_file(fs->super);
+			ext2fs_mark_super_dirty(fs);
+			goto check_quotas;
+		}
+		ret = check_init_orphan_file(ctx);
+		if (ret == 2 ||
+		    (ret == 0 && ext2fs_has_feature_orphan_present(fs->super) &&
+		     fix_problem(ctx, PR_6_ORPHAN_PRESENT_CLEAN_FILE, &pctx))) {
+			ext2fs_clear_feature_orphan_present(fs->super);
+			ext2fs_mark_super_dirty(fs);
+		} else if (ret == 1 &&
+		    fix_problem(ctx, PR_6_ORPHAN_FILE_CORRUPTED, &pctx)) {
+			int orphan_file_blocks;
+
+			if (ctx->invalid_bitmaps) {
+				fix_problem(ctx,
+					    PR_6_ORPHAN_FILE_BITMAP_INVALID,
+					    &pctx);
+				goto check_quotas;
+			}
+
+			retval = ext2fs_truncate_orphan_file(fs);
+			if (retval) {
+				/* Huh, failed to truncate file */
+				fix_problem(ctx, PR_6_ORPHAN_FILE_TRUNC_FAILED,
+					    &pctx);
+				goto check_quotas;
+			}
+
+			orphan_file_blocks =
+				ext2fs_default_orphan_file_blocks(fs);
+			log_out(ctx, _("Creating orphan file (%d blocks): "),
+				orphan_file_blocks);
+			fflush(stdout);
+			retval = ext2fs_create_orphan_file(fs,
+							   orphan_file_blocks);
+			if (retval) {
+				log_out(ctx, "%s: while trying to create "
+					"orphan file\n", error_message(retval));
+				fix_problem(ctx, PR_6_ORPHAN_FILE_CREATE_FAILED,
+					    &pctx);
+				goto check_quotas;
+			}
+			log_out(ctx, "%s", _(" Done.\n"));
+		}
+	} else if (ext2fs_has_feature_orphan_present(fs->super) &&
+		   fix_problem(ctx, PR_6_ORPHAN_PRESENT_NO_FILE, &pctx)) {
+			ext2fs_clear_feature_orphan_present(fs->super);
+			ext2fs_mark_super_dirty(fs);
+	}
+check_quotas:
+	if (ctx->qctx && !ctx->invalid_bitmaps) {
 		int needs_writeout;
 
 		for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
@@ -1988,6 +2055,7 @@ no_journal:
 		goto restart;
 	}
 
+cleanup:
 #ifdef MTRACE
 	mtrace_print("Cleanup");
 #endif
-- 
2.26.2

