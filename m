Return-Path: <linux-ext4+bounces-8109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BDABFFE0
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE201BC2327
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22535239581;
	Wed, 21 May 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwPiAGr5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F651754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867366; cv=none; b=r0Gi3aoL5TmncFf8rA2ZxJbQ0UDMbcjhni2uyG7Hvf2Kuix4m4GDbzFClArHmtWNHAdnyZRUUpec3zL5jx8fg5qOMeYhE5E7YtKmH673BPjJW3HMDw6zNPZd/X0QBAYTdgIRUqtOBmf8g+dUMsTihNebmd5Q8IU5kHJ3tRnpIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867366; c=relaxed/simple;
	bh=f1OnznGEoKd2P70Pq433/XhN2dQPmurdkHvUriC+ni8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXM1nmS4EpF1Gs1DG9wYMfJZCFNHPQL570c90Zw5eBBs4nlH6FhI9PBxQnRiUTPx7zQYosnNLULIPaVuNcuuWO0126VkGMaeC51Jxq5Qy9pcsYxI1+MSMNBDNoo0ak3EauhuAuo+LPoPGmsoJ95oXuOt2GURYvLlh7TYIIyVFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwPiAGr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B520C4CEE4;
	Wed, 21 May 2025 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867366;
	bh=f1OnznGEoKd2P70Pq433/XhN2dQPmurdkHvUriC+ni8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WwPiAGr54G++e1grgwiXGP3o/LPast9se8frpRYnxBq1TnCxZ8nl2nrRRL8xkrJ4V
	 E1K9HaFDDOWawfNVie1obqF8G0G4V8U2Eqjb2BXFxUep/xlJOdk3ZY8eeI9rAI4M71
	 pcSv2RKgVKSKDUIH8s5MVj1XK9vrgcKV1TzBCMigfczhBJo/U/HRt+wI/934Dgptlv
	 QYFvHPgO/oarAjKvqdllsfATUWnBcA5ou0+9vJkh6oPQyak1d3IkRKHUaS6+3LukHV
	 abCo5TonA8xPG5c2UWODI7qmwI8GwoZXNk6Kdz3PgBzjB0cZe38jkPpKs9ztdTOiRn
	 KP49wBKlwKUSQ==
Date: Wed, 21 May 2025 15:42:46 -0700
Subject: [PATCH 1/3] fuse2fs: clean up open-coded ext2_inode_large ->
 ext2_inode casts
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678211.1384866.6557992647185012616.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
References: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

There's a typechecked helper for this now, so let's use it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  102 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7ec9c6d861fd80..6921e6dc0a356c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -347,7 +347,7 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 
 	/* Otherwise we have to read-modify-write the inode */
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -355,7 +355,7 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -372,7 +372,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	if (!(fs->flags & EXT2_FLAG_RW))
 		return 0;
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -389,7 +389,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 		return 0;
 	EXT4_INODE_SET_XTIME(i_atime, &now, &inode);
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -413,7 +413,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -423,7 +423,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -726,7 +726,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	struct timespec tv;
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, ino, err);
@@ -741,7 +741,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	statbuf->st_size = EXT2_I_SIZE(&inode);
 	statbuf->st_blksize = fs->blocksize;
 	statbuf->st_blocks = ext2fs_get_stat_i_blocks(fs,
-						(struct ext2_inode *)&inode);
+						EXT2_INODE(&inode));
 	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
 	statbuf->st_atime = tv.tv_sec;
 	statbuf->st_atim.tv_nsec = tv.tv_nsec;
@@ -1062,7 +1062,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	inode.i_gid = ctxt->gid;
 	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 
-	err = ext2fs_write_new_inode(fs, child, (struct ext2_inode *)&inode);
+	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1070,7 +1070,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
-	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1139,7 +1139,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 
 	/* Is the parent dir sgid? */
-	err = ext2fs_read_inode_full(fs, parent, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, parent, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, parent, err);
@@ -1179,7 +1179,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		   node_name, parent);
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, child, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1195,7 +1195,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
-	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1211,7 +1211,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		ret = translate_error(fs, child, err);
 		goto out2;
 	}
-	err = ext2fs_bmap2(fs, child, (struct ext2_inode *)&inode, NULL, 0, 0,
+	err = ext2fs_bmap2(fs, child, EXT2_INODE(&inode), NULL, 0, 0,
 			   NULL, &blk);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1317,7 +1317,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	int ret = 0;
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -1355,8 +1355,8 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	if (err)
 		goto write_out;
 
-	if (ext2fs_inode_has_valid_blocks2(fs, (struct ext2_inode *)&inode)) {
-		err = ext2fs_punch(fs, ino, (struct ext2_inode *)&inode, NULL,
+	if (ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode))) {
+		err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), NULL,
 				   0, ~0ULL);
 		if (err) {
 			ret = translate_error(fs, ino, err);
@@ -1368,7 +1368,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 				  LINUX_S_ISDIR(inode.i_mode));
 
 write_out:
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -1506,7 +1506,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		dbg_printf(ff, "%s: decr dir=%d link count\n", __func__,
 			   rds.parent);
 		err = ext2fs_read_inode_full(fs, rds.parent,
-					     (struct ext2_inode *)&inode,
+					     EXT2_INODE(&inode),
 					     sizeof(inode));
 		if (err) {
 			ret = translate_error(fs, rds.parent, err);
@@ -1518,7 +1518,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		if (ret)
 			goto out;
 		err = ext2fs_write_inode_full(fs, rds.parent,
-					      (struct ext2_inode *)&inode,
+					      EXT2_INODE(&inode),
 					      sizeof(inode));
 		if (err) {
 			ret = translate_error(fs, rds.parent, err);
@@ -1618,7 +1618,7 @@ static int op_symlink(const char *src, const char *dest)
 		   child, node_name, parent);
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, child, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1632,7 +1632,7 @@ static int op_symlink(const char *src, const char *dest)
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
-	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -1967,7 +1967,7 @@ static int op_link(const char *src, const char *dest)
 	}
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -1983,7 +1983,7 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -2109,7 +2109,7 @@ static int op_chmod(const char *path, mode_t mode
 	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -2149,7 +2149,7 @@ static int op_chmod(const char *path, mode_t mode
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -2187,7 +2187,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 		   path, owner, group, ino);
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -2227,7 +2227,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -3282,13 +3282,13 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 		inode.i_flags &= ~EXT4_EXTENTS_FL;
 		ret = ext2fs_extent_open2(fs, child,
-					  (struct ext2_inode *)&inode, &handle);
+					  EXT2_INODE(&inode), &handle);
 		if (ret)
 			return ret;
 		ext2fs_extent_free(handle);
 	}
 
-	err = ext2fs_write_new_inode(fs, child, (struct ext2_inode *)&inode);
+	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -3296,7 +3296,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
-	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -3435,7 +3435,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 		goto out;
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -3460,7 +3460,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err) {
 		ret = translate_error(fs, ino, err);
@@ -3497,7 +3497,7 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3519,7 +3519,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3535,7 +3535,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3553,7 +3553,7 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3575,7 +3575,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3589,7 +3589,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3632,7 +3632,7 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3681,7 +3681,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3701,7 +3701,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3897,7 +3897,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 		return -ENOSPC;
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return err;
@@ -3907,7 +3907,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	flags = (mode & FL_KEEP_SIZE_FLAG ? 0 :
 			EXT2_FALLOCATE_INIT_BEYOND_EOF);
 	err = ext2fs_fallocate(fs, flags, fh->ino,
-			       (struct ext2_inode *)&inode,
+			       EXT2_INODE(&inode),
 			       ~0ULL, start, end - start + 1);
 	if (err && err != EXT2_ET_BLOCK_ALLOC_FAIL)
 		return translate_error(fs, fh->ino, err);
@@ -3916,7 +3916,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (!(mode & FL_KEEP_SIZE_FLAG)) {
 		if ((__u64) offset + len > fsize) {
 			err = ext2fs_inode_size_set(fs,
-						(struct ext2_inode *)&inode,
+						EXT2_INODE(&inode),
 						offset + len);
 			if (err)
 				return translate_error(fs, fh->ino, err);
@@ -3927,7 +3927,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return err;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -3954,7 +3954,7 @@ static errcode_t clean_block_middle(ext2_filsys fs, ext2_ino_t ino,
 			return err;
 	}
 
-	err = ext2fs_bmap2(fs, ino, (struct ext2_inode *)inode, *buf, 0,
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
 			   offset / fs->blocksize, &retflags, &blk);
 	if (err)
 		return err;
@@ -3989,7 +3989,7 @@ static errcode_t clean_block_edge(ext2_filsys fs, ext2_ino_t ino,
 			return err;
 	}
 
-	err = ext2fs_bmap2(fs, ino, (struct ext2_inode *)inode, *buf, 0,
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), *buf, 0,
 			   offset / fs->blocksize, &retflags, &blk);
 	if (err)
 		return err;
@@ -4037,7 +4037,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 		   fh->ino, mode, start, end);
 
 	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				     sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -4059,7 +4059,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 
 	/* Unmap full blocks in the middle */
 	if (start <= end) {
-		err = ext2fs_punch(fs, fh->ino, (struct ext2_inode *)&inode,
+		err = ext2fs_punch(fs, fh->ino, EXT2_INODE(&inode),
 				   NULL, start, end);
 		if (err)
 			return translate_error(fs, fh->ino, err);
@@ -4069,7 +4069,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return err;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
 				      sizeof(inode));
 	if (err)
 		return translate_error(fs, fh->ino, err);


