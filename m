Return-Path: <linux-ext4+bounces-8133-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38528AC0009
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3411BC52E7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6B2356B4;
	Wed, 21 May 2025 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go4wpQk2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858B1B0F20
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867743; cv=none; b=k0rAa6Gu/kgwKEX9kZGQeSLXgCu9OIXoDImksDA1sFGYNr3GB8yXFPyos0QWfonuPwbyydGPFkL3acMcopQWCkMgerrAywYBXAxTzk1v7T/+Ec3fjsFwtaixU2Upq9NPk8ccq0TPNOeYth8U6hJ68kXIeAFgYbV4w8azie4F97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867743; c=relaxed/simple;
	bh=N5Nzub49SqK6eyVbsQTI1kKumqZkqAbfxHWHdv0Y9ic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McUTzkbMSTm4+Os1PH99c3zIV+mHVFUxG6aR8qIRVaCx0MPQQwaNgZkBqXlAzItdp4NDm5ZmDN7v8/A0kqVHxU8I0ay9vyk4ZLO/kPE/6NBfq4L2R9BL794H/3Pyp1dlKra/7VSH5Qeh9LUbApTNZ1f/yOaklrYGpCbh7zdG610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go4wpQk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA319C4CEE4;
	Wed, 21 May 2025 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867742;
	bh=N5Nzub49SqK6eyVbsQTI1kKumqZkqAbfxHWHdv0Y9ic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Go4wpQk2wa6k4avQQkEYUpEUFuGziIRfyVQ7HOeikaZSmKBIXAa+hYVpyDMROyc3v
	 Lt8Z+j9z/txUGHUUbXZofNlyuR8KcE8AOZ/cQqgsccHMy1m0AN8sdFZd9sEE6BZ2SA
	 6ot3vGXUDJqbTcgFKPxig2miLEV8AXMVdmuMPLhNzHsiAm+SEfvL6sN5QW2HSr6vF6
	 As8upFwlKW9VP30Ireqh61s56yBp5OLxzCpoqsSq0QiTsZ2iawwArk7utzzhNb4Dxb
	 QLFs7cTQO83YkFhS/8BOEW9q6duRIhqsB6Kf2ctYkPIt5mX7GBy9BGsI+GRSqQvs/S
	 mWMUOXcJekZwA==
Date: Wed, 21 May 2025 15:49:02 -0700
Subject: [PATCH 1/2] fuse2fs: pass a struct fuse2fs to fs_writeable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679216.1385986.14922530113932721718.stgit@frogsfrogsfrogs>
In-Reply-To: <174786679193.1385986.6656255712144313017.stgit@frogsfrogsfrogs>
References: <174786679193.1385986.6656255712144313017.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 54753c79abeb1d..b68ae2d216d5d3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -543,8 +543,10 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 	return ext2fs_free_blocks_count(fs->super) > reserved + num;
 }
 
-static int fs_writeable(ext2_filsys fs)
+static int fs_writeable(struct fuse2fs *ff)
 {
+	ext2_filsys fs = ff->fs;
+
 	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
 }
 
@@ -573,12 +575,10 @@ static inline int want_check_owner(struct fuse2fs *ff,
 static int check_iflags_access(struct fuse2fs *ff, ext2_ino_t ino,
 			       const struct ext2_inode *inode, int mask)
 {
-	ext2_filsys fs = ff->fs;
-
 	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
 
 	/* no writing or metadata changes to read-only or broken fs */
-	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fs_writeable(ff))
 		return -EROFS;
 
 	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
@@ -611,7 +611,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	int ret;
 
 	/* no writing to read-only or broken fs */
-	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fs_writeable(ff))
 		return -EROFS;
 
 	err = ext2fs_read_inode(fs, ino, &inode);
@@ -1203,7 +1203,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	}
 	buf[len] = 0;
 
-	if (fs_writeable(fs)) {
+	if (fs_writeable(ff)) {
 		ret = update_atime(fs, ino);
 		if (ret)
 			goto out;
@@ -2890,7 +2890,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		goto out;
 	}
 
-	if (fs_writeable(fs)) {
+	if (fs_writeable(ff)) {
 		ret = update_atime(fs, fh->ino);
 		if (ret)
 			goto out;
@@ -2922,7 +2922,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino, offset,
 		   len);
 	pthread_mutex_lock(&ff->bfl);
-	if (!fs_writeable(fs)) {
+	if (!fs_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -2995,7 +2995,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	pthread_mutex_lock(&ff->bfl);
 
 	if ((fp->flags & O_SYNC) &&
-	    fs_writeable(fs) &&
+	    fs_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
 		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
@@ -3030,7 +3030,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	/* For now, flush everything, even if it's slow */
 	pthread_mutex_lock(&ff->bfl);
-	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
+	if (fs_writeable(ff) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
@@ -3588,7 +3588,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	if (fs_writeable(i.fs)) {
+	if (fs_writeable(ff)) {
 		ret = update_atime(i.fs, fh->ino);
 		if (ret)
 			goto out;
@@ -3778,7 +3778,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino, len);
 	pthread_mutex_lock(&ff->bfl);
-	if (!fs_writeable(fs)) {
+	if (!fs_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}
@@ -4147,7 +4147,7 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	blk64_t max_blks = ext2fs_blocks_count(fs->super);
 	errcode_t err = 0;
 
-	if (!fs_writeable(fs))
+	if (!fs_writeable(ff))
 		return -EROFS;
 
 	start = FUSE2FS_B_TO_FSBT(ff, fr->start);
@@ -4520,7 +4520,6 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	ext2_filsys fs = ff->fs;
 	int ret;
 
 	/* Catch unknown flags */
@@ -4528,7 +4527,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 		return -EOPNOTSUPP;
 
 	pthread_mutex_lock(&ff->bfl);
-	if (!fs_writeable(fs)) {
+	if (!fs_writeable(ff)) {
 		ret = -EROFS;
 		goto out;
 	}


