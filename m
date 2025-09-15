Return-Path: <linux-ext4+bounces-10068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F76B587AE
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 455314E256B
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9D2D47F2;
	Mon, 15 Sep 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/hjjXh2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84A2C11FE
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976114; cv=none; b=IeL8fmz8bChC+IbKb0Pwtf9Hg37Rj7cDLouGuTbL3LkfhDd8AVAb4KEUAi/Tt2gHLrYDGa8sW02zx2G0RcmpFgCN9HfRJoDk8hF4isDF9+ogHbaMT0aH7tN4M1DGl2w6UYf3hBZErDqmoFle27hWLnxzRkCOvFJaatdh5Le/nUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976114; c=relaxed/simple;
	bh=dMNKKN1NRDLCjY/GgubKkHw3k6W6o3AUsdgSsJeSQos=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vmd4WIsfcb0puMaNZkia36pU2zYVwzUNqAFg/cmezI/zCsV5DFapFHcuCrkZjZAuzKZ/v/R8+SdF9t1MY883U3U4U3k1zudWcF/b12yJuT6gfRTgzvMbhV0r8J/WQw3/edmEXOyCTOujuINcAHpJ6YPLikQ9vnF9RgfKqcn47+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/hjjXh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F07C4CEF1;
	Mon, 15 Sep 2025 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976113;
	bh=dMNKKN1NRDLCjY/GgubKkHw3k6W6o3AUsdgSsJeSQos=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=K/hjjXh2wK/n4YQpP7kN1Vmn5UGHX/fV3tsARRQToYbO0UpxulMoWFhxFf8XJ1h8R
	 FdZHPtNIIAfSAc4Juj1PBUqLWyDIkqvBnzNqlT+2ZIG+7fhIY/2KgoPX4NFo2Qg4vE
	 24EhZLf12zGkGXUD8WD0CiJGzzq/Flcfs20qePLoXjTnHwTeGEbGbWloRDjrdKWkOM
	 zpTu7ih0eAXb19yiAkDyxTS97NcV1yxsfXPskXaAa861P0NJjCtz6Z45QPmkaVO1zj
	 W/GPXyPOgW7DufWrKKvZUJ4a0YinC9gChgijGGG7IfdbEeAON900s/OTgYGNTjm1ZX
	 fnRDmd600n9fA==
Date: Mon, 15 Sep 2025 15:41:53 -0700
Subject: [PATCH 04/11] fuse2fs: implement dir seeking
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570085.246189.2342649019341341025.stgit@frogsfrogsfrogs>
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

Report (fake) directory offsets to readdir so that libfuse can send
smaller datasets to the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c756d9789979c7..efcf10fe731f3e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3361,6 +3361,11 @@ struct readdir_iter {
 	void *buf;
 	ext2_filsys fs;
 	fuse_fill_dir_t func;
+
+	struct fuse2fs *ff;
+	unsigned int nr;
+	off_t startpos;
+	off_t dirpos;
 };
 
 static inline mode_t dirent_fmode(ext2_filsys fs,
@@ -3404,9 +3409,15 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	};
 	int ret;
 
+	i->dirpos++;
+	if (i->startpos >= i->dirpos)
+		return 0;
+
+	dbg_printf(i->ff, "READDIR %u dirpos %llu\n", i->nr++,
+			(unsigned long long)i->dirpos);
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
-	ret = i->func(i->buf, namebuf, &stat, 0
+	ret = i->func(i->buf, namebuf, &stat, i->dirpos
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, 0
 #endif
@@ -3419,7 +3430,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 
 static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      void *buf, fuse_fill_dir_t fill_func,
-		      off_t offset EXT2FS_ATTR((unused)),
+		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
@@ -3431,13 +3442,18 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	struct fuse2fs_file_handle *fh =
 		(struct fuse2fs_file_handle *)(uintptr_t)fp->fh;
 	errcode_t err;
-	struct readdir_iter i;
+	struct readdir_iter i = {
+		.ff = ff,
+		.dirpos = 0,
+		.startpos = offset,
+	};
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	i.fs = ff->fs;
 	FUSE2FS_CHECK_MAGIC(i.fs, fh, FUSE2FS_FILE_MAGIC);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
+			(unsigned long long)offset);
 	pthread_mutex_lock(&ff->bfl);
 	i.buf = buf;
 	i.func = fill_func;


