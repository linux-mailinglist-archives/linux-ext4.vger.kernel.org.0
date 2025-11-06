Return-Path: <linux-ext4+bounces-11572-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB41C3D9EC
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D633A7710
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E82FBDFA;
	Thu,  6 Nov 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZg2eMzg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013433074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468473; cv=none; b=PQie7wx/98n1PYMBObVOOM9Lvhh/KgMMf/O7g1gRYsPR7RZoyxcvWCjzqYYT2FUuK0P+4MWhdbb1VvAEurnOQ04WDzV22B8CyW6b46+/+nDHLb/GSm5R01o719TXjgkWmUPr1SMZyXEACcAivBwOx+KHPKHLQWUGwe20MYPRPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468473; c=relaxed/simple;
	bh=Ix3nrqCupK/CoIxzvn4S863lOT9srnv137K/XRAdUrc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5tsBEck1neHI3txno76m9LrcJYNdUu16dH2hm32OTZRGKcf/uTuIgs8QI7SioeYDYJ2fl8zsHTzE8V1WlLG4Q2+3V6JdTX7HyWObQdThQVnapFJyRgibPzR2DLJPVIkHml/iCrnyO6UD9p8hbchnyNbr0abD/I7R3BDbBWJcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZg2eMzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C71C4CEFB;
	Thu,  6 Nov 2025 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468472;
	bh=Ix3nrqCupK/CoIxzvn4S863lOT9srnv137K/XRAdUrc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CZg2eMzgaFt5pyfwQZVHyaBptJaVO1GwLmuDwYYOy9U++tBM7w9yZTqU0T8PFRohs
	 n4ku9ZsTWjM4Kn+Sd7/G3SXBxdhwHXFgmOMEGhx0x/ExS8YPRofF7HeJHpj4ZLcH6B
	 DZMqlN6NWTDGjXNDcPdbhji7ZEJpSl0rRuTMyVTa257jNcy5Bc1tjcJj3EcDEB6ZCH
	 zu/C0NToVs8ON4x+8yKdHhI1TLL+YByRiPEOYniMTA7rY/QBrMH6wvQUTcTmFz+pBO
	 sEBEmDrnpR191hEcLcYO8d3hR+LUuULZZBDPn5KcQE1qyyYF+YwD0yHm+UgPAW3J/Q
	 cnACAjZHIl5+g==
Date: Thu, 06 Nov 2025 14:34:32 -0800
Subject: [PATCH 13/19] fuse2fs: improve want_extra_isize handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793864.2862242.13298248851777673309.stgit@frogsfrogsfrogs>
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

System administrators can set the {min,want}_extra_isize fields in the
superblock to try to influence the allocation of extra space in an
inode.  Currently fuse2fs ignores any such value and sets it to the
minimum possible size; let's actually follow it, like the kernel does.

Note: fuse2fs isn't quite as flexible as the kernel is about changing
extra_isize, so this isn't quite good enough to pass ext4/022.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4af22ea9e0d3a3..f1fb7227f1d077 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1403,6 +1403,27 @@ static inline int fuse2fs_dirsync_flush(struct fuse2fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static void fuse2fs_set_extra_isize(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	size_t extra = sizeof(struct ext2_inode_large) -
+		EXT2_GOOD_OLD_INODE_SIZE;
+
+	if (ext2fs_has_feature_extra_isize(fs->super)) {
+		dbg_printf(ff, "%s: ino=%u extra=%zu want=%u min=%u\n",
+			   __func__, ino, extra, fs->super->s_want_extra_isize,
+			   fs->super->s_min_extra_isize);
+
+		if (fs->super->s_want_extra_isize > extra)
+			extra = fs->super->s_want_extra_isize;
+		if (fs->super->s_min_extra_isize > extra)
+			extra = fs->super->s_min_extra_isize;
+	}
+
+	inode->i_extra_isize = extra;
+}
+
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -1498,8 +1519,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	else
 		inode.i_block[0] = dev;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 
@@ -1617,6 +1637,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID);
@@ -2079,6 +2100,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
@@ -3760,8 +3782,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	memset(&inode, 0, sizeof(inode));
 	inode.i_mode = mode;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	if (ext2fs_has_feature_extents(fs->super)) {


