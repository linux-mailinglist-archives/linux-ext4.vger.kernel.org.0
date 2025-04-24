Return-Path: <linux-ext4+bounces-7485-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61377A9BA17
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B21B1BA542A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51591F03EC;
	Thu, 24 Apr 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqDRPbyg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965D13213E
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531129; cv=none; b=P8BVJlaXe1DAiz2YoGBblUw4X2q+ciqHw6qfPtnw+hIYW+Icqgz5hUn3+Yt8/FMsofI31xHMgmEw0s6364izwCtY1OYNBUeBDFvdAyG0SrCWrRSABKkkkMgpay/1K8EitBwKQ8i02Q227asWBGrz+9cD3X3Hx1+GSgVeSQk4B1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531129; c=relaxed/simple;
	bh=0R5ylYX8Rn8xzfwtApSf1RWwc3s84Do7qvQiGJDpze4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6E7iSODM8/O4zKFKWbfAU64ta7iqvcd+iX3zomcGQ3nS7PZj8InDETFm6nDTtdoTHR8AWPTkNNvbLNBOy4kNavfYwUsnHZALT8tXWqWl0ui1vRQIqpPBPqsGJXiEbfEUXlTGGYqfuylin9GAT2w56XadKQ5nKG5fxGCQgttR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqDRPbyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BFAC4CEE4;
	Thu, 24 Apr 2025 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531128;
	bh=0R5ylYX8Rn8xzfwtApSf1RWwc3s84Do7qvQiGJDpze4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DqDRPbyg7hQWtd+wnuNIP0V2iYoD6GlGxCViGWUSPZdUakN259DKahSi2NkZYtq43
	 yHVWwb2Gx8piLecQfTl4+YOJyKiRvxoETB3qtrdUDzVKPqejO41WOIfHTqSyfnZ8tT
	 G9J2EvJxml4SKHq9NkvJ7XV6y5QSnHFvk8oo2HzRGTql4Ll3wjJuqe4EbLmX0rANWW
	 t7r6xS5Xab5cRNKRSF8Fe7y1wqE/h9x2hbr8edwH3ZfKGD9JUY2xVT1OfHSz+UZPZV
	 2t5sQ9yYe3I+mMn7FsvOhOwbfu3kCwo4ZecJ9f6pw+4t1S6q5yJcFIKJwnBfwMLj2Z
	 WSYJyL2aCH0ag==
Date: Thu, 24 Apr 2025 14:45:28 -0700
Subject: [PATCH 2/2] fuse2fs: delegate access control decisions to the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065373.1161102.14873909355987419902.stgit@frogsfrogsfrogs>
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

In "kernel" mode (aka allow_others + default_permissions), the kernel
enforces all the access control for us.  Therefore, we don't need to do
any checking of our own.  Create a purpose-built helper to detect this
situation and turn off all the access controlling.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a10491d19f54a9..8451cabfb19110 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -491,6 +491,18 @@ static inline int is_superuser(struct fuse2fs *ff, struct fuse_context *ctxt)
 	return ctxt->uid == 0;
 }
 
+static inline int want_check_owner(struct fuse2fs *ff,
+				   struct fuse_context *ctxt)
+{
+	/*
+	 * The kernel is responsible for access control, so we allow anything
+	 * that the superuser can do.
+	 */
+	if (ff->kernel)
+		return 0;
+	return !is_superuser(ff, ctxt);
+}
+
 static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -523,6 +535,10 @@ static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 	    (inode.i_flags & EXT2_IMMUTABLE_FL))
 		return -EACCES;
 
+	/* If kernel is responsible for mode and acl checks, we're done. */
+	if (ff->kernel)
+		return 0;
+
 	/* Figure out what root's allowed to do */
 	if (is_superuser(ff, ctxt)) {
 		/* Non-file access always ok */
@@ -1808,7 +1824,7 @@ static int op_chmod(const char *path, mode_t mode
 		goto out;
 	}
 
-	if (!is_superuser(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
+	if (want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -1875,7 +1891,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	/* FUSE seems to feed us ~0 to mean "don't change" */
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */
-		if (!is_superuser(ff, ctxt) &&
+		if (want_check_owner(ff, ctxt) &&
 		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
 			ret = -EPERM;
 			goto out;
@@ -1886,7 +1902,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
-		if (!is_superuser(ff, ctxt) &&
+		if (want_check_owner(ff, ctxt) &&
 		    inode_uid(inode) != ctxt->uid) {
 			ret = -EPERM;
 			goto out;
@@ -3051,7 +3067,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);
@@ -3107,7 +3123,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	inode.i_generation = generation;
@@ -3213,7 +3229,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!is_superuser(ff, ctxt) && inode_uid(inode) != ctxt->uid)
+	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	ret = set_iflags(&inode, flags);


