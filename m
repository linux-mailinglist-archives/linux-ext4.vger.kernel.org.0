Return-Path: <linux-ext4+bounces-11583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F2C3DA13
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6506B3A92DD
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4730102C;
	Thu,  6 Nov 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5l8BdFQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FF2FD7B9
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468649; cv=none; b=W6hlANc0r80bgC4HcARUibcC18tLVKj1bjPcl6UWJmslaxiiv5Das+nct8nPDk5YptHLpbnSq5mlMECBtwwaF+TRI937sYamhEsgmOro6soZZ0D3iBCErwgp+FlS5qAkZjwuu0VDY916Xq9+0rOFYc4VMVBjQfz3wh7qZCR43X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468649; c=relaxed/simple;
	bh=fciIgnRkaz56IRhhWh3wwwZpSGFCYWmgOqLBpixJ3Yk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd1/KMqE0HWxjtwQTf/iYlO0gCbu2ag1S5rnDJfBoD3SqIemCymD7y78VpqsO5riqq3t+Hd6htlggbc2ELZQXpUXufZyZgX0v90qGvbfNm328PdgDw/N2xU7rBAvbKSKB/orSUcpXZlIUnkjVb1YOltvZb7GfnjuftBwQ24cRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5l8BdFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8337DC113D0;
	Thu,  6 Nov 2025 22:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468648;
	bh=fciIgnRkaz56IRhhWh3wwwZpSGFCYWmgOqLBpixJ3Yk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F5l8BdFQ8x3kWnyPz+iaOSzF39EDqfFwUpihrEEIxledYNCnJdC691JzgNqqiMZo2
	 ysqMb4hi5P9iJPn4LWNFnl9CzXM869Ksa1uNhn64nqzQ9psCd6jL2l3yeUdBpXBCsS
	 Pugoge0O25tOXj8SjYu3PMiyIvvurKAZkoYRC+Vtt/h+tSzipYoSX0TGAcDlNKm6j0
	 i/cMYq0f7a699rwuXij9/W1NHU/NDis1eVL/XixktdOcni4oWnREO0CebyA24sO5Qb
	 Xpj4Hg/Xc0QSQzCTkEs1HWRt0nnOgQrxKfnoIFwKZ2vath97L2hSoTlO3xXvW4a1Fz
	 17VlhQ0PXwZbg==
Date: Thu, 06 Nov 2025 14:37:27 -0800
Subject: [PATCH 5/9] fuse2fs: move fs assignment closer to locking the bfl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794254.2862990.15804158692251186166.stgit@frogsfrogsfrogs>
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

Move the "fs = ff->fs" statements closer to where we take the BFL so
that we can refactor them easily in the next patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 171eff246e272c..63c1227faa0d7a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1338,8 +1338,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
@@ -1596,7 +1596,6 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o dev=0x%x\n", __func__, path, mode,
 		   (unsigned int)dev);
 	temp_path = strdup(path);
@@ -1613,6 +1612,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
@@ -1728,7 +1728,6 @@ static int op_mkdir(const char *path, mode_t mode)
 	int parent_sgid;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
 	temp_path = strdup(path);
 	if (!temp_path) {
@@ -1744,6 +1743,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -2191,7 +2191,6 @@ static int op_symlink(const char *src, const char *dest)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: symlink %s to %s\n", __func__, src, dest);
 	temp_path = strdup(dest);
 	if (!temp_path) {
@@ -2207,6 +2206,7 @@ static int op_symlink(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -2371,8 +2371,8 @@ static int op_rename(const char *from, const char *to
 #endif
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
@@ -2605,7 +2605,6 @@ static int op_link(const char *src, const char *dest)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: src=%s dest=%s\n", __func__, src, dest);
 	temp_path = strdup(dest);
 	if (!temp_path) {
@@ -2621,6 +2620,7 @@ static int op_link(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
@@ -3161,9 +3161,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
@@ -3218,9 +3218,9 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -3288,8 +3288,8 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 
 	if ((fp->flags & O_SYNC) &&
@@ -3322,10 +3322,10 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = ff->fs;
+	pthread_mutex_lock(&ff->bfl);
 	/* For now, flush everything, even if it's slow */
-	pthread_mutex_lock(&ff->bfl);
 	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -3864,9 +3864,9 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	i.fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
+	i.fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	i.buf = buf;
 	i.func = fill_func;
@@ -3896,8 +3896,8 @@ static int op_access(const char *path, int mask)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
@@ -3929,7 +3929,6 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
 	temp_path = strdup(path);
 	if (!temp_path) {
@@ -3945,6 +3944,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -4060,9 +4060,9 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -4112,8 +4112,8 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	ret = stat_inode(fs, fh->ino, statbuf);
 	pthread_mutex_unlock(&ff->bfl);


