Return-Path: <linux-ext4+bounces-8104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C32ABFFD5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ADD3B276B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C71754B;
	Wed, 21 May 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhCmseVl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9490186294
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867288; cv=none; b=JPIZlg8b1ei7W9sTT8rFAhzksU1BQdCm+6L2Mv0CSv85w/uy+sa+xmi83C9GolFqaZohnRW8C0+xv1qZpLPLDh6Js2yeZEs40PCyYOQorFmr/MboXIa/9HHG7zHylAq+DYhf4zJG4J8Rqf65dlLRpZIA4+vU7gbeZuyjhN7sJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867288; c=relaxed/simple;
	bh=82RKYbPrlDRo9OCCckUHfdouahzP/qf9439y51R/Ru8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA2m2wxK1TmSzeWUjg+sXRcDpdxPTEOu5X4EMmGJvNgZ7joHza1ozbHqvlrK6DbB4vUpIBZFmQP/kTXLl4cYfM+2aEEzGa1T90SlNR0lbvPQSTJy7lYQIyh7WBgiQRNXA6BOEb0Cd6YRHHTHqIeCo476r0IUbAGWUgvhPcp1Gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhCmseVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B8DC4CEE4;
	Wed, 21 May 2025 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867288;
	bh=82RKYbPrlDRo9OCCckUHfdouahzP/qf9439y51R/Ru8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jhCmseVlP2E3GT4ldXAPC1T3LgyyR/5Vm/0R5/PTBBv5a0uK/saOa9EbMRkDE4Shb
	 YDeZAj7g1Na2dRHgq3Ic3rqne8mYrmViB9zxO4XPFkUUNyhuECI0Wcn1DvvxQ6S+w1
	 fgILPilBW4eEglhMuZd0ccGap3fdoEa/6fNJjzekqZ8cn0pYYEJ/2EDgYMHgnVPLOs
	 mtp5gLqvUezxKvcqvIP61ok0WM1yxWyjXJOQrL73zgNSKO9gP7C1SSSHd64cjWFTk6
	 jLmtgpl3s2k84r/HmhZeYOB/3q5MFL5eGygvRoCc/QoKd3vlXmcaCw83Lz6frOCfmv
	 48n8kWAp/YsYg==
Date: Wed, 21 May 2025 15:41:26 -0700
Subject: [PATCH 25/29] fuse2fs: fix removing ea inodes when freeing a file
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677996.1383760.7408606469648643965.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the filesystem has ea_inode set, then each file that has xattrs might
have stored an xattr value in a separate inode.  These inodes also need
to be freed, so create a library function to do that, and call it from
the fuse2fs unlink method.  Seen by ext4/026.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h          |    1 +
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/ext_attr.c        |   19 +++++++++++++++++++
 misc/fuse2fs.c               |   40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 1527719554f001..2661e10f57c047 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1406,6 +1406,7 @@ errcode_t ext2fs_xattr_set(struct ext2_xattr_handle *handle,
 			   size_t value_len);
 errcode_t ext2fs_xattr_remove(struct ext2_xattr_handle *handle,
 			      const char *key);
+errcode_t ext2fs_xattr_remove_all(struct ext2_xattr_handle *handle);
 errcode_t ext2fs_xattrs_open(ext2_filsys fs, ext2_ino_t ino,
 			     struct ext2_xattr_handle **handle);
 errcode_t ext2fs_xattrs_close(struct ext2_xattr_handle **handle);
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index 35af8880dd4843..fc1e16ff1e086c 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -670,6 +670,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  ext2fs_xattr_get@Base 1.43
  ext2fs_xattr_inode_max_size@Base 1.43
  ext2fs_xattr_remove@Base 1.43
+ ext2fs_xattr_remove_all@Base 1.47.3
  ext2fs_xattr_set@Base 1.43
  ext2fs_xattrs_close@Base 1.43
  ext2fs_xattrs_count@Base 1.43
diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index 1b5f90d33f3cd4..7723d0f918d6a8 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -1355,6 +1355,7 @@ static errcode_t xattr_inode_dec_ref(ext2_filsys fs, ext2_ino_t ino)
 			goto out;
 	}
 
+	inode.i_flags &= ~EXT4_EA_INODE_FL;
 	ext2fs_inode_alloc_stats2(fs, ino, -1 /* inuse */, 0 /* is_dir */);
 
 write_out:
@@ -1725,6 +1726,24 @@ errcode_t ext2fs_xattr_remove(struct ext2_xattr_handle *handle,
 	return 0;
 }
 
+errcode_t ext2fs_xattr_remove_all(struct ext2_xattr_handle *handle)
+{
+	struct ext2_xattr *x;
+	struct ext2_xattr *end = handle->attrs + handle->count;
+
+	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
+	for (x = handle->attrs; x < end; x++) {
+		ext2fs_free_mem(&x->name);
+		ext2fs_free_mem(&x->value);
+		if (x->ea_ino)
+			xattr_inode_dec_ref(handle->fs, x->ea_ino);
+	}
+
+	handle->ibody_count = 0;
+	handle->count = 0;
+	return ext2fs_xattrs_write(handle);
+}
+
 errcode_t ext2fs_xattrs_open(ext2_filsys fs, ext2_ino_t ino,
 			     struct ext2_xattr_handle **handle)
 {
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a630d93f5f48a8..46ae73bd4e25bb 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1178,6 +1178,40 @@ static int unlink_file_by_name(struct fuse2fs *ff, const char *path)
 	return update_mtime(fs, dir, NULL);
 }
 
+static errcode_t remove_ea_inodes(struct fuse2fs *ff, ext2_ino_t ino,
+				  struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_xattr_handle *h;
+	errcode_t err;
+
+	/*
+	 * The xattr handle maintains its own private copy of the inode, so
+	 * write ours to disk so that we can read it.
+	 */
+	err = fuse2fs_write_inode(fs, ino, inode);
+	if (err)
+		return err;
+
+	err = ext2fs_xattrs_open(fs, ino, &h);
+	if (err)
+		return err;
+
+	err = ext2fs_xattrs_read(h);
+	if (err)
+		goto out_close;
+
+	err = ext2fs_xattr_remove_all(h);
+	if (err)
+		goto out_close;
+
+out_close:
+	ext2fs_xattrs_close(&h);
+
+	/* Now read the inode back in. */
+	return fuse2fs_read_inode(fs, ino, inode);
+}
+
 static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 {
 	ext2_filsys fs = ff->fs;
@@ -1213,6 +1247,12 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+	if (ext2fs_has_feature_ea_inode(fs->super)) {
+		err = remove_ea_inodes(ff, ino, &inode);
+		if (err)
+			goto write_out;
+	}
+
 	/* Nobody holds this file; free its blocks! */
 	err = ext2fs_free_ext_attr(fs, ino, &inode);
 	if (err)


