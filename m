Return-Path: <linux-ext4+bounces-10082-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A3B588AC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109E5584099
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1C2DC348;
	Mon, 15 Sep 2025 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPYo8i20"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958D2D1F6B
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980759; cv=none; b=HySswqWrsQmQV/amQWbQnoejFHQWXKGNGHaOQXLoOyJVTCTDG2Ot7AVDjcBlNOFnGHk+VYqSWki6yJK8bj4voGmPdhYW7UNbiI4eXUyJgVDwoXLGIrmmdU6rJoi1uR06s3RnGWMobbhqwtUfBxQVuvsB5EDrgxmPOt20SrglJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980759; c=relaxed/simple;
	bh=2+0etyJyh+8AopXL9NGwwfzlAWn7FubrPvdrmBu3YuY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNr+Fc0ILiCHRP0OHfAtbciBHlzMCwNK8w4MoCgkfb4WAZ0cJRxCGinFEcDHHfPzMhYZPalABbPJOSn+r2Culk9CRCnDjimn/pQtHPMF1/zmvHzoSlj7xS8hWUsR+eHGoIuAORPY/p7S1zvdAsiPj7Y2u3K0IO40Jm2zl78dpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPYo8i20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718E3C4CEF1;
	Mon, 15 Sep 2025 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980759;
	bh=2+0etyJyh+8AopXL9NGwwfzlAWn7FubrPvdrmBu3YuY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nPYo8i20Q+8+KRlOwYIhelcVz1fxnd++Tk48JOR0OnpeZQpT57kjOqU86YVQy5Hlu
	 DTU9pnz3to1IMFrK8YajaEt5FBEfyqclonC3amnYitObogJXXvhRf/tlgD66/7EqeZ
	 5mvmD4y00F7kQInuXfQfYyFvFTGYneZRh0Jn1icpYYqhpjPSvZv9NLZG1ubVSsVBbQ
	 R9bozDSEubihb+h2gAIKDiJRjLYq2CQIc5UOqXslPDtZ92Ym1D22Zp2DkJR0BG8qo/
	 nxCmuZP0gdTBT8eSZqMGciOkc0XVHfb/77FPrVJ1ziHMFb4f5zQprHGNizRYVaTdy/
	 uEb9m4htOPAIQ==
Date: Mon, 15 Sep 2025 16:59:18 -0700
Subject: [PATCH 1/9] fuse2fs: rework FUSE2FS_CHECK_CONTEXT not to rely on
 global_fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064113.349283.11609639510540263985.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
References: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 687255b57871ee..462ec8558567ee 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -246,9 +246,23 @@ struct fuse2fs {
 	return translate_error((fs), 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
 } while (0)
 
-#define FUSE2FS_CHECK_CONTEXT(ptr) do {if ((ptr)->magic != FUSE2FS_MAGIC) \
-	return translate_error(global_fs, 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
-} while (0)
+#define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
+	do { \
+		if ((ff) == NULL || (ff)->magic != FUSE2FS_MAGIC) { \
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
+#define FUSE2FS_CHECK_CONTEXT_RETURN(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), return)
+#define FUSE2FS_CHECK_CONTEXT_ABORT(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *file, int line);
@@ -751,10 +765,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	ext2_filsys fs;
 	errcode_t err;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return;
-	}
+	FUSE2FS_CHECK_CONTEXT_RETURN(ff);
 
 	pthread_mutex_lock(&ff->bfl);
 	fs = ff->fs;
@@ -927,10 +938,7 @@ static void *op_init(struct fuse_conn_info *conn
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return NULL;
-	}
+	FUSE2FS_CHECK_CONTEXT_ABORT(ff);
 
 	/*
 	 * Configure logging a second time, because libfuse might have
@@ -5254,16 +5262,13 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	case EXT2_ET_EA_KEY_NOT_FOUND:
 		ret = -ENODATA;
 		break;
-	/* Sometimes fuse returns a garbage file handle pointer to us... */
-	case EXT2_ET_MAGIC_EXT2_FILE:
-		ret = -EFAULT;
-		break;
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
 	case EXT2_ET_RO_FILSYS:
 		ret = -EROFS;
 		break;
+	case EXT2_ET_MAGIC_EXT2_FILE:
 	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
 	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
 	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:


