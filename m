Return-Path: <linux-ext4+bounces-11564-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9DC3D9CE
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E98E4E5408
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFA2FB0B7;
	Thu,  6 Nov 2025 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GovwIhOR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14E27FD5A
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468345; cv=none; b=jrmY4D4SWcqOlQ/x8hnS05FQ8gLOP7KZRzhGkqzBx2590qrrM60I+mRSmxPqYQUyKoOH6vFkVCODZv+4WRwitUWsKEZE/NFj3lMKJwZMv8ucEyqptmYG5hj3SHqp2aO3AhT+MnSp03zJhoVOMBefPrM+6P4yenY+LZvcKpc+eZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468345; c=relaxed/simple;
	bh=VFFCnwOWCB+wqY+gmLKXX7p/xS/i1F6CpIdU+8huYJY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTqwUkbiRT7WrOSvCVIzQcdj47sM3Qng7WUwWq2OjUw2iRB/f0HWPk8fx1fRnruGihACeOL0UU7XIaV5nuEsWzajIuepZy7jDe/Yj0Dg+vz7z1DfFDczhbzSz1X21m6RcLbQZkzmcBipAJINXV+91n1JpJLCWUOa8Q1def3vVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GovwIhOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F042BC4CEFB;
	Thu,  6 Nov 2025 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468345;
	bh=VFFCnwOWCB+wqY+gmLKXX7p/xS/i1F6CpIdU+8huYJY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GovwIhORzGpPDl3c8cVLyYaG1vjjV4k4zUPE/LaE+Ci4BD1sqBCLQCf7gVdVjOq2/
	 oXDfsLTwNSI5iLsaApeOFWkfdCt0IeITbrDGEMW2cBUdrLWMuDoV+7QZDzHsEURUJY
	 Wh0xgqsfFbcataX2sV/mJbUdFOIsoLOPK8bNIP3BKr3iHadhuEvNGUEzV2bah2Syrt
	 qgcN/jKEL8LYiaF90AWfm592s7/htOuGG0AX9e5XbEwAtRwd16A/Z0bhoxtLFCTNCk
	 z9JMlC+c81pn2cr2rio6oaU9avec0nSx/qaxNAs9/mp3wQeVCytcpnVo3iu9TGfw0x
	 FLMHTdm91ZSlg==
Date: Thu, 06 Nov 2025 14:32:24 -0800
Subject: [PATCH 05/19] libext2fs: always use ext2fs_mmp_get_mem to allocate
 fs->mmp_buf
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793718.2862242.11928656441926292537.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Always use our special allocator function to allocate the MMP buffer.
This will be useful in case we ever pass that buffer to ext2fs_mmp_write
on a filesystem that is opened with O_DIRECT.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 e2fsck/unix.c      |    2 +-
 lib/ext2fs/dupfs.c |    2 +-
 lib/ext2fs/mmp.c   |    6 +++---
 misc/dumpe2fs.c    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 7768f0ed7c4e3e..335ca37763e65f 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1230,7 +1230,7 @@ static errcode_t e2fsck_check_mmp(ext2_filsys fs, e2fsck_t ctx)
 
 	clear_problem_context(&pctx);
 	if (fs->mmp_buf == NULL) {
-		retval = ext2fs_get_mem(fs->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_buf);
 		if (retval)
 			goto check_error;
 	}
diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
index 0fd4e6c67afb5d..db3a812d8d1c0d 100644
--- a/lib/ext2fs/dupfs.c
+++ b/lib/ext2fs/dupfs.c
@@ -91,7 +91,7 @@ errcode_t ext2fs_dup_handle(ext2_filsys src, ext2_filsys *dest)
 			goto errout;
 	}
 	if (src->mmp_buf) {
-		retval = ext2fs_get_mem(src->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(src, &fs->mmp_buf);
 		if (retval)
 			goto errout;
 		memcpy(fs->mmp_buf, src->mmp_buf, src->blocksize);
diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index 41ef4e3e2aa6c5..e2823732e2b6a2 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -204,7 +204,7 @@ static errcode_t ext2fs_mmp_reset(ext2_filsys fs)
 	errcode_t retval = 0;
 
 	if (fs->mmp_buf == NULL) {
-		retval = ext2fs_get_mem(fs->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_buf);
 		if (retval)
 			goto out;
 	}
@@ -268,7 +268,7 @@ errcode_t ext2fs_mmp_init(ext2_filsys fs)
 		return EXT2_ET_INVALID_ARGUMENT;
 
 	if (fs->mmp_buf == NULL) {
-		retval = ext2fs_get_mem(fs->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_buf);
 		if (retval)
 			goto out;
 	}
@@ -306,7 +306,7 @@ errcode_t ext2fs_mmp_start(ext2_filsys fs)
 	errcode_t retval = 0;
 
 	if (fs->mmp_buf == NULL) {
-		retval = ext2fs_get_mem(fs->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_buf);
 		if (retval)
 			goto mmp_error;
 	}
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index b56d15d98caa47..1754fd4a999b9f 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -472,7 +472,7 @@ static void print_mmp_block(ext2_filsys fs)
 	errcode_t retval;
 
 	if (fs->mmp_buf == NULL) {
-		retval = ext2fs_get_mem(fs->blocksize, &fs->mmp_buf);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_buf);
 		if (retval) {
 			com_err(program_name, retval,
 				_("failed to alloc MMP buffer\n"));


