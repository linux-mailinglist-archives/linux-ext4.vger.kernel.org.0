Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C033C5F8C
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhGLPqP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhGLPqL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B68D022136;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZczAnmT3HWq5xEn+OQbGrFJ6cI12YlKcXoHr3Sm4y4=;
        b=bZUMMdN4MIIBXdEVTT4m6WZUeF6coBoA1BC+ZzVnbGNVFSRFKtRGDQw+9tfmXVnvL0kE/S
        909ikQphLiABhNblbKvrw27jCWqL1XkEy10wDY+OySQQpLJh7JIPIAVwjdCL4iu42ZhK82
        iYJulL6oBtdaPnuWfGpn9Y1ewY2yiY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZczAnmT3HWq5xEn+OQbGrFJ6cI12YlKcXoHr3Sm4y4=;
        b=CPm5BXLgnqMMclvMM+VYlVmxGub52MBg5KsTh2WOWySTIRxZD/kBxhP9FllD7WJ3HbJTKu
        q0hVexIvy+MLekDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A4E64A3BA4;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 948141F2CD2; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/9] libext2fs: Support for orphan file feature
Date:   Mon, 12 Jul 2021 17:43:10 +0200
Message-Id: <20210712154315.9606-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17284; h=from:subject; bh=TAVMfyd9uOf8v9KgGFjlnLi+ZFtI8xMFWAp5ZvjaUyM=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBLeJPNFdJ51nMY5uV2xxUbHd55+YsKF11dvORh7VLyMZowv 3Z3SyWjMwsDIwSArpsiyOvKi9rV5Rl1bQzVkYAaxMoFMYeDiFICJnH7JwXAnSWqJTfJS1mdmLv90HP cEX5V5Jjfn2KOpnIlvS/Y95Kzaq9iavb/Adn0js5p2+dLSiismKbeLc/d5a5sGPfsrzZ175d/S3d87 JoWw/urte7nSUYfvmRtX9s3/tQk6b7MSRE3W/z/PmPtRZdbWAL8l5/4VbqqbXnX5Glf34uZVCcFBre Kv1/rvN9L6VNDiXbhYIMqbaZecLSPfiXfH5dXvCckktS5mmpp4rsJG+kbqr4Pn+oNM3kc1TsiYer7K dfIjRcn9XyyjfqfnzbOPNUm5qR0R76Kg+nfe8l/6WnOtZ89i/MFzUs+ufqrxbbUF0l3uHJwCuk+alz RGdLR99o6RkLvy+aWe+d67djmrAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add support for creating and deleting orphan file and a couple of
utility functions that will be used in other tools.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/e2p/feature.c           |   4 +
 lib/ext2fs/Makefile.in      |   2 +
 lib/ext2fs/ext2_fs.h        |  16 ++-
 lib/ext2fs/ext2fs.h         |  36 ++++-
 lib/ext2fs/orphan.c         | 272 ++++++++++++++++++++++++++++++++++++
 lib/ext2fs/swapfs.c         |   3 +-
 lib/ext2fs/tst_super_size.c |   3 +-
 lib/support/mkquota.c       |   3 +-
 8 files changed, 331 insertions(+), 8 deletions(-)
 create mode 100644 lib/ext2fs/orphan.c

diff --git a/lib/e2p/feature.c b/lib/e2p/feature.c
index 2291060214ff..29b7b1512400 100644
--- a/lib/e2p/feature.c
+++ b/lib/e2p/feature.c
@@ -49,6 +49,8 @@ static struct feature feature_list[] = {
 			"fast_commit" },
 	{	E2P_FEATURE_COMPAT, EXT4_FEATURE_COMPAT_STABLE_INODES,
 			"stable_inodes" },
+	{	E2P_FEATURE_COMPAT, EXT4_FEATURE_COMPAT_ORPHAN_FILE,
+			"orphan_file" },
 
 	{	E2P_FEATURE_RO_INCOMPAT, EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER,
 			"sparse_super" },
@@ -80,6 +82,8 @@ static struct feature feature_list[] = {
 			"shared_blocks"},
 	{	E2P_FEATURE_RO_INCOMPAT, EXT4_FEATURE_RO_COMPAT_VERITY,
 			"verity"},
+	{	E2P_FEATURE_RO_INCOMPAT, EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT,
+			"orphan_present" },
 
 	{	E2P_FEATURE_INCOMPAT, EXT2_FEATURE_INCOMPAT_COMPRESSION,
 			"compression" },
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index 5d9af86e520b..ffbfd7a7fc33 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -115,6 +115,7 @@ OBJS= $(DEBUGFS_LIB_OBJS) $(RESIZE_LIB_OBJS) $(E2IMAGE_LIB_OBJS) \
 	newdir.o \
 	nls_utf8.o \
 	openfs.o \
+	orphan.o \
 	progress.o \
 	punch.o \
 	qcow2.o \
@@ -198,6 +199,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/newdir.c \
 	$(srcdir)/nls_utf8.c \
 	$(srcdir)/openfs.c \
+	$(srcdir)/orphan.c \
 	$(srcdir)/progress.c \
 	$(srcdir)/punch.c \
 	$(srcdir)/qcow2.c \
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 6f1d5db4b482..00809e7b92be 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -761,7 +761,8 @@ struct ext2_super_block {
 	__u8    s_last_error_errcode;
 /*27c*/ __le16	s_encoding;		/* Filename charset encoding */
 	__le16	s_encoding_flags;	/* Filename charset encoding flags */
-	__le32	s_reserved[95];		/* Padding to the end of the block */
+	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
+	__le32	s_reserved[94];		/* Padding to the end of the block */
 /*3fc*/	__u32	s_checksum;		/* crc32c(superblock) */
 };
 
@@ -816,7 +817,7 @@ struct ext2_super_block {
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
 #define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
-
+#define EXT4_FEATURE_COMPAT_ORPHAN_FILE		0x1000
 
 #define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
@@ -825,6 +826,7 @@ struct ext2_super_block {
 #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
 #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
 #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
+#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080
 #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
 #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
 /*
@@ -918,6 +920,7 @@ EXT4_FEATURE_COMPAT_FUNCS(exclude_bitmap,	2, EXCLUDE_BITMAP)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	4, SPARSE_SUPER2)
 EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		4, FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	4, STABLE_INODES)
+EXT4_FEATURE_COMPAT_FUNCS(orphan_file,		4, ORPHAN_FILE)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	2, SPARSE_SUPER)
 EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	2, LARGE_FILE)
@@ -933,6 +936,7 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(readonly,		4, READONLY)
 EXT4_FEATURE_RO_COMPAT_FUNCS(project,		4, PROJECT)
 EXT4_FEATURE_RO_COMPAT_FUNCS(shared_blocks,	4, SHARED_BLOCKS)
 EXT4_FEATURE_RO_COMPAT_FUNCS(verity,		4, VERITY)
+EXT4_FEATURE_RO_COMPAT_FUNCS(orphan_present,	4, ORPHAN_PRESENT)
 
 EXT4_FEATURE_INCOMPAT_FUNCS(compression,	2, COMPRESSION)
 EXT4_FEATURE_INCOMPAT_FUNCS(filetype,		2, FILETYPE)
@@ -1100,6 +1104,14 @@ static inline unsigned int ext2fs_dir_rec_len(__u8 name_len,
 	return rec_len;
 }
 
+#define EXT4_ORPHAN_BLOCK_MAGIC 0x0b10ca04
+
+/* Structure at the tail of orphan block */
+struct ext4_orphan_block_tail {
+	__u32 ob_magic;
+	__u32 ob_checksum;
+};
+
 /*
  * Constants for ext4's extended time encoding
  */
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index df150f0003f2..b5648004965a 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -620,7 +620,8 @@ typedef struct ext2_icount *ext2_icount_t;
 					 EXT2_FEATURE_COMPAT_EXT_ATTR|\
 					 EXT4_FEATURE_COMPAT_SPARSE_SUPER2|\
 					 EXT4_FEATURE_COMPAT_FAST_COMMIT|\
-					 EXT4_FEATURE_COMPAT_STABLE_INODES)
+					 EXT4_FEATURE_COMPAT_STABLE_INODES|\
+					 EXT4_FEATURE_COMPAT_ORPHAN_FILE)
 
 #ifdef CONFIG_MMP
 #define EXT4_LIB_INCOMPAT_MMP		EXT4_FEATURE_INCOMPAT_MMP
@@ -655,7 +656,8 @@ typedef struct ext2_icount *ext2_icount_t;
 					 EXT4_FEATURE_RO_COMPAT_READONLY |\
 					 EXT4_FEATURE_RO_COMPAT_PROJECT |\
 					 EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS |\
-					 EXT4_FEATURE_RO_COMPAT_VERITY)
+					 EXT4_FEATURE_RO_COMPAT_VERITY |\
+					 EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT)
 
 /*
  * These features are only allowed if EXT2_FLAG_SOFTSUPP_FEATURES is passed
@@ -1687,6 +1689,19 @@ errcode_t ext2fs_get_data_io(ext2_filsys fs, io_channel *old_io);
 errcode_t ext2fs_set_data_io(ext2_filsys fs, io_channel new_io);
 errcode_t ext2fs_rewrite_to_io(ext2_filsys fs, io_channel new_io);
 
+/* orphan.c */
+extern errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks);
+extern errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs);
+extern e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs);
+extern __u32 ext2fs_do_orphan_file_block_csum(ext2_filsys fs, ext2_ino_t ino,
+					      __u32 gen, blk64_t blk,
+					      char *buf);
+extern errcode_t ext2fs_orphan_file_block_csum_set(ext2_filsys fs,
+						   ext2_ino_t ino, blk64_t blk,
+						   char *buf);
+extern int ext2fs_orphan_file_block_csum_verify(ext2_filsys fs, ext2_ino_t ino,
+						blk64_t blk, char *buf);
+
 /* get_pathname.c */
 extern errcode_t ext2fs_get_pathname(ext2_filsys fs, ext2_ino_t dir, ext2_ino_t ino,
 			       char **name);
@@ -1840,7 +1855,9 @@ extern int ext2fs_dirent_file_type(const struct ext2_dir_entry *entry);
 extern void ext2fs_dirent_set_file_type(struct ext2_dir_entry *entry, int type);
 extern struct ext2_inode *ext2fs_inode(struct ext2_inode_large * large_inode);
 extern const struct ext2_inode *ext2fs_const_inode(const struct ext2_inode_large * large_inode);
-
+extern int ext2fs_inodes_per_orphan_block(ext2_filsys fs);
+extern struct ext4_orphan_block_tail *ext2fs_orphan_block_tail(ext2_filsys fs,
+							       char *buf);
 #endif
 
 /*
@@ -2150,6 +2167,19 @@ ext2fs_const_inode(const struct ext2_inode_large * large_inode)
 	return (const struct ext2_inode *) large_inode;
 }
 
+_INLINE_ int ext2fs_inodes_per_orphan_block(ext2_filsys fs)
+{
+	return (fs->blocksize - sizeof(struct ext4_orphan_block_tail)) /
+		sizeof(__u32);
+}
+
+_INLINE_ struct ext4_orphan_block_tail *
+ext2fs_orphan_block_tail(ext2_filsys fs, char *buf)
+{
+	return (struct ext4_orphan_block_tail *)(buf + fs->blocksize -
+		sizeof(struct ext4_orphan_block_tail));
+}
+
 #undef _INLINE_
 #endif
 
diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
new file mode 100644
index 000000000000..fde1e347fcc9
--- /dev/null
+++ b/lib/ext2fs/orphan.c
@@ -0,0 +1,272 @@
+/*
+ * orphan.c --- utility function to handle orphan file
+ *
+ * Copyright (C) 2015 Jan Kara.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Library
+ * General Public License, version 2.
+ * %End-Header%
+ */
+
+#include "config.h"
+#include <string.h>
+
+#include "ext2_fs.h"
+#include "ext2fsP.h"
+
+errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs)
+{
+	struct ext2_inode inode;
+	errcode_t err;
+	ext2_ino_t ino = fs->super->s_orphan_file_inum;
+
+	err = ext2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return err;
+
+	err = ext2fs_punch(fs, ino, &inode, NULL, 0, ~0ULL);
+	if (err)
+		return err;
+
+	fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+	memset(&inode, 0, sizeof(struct ext2_inode));
+	err = ext2fs_write_inode(fs, ino, &inode);
+
+	ext2fs_clear_feature_orphan_file(fs->super);
+	ext2fs_clear_feature_orphan_present(fs->super);
+	ext2fs_mark_super_dirty(fs);
+	/* Need to update group descriptors as well */
+	fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+
+	return err;
+}
+
+__u32 ext2fs_do_orphan_file_block_csum(ext2_filsys fs, ext2_ino_t ino,
+				       __u32 gen, blk64_t blk, char *buf)
+{
+	int inodes_per_ob = ext2fs_inodes_per_orphan_block(fs);
+	__u32 crc;
+
+	ino = ext2fs_cpu_to_le32(ino);
+	gen = ext2fs_cpu_to_le32(gen);
+	blk = ext2fs_cpu_to_le64(blk);
+	crc = ext2fs_crc32c_le(fs->csum_seed, (unsigned char *)&ino,
+			       sizeof(ino));
+	crc = ext2fs_crc32c_le(crc, (unsigned char *)&gen, sizeof(gen));
+	crc = ext2fs_crc32c_le(crc, (unsigned char *)&blk, sizeof(blk));
+	crc = ext2fs_crc32c_le(crc, buf, inodes_per_ob * sizeof(__u32));
+
+	return ext2fs_cpu_to_le32(crc);
+}
+
+struct mkorphan_info {
+	char *buf;
+	char *zerobuf;
+	blk_t num_blocks;
+	blk_t alloc_blocks;
+	blk64_t last_blk;
+	errcode_t err;
+	ino_t ino;
+	__u32 generation;
+};
+
+static int mkorphan_proc(ext2_filsys	fs,
+			 blk64_t	*blocknr,
+			 e2_blkcnt_t	blockcnt,
+			 blk64_t	ref_block EXT2FS_ATTR((unused)),
+			 int		ref_offset EXT2FS_ATTR((unused)),
+			 void		*priv_data)
+{
+	struct mkorphan_info *oi = (struct mkorphan_info *)priv_data;
+	blk64_t new_blk;
+	errcode_t err;
+
+	/* Can we just continue in currently allocated cluster? */
+	if (blockcnt &&
+	    EXT2FS_B2C(fs, oi->last_blk) == EXT2FS_B2C(fs, oi->last_blk + 1)) {
+		new_blk = oi->last_blk + 1;
+	} else {
+		err = ext2fs_new_block2(fs, oi->last_blk, 0, &new_blk);
+		if (err) {
+			oi->err = err;
+			return BLOCK_ABORT;
+		}
+		ext2fs_block_alloc_stats2(fs, new_blk, +1);
+		oi->alloc_blocks++;
+	}
+	if (blockcnt >= 0) {
+		if (ext2fs_has_feature_metadata_csum(fs->super)) {
+			struct ext4_orphan_block_tail *tail;
+
+			tail = ext2fs_orphan_block_tail(fs, oi->buf);
+			tail->ob_checksum = ext2fs_do_orphan_file_block_csum(fs,
+				oi->ino, oi->generation, new_blk, oi->buf); 
+		}
+		err = io_channel_write_blk64(fs->io, new_blk, 1, oi->buf);
+	} else	/* zerobuf is used to initialize new indirect blocks... */
+		err = io_channel_write_blk64(fs->io, new_blk, 1, oi->zerobuf);
+	if (err) {
+		oi->err = err;
+		return BLOCK_ABORT;
+	}
+	oi->last_blk = new_blk;
+	*blocknr = new_blk;
+	if (blockcnt >= 0 && --oi->num_blocks == 0)
+		return BLOCK_CHANGED | BLOCK_ABORT;
+	return BLOCK_CHANGED;
+}
+
+errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
+{
+	struct ext2_inode inode;
+	ext2_ino_t ino = fs->super->s_orphan_file_inum;
+	errcode_t err;
+	char *buf = NULL, *zerobuf = NULL;
+	struct mkorphan_info oi;
+	struct ext4_orphan_block_tail *ob_tail;
+
+	if (!ino) {
+		err = ext2fs_new_inode(fs, EXT2_ROOT_INO, LINUX_S_IFREG | 0600,
+				       0, &ino);
+		if (err)
+			return err;
+		ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
+		ext2fs_mark_ib_dirty(fs);
+	}
+
+	err = ext2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return err;
+	if (EXT2_I_SIZE(&inode)) {
+		err = ext2fs_truncate_orphan_file(fs);
+		if (err)
+			return err;
+	}
+
+	memset(&inode, 0, sizeof(struct ext2_inode));
+	if (ext2fs_has_feature_extents(fs->super)) {
+		inode.i_flags |= EXT4_EXTENTS_FL;
+		err = ext2fs_write_inode(fs, ino, &inode);
+		if (err)
+			return err;
+	}
+
+	err = ext2fs_get_mem(fs->blocksize, &buf);
+	if (err)
+		return err;
+	err = ext2fs_get_mem(fs->blocksize, &zerobuf);
+	if (err)
+		goto out;
+	memset(buf, 0, fs->blocksize);
+	memset(zerobuf, 0, fs->blocksize);
+	ob_tail = ext2fs_orphan_block_tail(fs, buf);
+	ob_tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
+	oi.num_blocks = num_blocks;
+	oi.alloc_blocks = 0;
+	oi.last_blk = 0;
+	oi.generation = inode.i_generation;
+	oi.ino = ino;
+	oi.buf = buf;
+	oi.zerobuf = zerobuf;
+	oi.err = 0;
+	err = ext2fs_block_iterate3(fs, ino, BLOCK_FLAG_APPEND,
+				    0, mkorphan_proc, &oi);
+	if (err)
+		goto out;
+	if (oi.err) {
+		err = oi.err;
+		goto out;
+	}
+
+	/* Reread inode after blocks were allocated */
+	err = ext2fs_read_inode(fs, ino, &inode);
+	if (err)
+		goto out;
+	ext2fs_iblk_set(fs, &inode, 0);
+	inode.i_atime = inode.i_mtime =
+		inode.i_ctime = fs->now ? fs->now : time(0);
+	inode.i_links_count = 1;
+	inode.i_mode = LINUX_S_IFREG | 0600;
+	ext2fs_iblk_add_blocks(fs, &inode, oi.alloc_blocks);
+	err = ext2fs_inode_size_set(fs, &inode,
+			(unsigned long long)fs->blocksize * num_blocks);
+	if (err)
+		goto out;
+	err = ext2fs_write_new_inode(fs, ino, &inode);
+	if (err)
+		goto out;
+
+	fs->super->s_orphan_file_inum = ino;
+	ext2fs_set_feature_orphan_file(fs->super);
+	ext2fs_mark_super_dirty(fs);
+	/* Need to update group descriptors as well */
+	fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+out:
+	if (buf)
+		ext2fs_free_mem(&buf);
+	if (zerobuf)
+		ext2fs_free_mem(&zerobuf);
+	return err;
+}
+
+/*
+ * Find reasonable size for orphan file. We choose orphan file size to be
+ * between 32 and 512 filesystem blocks and not more than 1/4096 of the
+ * filesystem unless it is really small.
+ */
+e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
+{
+	__u64 num_blocks = ext2fs_blocks_count(fs->super);
+	e2_blkcnt_t blks = 512;
+
+	if (num_blocks < 128 * 1024)
+		blks = 32;
+	else if (num_blocks < 2 * 1024 * 1024)
+		blks = num_blocks / 4096;
+	return (blks + EXT2FS_CLUSTER_MASK(fs)) & ~EXT2FS_CLUSTER_MASK(fs);
+}
+
+static errcode_t ext2fs_orphan_file_block_csum(ext2_filsys fs, ext2_ino_t ino,
+					       blk64_t blk, char *buf,
+					       __u32 *crcp)
+{
+	struct ext2_inode inode;
+	errcode_t retval;
+
+	retval = ext2fs_read_inode(fs, ino, &inode);
+	if (retval)
+		return retval;
+	*crcp = ext2fs_do_orphan_file_block_csum(fs, ino, inode.i_generation,
+						 blk, buf);
+	return 0;
+}
+
+errcode_t ext2fs_orphan_file_block_csum_set(ext2_filsys fs, ext2_ino_t ino,
+					    blk64_t blk, char *buf)
+{
+	struct ext4_orphan_block_tail *tail;
+
+	if (!ext2fs_has_feature_metadata_csum(fs->super))
+		return 0;
+
+	tail = ext2fs_orphan_block_tail(fs, buf);
+	return ext2fs_orphan_file_block_csum(fs, ino, blk, buf,
+					     &tail->ob_checksum);
+}
+
+int ext2fs_orphan_file_block_csum_verify(ext2_filsys fs, ext2_ino_t ino,
+					 blk64_t blk, char *buf)
+{
+	struct ext4_orphan_block_tail *tail;
+	__u32 crc;
+	errcode_t retval;
+
+	if (!ext2fs_has_feature_metadata_csum(fs->super))
+		return 1;
+	retval = ext2fs_orphan_file_block_csum(fs, ino, blk, buf, &crc);
+	if (retval)
+		return 0;
+	tail = ext2fs_orphan_block_tail(fs, buf);
+	return ext2fs_le32_to_cpu(tail->ob_checksum) == crc;
+}
diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
index 1006b2d2bd52..b844e7665999 100644
--- a/lib/ext2fs/swapfs.c
+++ b/lib/ext2fs/swapfs.c
@@ -131,8 +131,9 @@ void ext2fs_swap_super(struct ext2_super_block * sb)
 	/* s_*_time_hi are __u8 and does not need swabbing */
 	sb->s_encoding = ext2fs_swab16(sb->s_encoding);
 	sb->s_encoding_flags = ext2fs_swab16(sb->s_encoding_flags);
+	sb->s_orphan_file_inum = ext2fs_swab32(sb->s_orphan_file_inum);
 	/* catch when new fields are used from s_reserved */
-	EXT2FS_BUILD_BUG_ON(sizeof(sb->s_reserved) != 95 * sizeof(__le32));
+	EXT2FS_BUILD_BUG_ON(sizeof(sb->s_reserved) != 94 * sizeof(__le32));
 	sb->s_checksum = ext2fs_swab32(sb->s_checksum);
 }
 
diff --git a/lib/ext2fs/tst_super_size.c b/lib/ext2fs/tst_super_size.c
index 80a5269bceb7..ad452dee8eb3 100644
--- a/lib/ext2fs/tst_super_size.c
+++ b/lib/ext2fs/tst_super_size.c
@@ -152,7 +152,8 @@ int main(int argc, char **argv)
 	check_field(s_last_error_errcode, 1);
 	check_field(s_encoding, 2);
 	check_field(s_encoding_flags, 2);
-	check_field(s_reserved, 95 * 4);
+	check_field(s_orphan_file_inum, 4);
+	check_field(s_reserved, 94 * 4);
 	check_field(s_checksum, 4);
 	do_field("Superblock end", 0, 0, cur_offset, 1024);
 #endif
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 21a5c34d6921..b790b93f52c2 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -504,7 +504,8 @@ errcode_t quota_compute_usage(quota_ctx_t qctx)
 			continue;
 		if (ino == EXT2_ROOT_INO ||
 		    (ino >= EXT2_FIRST_INODE(fs->super) &&
-		     ino != quota_type2inum(PRJQUOTA, fs->super))) {
+		     ino != quota_type2inum(PRJQUOTA, fs->super) &&
+		     ino != fs->super->s_orphan_file_inum)) {
 			space = ext2fs_get_stat_i_blocks(fs,
 						EXT2_INODE(inode)) << 9;
 			quota_data_add(qctx, inode, ino, space);
-- 
2.26.2

