Return-Path: <linux-ext4+bounces-8134-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE9AC000A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0713C1BC5641
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4C21E0A2;
	Wed, 21 May 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoweWFSH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC033EA
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867758; cv=none; b=Aw/Z2gkp4l5rph1siboVMvzOEZVXqKCRo7SLcDys8p0Hr+MCE7lXHFliMcDFgC67b0lKRVHJUjw/fxuVcEWfJUOr/TM2om2GRY10khU413z6me6DBGFKLwVdupHS7sXWAS13kW/xSgzCOyxTNXkQ5dXWkmd4Vi/FMBGu0nxlqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867758; c=relaxed/simple;
	bh=8gsWFBlBC/jnUBqMjE9NhkcGCzdq0kDYPVavAUODrGE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBboejhXnq5vSC9K9EH1HDwIgFszMwEKSPXHFWG7CPES0GVhxueh8eA/tsSQheigUGEsvyKF63Aw89Oeajr+rD8prnEZL/y+bY5CG2O1wX7SwZjdeg1vQsyLYLYmLQCXv2jdTbTmFPfPQCKjftZzkfYB2QJuyRYxh1HS4o9yOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoweWFSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E41C4CEE4;
	Wed, 21 May 2025 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867758;
	bh=8gsWFBlBC/jnUBqMjE9NhkcGCzdq0kDYPVavAUODrGE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VoweWFSHKnIdWGt1hzAM6NFS5cKlnfyL5pM+G3K3SPEo0guznfB3MEQEiirA7FHVd
	 IIUOQjNOVd6k2051npbbemHn6qlTod1AN5/KiN8f+hW8fMgp/m0Xev9gsTHli9iUnY
	 I7/WqGMRv5gy8uZSHgUY2srTVuZfrvfN8HCvEt8GPxyb93zccfnQvrBjC2yIL4bgWX
	 PZZn/ixMg+NATF0cE+LcoSATRPuexYSSwNw4phh7BvNdj8w6pe+eF2t+3jMWMIwL8N
	 Lfn+KFMLLSzTaVPTJHbOdVWE27GCDaZNRmq/5cn62jWCIAf8kCJGgLvWqGX43UXyRr
	 OSB19hy3+4zew==
Date: Wed, 21 May 2025 15:49:17 -0700
Subject: [PATCH 2/2] fuse2fs: track our own writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679234.1385986.16343433714370514599.stgit@frogsfrogsfrogs>
In-Reply-To: <174786679193.1385986.6656255712144313017.stgit@frogsfrogsfrogs>
References: <174786679193.1385986.6656255712144313017.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Track our own willingness to write to the filesystem in a separate
variable from that of libext2fs.  There's a small window between opening
the filesystem and mounting it where the library is rw but we might fail
a mount task and therefore don't want to write anything more.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b68ae2d216d5d3..9667f00e366a66 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -164,6 +164,7 @@ struct fuse2fs {
 	uint8_t directio;
 	uint8_t acl;
 	uint8_t dirsync;
+	uint8_t writable;
 
 	int blocklog;
 	unsigned int blockmask;
@@ -434,8 +435,6 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
 
-	if (!(fs->flags & EXT2_FLAG_RW))
-		return 0;
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -545,9 +544,7 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 
 static int fs_writeable(struct fuse2fs *ff)
 {
-	ext2_filsys fs = ff->fs;
-
-	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
+	return ff->writable && (ff->fs->super->s_error_count == 0);
 }
 
 static inline int is_superuser(struct fuse2fs *ff, struct fuse_context *ctxt)
@@ -701,6 +698,7 @@ static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
 	errcode_t err;
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+	ff->writable = 0;
 
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
@@ -852,6 +850,7 @@ _("Mounting read-only without recovering journal."));
 			translate_error(fs, 0, err);
 			return err;
 		}
+		ff->writable = 1;
 	}
 
 	if (!(fs->super->s_state & EXT2_VALID_FS))
@@ -895,7 +894,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	fs = ff->fs;
 
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->writable) {
 		fs->super->s_state |= EXT2_VALID_FS;
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
@@ -1002,7 +1001,7 @@ static void *op_init(struct fuse_conn_info *conn
 	}
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->writable) {
 		fs->super->s_mnt_count++;
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
 		fs->super->s_state &= ~EXT2_VALID_FS;
@@ -3083,7 +3082,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	fsid ^= *f;
 	buf->f_fsid = fsid;
 	buf->f_flag = 0;
-	if (fs->flags & EXT2_FLAG_RW)
+	if (ff->writable)
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
 
@@ -5191,6 +5190,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 		err_printf(ff, "%s\n",
  _("Remounting read-only due to errors."));
 		fs->flags &= ~EXT2_FLAG_RW;
+		ff->writable = 0;
 		break;
 	case EXT2_ERRORS_PANIC:
 		err_printf(ff, "%s\n",


