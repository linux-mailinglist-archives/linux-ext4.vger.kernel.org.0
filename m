Return-Path: <linux-ext4+bounces-11582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D41C3DA0D
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3A6334CCB8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0633E36E;
	Thu,  6 Nov 2025 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDWQ6RIU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E933F8C7
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468633; cv=none; b=EuamN2guNH9ciM1GvxC19tja1jrP/MFB4Dzc4PY0waSuHmAhEJxLpbpJ0oE6cJ4sthTTQ+A2paAqkINSuzkhME6mQ+Q8Agjs/UWMk/fa8rPsyu2Pmo9U7X0dHaCyOBnG6+cCZ61mEouxyCecPhLNvZ8UPNrk/YSeMI8B1RnFJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468633; c=relaxed/simple;
	bh=DrwXlSsDcxiMRTH2A/tjHl7rOcrojd9gatrmiKNDRsE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOqF00YrElWhx7zmZo+rk93JJU4zfU/6KcoNZeGPT13P9dYgU421uPDI7LmgC2rFL4Ue4xEReH46ZQw9EHcxAzAmbJZLtV4meN/Y8zb+oqCmEM6iyqsj9+iYac6Hec9YbdXt023HZE26vJU86jBJ2krBpHswSAZiuXhGxeuoqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDWQ6RIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893FAC4CEFB;
	Thu,  6 Nov 2025 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468632;
	bh=DrwXlSsDcxiMRTH2A/tjHl7rOcrojd9gatrmiKNDRsE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eDWQ6RIUvD1xS+/5upMjyII7I8kceRDAjdbNwT5JY+hluWBL7erjSrF6fSWWTOK6S
	 q1y2tbYLpnV5i05wfSxGGmN/oYLugmsfd3mtSxNZwguST5/+th9IXlECy2x0cKteb8
	 dGOhvKTmbVGcxTqVM5UcTF1+b4O84r9OMtaVNCyHN9Li5Y0HuOsmSoSmWaSIiCZWxg
	 2xJ94BhFNIqy7Jag+YSDFx17nTkvnBKRdsk1sMMajOB0VgR0ShZmI6ETXb03kJig4a
	 niX/gpgmp3yT2sQBwaQZXSC/f/tRBcjvPnLSyj9wSKmzqeuAa6TPI44ECULKnvVFb+
	 yrvLBCxRrMCJA==
Date: Thu, 06 Nov 2025 14:37:11 -0800
Subject: [PATCH 4/9] fuse2fs: consolidate file handle checking in op_ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794236.2862990.7332845914069269587.stgit@frogsfrogsfrogs>
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

Reduce code size by checking the file handle in op_ioctl dispatch
instead of every single ioctl implementation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 07bb4cdb889c17..171eff246e272c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4216,7 +4216,6 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4236,7 +4235,6 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 flags = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4267,7 +4265,6 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	errcode_t err;
 	struct ext2_inode_large inode;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4287,7 +4284,6 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	__u32 generation = *(__u32 *)data;
 	struct fuse_context *ctxt = fuse_get_context();
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4341,7 +4337,6 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4414,7 +4409,6 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
-	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4557,6 +4551,7 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+	FUSE2FS_CHECK_HANDLE(ff, fh);
 	pthread_mutex_lock(&ff->bfl);
 	switch ((unsigned long) cmd) {
 #ifdef SUPPORT_I_FLAGS


