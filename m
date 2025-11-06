Return-Path: <linux-ext4+bounces-11596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 679EAC3DA46
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165814E4EBF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEE32AAD4;
	Thu,  6 Nov 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta1SCraC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13882DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468856; cv=none; b=lXlBEEmWjRIlSEqSI9xzszhlnyF0As/RvqsliIKa9nt0iH77TzTDQEEHzLwAkdmX2QOpLfezE8xViWIPWYJlHd4DUbl0pRr97/fS3vx4dG+pvRB0WlOtomJo1r0DUzCaZLqGKPP0AI8gvG7Tp93PZcSzMniWRTHtfnM7ySC0bFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468856; c=relaxed/simple;
	bh=obZgHJ8d31fh+AGzjNrZVx3r7WSHzBriW1veCu919LA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh35hu0flFYHGCc+l1633bM2XcZKY6p6ARxe35MhZCnrAwSsvvmgc+KHTQBY0GZ/R3QKyC0t1aJdRSoeXzXaFGW+R+hXSIe5nYZ5Gv+5PR7ZbfCtb2agiv/LAVjNONptZwB2XIbCiv+PUYGWNCe1CFu+Hnv8eH1DxM0105i17r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta1SCraC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275DCC4CEF7;
	Thu,  6 Nov 2025 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468856;
	bh=obZgHJ8d31fh+AGzjNrZVx3r7WSHzBriW1veCu919LA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ta1SCraCE2R7CYzYZqT0/mW2z6vTK9ZDs5MVN6L0dyvp5PnpEJK2xe2lteCxJOJUA
	 qW4phsCoUc5N4V6dsYwxm8rtiLomrF/A12obrY3e4LhrTQ8KJXi88fA6kNvCmNFOzX
	 KIKV/y2la1fp5D2wl9TjjWbY2akqrNPgzxFPPdkWAUHI6fCY+krpTbdbVLkNlewH5i
	 5NYs01Api0d5RuHphTihY6PcFHuKzldEQ8BwNJN+KntmpfBYpBlYEE6EVt5X4NDDRE
	 l4YaNEjZc5VNN8yq2/JkqRPqVc7t5nLb3vxuDBz1RlbJF+yFyZfE9RF99oRpQhCQ+Y
	 Dwmg143avZhtQ==
Date: Thu, 06 Nov 2025 14:40:55 -0800
Subject: [PATCH 3/4] fuse2fs: improve tracing for file range operations
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794899.2863722.698068868768407092.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
References: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
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
index cede10765f5c1b..9927a5d14c8fd2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3519,8 +3519,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
-		   (intmax_t) offset, len);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long)offset, len);
 	fs = fuse2fs_start(ff);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
@@ -3573,8 +3573,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
-		   (intmax_t) offset, (intmax_t) len);
+	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
+		   (unsigned long long) offset, len);
 	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -4146,12 +4146,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
 
@@ -4200,7 +4201,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx\n", __func__, fh->ino,
 			(unsigned long long)offset);
 	i.fs = fuse2fs_start(ff);
 	i.buf = buf;
@@ -4786,7 +4787,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	    fr->len < fs->blocksize)
 		return -EINVAL;
 
-	dbg_printf(ff, "%s: start=%llu end=%llu minlen=%llu\n", __func__,
+	dbg_printf(ff, "%s: start=0x%llx end=0x%llx minlen=0x%llx\n", __func__,
 		   start, end, minlen);
 
 	if (start < fs->super->s_first_data_block)
@@ -4957,8 +4958,12 @@ static int fuse2fs_allocate_range(struct fuse2fs *ff,
 
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
 
@@ -5029,6 +5034,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
+	dbg_printf(ff, "%s: ino=%d offset=0x%llx len=0x%llx\n",
+		   __func__, ino,
+		   (unsigned long long)offset + residue,
+		   (unsigned long long)len);
 	memset(*buf + residue, 0, len);
 
 	return io_channel_write_blk64(fs->io, blk, 1, *buf);
@@ -5065,10 +5074,19 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -5083,9 +5101,6 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
 	errcode_t err;
 	char *buf = NULL;
 
-	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
-		   (intmax_t) offset, (intmax_t) len);
-
 	/* kernel ext4 punch requires this flag to be set */
 	if (!(mode & FL_KEEP_SIZE_FLAG))
 		return -EINVAL;
@@ -5100,8 +5115,12 @@ static int fuse2fs_punch_range(struct fuse2fs *ff,
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
@@ -5185,6 +5204,12 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
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


