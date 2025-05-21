Return-Path: <linux-ext4+bounces-8111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7ACABFFE3
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10E73B31B3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D3239E62;
	Wed, 21 May 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKtaLomL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8931754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867398; cv=none; b=gtwjZ4LAuUSlmZG/xBW6y0iXQ6WhfoF4dsY1O3ylWj5a6y1Rlnq2knZhZdb6sa42eRi62z+LLwAdoeNfjU4h1i/nWNrYcyaGtv7pTXydYcj5UFcYbT8WUifQY9NyVDQZyx4TOU8Fz52cgctPIJSNeICxY5u2pYGb6oSTd1mlHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867398; c=relaxed/simple;
	bh=kdOWcX66/zOhCVXyv12rIBxXiUEn58pNr8WaT8isLFk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV4Ht45ZHu/hZo8OVSQ3dpjVECUBnUrjmQnXVMAgknOyyIHLmBa8aUor5du/cAESQZjIsmehseCKAl7AAFe0RDgD0Zmncw00Rsg/qk1q6NEYzeRPQAHRvRMHgSXJWVKmw9FOESOfQnQ2aawKPW6KQZdB3jmFiMD73Yqvap+Z6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKtaLomL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E397CC4CEE4;
	Wed, 21 May 2025 22:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867398;
	bh=kdOWcX66/zOhCVXyv12rIBxXiUEn58pNr8WaT8isLFk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nKtaLomLDg88IMvCRamwK2scve84aX+9Ba8m0uy30Q2Zgo3beIl4Sllj7d+/92M3x
	 5EzjXhMqzl//eOw94TY85SCTxvTppVX2bCBvUqAkiAtSj/D0MkmYDjNSUjIZIcB1QG
	 f1b3i5rBBk8yHpI+Fuj117TPL6wKnHibi0lCaAVxxDF7+SmxjRIV7tih603gviB6FS
	 wQBmRQTWcsnK2tMIa8IefdryJQe2o51PaEjXxYqxdU7KY1vo/tZZIKBuLawXxZFGhW
	 GDEHyR59TFZUU5erqBHFhwpKWA1XYqUtHLk9kdMtn6OGq6OV4NSeVh9qg/1s29zjJC
	 JqNzvur7PfGYA==
Date: Wed, 21 May 2025 15:43:17 -0700
Subject: [PATCH 3/3] fuse2fs: implement blocksize converters
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678247.1384866.5139178053250117853.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
References: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Before we implement iomap, add some helpers to convert bytes to fsblocks
and back.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   92 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 26 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a89ba115bf6f42..9c1e5b00703bbe 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -162,6 +162,9 @@ struct fuse2fs {
 	uint8_t kernel;
 	uint8_t directio;
 	uint8_t acl;
+
+	int blocklog;
+	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
 	unsigned long long cache_size;
@@ -189,6 +192,39 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 #  define R_OK 4
 #endif
 
+static inline int u_log2(unsigned int arg)
+{
+	int	l = 0;
+
+	arg >>= 1;
+	while (arg) {
+		l++;
+		arg >>= 1;
+	}
+	return l;
+}
+
+static inline blk64_t FUSE2FS_B_TO_FSBT(const struct fuse2fs *ff, off_t pos)
+{
+	return pos >> ff->blocklog;
+}
+
+static inline blk64_t FUSE2FS_B_TO_FSB(const struct fuse2fs *ff, off_t pos)
+{
+	return (pos + ff->blockmask) >> ff->blocklog;
+}
+
+static inline unsigned int FUSE2FS_OFF_IN_FSB(const struct fuse2fs *ff,
+					      off_t pos)
+{
+	return pos & ff->blockmask;
+}
+
+static inline off_t FUSE2FS_FSB_TO_B(const struct fuse2fs *ff, blk64_t bno)
+{
+	return bno << ff->blocklog;
+}
+
 #define EXT4_EPOCH_BITS 2
 #define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)
 #define EXT4_NSEC_MASK  (~0UL << EXT4_EPOCH_BITS)
@@ -2223,7 +2259,7 @@ static int punch_posteof(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_inode_large inode;
-	blk64_t truncate_block = (new_size + fs->blocksize - 1) / fs->blocksize;
+	blk64_t truncate_block = FUSE2FS_B_TO_FSB(ff, new_size);
 	errcode_t err;
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
@@ -2525,7 +2561,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (!fs_can_allocate(ff, len / fs->blocksize)) {
+	if (!fs_can_allocate(ff, FUSE2FS_B_TO_FSB(ff, len))) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -3684,9 +3720,9 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (!fs_writeable(fs))
 		return -EROFS;
 
-	start = fr->start / fs->blocksize;
-	end = (fr->start + fr->len - 1) / fs->blocksize;
-	minlen = fr->minlen / fs->blocksize;
+	start = FUSE2FS_B_TO_FSBT(ff, fr->start);
+	end = FUSE2FS_B_TO_FSBT(ff, fr->start + fr->len - 1);
+	minlen = FUSE2FS_B_TO_FSBT(ff, fr->minlen);
 
 	if (EXT2FS_NUM_B2C(fs, minlen) > EXT2_CLUSTERS_PER_GROUP(fs->super) ||
 	    start >= max_blks ||
@@ -3705,7 +3741,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 		end = ext2fs_blocks_count(fs->super) - 1;
 
 	cleared = 0;
-	max_blocks = 2048ULL * 1024 * 1024 / fs->blocksize;
+	max_blocks = FUSE2FS_B_TO_FSBT(ff, 2048ULL * 1024 * 1024);
 
 	fr->len = 0;
 	while (start <= end) {
@@ -3732,7 +3768,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 			if (err)
 				return translate_error(fs, fh->ino, err);
 			cleared += b - start;
-			fr->len = cleared * fs->blocksize;
+			fr->len = FUSE2FS_FSB_TO_B(ff, cleared);
 		}
 		start = b + 1;
 	}
@@ -3850,11 +3886,11 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
-	start = offset / fs->blocksize;
-	end = (offset + len - 1) / fs->blocksize;
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%jd end=%llu\n", __func__,
-		   fh->ino, mode, offset / fs->blocksize, end);
-	if (!fs_can_allocate(ff, len / fs->blocksize))
+	start = FUSE2FS_B_TO_FSBT(ff, offset);
+	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
+	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
+		   fh->ino, mode, start, end);
+	if (!fs_can_allocate(ff, FUSE2FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
@@ -3893,16 +3929,17 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	return err;
 }
 
-static errcode_t clean_block_middle(ext2_filsys fs, ext2_ino_t ino,
-				  struct ext2_inode_large *inode, off_t offset,
-				  off_t len, char **buf)
+static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode,
+				    off_t offset, off_t len, char **buf)
 {
+	ext2_filsys fs = ff->fs;
 	blk64_t blk;
 	off_t residue;
 	int retflags;
 	errcode_t err;
 
-	residue = offset % fs->blocksize;
+	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;
 
@@ -3913,7 +3950,7 @@ static errcode_t clean_block_middle(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
-			   offset / fs->blocksize, &retflags, &blk);
+			   FUSE2FS_B_TO_FSBT(ff, offset), &retflags, &blk);
 	if (err)
 		return err;
 	if (!blk || (retflags & BMAP_RET_UNINIT))
@@ -3928,16 +3965,17 @@ static errcode_t clean_block_middle(ext2_filsys fs, ext2_ino_t ino,
 	return io_channel_write_blk(fs->io, blk, 1, *buf);
 }
 
-static errcode_t clean_block_edge(ext2_filsys fs, ext2_ino_t ino,
+static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 				  struct ext2_inode_large *inode, off_t offset,
 				  int clean_before, char **buf)
 {
+	ext2_filsys fs = ff->fs;
 	blk64_t blk;
 	int retflags;
 	off_t residue;
 	errcode_t err;
 
-	residue = offset % fs->blocksize;
+	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;
 
@@ -3948,7 +3986,7 @@ static errcode_t clean_block_edge(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
-			   offset / fs->blocksize, &retflags, &blk);
+			   FUSE2FS_B_TO_FSBT(ff, offset), &retflags, &blk);
 	if (err)
 		return err;
 
@@ -3989,7 +4027,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 		return -EINVAL;
 
 	/* Punch out a bunch of blocks */
-	start = (offset + fs->blocksize - 1) / fs->blocksize;
+	start = FUSE2FS_B_TO_FSB(ff, offset);
 	end = (offset + len - fs->blocksize) / fs->blocksize;
 	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
 		   fh->ino, mode, start, end);
@@ -3999,13 +4037,13 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 		return translate_error(fs, fh->ino, err);
 
 	/* Zero everything before the first block and after the last block */
-	if ((offset / fs->blocksize) == ((offset + len) / fs->blocksize))
-		err = clean_block_middle(fs, fh->ino, &inode, offset,
+	if (FUSE2FS_B_TO_FSBT(ff, offset) == FUSE2FS_B_TO_FSBT(ff, offset + len))
+		err = clean_block_middle(ff, fh->ino, &inode, offset,
 					 len, &buf);
 	else {
-		err = clean_block_edge(fs, fh->ino, &inode, offset, 0, &buf);
+		err = clean_block_edge(ff, fh->ino, &inode, offset, 0, &buf);
 		if (!err)
-			err = clean_block_edge(fs, fh->ino, &inode,
+			err = clean_block_edge(ff, fh->ino, &inode,
 					       offset + len, 1, &buf);
 	}
 	if (buf)
@@ -4379,6 +4417,8 @@ int main(int argc, char *argv[])
 	}
 	fctx.fs = global_fs;
 	global_fs->priv_data = &fctx;
+	fctx.blocklog = u_log2(fctx.fs->blocksize);
+	fctx.blockmask = fctx.fs->blocksize - 1;
 
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
@@ -4386,7 +4426,7 @@ int main(int argc, char *argv[])
 		char buf[55];
 
 		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
-				fctx.cache_size / global_fs->blocksize);
+			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
 		err = io_channel_set_options(global_fs->io, buf);
 		if (err) {
 			err_printf(&fctx, "%s %lluk: %s\n",


