Return-Path: <linux-ext4+bounces-8092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC04ABFFB0
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A321C1BC098C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF78230269;
	Wed, 21 May 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmftChwK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECA1754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867099; cv=none; b=ocU6I6WTKR+I7PGxOSqPFaMGk3bfPdOHmFtLsjKqm0a3iPLyaGliqtnyDVT7eTtZYkTXSMb6/fCnuIZIauSJAqA7tlEKoamREHDtTYFx1Kh4vxshQtErugSY+qVsUMT2Iq/7zjG5ehxFur6aJ+/K6tBq4FypxFSrAp40RrCc854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867099; c=relaxed/simple;
	bh=k3G1jXPVNcoBKK1W6FIHX/t4OcvAM84gEjlWuDLBjTU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUcGEApHPGkvdYz/CGhIomrWOiu5g/rGsdUy2+1aoKc8Q7+OjL61Z1arzTO3oxLBnmMmKkFhjTT1hJ5zlPpCwyS0VGz1W8ubWO/utZvhCIigWJsIAXP1NBRfsIwb0EOHjdhbvLfrFdZzL62KjOhbdy8Irjo56OySKCHU3rULehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmftChwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B81C4CEE4;
	Wed, 21 May 2025 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867099;
	bh=k3G1jXPVNcoBKK1W6FIHX/t4OcvAM84gEjlWuDLBjTU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DmftChwK6dDFCr7aTTL1dRvrB8GBMI/Slxxe7Frp767WBVIiy8Hz4dPpkH8zUnk5G
	 r7YLpXoTsCW8zzfoK+7IV2rWhl9D43L0tT1Hz20LE2nPdJWp56zAY2Ciy11uoxIlp1
	 w/g3zrn4CjCqDiCsPbACifr9LEVx5xvOFKxkqanzPK+gTo+fAewqkIu6iCnzJDdvlI
	 yD/ZUn1GPG8DyShQdVzNnR6voK1ITPIrzi3Orh9o0hLwmnnGGRrDrm7GmRguHXQ/+Z
	 W/XLPL26LAd1fBu3N/MR1DhHRDWDBJTPyJMsdm9Kk8GaaQX9z81p4DBy+LRAu50Dhw
	 cWF/ssb5XAljA==
Date: Wed, 21 May 2025 15:38:18 -0700
Subject: [PATCH 13/29] fuse2fs: implement O_TRUNC correctly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677783.1383760.5736479713431403960.stgit@frogsfrogsfrogs>
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

Actually truncate files on open with O_TRUNC.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   56 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 299e62d3935886..9e7d8b8fe5118d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1950,6 +1950,29 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	return ret;
 }
 
+static int truncate_helper(ext2_filsys fs, ext2_ino_t ino, off_t new_size)
+{
+	ext2_file_t file;
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_file_set_size2(file, new_size);
+	if (err)
+		ret = translate_error(fs, ino, err);
+
+	err = ext2fs_file_close(file);
+	if (ret)
+		return ret;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return update_mtime(fs, ino, NULL);
+}
+
 static int op_truncate(const char *path, off_t len
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
@@ -1959,9 +1982,8 @@ static int op_truncate(const char *path, off_t len
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
-	errcode_t err;
 	ext2_ino_t ino;
-	ext2_file_t file;
+	errcode_t err;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -1982,28 +2004,9 @@ static int op_truncate(const char *path, off_t len
 	if (ret)
 		goto out;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
-
-	err = ext2fs_file_set_size2(file, len);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out2;
-	}
-
-out2:
-	err = ext2fs_file_close(file);
+	ret = truncate_helper(fs, ino, len);
 	if (ret)
 		goto out;
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
-
-	ret = update_mtime(fs, ino, NULL);
 
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -2039,7 +2042,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	struct fuse2fs_file_handle *file;
 	int check = 0, ret = 0;
 
-	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	dbg_printf(ff, "%s: path=%s oflags=0o%o\n", __func__, path, fp->flags);
 	err = ext2fs_get_mem(sizeof(*file), &file);
 	if (err)
 		return translate_error(fs, 0, err);
@@ -2090,6 +2093,13 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		} else
 			goto out;
 	}
+
+	if (fp->flags & O_TRUNC) {
+		ret = truncate_helper(fs, file->ino, 0);
+		if (ret)
+			goto out;
+	}
+
 	fp->fh = (uintptr_t)file;
 
 out:


