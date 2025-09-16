Return-Path: <linux-ext4+bounces-10085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD584B588B2
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A4F3A2F8E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D661C4A2D;
	Tue, 16 Sep 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaeZK18k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B96184524
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980806; cv=none; b=KF88yHUtgEjVIhWNRHBnJh5IJM7jsuuQoByCu+67A8dQlGZR4hXn97cJosCiZvIIhICTMyQuffFHEOLsWZA4uJ23PWYVBmdR9Q1aE+Btag9PXlTkJV+/DWu6cvNj6H6xp/XWRnVhgD3oQSQgBiUvZlkpCdYgyd74ByYPgqktJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980806; c=relaxed/simple;
	bh=rvEJEfunXyPx3zvy+GJ2eXZTEt+pAUQwrkBGyl2VE9g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwHA6/vie4pTSxDloDxMKMyEO9mCpwMS0Xs/UcgfuRs+GpB9d/HgtNtQyVHLtqtHQZdcme3QE0WZRATj4h7D9SWzA0v4TLA2QuF4Hn6sBIzF/zUm7dSSF+yVOPFAyhLniB9j6nEU+QIUeQjF8z/40a0JMhNK4KO8roHXG7IWxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaeZK18k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31205C4CEF5;
	Tue, 16 Sep 2025 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980806;
	bh=rvEJEfunXyPx3zvy+GJ2eXZTEt+pAUQwrkBGyl2VE9g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gaeZK18kwQU+6pbbaRklntIBfbAGZIy/nj5OnKjiBqnude7zV0wqGV29QXlk57MG6
	 HFqcFgjCitKdOgoICR2ffhMrRkjIqWCNZOmw1NHG58BjiA10zeBstJnfo53qqCn0Tn
	 zrY4cqiLiHZwVQcFy7eQtCrBUvyKbnlUr8B4XtnUD4YliwrPEVLzPRmyJg7zZNZGb6
	 6EfTitfRLhWJTRO1zW8vlCddeLhMb0CeUcZBTlbfid5ruEB4CdZgYsOK2EwG5yPmv1
	 19I8Z98/9Inya9ZFy+xe6ZIKkh70q/Rzj30Fm2rpZzBmLqmBm3CMvJWXwISIyNYmB3
	 RXHFpumEqSnfw==
Date: Mon, 15 Sep 2025 17:00:05 -0700
Subject: [PATCH 4/9] fuse2fs: consolidate file handle checking in op_ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064167.349283.10895404417682641266.stgit@frogsfrogsfrogs>
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

Reduce code size by checking the file handle in op_ioctl dispatch
instead of every single ioctl implementation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5a33e161ae8f9d..f264adbb3fe159 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3944,7 +3944,6 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -3964,7 +3963,6 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 flags = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -3995,7 +3993,6 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4015,7 +4012,6 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 generation = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4069,7 +4065,6 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4142,7 +4137,6 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4285,6 +4279,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	pthread_mutex_lock(&ff->bfl);
 	switch ((unsigned long) cmd) {
 #ifdef SUPPORT_I_FLAGS


