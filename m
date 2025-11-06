Return-Path: <linux-ext4+bounces-11567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D273C3D9D5
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79ED24E36BC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701530DED7;
	Thu,  6 Nov 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCv0yMyg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A53074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468393; cv=none; b=LJflWkocZmvxVZfk415ZqoScgY9hIurg7WFjCPLX6BNbh+ZAk/1MCI9ghNuyzjizSBFIpmAx0S8iqm7Td+7bo8u3VaTjgtSsAagQa13v/j0di1Vadkqlnh9cWqy1Xho/zTZx3GWEGEg51iUIbGuoAPT4pauBAjtjnJewd5Vbviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468393; c=relaxed/simple;
	bh=dly/WFThhYnHUuCBrOZlFXxtdddwU/Q1x9e5E5bBf4o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp315NOCsaAAK0RpUY7B4XZUZTWdpGxlf7MLNPbWwmkVKz/veSbilsLGAmqmTdAbbMftXOP9lID9AvSLH+Sbpcc75ZaeAxEoM+EhEC4dqb7yriubFuam9IxPaHmQvGFXJK8bjh0P2y7RBHeLtPrUxYGzpK8jDDh76zPr+DBV5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCv0yMyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E5C113D0;
	Thu,  6 Nov 2025 22:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468393;
	bh=dly/WFThhYnHUuCBrOZlFXxtdddwU/Q1x9e5E5bBf4o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LCv0yMygZo21b+gowYrqORWoDbFpxlSKPj0RzwW+rYMBbKCmSBFTho1JUBSpjgBjt
	 xZz++mQ0NXY0i/BAZEP4ON3rnn089EBLyvYheVA7rgagI2flukjxvRtYgtUFs9PqD0
	 xc9zxnerPnhp7liMNxMCLAGjyffZYBrbE0iuiKOqlMZIFt4IR4ehYAVfg0ezAJnjRc
	 plTVz9QBQGJo6yca+fbppQ7qhnvOFg0FNPWGBamVIbSL2XILpQNHMM0Lej1L8zmNzO
	 KUQdyYGZvrrdfKBlzHl14d00CNTN5ueSWQirIg3+ejgMSbj2CnSWv0HGNnw2ilHiZk
	 d9MgyrmL0g1nQ==
Date: Thu, 06 Nov 2025 14:33:12 -0800
Subject: [PATCH 08/19] fuse2fs: use file handles when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793773.2862242.12597393308149035590.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   92 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 35 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ebb0539abc2237..5e0a1f1fd58be4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1035,6 +1035,7 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
+	cfg->nullpath_ok = 1;
 #endif
 
 	if (ff->kernel) {
@@ -1102,9 +1103,49 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	return ret;
 }
 
+static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+			      struct fuse_file_info *fp EXT2FS_ATTR((unused)),
+#endif
+			      ext2_ino_t *inop,
+			      const char *func,
+			      int line)
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
+# define fuse2fs_file_ino(ff, path, fp, inop) \
+	__fuse2fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
+#else
+# define fuse2fs_file_ino(ff, path, fp, inop) \
+	__fuse2fs_file_ino((ff), (path), NULL, (inop), __func__, __LINE__)
+#endif
+
 static int op_getattr(const char *path, struct stat *statbuf
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -1112,18 +1153,14 @@ static int op_getattr(const char *path, struct stat *statbuf
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
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	ret = stat_inode(fs, ino, statbuf);
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -2439,7 +2476,7 @@ static int in_file_group(struct fuse_context *ctxt,
 
 static int op_chmod(const char *path, mode_t mode
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2454,11 +2491,9 @@ static int op_chmod(const char *path, mode_t mode
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
@@ -2513,7 +2548,7 @@ static int op_chmod(const char *path, mode_t mode
 
 static int op_chown(const char *path, uid_t owner, gid_t group
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2528,11 +2563,9 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: path=%s owner=%d group=%d ino=%d\n", __func__,
 		   path, owner, group, ino);
 
@@ -2658,29 +2691,20 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 
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
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
-	if (!ino) {
-		ret = -ESTALE;
-		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
 
 	ret = check_inum_access(ff, ino, W_OK);
@@ -2693,7 +2717,7 @@ static int op_truncate(const char *path, off_t len
 
 out:
 	pthread_mutex_unlock(&ff->bfl);
-	return err;
+	return ret;
 }
 
 #ifdef __linux__
@@ -3747,7 +3771,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 
 static int op_utimens(const char *path, const struct timespec ctv[2]
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -3764,11 +3788,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
 		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld\n", __func__,
 			ino,
 			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,


