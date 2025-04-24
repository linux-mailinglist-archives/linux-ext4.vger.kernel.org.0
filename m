Return-Path: <linux-ext4+bounces-7463-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C44A9BA00
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9451B8316E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1221FF2C;
	Thu, 24 Apr 2025 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzamJLkn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E1198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530785; cv=none; b=neaWQ6QFTihYATVhqfQMW3dQ9Af7vLFTulVi+3AXlrGr3Jg1RhKvkmmC1/UqDOVEYSbKs2Evg16ar4EQrtxG35+j8iqrlj1YTbLwFjjA/IrU9n3JX7Jo7IaFlXPywkH1ePxWN9riMZMA9Q29k6PG8KU1+wggM1g3Sp71odyxQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530785; c=relaxed/simple;
	bh=bv0bvNTCZtZeJv0I9P2+KZpVeKWVEQnVgrtVJoNm2zU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeK6EVmTKhhaENTC+qZZDPk3RoQ8XUe3sz6DHRszd/qdZ/jAUOSdaAOiZu7iRbnjQlflFsmeHCKss25Y4hJcm01BfxK0bJLxLUBU7LKYF9G0rSiDxvM75lCisQbzpBFr0H/LCduHWEIUd2Z1++qP5xUpGDerWuURRxn092yhuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzamJLkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CF3C4CEE3;
	Thu, 24 Apr 2025 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530785;
	bh=bv0bvNTCZtZeJv0I9P2+KZpVeKWVEQnVgrtVJoNm2zU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UzamJLknM1QjU1WOvTWXf35fc0h3ZXOLvy1gMhPbjqGuczJaY+ldyM7d/1L2rH6c9
	 cUL/m5P4JyOQEi8jFepkWBpT72FBVjQAi35R0QB15203zCdp0aabiYhxZGB3uLJeei
	 OEgEiTjs/HDHxdbq+9vHdMCL8PFJk1vn/9yfYa7kVqn0bCcI9V8JM1ElmE2d3coZCD
	 PEDe9ehEq2DfC1CDjMzX60xtZ7LQsM9j3SrcFYvQ9pzFfajxKuYZMUKMiFaizj3kFB
	 LM1ClqIpdc0vKek8VZHlhRxTYxkxnQ96u7dYWoOYDbwwMEE+9WWbQ8VjUK1e7ei1PL
	 krsqgrfPaFzzQ==
Date: Thu, 24 Apr 2025 14:39:44 -0700
Subject: [PATCH 4/5] fuse2fs: make other logging consistent
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064527.1160047.12420605972373641844.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
References: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make all the other advisory messages have a consistent format.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e3e747dec33fd9..9fd35d14e10556 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -89,6 +89,12 @@ static ext2_filsys global_fs; /* Try not to use this directly */
 		break; \
 	}
 
+#define log_printf(fuse2fs, format, ...) \
+	do { \
+		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
+		fflush(stdout); \
+	} while (0)
+
 #define err_printf(fuse2fs, format, ...) \
 	do { \
 		fprintf(stderr, "FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
@@ -3830,7 +3836,7 @@ int main(int argc, char *argv[])
 	if (fctx.norecovery)
 		fctx.ro = 1;
 	if (fctx.ro)
-		printf("%s", _("Mounting read-only.\n"));
+		log_printf(&fctx, "%s\n", _("Mounting read-only."));
 
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -3854,8 +3860,8 @@ int main(int argc, char *argv[])
 
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
-		printf(_("%s: Allowing users to allocate all blocks. "
-		       "This is dangerous!\n"), fctx.device);
+		log_printf(&fctx, "%s\n",
+ _("Allowing users to allocate all blocks. This is dangerous!"));
 		fctx.alloc_all_blocks = 1;
 	}
 
@@ -3879,11 +3885,10 @@ int main(int argc, char *argv[])
 
 	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
 		if (fctx.norecovery) {
-			printf(_("%s: mounting read-only without "
-				 "recovering journal\n"),
-			       fctx.device);
+			log_printf(&fctx, "%s\n",
+ _("Mounting read-only without recovering journal."));
 		} else if (!fctx.ro) {
-			printf(_("%s: recovering journal\n"), fctx.device);
+			log_printf(&fctx, "%s\n", _("Recovering journal."));
 			err = ext2fs_run_ext3_journal(&global_fs);
 			if (err) {
 				err_printf(&fctx, "%s.\n", error_message(err));
@@ -3902,8 +3907,8 @@ int main(int argc, char *argv[])
 
 	if (!fctx.ro) {
 		if (ext2fs_has_feature_journal(global_fs->super))
-			printf(_("%s: Writing to the journal is not supported.\n"),
-			       fctx.device);
+			log_printf(&fctx, "%s\n",
+ _("Writing to the journal is not supported."));
 		err = ext2fs_read_inode_bitmap(global_fs);
 		if (err) {
 			translate_error(global_fs, 0, err);


