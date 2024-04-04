Return-Path: <linux-ext4+bounces-1856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A598985CA
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02014285419
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399182D68;
	Thu,  4 Apr 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+XT2UJr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74180C09
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229042; cv=none; b=Q5CxjL2H2Fnamwf4Co1SvJa7GmkO34PgDo6/vi089hWRNZRsqW8u5Z9dr7i2bbe34nXB5TrIwzdOARrtJ3npyfvLME7ZVZso2v0GkBjwjrhN38Du/C8KQmGv4ZjkaY+EXLk/xooXJAOA/LPdSYUGOCTT2Jr0RiJ5PBDv6cKwcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229042; c=relaxed/simple;
	bh=2R4bn6h/V9QwnqF8wFmKHZ/kWIHOLLv5epWCfrESK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIC1KrkCq03OywTNd9R4cjVyDsFRU7o0M7KRGXCcl1XhPHDK3Vo7R7oBuGQqmadEgPXcmnzfVjgQ1foc603wqWqK68uUqD5olbuVFDjnO++DULbvb1AMi5iyjBLrGZX+Te/Rgia7+VEzizzL5XEkbAEYQ+3qKmCiffPugq371l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+XT2UJr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712229037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhnFM4FfFSVqaDsm4zl/Ss6PMlAqm2ARJf8bLZnxGKQ=;
	b=R+XT2UJrlT1SgB6NUS8ecnjT/4+lVqhAR8gEHCP/zVWizN75DFL4hrdcOHUgkkuec4LAN2
	TXVUCC7ucrbEiUsoB2U5H+sPEH005QFigAULENsoCa/DJ8pVfHDxWN6ZZ3o5u3jyLFQKmd
	7wmtb/R7sIKgcvyTUAy0xHXBWr6npCs=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 1/4] e2fsck: update quota accounting after directory optimization
Date: Thu,  4 Apr 2024 12:10:29 +0100
Message-ID: <20240404111032.10427-2-luis.henriques@linux.dev>
In-Reply-To: <20240404111032.10427-1-luis.henriques@linux.dev>
References: <20240404111032.10427-1-luis.henriques@linux.dev>
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

