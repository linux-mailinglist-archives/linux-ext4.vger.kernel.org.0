Return-Path: <linux-ext4+bounces-11626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAABC3DAD4
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3077F3B2A42
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4B2D97A6;
	Thu,  6 Nov 2025 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXPuzyZe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABF2F8BC8
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469320; cv=none; b=YwRUoKThaMGVqCD1BHx25c3qtNIS6eDlLGrBhwHtsx4RqS0Z3oVia+5j49cRN0SFzcRlT6r9pP1E4/j5goMm/LxIyJf47vm4vZDw972D5DzONOK9KhgYV8z76whrOaQfNcAB+fmf06rjNDsYo5///qWRu7709QUSrGwfC89xSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469320; c=relaxed/simple;
	bh=Uo8eVMBEY5JYJjwLc8Ykxg+xsUIDHcwzNIPffkSfmKE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gz9nxlAIzvWEcjj2ysFyzV9wanGWIaqQpGfPffh7u3KsnXIRirUZHTZbIoKuv6FXlX/wWydkBXlxW+fcnwlVpCmkDXmPTIyxX1DyCMWixa4ESl2YcWE2L0bhu9Ugwk2s8JudxlxC2vPi//fAL1cmuB8cxs46irGGRM2dz8CqwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXPuzyZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB3C116D0;
	Thu,  6 Nov 2025 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469320;
	bh=Uo8eVMBEY5JYJjwLc8Ykxg+xsUIDHcwzNIPffkSfmKE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OXPuzyZeirUnxL2NLuW5eKMNMsOhPRVHo2XHQ9tgzv42hbo+/dG9Jd1RSOVhJhOG6
	 Z8sC4E+SoBKmnbTaiL/kxj1JR1C+w/3XKc3so9GxBQpzIizFFefFv1Ad4B/7GGIhJs
	 ro0fUrF5BR6RV+mVB+EfQ26var9G1XIrqoLFhm0Efkiv5dliOjsivsUWumlwwmjAO1
	 5Pdwz4TxwvytQux4gnvywaDaf3lv+X1LKDnI+hR1wAOy7rJHRemIf+1pjDaIdgwjXC
	 sh1WfAurd+EVeBKiBSY+eVJPz31c0H5GNZSnMyyZL1OJM7+i/2LO6Wx8Paeb6lK/pJ
	 IKYx1owsSDiFQ==
Date: Thu, 06 Nov 2025 14:48:39 -0800
Subject: [PATCH 21/23] fuse4fs: use the orphaned inode list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795944.2864310.17677196080568451644.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Put open but unlinked files on the orphan list, and remove them when the
last open fd releases the inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  183 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 5 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 038d6126dbfde1..fdeef157e732d4 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1114,6 +1114,13 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		   inode_uid(inode), inode_gid(inode),
 		   ctxt->uid, ctxt->gid);
 
+	/* linked files cannot be on the unlinked list or deleted */
+	if (inode.i_dtime != 0) {
+		dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
+			   __func__, ino, inode.i_dtime);
+		return -ENOENT;
+	}
+
 	/* existence check */
 	if (mask == 0)
 		return 0;
@@ -2404,9 +2411,80 @@ static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+				  struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+
+	dbg_printf(ff, "%s: orphan ino=%d dtime=%d next=%d\n",
+		   __func__, ino, inode->i_dtime, fs->super->s_last_orphan);
+
+	inode->i_dtime = fs->super->s_last_orphan;
+	fs->super->s_last_orphan = ino;
+	ext2fs_mark_super_dirty(fs);
+
+	return 0;
+}
+
+static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+				       struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	ext2_ino_t prev_orphan;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: super=%d ino=%d next=%d\n",
+		   __func__, fs->super->s_last_orphan, ino, inode->i_dtime);
+
+	/* If we're lucky, the ondisk superblock points to us */
+	if (fs->super->s_last_orphan == ino) {
+		dbg_printf(ff, "%s: superblock\n", __func__);
+
+		fs->super->s_last_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+		ext2fs_mark_super_dirty(fs);
+		return 0;
+	}
+
+	/* Otherwise walk the ondisk orphan list. */
+	prev_orphan = fs->super->s_last_orphan;
+	while (prev_orphan != 0) {
+		struct ext2_inode_large orphan;
+
+		err = fuse4fs_read_inode(fs, prev_orphan, &orphan);
+		if (err)
+			return translate_error(fs, prev_orphan, err);
+
+		if (orphan.i_dtime == prev_orphan)
+			return translate_error(fs, prev_orphan,
+					       EXT2_ET_FILESYSTEM_CORRUPTED);
+
+		if (orphan.i_dtime == ino) {
+			dbg_printf(ff, "%s: prev=%d\n",
+				   __func__, prev_orphan);
+
+			orphan.i_dtime = inode->i_dtime;
+			inode->i_dtime = 0;
+
+			err = fuse4fs_write_inode(fs, prev_orphan, &orphan);
+			if (err)
+				return translate_error(fs, prev_orphan, err);
+
+			return 0;
+		}
+
+		dbg_printf(ff, "%s: orphan=%d next=%d\n",
+			   __func__, prev_orphan, orphan.i_dtime);
+		prev_orphan = orphan.i_dtime;
+	}
+
+	return translate_error(fs, ino, EXT2_ET_FILESYSTEM_CORRUPTED);
+}
+
 static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 {
 	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	int ret = 0;
@@ -2428,7 +2506,6 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		if (!ext2fs_dir_link_empty(EXT2_INODE(&inode)))
 			return translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
 		inode.i_links_count = 0;
-		ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	} else {
 		/*
 		 * Any other file type can be hardlinked, so all we need to do
@@ -2437,8 +2514,6 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		if (inode.i_links_count == 0)
 			return translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
 		inode.i_links_count--;
-		if (!inode.i_links_count)
-			ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	}
 
 	ret = update_ctime(fs, ino, &inode);
@@ -2449,6 +2524,26 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	dbg_printf(ff, "%s: put ino=%d opencount=%d\n", __func__, ino,
+		   fi->i_open_count);
+
+	/*
+	 * The file is unlinked but still open; add it to the orphan list and
+	 * free it later.
+	 */
+	if (fi->i_open_count > 0) {
+		fuse4fs_iput(ff, fi);
+		ret = fuse4fs_add_to_orphans(ff, ino, &inode);
+		if (ret)
+			return ret;
+
+		goto write_out;
+	}
+	fuse4fs_iput(ff, fi);
 
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
@@ -2468,6 +2563,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 			return translate_error(fs, ino, err);
 	}
 
+	ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	ext2fs_inode_alloc_stats2(fs, ino, -1,
 				  LINUX_S_ISDIR(inode.i_mode));
 
@@ -3056,6 +3152,16 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 		goto out2;
 	}
 
+	/*
+	 * Linking a file back into the filesystem requires removing it from
+	 * the orphan list.
+	 */
+	if (inode.i_links_count == 0) {
+		ret = fuse4fs_remove_from_orphans(ff, child, &inode);
+		if (ret)
+			goto out2;
+	}
+
 	ext2fs_inc_nlink(fs, EXT2_INODE(&inode));
 	ret = update_ctime(fs, child, &inode);
 	if (ret)
@@ -3339,7 +3445,8 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino, struct fuse_file_info *fp)
+			     ext2_ino_t ino,
+			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -3415,6 +3522,8 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	file->check_flags = check;
 	fuse4fs_set_handle(fp, file);
+	dbg_printf(ff, "%s: ino=%d fh=%p opencount=%d\n", __func__, ino, file,
+		   file->fi->i_open_count);
 
 out:
 	if (ret)
@@ -3431,6 +3540,8 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+
 	fuse4fs_start(ff);
 	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
 	fuse4fs_finish(ff, ret);
@@ -3579,6 +3690,55 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		fuse_reply_err(req, -ret);
 }
 
+static int fuse4fs_free_unlinked(struct fuse4fs *ff, ext2_ino_t ino)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	if (inode.i_links_count > 0)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%d links=%d\n", __func__, ino,
+		   inode.i_links_count);
+
+	if (ext2fs_has_feature_ea_inode(fs->super)) {
+		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
+		if (ret)
+			return ret;
+	}
+
+	/* Nobody holds this file; free its blocks! */
+	err = ext2fs_free_ext_attr(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	if (ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode))) {
+		err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), NULL,
+				   0, ~0ULL);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	ret = fuse4fs_remove_from_orphans(ff, ino, &inode);
+	if (ret)
+		return ret;
+
+	ext2fs_set_dtime(fs, EXT2_INODE(&inode));
+	ext2fs_inode_alloc_stats2(fs, ino, -1, LINUX_S_ISDIR(inode.i_mode));
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		       struct fuse_file_info *fp)
 {
@@ -3590,9 +3750,21 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CHECK_HANDLE(req, fh);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	dbg_printf(ff, "%s: ino=%d fh=%p opencount=%u\n",
+		   __func__, fh->ino, fh, fh->fi->i_open_count);
+
 	fs = fuse4fs_start(ff);
 
+	/*
+	 * If the file is no longer open and is unlinked, free it, which
+	 * removes it from the ondisk list.
+	 */
+	if (--fh->fi->i_open_count == 0) {
+		ret = fuse4fs_free_unlinked(ff, fh->ino);
+		if (ret)
+			goto out_iput;
+	}
+
 	if ((fp->flags & O_SYNC) &&
 	    fuse4fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
@@ -3601,6 +3773,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+out_iput:
 	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);


