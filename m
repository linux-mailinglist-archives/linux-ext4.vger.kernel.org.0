Return-Path: <linux-ext4+bounces-7484-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00CA9BA16
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78C21BA54F2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E741F8730;
	Thu, 24 Apr 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgB4iE8q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA822820A7
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531113; cv=none; b=Pxiw3KNZzMQdPSFtRcg7THJ7FxIUm9ZUMeqyS3WetVHfUY6eDKeTk31o/2s6106ChsIF5YV6QWJ5IsNaMXuFvgp5CyLpYbv+VWPq+WdUgBsWhuhs1y6zDQUy2nHvxGXTcKzFTAYEGfPm1JmZ7cUwOJfxrdbC08NSLzGIH4VjMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531113; c=relaxed/simple;
	bh=csKdZGWJYO/Xmhmc3ucsLMM0v9Uw6RUOO1GtTn49vQE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=motp4g7TwVbAvfGl1o9fQdeaH3x7oagDoyWcs32t0rWQGeQpRS3BwPsi4/KYgMLGHVslRE0Qh9WvTtg+a7EhoyPBC7broY0+FGW7Wof27Bn+vxCZ+ouTNTXRM63Qlp+fFofLnvk1l/zJyK5CrGwTVuR6v+fo2EAC7wmaTlV4TS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgB4iE8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18620C4CEE3;
	Thu, 24 Apr 2025 21:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531113;
	bh=csKdZGWJYO/Xmhmc3ucsLMM0v9Uw6RUOO1GtTn49vQE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MgB4iE8qCw9lj7F/0X7OiUf+Z8ksU6V8GzyTZsRK7CdDkvt3F5tPeqziylKPD6znn
	 Gr1SFFfvTe0d34OpxMkKTPaeO0M2D64gdWdKeh5SMkF0V8hZNLdrOCKARLX8CpNpzk
	 vyQuD0Xugha0wuGRfwsKwSke2m7CZpACj45fyP23MXmPyD1e4gr8YtNfaclCKLKegQ
	 ZNQbjImGd6v/G3ZYG5IA8qNQIq4saNa6jMD0NVOU4FcZX412ahuBMf8l/Y63wPBNwP
	 S6IVX7NLqP1RPrzhdfzdwAjxA2DTazZTHq0xA7ymBLn1DUxE7GeW6iE1uNROD+rY+x
	 ffAyrfz3uwvHw==
Date: Thu, 24 Apr 2025 14:45:12 -0700
Subject: [PATCH 1/2] fuse2fs: refactor sysadmin predicate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065355.1161102.13914905314262828953.stgit@frogsfrogsfrogs>
In-Reply-To: <174553065332.1161102.2163541286559749682.stgit@frogsfrogsfrogs>
References: <174553065332.1161102.2163541286559749682.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Refactor the code that decides if an access is being made by the
superuser into a helper, which we'll use to fix more permissions
problems in the next patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 480463e0bc4b1c..a10491d19f54a9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -484,6 +484,13 @@ static int fs_writeable(ext2_filsys fs)
 	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
 }
 
+static inline int is_superuser(struct fuse2fs *ff, struct fuse_context *ctxt)
+{
+	if (ff->fakeroot)
+		return 1;
+	return ctxt->uid == 0;
+}
+
 static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -517,7 +524,7 @@ static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 		return -EACCES;
 
 	/* Figure out what root's allowed to do */
-	if (ff->fakeroot || ctxt->uid == 0) {
+	if (is_superuser(ff, ctxt)) {
 		/* Non-file access always ok */
 		if (!LINUX_S_ISREG(inode.i_mode))
 			return 0;
@@ -1801,7 +1808,7 @@ static int op_chmod(const char *path, mode_t mode
 		goto out;
 	}
 
-	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->uid != inode_uid(inode)) {
+	if (!is_superuser(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -1811,7 +1818,7 @@ static int op_chmod(const char *path, mode_t mode
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->gid != inode_gid(inode))
+	if (!is_superuser(ff, ctxt) && ctxt->gid != inode_gid(inode))
 		mode &= ~S_ISGID;
 
 	inode.i_mode &= ~0xFFF;
@@ -1868,7 +1875,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	/* FUSE seems to feed us ~0 to mean "don't change" */
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */
-		if (!ff->fakeroot && ctxt->uid != 0 &&
+		if (!is_superuser(ff, ctxt) &&
 		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
 			ret = -EPERM;
 			goto out;
@@ -1879,7 +1886,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
-		if (!ff->fakeroot && ctxt->uid != 0 &&
+		if (!is_superuser(ff, ctxt) &&
 		    inode_uid(inode) != ctxt->uid) {
 			ret = -EPERM;
 			goto out;
@@ -3044,7 +3051,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
+	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);
@@ -3100,7 +3107,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
+	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	inode.i_generation = generation;
@@ -3206,7 +3213,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
+	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);


