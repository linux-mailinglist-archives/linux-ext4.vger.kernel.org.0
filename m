Return-Path: <linux-ext4+bounces-8113-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE84ABFFE6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA9E3ADA2C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E0239E87;
	Wed, 21 May 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXlAmZEa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E125239581
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867429; cv=none; b=CvB3pAevZpurYvViFTe56Z1tf5P941jjgOVwWrqkEFhEe3U25jzJwuAOU7q018fvPxAVQ7S9XPxvhQEV3urjz6SPUQ/JUVmR0822HAld6ARcVQzHlSvqRap5/YTvbGNCfyUsFKTiA5eWCET7imYr0XWeowMiTBqciRWFyPzbPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867429; c=relaxed/simple;
	bh=3ZwoOl6axz7YOYIIybBBFsE9IjolVHMa/53NmwcZtz0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exNRHZ0yzOYqlQLz7inu7yJV7ZGtFCom4GMo7D0hraGKDNLhZV+aP6TkN6kY14FhuxWYzLs++2jfFyXMY1L8EPMj/1blNr6l5Nj1ZqlzD2UYoYuqIgqiP2jAqzr+2e7dw72rS3h5jOaA/b24nAcB45eg9bHSzvIDicTtC4Kam1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXlAmZEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C4FC4CEEA;
	Wed, 21 May 2025 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867429;
	bh=3ZwoOl6axz7YOYIIybBBFsE9IjolVHMa/53NmwcZtz0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mXlAmZEaKhmG5vte1iiILCiU+xe9YgFMIaO2hd4T0cMHaOPIpcqxvgsK4SHZ7HZZf
	 7fGh4swg47IXQpz+JT1Ayl0japEzj7qkCdDawAEFN1coWH325evNzZ93ubGCqab6WW
	 jri/ZAN6+tesnhrFchlv0E/ByexocidyGSWyL29moKohatAajAJSAbhBFlWo+rWWbQ
	 48DMYpIYcu0Cf+4uXNAwVYyfA1As7fvfjqhw0JOzbkMo81X4S/AJH9+PjLMNSOAWyc
	 7oxWA4TY674VDbbVws1xzf2nHXLGKbEJ0pocZQetVQc384cIb1IOl4Fm5R+P6rIXQT
	 B9QXTG1pErqkg==
Date: Wed, 21 May 2025 15:43:48 -0700
Subject: [PATCH 2/7] fuse2fs: implement dir seeking
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678435.1385038.5869506710366055752.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
References: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
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
index de5cfa3d776127..7ffe8a7e5dd4c0 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3105,6 +3105,11 @@ struct readdir_iter {
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
@@ -3148,9 +3153,15 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -3163,7 +3174,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 
 static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      void *buf, fuse_fill_dir_t fill_func,
-		      off_t offset EXT2FS_ATTR((unused)),
+		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
@@ -3175,13 +3186,18 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
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


