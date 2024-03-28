Return-Path: <linux-ext4+bounces-1770-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B789072E
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B129ADE3
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E1126F19;
	Thu, 28 Mar 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrwQ74eL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41E7D401
	for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646989; cv=none; b=MrliY0TjZYnoz7CHbCNjJLwrzD/wyhaA3hn8C33/f3Bdk9yPdWqob1q6aw+31rF/a0EumpClXt7sC1abABIxO1CjeruMqwUBBw4w58m6mDL7U4xvNnuIkANnRaRJb98Kq73eBZozBGLpy/C+FRAEzVBJelgPDCFR8UM3goyuzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646989; c=relaxed/simple;
	bh=2R4bn6h/V9QwnqF8wFmKHZ/kWIHOLLv5epWCfrESK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jro/w7aG5uB0SRJrMh8rW6saAU01tBq4+FLVavg9U1jAeJ2N5PWnUfSQOKbxMbBFI5+wPNX3tfaFCmObsVWzrzvHyjAw9+SAevvxhJxqcD15ZyyFw+LTzKzah2rjzb+U0R9FCODnpqNROfXcmtytpFMQfA7SsyFYPrJwi6btI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrwQ74eL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711646984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhnFM4FfFSVqaDsm4zl/Ss6PMlAqm2ARJf8bLZnxGKQ=;
	b=SrwQ74eLU1waPtl1GF0WHFjlwX0CcnMMpj1MROpNaTAy0ZRp8kLcqHBK+mz/Gm+wXrZ6e/
	fzKuuZY5CTBxYK1xkS1Q8rWoInIn6Wzt3WHGBnVMnLt5WETgI+RbQG/hJadUmXjtYENEl1
	ivGjdFGp66bI6HUfxLCqW7T9gEFhI24=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 1/4] e2fsck: update quota accounting after directory optimization
Date: Thu, 28 Mar 2024 17:29:37 +0000
Message-ID: <20240328172940.1609-2-luis.henriques@linux.dev>
In-Reply-To: <20240328172940.1609-1-luis.henriques@linux.dev>
References: <20240328172940.1609-1-luis.henriques@linux.dev>
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
will be incorrect because it doesn't take the rehash into account.  This issue
was detected by running fstest ext4/014.

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

