Return-Path: <linux-ext4+bounces-7489-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068FA9BA1D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2D176356
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08341BD9E3;
	Thu, 24 Apr 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6LlS1Mj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458524438B
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531194; cv=none; b=Phpp+Er9SaD7eBx3Xh43Tmj6+9WtJwrDf0TRW5KohShGCcn6ophdNVvMIhPMz19ymcjZuLXKvL6LdRiP7pB2/4zcPndQari1UULdCbMck5Gf9BtfY9oS9cSpgKhcWXXLz23FzLhmUHPX7L3/KIeFuvnfbXHpsbdIUp5GmmhfxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531194; c=relaxed/simple;
	bh=LnIoEOLXgxBamApu2McOdKYJnu/hz8ICtw4Vxz4rCJc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFioM4KB5v1UdN0HQZmu1uoDq5w37U/mJ4Sfmx8ioUUFSzKmM6p1jIZ67/C+pVk2tBvoSktjBoFESdeiI3zLMMawBiaMzvi6Ap4ZoT/KvjoOx9wIKLGSP9JLr0duEzXyVeeV8CS6LFzBgz3hQhG6c6EYWOjnorHs/XnUUhT6OXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6LlS1Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9CAC4CEE3;
	Thu, 24 Apr 2025 21:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531194;
	bh=LnIoEOLXgxBamApu2McOdKYJnu/hz8ICtw4Vxz4rCJc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e6LlS1MjHZAmXzaGDAEyNbc+7yw8iYwxmtMGVIv/yHidk2to7uVKZbmOQ1hWK2Ymd
	 jxdavi0Q7SrdSSXZTx2XrNoAuWQGMO4DNTg/rNJiV33kkxdWgH4i2P3dL6o5Y/kqpe
	 LvJZBO9a2yPub20Qk6WA++pzPqFsL6pad06+sDmFfykWOCXCUA9zDDB1kcMXesijjc
	 xZ7rEsZrvZKZnOmnIzSvtLxwblx5jK4M0QXLOMs/JHTDlF1ZAijCiu+HSXm070uVjx
	 RPjlhs57BjQZjHT11zEjMmoj84fuwEEfINmb70br8OOIO8aYtZfVcCsYWHhdZAtT+7
	 ZnpmFyb/y47gA==
Date: Thu, 24 Apr 2025 14:46:33 -0700
Subject: [PATCH 4/5] fuse2fs: allow use of direct io for disk access
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065581.1161238.969038742323698265.stgit@frogsfrogsfrogs>
In-Reply-To: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
References: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow users to ask for O_DIRECT for disk accesses so that block device
writes won't be throttled.  This should improve latency, but will put
a lot more pressure on the disk cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.1.in |    3 +++
 misc/fuse2fs.c    |    5 +++++
 2 files changed, 8 insertions(+)


diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 517c67ff719911..43678a1c1971c5 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -62,6 +62,9 @@ .SS "fuse2fs options:"
 Note that these options can still be overridden (e.g.
 .I nosuid
 ) later.
+.TP
+.BR -o direct
+Use O_DIRECT to access the block device.
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7f1e7556b9204e..6aac84a2b4340b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -158,6 +158,7 @@ struct fuse2fs {
 	int alloc_all_blocks;
 	int norecovery;
 	int kernel;
+	int directio;
 	unsigned long offset;
 	unsigned int next_generation;
 };
@@ -3776,6 +3777,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("noload",		norecovery,		1),
 	FUSE2FS_OPT("offset=%lu",	offset,			0),
 	FUSE2FS_OPT("kernel",		kernel,			1),
+	FUSE2FS_OPT("directio",		directio,		1),
 
 	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
@@ -3824,6 +3826,7 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o fuse2fs_debug       enable fuse2fs debugging\n"
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
+	"    -o directio            use O_DIRECT to read and write the disk\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -3929,6 +3932,8 @@ int main(int argc, char *argv[])
 	ret = 2;
 	char options[50];
 	sprintf(options, "offset=%lu", fctx.offset);
+	if (fctx.directio)
+		flags |= EXT2_FLAG_DIRECT_IO;
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
 	if (err) {


