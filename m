Return-Path: <linux-ext4+bounces-8440-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD8ADB4E8
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jun 2025 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AEF188B53A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jun 2025 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBF20F087;
	Mon, 16 Jun 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFIDiYoq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947D2BEFF9
	for <linux-ext4@vger.kernel.org>; Mon, 16 Jun 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086376; cv=none; b=hngGnGltbvWNO1SDJQEfKeDwjRgdZU+EpQrnZtixy6CSh0AEWGqRv91gtifT6BxvNXcD9Lxbr3JpkJ3IxHIZ719ltwJgUnNlMEtAwuM2uYL9MF/WcDseHtJoQp2ShPttqZdCMYKw5vSZaTtMFxvv3I4nxwvYJ5T5eibEK22/sNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086376; c=relaxed/simple;
	bh=sbtVcvtxysmRyzj/aMqegOWtp2HYVhtGH+0s8ynEfkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6D9CE9TBrOpDeQXi2qIlbTAnJ56Gor94baFpVBozzvwSkqcDMq4LaUjDaTg4GFRbMkkLYLlezwpKDOKuhYQ186M1emI9NLlfThy8xGljn7r0nMtTPAIkFo1jlBS+NoEYjHigZO27V4mkXQayM7i3vDnR9UfP9JaU1iejEvLud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFIDiYoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCEC4CEEA;
	Mon, 16 Jun 2025 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750086375;
	bh=sbtVcvtxysmRyzj/aMqegOWtp2HYVhtGH+0s8ynEfkY=;
	h=Date:From:To:Cc:Subject:From;
	b=EFIDiYoqvNgUfkhxYFGC6mo4pgrYwTFgMhn3N649Dm2jgAe0uc01rHiTkav3djL0C
	 crPb4BYxxASmyCMRVS3A3frznuaaJj4I5gZbi+EsTjI5AQhCZ0+CPjFeBG3LiSCh3M
	 s1xQHgzpZ3pK0lxwrv/oGHUMdRTkwVvrAmnsS/vl7dzDubR8IZtGXfNNEStXQGi5hb
	 eL5sTH5OZiSq02vE9o+Kdd/0VUQRbiF9BCKgzwSbB+DLGaz5+KTISeveuOBV8XePiH
	 IuaJerh087Ru3ANO1Ce4HjCk5cKgfeS969ABZNUO2engEf5NNSw2qbTADZt1XPMJCB
	 +oZWE9hqt/3CA==
Date: Mon, 16 Jun 2025 08:06:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Tim Woodall <debianbugs@woodall.me.uk>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] fuse2fs: clean up the lockfile handling
Message-ID: <20250616150614.GG6134@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

Fix various problems with the new lockfile code in fuse2fs: the printfs
should use the actual logging function err_printf, the messages should
be looked up in gettext, we should actually exit main properly on
error instead of calling exit(), and the error message printing for the
final lockfile unlink is broken.

Fixes: e83c0df0135f98 ("fuse2fs: rename the inusefile option to lockfile")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0f9cb6849aa7ad..bb75d9421283ed 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4417,19 +4417,31 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
-	if(fctx.lockfile) {
-		FILE* lockfile=fopen(fctx.lockfile, "w");
-		if(!lockfile) {
-			fprintf(stderr, "Requested lockfile=%s but couldn't open the file for writing\n", fctx.lockfile);
-			exit(1);
+	if (fctx.lockfile) {
+		FILE *lockfile = fopen(fctx.lockfile, "w");
+		char *resolved;
+
+		if (!lockfile) {
+			err = errno;
+			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
+				   _("opening lockfile failed"),
+				   strerror(err));
+			fctx.lockfile = NULL;
+			ret |= 32;
+			goto out;
 		}
 		fclose(lockfile);
-		char* resolved = realpath(fctx.lockfile, NULL);
+
+		resolved = realpath(fctx.lockfile, NULL);
 		if (!resolved) {
-			perror("realpath");
-			fprintf(stderr, "Could not resolve realpath for lockfile=%s\n", fctx.lockfile);
+			err = errno;
+			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
+				   _("resolving lockfile failed"),
+				   strerror(err));
 			unlink(fctx.lockfile);
-			exit(1);
+			fctx.lockfile = NULL;
+			ret |= 32;
+			goto out;
 		}
 		free(fctx.lockfile);
 		fctx.lockfile = resolved;
@@ -4639,14 +4651,15 @@ int main(int argc, char *argv[])
 			com_err(argv[0], err, "while closing fs");
 		global_fs = NULL;
 	}
-	if(fctx.lockfile) {
-		err = unlink(fctx.lockfile);
-		if (err)
-			com_err(argv[0], errno, "while unlinking '%s'",
-				fctx.lockfile);
-	}
-	if (fctx.lockfile)
+	if (fctx.lockfile) {
+		if (unlink(fctx.lockfile)) {
+			err = errno;
+			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
+				   _("removing lockfile failed"),
+				   strerror(err));
+		}
 		free(fctx.lockfile);
+	}
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);

