Return-Path: <linux-ext4+bounces-11568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADAC3D9DA
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FC63A9A58
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C730DED7;
	Thu,  6 Nov 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsH6c5Z8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E833074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468409; cv=none; b=g2VIFw3UNG1EVmMZz+P3SFKgQcAPCpkd1OhCvTW4fYRNIZs2B11ojZtwdMBu+OEfn8K2W2QQDw9XfsvDCj88MsX4xNlkOHsMV+J2oalYB5uiulOOtKTpRQbZL6KVXPS8okWcTB7J8W93tyushmpL9hR3cDWDe2VLfbS15Id0b0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468409; c=relaxed/simple;
	bh=9rdqShHP/dlJicAqtmK9EanUObMRQSG5YpJVYvxgsd4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMR8wamCIfJKB2mqgMQ54VftSo5jY/D+2GdF+CWqysf8kdYiSD7T29l4rX4YTbsgz89u3Xg7iyEkrCX9h2daLnEoud9CSF6T7w9yzRtJrPJcd70PtqtpZfL6h5Civ44X7IO8bQwAfke4KVPVDmtlW0QOCIORh7iiPNLH2nJypG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsH6c5Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE96CC4CEFB;
	Thu,  6 Nov 2025 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468409;
	bh=9rdqShHP/dlJicAqtmK9EanUObMRQSG5YpJVYvxgsd4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OsH6c5Z8VXXne3D24x+kR+dtSXIEXrS2AUi52ZOT9Xv6870+aGv5dRVS+5Ye8rmAg
	 TDtcsH+ZdnPaBHj+PQFDh6BTk6Dv0Ox4Dcuitp1oqp0KJEfPnjtdcZx3otU9otDFUy
	 oWQUlAcyXg9uByyRSC1ErdNcSZdN7/GCzMKPR+GSlfpsZSjR+Xe2LLg8/50IxRAqZk
	 172nc+oSLH2TMZYzz13N2MYCwW6UdG1nlmkss8QDpOY8sx2xOP5W7MlSPknwcQxKwg
	 FWzONg/3KqutfFufcCEUKO86INr0LJ4h2Qt9HuGnLc6IqBSb111ZJRFX7OKbA11QUd
	 R1JS42MjMUe4g==
Date: Thu, 06 Nov 2025 14:33:28 -0800
Subject: [PATCH 09/19] fuse2fs: implement dir seeking
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793791.2862242.4687973298096620781.stgit@frogsfrogsfrogs>
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

Report (fake) directory offsets to readdir so that libfuse can send
smaller datasets to the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5e0a1f1fd58be4..1f52d7e4e37713 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3441,6 +3441,11 @@ struct readdir_iter {
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
@@ -3484,9 +3489,15 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -3499,7 +3510,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 
 static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      void *buf, fuse_fill_dir_t fill_func,
-		      off_t offset EXT2FS_ATTR((unused)),
+		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
@@ -3511,13 +3522,18 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
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


