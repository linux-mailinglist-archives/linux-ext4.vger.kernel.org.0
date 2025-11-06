Return-Path: <linux-ext4+bounces-11576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD4C3D9F8
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E7774E641D
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78233890E;
	Thu,  6 Nov 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6aRR/Hn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12923376A5
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468536; cv=none; b=P7qdUatt+dDvSVbRNQvTP2lur6ZptfaFQGL+7c2PBN3gz/vjHcXc85To4ox1Zft6GUp1FN1u7ZBYgUSBT90biwtZAM713JBltz3ZrvyACapErKX9QHLW0ToBkNI08VS9nn4J44va5SNkhiuPW4A1P21EBJw/4s//sD1o8HDiiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468536; c=relaxed/simple;
	bh=oHKqH1tGAcU180GkeFMmUXq5wZC/BQmHLIZB/OgWZ5E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZP/gphCbP3BfLjoI8yxzz/5dwDIb+m+ghZ+MRcp7AAX7RZq2f1wTgKIPYQFCCHRYWSaE0m6u4/l/Y2q6mKOyCaBlzYImSnEzqCJ5m1hfn3MnmtgljV4g2Glo7tyyKbH5t0rhlMLzIJRYafG2DJy7KEb1FhBLjNpW+VpjfnicUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6aRR/Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FD8C113D0;
	Thu,  6 Nov 2025 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468536;
	bh=oHKqH1tGAcU180GkeFMmUXq5wZC/BQmHLIZB/OgWZ5E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S6aRR/HnUwt+H0lHSh8sc026xISPef+s35BVs9QuHQnw5uxu9xFqEwTwwdS8cnyBp
	 WQCK18PJ8X9qox+dPBlOJ3Eymei6wtucOieTvcxmriKB1mhQBYk2r/u1YXIvHsKxpf
	 sLYc6p8VQV6SN3jacpWGKBBQeLDCFxsS3gCSd7+qq3u2AsQvB0DEc5pJm2T9+ZUowF
	 tQ5D0Eu3iySGAjeMxUY+itjtvP3Eejp5eN8pcuC1C7kuc2xpfusE4+8YapzZOZgjT9
	 EepkzxTXoNzS8nQHo1KIHOw9h/sn1piNFoWqZj79EN3dt4ziSomcQSoQn+4n/FM5/8
	 afBSM9rBVZNXg==
Date: Thu, 06 Nov 2025 14:35:35 -0800
Subject: [PATCH 17/19] fuse2fs: fix link count overflows on dir_nlink
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793936.2862242.4057006934868513614.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

On a dir_nlink filesystem, a dir with more than 65000 subdirs ends up
with i_links_count (aka nlink) of 1.  libext2fs wraps around and does
the wrong thing, which may have caused a lot of havoc over the years.
The kernel actually knows how to do this properly (it freezes the link
count at 1 when it would overflow) so use the helpers we added in the
previous patch to make fuse2fs behave the same as the kernel.

This is a convenient time to fix the annoying behavior that one has to
call remove_inode twice to rmdir a directory, and actually check for
link count overflows when renaming or hardlinking files.

Found via ext4/045.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   85 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 16 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fd21f546db7fb1..b1cac46ddce567 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1798,21 +1798,34 @@ static int remove_inode(struct fuse2fs *ff, ext2_ino_t ino)
 	dbg_printf(ff, "%s: put ino=%d links=%d\n", __func__, ino,
 		   inode.i_links_count);
 
-	switch (inode.i_links_count) {
-	case 0:
-		return 0; /* XXX: already done? */
-	case 1:
-		inode.i_links_count--;
+	if (S_ISDIR(inode.i_mode)) {
+		/*
+		 * Caller should have checked that this is an empty directory
+		 * before starting the unlink process.  nlink is usually 2, but
+		 * it could be 1 if this dir ever had more than 65000 subdirs.
+		 * Zero the link count.
+		 */
+		if (!ext2fs_dir_link_empty(EXT2_INODE(&inode)))
+			return translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
+		inode.i_links_count = 0;
 		ext2fs_set_dtime(fs, EXT2_INODE(&inode));
-		break;
-	default:
+	} else {
+		/*
+		 * Any other file type can be hardlinked, so all we need to do
+		 * is decrement the nlink.
+		 */
+		if (inode.i_links_count == 0)
+			return translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
 		inode.i_links_count--;
+		if (!inode.i_links_count)
+			ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	}
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
 		return ret;
 
+	/* Still linked?  Leave it be. */
 	if (inode.i_links_count)
 		goto write_out;
 
@@ -1964,10 +1977,6 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 	}
 
 	ret = fuse2fs_unlink(ff, path, &parent);
-	if (ret)
-		goto out;
-	/* Directories have to be "removed" twice. */
-	ret = remove_inode(ff, child);
 	if (ret)
 		goto out;
 	ret = remove_inode(ff, child);
@@ -1982,8 +1991,7 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 			ret = translate_error(fs, rds.parent, err);
 			goto out;
 		}
-		if (inode.i_links_count > 1)
-			inode.i_links_count--;
+		ext2fs_dec_nlink(EXT2_INODE(&inode));
 		ret = update_mtime(fs, rds.parent, &inode);
 		if (ret)
 			goto out;
@@ -2149,6 +2157,41 @@ static int update_dotdot_helper(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	return 0;
 }
 
+/*
+ * If we're moving a directory, make sure that the new parent of that directory
+ * can handle the nlink bump.
+ */
+static int fuse2fs_check_from_dir_nlink(struct fuse2fs *ff, ext2_ino_t from_ino,
+					ext2_ino_t to_ino,
+					ext2_ino_t from_dir_ino,
+					ext2_ino_t to_dir_ino)
+{
+	struct ext2_inode_large inode;
+	errcode_t err;
+
+	err = fuse2fs_read_inode(ff->fs, from_ino, &inode);
+	if (err)
+		return translate_error(ff->fs, from_ino, err);
+
+	if (!S_ISDIR(inode.i_mode))
+		return 0;
+
+	if (to_ino != 0)
+		return 0;
+
+	if (to_dir_ino == from_dir_ino)
+		return 0;
+
+	err = fuse2fs_read_inode(ff->fs, to_dir_ino, &inode);
+	if (err)
+		return translate_error(ff->fs, from_ino, err);
+
+	if (ext2fs_dir_link_max(ff->fs, &inode))
+		return -EMLINK;
+
+	return 0;
+}
+
 static int op_rename(const char *from, const char *to
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, unsigned int flags EXT2FS_ATTR((unused))
@@ -2275,6 +2318,11 @@ static int op_rename(const char *from, const char *to
 	if (ret)
 		goto out2;
 
+	ret = fuse2fs_check_from_dir_nlink(ff, from_ino, to_ino, from_dir_ino,
+					   to_dir_ino);
+	if (ret)
+		goto out2;
+
 	/* If the target exists, unlink it first */
 	if (to_ino != 0) {
 		err = ext2fs_read_inode(fs, to_ino, &inode);
@@ -2337,7 +2385,7 @@ static int op_rename(const char *from, const char *to
 			ret = translate_error(fs, from_dir_ino, err);
 			goto out2;
 		}
-		inode.i_links_count--;
+		ext2fs_dec_nlink(&inode);
 		err = ext2fs_write_inode(fs, from_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, from_dir_ino, err);
@@ -2350,7 +2398,7 @@ static int op_rename(const char *from, const char *to
 			ret = translate_error(fs, to_dir_ino, err);
 			goto out2;
 		}
-		inode.i_links_count++;
+		ext2fs_inc_nlink(fs, &inode);
 		err = ext2fs_write_inode(fs, to_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, to_dir_ino, err);
@@ -2453,7 +2501,12 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
-	inode.i_links_count++;
+	if (ext2fs_dir_link_max(ff->fs, &inode)) {
+		ret = -EMLINK;
+		goto out2;
+	}
+
+	ext2fs_inc_nlink(fs, EXT2_INODE(&inode));
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
 		goto out2;


