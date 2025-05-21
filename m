Return-Path: <linux-ext4+bounces-8105-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78632ABFFD7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3C4E4E95
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B7239E8B;
	Wed, 21 May 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD5Pq+11"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF4186294
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867304; cv=none; b=lhEzmw9OgQqTlnCqoRKPE2OHGvWBikpTO0AtJ2UCGGHw63by6ksGcqciQT99k5PpwwaeoOjyHULkdIteYKhjacWoqhuax2oM4RTMwEy2cpPga6+aNWq6AbGOurolbAz4LPUOJS9XKSc5F/rCl74bxz5C+KRZ0EGf1TidLJil8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867304; c=relaxed/simple;
	bh=akPvdEyJ6ykDsJf6ZBFrckGF3mJp1KrxcOa6L/prvpo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V71xh28nKVjTMMsa/Xx99zZrOHhG7k4Fhvp132U4r5rSIQViMmXmvF/1PbPP3HPixMktD9vodPedFHqmhLcXfwSkmt5Kc6U7Ic2cFE0dNqi3uAD2Wfh2qWvrtBmtoES6hXc+N1zfo5IA0TvFdQYZnMB67FJAtsSe0qYjjwvFFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD5Pq+11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3A2C4CEE4;
	Wed, 21 May 2025 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867304;
	bh=akPvdEyJ6ykDsJf6ZBFrckGF3mJp1KrxcOa6L/prvpo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nD5Pq+119hDny6WS8Fll5Zwi8p+TwiYi8muZ0JWEPMTjAwmGEcNKW2rLHG1ttRfMw
	 l7I+0OV3wzHemUhp0+mw3RoZB3gxx/yeRlWm/uqkCLb6YTLBAF0kLicqPxCddB+gbb
	 MCSDCT8v1mrDSXob1wnSqRD/kg4AWSiR5gQxKDfWCXek6NpzGuRj+m0ysJpWD4TvOf
	 Id7r9C9eZMRg87gFxjj1D+KpPdIzvLEokTvC7fpyP844RuybnR4Os6lhuV7ugFhzkO
	 HwdsuwHv9ZvxjzhBewRK7nv+uF4F791BoRhnTY6jwldSKr8rubFC0gcnJqkr4D2jJE
	 wldkJY5iboF+g==
Date: Wed, 21 May 2025 15:41:43 -0700
Subject: [PATCH 26/29] fuse2fs: fix post-EOF preallocation clearing on
 truncation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678014.1383760.1321101978729586160.stgit@frogsfrogsfrogs>
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

generic/092 shows that truncating a file to its current size does not
clean out post-eof preallocations like the kernel does.  Adopt the
kernel's behavior for consistency.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 46ae73bd4e25bb..626e3a42181148 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2068,9 +2068,30 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	return ret;
 }
 
-static int truncate_helper(ext2_filsys fs, ext2_ino_t ino, off_t new_size)
+static int punch_posteof(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 {
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	blk64_t truncate_block = (new_size + fs->blocksize - 1) / fs->blocksize;
+	errcode_t err;
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), 0, truncate_block,
+			   ~0ULL);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
+{
+	ext2_filsys fs = ff->fs;
 	ext2_file_t file;
+	__u64 old_isize;
 	errcode_t err;
 	int ret = 0;
 
@@ -2078,17 +2099,40 @@ static int truncate_helper(ext2_filsys fs, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
+	err = ext2fs_file_get_lsize(file, &old_isize);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_close;
+	}
+
+	dbg_printf(ff, "%s: ino=%u isize=0x%llx new_size=0x%llx\n", __func__,
+		   ino,
+		   (unsigned long long)old_isize,
+		   (unsigned long long)new_size);
+
 	err = ext2fs_file_set_size2(file, new_size);
 	if (err)
 		ret = translate_error(fs, ino, err);
 
+out_close:
 	err = ext2fs_file_close(file);
 	if (ret)
 		return ret;
 	if (err)
 		return translate_error(fs, ino, err);
 
-	return update_mtime(fs, ino, NULL);
+	ret = update_mtime(fs, ino, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Truncating to the current size is usually understood to mean that
+	 * we should clear out post-EOF preallocations.
+	 */
+	if (new_size == old_isize)
+		return punch_posteof(ff, ino, new_size);
+
+	return 0;
 }
 
 static int op_truncate(const char *path, off_t len
@@ -2122,7 +2166,7 @@ static int op_truncate(const char *path, off_t len
 	if (ret)
 		goto out;
 
-	ret = truncate_helper(fs, ino, len);
+	ret = truncate_helper(ff, ino, len);
 	if (ret)
 		goto out;
 
@@ -2222,7 +2266,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	}
 
 	if (fp->flags & O_TRUNC) {
-		ret = truncate_helper(fs, file->ino, 0);
+		ret = truncate_helper(ff, file->ino, 0);
 		if (ret)
 			goto out;
 	}


