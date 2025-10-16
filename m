Return-Path: <linux-ext4+bounces-10903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87204BE450A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673AB3B451C
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E0313287;
	Thu, 16 Oct 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlw8RoZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A220DD48
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629361; cv=none; b=L4KKuFVlfQ/XHurGM69+hawOPosLZJo4oBB7RQulQx2v7+K+cbZVj12LnXY/BgB3PzTiX/jhsJrwk0Lx3ncX5N3HGIOgYTG1v2+6/2etuAcb4QN15hva54YERQR+EMxlqlPcSlYIo/OVkIuuuecQ5PWdfTG57c/fpoKYxX2jgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629361; c=relaxed/simple;
	bh=7/wrJ8p7lXO4kNm3WtUhz2rYuD1tBHqUESGX9eyATeA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBil4fyfmcbo85NbJx+ldI7UAG6/fx7hPLVv65d+Nh2J5LD0hC5SQfg3UAO0UzsAxLK9d1HhVfXxZK6GeTbhr5e5N/gIUG9Z4kAm71szrre9fRmeDg1x7KQ7asHmFq2P/kc9Z+Syz1ZuTdje1QtYsHoPKD6pUOd5+Cz//lJxVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlw8RoZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB73C4CEF1;
	Thu, 16 Oct 2025 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629360;
	bh=7/wrJ8p7lXO4kNm3WtUhz2rYuD1tBHqUESGX9eyATeA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jlw8RoZlqeF6ILX6y19mZwFxNUbkYHOul76+L86q36gEPTY3fVnWJW31MgUt3P0I9
	 lcrveJN0BZvUunGUulR2O0TlxtfyB/K4eKc6Ne4ZX1vcLBot/RUP6W21Lx/+uhLkH/
	 vm6kOceKxFnGqZL8I8s3zF4E0bvBGCYzSxtvfwCHMxwRnM2IGAgtSkzWG4+OaB6rxd
	 qCjONih5IpBqd6URCQjls/OUCbr2hKBl0vtDxgheYIY95j6h/gkBofAjOrQvt1XJR0
	 8MVhhD4w9vgMUbU0SutetuJaAwGGPCvbfXKtwENqnvQTV/vany1LZMONIDDhyPI9jr
	 KcGwiJVbSHjOQ==
Date: Thu, 16 Oct 2025 08:42:40 -0700
Subject: [PATCH 11/16] fuse2fs: fix default acls propagating to non-dir
 children
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915665.3343688.5505234672337035445.stgit@frogsfrogsfrogs>
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

New non-directory children should not be copying the default ACLs of the
parents.  Caught by generic/099 in fuseblk/iomap mode.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 2c7900387620a6 ("fuse2fs: propagate default ACLs to new children")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5e610be2760a5a..0f655c41372cc7 100644
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
 


