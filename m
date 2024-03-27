Return-Path: <linux-ext4+bounces-1761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290788E9AC
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E76F1C22393
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85417131BAD;
	Wed, 27 Mar 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlpxAWwe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2C130E39
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554241; cv=none; b=tyhfF8pD0Ihjnk/VgMoiQGTL7gdo6+0dUHg9Tt9uvbm3IaohViNEIb2wWBNQRGzEMEykT/GAL4ctQUGC7O6SSVk/5+nULKZPGOWSvEpI9N8Etqjkx9xG5fXTQXn24FDcTH6SQIpe72Cps1UvE5sgzt2EE+QgWKUuCWIeCNbLHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554241; c=relaxed/simple;
	bh=oEY2sw7CThP3o3NIm6ZV3n5nxEorG4xzERASJzSoFo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DahAkb5BIwZhFRG7U5qFhdft9RaJ2AB52jIAddlIyvm2DYS9ikD2BthCaNhdKivZ4XMUBXsL6Cv+ojTYrCvLu3fGfFkMkZkg5UXTioPB9ZzQAkbuUUEtxeG13QZUSowWUZkFzREOmwr2DQLxQfKiJMp7slw/paJR/UQvZQXJRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlpxAWwe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711554237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYT7ZN69J2EZ4mvcDS8N/IehBipEL7PWyV412QVc0Vk=;
	b=SlpxAWwenagabt5V+iIlbYC74JLbGc+xJjvgFK8AJmv0wIpces4Z++mif+TYGnyszekwN4
	nw6zSkOQeNn45jM/f6fUCPyWxbfMzCGuq+dXgBi6K4wEG2rcGJ/Z1OMPaIC6XKISZ4lBz3
	DqW7jzFpuv83EVr1rIuCp65+H7LRv48=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH e2fsprogs] e2fsck: update quota accounting after directory optimization
Date: Wed, 27 Mar 2024 15:43:52 +0000
Message-ID: <20240327154352.22648-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In "Pass 3A: Optimizing directories", a directory may have it's size reduced.
If that happens and quota is enabled in the filesystem, the quota information
will be incorrect because it doesn't take the rehash into account.

This patch simply updates the quota data accordingly, after the directory is
written and it's size has been updated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218626
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 e2fsck/rehash.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index c1da7d52724e..4847d172e5fe 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -987,14 +987,18 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 {
 	ext2_filsys 		fs = ctx->fs;
 	errcode_t		retval;
-	struct ext2_inode 	inode;
+	struct ext2_inode_large	inode;
 	char			*dir_buf = 0;
 	struct fill_dir_struct	fd = { NULL, NULL, 0, 0, 0, NULL,
 				       0, 0, 0, 0, 0, 0 };
 	struct out_dir		outdir = { 0, 0, 0, 0 };
-	struct name_cmp_ctx name_cmp_ctx = {0, NULL};
+	struct name_cmp_ctx	name_cmp_ctx = {0, NULL};
+	__u64			osize;
 
-	e2fsck_read_inode(ctx, ino, &inode, "rehash_dir");
+	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
+			       sizeof(inode), "rehash_dir");
+
+	osize = EXT2_I_SIZE(&inode);
 
 	if (ext2fs_has_feature_inline_data(fs->super) &&
 	   (inode.i_flags & EXT4_INLINE_DATA_FL))
@@ -1013,7 +1017,7 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 	fd.ino = ino;
 	fd.ctx = ctx;
 	fd.buf = dir_buf;
-	fd.inode = &inode;
+	fd.inode = EXT2_INODE(&inode);
 	fd.dir = ino;
 	if (!ext2fs_has_feature_dir_index(fs->super) ||
 	    (inode.i_size / fs->blocksize) < 2)
@@ -1092,14 +1096,25 @@ resort:
 			goto errout;
 	}
 
-	retval = write_directory(ctx, fs, &outdir, ino, &inode, fd.compress);
+	retval = write_directory(ctx, fs, &outdir, ino, EXT2_INODE(&inode),
+				 fd.compress);
 	if (retval)
 		goto errout;
 
+	if ((osize > EXT2_I_SIZE(&inode)) &&
+	    (ino != quota_type2inum(PRJQUOTA, fs->super)) &&
+	    (ino != fs->super->s_orphan_file_inum) &&
+	    (ino == EXT2_ROOT_INO || ino >= EXT2_FIRST_INODE(ctx->fs->super)) &&
+	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
+		quota_data_sub(ctx->qctx, &inode,
+			       ino, osize - EXT2_I_SIZE(&inode));
+	}
+
 	if (ctx->options & E2F_OPT_CONVERT_BMAP)
 		retval = e2fsck_rebuild_extents_later(ctx, ino);
 	else
-		retval = e2fsck_check_rebuild_extents(ctx, ino, &inode, pctx);
+		retval = e2fsck_check_rebuild_extents(ctx, ino,
+						      EXT2_INODE(&inode), pctx);
 errout:
 	ext2fs_free_mem(&dir_buf);
 	ext2fs_free_mem(&fd.harray);

