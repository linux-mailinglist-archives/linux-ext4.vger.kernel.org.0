Return-Path: <linux-ext4+bounces-8107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF7ABFFDC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2387ADD39
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBD239E85;
	Wed, 21 May 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAoINpaM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FD1754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867335; cv=none; b=aBwewGdjienZVFZGxpVRMME1zrF/oPaXT8GPqsnUKgol1HuxNKcVjn5hC5C9be6rXibiDtUglP50GGfbkruuX01AHgqzeH7oZzDvoOfG+GSppswy+UTjwTcezE6dzPyZYWw+OKQEYZvzDkGM4cN9mZoeskA1MueKFlSoZ7I4D0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867335; c=relaxed/simple;
	bh=9BS4M+CaeiKKamS7oIWbbnbGgM0wUWfpf7sMaSOpaN0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMyu0IpGDH1ohmlW2klQzkMc1+DpESlcKH2zD3GjSBVJ0y0FiwUZq5jRUVcVZ/5guLL1I/GOL+I3qWARjkF74861hd5WArcot30FCG1DkjmAOz2K5ObOlFnuzE96OHh3zxFuQMBELxbJ+xwJ+kFrCDrkeL0tAE2SBdE9z3Q4UZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAoINpaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47232C4CEE4;
	Wed, 21 May 2025 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867335;
	bh=9BS4M+CaeiKKamS7oIWbbnbGgM0wUWfpf7sMaSOpaN0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fAoINpaMoSW+ezfzMa8PxMB0SjpTgsN+X0lF1gZKpnmMgg/MTEmAOowp9x3esamRV
	 42FdB/P+jy1926H57aDYwhnEcOiRyDgZWM8r43FG7/Ihb/8R/oKS4GweF1+nVh1DsA
	 f9F2+e4VSMmUfyY10NVCdclIygdjeVKny5FLOYL4VEn8oPY1R/boBbVVEtOj706cXy
	 TCjkk2f9yUSyAHKueJTehadQ5YQ/S6aaChqjwooo/TNXQVEFmCkS4IV3dIQWxdW0t6
	 e4TyfAtxvXGD84V0jTjIfDGAu4wMqENtSlpCeMcm489ScUCjeY3gysuXEkBOcnMTMa
	 iq5/J5asMzVuQ==
Date: Wed, 21 May 2025 15:42:14 -0700
Subject: [PATCH 28/29] fuse2fs: propagate default ACLs to new children
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678048.1383760.1562421474540065349.stgit@frogsfrogsfrogs>
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

generic/319 points out that we don't propagate the default ACL from a
directory into new children.  Do that, since that's expected behavior.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  124 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 21 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 71e81992cc1819..a9f753c775db09 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -866,6 +866,96 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	return ret;
 }
 
+static int __getxattr(struct fuse2fs *ff, ext2_ino_t ino, const char *name,
+		      void **value, size_t *value_len)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	err = ext2fs_xattr_get(h, name, value, value_len);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+out_close:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+	return ret;
+}
+
+static int __setxattr(struct fuse2fs *ff, ext2_ino_t ino, const char *name,
+		      void *value, size_t valuelen)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_xattrs_read(h);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	err = ext2fs_xattr_set(h, name, value, valuelen);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+out_close:
+	err = ext2fs_xattrs_close(&h);
+	if (err && !ret)
+		ret = translate_error(fs, ino, err);
+	return ret;
+}
+
+static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
+				  ext2_ino_t child)
+{
+	void *def;
+	size_t deflen;
+	int ret;
+
+	if (!ff->acl)
+		return 0;
+
+	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
+			 &deflen);
+	switch (ret) {
+	case -ENODATA:
+	case -ENOENT:
+		/* no default acl */
+		return 0;
+	case 0:
+		break;
+	default:
+		return ret;
+	}
+
+	ret = __setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def, deflen);
+	ext2fs_free_mem(&def);
+	return ret;
+}
+
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -989,6 +1079,9 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
+	ret = propagate_default_acls(ff, parent, child);
+	if (ret)
+		goto out2;
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -1130,6 +1223,10 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out3;
 	}
 
+	ret = propagate_default_acls(ff, parent, child);
+	if (ret)
+		goto out3;
+
 out3:
 	ext2fs_free_mem(&block);
 out2:
@@ -2554,7 +2651,6 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
-	struct ext2_xattr_handle *h;
 	void *ptr;
 	size_t plen;
 	ext2_ino_t ino;
@@ -2583,23 +2679,9 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	if (ret)
 		goto out;
 
-	err = ext2fs_xattrs_open(fs, ino, &h);
-	if (err) {
-		ret = translate_error(fs, ino, err);
+	ret = __getxattr(ff, ino, key, &ptr, &plen);
+	if (ret)
 		goto out;
-	}
-
-	err = ext2fs_xattrs_read(h);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out2;
-	}
-
-	err = ext2fs_xattr_get(h, key, &ptr, &plen);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out2;
-	}
 
 	if (!len) {
 		ret = plen;
@@ -2611,10 +2693,6 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	}
 
 	ext2fs_free_mem(&ptr);
-out2:
-	err = ext2fs_xattrs_close(&h);
-	if (err && !ret)
-		ret = translate_error(fs, ino, err);
 out:
 	pthread_mutex_unlock(&ff->bfl);
 
@@ -3153,6 +3231,10 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
+	ret = propagate_default_acls(ff, parent, child);
+	if (ret)
+		goto out2;
+
 	ret = __op_open(ff, path, fp);
 	if (ret)
 		goto out2;


