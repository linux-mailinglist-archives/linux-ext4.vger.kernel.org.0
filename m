Return-Path: <linux-ext4+bounces-11580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CEC3DA07
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392584E2984
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6A3396FD;
	Thu,  6 Nov 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ4yrs40"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843B33858F
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468600; cv=none; b=dzkhQEsBJP7g/dIi7/DhMvFlct5qfR27YVBdh2GuxYtb7CtV8uw6sdyRMWgrRDbOAdPXv82kIi9TDOYdVOITFtvUqKFHsuE0E59GsANTQFB4V45d5kjavz1bY7YoR+F+ibhTgjAMoTRfJ3HRNHfTbTA3UWD93bXT0OdlSEjG4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468600; c=relaxed/simple;
	bh=thxkPBnaTPW5yPMQNL91mHwbnnhvMiVRsSrR+uaFQ+8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izN1wAUoOp9O6+/lBKjDmppmPB9YoqoMXf1xKYj2SVWhUfHFBGqinfljjFoT5G/On+Z8Om63Ke+Uzv65MMiKaqvkdzLverrFS73ibNMgbCoCkSns57EIW3KWdVktz05pBcbdrkdJ/c07KYkkNyB+i9vWKVmVNV0GCO0QMwZQKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ4yrs40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D02C4CEFB;
	Thu,  6 Nov 2025 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468600;
	bh=thxkPBnaTPW5yPMQNL91mHwbnnhvMiVRsSrR+uaFQ+8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TQ4yrs404nA7I3Ly6OaC1/DKijhrQGzqJHcITlc0SJ+AOQZ6hZzbEOd5pZeVASbMv
	 Wld0ljClllLmdPpwPwkwY2QBHFcBllsvkyROUXZD/ycqmfPsmq3U1PFKmNUH+GtOj0
	 rnGkJxwd3e/ZhCKjQVR72GEPFRZe3sqqFNV22+uSmjrEK44+H/IRBfM6VjIgoCw4ef
	 2jwyIkONySLjvGVcqCSS/6mG3r3+xdP4r+NSucRiUMKSMoKNE3jTvoQo95Uh2SkHW8
	 vSltQhpTvz4Rtmp2ICly9/6ia1lzUoW1yKjbvFYetBQsFKf5BZP1xKgxXEV3HnSlti
	 nq7haD0tXueAA==
Date: Thu, 06 Nov 2025 14:36:39 -0800
Subject: [PATCH 2/9] fuse2fs: rework checking file handles
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794200.2862990.4416314571411875983.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
References: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
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
index e973f75736a245..da37c095c7a304 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -248,9 +248,16 @@ struct fuse2fs {
 #endif
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
@@ -3153,8 +3160,8 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
 	pthread_mutex_lock(&ff->bfl);
@@ -3210,8 +3217,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
 	pthread_mutex_lock(&ff->bfl);
@@ -3280,8 +3287,8 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 
@@ -3314,8 +3321,8 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	/* For now, flush everything, even if it's slow */
 	pthread_mutex_lock(&ff->bfl);
@@ -3856,8 +3863,8 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	i.fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(i.fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
 	pthread_mutex_lock(&ff->bfl);
@@ -4052,8 +4059,8 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
 	pthread_mutex_lock(&ff->bfl);
@@ -4104,8 +4111,8 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
 	ret = stat_inode(fs, fh->ino, statbuf);
@@ -4209,7 +4216,7 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4229,7 +4236,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 flags = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4260,7 +4267,7 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4280,7 +4287,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 generation = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4334,7 +4341,7 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4407,7 +4414,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4637,8 +4644,8 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	int flags;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	start = FUSE2FS_B_TO_FSBT(ff, offset);
 	end = FUSE2FS_B_TO_FSBT(ff, offset + len - 1);
 	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
@@ -4771,8 +4778,8 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	char *buf = NULL;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	fs = ff->fs;
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: offset=%jd len=%jd\n", __func__,
 		   (intmax_t) offset, (intmax_t) len);
 


