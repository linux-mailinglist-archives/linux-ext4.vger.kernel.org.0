Return-Path: <linux-ext4+bounces-10087-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAFB588B9
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DFC3B9FD7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DB41AAC;
	Tue, 16 Sep 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRLHQUDK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728F7494
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980837; cv=none; b=jfRFxJBwcfI5JEHqlYSv74i614O5AjZL1M9gQSj84IJLIZLoyBCGIvm40xxaLdvl5vXgIIKmMqWSFQOGcIBnsWWruYDHqeEurYd5ZjnDyAgk5HVMS3VT7sIiFx/wKsp2JV3cm1qx7g8oyKRl8CIQmIljeIbPmcMndCvGejIO7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980837; c=relaxed/simple;
	bh=4DrgGA3+So7UHcq2BZmLSvcTiYHWTAHkCDUG0pyZvSo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVd5fsZ9HlhG0bUvcq4/KoVKs8PdcfRAfUeUSKqn134OqLLB6wMPp/5LuGUaxKXfwCGdrvfp4k9YADaFS7I/1gH5/z6Gc5Hyh5EXLH8Il2bVKfMz1sR6PAUz7sd5OjexqN2muSX1sq7iKfVB62EseoUFjpYP5x2U8KEmV5+X+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRLHQUDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B69AC4CEF1;
	Tue, 16 Sep 2025 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980837;
	bh=4DrgGA3+So7UHcq2BZmLSvcTiYHWTAHkCDUG0pyZvSo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SRLHQUDK1TaTCY9xb0SIp3zRwZMo5/zN7CJ2BJpl+L8ytJgUj0zezquDX17SKnlIA
	 5/XRy6Aaf4R7+Om2faMN45doITWowHyNdtnCsvtA+UHDd2jgOU5ZP+FtQpb0T/5SHp
	 9hjXyNIJFHE64KSJ7kQbhGo9vq/aGEOMitVfVPbgQQ6yWx40+Arrgy8GAgs0Rx0STK
	 V+JCzpcPGUcQ4KXuD82xl7zs4qUzxiX3XhCyrOFl/u9J4tOf5H2tsmfwZy3Qvnzrad
	 AwLwVbywkKKKFepuh3k3tWcQyigl2RtTaal/eupga+SGADgpQR/YQfbJLTsEGHaq4a
	 ooxNv4UGSMhdg==
Date: Mon, 15 Sep 2025 17:00:36 -0700
Subject: [PATCH 6/9] fuse2fs: clean up operation startup
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064203.349283.16654328687175760357.stgit@frogsfrogsfrogs>
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

Create a helper to take the BFL and give us a reference to the
ext2_filsys that we're protecting with the BFL.  This eliminates a
theoretical race with any code that sets or clears fuse2fs:fs.  But
really it just cuts down on the boilerplate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   97 ++++++++++++++++++++++----------------------------------
 1 file changed, 38 insertions(+), 59 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ff4dd8cc0a0eea..9ea42eeeb13bfd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -437,6 +437,12 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
+static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
+{
+	pthread_mutex_lock(&ff->bfl);
+	return ff->fs;
+}
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -774,8 +780,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 
 	FUSE2FS_CHECK_CONTEXT_RETURN(ff);
 
-	pthread_mutex_lock(&ff->bfl);
-	fs = ff->fs;
+	fs = fuse2fs_start(ff);
 
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 	if (fs->flags & EXT2_FLAG_RW) {
@@ -1095,8 +1100,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -1120,8 +1124,7 @@ static int op_readlink(const char *path, char *buf, size_t len)
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
 		ret = translate_error(fs, 0, err);
@@ -1393,8 +1396,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -1524,8 +1526,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -1820,7 +1821,7 @@ static int op_unlink(const char *path)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_unlink(ff, path);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -1944,7 +1945,7 @@ static int op_rmdir(const char *path)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_rmdir(ff, path);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -1979,8 +1980,7 @@ static int op_symlink(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -2110,8 +2110,7 @@ static int op_rename(const char *from, const char *to
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
 		goto out;
@@ -2353,8 +2352,7 @@ static int op_link(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -2525,8 +2523,7 @@ static int op_chmod(const char *path, mode_t mode
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -2597,8 +2594,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -2737,7 +2733,7 @@ static int op_truncate(const char *path, off_t len
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -2867,7 +2863,7 @@ static int op_open(const char *path, struct fuse_file_info *fp)
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	ret = __op_open(ff, path, fp);
 	pthread_mutex_unlock(&ff->bfl);
 	return ret;
@@ -2891,8 +2887,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -2948,8 +2943,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;
@@ -3017,8 +3011,7 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 
 	if ((fp->flags & O_SYNC) &&
 	    fs_writeable(fs) &&
@@ -3051,8 +3044,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	/* For now, flush everything, even if it's slow */
 	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
@@ -3075,8 +3067,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	buf->f_bsize = fs->blocksize;
 	buf->f_frsize = 0;
 
@@ -3151,8 +3142,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		return -ENODATA;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3223,8 +3213,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3306,8 +3295,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		return -EINVAL;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3404,8 +3392,7 @@ static int op_removexattr(const char *path, const char *key)
 		return -ENODATA;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
@@ -3594,8 +3581,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
-	i.fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	i.fs = fuse2fs_start(ff);
 	i.buf = buf;
 	i.func = fill_func;
 	err = ext2fs_dir_iterate2(i.fs, fh->ino, 0, NULL, op_readdir_iter, &i);
@@ -3625,8 +3611,7 @@ static int op_access(const char *path, int mask)
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
 		ret = translate_error(fs, 0, err);
@@ -3672,8 +3657,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	a = *node_name;
 	*node_name = 0;
 
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
@@ -3790,8 +3774,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;
@@ -3841,8 +3824,7 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = stat_inode(fs, fh->ino, statbuf);
 	pthread_mutex_unlock(&ff->bfl);
 
@@ -3867,8 +3849,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
@@ -4280,7 +4261,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	pthread_mutex_lock(&ff->bfl);
+	fuse2fs_start(ff);
 	switch ((unsigned long) cmd) {
 #ifdef SUPPORT_I_FLAGS
 	case EXT2_IOC_GETFLAGS:
@@ -4330,8 +4311,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err) {
 		ret = translate_error(fs, 0, err);
@@ -4590,8 +4570,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
-	pthread_mutex_lock(&ff->bfl);
+	fs = fuse2fs_start(ff);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
 		goto out;


