Return-Path: <linux-ext4+bounces-9411-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498CFB2E8FB
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14B67BA3D7
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C502E228A;
	Wed, 20 Aug 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI6FHpG3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA532765E3
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733394; cv=none; b=R96K8fZyJxokxhVX1x3M5cb39N+Zv4O+cU4XTZeBs61858ZH6o7DKhi+PhjXkOoHdSXdKlsW/lgnRKBtFMTnXUBOUBqcS3q2S9S3ndKRczTelR8q7V2c4c0Zwke43vq2YrA+Er3JPI1Y1skMLpoqbxUKR21ztbFqV9fjuIAjyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733394; c=relaxed/simple;
	bh=5hBrVWl5ogYfSkonnLyIg/ks2iHiSi1WvRI4RpDNb2E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+uSXNaYRuK2u8EuQ1UrOrbtMVgfow2JrEKW27uMjNpNw6gxYcPaZRjQxAzR+h+7482/HFuUZLbZ1TyIwIiYITs/UkoBAsgsLqNDH698xwN5lkViMrIohJpwPdan0agrsuCt+Nc332ySQx9WZzXJOMeJ0OYnvGJUYtWvoxrPXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI6FHpG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A6C4CEE7;
	Wed, 20 Aug 2025 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733393;
	bh=5hBrVWl5ogYfSkonnLyIg/ks2iHiSi1WvRI4RpDNb2E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VI6FHpG3MNI4MQdABq/5ReONqXuIdHhC53FjmQkhZ0Nc1UCU+vmtIosIg41PLuXTP
	 u+niEuAOFQwkb0+BEzH22klzj/QbEfLpXZshRhQDdTuZFRTxiXh2lijnEC1Jrj7cmC
	 etmTTv8eYHMe46EisiVmUmzJartvRs7tAW4rdhByAvdC4SlS9/oSwLV1RdBm4uL+TP
	 OUAGaQIAwiQQn3qtu3almzVO7qUKKcFxPfK7DIX3f/F8ZbA4vbTfiwqVU9xONR/XGY
	 QVdBHg+juOw4EAXO0Ki1bUj+dTYYgWx69XHf9VB4Mdh0VudoqEcbr9DAUP+Dymz3tL
	 fpDf5pIjRRYnQ==
Date: Wed, 20 Aug 2025 16:43:13 -0700
Subject: [PATCH 09/12] fuse2fs: don't write inode when inactivation fails
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318765.4130038.17584770605415835679.stgit@frogsfrogsfrogs>
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

remove_inode has this weird behavior where it writes the inode to disk
even if the attempts to inactivate it (remove xattrs, truncate data)
fail.  Worse yet, it doesn't even return the original error code, so it
masks failures.  Fix this too.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a7f7e7f1595344..2648b55893d5e7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1577,10 +1577,9 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	int ret = 0;
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
+	if (err)
+		return translate_error(fs, ino, err);
+
 	dbg_printf(ff, "%s: put ino=%d links=%d\n", __func__, ino,
 		   inode.i_links_count);
 
@@ -1597,7 +1596,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (inode.i_links_count)
 		goto write_out;
@@ -1605,21 +1604,19 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = remove_ea_inodes(ff, ino, &inode);
 		if (ret)
-			goto write_out;
+			return ret;
 	}
 
 	/* Nobody holds this file; free its blocks! */
 	err = ext2fs_free_ext_attr(fs, ino, &inode);
 	if (err)
-		goto write_out;
+		return translate_error(fs, ino, err);
 
 	if (ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode))) {
 		err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), NULL,
 				   0, ~0ULL);
-		if (err) {
-			ret = translate_error(fs, ino, err);
-			goto write_out;
-		}
+		if (err)
+			return translate_error(fs, ino, err);
 	}
 
 	ext2fs_inode_alloc_stats2(fs, ino, -1,
@@ -1627,12 +1624,10 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 
 write_out:
 	err = fuse2fs_write_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
-out:
-	return ret;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
 }
 
 static int __op_unlink(struct fuse2fs *ff, const char *path)


