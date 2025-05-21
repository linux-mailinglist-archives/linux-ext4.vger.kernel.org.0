Return-Path: <linux-ext4+bounces-8128-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A850AC0002
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE941BC154B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB322B8B6;
	Wed, 21 May 2025 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swVpKmIe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A61EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867664; cv=none; b=qNFmhw/k7WuBvPxnIUpNNTC9XavgVmXdoJhdUCLeSVmW/fOEc6U5Xi3ODvkc6LDQcr2fSngHspyv5GV8b2hhGNkAJfq1rRrcRNfsDz/gVV4QyCGIe2v4YGLaRco/fooe57zJUXKBOHwpfIqE6EOVljRuGCNNOOL++MZsTTu4TIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867664; c=relaxed/simple;
	bh=A4cZK6Iw9WR3OYTGltfi2J19vQGIsLUyK/I4d/7MEtA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPfbuuaUbDsWaKh+LktSEcW2Qc6iOb/u6OkwUtWY8vgmICuBq7IOKjC/wGOQh9IOrUpsM0Tkx/hT8XyUPDl8loURnU+wJFIngux7sx5EO0/ZwsNOJweZFGgsGEG94NyoLZptbH5g+tP0lg+ycXJHjCUoiO899si2elfts+VAxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swVpKmIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70394C4CEE4;
	Wed, 21 May 2025 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867664;
	bh=A4cZK6Iw9WR3OYTGltfi2J19vQGIsLUyK/I4d/7MEtA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=swVpKmIex/O3fdS83rkxVu2mfFnLlW3Isav56xz0Kzok7eZBIVGnw7KujK5baXE9F
	 y6Di2aehnrv2r7sE7Sqp+Ba36LVC+kpmrfwvC+5urxeGTXBxNZGUhM5zAfBHNv5uGF
	 /UA5nAVUNvLu1mSLH4XSBV6hS8dYZFp/4ezyeS61jDpMDsi247jUv/Rf+fePBeoUA5
	 Fs8t87/35aiX3wmCSjI5RLI82eI1v62hCPlcHK4irP4ZYFBthFvmoHfvMFUTBb4Dxb
	 IY3kraxy69Hz8V1gfDXHxwI2L2Bu2AT05CvomwL/EEZIDnyF8tLpp2xy8g3F4TTb/c
	 6beox5lRfqSxw==
Date: Wed, 21 May 2025 15:47:43 -0700
Subject: [PATCH 10/10] fuse2fs: use fuseblk mode for mounting filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678871.1385354.15276136136470748216.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

So this is awkward.  Up until now, fuse2fs has opened the block device
in exclusive mode so that it can do all the superblock feature parsing
in main() prior to initiating the fuse connection.

However, in running fstests on fuse2fs, I noticed a weird unmount race
where the umount() syscall can return before the op_destroy function
gets called by libfuse.  This is problematic because fstests (and
probably users too) make a lot of assumptions about the block device
being openable after umount() completes.  The op_destroy function can
take some time to flush dirty blocks out of its pagecache, call fsync,
etc.

I poked around the kernel and libfuse and discovered that the kernel
fuse driver has two modes: anonymous and block device mode.  In block
device mode the kernel will send a FUSE_DESTROY command to userspace and
wait for libfuse to call our op_destroy function.  In anonymous mode,
the kernel closes the fuse device and completes the unmount, which means
that libfuse calls op_destroy after the unmount has gone away.

This is the root cause of _scratch_cycle_mount sporadically complaining
about the block device being in use.  The solution is to use block
device mode, but this means we have to move the libext2fs initialization
to op_init and we can no longer be the exclusive owner of the block
device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 13 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7f9f230f37ed2b..51f703267462b4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -164,6 +164,7 @@ struct fuse2fs {
 
 	int blocklog;
 	unsigned int blockmask;
+	int retcode;
 	unsigned long offset;
 	unsigned int next_generation;
 	unsigned long long cache_size;
@@ -715,6 +716,31 @@ static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
 	return 0;
 }
 
+static errcode_t fs_on_bdev(struct fuse2fs *ff, int *is_bdev)
+{
+	struct stat statbuf;
+	ext2_filsys fs = ff->fs;
+	int fd;
+	errcode_t err;
+	int ret;
+
+	err = io_channel_fd(fs->io, &fd);
+	if (err) {
+		err_printf(ff, "%s\n",
+			   _("Cannot determine if this is a block device.\n"));
+		return err;
+	}
+
+	ret = fstat(fd, &statbuf);
+	if (ret) {
+		err_printf(ff, "%s\n", strerror(errno));
+		return ret;
+	}
+
+	*is_bdev = S_ISBLK(statbuf.st_mode);
+	return 0;
+}
+
 static errcode_t config_fs_cache(struct fuse2fs *ff)
 {
 	char buf[128];
@@ -854,9 +880,17 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	ext2_filsys fs;
 	errcode_t err;
 
+	/* Can be null if op_init is given an incorrect fuse2fs */
+	if (!ff)
+		return;
 
 	FUSE2FS_CHECK_CONTEXT_NORET(ff);
+
+	/* Can be null if opening the filesystem failed */
+	if (!ff->fs)
+		return;
 	fs = ff->fs;
+
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_state |= EXT2_VALID_FS;
@@ -904,12 +938,12 @@ static void *op_init(struct fuse_conn_info *conn
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
-	ext2_filsys fs;
+	ext2_filsys fs = ff->fs;
 	errcode_t err;
+	int ret;
 
 	FUSE2FS_CHECK_CONTEXT_NULL(ff);
-	fs = ff->fs;
-	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
+	dbg_printf(ff, "%s: dev=%s\n", __func__, ff->device);
 #ifdef FUSE_CAP_IOCTL_DIR
 	conn->want |= FUSE_CAP_IOCTL_DIR;
 #endif
@@ -925,6 +959,46 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->use_ino = 1;
 	cfg->nullpath_ok = 1;
 #endif
+
+	/*
+	 * If the ext2_filsys object is null, then we are operating in fuseblk
+	 * mode and must reopen the filesystem.  If any of these steps fail,
+	 * tough.
+	 */
+	if (!fs) {
+		err = open_fs(ff, 0);
+		if (err)
+			goto mount_fail;
+		fs = ff->fs;
+
+		if (ff->cache_size) {
+			err = config_fs_cache(ff);
+			if (err)
+				goto mount_fail;
+		}
+
+		err = check_fs_supported(ff);
+		if (err)
+			goto mount_fail;
+
+		if (ext2fs_has_feature_shared_blocks(fs->super)) {
+			log_printf(ff, "%s\n",
+ _("shared file blocks, mounting filesystem read-only."));
+			fs->flags &= ~EXT2_FLAG_RW;
+		}
+
+		if (ff->norecovery) {
+			ret = check_norecovery(ff);
+			if (ret)
+				goto mount_fail;
+		}
+
+		err = mount_fs(ff);
+		if (err)
+			goto mount_fail;
+	}
+
+	/* Clear the valid flag so that an unclean shutdown forces a fsck */
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_mnt_count++;
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
@@ -943,7 +1017,13 @@ static void *op_init(struct fuse_conn_info *conn
 		uuid_unparse(fs->super->s_uuid, uuid);
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
+out:
 	return ff;
+mount_fail:
+	ff->retcode = 32;
+	/* Tear down the mount immediately. */
+	fuse_exit(ctxt->fuse);
+	goto out;
 }
 
 static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
@@ -4663,6 +4743,8 @@ int main(int argc, char *argv[])
 	FILE *orig_stderr = stderr;
 	char *logfile;
 	char extra_args[BUFSIZ];
+	unsigned int blksize;
+	int is_bdev;
 	int ret = 0;
 
 	memset(&fctx, 0, sizeof(fctx));
@@ -4717,6 +4799,10 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
+	/*
+	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
+	 * we must force ro mode.
+	 */
 	err = open_fs(&fctx, EXT2_FLAG_EXCLUSIVE);
 	if (err) {
 		ret = 32;
@@ -4725,13 +4811,6 @@ int main(int argc, char *argv[])
 
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
-	if (fctx.cache_size) {
-		err = config_fs_cache(&fctx);
-		if (err) {
-			ret = 32;
-			goto out;
-		}
-	}
 
 	err = check_fs_supported(&fctx);
 	if (err) {
@@ -4754,17 +4833,40 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	err = fs_on_bdev(&fctx, &is_bdev);
+	if (err) {
+		ret = 32;
+		goto out;
+	}
+
+	blksize = fctx.fs->blocksize;
+
+	/*
+	 * If this is a block device, we want to close the fd, open the fuse
+	 * driver in fuseblk mode (which will reopen the block device) so that
+	 * unmount will wait until op_destroy completes.  If this is not a
+	 * block device, we cannot use fuseblk mode and should leave the
+	 * filesystem open.
+	 */
+	if (is_bdev)
+		close_fs(&fctx);
+
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
 	/* Set up default fuse parameters */
 	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
-		 get_subtype(argv[0]),
-		 fctx.device);
+		 "attr_timeout=0" FUSE_PLATFORM_OPTS,
+		 get_subtype(argv[0]));
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
 
+	if (is_bdev) {
+		snprintf(extra_args, BUFSIZ, "-ofsname=%s,blkdev,blksize=%u",
+			 fctx.device, blksize);
+		fuse_opt_add_arg(&args, extra_args);
+	}
+
 	if (fctx.ro)
 		fuse_opt_add_arg(&args, "-oro");
 
@@ -4824,6 +4926,9 @@ int main(int argc, char *argv[])
 		ret = 0;
 		break;
 	}
+
+	/* mount might have failed */
+	ret |= fctx.retcode;
 out:
 	if (ret & 1) {
 		fprintf(orig_stderr, "%s\n",


