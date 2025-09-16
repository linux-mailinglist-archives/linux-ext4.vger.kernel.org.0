Return-Path: <linux-ext4+bounces-10104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED83B588CE
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E2517BD42
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4E4A00;
	Tue, 16 Sep 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmCOwAMX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5FA625
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981105; cv=none; b=FdMe49H70Nv/WIPICIuyU5SgaISPlCtRW20QEkm8sirhviVtMZZwY8MRSSuSpwvCyqPccXtLlrQko3B2u6cC9Bq5NIenKTneWNR56KC7p1BPAj5DdBDEs627lxnu0soMXyf+dSzUS+ixBmmpuriYGua4Unn2H6Ji9DR2PG4UaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981105; c=relaxed/simple;
	bh=QeMb/UDqwLKnuuJ37/hP4ayhMVCPReFAQSrlCpZTmvY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSs37T9EODZ2jyZBl37S7WYedKO/rWEJ3dGkQp3ihkLFv2lyyTLamEdsLI+vEt4trhFFZQgs3QMdQn5QLmVHeu20DZVjrqdIF2oqpSDgAxjO3/HVcXiXXKe6kHfHCls1IUR+1R/jSF1XLvlHWi/w7nQmIJOTkyofVdef0+yEktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmCOwAMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5F1C4CEF1;
	Tue, 16 Sep 2025 00:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981105;
	bh=QeMb/UDqwLKnuuJ37/hP4ayhMVCPReFAQSrlCpZTmvY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FmCOwAMXYZk577TwIqFpq18+TI7Hc9TKFPQFjXoP+vsQ46CycP8EvED8FQF4DeIJT
	 BI2MHxxwFq9x67xhmGuzvezQAUfYojP5+ypgJRc4O/mh9GuxCFHdzxa1jlxpYwCz6O
	 7OoNMbpzhO2HdSrUuKc9MKJPDPMf5croessYo+CM1dtR4+41+KtHnOPRj8znTjy5/O
	 n0bHkgHIwFytR+yalxMFZleESOhtR/LCiwBoaT6ABvtzIbejyubWIOKjTUco6LAq5t
	 wfYchO8e780ku+LmrR6rFbDo086M/0lxS9mywWWNPtApfCYCN9eqqNRsHOwFbTwWcB
	 j6e+AKLv1s7dQ==
Date: Mon, 15 Sep 2025 17:05:03 -0700
Subject: [PATCH 1/3] fuse2fs: pass a struct fuse2fs to fs_writeable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065174.350393.1813141525774384468.stgit@frogsfrogsfrogs>
In-Reply-To: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
References: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Pass the outer fuse2fs context to fs_writable in preparation for the
next patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6173d6f51892a9..dd731d84c4535f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -726,8 +726,10 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 	return ext2fs_free_blocks_count(fs->super) > reserved + num;
 }
 
-static int fs_writeable(ext2_filsys fs)
+static int fuse2fs_is_writeable(struct fuse2fs *ff)
 {
+	ext2_filsys fs = ff->fs;
+
 	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
 }
 
@@ -756,12 +758,10 @@ static inline int want_check_owner(struct fuse2fs *ff,
 static int check_iflags_access(struct fuse2fs *ff, ext2_ino_t ino,
 			       const struct ext2_inode *inode, int mask)
 {
-	ext2_filsys fs = ff->fs;
-
 	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
 
 	/* no writing or metadata changes to read-only or broken fs */
-	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fuse2fs_is_writeable(ff))
 		return -EROFS;
 
 	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
@@ -794,7 +794,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	int ret;
 
 	/* no writing to read-only or broken fs */
-	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fuse2fs_is_writeable(ff))
 		return -EROFS;
 
 	err = ext2fs_read_inode(fs, ino, &inode);
@@ -1517,7 +1517,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 	buf[len] = 0;
 
-	if (fs_writeable(fs)) {
+	if (fuse2fs_is_writeable(ff)) {
 		ret = update_atime(fs, ino);
 		if (ret)
 			goto out;
@@ -3252,7 +3252,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		goto out;
 	}
 
-	if (fh->check_flags != X_OK && fs_writeable(fs)) {
+	if (fh->check_flags != X_OK && fuse2fs_is_writeable(ff)) {
 		ret = update_atime(fs, fh->ino);
 		if (ret)
 			goto out;
@@ -3279,7 +3279,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
 	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -3347,7 +3347,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	fs = fuse2fs_start(ff);
 
 	if ((fp->flags & O_SYNC) &&
-	    fs_writeable(fs) &&
+	    fuse2fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
 		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
@@ -3377,7 +3377,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
 	/* For now, flush everything, even if it's slow */
-	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
+	if (fuse2fs_is_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
@@ -3915,7 +3915,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (fs_writeable(i.fs)) {
+	if (fuse2fs_is_writeable(ff)) {
 		ret = update_atime(i.fs, fh->ino);
 		if (ret)
 			goto out;
@@ -4097,7 +4097,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
 	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -4475,7 +4475,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	blk64_t max_blks = ext2fs_blocks_count(fs->super);
 	errcode_t err = 0;
 
-	if (!fs_writeable(fs))
+	if (!fuse2fs_is_writeable(ff))
 		return -EROFS;
 
 	start = FUSE2FS_B_TO_FSBT(ff, fr->start);
@@ -4893,7 +4893,6 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
-	ext2_filsys fs;
 	int ret;
 
 	/* Catch unknown flags */
@@ -4902,8 +4901,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	fuse2fs_start(ff);
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}


