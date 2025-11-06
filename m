Return-Path: <linux-ext4+bounces-11600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E7C3DA52
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9724834A92B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1E3491C4;
	Thu,  6 Nov 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niHGBdh+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC832EF67A
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468920; cv=none; b=T+wSFgcCyzeTPczjYJfHReZNf3nucUwd8JeEnV4anKzmYnUOBB2rxxcNcsAu4UTtNaZwCK9q69JKvaJFkyRmA4lROtRJY8ia5RkLHnOd5HR8VAOL3RtC2iMEmWEPy7hTBqQT7Idu4DhQCqMDzsYc9ON3IG3poaYL2HANZBObzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468920; c=relaxed/simple;
	bh=w1VEVDKRjIu97UWheoQIzve5RqsLfj8UAZ8CVw8YiEo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVddA4ixt0vZtliIa0X3gWwJbY5yBo+FLa+hF58QYlMCUDmtTwu295XdMyQ0bMDc5zH1wS+v1pXlZFz6F9dzkBB+PuOZZZ09hW4uJwQnvqNfWu9NvScdztaGcjtK3hoF0Q7hzMEdYkzC1x8qjR0ycDqT8o/f0S6riu6fa4W+WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niHGBdh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B6FC116D0;
	Thu,  6 Nov 2025 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468920;
	bh=w1VEVDKRjIu97UWheoQIzve5RqsLfj8UAZ8CVw8YiEo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=niHGBdh+P7S3/pzZ/OZvB00LqyNUXoKGOKAS8WefOeh9zuUHi53q/dw4u10854xcq
	 YrwEkN8hICENai6HccbSBQzl2UWxffXvZeNpawgIQNU6nHebsbcFd3+FHv4tuGEYp2
	 tbqMglNPGw//QkmgqL2nG1kaXzbkIF64hdq0jAPLskcE9XImzteNtEzS6AF5d0HpJL
	 2hneJkpMNRNJCl1LNra34Hv8Z6tFos+uJJs5IKEGlf5fAvFrLGhSVaxZIxphAoqTf3
	 uFfHQ9UkG2GG5bOLxx3C02ZGArHSP8h85T1cLUmacMLz+9btyK1XDntEuNzvSyDOAs
	 onhbkQL67Z8SQ==
Date: Thu, 06 Nov 2025 14:41:59 -0800
Subject: [PATCH 3/3] fuse2fs: enable the shutdown ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795104.2863930.12963756725107811944.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
References: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
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
read the flags.  So all we do is flush the filesystem, clear the
writable flags, and hope that's what the user wanted.

Since we change __FUSE2FS_CHECK_CONTEXT to return an error code on a
shut down filesystem, remove FUSE2FS_CHECK_CONTEXT_RETURN so that
op_destroy always tears everything down and logs the unmount message.
Later on in the iomap patchset this will become critical because we need
to try to close the block device before unmount completes to avoid
problems with fstests.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8d5b705280b72f..51e6b3b1969d62 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -222,6 +222,7 @@ struct fuse2fs_file_handle {
 enum fuse2fs_opstate {
 	F2OP_READONLY,
 	F2OP_WRITABLE,
+	F2OP_SHUTDOWN,
 };
 
 /* Main program context */
@@ -280,7 +281,7 @@ struct fuse2fs {
 		} \
 	} while (0)
 
-#define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
+#define __FUSE2FS_CHECK_CONTEXT(ff, retcode, shutcode) \
 	do { \
 		if ((ff) == NULL || (ff)->magic != FUSE2FS_MAGIC) { \
 			fprintf(stderr, \
@@ -289,14 +290,17 @@ struct fuse2fs {
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
 #define FUSE2FS_CHECK_CONTEXT_DESTROY(ff) \
-	__FUSE2FS_CHECK_CONTEXT((ff), return)
+	__FUSE2FS_CHECK_CONTEXT((ff), return, /* do not return */)
 #define FUSE2FS_CHECK_CONTEXT_INIT(ff) \
-	__FUSE2FS_CHECK_CONTEXT((ff), abort())
+	__FUSE2FS_CHECK_CONTEXT((ff), abort(), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *func, int line);
@@ -4863,6 +4867,36 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
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
+	fuse2fs_mmp_cancel(ff);
+
+	/*
+	 * EXT4_IOC_SHUTDOWN inherited the inverted polarity on the ioctl
+	 * direction from XFS.  Unfortunately, that means we can't implement
+	 * any of the flags.  Flush whatever is dirty and shut down.
+	 */
+	if (ff->opstate == F2OP_WRITABLE)
+		ext2fs_flush2(fs, 0);
+	ff->opstate = F2OP_SHUTDOWN;
+	fs->flags &= ~EXT2_FLAG_RW;
+
+	return 0;
+}
+
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
@@ -4909,6 +4943,9 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		ret = ioctl_fitrim(ff, fh, data);
 		break;
 #endif
+	case EXT4_IOC_SHUTDOWN:
+		ret = ioctl_shutdown(ff, fh, data);
+		break;
 	default:
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
 		ret = -ENOTTY;


