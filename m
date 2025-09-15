Return-Path: <linux-ext4+bounces-10067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F426B587AD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FAE1B25930
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8122D47F2;
	Mon, 15 Sep 2025 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caZYJiso"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9382C11FE
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976098; cv=none; b=POTzcl47T2yt2acLQu+hN7UHo9Ueysy5hGcCYosT/keC90OfDYLWkoSayC1TRrV86T96+npWagE5qCU60I4woeHJz+74ZD6Zeply+Ra8cRolM4cVofOZIEEjs0hvbSAAuTuB8oc0covPwx4jZJUkv7nff6wSYtRzjVuAeP+K1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976098; c=relaxed/simple;
	bh=ImpaEAxK+Hzy4vH7IbI7RDqVOeXm1CD/qFLSA3MyGIE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZRhysroRHdiwcfi/Pf4SAI45BN/DNSImP69wKDoxW/pIX642BikbeLkQkVZ9bKpz5X+XAeP9hnzKEh3yGFa/ZG4oFINSdYGBvKtZ5MsGyAZymQsZ1ek+08SeJgoCO4KPoAaZZb87oTKzsuPPuRSe8r1CiyTw3lsHe7zEnQobfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caZYJiso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342ECC4CEF1;
	Mon, 15 Sep 2025 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976098;
	bh=ImpaEAxK+Hzy4vH7IbI7RDqVOeXm1CD/qFLSA3MyGIE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=caZYJisong1ILZ2VINMOSRRma4RKsR27UZy3sqkvGuMHZvUtLXH7YKtni/f2EOhYi
	 4a1MqNdsqvlslw6OjpvYPy9AkCroSBiFA8f8/Lw5cddrBtj2eyfONIcxMvlxKws9vJ
	 ZiYt3smxMhbcDJ53b5L3QlFLIfoqmj2wyuT/VNDBVYxZztR/5mRb+aE5F7ejVTCJCH
	 EB9NnGlqMPp/Sl4nqxMJujEbxFPi2O7EuvYW09flvEZLD+pLPTnB3Vod16/1hyArte
	 tbXf2vjTCyhNuh0Is9+Pu4l0C58YTRdSS+yKcD8OJn0lowxVUcfkQ5KxMp05oIskcw
	 he4UhKh6zLhpQ==
Date: Mon, 15 Sep 2025 15:41:37 -0700
Subject: [PATCH 03/11] fuse2fs: use file handles when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570067.246189.131100058556689390.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
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
index 438ac1194082b8..c756d9789979c7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -955,6 +955,7 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
+	cfg->nullpath_ok = 1;
 #endif
 
 	if (ff->kernel) {
@@ -1022,9 +1023,49 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
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
@@ -1032,18 +1073,14 @@ static int op_getattr(const char *path, struct stat *statbuf
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
@@ -2359,7 +2396,7 @@ static int in_file_group(struct fuse_context *ctxt,
 
 static int op_chmod(const char *path, mode_t mode
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2374,11 +2411,9 @@ static int op_chmod(const char *path, mode_t mode
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
@@ -2433,7 +2468,7 @@ static int op_chmod(const char *path, mode_t mode
 
 static int op_chown(const char *path, uid_t owner, gid_t group
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -2448,11 +2483,9 @@ static int op_chown(const char *path, uid_t owner, gid_t group
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
 
@@ -2578,29 +2611,20 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 
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
@@ -2613,7 +2637,7 @@ static int op_truncate(const char *path, off_t len
 
 out:
 	pthread_mutex_unlock(&ff->bfl);
-	return err;
+	return ret;
 }
 
 #ifdef __linux__
@@ -3667,7 +3691,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 
 static int op_utimens(const char *path, const struct timespec ctv[2]
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
+			, struct fuse_file_info *fi
 #endif
 			)
 {
@@ -3684,11 +3708,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
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


