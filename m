Return-Path: <linux-ext4+bounces-1767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056189072B
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30201F24B35
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3F8174B;
	Thu, 28 Mar 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VoHae2xO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF864CE1
	for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646988; cv=none; b=UyVx7tmg7A6wHSJKkKaxs6QY49sSO/szWZcBIrW8CbP9oVx4L8JXb4ombHD0bSMtcz7s9rt2nPytyasg5g2bl7gXjNhDtAErhcl/5TQ/xBQXY5x+YTMMnBDIyOtMNb/OX6HqSem6hj3cE8zLQkfGaR63OeLy8om37aUj45hFFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646988; c=relaxed/simple;
	bh=gLNXCKiOE/I2IkJj7bA0qUletUEyLNrPlMYpeW9wqb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkbJ65xpVEIP3ptU7qIFFtqyEMC5uNmJR4zSlvW5Wa3gHl9zw7RvMFBhJAY1QMkZCVLKFg373+8EQI3c5rCVyb7pyQ33lbz8axoNx3jRJnF6VDzq27wWIBd/4sWfAtGABnSzG15WpjjOwhkPwmg6YA15sWubd1uLfDFCWM1h9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VoHae2xO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711646984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhP+WHnExIAs9vguNWogzs/vKkxt/IJoFze4T8iLFkM=;
	b=VoHae2xOGH5q/0MolTeKjWOfl4m0NaFjCd4K1zuQabZr0y/SF6oWeh60gJjQ7zDJ7xlvJd
	mVWPrGrTyOTyLSD1sl/D3wisiB/cnw9kQPkLGfvaAFsEHbxjZMLtWbIfoNExfWVUK4PHxB
	wo9t5v5qQ4vhfCMsMGXjUhltkT/zh4E=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 2/4] e2fsck: update quota when deallocating a bad inode
Date: Thu, 28 Mar 2024 17:29:38 +0000
Message-ID: <20240328172940.1609-3-luis.henriques@linux.dev>
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

If a bad inode is found it will be deallocated.  However, if the filesystem has
quota enabled, the quota information isn't being updated accordingly.  This
issue was detected by running fstest ext4/019.

This patch fixes the issue by decreasing the inode count from the
quota and, if blocks are also being released, also subtract them as well.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 e2fsck/pass2.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index b91628567a7f..e16b488af643 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1859,12 +1859,13 @@ static int deallocate_inode_block(ext2_filsys fs,
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
 
@@ -1874,29 +1875,29 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
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
@@ -1921,10 +1922,22 @@ static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* block_buf)
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

