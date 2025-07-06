Return-Path: <linux-ext4+bounces-8834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FCAFA730
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF233B0640
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CA1891AB;
	Sun,  6 Jul 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlvZ5DPL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703712C544
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826708; cv=none; b=f4sfSGKmXHfEbeh7sd6s2Qn2wM5ePyFe+EqSe0jwM/piKWGkO/JaaOS+qGC/E1QZJHON/gnabQEPGEy2wqy+kt9wMpUgEikFpXvSq8ShzTt7mV52Dke1mtN+NvCwALCywnj2pzGZAdltjYSLgh1H5mV/DCH4AP6F0WCr4Gsxpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826708; c=relaxed/simple;
	bh=xjWHrU6OPbbJrDwEE2WROa0mesVW6Qas+Q58cGgsPgI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSjFusetqBpr/YTuuLsoRU6vkxhXEFURMQ661obN1E6OB1kjaS3RB1+KFaAFxHWuXoRHxOGG7exuI1lQ2MAj5XxAlVIDTc0IDrafpn9rsG7BgICY6S1oTvuv46R10cqT4UJV+FX8+atm40t3kUhYs+rVcNBN61dUw3UL2n4sg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlvZ5DPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16437C4CEED;
	Sun,  6 Jul 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826708;
	bh=xjWHrU6OPbbJrDwEE2WROa0mesVW6Qas+Q58cGgsPgI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tlvZ5DPL5hZAF38u6OflSa6jJBgsepgFsP54vaPHuo3wglit0FiJNe2414u5CQNkR
	 lydBlHdoomR+BhUTBlX69aHOYhD2yx1OHfZ9QuD7DH3wJ8sEtrUHYSWuw8arM0c1GC
	 RsJTQbAORWiMCKEQRMDknJBo89Yf1bW90/SOofn8TYo+G+ooYbPDmJHxQ5XD+DnCeL
	 4aTmn50k8KKP/pUkp5fbW+W0JNVZ380gkt5ZlQJZBMHp/+YW/eaRjl0U+7rInRQufJ
	 d3ARdce93GWoiRLUeZIyiwzwGZLJNx/mH7NME5vM4F3JU9YqTy4OCQiAFfeP7FxQ5v
	 DC/l4nv3WxxoQ==
Date: Sun, 06 Jul 2025 11:31:47 -0700
Subject: [PATCH 4/8] fuse2fs: fix gid inheritance on sgid parent directories
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182663041.1984706.582232688757289460.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When a child file is created inside a setgid parent directory, the child
is supposed to inherit the gid of the parent, not the fsgid of the
creating process.  Fix this error, which was discovered by generic/633,
generic/696, and generic/697.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   62 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 13 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 86fef7765e5e46..0e9576b6ca6aa7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1065,6 +1065,30 @@ static inline void fuse2fs_set_gid(struct ext2_inode_large *inode, gid_t gid)
 	ext2fs_set_i_gid_high(*inode, gid >> 16);
 }
 
+static int fuse2fs_new_child_gid(struct fuse2fs *ff, ext2_ino_t parent,
+				 gid_t *gid, int *parent_sgid)
+{
+	struct ext2_inode_large inode;
+	struct fuse_context *ctxt = fuse_get_context();
+	errcode_t err;
+
+	err = fuse2fs_read_inode(ff->fs, parent, &inode);
+	if (err)
+		return translate_error(ff->fs, parent, err);
+
+	if (inode.i_mode & S_ISGID) {
+		if (parent_sgid)
+			*parent_sgid = 1;
+		*gid = inode.i_gid;
+	} else {
+		if (parent_sgid)
+			*parent_sgid = 0;
+		*gid = ctxt->gid;
+	}
+
+	return 0;
+}
+
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -1076,6 +1100,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	char *node_name, a;
 	int filetype;
 	struct ext2_inode_large inode;
+	gid_t gid;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -1128,6 +1153,10 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
+	err = fuse2fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
+
 	err = ext2fs_new_inode(fs, parent, mode, 0, &child);
 	if (err) {
 		ret = translate_error(fs, 0, err);
@@ -1158,7 +1187,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
 	fuse2fs_set_uid(&inode, ctxt->uid);
-	fuse2fs_set_gid(&inode, ctxt->gid);
+	fuse2fs_set_gid(&inode, gid);
 
 	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
@@ -1199,7 +1228,8 @@ static int op_mkdir(const char *path, mode_t mode)
 	char *block;
 	blk64_t blk;
 	int ret = 0;
-	mode_t parent_sgid;
+	gid_t gid;
+	int parent_sgid;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
@@ -1235,13 +1265,9 @@ static int op_mkdir(const char *path, mode_t mode)
 	if (ret)
 		goto out2;
 
-	/* Is the parent dir sgid? */
-	err = fuse2fs_read_inode(fs, parent, &inode);
-	if (err) {
-		ret = translate_error(fs, parent, err);
+	err = fuse2fs_new_child_gid(ff, parent, &gid, &parent_sgid);
+	if (err)
 		goto out2;
-	}
-	parent_sgid = inode.i_mode & S_ISGID;
 
 	*node_name = a;
 
@@ -1273,9 +1299,10 @@ static int op_mkdir(const char *path, mode_t mode)
 	}
 
 	fuse2fs_set_uid(&inode, ctxt->uid);
-	fuse2fs_set_gid(&inode, ctxt->gid);
-	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID) |
-		       parent_sgid;
+	fuse2fs_set_gid(&inode, gid);
+	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID);
+	if (parent_sgid)
+		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
@@ -1629,6 +1656,7 @@ static int op_symlink(const char *src, const char *dest)
 	errcode_t err;
 	char *node_name, a;
 	struct ext2_inode_large inode;
+	gid_t gid;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -1661,6 +1689,9 @@ static int op_symlink(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
+	err = fuse2fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
 
 	/* Create symlink */
 	err = ext2fs_symlink(fs, parent, 0, node_name, src);
@@ -1700,7 +1731,7 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	fuse2fs_set_uid(&inode, ctxt->uid);
-	fuse2fs_set_gid(&inode, ctxt->gid);
+	fuse2fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
@@ -3240,6 +3271,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	char *node_name, a;
 	int filetype;
 	struct ext2_inode_large inode;
+	gid_t gid;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3276,6 +3308,10 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	if (ret)
 		goto out2;
 
+	err = fuse2fs_new_child_gid(ff, parent, &gid, NULL);
+	if (err)
+		goto out2;
+
 	*node_name = a;
 
 	filetype = ext2_file_type(mode);
@@ -3305,7 +3341,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
 	fuse2fs_set_uid(&inode, ctxt->uid);
-	fuse2fs_set_gid(&inode, ctxt->gid);
+	fuse2fs_set_gid(&inode, gid);
 	if (ext2fs_has_feature_extents(fs->super)) {
 		ext2_extent_handle_t handle;
 


