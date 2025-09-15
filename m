Return-Path: <linux-ext4+bounces-10084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D01B588B0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFDFE4E1E1A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126E2DC32D;
	Mon, 15 Sep 2025 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRxHkW0R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348F2C0F87
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980791; cv=none; b=BCHGfJOlSKMHCI04MqL4uYaOIHM+KoFbGlvlhfF7NSlUDGZoSNVrKazffRiKJhRpmjh4MarOLEl2+qaW0WDJo79samjRAdoSUGHeZTboUdo9Bh3SPcSwBLEajZPVwFJTqwqlxZ+hqjXXOtHUPPD45WOXAI7LWGJuu/Q4XvGnRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980791; c=relaxed/simple;
	bh=2w38FwqvEGSjxx/LCXO9xfuuUWSb0alBLHtnpmoYI1M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1mY/z6wt/Cd4dNm8Wn2Bg3yxlAYxSORMzekrMyUzxJItp3/mh71SiGqbZeSAC295d7nYc1OGvcucBG1qT65I8Vw6z1l9AqulL41dEeywF2DxZo3Zxubxc9MBWCttcA12iItp49gKpRS136y/gYwK6Jmxx34jCzUVrrc30qK19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRxHkW0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987EEC4CEF1;
	Mon, 15 Sep 2025 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980790;
	bh=2w38FwqvEGSjxx/LCXO9xfuuUWSb0alBLHtnpmoYI1M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IRxHkW0RrghAFdlaSMCJga3MOd3FgP2EjPVcUvGiOggme6OJ3DR2Fb0Rse9AE9YnK
	 ChFqkK17osOctDqChqvlX5qoHvecOh6dYVXZWDLaI0a0eiLz5zaiY8lqmXkqASZQDL
	 xVAVInkN5ZxIEJa5Xa/nFHKc0lvE/bI+BhDPBgQ2ihxmdiMy7nvfye+omAhiQeSi1I
	 J7B0vs5NI/OEYawOHzp7+t2f/s86ah3XDdN/3+LetsJs5DiN8w9sl2FHS2umQnHQdC
	 AQPJm7r9pJdSuSIrGGHVljYDH5mKBuxspKNi30UngaDdxp5+75j+1WPM765fx7THdU
	 zxLBVtHrXVIlw==
Date: Mon, 15 Sep 2025 16:59:50 -0700
Subject: [PATCH 3/9] fuse2fs: rework fallocate file handle extraction
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064149.349283.559208645562467096.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
References: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
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
index 178d0fd6e20263..5a33e161ae8f9d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4357,23 +4357,17 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 
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
@@ -4492,22 +4486,16 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
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
 
@@ -4578,13 +4566,15 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
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
 
@@ -4594,24 +4584,29 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
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
 


