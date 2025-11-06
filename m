Return-Path: <linux-ext4+bounces-11584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54037C3DA16
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A161883048
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC230102C;
	Thu,  6 Nov 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYefnuQa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BC2E62B3
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468665; cv=none; b=Oz1BgLpBCLjgSQBZujPizcObTfzELhzVryxiEE9IAl7GPI6649StACi+2BULL6ypq+ZJcclLZE7U1DghEh2jG4gnsPIlOpEwCXQoSpSoy436Y54aDnx5QdOJ7IoMAv3xF9iOrHYgKFt+hgLywFLJ7Ht112vaQRZBh3CNBr+eiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468665; c=relaxed/simple;
	bh=NflNO1/X2lcIRwtU+3d800TTyF2LSNssqkOkWl2sc0c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjETw1DJHwGdlPZB28NR3y0LWd7gxdyneSDadc/5uiX2FmZsj+Z/Pz8D4poDrhURS/T7LyE/CxyuElNjZDeQvSWdQXO2z6mMIwo1/JXZ81Csbs9qKa0mXgR3w8P+9wSfERwbE6FbGL4Ti0CiFGmQ3RG7ohhYVOlWhMPWufsPueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYefnuQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82567C4CEF7;
	Thu,  6 Nov 2025 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468664;
	bh=NflNO1/X2lcIRwtU+3d800TTyF2LSNssqkOkWl2sc0c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kYefnuQaMGeC4zMhy6w94f8vQ/zPzwVuImLsdsM6+WkXD7GB5rX8mEQhO7/o1Tb1o
	 nycmCA83XcTHa+jgElaVGY4ync7A2u4fMJBrHnhoUHn3VJE94X+WED4Q3GEWr7U/nU
	 3VDEMIn88BP3+1I8nJaoYah5Jh2+yohS1BWtwwcJzU2ODY1Fl24Ksv10pV0ahPlNF8
	 JBBkQdjCT1q0AGS0yYDPKJmpSFdUijLiKVmau3+Vmq8uaX4/u8B80ocsV4uzoFYSy0
	 yIRiP4w+nZ0s2V6F3+19IFu++CS2n1AiMm98akI82G13TQNenvASgnNGFTp14v4ong
	 rhWwrWnfqicSA==
Date: Thu, 06 Nov 2025 14:37:43 -0800
Subject: [PATCH 6/9] fuse2fs: clean up operation startup
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794273.2862990.9031003355759528212.stgit@frogsfrogsfrogs>
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

Create a helper to take the BFL and give us a reference to the
ext2_filsys that we're protecting with the BFL.  This eliminates a
theoretical race with any code that sets or clears fuse2fs:fs.  But
really it just cuts down on the boilerplate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   99 ++++++++++++++++++++++----------------------------------
 1 file changed, 39 insertions(+), 60 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 63c1227faa0d7a..3baeec67c2b4b7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -492,6 +492,12 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
+static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
+{
+	pthread_mutex_lock(&ff->bfl);
+	return ff->fs;
+}
+
 #ifdef CONFIG_MMP
 static bool fuse2fs_mmp_wanted(const struct fuse2fs *ff)
 {
@@ -543,7 +549,7 @@ static void fuse2fs_mmp_bthread(void *data)
 {
 	struct fuse2fs *ff = data;
 
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	if (fuse2fs_mmp_wanted(ff) && !bthread_cancelled(ff->mmp_thread))
 		fuse2fs_mmp_touch(ff, false);
 	pthread_mutex_unlock(&ff->bfl);
@@ -986,8 +992,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 
 	FUSE2FS_CHECK_CONTEXT_DESTROY(ff);
 
-	pthread_mutex_lock(&ff->bfl);
-	fs = ff->fs;
+	fs = fuse2fs_start(ff);
 
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 	if (fs->flags & EXT2_FLAG_RW) {
@@ -1314,8 +1319,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -1339,8 +1343,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
 		ret = translate_error(fs, 0, err);
@@ -1612,8 +1615,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -1743,8 +1745,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -2052,7 +2053,7 @@ static int op_unlink(const char *path)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_unlink(ff, path);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -2171,7 +2172,7 @@ static int op_rmdir(const char *path)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_rmdir(ff, path);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -2206,8 +2207,7 @@ static int op_symlink(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -2372,8 +2372,7 @@ static int op_rename(const char *from, const char *to
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
 		goto out;
@@ -2620,8 +2619,7 @@ static int op_link(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -2797,8 +2795,7 @@ static int op_chmod(const char *path, mode_t mode
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -2869,8 +2866,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -3009,7 +3005,7 @@ static int op_truncate(const char *path, off_t len
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -3139,7 +3135,7 @@ static int op_open(const char *path, struct fuse_file_info *fp)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_open(ff, path, fp);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -3163,8 +3159,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -3220,8 +3215,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;
@@ -3289,8 +3283,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 
 	if ((fp->flags & O_SYNC) &&
 	    fs_writeable(fs) &&
@@ -3323,8 +3316,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	/* For now, flush everything, even if it's slow */
 	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
@@ -3347,8 +3339,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	buf->f_bsize = fs->blocksize;
 	buf->f_frsize = 0;
 
@@ -3423,8 +3414,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		return -ENODATA;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3495,8 +3485,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3578,8 +3567,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		return -EINVAL;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3676,8 +3664,7 @@ static int op_removexattr(const char *path, const char *key)
 		return -ENODATA;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3866,8 +3853,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
-	i.fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	i.fs = fuse2fs_start(ff);
 	i.buf = buf;
 	i.func = fill_func;
 	err = ext2fs_dir_iterate2(i.fs, fh->ino, 0, NULL, op_readdir_iter, &i);
@@ -3897,8 +3883,7 @@ static int op_access(const char *path, int mask)
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
 		ret = translate_error(fs, 0, err);
@@ -3944,8 +3929,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -4062,8 +4046,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;
@@ -4113,8 +4096,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = stat_inode(fs, fh->ino, statbuf);
 	pthread_mutex_unlock(&ff->bfl);
 
@@ -4139,8 +4121,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -4552,7 +4533,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	switch ((unsigned long) cmd) {
 #ifdef SUPPORT_I_FLAGS
 	case EXT2_IOC_GETFLAGS:
@@ -4602,8 +4583,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err) {
 		ret = translate_error(fs, 0, err);
@@ -4862,8 +4842,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;


