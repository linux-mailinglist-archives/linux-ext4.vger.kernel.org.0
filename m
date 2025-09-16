Return-Path: <linux-ext4+bounces-10098-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD71B588C6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19306170995
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0939E571;
	Tue, 16 Sep 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shRn276f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84376610D
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981010; cv=none; b=lUQk0gvh//ADttG/Ajm5hFKj16WoCkQkHbuKUWrJLo0aatbBeKVl7Q2PcYhIjBVcIznr+7vGLc7ARas0vqSFdj45mRYC0gaBGNFcQ1eIqwpRTC98iSY/KS0ugzz23XnNDWrodIvTAzr7yO/kMPb/4L/ogo0PPCXuCfEHm9w75Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981010; c=relaxed/simple;
	bh=0r8X+JFMjK98lVUkerhcTR83Jnzr7qLJj45drwaWqPc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3cIdY5FPZvKS/rkTmxGJeghBvl5b3s1YWb3rj9c7gDs1zdhTRK0PRCArVQIi4CaB+uQYe1yHORS0r69DsjEY6ET2m2ve3o8Fg0QKnvrivv/UXVFo7/ZCiSrQ8Kik1fsD8Aw0kZA5JfP949tcsiUok9EGXZyL9EiRRVpqv7NTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shRn276f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0C4C4CEF1;
	Tue, 16 Sep 2025 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981010;
	bh=0r8X+JFMjK98lVUkerhcTR83Jnzr7qLJj45drwaWqPc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=shRn276ftsXW0bMtJi5hge9k2DLuDYP8TkspFTHGtcJ2AzthOAu3nvoD/XZQ62wJg
	 6VkA4kDx0gwGFa15yyHrlPLJs9z73XtaRFctZwCtLFH566pNZ2Oikmc35RaNtTy55S
	 8B6SxrnJ6/zOj2VCGUPp3mK+WKEdUA+Z0YCm9Y0kNQBurY3zC94s046C36KjMjtS8+
	 5iuq+/8VeUXY2vNdlB9OS3/o5cHQZQVVKxzsV+LYVglFwZFf7kLX69aVVHYA98Kku9
	 RQEiZBODzgAUnfrO3YjLpBC5jWd2kcv39kurtiRlbklf8Lxl7uZ9Dhw9QzpoYC6EfT
	 mXJ5KBK7RhUhQ==
Date: Mon, 15 Sep 2025 17:03:29 -0700
Subject: [PATCH 2/2] fuse2fs: use fuseblk mode for mounting filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064794.350013.8990855643052322750.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fb44b0a79b53e6..8cd4dc600888b9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <stdbool.h>
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
@@ -236,6 +237,8 @@ struct fuse2fs {
 	int directio;
 	int acl;
 	int dirsync;
+	int unmount_in_destroy;
+	int noblkdev;
 
 	int logfd;
 	int blocklog;
@@ -967,6 +970,11 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 	return 0;
 }
 
+static inline bool fuse2fs_on_bdev(const struct fuse2fs *ff)
+{
+	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
+}
+
 static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
 {
 	char buf[128];
@@ -1152,6 +1160,9 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
 	}
 
+	if (ff->unmount_in_destroy)
+		fuse2fs_unmount(ff);
+
 	fuse2fs_finish(ff, 0);
 }
 
@@ -4998,6 +5009,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 #ifdef HAVE_CLOCK_MONOTONIC
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
+	FUSE2FS_OPT("noblkdev",		noblkdev,		1),
 
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
@@ -5143,6 +5155,18 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+static inline bool fuse2fs_want_fuseblk(const struct fuse2fs *ff)
+{
+	if (ff->noblkdev)
+		return false;
+
+	/* libfuse won't let non-root do fuseblk mounts */
+	if (getuid() != 0)
+		return false;
+
+	return fuse2fs_on_bdev(ff);
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -5201,6 +5225,28 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (fuse2fs_want_fuseblk(&fctx)) {
+		/*
+		 * If this is a block device, we want to close the fs, reopen
+		 * the block device in non-exclusive mode, and start the fuse
+		 * driver in fuseblk mode (which will reopen the block device
+		 * in exclusive mode) so that unmount will wait until
+		 * op_destroy completes.
+		 */
+		fuse2fs_unmount(&fctx);
+		err = fuse2fs_open(&fctx, 0);
+		if (err) {
+			ret = 32;
+			goto out;
+		}
+
+		/* "blkdev" is the magic mount option for fuseblk mode */
+		snprintf(extra_args, BUFSIZ, "-oblkdev,blksize=%u",
+			 fctx.fs->blocksize);
+		fuse_opt_add_arg(&args, extra_args);
+		fctx.unmount_in_destroy = 1;
+	}
+
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {


