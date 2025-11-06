Return-Path: <linux-ext4+bounces-11575-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E67B6C3D9F5
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7964E4AC8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFF30EF91;
	Thu,  6 Nov 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnrMDSIp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E02C3252
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468520; cv=none; b=E0Kebg9H3SoxIZx9eiwPrzVNfcNSe7+RX9sSS1JCewSiIIg8B3CpsuzFISFrinWwVv1C7ED26U/kOJLZSIZ6Tz+S5QYXUwDKq7AkttrDj2xdir/F0U8VPBWj7emI+zRvkWvNBbAd4pcWXykEEs7UEX64N/Oa2S8M9OsPTxYuLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468520; c=relaxed/simple;
	bh=EGT5EnA8i7OfwPjDbNnN3iaDIonRoabgf32cJMV9JOw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGAHQviBLxfKK7JD+/bHCXiu38pqwzeWtPK7/DzZJjbkX0HWrUO35tcEdppj6i/meOWhTAU+CiWqpZe2pQMUWcockKQ4XnmLRp7IUS8EJYsDl+2ltc4K1GEOWLKvzXH+oHygxqxMVnYkR6/XVLT3bs0LkDodH3o2yRJ6a4R9lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnrMDSIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A36AC4CEF7;
	Thu,  6 Nov 2025 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468520;
	bh=EGT5EnA8i7OfwPjDbNnN3iaDIonRoabgf32cJMV9JOw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dnrMDSIpy+i+q42Gk1G0qescwi3Fn1482ZJGEugxIb5ECioCa2mP+3e7Mx3cSKy20
	 badM5ksIT+FIZ/obndruoG36n2Q9XEl015tZP2ej3PzR/YSiCftGFAGAVtlaTPhdys
	 4fIf+YofeNiuMc8eTBedsxSZDcXAnj+AHG7pIrhTWhGiJ6eUqy3OR/wZpI927FeARh
	 0K8+3/epIKq8gmcXnF3jqsgg5db82Gay1qAoAcTM3ZRgNcTefCBuanr8IlCHMC1Vtb
	 RFa5nbsz17QAg8RZZFxnnaVzO4oBrOgU9GwE67WxZI5QWMThgXDNX1OgBxwCECjkjm
	 +n3L15LkKNJug==
Date: Thu, 06 Nov 2025 14:35:19 -0800
Subject: [PATCH 16/19] fuse2fs: improve error handling behaviors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793918.2862242.3615380767315397985.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
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
index d890855df9c0f3..fd21f546db7fb1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -224,7 +224,7 @@ struct fuse2fs {
 	int ro;
 	int debug;
 	int no_default_opts;
-	int panic_on_error;
+	int errors_behavior; /* actually an enum */
 	int minixdf;
 	int fakeroot;
 	int alloc_all_blocks;
@@ -4771,6 +4771,7 @@ enum {
 	FUSE2FS_HELPFULL,
 	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
+	FUSE2FS_ERRORS_BEHAVIOR,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -4778,7 +4779,6 @@ enum {
 static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("ro",		ro,			1),
 	FUSE2FS_OPT("rw",		ro,			0),
-	FUSE2FS_OPT("errors=panic",	panic_on_error,		1),
 	FUSE2FS_OPT("minixdf",		minixdf,		1),
 	FUSE2FS_OPT("bsddf",		minixdf,		0),
 	FUSE2FS_OPT("fakeroot",		fakeroot,		1),
@@ -4798,6 +4798,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
+	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -4832,6 +4833,21 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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
@@ -4859,6 +4875,8 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
 	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
+	"    -o errors=             behavior when an error is encountered:\n"
+	"                           continue|remount-ro|panic\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -5226,6 +5244,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!fctx.errors_behavior)
+		fctx.errors_behavior = global_fs->super->s_errors;
+
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
@@ -5492,8 +5513,23 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
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


