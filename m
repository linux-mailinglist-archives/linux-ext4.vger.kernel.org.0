Return-Path: <linux-ext4+bounces-10106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B7B588D5
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E53F7A5CB5
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A701C6A3;
	Tue, 16 Sep 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOlVoiZ5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505BE571
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981137; cv=none; b=km9cJcdI4Vm5wrtnL02uEE1/BJ9mj3zZEfrdRIJ3pZNxlPxoaOwycHXMeeq/rkcb4KoyLBj1ZOBI6r+j0mLYv3rOmjjvjoT1O5MXclzbY9p/wm2x5LALT/+N5QF5aZhQlNbHid+E9eivtHMSxx6kM5jNkVwEE7l8OFeu0NRB31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981137; c=relaxed/simple;
	bh=ZR2RB4kexZiT5mqLlPUj7SRI96S44NyYhYNsYTsOrlw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeY2R3zaq3nmaTcmN88NdmIop7MLyJI1ldmx/Bg6fL4G1w/nk6uPgPG3LEjekb5ZZlh4Q0h2LMOeARvPvosbQlp5vQJWqW8CVtc7CUGXooQ3wEBUFwrzl4/sUUSnRf4jGm+sld7/hmEKMvHojdIcezEvQwjLxfXPu5j+hPSeXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOlVoiZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86040C4CEF1;
	Tue, 16 Sep 2025 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981136;
	bh=ZR2RB4kexZiT5mqLlPUj7SRI96S44NyYhYNsYTsOrlw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NOlVoiZ5mt+515qRhwqIzxxdCDb08Ipop+fkJS2j8WSgtj9nTHjOO961V7+aafAex
	 srQHqeJQ7Vf97/uVGbO758Zm2cIPWnxIbhHVsoItN2FmSX8XC2zPkQaqzJhREIb4jY
	 IOJE5JzUSXyCo445ejseNuXJY4s9duetVljE12IrPoOsygB803lHrOVDnxmkYO+KdD
	 ZZzHHyomdmnIPV7Jt36Zf3KKA3Dzelq7Ub+a25JToBL/nz+bB+nCeZfR3QVSL/iVtz
	 yFYCvC8Usvb8gibrN3z0xUkSdiEt0Rgjcy5Vc1Auh7tEDcJe46hegr63xJ6+ky5uBq
	 12stH8BxtZ+JQ==
Date: Mon, 15 Sep 2025 17:05:35 -0700
Subject: [PATCH 3/3] fuse2fs: enable the shutdown ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065210.350393.10163706639168342705.stgit@frogsfrogsfrogs>
In-Reply-To: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
References: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement a bastardized version of EXT4_IOC_SHUTDOWN, because the people
who invented the ioctl got the direction wrong, so we can't actually
read the flags.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 80d1c79b5cce1c..101f0fa03c397d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -221,6 +221,7 @@ struct fuse2fs_file_handle {
 enum fuse2fs_opstate {
 	F2OP_READONLY,
 	F2OP_WRITABLE,
+	F2OP_SHUTDOWN,
 };
 
 /* Main program context */
@@ -276,7 +277,7 @@ struct fuse2fs {
 		} \
 	} while (0)
 
-#define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
+#define __FUSE2FS_CHECK_CONTEXT(ff, retcode, shutcode) \
 	do { \
 		if ((ff) == NULL || (ff)->magic != FUSE2FS_MAGIC) { \
 			fprintf(stderr, \
@@ -285,14 +286,17 @@ struct fuse2fs {
 			fflush(stderr); \
 			retcode; \
 		} \
+		if ((ff)->opstate == F2OP_SHUTDOWN) { \
+			shutcode; \
+		} \
 	} while (0)
 
 #define FUSE2FS_CHECK_CONTEXT(ff) \
-	__FUSE2FS_CHECK_CONTEXT((ff), return -EUCLEAN)
+	__FUSE2FS_CHECK_CONTEXT((ff), return -EUCLEAN, return -EIO)
 #define FUSE2FS_CHECK_CONTEXT_RETURN(ff) \
-	__FUSE2FS_CHECK_CONTEXT((ff), return)
+	__FUSE2FS_CHECK_CONTEXT((ff), return, return)
 #define FUSE2FS_CHECK_CONTEXT_ABORT(ff) \
-	__FUSE2FS_CHECK_CONTEXT((ff), abort())
+	__FUSE2FS_CHECK_CONTEXT((ff), abort(), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *func, int line);
@@ -4566,6 +4570,33 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 }
 #endif /* FITRIM */
 
+#ifndef EXT4_IOC_SHUTDOWN
+# define EXT4_IOC_SHUTDOWN	_IOR('X', 125, __u32)
+#endif
+
+static int ioctl_shutdown(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
+			  void *data)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	ext2_filsys fs = ff->fs;
+
+	if (!is_superuser(ff, ctxt))
+		return -EPERM;
+
+	err_printf(ff, "%s.\n", _("shut down requested"));
+
+	/*
+	 * EXT4_IOC_SHUTDOWN inherited the inverted polarity on the ioctl
+	 * direction from XFS.  Unfortunately, that means we can't implement
+	 * any of the flags.  Flush whatever is dirty and shut down.
+	 */
+	if (ff->opstate == F2OP_WRITABLE)
+		ext2fs_flush2(fs, 0);
+	ff->opstate = F2OP_SHUTDOWN;
+
+	return 0;
+}
+
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
@@ -4612,6 +4643,9 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		ret = ioctl_fitrim(ff, fh, data);
 		break;
 #endif
+	case EXT4_IOC_SHUTDOWN:
+		ret = ioctl_shutdown(ff, fh, data);
+		break;
 	default:
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
 		ret = -ENOTTY;


