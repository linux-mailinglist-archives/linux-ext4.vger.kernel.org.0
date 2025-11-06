Return-Path: <linux-ext4+bounces-11627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D574C3DAD7
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA214E57A4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315F3074BE;
	Thu,  6 Nov 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDPTC0sa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2927CCEE
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469336; cv=none; b=JziQrl45r6p9db8iyJE6DVOHuLZZEnHVnFZ9fDsuLZRNHt2pQYs6/Xg2oegCuqMBPulP3vvRlle+i/I9HZkEv2ys6Vtp1fz49LdeiXgmKsdauOnmr+idcULhy+gmHbmAHyFbfpaobuXs/OYckFsWFZ5BNO92U8bdRlB3OY7CgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469336; c=relaxed/simple;
	bh=iAeSV78Dz+tC5KfPVY4aA4w5JopFPbULMcPmqoL+o4E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psakF5SZo141CZK0FcLZ3h65uDq1hh80HN1mSpBuO+qVsn8aQdAXvPcV7t/uLxa27f8c2n94XH+GmPWwFM5mvQGF0nA2Ee94jzBAvWHsBfbBODP75wI06BanL2K0hpljRwu0666LtH+r8zbPakbcD0BM1dMoV080K4qyUOSrbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDPTC0sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2BC113D0;
	Thu,  6 Nov 2025 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469336;
	bh=iAeSV78Dz+tC5KfPVY4aA4w5JopFPbULMcPmqoL+o4E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pDPTC0sa2keXS6zCGVPD22SxgvI5s77Rv/U5Q8MaBxcCpuiWBMdTtmX4s9WMqKH4C
	 7jUio2bU7gU8De1wk3uHJvO6HgwgI2/kpv8GtpyE2UGpnvssNl1VUCiyeE/66CrNbj
	 QR1zXYIUvPRUq5oeXfUFnkC93LQUqccPg/gfoIV0fmZIkvSPbFTb4mN03ItdDRDbYs
	 RZAiDSUCoRDHdFVX4EVX47mbgVVCwxVYsVapdhEzXKNnLdtgD8VKOwTGtRj30ZsSv4
	 q3jXLO0MoJcWCcyW9Avgj0aDfbkIrNuavLGNRmMp3KE4t13PzjOoAAgwlAMZbMHF+C
	 m37Nu2FqoxNfQ==
Date: Thu, 06 Nov 2025 14:48:55 -0800
Subject: [PATCH 22/23] fuse4fs: implement FUSE_TMPFILE
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795963.2864310.14373261478148361921.stgit@frogsfrogsfrogs>
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

Allow creation of O_TMPFILE files now that we know how to use the
unlinked list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   93 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 26 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index fdeef157e732d4..7db09ed93fdf1f 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1056,22 +1056,25 @@ static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
 
 /* Test for append permission */
 #define A_OK	16
+/* Test for linked file */
+#define L_OK	32
 
 static int fuse4fs_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
 				 const struct ext2_inode *inode, int mask)
 {
-	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
+	EXT2FS_BUILD_BUG_ON(((A_OK | L_OK) & (R_OK | W_OK | X_OK | F_OK)) != 0);
 
 	/* no writing or metadata changes to read-only or broken fs */
 	if ((mask & (W_OK | A_OK)) && !fuse4fs_is_writeable(ff))
 		return -EROFS;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s%s iflags=0x%x\n",
 		   ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
 		   (mask & A_OK ? "a" : ""),
+		   (mask & L_OK ? "l" : ""),
 		   inode->i_flags);
 
 	/* is immutable? */
@@ -1104,21 +1107,31 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		return translate_error(fs, ino, err);
 	perms = inode.i_mode & 0777;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s perms=0%o iflags=0x%x "
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s%s perms=0%o iflags=0x%x "
 		   "fuid=%d fgid=%d uid=%d gid=%d\n", ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
 		   (mask & A_OK ? "a" : ""),
+		   (mask & L_OK ? "l" : ""),
 		   perms, inode.i_flags,
 		   inode_uid(inode), inode_gid(inode),
 		   ctxt->uid, ctxt->gid);
 
-	/* linked files cannot be on the unlinked list or deleted */
-	if (inode.i_dtime != 0) {
-		dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
-			   __func__, ino, inode.i_dtime);
-		return -ENOENT;
+	if (mask & L_OK) {
+		/* linked files cannot be on the unlinked list or deleted */
+		if (inode.i_dtime != 0) {
+			dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
+				   __func__, ino, inode.i_dtime);
+			return -ENOENT;
+		}
+	} else {
+		/* unlinked files cannot be deleted */
+		if (inode.i_dtime >= fs->super->s_inodes_count) {
+			dbg_printf(ff, "%s: deleted ino=%d dtime=0x%x\n",
+				   __func__, ino, inode.i_dtime);
+			return -ENOENT;
+		}
 	}
 
 	/* existence check */
@@ -3445,7 +3458,7 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino,
+			     ext2_ino_t ino, bool linked,
 			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
@@ -3475,6 +3488,9 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		break;
 	}
 
+	if (linked)
+		check |= L_OK;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.
@@ -3543,7 +3559,7 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
 	fuse4fs_start(ff);
-	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
+	ret = fuse4fs_open_file(ff, ctxt, ino, true, fp);
 	fuse4fs_finish(ff, ret);
 
 	if (ret)
@@ -4452,22 +4468,28 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	dbg_printf(ff, "%s: creating dir=%d name='%s' child=%d\n",
-		   __func__, parent, name, child);
-	err = ext2fs_link(fs, parent, name, child,
-			  filetype | EXT2FS_LINK_EXPAND);
-	if (err) {
-		ret = translate_error(fs, parent, err);
-		goto out2;
+	if (name) {
+		dbg_printf(ff, "%s: creating dir=%d name='%s' child=%d\n",
+			   __func__, parent, name, child);
+
+		err = ext2fs_link(fs, parent, name, child,
+				  filetype | EXT2FS_LINK_EXPAND);
+		if (err) {
+			ret = translate_error(fs, parent, err);
+			goto out2;
+		}
+
+		ret = update_mtime(fs, parent, NULL);
+		if (ret)
+			goto out2;
+	} else {
+		dbg_printf(ff, "%s: creating dir=%d tempfile=%d\n",
+			   __func__, parent, child);
 	}
 
-	ret = update_mtime(fs, parent, NULL);
-	if (ret)
-		goto out2;
-
 	memset(&inode, 0, sizeof(inode));
 	inode.i_mode = mode;
-	inode.i_links_count = 1;
+	inode.i_links_count = name ? 1 : 0;
 	fuse4fs_set_extra_isize(ff, child, &inode);
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
@@ -4485,6 +4507,12 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		ext2fs_extent_free(handle);
 	}
 
+	if (!name) {
+		ret = fuse4fs_add_to_orphans(ff, child, &inode);
+		if (ret)
+			goto out2;
+	}
+
 	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4506,13 +4534,15 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 
 	fp->flags &= ~O_TRUNC;
-	ret = fuse4fs_open_file(ff, ctxt, child, fp);
+	ret = fuse4fs_open_file(ff, ctxt, child, name != NULL, fp);
 	if (ret)
 		goto out2;
 
-	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
-	if (ret)
-		goto out2;
+	if (name) {
+		ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+		if (ret)
+			goto out2;
+	}
 
 	ret = fuse4fs_stat_inode(ff, child, NULL, &fstat);
 	if (ret)
@@ -4527,6 +4557,14 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		fuse_reply_create(req, &fstat.entry, fp);
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+static void op_tmpfile(fuse_req_t req, fuse_ino_t fino, mode_t mode,
+		       struct fuse_file_info *fp)
+{
+	op_create(req, fino, NULL, mode, fp);
+}
+#endif
+
 enum fuse4fs_time_action {
 	TA_NOW,		/* set to current time */
 	TA_OMIT,	/* do not set timestamp */
@@ -5521,6 +5559,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	.tmpfile = op_tmpfile,
+#endif
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,


