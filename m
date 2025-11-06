Return-Path: <linux-ext4+bounces-11581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFBC3DA0A
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422613A3916
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6923081B9;
	Thu,  6 Nov 2025 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMHj3HJs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC53376A5
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468616; cv=none; b=Ggm1hGCGZUgHLdzbyaqCT7UYUxPN3BHjsLuuWZDQdcVUhiJHt151BOJ1IIRc1/zvFun/0NtWY8WID0er/rxQRnGfN/DQcJ4irKOVFGoWWENihpGVWhtJRxkc4ivt2tZ9ddmkvCeusB6R319eb/dYHJqwXXLpdT4636EBYGSfJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468616; c=relaxed/simple;
	bh=WyDHfm7nxqWrGyGLINWjRj8RXpwNJ9W2SxR1ijsBRuQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/7cm6Q+Yq0GQSgayrfKdiXlE0vLWraUZLIhvMHHgvpqS0+/Oijfgn8F6VhwQCtCQoTjec20Q1tb9Mhd7aD66y3C+q6eukkoLDjMjfP5+TzixGyIbJt1U3XF5TyYVyl4FLnRwCkdWW0yl8oWe9ptYb+PmWOV4IEaLdCRQPLVTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMHj3HJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBD5C4CEFB;
	Thu,  6 Nov 2025 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468616;
	bh=WyDHfm7nxqWrGyGLINWjRj8RXpwNJ9W2SxR1ijsBRuQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cMHj3HJsoE+lUdDkUhIfGQhxHgCpsJF0EDTCvAb+pBn19abtQzMVaekn6VMfkUvta
	 sbSfadwoiPNa2QcQse5hiy8mTVZv8weiPXilOZb/G2vmDzMoogcTogE8tkeaty+Gqm
	 HCIB7T6Y3zptsRGAmrSLgml7lFylqI99H4aQ2+naBZnZbtYIS2SuYj5gHo5x0od78a
	 AB68ql3wU/jDpjL2dDUxnmNA4dwmV34nLI2TyaHEe9meP5S9D8WDz8Qx0yskbr/1EB
	 QQQHz/Y964e6Tz1u0Nh5L3o6yDBe2GMEK3Ujn98NXz5iRThzjiRW09F0uC7Csczi9r
	 FSarelYrNWOJA==
Date: Thu, 06 Nov 2025 14:36:55 -0800
Subject: [PATCH 3/9] fuse2fs: rework fallocate file handle extraction
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794218.2862990.11455044492908046818.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
References: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Move the context and file handle checking to op_fallocate so that we can
pass them to the alloc/punch/zero helpers.  This eliminates redundant
checking in the zero_range path.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index da37c095c7a304..07bb4cdb889c17 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4629,23 +4629,17 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
 # ifdef SUPPORT_FALLOCATE
-static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
-			    off_t len)
+static int fuse2fs_allocate_range(struct fuse2fs *ff,
+				  struct fuse2fs_file_handle *fh, int mode,
+				  off_t offset, off_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
-	ext2_filsys fs;
+	ext2_filsys fs = ff->fs;
 	struct ext2_inode_large inode;
 	blk64_t start, end;
 	__u64 fsize;
 	errcode_t err;
 	int flags;
 
-	FUSE2FS_CHECK_CONTEXT(ff);
-	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
 	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
@@ -4764,22 +4758,16 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	return io_channel_write_blk64(fs->io, blk, 1, *buf);
 }
 
-static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
-			off_t len)
+static int fuse2fs_punch_range(struct fuse2fs *ff,
+			       struct fuse2fs_file_handle *fh, int mode,
+			       off_t offset, off_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
-	ext2_filsys fs;
+	ext2_filsys fs = ff->fs;
 	struct ext2_inode_large inode;
 	blk64_t start, end;
 	errcode_t err;
 	char *buf = NULL;
 
-	FUSE2FS_CHECK_CONTEXT(ff);
-	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
 		   (intmax_t) offset, (intmax_t) len);
 
@@ -4850,13 +4838,15 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	return 0;
 }
 
-static int zero_helper(struct fuse_file_info *fp, int mode, off_t offset,
-		       off_t len)
+static int fuse2fs_zero_range(struct fuse2fs *ff,
+			      struct fuse2fs_file_handle *fh, int mode,
+			      off_t offset, off_t len)
 {
-	int ret = punch_helper(fp, mode | FL_KEEP_SIZE_FLAG, offset, len);
+	int ret = fuse2fs_punch_range(ff, fh, mode | FL_KEEP_SIZE_FLAG, offset,
+				      len);
 
 	if (!ret)
-		ret = fallocate_helper(fp, mode, offset, len);
+		ret = fuse2fs_allocate_range(ff, fh, mode, offset, len);
 	return ret;
 }
 
@@ -4866,24 +4856,29 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	ext2_filsys fs = ff->fs;
+	struct fuse2fs_file_handle *fh =
+		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	ext2_filsys fs;
 	int ret;
 
 	/* Catch unknown flags */
 	if (mode & ~(FL_ZERO_RANGE_FLAG | FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
 		return -EOPNOTSUPP;
 
+	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;
 	}
 	if (mode & FL_ZERO_RANGE_FLAG)
-		ret = zero_helper(fp, mode, offset, len);
+		ret = fuse2fs_zero_range(ff, fh, mode, offset, len);
 	else if (mode & FL_PUNCH_HOLE_FLAG)
-		ret = punch_helper(fp, mode, offset, len);
+		ret = fuse2fs_punch_range(ff, fh, mode, offset, len);
 	else
-		ret = fallocate_helper(fp, mode, offset, len);
+		ret = fuse2fs_allocate_range(ff, fh, mode, offset, len);
 out:
 	pthread_mutex_unlock(&ff->bfl);
 


