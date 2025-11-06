Return-Path: <linux-ext4+bounces-11589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F0C3DA25
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECD1885994
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D55E32AAD4;
	Thu,  6 Nov 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2K7VIQ5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EED30504D
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468745; cv=none; b=eb+ES921ZVoaQsiLg3qvPQOF1HRPqNFjC3APhIXXWoWAi229YdNhh8y2sMZ0eQIvzN7zA0zI7XGhM3OtOnzXn6jqYTAW3FTK1bXR/WJlUYA71Zi65IDC1ElWGBTo/7eKGhwFCiXIYBmqTi+LkqmMl169WYF8R19OQGKkOUf4F1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468745; c=relaxed/simple;
	bh=iitghTmfZD4qBh4lbMUC72urbHpP2xmQxeIJMsbUjsw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rARNEyg81CSSmJgCZ8/ZpkkWvbmkdTbZv02nXmjNmS97twHEj1NfXiUV6qQD0Hw9gUTU7tmFTnB83dYQxBPSdiUMFZiL2ewwi4KEKIPq54bYX8ifJ/3m9ppFT68JnbP9cpDPamjF22mgUTxpo0Osp5vs/k9PBZS8liLtXAq++hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2K7VIQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5805BC113D0;
	Thu,  6 Nov 2025 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468744;
	bh=iitghTmfZD4qBh4lbMUC72urbHpP2xmQxeIJMsbUjsw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L2K7VIQ5vrxuTi1BI8Hq/eJgbtSsuA9uzgsTFV5XHopF8E534ALJs7VjvBdW9+76F
	 hIA/QdHFrdI1n2Dx+g3w/m3fMVIFSXlESvnASnmZthebufUEFUn1gC6fJpRZTWGc5O
	 dxeJsZxB1/bpf51ZeM6AVsXDh2o8NXqwu3M1RFhO2A2mwtVYvBKZDyKsGEEvtuiBuK
	 tv7nHoHNrKMJT84zYz/gFZnUNmiizYdbFaAWvdQ0hAeETIN9TIgl4xx7Z9/alBRcqf
	 /szMYBFtuiYwEgVjmrp4WNjHjIxEmejJzNpCSrR6jBuHowZdhL5llrtSEE1I13D/UP
	 wXSQJEDIsIo7A==
Date: Thu, 06 Nov 2025 14:39:03 -0800
Subject: [PATCH 2/3] fuse2fs: hoist lockfile code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794497.2863378.17661457507807625469.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
References: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
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
index 0020d149949835..cefc6442ae45ec 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1047,6 +1047,54 @@ static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
 	return 0;
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
@@ -5212,38 +5260,9 @@ int main(int argc, char *argv[])
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
@@ -5547,15 +5566,8 @@ int main(int argc, char *argv[])
 		if (err)
 			com_err(argv[0], err, "while closing fs");
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
 	pthread_mutex_destroy(&fctx.bfl);


