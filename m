Return-Path: <linux-ext4+bounces-10101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7473B588CB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4A3AD3B8
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10B4C9F;
	Tue, 16 Sep 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmbH7yAc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD95625
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981057; cv=none; b=LFZP6KLbanIdSi0etkNG3ZLXu5r9d4ALvzuS8KNrAwtKCh7ekAdZS4xUaw+Uo3u/B8DJ/wyM2glfJlX2We3lMVlMgOWRsPztAJu9DHjmpAUja2Zd3Dgy8uoILgglWQNMtDVdtNp8op9BCWAAqTbKqC9jZJHtKwPKp1XEcxnqdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981057; c=relaxed/simple;
	bh=CLsUwVFXLDcsOQCyBDrs1iU38dN87nBxHc5gynsM8PY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC7b8sFJG9wOFeku6Ajuc3cAjmDE1Qyjw9xP2lDAP8GdWC0igJHWKfHuubiREi5+8VkN6NeICO1SCeGvI5BXf6DsYDHoDLV6IH9Ca2JettfUxebdmGzMwrAyE5kaoQQ/QRyYLKv3bPmE9VhVf7pBiLHWk/G8NuwbnHKpnViVSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmbH7yAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F8DC4CEF1;
	Tue, 16 Sep 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981057;
	bh=CLsUwVFXLDcsOQCyBDrs1iU38dN87nBxHc5gynsM8PY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lmbH7yAc7PNmnAs00zTJ/WoXX5K9kEgVUMecwmcT1qyBqEjoqIItlGtcvNNDX9Jti
	 ZAWj1fs3XXA89yC9xkplKZh157EWEFuIDuNlkiWf1oVFFMD8PA7lpzkgJGCgFZFVOZ
	 Z9ZEKG0TpguBWwoCSHc03MiTz4J1zkir0loOmtiLSDzeMAakuOHVFKmGHs87Cr2zRj
	 ds5bl2WGk/sCMbI78+qVBlIAqF7z4xXGQ1VWWlx2C13JLJJBDJWUKLRy7PHaT27bR5
	 CZRU4CmOPT3AynyzJ4BI5Aptq1mgyuYra1ac2bq6gPdQ71j60yVkrynMUYGSGRZr/N
	 qj8ZTCagvCDDA==
Date: Mon, 15 Sep 2025 17:04:16 -0700
Subject: [PATCH 3/5] fuse2fs: print the function name in error messages,
 not the file name
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064986.350149.15362751238065820003.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
References: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

It would be nice to know which fuse op actually causes failures such as:
FUSE2FS (sda4): Directory block checksum does not match directory block at ../../misc/fuse2fs.c:819.

The filename is utterly pointless, there's only one for the whole
daemon.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5e8581438aa9d7..e0095b5c43c0c1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -289,9 +289,9 @@ struct fuse2fs {
 	__FUSE2FS_CHECK_CONTEXT((ff), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line);
+			     const char *func, int line);
 #define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
-			__FILE__, __LINE__)
+			__func__, __LINE__)
 
 /* for macosx */
 #ifndef W_OK
@@ -5417,7 +5417,7 @@ int main(int argc, char *argv[])
 }
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line)
+			     const char *func, int line)
 {
 	struct timespec now;
 	int ret = err;
@@ -5544,10 +5544,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 
 	if (ino)
 		err_printf(ff, "%s (inode #%d) at %s:%d.\n",
-			error_message(err), ino, file, line);
+			error_message(err), ino, func, line);
 	else
 		err_printf(ff, "%s at %s:%d.\n",
-			error_message(err), file, line);
+			error_message(err), func, line);
 
 	/* Make a note in the error log */
 	get_now(&now);
@@ -5555,14 +5555,14 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
 	fs->super->s_last_error_block = err; /* Yeah... */
-	strncpy((char *)fs->super->s_last_error_func, file,
+	strncpy((char *)fs->super->s_last_error_func, func,
 		sizeof(fs->super->s_last_error_func));
 	if (ext2fs_get_tstamp(fs->super, s_first_error_time) == 0) {
 		ext2fs_set_tstamp(fs->super, s_first_error_time, now.tv_sec);
 		fs->super->s_first_error_ino = ino;
 		fs->super->s_first_error_line = line;
 		fs->super->s_first_error_block = err;
-		strncpy((char *)fs->super->s_first_error_func, file,
+		strncpy((char *)fs->super->s_first_error_func, func,
 			sizeof(fs->super->s_first_error_func));
 	}
 


