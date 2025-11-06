Return-Path: <linux-ext4+bounces-11586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA474C3DA1C
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7B764E22ED
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868113019A6;
	Thu,  6 Nov 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZWPXaYC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9A2DF138
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468697; cv=none; b=Ivv9RmSTfqcKHLFCxDZpohu26k1p6tBqEJMhl3SWjSIf9d6X/HuZhlvXW6O3MGQWuQFsrOu5iIi85fJZjeioSkjuk3ccpxH37WBjGBSmbbH6bd8sOY5LHGzV+TNzKsM0l8a/gDYf7K+ZlEJBF9NRExSnX4vQiUJYlR/vduTbUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468697; c=relaxed/simple;
	bh=Q9ujx1d/VvAKJsHxhB9A61ziAV6uOIJ6vf9cZV6gDa8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOtWO2K8Z7UTZLcltPunV4FMvGwAJMNT4QnW3tjB3CAlcsBf4uC9vcuBMRi00GnU/ltUylCbByWGLYQv7sLEUsRzRvJOMAZO2/hBXnx6hiRpOCL/I7jflqCcNsRM7P/jiXhSebXtW1lM10TcEpl0F802kLSX3HrX8RX3Ui6Mg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZWPXaYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C061C4CEFB;
	Thu,  6 Nov 2025 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468696;
	bh=Q9ujx1d/VvAKJsHxhB9A61ziAV6uOIJ6vf9cZV6gDa8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uZWPXaYC9S1P/HH+QLpn6iP1JI8WeUu/JKNC9qWvxwtq3YwEJWt2cyGrnCd52h+Dp
	 sACpO2ugYjUKPlRA2aV/Dq7pivqqQ4eyHoo7iHZ+QVNn+IPH51LdsrmhTUPEH35ocl
	 b/DdcL3vKFKfmQDcVgjcftlnh7Mqt1SBxiHVxjr0G4npd0V+1owc6GHMBbEouOXl+3
	 Ifu2VrLtT5uGYAqpN5+MNlo96TVI7ezwGtaEaI2+HSXq2dERYAk4ZnI1hoLmlZkuFk
	 Qrr2fAaqeORVDm9h3o3C1HX0WSYGVRXBr1cWo6zg+Q5S3FRE+kpTYqhZ8aiekFuNk2
	 B9R3bmHSC+YdQ==
Date: Thu, 06 Nov 2025 14:38:15 -0800
Subject: [PATCH 8/9] fuse2fs: clean up more boilerplate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794309.2862990.6850255103803990845.stgit@frogsfrogsfrogs>
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

Clean up these opencoded bits everywhere.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  146 +++++++++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 82 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 77d0eddbe805dc..9d50ebb6d08f8a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -634,6 +634,25 @@ static void fuse2fs_mmp_destroy(struct fuse2fs *ff)
 # define fuse2fs_mmp_destroy(...)	((void)0)
 #endif
 
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
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -994,8 +1013,7 @@ static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
 
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 
@@ -1167,8 +1185,7 @@ static void *op_init(struct fuse_conn_info *conn
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 
 	FUSE2FS_CHECK_CONTEXT_INIT(ff);
@@ -1288,8 +1305,7 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (fp) {
-		struct fuse2fs_file_handle *fh =
-			(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
+		struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 
 		if (fh->ino == 0)
 			return -ESTALE;
@@ -1321,8 +1337,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t ino;
 	int ret = 0;
@@ -1340,8 +1355,7 @@ static int op_getattr(const char *path, struct stat *statbuf
 
 static int op_readlink(const char *path, char *buf, size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -1596,7 +1610,7 @@ static void fuse2fs_set_extra_isize(struct fuse2fs *ff, ext2_ino_t ino,
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -1725,7 +1739,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 static int op_mkdir(const char *path, mode_t mode)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -2057,8 +2071,7 @@ static int __op_unlink(struct fuse2fs *ff, const char *path)
 
 static int op_unlink(const char *path)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -2176,8 +2189,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 
 static int op_rmdir(const char *path)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -2190,7 +2202,7 @@ static int op_rmdir(const char *path)
 static int op_symlink(const char *src, const char *dest)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -2361,8 +2373,7 @@ static int op_rename(const char *from, const char *to
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t from_ino, to_ino, to_dir_ino, from_dir_ino;
@@ -2602,8 +2613,7 @@ static int op_rename(const char *from, const char *to
 
 static int op_link(const char *src, const char *dest)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	char *temp_path;
 	errcode_t err;
@@ -2752,7 +2762,7 @@ static int get_req_groups(struct fuse2fs *ff, gid_t **gids, size_t *nr_gids)
 static int in_file_group(struct fuse_context *ctxt,
 			 const struct ext2_inode_large *inode)
 {
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	gid_t *gids = NULL;
 	size_t i, nr_gids = 0;
 	gid_t gid = inode_gid(*inode);
@@ -2796,7 +2806,7 @@ static int op_chmod(const char *path, mode_t mode
 			)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -2867,7 +2877,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 			)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -3008,8 +3018,7 @@ static int op_truncate(const char *path, off_t len
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_ino_t ino;
 	int ret = 0;
 
@@ -3129,7 +3138,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	}
 
 	file->check_flags = check;
-	fp->fh = (uintptr_t)file;
+	fuse2fs_set_handle(fp, file);
 
 out:
 	if (ret)
@@ -3139,8 +3148,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 
 static int op_open(const char *path, struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3154,10 +3162,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
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
@@ -3210,10 +3216,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -3281,10 +3285,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
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
@@ -3314,10 +3316,8 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
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
@@ -3340,8 +3340,7 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 		     struct statvfs *buf)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	uint64_t fsid, *f;
 	blk64_t overhead, reserved, free;
@@ -3410,8 +3409,7 @@ static int validate_xattr_name(const char *name)
 static int op_getxattr(const char *path, const char *key, char *value,
 		       size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	void *ptr;
 	size_t plen;
@@ -3484,8 +3482,7 @@ static int copy_names(char *name, char *value EXT2FS_ATTR((unused)),
 
 static int op_listxattr(const char *path, char *names, size_t len)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	unsigned int bufsz;
@@ -3561,8 +3558,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		       const char *key, const char *value,
 		       size_t len, int flags)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	ext2_ino_t ino;
@@ -3652,8 +3648,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 
 static int op_removexattr(const char *path, const char *key)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	void *buf;
@@ -3843,10 +3838,8 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
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
@@ -3883,8 +3876,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 static int op_access(const char *path, int mask)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
@@ -3911,7 +3903,7 @@ static int op_access(const char *path, int mask)
 static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
 	char *temp_path;
@@ -4042,10 +4034,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
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
@@ -4095,11 +4085,9 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
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
@@ -4119,8 +4107,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 #endif
 			)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	struct timespec tv[2];
 	ext2_filsys fs;
 	errcode_t err;
@@ -4534,10 +4521,8 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
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
@@ -4584,8 +4569,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 		   uint64_t *idx)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	ext2_ino_t ino;
 	errcode_t err;
@@ -4838,10 +4822,8 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
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
 


