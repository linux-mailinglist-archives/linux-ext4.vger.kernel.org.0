Return-Path: <linux-ext4+bounces-10072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97645B587B8
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A74A4E2514
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1122D5C61;
	Mon, 15 Sep 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBuhDn2O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE052C11F9
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976176; cv=none; b=OBuGiGwrhMgnk29TPAgOuBhGybRi11PTIwXiMWQ7ZwsX+1z8cVikWV4EQByY2fElt3M1k5XxWa5HVQBmCyI6AB8iW8uibgjXi8Hk2MUJ5uAgPEXYwVFr5AV0CDBa+vry0VXZNwFrrKLQWmuGzIcgff9gKj0nrmdahfKObwOILgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976176; c=relaxed/simple;
	bh=AtPHZrZsKzdtYTcrnkYh+unzwUFEYqKsIDp3R2Vqvpw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh+59eW3zEwTU5sM3ldscy24mSKhiniG7gSW4h+v+BePNtkSdqIuQTSkfisTvyEx31htrz+ah/FhKGZ9zo84u9TvoKRpdi5taWoCugOUncgQerdL8+DdGvROQyJ9SQ1JrxPPYihfTX488gw7W75EP/sMUtzqNFdR7fFLy47rAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBuhDn2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4383EC4CEF1;
	Mon, 15 Sep 2025 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976176;
	bh=AtPHZrZsKzdtYTcrnkYh+unzwUFEYqKsIDp3R2Vqvpw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tBuhDn2OLUhfBARZiCtZS+hRQNwcgwF4ebG53rwhfcQIWMNBhXh8/vLkKrDyQHSSe
	 Mb4wBjGQd8ERlBeGg8OGbq81KIOBGVjI5LfBqKHJLvG5bmEQmCrtRQwCIPkZuHqXDr
	 zqc9JfgRGCcCPA8gdg1LUxEdAJG6nA8LeEcsluflNh7P+erldDaOFNr/bPbqnpS0qW
	 uBh3qmaL7qcFUnioQtaE2xaGUetyMi/Gzaz3ExgEqdVZVmJuutZ5Z93QN+R/iHyttE
	 anaJgPv+xWiW6PeEQX7ID8AZ8bGCUsmgYL95fq2jjQUc/rXDXV/e0JpLpgJWEJYrwq
	 W/E3YgpxYs2Cw==
Date: Mon, 15 Sep 2025 15:42:55 -0700
Subject: [PATCH 08/11] fuse2fs: improve want_extra_isize handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570157.246189.18172211884520016217.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
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
index 5409b288a025cf..f4ae7a273a83f5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1323,6 +1323,27 @@ static inline int fuse2fs_dirsync_flush(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -1418,8 +1439,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	else
 		inode.i_block[0] = dev;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 
@@ -1537,6 +1557,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID);
@@ -1999,6 +2020,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
@@ -3680,8 +3702,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	memset(&inode, 0, sizeof(inode));
 	inode.i_mode = mode;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	fuse2fs_set_extra_isize(ff, child, &inode);
 	fuse2fs_set_uid(&inode, ctxt->uid);
 	fuse2fs_set_gid(&inode, gid);
 	if (ext2fs_has_feature_extents(fs->super)) {


