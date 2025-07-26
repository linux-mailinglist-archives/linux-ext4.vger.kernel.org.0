Return-Path: <linux-ext4+bounces-9197-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF7B12B6C
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Jul 2025 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398401C2168D
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Jul 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FD285072;
	Sat, 26 Jul 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbkP4L+C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D021B3923
	for <linux-ext4@vger.kernel.org>; Sat, 26 Jul 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547329; cv=none; b=hj8aJnRpBhxrocAAp0SPjMuRBnsarR7pBm1txu+Mnb9xCY8YJ5Va5ePQ2wAIghFbYRxaHV8NxEb4EVFhsLMGQD3TNxwBRrgMSvTL7xnFYAyxsCMPQsMVdkwT03fRqx9xHQKlUtV1d9Yx2HwVnCc/rLLIM26y+SUHhbm2Iljy1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547329; c=relaxed/simple;
	bh=a1ssf2/wZmYGiMwlFZD6G+dIDgmBirsdDXdvoaUxmzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+Lo5FjV2wUyoR+FbtYQJACshPH+kbu6hfKg2NnStiAHJHDIAV5d5IyRvG/MM08CCROkIinB8C+Yc1Ut7m0Z40jhmjicNNpMSGURv73zrIHBZoz7AirGLPrVXNA8aC0Ig2O5e4BeC0t1f0AMoILD1oMf7Sm9kcIySCK1RlCuyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbkP4L+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46825C4CEED;
	Sat, 26 Jul 2025 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753547329;
	bh=a1ssf2/wZmYGiMwlFZD6G+dIDgmBirsdDXdvoaUxmzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbkP4L+CiRZecGFIuHlMIHMa+u2RdfBLPvSqy92lYbyj0IilcxoG11u+U4wBOMURh
	 E9KV1rCgO+xhEjQr2osKaSw5kpeG2EM5tzYiwjstNEHS+//EOAOfyLNEf0MS+bZDMe
	 /0RSPZD24gh/YAWJPLzohJowHoKsVq1WVs5hTZcLmAZdDJBcEZZOImozopN1z9sSRJ
	 YcPqlKlOrzhYYInyzrr/t74S0a61AJHDe/q4K8tD4rEOOUpJNB4XSKXM+lNkyF/kO9
	 CaBV62giRTLxPA0+QQiUY75sCWB2iUI6TRXZXUkPtuSJiXjL7rkZiTEY03jUcPEVC7
	 uVHY1am/3M1/w==
Date: Sat, 26 Jul 2025 09:28:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 20/8] fuse2fs: fix punching post-EOF blocks during truncate
Message-ID: <20250726162848.GQ2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

ext2fs_punch() can update the inode that's passed in, so we need to
write it back.  This should fix some fstests failures where the test
file system ends up with inodes where all extent records fit within the
inode but inexplicably have extents beyond EOF.  While we're at it, add
the fuse2fs prefix to the two helper functions.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 4581ac60eb53ec ("fuse2fs: fix post-EOF preallocation clearing on truncation")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 18d8f426a5eb43..c6b1684f53e2e4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2461,7 +2461,8 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	return ret;
 }
 
-static int punch_posteof(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
+static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
+				 off_t new_size)
 {
 	ext2_filsys fs = ff->fs;
 	struct ext2_inode_large inode;
@@ -2477,10 +2478,14 @@ static int punch_posteof(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
+	err = fuse2fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
 	return 0;
 }
 
-static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
+static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 {
 	ext2_filsys fs = ff->fs;
 	ext2_file_t file;
@@ -2523,7 +2528,7 @@ static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	 * we should clear out post-EOF preallocations.
 	 */
 	if (new_size == old_isize)
-		return punch_posteof(ff, ino, new_size);
+		return fuse2fs_punch_posteof(ff, ino, new_size);
 
 	return 0;
 }
@@ -2559,7 +2564,7 @@ static int op_truncate(const char *path, off_t len
 	if (ret)
 		goto out;
 
-	ret = truncate_helper(ff, ino, len);
+	ret = fuse2fs_truncate(ff, ino, len);
 	if (ret)
 		goto out;
 
@@ -2659,7 +2664,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	}
 
 	if (fp->flags & O_TRUNC) {
-		ret = truncate_helper(ff, file->ino, 0);
+		ret = fuse2fs_truncate(ff, file->ino, 0);
 		if (ret)
 			goto out;
 	}

