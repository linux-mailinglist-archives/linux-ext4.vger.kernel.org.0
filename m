Return-Path: <linux-ext4+bounces-8892-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275AAFD55F
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7715D17C3B3
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBD2C15A6;
	Tue,  8 Jul 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkuEuEf2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DA2E36FE
	for <linux-ext4@vger.kernel.org>; Tue,  8 Jul 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996014; cv=none; b=A8+n0nEwxUNi5PeJRdbVkIRgtWXudBN8TvtDEEtj30mKjKWEDZ+ZwB85+2eBtIuk27euAh+9sXyy4bC2fio+flliKWBkhPCSRcR0+CFk+RpLxAzKu6d8dKi7bCxKcqTRCyiHPabrCwJTO9BlUsFcBSlngfiaPAN/uNDJD+XolG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996014; c=relaxed/simple;
	bh=nm8QqQDgJltRF76FyT8WTMHLZw2lyNt1AepY3EgdA+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1/JW8zxI5RVpSGMYYmCX3AmGnjZFUB+IBpDamLqsXPby1fPUOMi9HYNc1qIY7giDMOFEK9gljQlkLRAjfd7xFkiXnTcmikAIDUhAXdmLOF5qd9lxyIhCQ73FD7NghQHI04WR5uDPDuYpeCYDY6CjfXbelcaHTOwwx2wRniPmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkuEuEf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF2C4CEED;
	Tue,  8 Jul 2025 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996013;
	bh=nm8QqQDgJltRF76FyT8WTMHLZw2lyNt1AepY3EgdA+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkuEuEf25jvlP333M3IHPevSIwnYz9tPASV6w8micVvXMXaHQ/j384pl3oSIwFRm2
	 8L9FUaDd9u2pZ+MpWcggTmxxcIBFZPSMHx8UDkSBOI68xR4ajq1AyOZIyf28jT0a6Z
	 6v+z06uPYI3eEwAy6cWNVkD35U62aYgBgJ4XhwWb9aGaYPyX0I9++L1GQFudjjWbut
	 rzDT0XJR309yZFbL8y0GXZBbCtKnlt8lsaLDHo0E4txaVOoxXSel3ZgX+x3G4NnNs+
	 sGDt2nonBDF3uOrIqnPumb5HYsD8CxC+Z2so3DSkT3aknWfiATCGYZ6Rtto3HzZLZE
	 oKu2jV8TPT7hQ==
Date: Tue, 8 Jul 2025 10:33:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 10/8] fuse2fs: fix lockfile creation, again
Message-ID: <20250708173333.GD2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

On closer examination of the lockfile code, there is still a fatal flaw
in the locking logic.  This is born out by the fact that you can run:

# truncate -s 300m /tmp/a
# mkfs.ext2 /tmp/a
# fuse2fs -o kernel /tmp/a /mnt -o lockfile=/tmp/fuselock
# fuse2fs -o kernel /tmp/a /mnt -o lockfile=/tmp/fuselock

and the second mount attempt succeeds where it really shouldn't.  This
is due to the use of fopen(..., "w"), because "w" means "truncate or
create".  It does /not/ imply O_CREAT | O_EXCL, which fails if the file
already exists.  Theoretically that could have been done with mode
string "wx", but that's a glibc extension.

Fix this by calling open() directly with the O_ modes that we want.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3-rc3
Fixes: e50fbaa4d156a6 ("fuse2fs: clean up the lockfile handling")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b7201f7c8ed185..ff8d4668cee217 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4473,11 +4473,15 @@ int main(int argc, char *argv[])
 	}
 
 	if (fctx.lockfile) {
-		FILE *lockfile = fopen(fctx.lockfile, "w");
 		char *resolved;
+		int lockfd;
 
-		if (!lockfile) {
-			err = errno;
+		lockfd = open(fctx.lockfile, O_RDWR | O_CREAT | O_EXCL, 0400);
+		if (lockfd < 0) {
+			if (errno == EEXIST)
+				err = EWOULDBLOCK;
+			else
+				err = errno;
 			err_printf(&fctx, "%s: %s: %s\n", fctx.lockfile,
 				   _("opening lockfile failed"),
 				   strerror(err));
@@ -4485,7 +4489,7 @@ int main(int argc, char *argv[])
 			ret |= 32;
 			goto out;
 		}
-		fclose(lockfile);
+		close(lockfd);
 
 		resolved = realpath(fctx.lockfile, NULL);
 		if (!resolved) {

