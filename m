Return-Path: <linux-ext4+bounces-10902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88665BE4507
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEB3A9A90
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E17341AAE;
	Thu, 16 Oct 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4E7kgyA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD62E764B
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629345; cv=none; b=K56cnn8xbLbowAf+hqYUJWR+z52o6F3J1orPH1yXxAg29+VWacmIPTcbmTaHNDpY2k6aQsd5dIqbY7MV5LU1XUlHdWpt+d5fu9kQHD+14597hltiYw1QgpK/x3Ob0B5ScIvfU+6RvjImgdRAwzG/oi1PqvhRboM4nJbJAFYc++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629345; c=relaxed/simple;
	bh=Mj9wgRxMqqUT4w+00jq7daPCIcIm0OQrKH9Iavv1fds=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJBQV3ZEBetkxtY5S+Zx1ZOYAjmPlNc7IJjma8WcRpmz8qlYeeaHHdjxMe6yoTowgGa9bE60usZczvQwgdsQeMGBfJBm+WqiPV4i3nnkxJ3lI6WlgEOyUUk1kr3QRe9GMl5hfv69mRCpkLCBrEkpF/2ut97ijmK5J8GnMNDvtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4E7kgyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08119C4CEF1;
	Thu, 16 Oct 2025 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629345;
	bh=Mj9wgRxMqqUT4w+00jq7daPCIcIm0OQrKH9Iavv1fds=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R4E7kgyA4I57Vwfh0yuu3D+N2VtvhFyyHV9Y4+PTGudUZPl8kAhOzhTzUCN0LI7C3
	 jL0RtxbNq+DoYZGJ7b1hnDjovWLFc1L/pSaCY4ZaQYCxs3Nb2M7hxeLkqvNii7MM6f
	 2rJBRJBubkTvTrEg6ajgdtU9Td/QUG7PUGTcLuTOCriGTgGpQgGPdj74w9yCqdc1bH
	 +AdpiX1oM/5ZvIKAwDKhzVa1mVw2toCORx8mnJGqdyXkMjHA6/yNoLTcpkr62O5LxB
	 SuBxsS8sBMUP7ES4HtuLaO0cbFVCXc2nMeQONrakCFsFhZtDqKuV5c5LLDUDJIHaPV
	 MFQEg265NGzUw==
Date: Thu, 16 Oct 2025 08:42:24 -0700
Subject: [PATCH 10/16] fuse2fs: fix fssetxattr flags updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915646.3343688.11806287002162350034.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix flags setting so that it actually works -- we need to preserve the
iflags bits that don't exist in xflags.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 9b5012c1569d4e ("fuse2fs: support getting and setting via struct fsxattr")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 868b889912857d..5e610be2760a5a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3891,6 +3891,33 @@ static __u32 fsxflags_to_iflags(__u32 xflags)
 	return iflags;
 }
 
+#define FUSE2FS_MODIFIABLE_XFLAGS (FS_XFLAG_IMMUTABLE | \
+				   FS_XFLAG_APPEND | \
+				   FS_XFLAG_SYNC | \
+				   FS_XFLAG_NOATIME | \
+				   FS_XFLAG_NODUMP | \
+				   FS_XFLAG_PROJINHERIT)
+
+#define FUSE2FS_MODIFIABLE_IXFLAGS (FS_IMMUTABLE_FL | \
+				    FS_APPEND_FL | \
+				    FS_SYNC_FL | \
+				    FS_NOATIME_FL | \
+				    FS_NODUMP_FL | \
+				    FS_PROJINHERIT_FL)
+
+static inline int set_xflags(struct ext2_inode_large *inode, __u32 xflags)
+{
+	__u32 iflags;
+
+	if (xflags & ~FUSE2FS_MODIFIABLE_XFLAGS)
+		return -EINVAL;
+
+	iflags = fsxflags_to_iflags(xflags);
+	inode->i_flags = (inode->i_flags & ~FUSE2FS_MODIFIABLE_IXFLAGS) |
+			 (iflags & FUSE2FS_MODIFIABLE_IXFLAGS);
+	return 0;
+}
+
 static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 			    void *data)
 {
@@ -3900,7 +3927,6 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	int ret;
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fsxattr *fsx = data;
-	__u32 flags = fsxflags_to_iflags(fsx->fsx_xflags);
 	unsigned int inode_size;
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
@@ -3912,7 +3938,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
-	ret = set_iflags(&inode, flags);
+	ret = set_xflags(&inode, fsx->fsx_xflags);
 	if (ret)
 		return ret;
 


