Return-Path: <linux-ext4+bounces-10083-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABCB588AD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC281B2391F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50952DAFD2;
	Mon, 15 Sep 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enBkaRch"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CFB5C96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980775; cv=none; b=rLqOrthHKQpFBVhrhpemDwnG3mzZbgW0ANj0YS7q1yxOBuyCxuwmoKUZ+h+UCI/gR4CO+xBDKl3FHxpaQCO0PKO4V97U1eOB/n7S7yB9VTtfM5tLmH6KSxKwVmYNOWqW+CehPFNP1LRWBRvcMRqXolYOFaWkMPpcHFn0yZkP6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980775; c=relaxed/simple;
	bh=AtLSGFj4catR6aWiHiKfFmYRyulpRcnEdbd9ELHxtJs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2/s9SzN9Rb5KhxXXD0tTYeXUemUHZ6yv7en8KMM2kQiuMpGCYhzaezPMBXWVtETTAdREFkDr+aHIWF71PliDpWzaqCYbv81Skf3NmSfI3vw1Z7Bvs4hozb0/ZyutejsTsrYLH8HbwvKB2KhoKKymBex+vmkhCNXCMXg7L3FnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enBkaRch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BA8C4CEF1;
	Mon, 15 Sep 2025 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980775;
	bh=AtLSGFj4catR6aWiHiKfFmYRyulpRcnEdbd9ELHxtJs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=enBkaRch2vrdhBPrWLADNFjejvsf8DLEB6cfoVddPVEuRJrimrnwXAC7g5YMX2a83
	 DN7apkJB1Gc5pu/j/IZ2jC/EUqZuygcllYLXd7XeYSyIOOPgJx3LqwnM6A/PllMCka
	 UIl1lM9aqRa8SYkrX7yuWGTbIX51oi5A2xTtHVwzyrlNdlx2AkaMja0HObb7VmNZ1j
	 N3Qh0YLcOfR9bEZFE63kudSZ0wsiyem7XXrvSoVQVS23LupQpYMOPNwiSJH3kUQuKT
	 amAQTdQIWuG2bOC324Lz9jWuXRd1sU/yDRlHGPCIetjUx0WczJPJ9nEctDr4QCDhCc
	 KwJG3Sqt4oLXA==
Date: Mon, 15 Sep 2025 16:59:34 -0700
Subject: [PATCH 2/9] fuse2fs: rework checking file handles
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064131.349283.6923537020395101120.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
References: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We only use FUSE2FS_CHECK_MAGIC for one thing -- to check the magic
number of file handles.  Make the whole macro more specific to file
handles, and move it to the top of each function so that we don't take
locks or any other silly stuff like that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 462ec8558567ee..178d0fd6e20263 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -242,9 +242,16 @@ struct fuse2fs {
 	char *lockfile;
 };
 
-#define FUSE2FS_CHECK_MAGIC(fs, ptr, num) do {if ((ptr)->magic != (num)) \
-	return translate_error((fs), 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
-} while (0)
+#define FUSE2FS_CHECK_HANDLE(ff, fh) \
+	do { \
+		if ((fh) == NULL || (fh)->magic != FUSE2FS_FILE_MAGIC) { \
+			fprintf(stderr, \
+				"FUSE2FS: Corrupt in-memory file handle at %s:%d!\n", \
+				__func__, __LINE__); \
+			fflush(stderr); \
+			return -EUCLEAN; \
+		} \
+	} while (0)
 
 #define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
 	do { \
@@ -2881,8 +2888,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
 	pthread_mutex_lock(&ff->bfl);
@@ -2938,8 +2945,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
 	pthread_mutex_lock(&ff->bfl);
@@ -3008,8 +3015,8 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 
@@ -3042,8 +3049,8 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	/* For now, flush everything, even if it's slow */
 	pthread_mutex_lock(&ff->bfl);
@@ -3584,8 +3591,8 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	i.fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(i.fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
 	pthread_mutex_lock(&ff->bfl);
@@ -3780,8 +3787,8 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
 	pthread_mutex_lock(&ff->bfl);
@@ -3832,8 +3839,8 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 	ret = stat_inode(fs, fh->ino, statbuf);
@@ -3937,7 +3944,7 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -3957,7 +3964,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 flags = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -3988,7 +3995,7 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4008,7 +4015,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 generation = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4062,7 +4069,7 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4135,7 +4142,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4365,8 +4372,8 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	int flags;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
 	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
@@ -4499,8 +4506,8 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	char *buf = NULL;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
 		   (intmax_t) offset, (intmax_t) len);
 


