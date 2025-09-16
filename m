Return-Path: <linux-ext4+bounces-10089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDBB588BA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8649E188932E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A632B2D7;
	Tue, 16 Sep 2025 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzkL5XZZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296262AD02
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980869; cv=none; b=pDhHxafQYYLjIXGZfbH0GzH+KPY44tSDtT1lSiXBCZMlntqXAaukO6Qg763TUe156QLSfReTKqIa76+1801i+WU0Vuz0rfXTicIS449ocS+RJv5pwJVhZ3yG9Uzw3TZ/FakKoGcJeEGg/blN0ibJOFy3wLqbwb7XNji/vEnmpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980869; c=relaxed/simple;
	bh=iq95NugmOGwI1Ox1hsvhc8uC0KhcEr98Z6dfUL9cBhU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f89xokn+SaeCllsTPWA0ZiIL10YFmvGY07DAZQuGcJwuXnPcX90AVYNezebJOuVUU3K8sLvY/B5WyiXpRyfQB1XkR4xhvjKV1ux4zJgj+mgwnB/O/VdkU/jJ6u3vQV3wsxcD3FD+qPrMXPqw0YI0URhdeqQbACZazFcxkfrBjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzkL5XZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91631C4CEF1;
	Tue, 16 Sep 2025 00:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980868;
	bh=iq95NugmOGwI1Ox1hsvhc8uC0KhcEr98Z6dfUL9cBhU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uzkL5XZZYhR78sAkklEzqXEByjwcmzmugIeEPEDrjvGu/aUKJxENRlgovdXVoBMeF
	 OH9ipj27i95wvCDvUvddlIoWleAAtkhDq6UU18n2u8lq9yHUcnSVX0eDa6MK4ve9bN
	 xreaIICZmIgEtfc+14wCK5mFCYImnD7pkJOCJP+pHLYT7zrzNzgD68/sxfVEvYLi10
	 9IskKKTaFijNiRHWRIONlq6jeC5yAJfVzYy02KVHNJHCTZh5j1vbJmAT5S1KXUfeBM
	 2sF7uNn6SjzXlsGtSaEu9vJz7dsMAiHyc8VyHKIDAmzT444IcKtHS82x922GI+0VQR
	 yKnzv4xbTQUOQ==
Date: Mon, 15 Sep 2025 17:01:08 -0700
Subject: [PATCH 8/9] fuse2fs: clean up more boilerplate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064239.349283.7180905633207368855.stgit@frogsfrogsfrogs>
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

Clean up these opencoded bits everywhere.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  146 +++++++++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 82 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b856cc3a6f23ed..23420c23be240c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -437,6 +437,25 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
+static inline struct fuse2fs *fuse2fs_get(void)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+
+	return ctxt->private_data;
+}
+
+static inline struct fuse2fs_file_handle *
+fuse2fs_get_handle(const struct fuse_file_info *fp)
+{
+	return (struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+}
+
+static inline void
+fuse2fs_set_handle(struct fuse_file_info *fp, struct fuse2fs_file_handle *fh)
+{
+	fp->fh = (uintptr_t)fh;
+}
+
 static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
 {
 	pthread_mutex_lock(&ff->bfl);
@@ -782,8 +801,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 
@@ -955,8 +973,7 @@ static void *op_init(struct fuse_conn_info *conn
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 
 	FUSE2FS_CHECK_CONTEXT_ABORT(ff);
@@ -1069,8 +1086,7 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (fp) {
-		struct fuse2fs_file_handle *fh =
-			(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+		struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 
 		if (fh->ino == 0)
 			return -ESTALE;
@@ -1102,8 +1118,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t ino;
 	int ret = 0;
@@ -1121,8 +1136,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 
 static int op_readlink(const char *path, char *buf, size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -1377,7 +1391,7 @@ static void fuse2fs_set_extra_isize(struct fuse2fs *ff, ext2_ino_t ino,
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -1506,7 +1520,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 static int op_mkdir(const char *path, mode_t mode)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -1825,8 +1839,7 @@ static int __op_unlink(struct fuse2fs *ff, const char *path)
 
 static int op_unlink(const char *path)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -1949,8 +1962,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 
 static int op_rmdir(const char *path)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -1963,7 +1975,7 @@ static int op_rmdir(const char *path)
 static int op_symlink(const char *src, const char *dest)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -2099,8 +2111,7 @@ static int op_rename(const char *from, const char *to
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t from_ino, to_ino, to_dir_ino, from_dir_ino;
@@ -2335,8 +2346,7 @@ static int op_rename(const char *from, const char *to
 
 static int op_link(const char *src, const char *dest)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	char *temp_path;
 	errcode_t err;
@@ -2480,7 +2490,7 @@ static int get_req_groups(struct fuse2fs *ff, gid_t **gids, size_t *nr_gids)
 static int in_file_group(struct fuse_context *ctxt,
 			 const struct ext2_inode_large *inode)
 {
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	gid_t *gids = NULL;
 	size_t i, nr_gids = 0;
 	gid_t gid = inode_gid(*inode);
@@ -2524,7 +2534,7 @@ static int op_chmod(const char *path, mode_t mode
 			)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -2595,7 +2605,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 			)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -2736,8 +2746,7 @@ static int op_truncate(const char *path, off_t len
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_ino_t ino;
 	int ret = 0;
 
@@ -2857,7 +2866,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	}
 
 	file->check_flags = check;
-	fp->fh = (uintptr_t)file;
+	fuse2fs_set_handle(fp, file);
 
 out:
 	if (ret)
@@ -2867,8 +2876,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 
 static int op_open(const char *path, struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -2882,10 +2890,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	ext2_file_t efp;
 	errcode_t err;
@@ -2938,10 +2944,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		    const char *buf, size_t len, off_t offset,
 		    struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	ext2_file_t efp;
 	errcode_t err;
@@ -3009,10 +3013,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 static int op_release(const char *path EXT2FS_ATTR((unused)),
 		      struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	errcode_t err;
 	int ret = 0;
@@ -3042,10 +3044,8 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 		    int datasync EXT2FS_ATTR((unused)),
 		    struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	errcode_t err;
 	int ret = 0;
@@ -3068,8 +3068,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 		     struct statvfs *buf)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	uint64_t fsid, *f;
 	blk64_t overhead, reserved, free;
@@ -3138,8 +3137,7 @@ static int validate_xattr_name(const char *name)
 static int op_getxattr(const char *path, const char *key, char *value,
 		       size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	void *ptr;
 	size_t plen;
@@ -3212,8 +3210,7 @@ static int copy_names(char *name, char *value EXT2FS_ATTR((unused)),
 
 static int op_listxattr(const char *path, char *names, size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	unsigned int bufsz;
@@ -3289,8 +3286,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		       const char *key, const char *value,
 		       size_t len, int flags)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	ext2_ino_t ino;
@@ -3380,8 +3376,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 
 static int op_removexattr(const char *path, const char *key)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	void *buf;
@@ -3571,10 +3566,8 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	errcode_t err;
 	struct readdir_iter i = {
 		.ff = ff,
@@ -3611,8 +3604,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 static int op_access(const char *path, int mask)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -3639,7 +3631,7 @@ static int op_access(const char *path, int mask)
 static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -3770,10 +3762,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 			off_t len, struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	ext2_file_t efp;
 	errcode_t err;
@@ -3823,11 +3813,9 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 		       struct stat *statbuf,
 		       struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3847,8 +3835,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	struct timespec tv[2];
 	ext2_filsys fs;
 	errcode_t err;
@@ -4262,10 +4249,8 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		    struct fuse_file_info *fp,
 		    unsigned int flags EXT2FS_ATTR((unused)), void *data)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -4312,8 +4297,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 		   uint64_t *idx)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t ino;
 	errcode_t err;
@@ -4566,10 +4550,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 			off_t offset, off_t len,
 			struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	struct fuse2fs_file_handle *fh =
-		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+	struct fuse2fs *ff = fuse2fs_get();
+	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
 	int ret;
 


