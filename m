Return-Path: <linux-ext4+bounces-9410-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C225B2E8F1
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130625E64A0
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FA2E0B48;
	Wed, 20 Aug 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BabWfOfB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700052DCF56
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733378; cv=none; b=mIyFLzMm05qOR+7A26X+EthNP8EadPEtBvrVKgOxwRetHd0I00OGCOjOZtEmfaUiJTBi7lp7eePZ2c8Q1BJASn7Sj1yjtEn4gTOUIy0d4FEI6oYsQlRZSvHi+MdlYmiKr6qQ7AnSaVx8iNYGpIBLWZjo0XSIl8UXdU2+TVjwJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733378; c=relaxed/simple;
	bh=mOcCmuPoKCHlnFRy0MDE0myNvBqn35HqHSaFJFTNf5M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTETyVMYSsGsSoqhk5sMdz4QBx66LH0dG4d7BHd+yQ/2rKHe60SOrWcQB0XBnn7LXBNaXeC/WrxxrDZEGFwm6Y5lkjwj4lviYsaldJ6wdIIJ8JaWGG/OSOsdNPtEEeHULzIMadSBXhGNkYeEpTnugL1dAjVP7wlfrf7MeZw6fWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BabWfOfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040A8C4CEE7;
	Wed, 20 Aug 2025 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733378;
	bh=mOcCmuPoKCHlnFRy0MDE0myNvBqn35HqHSaFJFTNf5M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BabWfOfBinoxNQgbarK7PhLp2Vd4ALhXNBH9+O3nIj3eycYNJLYOFCCNeEo57ZtJx
	 +7WO5ELrnfHLeAjlNd55g9FI9PR3AqMm0/oKi+aF306Y/xJ1jCzpLYnvVla8y+UKjb
	 hLAOM1Ff5yEan0zc6oNu90itp1eoIvmQuWWfKmmiuU7pnVM3ASCB8AQmcZfm0tiu5k
	 IDKLicrg1FpS+zNsKYP69toC/N9bBrMEhmHigAaF8+7UvKZSc/6vkMrSTsoB6+92zM
	 5cWeKwFxCLYMXaZ/aP866ru9BVffSvMy/BxiBpDDFFKWqukAvVZ3nc+sPHMac5UmwP
	 j3GztEH8QlndQ==
Date: Wed, 20 Aug 2025 16:42:57 -0700
Subject: [PATCH 08/12] fuse2fs: interpret error codes in remove_ea_inodes
 correctly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318746.4130038.9263918181319561586.stgit@frogsfrogsfrogs>
In-Reply-To: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
References: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

remove_ea_inodes should translate libext2fs error codes into errnos so
that fs developers can trace exactly where a failure occurred.  Also
don't squash EA inode removal errors.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 3045aed621117f ("fuse2fs: fix removing ea inodes when freeing a file")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 415f174875922f..a7f7e7f1595344 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1524,12 +1524,13 @@ static int unlink_file_by_name(struct fuse2fs *ff, const char *path)
 	return update_mtime(fs, dir, NULL);
 }
 
-static errcode_t remove_ea_inodes(struct fuse2fs *ff, ext2_ino_t ino,
-				  struct ext2_inode_large *inode)
+static int remove_ea_inodes(struct fuse2fs *ff, ext2_ino_t ino,
+			    struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_xattr_handle *h;
 	errcode_t err;
+	int ret = 0;
 
 	/*
 	 * The xattr handle maintains its own private copy of the inode, so
@@ -1537,25 +1538,35 @@ static errcode_t remove_ea_inodes(struct fuse2fs *ff, ext2_ino_t ino,
 	 */
 	err = fuse2fs_write_inode(fs, ino, inode);
 	if (err)
-		return err;
+		return translate_error(fs, ino, err);
 
 	err = ext2fs_xattrs_open(fs, ino, &h);
 	if (err)
-		return err;
+		return translate_error(fs, ino, err);
 
 	err = ext2fs_xattrs_read(h);
-	if (err)
+	if (err) {
+		ret = translate_error(fs, ino, err);
 		goto out_close;
+	}
 
 	err = ext2fs_xattr_remove_all(h);
-	if (err)
+	if (err) {
+		ret = translate_error(fs, ino, err);
 		goto out_close;
+	}
 
 out_close:
 	ext2fs_xattrs_close(&h);
+	if (ret)
+		return ret;
 
 	/* Now read the inode back in. */
-	return fuse2fs_read_inode(fs, ino, inode);
+	err = fuse2fs_read_inode(fs, ino, inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
 }
 
 static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
@@ -1592,8 +1603,8 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 		goto write_out;
 
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
-		err = remove_ea_inodes(ff, ino, &inode);
-		if (err)
+		ret = remove_ea_inodes(ff, ino, &inode);
+		if (ret)
 			goto write_out;
 	}
 


