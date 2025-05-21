Return-Path: <linux-ext4+bounces-8097-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491CABFFBE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E9B3B4189
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B8239E85;
	Wed, 21 May 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/cDYkdF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AA186294
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867177; cv=none; b=M/ynhpLbtwVMpjHo5Zz8jOFCJMGglXFjx70QpQRcSCI2zO8MxTdidC7pYQsjeymA49GFKvlm2wKlBI4FtJSRkktmsRLKAXkloCqS01qjISkIs3VT4Jb0bo5fnvaWUmZ3UQoUSbP7iyffzFWVS9XCDQebMdmaSgRkVr3/h9Kec2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867177; c=relaxed/simple;
	bh=Xa2/40Fvk7dIxs1NjZ54nFMY1o7xvapSgUkMzSwZ7XY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGA2xxCgKgkXFk0WT297mbxR6vu51DNKi7Ihi58PzKSan8ORi5IW1eRRrptYbVYjp9qvL4CKXkhQxyEdLxUwVKWdyomskVTVcIAJsXL7BlpA2zF/YOaLOzEZCQRk07mNUUhZLEQlBCdoR2xYZaFyDP13XocPj6jFqUXE+Zy/z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/cDYkdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6794EC4CEE4;
	Wed, 21 May 2025 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867177;
	bh=Xa2/40Fvk7dIxs1NjZ54nFMY1o7xvapSgUkMzSwZ7XY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A/cDYkdFqY7xiZKuJDxVODuJSyOBXd3dNpzslpLAa3cCrZ6DD2W1r7bmRNIzjsr4Z
	 XUEd3RIdPbm1jKush+M0+FNO9Ml9yeuGO6Jf4WCmoF1Ns7/3EryOalpjwOLVsag7Ho
	 PyzXdrr/LutnPIT+ipfYFVinWiyJ/va8hXdgl1PWjSGys5yIg6GsGT19C6r9HyIlja
	 H4zmsvFSl6ya0Nn4ADP/MhRUyJwEWfDikGh47P26GOj50V1i1s6LHuexz1Gvp8/vaB
	 nEqxpjDSkamVKB646Hv1aoPYhG3eoTb9sccIfCQy6H9v69JeV1K/SVSDdOIl3h4cLV
	 J129UUZlm+m4g==
Date: Wed, 21 May 2025 15:39:36 -0700
Subject: [PATCH 18/29] fuse2fs: return EPERM for write access to
 EXT2_IMMUTABLE_FL files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677869.1383760.310634374176043971.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel drivers return EPERM for attempts to write to immutable
files, so switch the error code.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e73730cfe27130..06d59a3e824e09 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -524,11 +524,14 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 		return translate_error(fs, ino, err);
 	perms = inode.i_mode & 0777;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s perms=0%o fuid=%d fgid=%d "
-		   "uid=%d gid=%d\n", ino,
-		   (mask & R_OK ? "r" : ""), (mask & W_OK ? "w" : ""),
-		   (mask & X_OK ? "x" : ""), perms, inode_uid(inode),
-		   inode_gid(inode), ctxt->uid, ctxt->gid);
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s perms=0%o iflags=0x%x "
+		   "fuid=%d fgid=%d uid=%d gid=%d\n", ino,
+		   (mask & R_OK ? "r" : ""),
+		   (mask & W_OK ? "w" : ""),
+		   (mask & X_OK ? "x" : ""),
+		   perms, inode.i_flags,
+		   inode_uid(inode), inode_gid(inode),
+		   ctxt->uid, ctxt->gid);
 
 	/* existence check */
 	if (mask == 0)
@@ -537,7 +540,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	/* is immutable? */
 	if ((mask & W_OK) &&
 	    (inode.i_flags & EXT2_IMMUTABLE_FL))
-		return -EACCES;
+		return -EPERM;
 
 	/* If kernel is responsible for mode and acl checks, we're done. */
 	if (ff->kernel)


