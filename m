Return-Path: <linux-ext4+bounces-10086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AEB588B7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C527A8A88
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDD229B36;
	Tue, 16 Sep 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIX/MDLz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702C242D9A
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980822; cv=none; b=MOS1OT4GzCmtNOUtN1Q6JN3q5ese87OCeZEIPqi5mJqclBs1maPxlUXcPHZLxVm5m0r2/NLT5Q7u+g3LQpPtTJ1KkGqP1014JemHAg472pSwh5j5ibdAz/mSMSybNfT8HY+ErXgPu9Q81n2fFFlCjR7P7M3MHYsWAoD6WWAEcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980822; c=relaxed/simple;
	bh=A5yi++igdDAHR0jGCy6i9uKt4V+nKbiuiYU4uBbxi7A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW7ALemPKjqv2xsS8D4HeByzSsn5AKgrZ8hLJDzcFCdu9Me9cw4XuhXoJ5IVL0T7+O4+IWLGokc9fj8Fw1EE/WQp5fpJzV4DnZSrQM99XCj+XmqKk2qyelTRT5zl2CY2gqych2WFbYon7rvB83IO4HStkmIKDWKB7e7Q5BsP6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIX/MDLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B1C4CEF1;
	Tue, 16 Sep 2025 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980821;
	bh=A5yi++igdDAHR0jGCy6i9uKt4V+nKbiuiYU4uBbxi7A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qIX/MDLzOCGU2LPtfrPwowVtDUnrTxKk08U14vC4yjmlTiPw8Olmj8NcLR1V4TC3x
	 CBGVekPF0DNl4uZuavFfTCjc9pYYcI8tdnSjZKDZo5siZGqiNlGh/hvOePxvzCytjY
	 TpwFUeUa6POP3eJjIsPQcZTGhSdUKmAQl+HVI1M7ZQNKWg7I3eS+dnvyD541zcdoZ4
	 L/oe+KY674vZDshgn44ZbCMVRemqD/NU1jSgrAilcqwd2che0xEgVK5ulx4RTK/bwb
	 OHBIU5uH4vxSmyolaFU+Um78aoe20CteL+FtnoKXHHpxNo0fYKSff5Rb8R3S7Ee6Sz
	 gtI+JyH1mU6nQ==
Date: Mon, 15 Sep 2025 17:00:21 -0700
Subject: [PATCH 5/9] fuse2fs: move fs assignment closer to locking the bfl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064185.349283.18417371352832461843.stgit@frogsfrogsfrogs>
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

Move the "fs = ff->fs" statements closer to where we take the BFL so
that we can refactor them easily in the next patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f264adbb3fe159..ff4dd8cc0a0eea 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1119,8 +1119,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
@@ -1377,7 +1377,6 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o dev=0x%x\n", __func__, path, mode,
 		   (unsigned int)dev);
 	temp_path = strdup(path);
@@ -1394,6 +1393,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
@@ -1509,7 +1509,6 @@ static int op_mkdir(const char *path, mode_t mode)
 	int parent_sgid;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
 	temp_path = strdup(path);
 	if (!temp_path) {
@@ -1525,6 +1524,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -1964,7 +1964,6 @@ static int op_symlink(const char *src, const char *dest)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: symlink %s to %s\n", __func__, src, dest);
 	temp_path = strdup(dest);
 	if (!temp_path) {
@@ -1980,6 +1979,7 @@ static int op_symlink(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -2109,8 +2109,8 @@ static int op_rename(const char *from, const char *to
 #endif
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
@@ -2338,7 +2338,6 @@ static int op_link(const char *src, const char *dest)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: src=%s dest=%s\n", __func__, src, dest);
 	temp_path = strdup(dest);
 	if (!temp_path) {
@@ -2354,6 +2353,7 @@ static int op_link(const char *src, const char *dest)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 2)) {
 		ret = -ENOSPC;
@@ -2889,9 +2889,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
@@ -2946,9 +2946,9 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d off=%jd len=%jd\n", __func__, fh->ino,
 		   (intmax_t) offset, (intmax_t) len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -3016,8 +3016,8 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 
 	if ((fp->flags & O_SYNC) &&
@@ -3050,10 +3050,10 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 
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
@@ -3592,9 +3592,9 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	i.fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d offset=%llu\n", __func__, fh->ino,
 			(unsigned long long)offset);
+	i.fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	i.buf = buf;
 	i.func = fill_func;
@@ -3624,8 +3624,8 @@ static int op_access(const char *path, int mask)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
 	if (err || ino == 0) {
@@ -3657,7 +3657,6 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
 	temp_path = strdup(path);
 	if (!temp_path) {
@@ -3673,6 +3672,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	a = *node_name;
 	*node_name = 0;
 
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
@@ -3788,9 +3788,9 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
 		   (intmax_t) len);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {
 		ret = -EROFS;
@@ -3840,8 +3840,8 @@ static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	FUSE2FS_CHECK_HANDLE(ff, fh);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	ret = stat_inode(fs, fh->ino, statbuf);
 	pthread_mutex_unlock(&ff->bfl);


