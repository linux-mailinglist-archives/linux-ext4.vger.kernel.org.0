Return-Path: <linux-ext4+bounces-8110-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF772ABFFE2
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119CB3B2A42
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9D239E87;
	Wed, 21 May 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glCTEQOa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6041A317A
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867382; cv=none; b=nSX7+RDRbyzYKb70Ig7gVL1HKX3a1BArHOoU7MDx+xF1Hod/0SSArpnsMszLkfeDZRpstLMcFMOYQGzTKHdPkKkg/ekUkSBCarf06wgxOnXBdRogCXfyWowrDrPEZTKZeB3pdzZ4sLRw77PedEvLHotyXHTY4pZYGAULn1YntT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867382; c=relaxed/simple;
	bh=YkgE8BkFBF7SFi5h0nS8Pi5LwGIB9og8lELaSuIBxwQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvM9bEm/pIyTNvBHnadDqP4FrYPzfA7OuMgNk83TM55B80/kUdNCxq4fu/AEV+7/QA9WlRmjYBkcAPNV96E7bDqwC2aUN5d4tyYHp2B/5mbwuzBidzf2I4U1zMktER7rOMwVpXXAzjxX5QdE1qOyTAIGYCCDq4vqRaBPMBQ9vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glCTEQOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFAC4CEE4;
	Wed, 21 May 2025 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867382;
	bh=YkgE8BkFBF7SFi5h0nS8Pi5LwGIB9og8lELaSuIBxwQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=glCTEQOam0Y9VYuf/yysYlMTzk0F/zY4Mbu6vCTfWKfEopMeq8sPbVvcGC1I128+n
	 yk7vJsPUVM0+SjGWSV0dueNyR6Cuq6NVhKxOoI++9JXfKGcyaJJSecOPwyEbc9S6UT
	 RlgzV5/NHbED/KTEsY63bG+Ike0cGbayXujJjE8IWgy3n2eu0IStS8s1PfsWsmr6bU
	 BeK9zkiXVLlgtWO4bP+5FehNaOuIN7XuyOjpLs/wOAdzIgPnux2RpCiPmXw5tA7Mtu
	 9ooBGY6oFU05YcD2tpZFg0UVN2/V6wRxMIQatQiT6eR9JqXNTdQFIsi66726QR5x8S
	 M4nwqagYuN/zw==
Date: Wed, 21 May 2025 15:43:01 -0700
Subject: [PATCH 2/3] fuse2fs: simplify reading and writing inodes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678229.1384866.9795826246954895736.stgit@frogsfrogsfrogs>
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

Wrap the inode read and write methods in a wrapper so that we don't have
to maintain all these silly casts and sizeof operators.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  153 ++++++++++++++++++++------------------------------------
 1 file changed, 54 insertions(+), 99 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6921e6dc0a356c..a89ba115bf6f42 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -293,6 +293,21 @@ do {									       \
 		(timespec)->tv_nsec = 0;				       \
 } while (0)
 
+static inline errcode_t fuse2fs_read_inode(ext2_filsys fs, ext2_ino_t ino,
+					   struct ext2_inode_large *inode)
+{
+	memset(inode, 0, sizeof(*inode));
+	return ext2fs_read_inode_full(fs, ino, EXT2_INODE(inode),
+				      sizeof(*inode));
+}
+
+static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
+					    struct ext2_inode_large *inode)
+{
+	return ext2fs_write_inode_full(fs, ino, EXT2_INODE(inode),
+				       sizeof(*inode));
+}
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -346,17 +361,14 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	/* Otherwise we have to read-modify-write the inode */
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
 	increment_version(&inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -371,9 +383,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 
 	if (!(fs->flags & EXT2_FLAG_RW))
 		return 0;
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -389,8 +399,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 		return 0;
 	EXT4_INODE_SET_XTIME(i_atime, &now, &inode);
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -412,9 +421,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 		return 0;
 	}
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -423,8 +430,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -725,9 +731,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	int ret = 0;
 	struct timespec tv;
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -1070,8 +1074,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
-	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1139,8 +1142,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 
 	/* Is the parent dir sgid? */
-	err = ext2fs_read_inode_full(fs, parent, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, parent, &inode);
 	if (err) {
 		ret = translate_error(fs, parent, err);
 		goto out2;
@@ -1178,9 +1180,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	dbg_printf(ff, "%s: created ino=%d/path=%s in dir=%d\n", __func__, child,
 		   node_name, parent);
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, child, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1195,8 +1195,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
-	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1316,9 +1315,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	struct ext2_inode_large inode;
 	int ret = 0;
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -1368,8 +1365,7 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 				  LINUX_S_ISDIR(inode.i_mode));
 
 write_out:
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -1505,9 +1501,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 	if (rds.parent) {
 		dbg_printf(ff, "%s: decr dir=%d link count\n", __func__,
 			   rds.parent);
-		err = ext2fs_read_inode_full(fs, rds.parent,
-					     EXT2_INODE(&inode),
-					     sizeof(inode));
+		err = fuse2fs_read_inode(fs, rds.parent, &inode);
 		if (err) {
 			ret = translate_error(fs, rds.parent, err);
 			goto out;
@@ -1517,9 +1511,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		ret = update_mtime(fs, rds.parent, &inode);
 		if (ret)
 			goto out;
-		err = ext2fs_write_inode_full(fs, rds.parent,
-					      EXT2_INODE(&inode),
-					      sizeof(inode));
+		err = fuse2fs_write_inode(fs, rds.parent, &inode);
 		if (err) {
 			ret = translate_error(fs, rds.parent, err);
 			goto out;
@@ -1617,9 +1609,7 @@ static int op_symlink(const char *src, const char *dest)
 	dbg_printf(ff, "%s: symlinking ino=%d/name=%s to dir=%d\n", __func__,
 		   child, node_name, parent);
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, child, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1632,8 +1622,7 @@ static int op_symlink(const char *src, const char *dest)
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
-	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -1966,9 +1955,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out2;
@@ -1983,8 +1970,7 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out2;
@@ -2108,9 +2094,7 @@ static int op_chmod(const char *path, mode_t mode
 	}
 	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -2149,8 +2133,7 @@ static int op_chmod(const char *path, mode_t mode
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -2186,9 +2169,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	dbg_printf(ff, "%s: path=%s owner=%d group=%d ino=%d\n", __func__,
 		   path, owner, group, ino);
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -2227,8 +2208,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -3296,8 +3276,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
-	err = ext2fs_write_inode_full(fs, child, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out2;
@@ -3434,9 +3413,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	if (ret)
 		goto out;
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -3460,8 +3437,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	if (ret)
 		goto out;
 
-	err = ext2fs_write_inode_full(fs, ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, ino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -3496,9 +3472,7 @@ static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3518,9 +3492,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3535,8 +3507,7 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3552,9 +3523,7 @@ static int ioctl_getversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3574,9 +3543,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3589,8 +3556,7 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3631,9 +3597,7 @@ static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3680,9 +3644,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3701,8 +3663,7 @@ static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (ret)
 		return ret;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -3896,9 +3857,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (!fs_can_allocate(ff, len / fs->blocksize))
 		return -ENOSPC;
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return err;
 	fsize = EXT2_I_SIZE(&inode);
@@ -3927,8 +3886,7 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return err;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -4036,9 +3994,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
 		   fh->ino, mode, start, end);
 
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				     sizeof(inode));
+	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
@@ -4069,8 +4025,7 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return err;
 
-	err = ext2fs_write_inode_full(fs, fh->ino, EXT2_INODE(&inode),
-				      sizeof(inode));
+	err = fuse2fs_write_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 


