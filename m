Return-Path: <linux-ext4+bounces-10075-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E50B587BD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B324C3325
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B842D7DEF;
	Mon, 15 Sep 2025 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn+lbhrC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016829617D
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976223; cv=none; b=r6HIpSMvYbfDtRudTsPYT/l5hsPlXR6AVED2BSLGcWwhc88nWPAm41m5CoND9g93JvOE4gDRb7oSR9EeHh6IWqh30+W2dkeasThvTYT9q0INwcQATb44E6QzWIKmN1/AFMyK0DjMoVlb+oZtHiJWALOJ7t9Fk5TuklNbw8zv19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976223; c=relaxed/simple;
	bh=luZDz6MPD19NJ+nr1qgiqjn8hCjqseaB724qacYv/NY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bxf5/IIKvEdwhTzy/Kw2j0ghcnAFzgqTC5JDeBdtYmyjnSG9S7QZfXkZvCYtZKNvKhufEOG0kB8IBh4yqF094+X7UypWg54rTe4QEYtV6EcQI4z7UVdsEhCp1D6+36FDW/WGsnzq33P5wcvEiYZKOe0uH/S9aLpzBBr2hR2N8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn+lbhrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C7C4CEF1;
	Mon, 15 Sep 2025 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976223;
	bh=luZDz6MPD19NJ+nr1qgiqjn8hCjqseaB724qacYv/NY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pn+lbhrCBftH3f8gZl8z+lN6GDIganUjBzB17lXNIyFEDqyYF6iNicCxT6QpwKJRD
	 a0sr56CI9ICkOTV1TaFVXBO07x8v0xZ+cByWL7+H6Wx3VLw8HK4uMSrJ1V50MRiQ5n
	 IlhBsy3aWOzYuO++N66+EBZ77bQOiehr/F9uGQ0LFcgrOI+oVGqL+hFitBWopiUEQ2
	 M/1oJw/ZNDFT/VceJqA5NwZM4CVMEDOSkHKtD0j157Zl/lyy1uH/bqxEiPjHMsZN71
	 8sSrGNz4/fyhSIqgPx054iVIbjALkEpx+JIug6uQig+xmK6CamWMA6spqS46QCd8sY
	 8ykmr9zqXHM/w==
Date: Mon, 15 Sep 2025 15:43:42 -0700
Subject: [PATCH 11/11] fuse2fs: improve error handling behaviors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570211.246189.398253569156678998.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.1.in |    6 ++++++
 misc/fuse2fs.c    |   42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index b18b7f3464bc74..6acfa092851292 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -60,6 +60,12 @@ .SS "fuse2fs options:"
 \fB-o\fR dirsync
 Flush dirty metadata to disk after every directory update.
 .TP
+\fB-o\fR errors=continue
+ignore errors
+.TP
+\fB-o\fR errors=remount-ro
+stop allowing writes after errors
+.TP
 \fB-o\fR errors=panic
 dump core on error
 .TP
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e54a2d7f9ae523..687255b57871ee 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -223,7 +223,7 @@ struct fuse2fs {
 	int ro;
 	int debug;
 	int no_default_opts;
-	int panic_on_error;
+	int errors_behavior; /* actually an enum */
 	int minixdf;
 	int fakeroot;
 	int alloc_all_blocks;
@@ -4691,6 +4691,7 @@ enum {
 	FUSE2FS_HELPFULL,
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
+	FUSE2FS_ERRORS_BEHAVIOR,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -4698,7 +4699,6 @@ enum {
 static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("ro",		ro,			1),
 	FUSE2FS_OPT("rw",		ro,			0),
-	FUSE2FS_OPT("errors=panic",	panic_on_error,		1),
 	FUSE2FS_OPT("minixdf",		minixdf,		1),
 	FUSE2FS_OPT("bsddf",		minixdf,		0),
 	FUSE2FS_OPT("fakeroot",		fakeroot,		1),
@@ -4718,6 +4718,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
+	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -4752,6 +4753,21 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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
@@ -4779,6 +4795,8 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
+	"    -o errors=             behavior when an error is encountered:\n"
+	"                           continue|remount-ro|panic\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5069,6 +5087,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!fctx.errors_behavior)
+		fctx.errors_behavior = global_fs->super->s_errors;
+
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
@@ -5338,8 +5359,23 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	fs->super->s_error_count++;
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_flush(fs);
-	if (ff->panic_on_error)
+	switch (ff->errors_behavior) {
+	case EXT2_ERRORS_CONTINUE:
+		err_printf(ff, "%s\n",
+ _("Continuing after errors; is this a good idea?"));
+		break;
+	case EXT2_ERRORS_RO:
+		if (fs->flags & EXT2_FLAG_RW)
+			err_printf(ff, "%s\n",
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


