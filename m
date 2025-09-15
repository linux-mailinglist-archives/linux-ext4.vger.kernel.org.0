Return-Path: <linux-ext4+bounces-10059-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD6B587A2
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416E71B256A1
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210282D47EB;
	Mon, 15 Sep 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeaTle37"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4D2D1F7C
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975973; cv=none; b=OFHhmEVf5PbQ0X/MH+9HhlbgWcacyxI+FSFMTUlx8K/fWdUnxZwVSUVzgU88t7nPSIUUilkXYjVDihP9ziTMI/UlZkPd6vXsuEoJ6xnM4LR4wrMDkSY/72dmRICvtrIDg6s0tJgpox4kt7z9D7oSFVoLj4oJex2q79M/uHiL8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975973; c=relaxed/simple;
	bh=U/dBHAnHAZJ96BhM3ptIOGFDZjPAnmvwASRnRU6DEQA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlaBTpZ3Ojf9ZPhwz59sPPfGzb2twruMgDabfAeI51U3BFwajJeS/VZVtzw2OZGDyh3LTI+4KZ43hDZyBw802XeqPf+Qp1dHCChuLr1ww5CTaO1pncuy23FvS9STb1N1nATHewi81euICCnXp9HYJR8+4ewpK/EOx5sXZ0Y81M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeaTle37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A8C4CEF1;
	Mon, 15 Sep 2025 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975973;
	bh=U/dBHAnHAZJ96BhM3ptIOGFDZjPAnmvwASRnRU6DEQA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NeaTle37A/Z2fKJEu3YvkzQfm+nuL7qoYlUYcGrZpD9d+h/VcfbXX4NedRPY34GCk
	 H+ZJzhSy5O3wim0e9gWjRqdbIrhSvuiDupV4KUZPhsryKlN4n2VtzheD+c/E6muUcy
	 Waq6SbQ7EPKAT7DYrEFIeIoKNrvKbcdgHvQqWRP6Bi8lzwZLaiK6AkmnLgDB3zBzew
	 glrtyqKvk297Y9DghcFMFLaBXsMyA9073parynTiBLqSQpdqtcqzOirMKcwXH5NFTB
	 1ZqjRqU1LT/rBM+R8DJdzV6t+4zi8fYMNS9+1bnuT396dAzFCWiEXdEbXU11ERc3s2
	 naEkZrCKIFcag==
Date: Mon, 15 Sep 2025 15:39:32 -0700
Subject: [PATCH 07/12] fuse2fs: fix fssetxattr flags updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569745.245695.6936544007331941052.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
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
index 4ebc949b53d1fe..de675b4ecb9438 100644
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
 


