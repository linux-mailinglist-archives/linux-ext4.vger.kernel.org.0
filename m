Return-Path: <linux-ext4+bounces-1901-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7E899F77
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41EC1C2248E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D616EC03;
	Fri,  5 Apr 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQq15JCH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1216EBEB
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327053; cv=none; b=gua6IhQEv7XdKFUEnL7iltNSPZ22wnjp+Opz/zA2k2H7p1IYCbkxco4QHSTlWk6yvtxNdEwwS/IVFWdUZ7rOgHziQN0QhnsinPvvLf1x7a5LAF1+z4ihESeEhybqoJgwK10PBK9UZDDfWmQWcm6Nq5ZogMYStt8i8GYx5PAhVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327053; c=relaxed/simple;
	bh=62OJsOtg1s0aAYcd3xLjgyMBTelKu2nGtnU2O5fEY+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tufn9cteegFz/FBKISMu445BS4cYBRqbaQrJgaoCFGsTKybKYrLyeE4t/e22+1mAdJYpRWpLD8qDTCbZX0WznRKdCOyhl74ZeTuU7GDXEhVJhvfuvv3aMXTjLn2JePdf6gyWI0WqONTjA8DxEtGGZOultuw/qgm1B9NUK0H/uc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQq15JCH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712327050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I/jBXYRJyhRcK8oWUV/079Yu4qPZYJRmaE9t+GmEsU=;
	b=QQq15JCHF7Gc3lFuSbNlpsaz1eL9G6bHtXOxUULXwidwm+DqBPxD3/+8km+trUFTmeC4Qc
	cWEYnjAcFZkSwnzbx1x5M4jRc/H6m0615UpCT22uw0xD7+zt62r3/aHqQk4zEGIX6xxttE
	zcNlgcyDJGk6RVWWSuQHc3ldhR4iD24=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v3 2/4] e2fsck: update quota when deallocating a bad inode
Date: Fri,  5 Apr 2024 15:24:03 +0100
Message-ID: <20240405142405.12312-3-luis.henriques@linux.dev>
In-Reply-To: <20240405142405.12312-1-luis.henriques@linux.dev>
References: <20240405142405.12312-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a bad inode is found it will be deallocated.  However, if the filesystem has
quota enabled, the quota information isn't being updated accordingly.  This
issue was detected by running fstest ext4/019.

This patch fixes the issue by decreasing the inode count from the
quota and, if blocks are also being released, also subtract them as well.

While there, and as suggested by Andreas Dilger, the deallocate_inode()
function documentation is also updated by this patch to make it clear what
that function really does.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 e2fsck/pass2.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index b91628567a7f..08ab40fa8ba1 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1854,17 +1854,26 @@ static int deallocate_inode_block(ext2_filsys fs,
 }
 
 /*
- * This function deallocates an inode
+ * This function reverts various counters and bitmaps incremented in
+ * pass1 for the inode, blocks, and quotas before it was decided the
+ * inode was corrupt and needed to be cleared.  This avoids the need
+ * to run e2fsck a second time (or have it restart itself) to repair
+ * these counters.
+ *
+ * It does not modify any on-disk state, so even if the inode is bad
+ * it _should_ reset in-memory state to before the inode was first
+ * processed.
  */
 static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
 {
 	ext2_filsys fs = ctx->fs;
-	struct ext2_inode	inode;
+	struct ext2_inode_large	inode;
 	struct problem_context	pctx;
 	__u32			count;
 	struct del_block	del_block;
 
-	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
+	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
+			       sizeof(inode), "deallocate_inode");
 	clear_problem_context(&pctx);
 	pctx.ino = ino;
 
@@ -1874,29 +1883,29 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
 	e2fsck_read_bitmaps(ctx);
 	ext2fs_inode_alloc_stats2(fs, ino, -1, LINUX_S_ISDIR(inode.i_mode));
 
-	if (ext2fs_file_acl_block(fs, &inode) &&
+	if (ext2fs_file_acl_block(fs, EXT2_INODE(&inode)) &&
 	    ext2fs_has_feature_xattr(fs->super)) {
 		pctx.errcode = ext2fs_adjust_ea_refcount3(fs,
-				ext2fs_file_acl_block(fs, &inode),
+				ext2fs_file_acl_block(fs, EXT2_INODE(&inode)),
 				block_buf, -1, &count, ino);
 		if (pctx.errcode == EXT2_ET_BAD_EA_BLOCK_NUM) {
 			pctx.errcode = 0;
 			count = 1;
 		}
 		if (pctx.errcode) {
-			pctx.blk = ext2fs_file_acl_block(fs, &inode);
+			pctx.blk = ext2fs_file_acl_block(fs, EXT2_INODE(&inode));
 			fix_problem(ctx, PR_2_ADJ_EA_REFCOUNT, &pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
 			return;
 		}
 		if (count == 0) {
 			ext2fs_block_alloc_stats2(fs,
-				  ext2fs_file_acl_block(fs, &inode), -1);
+				  ext2fs_file_acl_block(fs, EXT2_INODE(&inode)), -1);
 		}
-		ext2fs_file_acl_block_set(fs, &inode, 0);
+		ext2fs_file_acl_block_set(fs, EXT2_INODE(&inode), 0);
 	}
 
-	if (!ext2fs_inode_has_valid_blocks2(fs, &inode))
+	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode)))
 		goto clear_inode;
 
 	/* Inline data inodes don't have blocks to iterate */
@@ -1921,10 +1930,22 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
 		ctx->flags |= E2F_FLAG_ABORT;
 		return;
 	}
+
+	if ((ino != quota_type2inum(PRJQUOTA, fs->super)) &&
+	    (ino != fs->super->s_orphan_file_inum) &&
+	    (ino == EXT2_ROOT_INO || ino >= EXT2_FIRST_INODE(ctx->fs->super)) &&
+	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
+		if (del_block.num > 0)
+			quota_data_sub(ctx->qctx, &inode, ino,
+				       del_block.num * EXT2_CLUSTER_SIZE(fs->super));
+		quota_data_inodes(ctx->qctx, (struct ext2_inode_large *)&inode,
+				  ino, -1);
+	}
+
 clear_inode:
 	/* Inode may have changed by block_iterate, so reread it */
-	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
-	e2fsck_clear_inode(ctx, ino, &inode, 0, "deallocate_inode");
+	e2fsck_read_inode(ctx, ino, EXT2_INODE(&inode), "deallocate_inode");
+	e2fsck_clear_inode(ctx, ino, EXT2_INODE(&inode), 0, "deallocate_inode");
 }
 
 /*

