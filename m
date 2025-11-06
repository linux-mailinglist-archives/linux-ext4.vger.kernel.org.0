Return-Path: <linux-ext4+bounces-11579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B4C3DA01
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF47188D4D7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF2339709;
	Thu,  6 Nov 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrwAX/Sj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E1337690
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468584; cv=none; b=TTI8CzEkjJTJITGbU8h2nWWEcUpKDViPyoL+GZ5o1JNNT1Anbp0w8WWBOgsYiv4e6aKv1UFkaTb+NSe8LbFP3+31YN/B4HZD4i7JLnaKpe1Ec9XNuzj+lF3fW2nIODDCf1LByC0yaQAEkfnYSvAG3FKMdcfrUTAeowTqnqp5+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468584; c=relaxed/simple;
	bh=K7CnVsqqD3RHPxaEyOeVdYgDjpkN9FTxRxHXL5LKmP0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmuds5rPEkJW/mecDzWxILqMYActjV/IZ5s58zw53K4om4ESRRI84xwhvw18jZlZKhkEb3aKpbZ+OnJjjqO42en6amLqd8NOLwnLY1sbW9RMWkZYYUplMQdqLsNefnEN30HVobz/d3kPKRg+xUl6RAMxFjqEow7lsFa2dhGo06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrwAX/Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA1BC19424;
	Thu,  6 Nov 2025 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468584;
	bh=K7CnVsqqD3RHPxaEyOeVdYgDjpkN9FTxRxHXL5LKmP0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lrwAX/Sjko4UkajhlTYrwlYpZhrzMnHMM10pUMG9gD/K7rjyFM7GXo7kBjETBCnM+
	 BvRbKNl4eCDpaoGqMh9hgneLZ7ggU4UI04gg1JamTHoc+d6cJbj/6MDku4EqiatiI3
	 y5k96lVrTDqGK9tTqjrfh3spTp87qhb5UFBx/qGYT3ffUKob5I/KoyhiZwbF1lyMbL
	 tN9gVChEt1QJPtgw1mOO2uiGCkmD5Sclde3d2B7ZrpF7o4KlgMe4/LmDQjjMhpX5v6
	 ivHUi/AoxRKEUtwx07egHE53X2E7GpnHdV82odjAjLsvh37SoWYXB6Sc4JohAuQWKt
	 qRyrXN70fn33Q==
Date: Thu, 06 Nov 2025 14:36:23 -0800
Subject: [PATCH 1/9] fuse2fs: rework FUSE2FS_CHECK_CONTEXT not to rely on
 global_fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794182.2862990.17225600990620547570.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
References: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
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
index 589599f91b4390..e973f75736a245 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -252,9 +252,23 @@ struct fuse2fs {
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
+#define FUSE2FS_CHECK_CONTEXT_DESTROY(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), return)
+#define FUSE2FS_CHECK_CONTEXT_INIT(ff) \
+	__FUSE2FS_CHECK_CONTEXT((ff), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *file, int line);
@@ -963,10 +977,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	ext2_filsys fs;
 	errcode_t err;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return;
-	}
+	FUSE2FS_CHECK_CONTEXT_DESTROY(ff);
 
 	pthread_mutex_lock(&ff->bfl);
 	fs = ff->fs;
@@ -1139,10 +1150,7 @@ static void *op_init(struct fuse_conn_info *conn
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 
-	if (ff->magic != FUSE2FS_MAGIC) {
-		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
-		return NULL;
-	}
+	FUSE2FS_CHECK_CONTEXT_INIT(ff);
 
 	/*
 	 * Configure logging a second time, because libfuse might have
@@ -5602,16 +5610,13 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
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


