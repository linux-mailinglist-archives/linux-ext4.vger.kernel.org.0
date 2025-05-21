Return-Path: <linux-ext4+bounces-8098-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B1ABFFC1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DB27A3BD1
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E8239E85;
	Wed, 21 May 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGM9rgGE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27481754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867193; cv=none; b=DmANpu0lhbwCO3OsVboadAlbl0MAbCpuVJ4shNkTQ84FBA35rSpZeVr3xLYwpw+rNFIkt7+0V8jNItf1sTZ9HT6Ro5Kjfumu3/3v3qep/snpOgv/5UR1XvybQwH0qCCIYosgJMnIGppBb89EWebufuuqtzFMvvTr0PiltPHol54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867193; c=relaxed/simple;
	bh=7RhiwsSQLQlxgID6tpuUBDSu0ptj7pAUbRDs8tPwD7c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdqGFKz9cCHvkFK+ISgXJ7Wphlr0l5EFqdkAtv3u+0lXITlq8YeDUk3yobbqcE0Ez5CTZ4hJLfbaOfg8pBqxfSNuynTZoK86Vc0/7UcBbafppvNrDGQ77pYyLFu6OtMOY/EXQl/ZZ4S/K6EzLt4VOGJ5chIhZx+TTFJmLIyIgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGM9rgGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD7C4CEF2;
	Wed, 21 May 2025 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867193;
	bh=7RhiwsSQLQlxgID6tpuUBDSu0ptj7pAUbRDs8tPwD7c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jGM9rgGEayS8K8lQZmDcSir3iWc9g+ewu8zog+rp9jBDByWt5eHYYqVvplrixoXjh
	 fKMIjp1YWhIypHgW4mmtqiuJLpJ/3oIFweXZaDreyCWlal00Bu6rTYxm4cv+7GJ6ha
	 o0sUTuPCYjnfPoNRhAwVhoMGxiUrzpHV6Lo4nywNwi2IV1ax4M6a1cARcz6FQbU0gs
	 1D9/yw7VftJJqjUyGT7lw/NzLaWkwGsgiGw07NpkWBjzxTd8bFYoDxKA2dlxp/n+02
	 6Lmnds7MCg67ANtJVq1kT217bYqOEVkYKmnUXnele8okC0XwbpdxeoL1Y9PyOvVW0i
	 WUMYdoyXXisMg==
Date: Wed, 21 May 2025 15:39:52 -0700
Subject: [PATCH 19/29] fuse2fs: check the immutable flag in more places
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677887.1383760.16795876049190712906.stgit@frogsfrogsfrogs>
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

We need to check the immutable flag in a few more places that try to
modify files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 06d59a3e824e09..8567d2a8801bb6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -507,6 +507,30 @@ static inline int want_check_owner(struct fuse2fs *ff,
 	return !is_superuser(ff, ctxt);
 }
 
+static int check_iflags_access(struct fuse2fs *ff, ext2_ino_t ino,
+			       const struct ext2_inode *inode, int mask)
+{
+	ext2_filsys fs = ff->fs;
+
+	/* no writing to read-only or broken fs */
+	if ((mask & W_OK) && !fs_writeable(fs))
+		return -EROFS;
+
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s iflags=0x%x\n",
+		   ino,
+		   (mask & R_OK ? "r" : ""),
+		   (mask & W_OK ? "w" : ""),
+		   (mask & X_OK ? "x" : ""),
+		   inode->i_flags);
+
+	/* is immutable? */
+	if ((mask & W_OK) &&
+	    (inode->i_flags & EXT2_IMMUTABLE_FL))
+		return -EPERM;
+
+	return 0;
+}
+
 static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -514,6 +538,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	struct ext2_inode inode;
 	mode_t perms;
 	errcode_t err;
+	int ret;
 
 	/* no writing to read-only or broken fs */
 	if ((mask & W_OK) && !fs_writeable(fs))
@@ -537,10 +562,9 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	if (mask == 0)
 		return 0;
 
-	/* is immutable? */
-	if ((mask & W_OK) &&
-	    (inode.i_flags & EXT2_IMMUTABLE_FL))
-		return -EPERM;
+	ret = check_iflags_access(ff, ino, &inode, mask);
+	if (ret)
+		return ret;
 
 	/* If kernel is responsible for mode and acl checks, we're done. */
 	if (ff->kernel)
@@ -1218,6 +1242,10 @@ static int __op_unlink(struct fuse2fs *ff, const char *path)
 		goto out;
 	}
 
+	ret = check_inum_access(ff, ino, W_OK);
+	if (ret)
+		goto out;
+
 	ret = unlink_file_by_name(ff, path);
 	if (ret)
 		goto out;
@@ -1286,6 +1314,10 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 	}
 	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
 
+	ret = check_inum_access(ff, child, W_OK);
+	if (ret)
+		goto out;
+
 	rds.parent = 0;
 	rds.empty = 1;
 
@@ -1295,6 +1327,16 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		goto out;
 	}
 
+	/* the kernel checks parent permissions before emptiness */
+	if (rds.parent == 0) {
+		ret = translate_error(fs, child, EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out;
+	}
+
+	ret = check_inum_access(ff, rds.parent, W_OK);
+	if (ret)
+		goto out;
+
 	if (rds.empty == 0) {
 		ret = -ENOTEMPTY;
 		goto out;
@@ -1530,6 +1572,16 @@ static int op_rename(const char *from, const char *to
 		goto out;
 	}
 
+	ret = check_inum_access(ff, from_ino, W_OK);
+	if (ret)
+		goto out;
+
+	if (to_ino) {
+		ret = check_inum_access(ff, to_ino, W_OK);
+		if (ret)
+			goto out;
+	}
+
 	temp_to = strdup(to);
 	if (!temp_to) {
 		ret = -ENOMEM;
@@ -1759,7 +1811,6 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
-
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, src, &ino);
 	if (err || ino == 0) {
 		ret = translate_error(fs, 0, err);
@@ -1774,6 +1825,10 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out2;
+
 	inode.i_links_count++;
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
@@ -1848,6 +1903,10 @@ static int op_chmod(const char *path, mode_t mode
 		goto out;
 	}
 
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out;
+
 	if (want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
 		ret = -EPERM;
 		goto out;
@@ -1912,6 +1971,10 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 		goto out;
 	}
 
+	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	if (ret)
+		goto out;
+
 	/* FUSE seems to feed us ~0 to mean "don't change" */
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */


