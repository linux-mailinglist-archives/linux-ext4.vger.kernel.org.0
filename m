Return-Path: <linux-ext4+bounces-11599-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCDC3DA4F
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A53234ED23
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC92E92C3;
	Thu,  6 Nov 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2gTJWf2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F92F6180
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468904; cv=none; b=vBvFF182dLkI7pt/Vg9ciuRj3SrwN/Yiok8sTnVctTiTbVCH48X/9mCFabRA6bTzyUGvSQKA8fccWTAX0HrTX8sAWUyUzuq2YKONlDK2v1Who9w1uwwe/PejBlSwUyGbxvWJOBNBpZI+jI/sJ4RoEAK6FMWfxqlLAZzMrlgcbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468904; c=relaxed/simple;
	bh=bSS72xlUsHwqHxnUgVjRhdUNlSZKH+rRciNrHOL0GlM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaYcAxMUCltCmCvVZQDZ4+ji70oN+Dp/uqPrDSbcp+nuLZvoLy195kwiNt5sO4E8zZs87ZcHx5X0ciqwTyM4Yo/SXevLDErfR8VjZTeBfbLO14iRbAhYDWw+lUQH+51CjbR92ie+O7mw9CuHKHt5pukCrI3LX2EHsJBRhrwuTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2gTJWf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145A4C16AAE;
	Thu,  6 Nov 2025 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468904;
	bh=bSS72xlUsHwqHxnUgVjRhdUNlSZKH+rRciNrHOL0GlM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f2gTJWf2pJ9lpElG4qgkvtFRTSXpy+95tcP87IQjthwecPiQaHb6jHg06zRV9eeRC
	 nASKA65aidTqw/g3HYab0OgVeibGEuDd5TFeA7IklKb+/cnsUrCulFqSxAw0Cg5387
	 iYDfsn0G/gWTaTvBDSMxyMSowf+AGy1CJFR9TNkpG0CGTOBNT5OHg8xdoriDpoC79m
	 krPKTOFBpsGkxLsRHVpLKsfSY79D1/C9uv3NtEwUNr9M/SJaFcGq3+tRKRsiEAJh3Q
	 KYbZJ1YIJWDTaJ7MuIYSC8FEtvD0hfw+JdqrqkKB96Fy+B2bblzT+7rSBD+8GoKFBY
	 5AOcwXs7KHyGg==
Date: Thu, 06 Nov 2025 14:41:43 -0800
Subject: [PATCH 2/3] fuse2fs: track our own writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795086.2863930.12714189998385617158.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
References: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1aa391b5a56456..8d5b705280b72f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -219,6 +219,11 @@ struct fuse2fs_file_handle {
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
@@ -242,6 +247,7 @@ struct fuse2fs {
 	int acl;
 	int dirsync;
 
+	enum fuse2fs_opstate opstate;
 	int logfd;
 	int blocklog;
 	int oom_score_adj;
@@ -553,7 +559,7 @@ static bool fuse2fs_mmp_wanted(const struct fuse2fs *ff)
 	ext2_filsys fs = ff->fs;
 
 	if (!fs || !ext2fs_has_feature_mmp(fs->super) ||
-	    !(fs->flags & EXT2_FLAG_RW) || (fs->flags & EXT2_FLAG_SKIP_MMP))
+	    ff->opstate != F2OP_WRITABLE || (fs->flags & EXT2_FLAG_SKIP_MMP))
 		return false;
 	return true;
 }
@@ -767,8 +773,6 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	struct timespec atime, mtime, now;
 	double datime, dmtime, dnow;
 
-	if (!(fs->flags & EXT2_FLAG_RW))
-		return 0;
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err)
 		return translate_error(fs, ino, err);
@@ -884,9 +888,8 @@ static int fs_can_allocate(struct fuse2fs *ff, blk64_t num)
 
 static int fuse2fs_is_writeable(struct fuse2fs *ff)
 {
-	ext2_filsys fs = ff->fs;
-
-	return (fs->flags & EXT2_FLAG_RW) && (fs->super->s_error_count == 0);
+	return ff->opstate == F2OP_WRITABLE &&
+		(ff->fs->super->s_error_count == 0);
 }
 
 static inline int is_superuser(struct fuse2fs *ff, struct fuse_context *ctxt)
@@ -1135,6 +1138,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	}
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+	ff->opstate = F2OP_READONLY;
 
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
@@ -1337,6 +1341,7 @@ static int fuse2fs_mount(struct fuse2fs *ff)
  _("Warning: fuse2fs does not support using the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
+		ff->opstate = F2OP_WRITABLE;
 	}
 
 	if (!(fs->super->s_state & EXT2_VALID_FS))
@@ -1359,7 +1364,7 @@ static int fuse2fs_mount(struct fuse2fs *ff)
 		ff->errors_behavior = fs->super->s_errors;
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->opstate == F2OP_WRITABLE) {
 		fs->super->s_mnt_count++;
 		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
 		fs->super->s_state &= ~EXT2_VALID_FS;
@@ -1383,7 +1388,7 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	fs = fuse2fs_start(ff);
 
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
-	if (fs->flags & EXT2_FLAG_RW) {
+	if (ff->opstate == F2OP_WRITABLE) {
 		fs->super->s_state |= EXT2_VALID_FS;
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
@@ -1574,7 +1579,7 @@ static void *op_init(struct fuse_conn_info *conn
 	cfg->nullpath_ok = 1;
 #endif
 
-	if (ff->fs->flags & EXT2_FLAG_RW)
+	if (ff->opstate == F2OP_WRITABLE)
 		fuse2fs_read_bitmaps(ff);
 
 	/*
@@ -3724,7 +3729,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	fsid ^= *f;
 	buf->f_fsid = fsid;
 	buf->f_flag = 0;
-	if (!(fs->flags & EXT2_FLAG_RW))
+	if (ff->opstate != F2OP_WRITABLE)
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
 	fuse2fs_finish(ff, 0);
@@ -5568,6 +5573,7 @@ int main(int argc, char *argv[])
 		.logfd = -1,
 		.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER,
 		.oom_score_adj = -500,
+		.opstate = F2OP_WRITABLE,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
@@ -5861,9 +5867,11 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
  _("Continuing after errors; is this a good idea?"));
 		break;
 	case EXT2_ERRORS_RO:
-		if (fs->flags & EXT2_FLAG_RW)
+		if (ff->opstate == F2OP_WRITABLE) {
 			err_printf(ff, "%s\n",
  _("Remounting read-only due to errors."));
+			ff->opstate = F2OP_READONLY;
+		}
 		fuse2fs_mmp_cancel(ff);
 		fs->flags &= ~EXT2_FLAG_RW;
 		break;


