Return-Path: <linux-ext4+bounces-8119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E08DFABFFEF
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FCD1BC4FF8
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27423BCE3;
	Wed, 21 May 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxCRYQhs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53271B0F20
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867523; cv=none; b=snadhOOMnYuvukNIOuQRKhOGhueghTlMzn1zl50qVo8K8IbwcGHPTwH+Mvx4Wus7zRK7ZP91ODK8FXoRUMMrZpMzCu3GMVapg0K2Bz3ySVE4GH5a5sHLS7QSoWMQ8IGnv0AD9J4bm/QFmwi6aD/bwIDmfgY6IFmzgnIJTlCj83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867523; c=relaxed/simple;
	bh=Xw0keeaFjklyCmTneYf3ZH5vVm0aC0TskqWntAPOaCc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3idXfpo0LFMBAJHgLSEoEdf3gBkHTHyOQLDY5mCk5iO864zvTACAHkDECY50MYxuv3QI6qaelsoHBDAgPBnVh8wg6Wr8R2On5fNVt8F1vKCyR/Ui2BXBFCoIA/q945BqiSz9+Pw6JlNT9gQNiXY4HsJdYhgdANtA64lMcDrcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxCRYQhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306E8C4CEE4;
	Wed, 21 May 2025 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867523;
	bh=Xw0keeaFjklyCmTneYf3ZH5vVm0aC0TskqWntAPOaCc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PxCRYQhsaFwBTn0vkl1DaDlrmYU9e8heIOsCDPsRNxlylaPi09FKFQ4lhcEJaxTT/
	 y11tyQJA0Sf9lGoTV5Rov1Wyr82Tv3xax02uTBAOCINjENvDootkEO44QRPfZfLOaz
	 X1YLzBktpvQKxXYeBysFu+hQiYLgsKrpuXUieL1vd0oM1sNnFe+v+xj/SCDhtAwvEX
	 8UqB8qu0PJmqiW5By8iKdkbO2FTgv6pvsrSXOlCgomXqlhJIiiekXFbu7uV4B+AItx
	 lLsH2R1ezzmq67uvLM1VJohrBsHNnEKA7Z4R2M1O6bmsB41rflFlOypaK0u48Gz1tw
	 D9DI2viULbZRQ==
Date: Wed, 21 May 2025 15:45:22 -0700
Subject: [PATCH 01/10] fuse2fs: rework FUSE2FS_CHECK_CONTEXT not to rely on
 global_fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678709.1385354.14643549622558175074.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the fuse2fs object that libfuse hands to us has the wrong magic
number, something is clearly wrong.  In that case, we don't really want
to rely on the global_fs variable actually pointing to a valid
ext2_filsys object because something could be wrong there too.  Instead,
try to emit an error on stderr and just bail out.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 2368c87ef0b614..138e3292b2de09 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -175,9 +175,23 @@ struct fuse2fs {
 	return translate_error((fs), 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
 } while (0)
 
-#define FUSE2FS_CHECK_CONTEXT(ptr) do {if ((ptr)->magic != FUSE2FS_MAGIC) \
-	return translate_error(global_fs, 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
-} while (0)
+#define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
+	do { \
+		if ((ff)->magic != FUSE2FS_MAGIC) { \
+			fprintf(stderr, \
+				"FUSE2FS: Corrupt in-memory data at %s:%d!\n", \
+				__func__, __LINE__); \
+			fflush(stderr); \
+			retcode; \
+		} \
+	} while (0)
+
+#define FUSE2FS_CHECK_CONTEXT(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), return -EUCLEAN)
+#define FUSE2FS_CHECK_CONTEXT_NORET(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), return)
+#define FUSE2FS_CHECK_CONTEXT_NULL(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), return NULL)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *file, int line);
@@ -670,10 +684,8 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	ext2_filsys fs;
 	errcode_t err;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return;
-	}
+
+	FUSE2FS_CHECK_CONTEXT_NORET(ff);
 	fs = ff->fs;
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 	if (fs->flags & EXT2_FLAG_RW) {
@@ -722,10 +734,7 @@ static void *op_init(struct fuse_conn_info *conn
 	ext2_filsys fs;
 	errcode_t err;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return NULL;
-	}
+	FUSE2FS_CHECK_CONTEXT_NULL(ff);
 	fs = ff->fs;
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 #ifdef FUSE_CAP_IOCTL_DIR
@@ -4785,13 +4794,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 		ret = -ENOENT;
 #endif
 		break;
-	/* Sometimes fuse returns a garbage file handle pointer to us... */
-	case EXT2_ET_MAGIC_EXT2_FILE:
-		ret = -EFAULT;
-		break;
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
+	case EXT2_ET_MAGIC_EXT2_FILE:
 	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
 	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
 	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:


