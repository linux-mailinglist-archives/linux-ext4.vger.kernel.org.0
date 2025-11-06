Return-Path: <linux-ext4+bounces-11570-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE12C3D9E0
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8283B188C4EC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744A30DED7;
	Thu,  6 Nov 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0tbCy+C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045933074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468441; cv=none; b=awDtaXA/L1NglfELY5gO+sawKcXdF445SpTufRaUQt+QWbhV0cV2++u5uQAiJU1eNS4ubLrNOAA6F99GL4o0ZI253HbmIHKfgwWfBSUdgYOdCG9foaVWFY8PrlAVMge2c9XRO9KmPV1bWIaqRdIBJdZjNTaugufrvhkrjWqPAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468441; c=relaxed/simple;
	bh=QR8RrhxpAoMktf0xGm5QWuDgQ4N5egihqYnu/MMqhoU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxE1ADSbovFiKrKtGazlU2i4s5i13oVegAv12q4uR7oINQvXwAoGnLLrumDWmLH1+Qy0ibGya1HJiHduHcpovkvVKVkjBnhQfUqXjSTbwYfoJcVSUG4Pw778Yc4/R24OJrR6HgStnVPBOtlvxS7xtLLMGu3Vfxzrv+3wVTn/6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0tbCy+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F0C4CEFB;
	Thu,  6 Nov 2025 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468440;
	bh=QR8RrhxpAoMktf0xGm5QWuDgQ4N5egihqYnu/MMqhoU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o0tbCy+CWuELthfcftIX9g0GjQ+oxtFjrC28gkvHcLODaS2VBVjiRbMHruJPY5gBk
	 T/slbl4hTbxHixKmBM8eJ2vCszlBfqfy29zYbBHOGFUB/B9CayDQoOEGI9V4MmzNCG
	 AW+RdEshU4DEyLxapGoK7EDZeTzR85ZO8OtZfm3ETuK9z0bfpz9YF+0k4SlDFDvMYD
	 BBTxN5x1hki0+bHPhBPCrMKro8PK5pu1qw9iyES3Dda19iV4tbn7zvI1AtFNNXvol1
	 /YZWlhBhN3qN7WuwH0b8PQ3HjS/v3nQ2APXaQLzn5hc/NkCE/ahduVe9fqUNNnfPZW
	 m3r07ofMdVdkQ==
Date: Thu, 06 Nov 2025 14:34:00 -0800
Subject: [PATCH 11/19] fuse2fs: implement dirsync mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793827.2862242.13201485872962605306.stgit@frogsfrogsfrogs>
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

Implement dirsync so that we only perform full metadata flushes on
directory updates when the sysadmin explicitly wants it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.1.in |    3 +
 misc/fuse2fs.c    |  111 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 102 insertions(+), 12 deletions(-)


diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 69fc6b01d7b639..b18b7f3464bc74 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -57,6 +57,9 @@ .SS "fuse2fs options:"
 \fB-o\fR direct
 Use O_DIRECT to access the block device.
 .TP
+\fB-o\fR dirsync
+Flush dirty metadata to disk after every directory update.
+.TP
 \fB-o\fR errors=panic
 dump core on error
 .TP
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 16492d54f7ed1d..0b4f7f10ddc97f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -232,6 +232,7 @@ struct fuse2fs {
 	int kernel;
 	int directio;
 	int acl;
+	int dirsync;
 
 	int logfd;
 	int blocklog;
@@ -1367,6 +1368,41 @@ static int fuse2fs_new_child_gid(struct fuse2fs *ff, ext2_ino_t parent,
 	return 0;
 }
 
+/*
+ * Flush dirty data to disk if we're running in dirsync mode.  If @flushed is a
+ * non-null pointer, this function sets @flushed to 1 if we decided to flush
+ * data, or 0 if not.
+ */
+static inline int fuse2fs_dirsync_flush(struct fuse2fs *ff, ext2_ino_t ino,
+					int *flushed)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ff->dirsync)
+		goto flush;
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, 0, err);
+
+	if (inode.i_flags & EXT2_DIRSYNC_FL)
+		goto flush;
+
+	if (flushed)
+		*flushed = 0;
+	return 0;
+flush:
+	err = ext2fs_flush2(fs, 0);
+	if (err)
+		return translate_error(fs, 0, err);
+
+	if (flushed)
+		*flushed = 1;
+	return 0;
+}
+
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -1486,6 +1522,11 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out2;
+
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -1615,6 +1656,10 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (ret)
 		goto out3;
 
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out3;
+
 out3:
 	ext2fs_free_mem(&block);
 out2:
@@ -1624,7 +1669,8 @@ static int op_mkdir(const char *path, mode_t mode)
 	return ret;
 }
 
-static int unlink_file_by_name(struct fuse2fs *ff, const char *path)
+static int fuse2fs_unlink(struct fuse2fs *ff, const char *path,
+			  ext2_ino_t *parent)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -1660,7 +1706,13 @@ static int unlink_file_by_name(struct fuse2fs *ff, const char *path)
 	if (err)
 		return translate_error(fs, dir, err);
 
-	return update_mtime(fs, dir, NULL);
+	ret = update_mtime(fs, dir, NULL);
+	if (ret)
+		return ret;
+
+	if (parent)
+		*parent = dir;
+	return 0;
 }
 
 static int remove_ea_inodes(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1772,7 +1824,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 static int __op_unlink(struct fuse2fs *ff, const char *path)
 {
 	ext2_filsys fs = ff->fs;
-	ext2_ino_t ino;
+	ext2_ino_t parent, ino;
 	errcode_t err;
 	int ret = 0;
 
@@ -1786,13 +1838,18 @@ static int __op_unlink(struct fuse2fs *ff, const char *path)
 	if (ret)
 		goto out;
 
-	ret = unlink_file_by_name(ff, path);
+	ret = fuse2fs_unlink(ff, path, &parent);
 	if (ret)
 		goto out;
 
 	ret = remove_inode(ff, ino);
 	if (ret)
 		goto out;
+
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out;
+
 out:
 	return ret;
 }
@@ -1841,7 +1898,7 @@ static int rmdir_proc(ext2_ino_t dir EXT2FS_ATTR((unused)),
 static int __op_rmdir(struct fuse2fs *ff, const char *path)
 {
 	ext2_filsys fs = ff->fs;
-	ext2_ino_t child;
+	ext2_ino_t parent, child;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	struct rd_struct rds;
@@ -1882,7 +1939,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		goto out;
 	}
 
-	ret = unlink_file_by_name(ff, path);
+	ret = fuse2fs_unlink(ff, path, &parent);
 	if (ret)
 		goto out;
 	/* Directories have to be "removed" twice. */
@@ -1913,6 +1970,10 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		}
 	}
 
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out;
+
 out:
 	return ret;
 }
@@ -2028,6 +2089,11 @@ static int op_symlink(const char *src, const char *dest)
 		ret = translate_error(fs, child, err);
 		goto out2;
 	}
+
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -2073,6 +2139,7 @@ static int op_rename(const char *from, const char *to
 	char *cp, a;
 	struct ext2_inode inode;
 	struct update_dotdot ud;
+	int flushed = 0;
 	int ret = 0;
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
@@ -2276,14 +2343,19 @@ static int op_rename(const char *from, const char *to
 		goto out2;
 
 	/* Remove the old file */
-	ret = unlink_file_by_name(ff, from);
+	ret = fuse2fs_unlink(ff, from, NULL);
 	if (ret)
 		goto out2;
 
-	/* Flush the whole mess out */
-	err = ext2fs_flush2(fs, 0);
-	if (err)
-		ret = translate_error(fs, 0, err);
+	ret = fuse2fs_dirsync_flush(ff, from_dir_ino, &flushed);
+	if (ret)
+		goto out2;
+
+	if (from_dir_ino != to_dir_ino && !flushed) {
+		ret = fuse2fs_dirsync_flush(ff, to_dir_ino, NULL);
+		if (ret)
+			goto out2;
+	}
 
 out2:
 	free(temp_from);
@@ -2380,6 +2452,10 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -3722,6 +3798,11 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	ret = __op_open(ff, path, fp);
 	if (ret)
 		goto out2;
+
+	ret = fuse2fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out2;
+
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -4661,6 +4742,7 @@ enum {
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
 	FUSE2FS_CACHE_SIZE,
+	FUSE2FS_DIRSYNC,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -4681,12 +4763,13 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("directio",		directio,		1),
 	FUSE2FS_OPT("acl",		acl,			1),
 	FUSE2FS_OPT("noacl",		acl,			0),
+	FUSE2FS_OPT("lockfile=%s",	lockfile,		0),
 
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
-	FUSE2FS_OPT("lockfile=%s",	lockfile,		0),
+	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -4703,6 +4786,10 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	struct fuse2fs *ff = data;
 
 	switch (key) {
+	case FUSE2FS_DIRSYNC:
+		ff->dirsync = 1;
+		/* pass through to libfuse */
+		return 1;
 	case FUSE_OPT_KEY_NONOPT:
 		if (!ff->device) {
 			ff->device = strdup(arg);


