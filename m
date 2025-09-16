Return-Path: <linux-ext4+bounces-10092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D8B588BF
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC5C188993B
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643351C4A2D;
	Tue, 16 Sep 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEWBJVWE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4A1A8F84
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980916; cv=none; b=jn8BuFy0EEA0nHb9FfqbbexgxmkbVFTPjI7BSlV1lxc4SRP5EwyE7LZBIhicXlujKkp/enofRLBQstM8kyR86lK7Pu9klxUkT+5nQOiGP2gOXTg2RW+IzaZtDH471zU04SRgVrqLSnUOe1HY0MSVd7KVYS94ztxkjcgwf0Z96cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980916; c=relaxed/simple;
	bh=zM5yxklSY4T9396bhDLVgGA+mT8kTU/q1pwUo6at/pU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzVbShjRWLoeTNO0jG5lFuPgSnJjODRHRmc027czoqDHj6CbJHn6RQz++pLVklNkIOKzmsPaem33M6UOKS3KQEd89JPCdIyvZqf6Er2vJ2kPFuac7yRIX+I6YWxxnNTMI9hCXXDgba/n8aRY059oCHAnwNPEN3hEloh/bZVJK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEWBJVWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E72EC4CEF1;
	Tue, 16 Sep 2025 00:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980915;
	bh=zM5yxklSY4T9396bhDLVgGA+mT8kTU/q1pwUo6at/pU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iEWBJVWEWnrqoTtlnyVq/NS1PVzwBitzYvkqvHBSoOX0FAwiP6pCcdwdjy0EmCWrC
	 j5rx4VK6L5TtJzZEndUXCkYsQv9LqYAFajIRhX4Igo4epVegNzjJHSvOXlo1x3fVVs
	 r9JC2DwVR2ohaKC3ItdNFwrcsJM6pFywJSZSjBPc5RF/8n/hVW3DG1o2IwFUzfPRe/
	 egeRZZYFT/uRpEwXP3gT+t3RteAkl+Z1Pvqg/CvHZWcSfeFFKoPvbl7GBbXOJa0m9x
	 Ad6NB27PGpGYcuhlauOsVdxKJKZ5g8aghzergKqHxWI4550qOSA5zcBW0sVcNSe8nE
	 j+sPOpVMdn2FQ==
Date: Mon, 15 Sep 2025 17:01:55 -0700
Subject: [PATCH 2/3] fuse2fs: hoist lockfile code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064428.349669.9439688431509746889.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064383.349669.5686318690824770898.stgit@frogsfrogsfrogs>
References: <175798064383.349669.5686318690824770898.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hoist the lockfile handling code into separate helpers before we start
rearranging the code that opens and closes filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   94 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 41 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 948a12c2812b65..a66c0496e66dcf 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -859,6 +859,54 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	return -EACCES;
 }
 
+static errcode_t fuse2fs_acquire_lockfile(struct fuse2fs *ff)
+{
+	char *resolved;
+	int lockfd;
+	errcode_t err;
+
+	lockfd = open(ff->lockfile, O_RDWR | O_CREAT | O_EXCL, 0400);
+	if (lockfd < 0) {
+		if (errno == EEXIST)
+			err = EWOULDBLOCK;
+		else
+			err = errno;
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("opening lockfile failed"),
+			   strerror(err));
+		ff->lockfile = NULL;
+		return err;
+	}
+	close(lockfd);
+
+	resolved = realpath(ff->lockfile, NULL);
+	if (!resolved) {
+		err = errno;
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("resolving lockfile failed"),
+			   strerror(err));
+		unlink(ff->lockfile);
+		ff->lockfile = NULL;
+		return err;
+	}
+	free(ff->lockfile);
+	ff->lockfile = resolved;
+
+	return 0;
+}
+
+static void fuse2fs_release_lockfile(struct fuse2fs *ff)
+{
+	if (unlink(ff->lockfile)) {
+		errcode_t err = errno;
+
+		err_printf(ff, "%s: %s: %s\n", ff->lockfile,
+			   _("removing lockfile failed"),
+			   strerror(err));
+	}
+	free(ff->lockfile);
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -4962,38 +5010,9 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
-	if (fctx.lockfile) {
-		char *resolved;
-		int lockfd;
-
-		lockfd = open(fctx.lockfile, O_RDWR | O_CREAT | O_EXCL, 0400);
-		if (lockfd < 0) {
-			if (errno == EEXIST)
-				err = EWOULDBLOCK;
-			else
-				err = errno;
-			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
-				   _("opening lockfile failed"),
-				   strerror(err));
-			fctx.lockfile = NULL;
-			ret |= 32;
-			goto out;
-		}
-		close(lockfd);
-
-		resolved = realpath(fctx.lockfile, NULL);
-		if (!resolved) {
-			err = errno;
-			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
-				   _("resolving lockfile failed"),
-				   strerror(err));
-			unlink(fctx.lockfile);
-			fctx.lockfile = NULL;
-			ret |= 32;
-			goto out;
-		}
-		free(fctx.lockfile);
-		fctx.lockfile = resolved;
+	if (fctx.lockfile && fuse2fs_acquire_lockfile(&fctx)) {
+		ret |= 32;
+		goto out;
 	}
 
 	/* Start up the fs (while we still can use stdout) */
@@ -5224,15 +5243,8 @@ int main(int argc, char *argv[])
 		}
 		fctx.fs = NULL;
 	}
-	if (fctx.lockfile) {
-		if (unlink(fctx.lockfile)) {
-			err = errno;
-			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
-				   _("removing lockfile failed"),
-				   strerror(err));
-		}
-		free(fctx.lockfile);
-	}
+	if (fctx.lockfile)
+		fuse2fs_release_lockfile(&fctx);
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);


