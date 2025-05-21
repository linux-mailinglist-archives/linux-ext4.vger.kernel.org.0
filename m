Return-Path: <linux-ext4+bounces-8099-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B9ABFFC8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF764E4DB7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB762239E94;
	Wed, 21 May 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoFmOnQ0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBB239E87
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867209; cv=none; b=kmpzgmQAM8Jl2Kv76Ma7c/erEUpYYcSfsEF0hjAbQyfH2fMudW9YyAsqi9mkPPCLhn4LaK+6SUW5Txq2rCS/gZR3owXkKQAUVEbNJeA+AQpVfl1/ZA4p7nRzzorH688VwhDBR7PXgdMBA7ikhHd/SUkL4fB4Bbm69yRfUlTgzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867209; c=relaxed/simple;
	bh=8T0zCvonvtTLhN3jw2P0WAZMx7Z9y4pgpi7cPlLzZDc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bo8sYUDfDQqhIH3Q46Mq69lZD/3k58sAseEOewmYuBTqu14vV7bINuUFRIlrgxa+oWZKrJDSYa9fC7c1qfI09Y39aX5tjCVNuaGqjjZ5LV4gG4B4zADS+qSUkeP7lIXErQ2+1opZoOxgKBo7LMfUwIk11rlrbez7QgVKyMmAzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoFmOnQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E5EC4CEE4;
	Wed, 21 May 2025 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867208;
	bh=8T0zCvonvtTLhN3jw2P0WAZMx7Z9y4pgpi7cPlLzZDc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DoFmOnQ0607tNSR/29RnSl/CjdwvASSSiBBJq8CWKpRiV4A/QKX9QdHfsp+AQawQS
	 c9czEgVoPMzsC3wSVWON4/64NBv0cnJY7fiSUikDqmTHxfrpIxeYJ9ixj27VdoFm6i
	 +OOq61Jkd1wYrXLyl2wDv+HTTHhhNp0YUTejUE9s589+C3jcTEKCN6RwyyuP3L/DDX
	 aZq5oVi72e4F8yzxlNblM7WGt7htoKdFUo8WfjoMrDSajfEi57iS9Ihabj8f9SeBMF
	 oQ6NcR9DiDwrbH/dsXa278M/Quuh0iZYPK1kLoqOIEp42FWY09ihn/gdj+APfz2eWn
	 h6TqTXvuuduFA==
Date: Wed, 21 May 2025 15:40:08 -0700
Subject: [PATCH 20/29] fuse2fs: implement O_APPEND correctly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677905.1383760.14021746902005874478.stgit@frogsfrogsfrogs>
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

Try to implement append-only files correctly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8567d2a8801bb6..52c24715fbc109 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -41,6 +41,7 @@
 #include <inttypes.h>
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
+#include "ext2fs/ext2fsP.h"
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 # define FUSE_PLATFORM_OPTS	""
 #else
@@ -507,20 +508,26 @@ static inline int want_check_owner(struct fuse2fs *ff,
 	return !is_superuser(ff, ctxt);
 }
 
+/* Test for append permission */
+#define A_OK	16
+
 static int check_iflags_access(struct fuse2fs *ff, ext2_ino_t ino,
 			       const struct ext2_inode *inode, int mask)
 {
 	ext2_filsys fs = ff->fs;
 
-	/* no writing to read-only or broken fs */
-	if ((mask & W_OK) && !fs_writeable(fs))
+	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
+
+	/* no writing or metadata changes to read-only or broken fs */
+	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
 		return -EROFS;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s iflags=0x%x\n",
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
 		   ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
+		   (mask & A_OK ? "a" : ""),
 		   inode->i_flags);
 
 	/* is immutable? */
@@ -528,6 +535,10 @@ static int check_iflags_access(struct fuse2fs *ff, ext2_ino_t ino,
 	    (inode->i_flags & EXT2_IMMUTABLE_FL))
 		return -EPERM;
 
+	/* is append-only? */
+	if ((inode->i_flags & EXT2_APPEND_FL) && (mask & W_OK) && !(mask & A_OK))
+		return -EPERM;
+
 	return 0;
 }
 
@@ -541,7 +552,7 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	int ret;
 
 	/* no writing to read-only or broken fs */
-	if ((mask & W_OK) && !fs_writeable(fs))
+	if ((mask & (W_OK | A_OK)) && !fs_writeable(fs))
 		return -EROFS;
 
 	err = ext2fs_read_inode(fs, ino, &inode);
@@ -549,11 +560,12 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 		return translate_error(fs, ino, err);
 	perms = inode.i_mode & 0777;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s perms=0%o iflags=0x%x "
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s perms=0%o iflags=0x%x "
 		   "fuid=%d fgid=%d uid=%d gid=%d\n", ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
+		   (mask & A_OK ? "a" : ""),
 		   perms, inode.i_flags,
 		   inode_uid(inode), inode_gid(inode),
 		   ctxt->uid, ctxt->gid);
@@ -898,7 +910,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, W_OK);
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1029,7 +1041,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, W_OK);
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1432,7 +1444,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, W_OK);
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -1807,7 +1819,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, W_OK);
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -2128,6 +2140,15 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		file->open_flags |= EXT2_FILE_WRITE;
 		break;
 	}
+	if (fp->flags & O_APPEND) {
+		/* the kernel doesn't allow truncation of an append-only file */
+		if (fp->flags & O_TRUNC) {
+			ret = -EPERM;
+			goto out;
+		}
+
+		check |= A_OK;
+	}
 
 	detect_linux_executable_open(fp->flags, &check, &file->open_flags);
 
@@ -2938,7 +2959,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = check_inum_access(ff, parent, W_OK);
+	ret = check_inum_access(ff, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
@@ -3110,6 +3131,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	errcode_t err;
 	ext2_ino_t ino;
 	struct ext2_inode_large inode;
+	int access = W_OK;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3125,7 +3147,13 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,
 			(long long int)ctv[1].tv_sec, ctv[1].tv_nsec);
 
-	ret = check_inum_access(ff, ino, W_OK);
+	/*
+	 * ext4 allows timestamp updates of append-only files but only if we're
+	 * setting to current time
+	 */
+	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
+		access |= A_OK;
+	ret = check_inum_access(ff, ino, access);
 	if (ret)
 		goto out;
 


