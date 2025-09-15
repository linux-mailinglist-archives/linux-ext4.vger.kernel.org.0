Return-Path: <linux-ext4+bounces-10060-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B6B587A3
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147F9204100
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7B2D46AF;
	Mon, 15 Sep 2025 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG+WSjJm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF42D1F44
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975989; cv=none; b=UBVrr/PWp5f85U6BYnahezrgqqqtPlNP65YxuoqYnrpLLJGPraICFVMyzxEKYBUgyesMeD383xkFIbSQsvcRik09gna+WFK++D4+GGSGJn8I+5PVgpWVa+mISkN11nnYJYz+RGug7/TXkXlSVgVLVzxKuKQ2u0Gqw35+d8+WmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975989; c=relaxed/simple;
	bh=RGkcd9YAdvJq1km3ygDapzQlBnDzMZrq0Y9SXqAsblw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVOji+QkaBoZj8+Ia9hUC3ccUXECHchUraukH68+Z4HkhLTuTHPvCHYE8oOBtPhUdZ8GM39vXHlF/dewIhRhFa7Fy/J93KvsRLBVqUWbtJAxSK94HK7RHjI8VrKtZlmI0HZBN/KNm49+sK0OJxCI4i6Mk6hdM5U4EAAHeZ+77/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG+WSjJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74C5C4CEF1;
	Mon, 15 Sep 2025 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975989;
	bh=RGkcd9YAdvJq1km3ygDapzQlBnDzMZrq0Y9SXqAsblw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AG+WSjJmKjQBiYwJNkC4SidVMCIxvCdWAVkQSMMWOGSZqI8nclTaQPSZYmHGpc+Qd
	 Q3Z/znZ2cU7dO5zzrxpdUGFNm1K8J2YyvyQbHOYF8Cp5hmmSle/ypfOovCmP/EW5Xs
	 nGI8B4dpK3JKlorH5k04rLJMU+w8mLq2zPblhWIhfFeXsiB09Zygzk7gSQH9MGiFuw
	 n6MKse4W5znIg6SShizixFDOSF10MrpkLqmxDpIkWlQ0mMkAxkYZSKNY5ofCJjSUic
	 Ld75i3nmmQOZ99w5Te19lsKHuIh1vRmuijDn5srUz4xh0UGL23TQ6ZXYr90kbr8ZbI
	 l8gguOYjPcUDw==
Date: Mon, 15 Sep 2025 15:39:48 -0700
Subject: [PATCH 08/12] fuse2fs: fix default acls propagating to non-dir
 children
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569763.245695.8285471672384752332.stgit@frogsfrogsfrogs>
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

New non-directory children should not be copying the default ACLs of the
parents.  Caught by generic/099 in fuseblk mode.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 2c7900387620a6 ("fuse2fs: propagate default ACLs to new children")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index de675b4ecb9438..b5b860466742d2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1167,13 +1167,13 @@ static int __setxattr(struct fuse2fs *ff, ext2_ino_t ino, const char *name,
 }
 
 static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
-				  ext2_ino_t child)
+				  ext2_ino_t child, mode_t mode)
 {
 	void *def;
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl)
+	if (!ff->acl || S_ISDIR(mode))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -1346,7 +1346,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out2;
 out2:
@@ -1474,7 +1474,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out3;
 	}
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out3;
 
@@ -3543,7 +3543,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
 
-	ret = propagate_default_acls(ff, parent, child);
+	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
 	if (ret)
 		goto out2;
 


