Return-Path: <linux-ext4+bounces-10105-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15DB588D1
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3988E4E1838
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B894A00;
	Tue, 16 Sep 2025 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5Rr6eHn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43D22615
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981121; cv=none; b=JWWJYUpmojaJoiXZmSFSbmZVAJMrG9WB55MrvQnabwoDITgyenq96kFRmOEWuyDACgfArShiCIcN/s12QKhTgSJzN2nF/dKKHVsPeZY5+RHU5FY3+3s2Cie/rJVSUt2VTC7YneV+POxScI65PZPc6q0Lh41HykcQnN4L+FMdkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981121; c=relaxed/simple;
	bh=cbirfAA8JrdCVDI9a4KYaWkU5sj5nodeVDSZU5ACA5o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmGGgu3pS3UFKnbwd93dlkuB64q+k3HcH+3/I5ZThXxcJZQRF/AOQ8LtM1ChW9/5A2HKEzwGyAxfv4tdLmpH6YzJIpOzgrDEBGqsNGR1Hly6d71Nekrsgq8cQ9DpWds2Hp0umPMG1jovIXyfX9LKJwufiwpfjzQRBWvs3qLRC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5Rr6eHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ACDC4CEF1;
	Tue, 16 Sep 2025 00:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981120;
	bh=cbirfAA8JrdCVDI9a4KYaWkU5sj5nodeVDSZU5ACA5o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t5Rr6eHnaw0+LfN787kmeLQop0+JBc2ATRKuSxSGO+bpz+5w1T5/fds0QbqYsBKDF
	 +u1DNlcL9H7wYWTShoT9o79RLxcOkBKcs1HkS2NHepb6qgtcZiZi6qf+yQvSQY5wWW
	 kvtE0EtFmW6XNq3mufSW7WrTqon9GaDzdggYkyMRrJ9mDv7y3QNBcDN7aI+iUiXwRE
	 YajugN3z0GFUsl7Wm1u8p2Gk204mQQMc4sbLtvq0X6uw10vdcJjXFGhRYHzDsVj4BV
	 2ERJrk9/DIHQIAiesUwPcLxC0QyFpqtIN3XCPR3N7CArA9Cn3iXMKmKh7Vbg3qH3DL
	 h8nRG6TGBU0cA==
Date: Mon, 15 Sep 2025 17:05:20 -0700
Subject: [PATCH 2/3] fuse2fs: track our own writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065192.350393.12399832147314031434.stgit@frogsfrogsfrogs>
In-Reply-To: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
References: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index dd731d84c4535f..80d1c79b5cce1c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -218,6 +218,11 @@ struct fuse2fs_file_handle {
 	int check_flags;
 };
 
+enum fuse2fs_opstate {
+	F2OP_READONLY,
+	F2OP_WRITABLE,
+};
+
 /* Main program context */
 #define FUSE2FS_MAGIC		(0xEF53DEADUL)
 struct fuse2fs {
@@ -243,6 +248,7 @@ struct fuse2fs {
 	int unmount_in_destroy;
 	int noblkdev;
 
+	enum fuse2fs_opstate opstate;
 	int logfd;
 	int blocklog;
 	unsigned int blockmask;
@@ -611,8 +617,6 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	struct timespec atime, mtime, now;
 	double datime, dmtime, dnow;
 
-	if (!(fs->flags & EXT2_FLAG_RW))
-		return 0;
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -728,9 +732,8 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 
 static int fuse2fs_is_writeable(struct fuse2fs *ff)
 {
-	ext2_filsys fs = ff->fs;
-
-	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
+	return ff->opstate == F2OP_WRITABLE &&
+		(ff->fs->super->s_error_count == 0);
 }
 
 static inline int is_superuser(struct fuse2fs *ff, struct fuse_context *ctxt)
@@ -946,6 +949,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 	}
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+	ff->opstate = F2OP_READONLY;
 
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
@@ -1083,6 +1087,7 @@ static int fuse2fs_mount(struct fuse2fs *ff)
  _("Warning: fuse2fs does not support using the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
+		ff->opstate = F2OP_WRITABLE;
 	}
 
 	if (!(fs->super->s_state & EXT2_VALID_FS))
@@ -1105,7 +1110,7 @@ static int fuse2fs_mount(struct fuse2fs *ff)
 		ff->errors_behavior = fs->super->s_errors;
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->opstate == F2OP_WRITABLE) {
 		fs->super->s_mnt_count++;
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
 		fs->super->s_state &= ~EXT2_VALID_FS;
@@ -1129,7 +1134,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	fs = fuse2fs_start(ff);
 
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->opstate == F2OP_WRITABLE) {
 		fs->super->s_state |= EXT2_VALID_FS;
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
@@ -1337,7 +1342,7 @@ static void *op_init(struct fuse_conn_info *conn
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
-	if (ff->fs->flags & EXT2_FLAG_RW)
+	if (ff->opstate == F2OP_WRITABLE)
 		fuse2fs_read_bitmaps(ff);
 
 	return ff;
@@ -3427,7 +3432,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	fsid ^= *f;
 	buf->f_fsid = fsid;
 	buf->f_flag = 0;
-	if (!(fs->flags & EXT2_FLAG_RW))
+	if (ff->opstate != F2OP_WRITABLE)
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
 	fuse2fs_finish(ff, 0);
@@ -5218,6 +5223,7 @@ int main(int argc, char *argv[])
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
 	fctx.logfd = -1;
+	fctx.opstate = F2OP_WRITABLE;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
 	if (ret)
@@ -5600,9 +5606,11 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
  _("Continuing after errors; is this a good idea?"));
 		break;
 	case EXT2_ERRORS_RO:
-		if (fs->flags & EXT2_FLAG_RW)
+		if (ff->opstate == F2OP_WRITABLE) {
 			err_printf(ff, "%s\n",
  _("Remounting read-only due to errors."));
+			ff->opstate = F2OP_READONLY;
+		}
 		fs->flags &= ~EXT2_FLAG_RW;
 		break;
 	case EXT2_ERRORS_PANIC:


