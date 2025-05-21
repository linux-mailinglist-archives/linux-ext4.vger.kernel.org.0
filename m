Return-Path: <linux-ext4+bounces-8112-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F5ABFFE5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894B41BC3B41
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131023BD17;
	Wed, 21 May 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfkIiQmd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960B23BCFF
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867413; cv=none; b=Pz0P57tzEQtDavro6RKgkEDkAqoTMXLJx9MX1TcsWqXV4tXNHgC4iQOPLknZBuKefi5/xxXkIKIr1RdV+dIOyHm+AXS1ZXQ1Z+uGrmo2TE/PL6y+qRmpPUX4BM5Kbv1++tR/a5CDwRWLiF7tgzFDyEFibX5QqtyKSj4A1FlmsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867413; c=relaxed/simple;
	bh=lu3laHiXCZ8HURxkd+PeVFnS9lBS1U6vgZggYs65zbY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+YeMufvD0aJ1JScr2KzPYuzS2ung3AHvc/SDB4Jhtx8C8NEH/2lYf4WdjSKWq2wN2FXYhV4PYu92OBu/e5mm/8pxwTECyzg0nOSz/8ONroCCiDBqULDTAwOraC7p/EthzQpZTExRdsnS9cXKlrjOKHI1w2sy+au+p4onTAuhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfkIiQmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86476C4CEE4;
	Wed, 21 May 2025 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867413;
	bh=lu3laHiXCZ8HURxkd+PeVFnS9lBS1U6vgZggYs65zbY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XfkIiQmddQ4o6aG0hxg19eGjq6ktKPldIaE0RNs24aNMaBr/VjrZRf9RrGU9oE9f8
	 1g/UYIqpWA3iQpD1MrIysGU7D0hUDu5budqQsHr3xCpeELzWaBHwSKiExrj4Fj5uFR
	 lTEkHxG0wj/I9b3BJ5fD7GPuWxn8G1OUbx8j1M0HSLGyGyfAnBrdVunoVX/SnQHh3T
	 Qz57/dxnFHcu9aptVN6iLPGJ1Bks/EN+UH3oLKHy9rjzjqwOtiW1ZWq+zbDr8K/r0X
	 6DHrh3q5u3u+s4VK0MFB3+7YsgYPOqQ8wbZrrsa4zdNEfxKAXuhz56GD0R+tXRhpuR
	 NAaOzyYTYUx5g==
Date: Wed, 21 May 2025 15:43:33 -0700
Subject: [PATCH 1/7] fuse2fs: use file handles when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678417.1385038.7137986464704269574.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
References: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use file handles when possible, so the f* family of file syscalls
doesn't have to do a complete path lookup for every single call.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   90 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 34 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9c1e5b00703bbe..de5cfa3d776127 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -737,6 +737,7 @@ static void *op_init(struct fuse_conn_info *conn
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
+	cfg->nullpath_ok = 1;
 #endif
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_mnt_count++;
@@ -802,9 +803,49 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	return ret;
 }
 
+static int __path_or_file_info_to_ino(struct fuse2fs *ff, const char *path,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+			struct fuse_file_info *fp EXT2FS_ATTR((unused)),
+#endif
+			ext2_ino_t *inop,
+			const char *func,
+			int line)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	if (fp) {
+		struct fuse2fs_file_handle *fh =
+			(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+
+		if (fh->ino == 0)
+			return -ESTALE;
+
+		*inop = fh->ino;
+		dbg_printf(ff, "%s: get ino=%d\n", func, fh->ino);
+		return 0;
+	}
+#endif
+	dbg_printf(ff, "%s: get path=%s\n", func, path);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, inop);
+	if (err)
+		return __translate_error(fs, 0, err, func, line);
+
+	return 0;
+}
+
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+# define path_or_file_info_to_ino(ff, path, fp, inop) \
+	__path_or_file_info_to_ino((ff), (path), (fp), (inop), __func__, __LINE__)
+#else
+# define path_or_file_info_to_ino(ff, path, fp, inop) \
+	__path_or_file_info_to_ino((ff), (path), NULL, (inop), __func__, __LINE__)
+#endif
+
 static int op_getattr(const char *path, struct stat *statbuf
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -812,18 +853,14 @@ static int op_getattr(const char *path, struct stat *statbuf
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 	ext2_ino_t ino;
-	errcode_t err;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
-	dbg_printf(ff, "%s: path=%s\n", __func__, path);
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = path_or_file_info_to_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	ret = stat_inode(fs, ino, statbuf);
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -2108,7 +2145,7 @@ static int in_file_group(struct fuse_context *ctxt,
 
 static int op_chmod(const char *path, mode_t mode
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2123,11 +2160,9 @@ static int op_chmod(const char *path, mode_t mode
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = path_or_file_info_to_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
@@ -2182,7 +2217,7 @@ static int op_chmod(const char *path, mode_t mode
 
 static int op_chown(const char *path, uid_t owner, gid_t group
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2197,11 +2232,9 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = path_or_file_info_to_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: path=%s owner=%d group=%d ino=%d\n", __func__,
 		   path, owner, group, ino);
 
@@ -2324,29 +2357,20 @@ static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 
 static int op_truncate(const char *path, off_t len
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	ext2_filsys fs;
 	ext2_ino_t ino;
-	errcode_t err;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = path_or_file_info_to_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
-	if (!ino) {
-		ret = -ESTALE;
-		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, len);
 
 	ret = check_inum_access(ff, ino, W_OK);
@@ -3412,7 +3436,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 
 static int op_utimens(const char *path, const struct timespec ctv[2]
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -3429,11 +3453,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = path_or_file_info_to_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld\n", __func__,
 			ino,
 			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,


