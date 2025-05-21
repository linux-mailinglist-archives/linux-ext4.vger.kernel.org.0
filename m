Return-Path: <linux-ext4+bounces-8082-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBCABFF9D
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07604E36C5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D1239E85;
	Wed, 21 May 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGsdYaFu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC2230269
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866943; cv=none; b=u9DYL+CvlXM7jtikptGkglyj/lTSVGAgE6I7qIyajDqW4SBBwwe/TK4h7c37kFu50pBU4+VadgZOh6Ad8fFEwM2qGSkdNazjH1mUWsnMJGrVQpDNs2FASw2ePZ9TZmjWp/3/Hwnendpx/KDkh9ej+5gOjkfAmfy/RhXTmfmqRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866943; c=relaxed/simple;
	bh=ppmZJoNG8cKYy3EAFUrxQTbgU26DSCPO9TMEZ9NXxU8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3VVN+/yZfhZbI40NYiO7uKsu32oek7xxrQ5RmD98n5m/sFtHDszTDIXDwVsEg9JK+aMtq9fxWmcwFdlyU8DIW9m6w4FNPzaX4wLGGBe1IQ6fJ/acUaOVpiwUTS3Tcm06s72mTVS4RXEqiA6J8XheVEIXCfMPpRaPOAASnHDSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGsdYaFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DCCC4CEE4;
	Wed, 21 May 2025 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866942;
	bh=ppmZJoNG8cKYy3EAFUrxQTbgU26DSCPO9TMEZ9NXxU8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YGsdYaFukSbPIGIqLGhye3CAbsVQm+sAhYnU000A3rWj3Lxm3JTqoQwk+nGEFeNxV
	 ux/U26LsxyclTkKd4SpAJoTrHBPY/KJHhpdeBvCxeQuoTUlh8dTVIg1o5hERkFnmhs
	 yDEuDtMp+P2e4ahdfPlRy0xL9FWEI8BGK54aUKpi2/QVX7L6xy9Uxi++U72j0n2KtW
	 AfUVKu3TAIqNWSuRyx8FhvO9zWcWE53RKXyhxs7Nw1RoH5BQMs06SVSfw1jBEyZq8J
	 x47yxDBFbSV5p3ZG+S7F3aRnxvUMwea/kMOd2IwRwnURD5RjLh6H3WhaGhEk4ABPUY
	 cDlqKsWHCijlg==
Date: Wed, 21 May 2025 15:35:41 -0700
Subject: [PATCH 03/29] fuse2fs: clean up error messages
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677603.1383760.817536477752866097.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Instead of horridly line-wrapping multi-line messages that are printed
during mounting, let's just expand them to be one source code line per
printed line.  This will make it a lot easier for someone who sees the
these errors to grep the source code to find out where they came from.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 58c80c5c9a1ea2..8d52e00e3ece48 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4023,8 +4023,7 @@ int main(int argc, char *argv[])
 	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
 		if (fctx.norecovery) {
 			log_printf(&fctx, "%s\n",
-				   _("Mounting read-only without "
-				     "recovering journal."));
+ _("Mounting read-only without recovering journal."));
 			fctx.ro = 1;
 			global_fs->flags &= ~EXT2_FLAG_RW;
 		} else {
@@ -4043,13 +4042,10 @@ int main(int argc, char *argv[])
 
 	if (global_fs->flags & EXT2_FLAG_RW) {
 		if (ext2fs_has_feature_journal(global_fs->super))
-			log_printf(&fctx, "%s\n",
-				   _("Warning: fuse2fs does not support "
-				     "using the\n"
-				     "journal.  There may be file system "
-				     "corruption or data loss if\n"
-				     "the file system is not gracefully "
-				     "unmounted.\n"));
+			log_printf(&fctx, "%s",
+ _("Warning: fuse2fs does not support using the journal.\n"
+   "There may be file system corruption or data loss if\n"
+   "the file system is not gracefully unmounted.\n"));
 		err = ext2fs_read_inode_bitmap(global_fs);
 		if (err) {
 			translate_error(global_fs, 0, err);


