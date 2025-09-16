Return-Path: <linux-ext4+bounces-10102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F6B588CC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20D03AEC98
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4D4A00;
	Tue, 16 Sep 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro95KRA3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84966625
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981073; cv=none; b=t91gXGWTTBlsa9ot6EZXWxDXfovyeodqgjLGJivJc2NR2DIRJWAdF0nAmOj1nvpwkd+eliDeZagySLlpHkdFIfCGPko3YobG20MshScCBplGqkzq3LNhbKK7DaVxIRnI8pxSfmowCmDgi5RpOLhw19+llt+IUhOo5zUrt87+kBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981073; c=relaxed/simple;
	bh=1zoyQ3glyvPfOAnmD7emihijmTTtmtr7V/PD3C0P79g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJwkrnI+ez6AzpJwdpwN0WBtPscZCBGjQH4f5XeyD6ig5cRWnnea/Sp3o6PbP9iu66jvNcWtnp3eMEA7zSW7b5Piv7JQQUq+V5oDKAu6VrF8KxZxbD2IS8xBGkPnhg4ASj0JZ8J6f/cwu110XHhquo0or3X6p/G9YqnnlhofVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ro95KRA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD31C4CEF1;
	Tue, 16 Sep 2025 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981073;
	bh=1zoyQ3glyvPfOAnmD7emihijmTTtmtr7V/PD3C0P79g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ro95KRA3vg+nbRHFOgL5p6h9VtM9GzG9kxnmzy7TZaaly1dth5Ufb+nzOpInuMEIT
	 TWmZhfOxOTg9kdTJURYumazj13ZLyfTsq/4rW8XTZdOmiDweAe06BhmYiI529jI9wq
	 X+HuU3sgPJPA7Voarje0VNranWvc0/JXXEygLEBofai9qMlP7QqAtnYJx87+aVNzkb
	 /Ajh3D7FBeBknrAr/XwTUc4kryQshCe0ZREUXDTQ6AxtSUUdlKF74hQPmFNKb3SP9w
	 0rRia+2CGGPtniDR5Ju2RaSuvYkWFWmY3J0+FJ8fV1Kuw8/CKvXGwfTwCx0o2kpdgR
	 0qRxOxT9sjPmw==
Date: Mon, 15 Sep 2025 17:04:32 -0700
Subject: [PATCH 4/5] fuse2fs: improve tracing for file range operations
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065004.350149.4181596608485421395.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
References: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Improve the tracing for read, write, readdir, and fallocate by reporting
the inode number and the file range in all tracepoints relating to file
IO.  Make the file ranges hexadecimal to make it easier for the
programmer to convert bytes to block numbers and back.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   57 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e0095b5c43c0c1..feef9a1709f6cd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3222,8 +3222,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
-		   (intmax_t) offset, len);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long)offset, len);
 	fs = fuse2fs_start(ff);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
@@ -3276,8 +3276,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
-		   (intmax_t) offset, (intmax_t) len);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long) offset, len);
 	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -3849,12 +3849,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	if (i->startpos >= i->dirpos)
 		return 0;
 
-	dbg_printf(i->ff, "READDIR%s %u dirpos %llu\n",
+	dbg_printf(i->ff, "READDIR%s ino=%d %u offset=0x%llx\n",
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
 #else
 			"",
 #endif
+			dir,
 			i->nr++,
 			(unsigned long long)i->dirpos);
 
@@ -3903,7 +3904,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx\n", __func__, fh->ino,
 			(unsigned long long)offset);
 	i.fs = fuse2fs_start(ff);
 	i.buf = buf;
@@ -4489,7 +4490,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	    fr->len < fs->blocksize)
 		return -EINVAL;
 
-	dbg_printf(ff, "%s: start=%llu end=%llu minlen=%llu\n", __func__,
+	dbg_printf(ff, "%s: start=0x%llx end=0x%llx minlen=0x%llx\n", __func__,
 		   start, end, minlen);
 
 	if (start < fs->super->s_first_data_block)
@@ -4660,8 +4661,12 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
-		   fh->ino, mode, start, end);
+	dbg_printf(ff, "%s: ino=%d mode=0x%x offset=0x%llx len=0x%llx start=0x%llx end=0x%llx\n",
+		   __func__, fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)len,
+		   (unsigned long long)start,
+		   (unsigned long long)end);
 	if (!fs_can_allocate(ff, FUSE2FS_B_TO_FSB(ff, len)))
 		return -ENOSPC;
 
@@ -4732,6 +4737,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx len=0x%llx\n",
+		   __func__, ino,
+		   (unsigned long long)offset + residue,
+		   (unsigned long long)len);
 	memset(*buf + residue, 0, len);
 
 	return io_channel_write_blk64(fs->io, blk, 1, *buf);
@@ -4768,10 +4777,19 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	if (clean_before)
+	if (clean_before) {
+		dbg_printf(ff, "%s: ino=%d before offset=0x%llx len=0x%llx\n",
+			   __func__, ino,
+			   (unsigned long long)offset,
+			   (unsigned long long)residue);
 		memset(*buf, 0, residue);
-	else
+	} else {
+		dbg_printf(ff, "%s: ino=%d after offset=0x%llx len=0x%llx\n",
+			   __func__, ino,
+			   (unsigned long long)offset,
+			   (unsigned long long)fs->blocksize - residue);
 		memset(*buf + residue, 0, fs->blocksize - residue);
+	}
 
 	return io_channel_write_blk64(fs->io, blk, 1, *buf);
 }
@@ -4786,9 +4804,6 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 	errcode_t err;
 	char *buf = NULL;
 
-	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
-		   (intmax_t) offset, (intmax_t) len);
-
 	/* kernel ext4 punch requires this flag to be set */
 	if (!(mode & FL_KEEP_SIZE_FLAG))
 		return -EINVAL;
@@ -4803,8 +4818,12 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 	end = FUSE2FS_B_TO_FSBT(ff, round_down(offset + len, fs->blocksize));
 
 	dbg_printf(ff,
- "%s: ino=%d mode=0x%x offset=0x%jx len=0x%jx start=0x%llx end=0x%llx\n",
-		   __func__, fh->ino, mode, offset, len, start, end);
+ "%s: ino=%d mode=0x%x offset=0x%llx len=0x%llx start=0x%llx end=0x%llx\n",
+		   __func__, fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)len,
+		   (unsigned long long)start,
+		   (unsigned long long)end);
 
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4888,6 +4907,12 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 		ret = -EROFS;
 		goto out;
 	}
+
+	dbg_printf(ff, "%s: ino=%d mode=0x%x start=0x%llx end=0x%llx\n", __func__,
+		   fh->ino, mode,
+		   (unsigned long long)offset,
+		   (unsigned long long)offset + len);
+
 	if (mode & FL_ZERO_RANGE_FLAG)
 		ret = fuse2fs_zero_range(ff, fh, mode, offset, len);
 	else if (mode & FL_PUNCH_HOLE_FLAG)


