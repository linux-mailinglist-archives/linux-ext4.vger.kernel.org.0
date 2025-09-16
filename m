Return-Path: <linux-ext4+bounces-10093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E2FB588C0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D34205D28
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AE45C0B;
	Tue, 16 Sep 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOFuk6wt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8072614
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980931; cv=none; b=mZy14vzDQQerkwc2sBWA8Wqolv/6hOPPYxOp0lpQ1tWCgYN49KOrjw4xAj+ij7KW4eWlxPt3ucwkP6rX8qilDBEVQywSbqi+pymXeqKnXIEuLmE8QHn0faCchi9+7jPrgENJlH957csr4PVSZYzlzBLvgF4Kg0he5skBplIcF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980931; c=relaxed/simple;
	bh=77p8XdfZ2IyHJM3QuCSHY5DEtPjlAq+noPdtMCZHTPk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUVyNL9N12iwEBeB23wwy37/iki/cnfsrQt/8P+L5kgvoMwykfFrz/x6+/e6FvHmxoj2qTldzTPps2yI/07G7Y7t3iORvB7VYA/HcImfrLv4T60q+m8RZGFAqEHSPjkL0pjdZ8tdvwMevFZOHKCDLlUizzdKMy+knOyV2x013Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOFuk6wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4991EC4CEF1;
	Tue, 16 Sep 2025 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980931;
	bh=77p8XdfZ2IyHJM3QuCSHY5DEtPjlAq+noPdtMCZHTPk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hOFuk6wtUwpz+BJkMsxaquFcIHi3K90kK3x5T5apZYxbS61lwuXrHoMxveQ08yIB9
	 lM9DtbPcDJXwazxIe3Qh14BB3oI/PUxKrFBhphIzM7vfELEXfOncnURKm9E+h2cioB
	 rIWIXPZEmwarguoIcuTVzTxU+9EESPhlpeJ0jkl+1Fo98tQEe6n6GMFxeB6D2zDooh
	 habOaW8hoehbQbuFYii4tIDyYgndSo791S93qBqYOJjZRdc02hnyGa/cl6CCtOO18I
	 OtuOwhpxd/JPIu4qNhCn41ASwhTVCdjRlVPZUA3h8Qth67Y79OrU/bEozCeh9WLoDq
	 VAG6nT0QtnJAA==
Date: Mon, 15 Sep 2025 17:02:10 -0700
Subject: [PATCH 3/3] fuse2fs: hoist unmount code from main
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064444.349669.1767392407737387794.stgit@frogsfrogsfrogs>
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

Hoist the unmount code into a separate function so that we can reduce
the complexity of main().  This also sets us up for unmounting the
filesystem from op_destroy, which we'll need for fuse2fs+iomap mode to
maintain the expected behavior that the block device is free when
umount(8) returns.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a66c0496e66dcf..23a1cd8d5d5d0a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -907,6 +907,25 @@ static void fuse2fs_release_lockfile(struct fuse2fs *ff)
 	free(ff->lockfile);
 }
 
+static void fuse2fs_unmount(struct fuse2fs *ff)
+{
+	errcode_t err;
+
+	if (!ff->fs)
+		return;
+
+	err = ext2fs_close(ff->fs);
+	if (err) {
+		err_printf(ff, "%s: %s\n", _("while closing fs"),
+			   error_message(err));
+		ext2fs_free(ff->fs);
+	}
+	ff->fs = NULL;
+
+	if (ff->lockfile)
+		fuse2fs_release_lockfile(ff);
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -5235,16 +5254,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
-	if (fctx.fs) {
-		err = ext2fs_close(fctx.fs);
-		if (err) {
-			com_err(argv[0], err, "while closing fs");
-			ext2fs_free(fctx.fs);
-		}
-		fctx.fs = NULL;
-	}
-	if (fctx.lockfile)
-		fuse2fs_release_lockfile(&fctx);
+	fuse2fs_unmount(&fctx);
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);


