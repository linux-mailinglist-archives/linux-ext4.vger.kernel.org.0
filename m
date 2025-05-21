Return-Path: <linux-ext4+bounces-8093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E4ABFFB2
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B427A1667
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC44237707;
	Wed, 21 May 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxDu+lbk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28721754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867114; cv=none; b=M4TB+9uXzeMrLkQei4JmIPLPx5lVtKEigVj/Vup7M1yvA+Uqz3z5rhicFjhDcouQFbyIrC4ZLga5ILfgo2Lxauarkz2gDDzcWWI5lDyucliM5c7hELix1+iEoBQn0t2aqprGw3NQE8i6s/s5AGGeNPXe6eVGeLso1obV/m2h5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867114; c=relaxed/simple;
	bh=6jN4N1g8u7LzpYXQhukccXiJe1RAdebXcrOhOH691C4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvXehyYrORWtmv7j+Pp8yRgon9fPRIzhDDkXbFQ0DlCQCD6QdKu0ttgN/FnahrXpz3rLoGL3hHIQe13GfZn6SxL/Ye6f8UT4e1jfJJVxMaZ0J2p8gTJUgBHOjb8nkRKVJo7MQPkpFzHwvAQu/sVCbHL8fHy7Hlqrw2+Xh0iNCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxDu+lbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A70C4CEE4;
	Wed, 21 May 2025 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867114;
	bh=6jN4N1g8u7LzpYXQhukccXiJe1RAdebXcrOhOH691C4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TxDu+lbkADWQVtsOf2DA1TbWc0oQsi9eEz13MhADABPdki7q76rlz/zPxMFjnsS8P
	 q7m2thyZZrbEx5Tdgv7YA517iyt1/Bxde2DOnbHHd3zRA/wfMfk7BtnoyzgPsyli1B
	 v6H7INHqkkigXpimCUrq6giaU2OYPivZanzFA5EWPkLH2rrjlh8RY3smjtB0cqqv1/
	 WcMC00qzSX6lcrlP7R8M6cPeLrGZI/g3insXlPaanBY6ruK4izjzW/JKik49SSoUlP
	 KVaFCCD4LvwnU2YbOuPF/AsSBoW9JFGhLa3O+ecVupIPAKK1TacuO/O8zwYhe9SoY0
	 tXohiMEvBdq8w==
Date: Wed, 21 May 2025 15:38:34 -0700
Subject: [PATCH 14/29] fuse2fs: rearrange check_inum_access parameters a bit
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677801.1383760.3807372754743381596.stgit@frogsfrogsfrogs>
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

Pass the struct fuse2fs pointer to check_inum_access so that we can do
some more rearranging in the next patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9e7d8b8fe5118d..eb1ac818359c19 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -507,10 +507,10 @@ static inline int want_check_owner(struct fuse2fs *ff,
 	return !is_superuser(ff, ctxt);
 }
 
-static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
+static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 {
 	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	ext2_filsys fs = ff->fs;
 	struct ext2_inode inode;
 	mode_t perms;
 	errcode_t err;
@@ -871,7 +871,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, parent, W_OK);
+	ret = check_inum_access(ff, parent, W_OK);
 	if (ret)
 		goto out2;
 
@@ -1002,7 +1002,7 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, parent, W_OK);
+	ret = check_inum_access(ff, parent, W_OK);
 	if (ret)
 		goto out2;
 
@@ -1123,7 +1123,7 @@ static int unlink_file_by_name(struct fuse2fs *ff, const char *path)
 		base_name = filename;
 	}
 
-	ret = check_inum_access(fs, dir, W_OK);
+	ret = check_inum_access(ff, dir, W_OK);
 	if (ret) {
 		free(filename);
 		return ret;
@@ -1387,7 +1387,7 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, parent, W_OK);
+	ret = check_inum_access(ff, parent, W_OK);
 	if (ret)
 		goto out2;
 
@@ -1560,7 +1560,7 @@ static int op_rename(const char *from, const char *to
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, from_dir_ino, W_OK);
+	ret = check_inum_access(ff, from_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -1585,7 +1585,7 @@ static int op_rename(const char *from, const char *to
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, to_dir_ino, W_OK);
+	ret = check_inum_access(ff, to_dir_ino, W_OK);
 	if (ret)
 		goto out2;
 
@@ -1752,7 +1752,7 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, parent, W_OK);
+	ret = check_inum_access(ff, parent, W_OK);
 	if (ret)
 		goto out2;
 
@@ -2000,7 +2000,7 @@ static int op_truncate(const char *path, off_t len
 	}
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, len);
 
-	ret = check_inum_access(fs, ino, W_OK);
+	ret = check_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -2075,7 +2075,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
 
-	ret = check_inum_access(fs, file->ino, check);
+	ret = check_inum_access(ff, file->ino, check);
 	if (ret) {
 		/*
 		 * In a regular (Linux) fs driver, the kernel will open
@@ -2087,7 +2087,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		 * also employ undocumented hacks (see above).
 		 */
 		if (check == R_OK) {
-			ret = check_inum_access(fs, file->ino, X_OK);
+			ret = check_inum_access(ff, file->ino, X_OK);
 			if (ret)
 				goto out;
 		} else
@@ -2384,7 +2384,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(fs, ino, R_OK);
+	ret = check_inum_access(ff, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -2474,7 +2474,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
-	ret = check_inum_access(fs, ino, R_OK);
+	ret = check_inum_access(ff, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -2554,7 +2554,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(fs, ino, W_OK);
+	ret = check_inum_access(ff, ino, W_OK);
 	if (ret == -EACCES) {
 		ret = -EPERM;
 		goto out;
@@ -2647,7 +2647,7 @@ static int op_removexattr(const char *path, const char *key)
 	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = check_inum_access(fs, ino, W_OK);
+	ret = check_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -2820,7 +2820,7 @@ static int op_access(const char *path, int mask)
 		goto out;
 	}
 
-	ret = check_inum_access(fs, ino, mask);
+	ret = check_inum_access(ff, ino, mask);
 	if (ret)
 		goto out;
 
@@ -2872,7 +2872,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	ret = check_inum_access(fs, parent, W_OK);
+	ret = check_inum_access(ff, parent, W_OK);
 	if (ret)
 		goto out2;
 
@@ -3059,7 +3059,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,
 			(long long int)ctv[1].tv_sec, ctv[1].tv_nsec);
 
-	ret = check_inum_access(fs, ino, W_OK);
+	ret = check_inum_access(ff, ino, W_OK);
 	if (ret)
 		goto out;
 


