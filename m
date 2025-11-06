Return-Path: <linux-ext4+bounces-11598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF924C3DA4C
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5093918836C5
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473330B51B;
	Thu,  6 Nov 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+Yy+EGa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B72DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468888; cv=none; b=BK4iMdP6TA+2QOgrvP+Isngde6PYCtDH7l9nU/CdpFe4sLqudvCooW6F7ynBAEswMnfqYL0VdJrjb8AlNI6/0Fp3Ov4SmvAkSGjA0p+BQvlXnweqlZjoA+qAYn61ezXP7VhjsnWxVSY10dgWETsESXhTigkXy/ddCIPNP3OBz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468888; c=relaxed/simple;
	bh=VUVqo7gYV2M0M2R+g80+6Nghp8kN7+ELbTVptOlZZdQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDGebWuHsAHjWr9p2uSe2Z8N6coySWecWjl94SjFpujvG6JKYJWSvY/d4siPL9Ikj798NeJwCkLE/0mZtw7XzZz9vHyap453wnWTd9aK2xmPS7tBASOjvcrjvVUx12WEXg+SgO+1aS6n6/i5I6ugfdpatbM9xvqoRcbmOPjaFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+Yy+EGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAB5C4CEFB;
	Thu,  6 Nov 2025 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468888;
	bh=VUVqo7gYV2M0M2R+g80+6Nghp8kN7+ELbTVptOlZZdQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o+Yy+EGaTJ5UlffFaqaWX72OGFmsWa1xoqD9psfe9Oc3VdeQ++h236XQGfxEBbDv5
	 zUB3CLQVTkKHNF2fdeDazcMYDc1seSMv4Lmt73XcCDs9LgBPgwrriFnMxiM4BlRYO/
	 Wx7tVE8X0ybJJvra63eDWTbGfA/7J2eHLnXOTp24GLc6tEtKm9qThI4ZSUq7Xdk55J
	 1g684+K+p2HYeGtPRrCwuCKy0BPp9qaRft3A7ttV9pj9CUlcf32qXM4eK71FoJ1cgr
	 QbMjLACOkveaoFjhfVRpZeeU0LMl0C8L6BKUZrwNgM8UxO6ljVdZ2RNOqhEf6kQbR9
	 J1og2GopiL6sg==
Date: Thu, 06 Nov 2025 14:41:27 -0800
Subject: [PATCH 1/3] fuse2fs: pass a struct fuse2fs to fs_writeable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795068.2863930.16927910558736451438.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
References: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
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
index 33e456aa0a964c..1aa391b5a56456 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -882,8 +882,10 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 	return ext2fs_free_blocks_count(fs->super) > reserved + num;
 }
 
-static int fs_writeable(ext2_filsys fs)
+static int fuse2fs_is_writeable(struct fuse2fs *ff)
 {
+	ext2_filsys fs = ff->fs;
+
 	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
 }
 
@@ -912,12 +914,10 @@ static inline int want_check_owner(struct fuse2fs *ff,
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
@@ -950,7 +950,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	int ret;
 
 	/* no writing to read-only or broken fs */
-	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fuse2fs_is_writeable(ff))
 		return -EROFS;
 
 	err = ext2fs_read_inode(fs, ino, &inode);
@@ -1761,7 +1761,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 	buf[len] = 0;
 
-	if (fs_writeable(fs)) {
+	if (fuse2fs_is_writeable(ff)) {
 		ret = update_atime(fs, ino);
 		if (ret)
 			goto out;
@@ -3549,7 +3549,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		goto out;
 	}
 
-	if (fh->check_flags != X_OK && fs_writeable(fs)) {
+	if (fh->check_flags != X_OK && fuse2fs_is_writeable(ff)) {
 		ret = update_atime(fs, fh->ino);
 		if (ret)
 			goto out;
@@ -3576,7 +3576,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
 	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -3644,7 +3644,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	fs = fuse2fs_start(ff);
 
 	if ((fp->flags & O_SYNC) &&
-	    fs_writeable(fs) &&
+	    fuse2fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
 		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
@@ -3674,7 +3674,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse2fs_start(ff);
 	/* For now, flush everything, even if it's slow */
-	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
+	if (fuse2fs_is_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
@@ -4212,7 +4212,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (fs_writeable(i.fs)) {
+	if (fuse2fs_is_writeable(ff)) {
 		ret = update_atime(i.fs, fh->ino);
 		if (ret)
 			goto out;
@@ -4394,7 +4394,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
 	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -4772,7 +4772,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	blk64_t max_blks = ext2fs_blocks_count(fs->super);
 	errcode_t err = 0;
 
-	if (!fs_writeable(fs))
+	if (!fuse2fs_is_writeable(ff))
 		return -EROFS;
 
 	start = FUSE2FS_B_TO_FSBT(ff, fr->start);
@@ -5190,7 +5190,6 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
-	ext2_filsys fs;
 	int ret;
 
 	/* Catch unknown flags */
@@ -5199,8 +5198,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = fuse2fs_start(ff);
-	if (!fs_writeable(fs)) {
+	fuse2fs_start(ff);
+	if (!fuse2fs_is_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}


