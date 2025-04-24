Return-Path: <linux-ext4+bounces-7467-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E776A9BA05
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935625A8008
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E21E087;
	Thu, 24 Apr 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj68pWFu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F37199949
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530848; cv=none; b=CwubXA5I7TkKcmV4vPdfh+uuwGBVxwQb6nYbuY3HxfTHiTUniR8RCJlMQz+FJ1tyexk9AWZRu3cpxUrizESGv8uF0pcITpminuuyB2EQOJGErdBgvP0sIrRwTneTka0YR6oCEMTWpyH9dKbIVCGNVAtCRM8V6gCdA6sKh11dZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530848; c=relaxed/simple;
	bh=6HMuTo8t52WSqRXgMZ0SbycaC1DY4Qc11a+RZ8LZ3wo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdAIYATCIcXjRoYOQu4OHLqNi3zEtoy4hyQ/bk0ZQ3umqBPd8vGth0ggo0FTVdSDj71GuDA4PWB1Rrf2ZQA3k5VSa/aW55NEx1RxpQ1/Mmn4pG4oM8BLMhaShptqOjAwihwsfyIbAPgDih4S9DFsd517DB2aHFOIViCyCJaggv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj68pWFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B8C4CEE3;
	Thu, 24 Apr 2025 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530847;
	bh=6HMuTo8t52WSqRXgMZ0SbycaC1DY4Qc11a+RZ8LZ3wo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oj68pWFuZYw6f2q9zYqHA2vwm9wvCuJwFgbjrtcchx3V+10y7IIo3+WnTajF8zFRT
	 baR4SPd+U2ufMfBN7jCnSf1aWw13j9hjPQwTSipUY2PvyPZo2Nm0rtSmuDK11uUDtK
	 Zs/GuVT+CunvEWiF1ggIPkiDIvLdYjy3vf4vcs02HErzGvJhhUDjZRz08/3LaoqA3Q
	 vkoBPrp4/gIY/98rER/DhX8nf5ZfuByNj+3RNwGE0qrKvbx9n+4g8lZBCdh65l4fjJ
	 KRx65pklkHK79MgRZasE/yhfaY+MYZELqKzbj1MM/w8gh7JcvTi54GwWUftOqxRqCg
	 RG7pz1mmAU1ag==
Date: Thu, 24 Apr 2025 14:40:47 -0700
Subject: [PATCH 3/3] fuse2fs: make "ro" behavior consistent with the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064727.1160289.10466952108264302412.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
References: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make the behavior of the "ro" mount option consistent with the kernel:
User programs cannot change the files in the filesystem, but the driver
itself is allowed to update the filesystem metadata.  This means that ro
mounts can recover the journal.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 991a9f6733148d..f974171d3e726d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3739,6 +3739,7 @@ enum {
 
 static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("ro",		ro,			1),
+	FUSE2FS_OPT("rw",		ro,			0),
 	FUSE2FS_OPT("errors=panic",	panic_on_error,		1),
 	FUSE2FS_OPT("minixdf",		minixdf,		1),
 	FUSE2FS_OPT("fakeroot",		fakeroot,		1),
@@ -3784,13 +3785,12 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -V   --version   print version\n"
 	"\n"
 	"fuse2fs options:\n"
-	"    -o ro                  read-only mount\n"
 	"    -o errors=panic        dump core on error\n"
 	"    -o minixdf             minix-style df\n"
 	"    -o fakeroot            pretend to be root for permission checks\n"
 	"    -o no_default_opts     do not include default fuse options\n"
 	"    -o offset=<bytes>      similar to mount -o offset=<bytes>, mount the partition starting at <bytes>\n"
-	"    -o norecovery	    don't replay the journal (implies ro)\n"
+	"    -o norecovery          don't replay the journal\n"
 	"    -o fuse2fs_debug       enable fuse2fs debugging\n"
 	"\n",
 			outargs->argv[0]);
@@ -3838,7 +3838,8 @@ int main(int argc, char *argv[])
 	char *logfile;
 	char extra_args[BUFSIZ];
 	int ret = 0;
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
+		    EXT2_FLAG_RW;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
@@ -3857,11 +3858,6 @@ int main(int argc, char *argv[])
 	else
 		fctx.shortdev = fctx.device;
 
-	if (fctx.norecovery)
-		fctx.ro = 1;
-	if (fctx.ro)
-		log_printf(&fctx, "%s\n", _("Mounting read-only."));
-
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_CTYPE, "");
@@ -3892,8 +3888,6 @@ int main(int argc, char *argv[])
 
 	/* Start up the fs (while we still can use stdout) */
 	ret = 2;
-	if (!fctx.ro)
-		flags |= EXT2_FLAG_RW;
 	char options[50];
 	sprintf(options, "offset=%lu", fctx.offset);
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
@@ -3912,7 +3906,9 @@ int main(int argc, char *argv[])
 		if (fctx.norecovery) {
 			log_printf(&fctx, "%s\n",
  _("Mounting read-only without recovering journal."));
-		} else if (!fctx.ro) {
+			fctx.ro = 1;
+			global_fs->flags &= ~EXT2_FLAG_RW;
+		} else {
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
 			err = ext2fs_run_ext3_journal(&global_fs);
 			if (err) {
@@ -3923,14 +3919,10 @@ int main(int argc, char *argv[])
 			}
 			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
 			ext2fs_mark_super_dirty(global_fs);
-		} else {
-			err_printf(&fctx, "%s\n",
- _("Journal needs recovery; running `e2fsck -E journal_only' is required."));
-			goto out;
 		}
 	}
 
-	if (!fctx.ro) {
+	if (global_fs->flags & EXT2_FLAG_RW) {
 		if (ext2fs_has_feature_journal(global_fs->super))
 			log_printf(&fctx, "%s\n",
  _("Writing to the journal is not supported."));
@@ -3979,6 +3971,9 @@ int main(int argc, char *argv[])
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
 
+	if (fctx.ro)
+		fuse_opt_add_arg(&args, "-oro");
+
 	if (fctx.fakeroot) {
 #ifdef HAVE_MOUNT_NODEV
 		fuse_opt_add_arg(&args,"-onodev");


