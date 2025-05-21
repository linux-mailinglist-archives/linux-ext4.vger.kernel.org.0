Return-Path: <linux-ext4+bounces-8117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFCABFFEC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E741BC4207
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B171A317A;
	Wed, 21 May 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEo3toHG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79185239E85
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867492; cv=none; b=bYdfdKxqHTfTj68eh5lu7rdi1WOAISACLESjSkr6SMs78P1oxLK4IdlioeMVNEHlzQeo1eWPBZimmvWu3F65GgrKkqKqbcKN0lUrMTSwTTXrj8uIo7YUhYn4ZNf8D3KZILPuwlaXVFDQURtT+THhBHkQJlo+hb5AvI7kRvoorsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867492; c=relaxed/simple;
	bh=Yw67ZV5pPOV8L6uds9iUVtCTK3GbZ3Rw1f1z+pUSq3Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H14Po7Z6LJq228OOVMukh6DMpajTwgTbChvSUXwVYfgahPm3J/EVzBnyqKoW0mWcLTOdANxYRa+gFLk241YdsFDEdQsKt/EsWidJpq7D3WJvJXOTgTnFwGaQrfBVQx424uMVJT6njWmhsQcQ5/4M4fsP/luHngGciqU0PUWNW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEo3toHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE565C4CEE4;
	Wed, 21 May 2025 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867492;
	bh=Yw67ZV5pPOV8L6uds9iUVtCTK3GbZ3Rw1f1z+pUSq3Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HEo3toHGcRjN/0HMHRk6E/sAdeJ+ed7HpvUI+4RLLQikBblHTJ/Ejiq5YzTvyyGh7
	 YpsvV3Q44BmTiACUQl+VqI/hdqTQUlCydBPEeVR/lnUrhmTP7aNjNeqdMfdiXFovCj
	 8BlTwJr/L6rR7O/Bn0lbbNXGMRQmxB9dr+sj6AXu9HrRslVQIMb+IxJV8sU6fDMQU9
	 Jp9lG0Gf0B/vs+LvnRrBF6GnKZLzizuzKjkVlYmyVkJOU9pA65KvjtXR8YCjqUJOwN
	 XY665vmrxG01IF2cJE+OxLCedpR3Zem2DG1aTgEiB+Yp1fiDpDYj2Miu/9SJIy26Dk
	 MmfOZ1GpJT/YA==
Date: Wed, 21 May 2025 15:44:51 -0700
Subject: [PATCH 6/7] fuse2fs: improve want_extra_isize handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678508.1385038.8423891544968548049.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
References: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
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
index b0d3e3ea479d72..49c77569a0336b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1034,6 +1034,27 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	return ret;
 }
 
+static void set_extra_isize(struct fuse2fs *ff, ext2_ino_t ino,
+			    struct ext2_inode_large *inode)
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
@@ -1133,8 +1154,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	else
 		inode.i_block[0] = dev;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	set_extra_isize(ff, child, &inode);
 	inode.i_uid = ctxt->uid;
 	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
@@ -1260,6 +1280,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
+	set_extra_isize(ff, child, &inode);
 	inode.i_uid = ctxt->uid;
 	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
@@ -1703,6 +1724,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
+	set_extra_isize(ff, child, &inode);
 	inode.i_uid = ctxt->uid;
 	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
@@ -3376,8 +3398,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	memset(&inode, 0, sizeof(inode));
 	inode.i_mode = mode;
 	inode.i_links_count = 1;
-	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
-		EXT2_GOOD_OLD_INODE_SIZE;
+	set_extra_isize(ff, child, &inode);
 	inode.i_uid = ctxt->uid;
 	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;


