Return-Path: <linux-ext4+bounces-7483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8EA9BA15
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3EF7A82D4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0221E087;
	Thu, 24 Apr 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+OjGu5Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153921F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531098; cv=none; b=XUokfWeyiFnV83A7v9ZlJybh+/Z9xiIV6XAKMDDk1KF4LQVaJKTTyFF2t1uCvaM7AM2X+FPSarScbbWu60ru9V/VLBqa8mfthk220if8dBsmk8GKXwf92L9Kj1WNp7PFjK8Z0xacVZQTgRMbhK5SfoEjI6WPDy/RnqxddHBb0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531098; c=relaxed/simple;
	bh=Sv1cI1AZcgkhXBHNMhit9FDF8UKfsaOU1+TNtKK9IHg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTLvC96YWuGPvEYYbGK7XNyGZGvXWelaiw7s0DhDHqI4SDUCEZfEL7qxTXTu7XF6aXy1r0z3D7o5FvMwMyREUq2sVS0Da9NLUurryQqTXiSNZoD6QUsIKA9SS0CNkpq9XukxJg6s6UST5Wc20iIH/Ftc/Th9kuAT8iYeqTdoPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+OjGu5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1F1C4CEE3;
	Thu, 24 Apr 2025 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531097;
	bh=Sv1cI1AZcgkhXBHNMhit9FDF8UKfsaOU1+TNtKK9IHg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t+OjGu5Z5K9bQyjLH7J7gGCheO3iijqYFP2IkhNgL1r8ZqLBsiQpBjb2x21vU0uBG
	 yfCkhDIfzDeqOZRlTa7CR6oW/7JPiltXK90wALpu+HezLbhmIzKYF3w4Ha17ap01x6
	 OQ/And9nZ9HorU1YGYqVzvyf1WJJIfOvHq+7+vYpL2SFyDLuj/JBXR8WP7yIQKzQtU
	 +ieZqO/osdAafGtLGtJucFwHI7SOB1bdJXRwiqB3CoQTnn32z0HTmMI7NWCfcvdqTD
	 zSN43CEYR6rgGBFd/EpTBEEtHbdDupZS4L4dG0nhH/EwD7AqKjz0WkFcFV2tfBbZXg
	 9Eys3QR9qskbw==
Date: Thu, 24 Apr 2025 14:44:57 -0700
Subject: [PATCH 16/16] fuse2fs: report inode number and file type via readdir
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065213.1160461.4431922817174080124.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report the inode number and file type in readdir to speed up directory
iteration a bit.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5a6b607ead9b4b..480463e0bc4b1c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2594,9 +2594,36 @@ static int op_removexattr(const char *path, const char *key)
 
 struct readdir_iter {
 	void *buf;
+	ext2_filsys fs;
 	fuse_fill_dir_t func;
 };
 
+static inline mode_t dirent_fmode(ext2_filsys fs,
+				   const struct ext2_dir_entry *dirent)
+{
+	if (!ext2fs_has_feature_filetype(fs->super))
+		return 0;
+
+	switch (ext2fs_dirent_file_type(dirent)) {
+	case EXT2_FT_REG_FILE:
+		return S_IFREG;
+	case EXT2_FT_DIR:
+		return S_IFDIR;
+	case EXT2_FT_CHRDEV:
+		return S_IFCHR;
+	case EXT2_FT_BLKDEV:
+		return S_IFBLK;
+	case EXT2_FT_FIFO:
+		return S_IFIFO;
+	case EXT2_FT_SOCK:
+		return S_IFSOCK;
+	case EXT2_FT_SYMLINK:
+		return S_IFLNK;
+	}
+
+	return 0;
+}
+
 static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			   int entry EXT2FS_ATTR((unused)),
 			   struct ext2_dir_entry *dirent,
@@ -2606,11 +2633,15 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 {
 	struct readdir_iter *i = data;
 	char namebuf[EXT2_NAME_LEN + 1];
+	struct stat stat = {
+		.st_ino = dirent->inode,
+		.st_mode = dirent_fmode(i->fs, dirent),
+	};
 	int ret;
 
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
-	ret = i->func(i->buf, namebuf, NULL, 0
+	ret = i->func(i->buf, namebuf, &stat, 0
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, 0
 #endif
@@ -2634,26 +2665,25 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	struct fuse2fs_file_handle *fh =
 		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
-	ext2_filsys fs;
 	errcode_t err;
 	struct readdir_iter i;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	i.fs = ff->fs;
+	FUSE2FS_CHECK_MAGIC(i.fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 	i.buf = buf;
 	i.func = fill_func;
-	err = ext2fs_dir_iterate2(fs, fh->ino, 0, NULL, op_readdir_iter, &i);
+	err = ext2fs_dir_iterate2(i.fs, fh->ino, 0, NULL, op_readdir_iter, &i);
 	if (err) {
-		ret = translate_error(fs, fh->ino, err);
+		ret = translate_error(i.fs, fh->ino, err);
 		goto out;
 	}
 
-	if (fs_writeable(fs)) {
-		ret = update_atime(fs, fh->ino);
+	if (fs_writeable(i.fs)) {
+		ret = update_atime(i.fs, fh->ino);
 		if (ret)
 			goto out;
 	}


