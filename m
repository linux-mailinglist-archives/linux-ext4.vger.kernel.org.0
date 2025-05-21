Return-Path: <linux-ext4+bounces-8126-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC6AC0000
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798A31BC150E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675692192E3;
	Wed, 21 May 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIZ3uBY9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71D1EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867633; cv=none; b=mZPXgTQaI2po76DSaSExi+noh6B6X1J1kGy4wqjkr/nqUHxQKBtVnI8cDdrwIES6PwOyF6oveBZJ4nyzbWs4SNS7hjjHE0jFQyeZtsknjHVmubbgZwbjkAPscyTuvLazt5BZO/yAbGO8+Dwv3GujkyF/deEfcaSsOJETxFRw1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867633; c=relaxed/simple;
	bh=1d5nniOkwaWdCzyLfbNkEoCJppLPBKtd7V5eEO4U1UY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK00Q1xkZDbuvHCyLWku7OzLr/M1AiXtTWzx5eITf/Xshq49tH7pOG+rkenx6mQEEfRR4KeUOjMtpAA6zy27zOApyk2XhYuT8QXcI9UOWAm1cHoFclvc02Fd0t3lNzgLrawKeihw/DUWWta4rfK9Ic1qhNcbipfiKXzMztkRX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIZ3uBY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52CEC4CEE4;
	Wed, 21 May 2025 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867632;
	bh=1d5nniOkwaWdCzyLfbNkEoCJppLPBKtd7V5eEO4U1UY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DIZ3uBY91XrY8yZlxJundzPJp9XF9qzexKSvLofQKmO/h/vTIU1Q+p3WwDsqf6ry0
	 02Yt1E2QakFx1eShZIkInDXWzc+PXuibCT67T88u7kvSPd3VIO5K1fA3SmWYAYSq0Z
	 OPUlC11M+AkLRhwRoSEEccRnklSZcLrDoMI3eXPoNTgxpoJs+GP8/goK50roY+aVse
	 5EkXu3g9D+pgJDcTJeO3i8UxLHC6x4mGdY/iRvf/xBl5LQJhScER8dnSkOO2ZRbUhz
	 Oj2AwyG3t+J621Qx1o/f7/dDcS1ByK13xIhMCzOsKjqZ0ASNoRSARaRdV5tVPsiHhi
	 l2ByRxYwDzVvw==
Date: Wed, 21 May 2025 15:47:12 -0700
Subject: [PATCH 08/10] fuse2fs: improve error handling behaviors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678835.1385354.17591732684085988440.stgit@frogsfrogsfrogs>
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

Make the behavior of fuse2fs on filesystem errors consistent with what
the kernel driver does.  Sort of.  We can't panic the kernel, but we can
abort the server, which leaves a dead mount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 2d4b9c8f51264e..7f9f230f37ed2b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -152,7 +152,7 @@ struct fuse2fs {
 	uint8_t ro;
 	uint8_t debug;
 	uint8_t no_default_opts;
-	uint8_t panic_on_error;
+	uint8_t errors_behavior; /* actually an enum */
 	uint8_t minixdf;
 	uint8_t fakeroot;
 	uint8_t alloc_all_blocks;
@@ -841,6 +841,9 @@ _("Mounting read-only without recovering journal."));
 		err_printf(ff, "%s\n",
  _("Orphans detected; running e2fsck is recommended."));
 
+	if (!ff->errors_behavior)
+		ff->errors_behavior = fs->super->s_errors;
+
 	return 0;
 }
 
@@ -4488,6 +4491,7 @@ enum {
 	FUSE2FS_HELPFULL,
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
+	FUSE2FS_ERRORS_BEHAVIOR,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -4495,7 +4499,6 @@ enum {
 static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("ro",		ro,			1),
 	FUSE2FS_OPT("rw",		ro,			0),
-	FUSE2FS_OPT("errors=panic",	panic_on_error,		1),
 	FUSE2FS_OPT("minixdf",		minixdf,		1),
 	FUSE2FS_OPT("bsddf",		minixdf,		0),
 	FUSE2FS_OPT("fakeroot",		fakeroot,		1),
@@ -4514,6 +4517,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
+	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -4548,6 +4552,21 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 			return -1;
 		}
 
+		/* do not pass through to libfuse */
+		return 0;
+	case FUSE2FS_ERRORS_BEHAVIOR:
+		if (strcmp(arg + 7, "continue") == 0)
+			ff->errors_behavior = EXT2_ERRORS_CONTINUE;
+		else if (strcmp(arg + 7, "remount-ro") == 0)
+			ff->errors_behavior = EXT2_ERRORS_RO;
+		else if (strcmp(arg + 7, "panic") == 0)
+			ff->errors_behavior = EXT2_ERRORS_PANIC;
+		else {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("unknown errors behavior."));
+			return -1;
+		}
+
 		/* do not pass through to libfuse */
 		return 0;
 	case FUSE2FS_IGNORED:
@@ -4574,6 +4593,8 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
+	"    -o errors=             behavior when an error is encountered:\n"
+	"                           continue|remount-ro|panic\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -4962,8 +4983,22 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	fs->super->s_error_count++;
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_flush(fs);
-	if (ff->panic_on_error)
+	switch (ff->errors_behavior) {
+	case EXT2_ERRORS_CONTINUE:
+		err_printf(ff, "%s\n",
+ _("Continuing after errors; is this a good idea?."));
+		break;
+	case EXT2_ERRORS_RO:
+		err_printf(ff, "%s\n",
+ _("Remounting read-only due to errors."));
+		fs->flags &= ~EXT2_FLAG_RW;
+		break;
+	case EXT2_ERRORS_PANIC:
+		err_printf(ff, "%s\n",
+ _("Aborting filesystem mount due to errors."));
 		abort();
+		break;
+	}
 
 	return ret;
 }


