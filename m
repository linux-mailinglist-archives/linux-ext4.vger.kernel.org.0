Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7869E12CF95
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 12:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfL3LeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 06:34:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfL3LeN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 06:34:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so17030861pfo.10
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2019 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Iob/hlUn2QCCh378BWskZvI0mfeUwZZM+IJ1tulZqj8=;
        b=LZollxCMVLE3m2O1vO3vscBmRyWQoQVB5wbu2hsDWxah4CCroeN7BIlJ79tdlFEJOP
         IklNy83km5ZjvdgarSb8nUyTlRAgF9wBmB+DnuJ+ugstE4dxBKgjznYF7WKJyUI+0pL3
         ix/eA5ZjJ0Ym/bhXyGsnYAWmRtq20y2dssibfPIoEhlPw2xT1HDbOgDJEYy1mo9ub6qW
         vHZCjdW9mtIqs74Pyv9AUXRk3uSVsb6tpxxdRTZMTlzIGwsx5s1mbUjjN7Zq/jXC01nh
         KvutoWFm3FK8QtBe2+10UK9z/1DoOExk9YnzJaTrduhoePMfk7rLlqk/WEAQy2Jx07Mq
         VCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iob/hlUn2QCCh378BWskZvI0mfeUwZZM+IJ1tulZqj8=;
        b=NUYS0P9lM0eLWwMtGXgUyI7gW+ylEiClBlPHh3prvzGHjo8LrSiICoXrISA9e10v/r
         aO9abclB9rGB/0oXc/5ouB6Nu3G7K8s0oqT5lSqi8n5z8fAOgyG452f4vBNBZHcWEsob
         vQFvAsrx64YUAHxgMwE589ZZ/phH4WXtJ1IgnsIK/r1hx2LpLvvZ18GLtG1yaAeuSIQ2
         Gwjap91jVrU6+9tb9C5OHBBl/QDeAoAZa8f428UpHYmtTp1fzjPmHYwhV2XbQc4yjd54
         XeQZdJ50kgUnBuLbfKRzq46afZ3Pyj8BQClXYSGUUPaChgfEL9P0KF31FiI8JlQ/Dowx
         k4RQ==
X-Gm-Message-State: APjAAAVjFmzW3FAWvfJCt8IQKvFpgZ75JMJiH4Vnq6RVf2ZkADAkFxRw
        f1jQMliPFoNZhc6KWny3yJe1QNQPLik=
X-Google-Smtp-Source: APXvYqw2J8fu5q1GAxBiOaQtqhl0ge7deiveuqcG5BhDVtSkvJNL1Z2IaaEWB7aCJ+eJHC6NalLQmQ==
X-Received: by 2002:a65:620d:: with SMTP id d13mr53506678pgv.252.1577705651951;
        Mon, 30 Dec 2019 03:34:11 -0800 (PST)
Received: from ddnmon.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id c14sm24097187pjr.24.2019.12.30.03.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 03:34:11 -0800 (PST)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, dongyangli@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [PATCH] e2fsprogs: fix to use inode i_blocks correctly
Date:   Mon, 30 Dec 2019 20:36:06 +0900
Message-Id: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

According to following logic:

"If the huge_file feature flag is not set on the filesystem,
the file consumes i_blocks_lo 512-byte blocks on disk.
If huge_file is set and EXT4_HUGE_FILE_FL is NOT set in
inode.i_flags, then the file consumes i_blocks_lo + (i_blocks_hi << 32)
512-byte blocks on disk. If huge_file is set and EXT4_HUGE_FILE_FL IS set
in inode.i_flags, then this file consumes (i_blocks_lo + i_blocks_hi << 32)
filesystem blocks on disk."

blocks_from_inode() did not return wrong inode blocks, and
ext2fs_inode_i_blocks() is not taking EXT4_HUGE_FILE_FL into account
at all, while the some callers deal it correctly, some not. This patch
try to unify to handle it in ext2fs_inode_i_blocks() to return.
blocks(based on 512 bytes)

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 debugfs/filefrag.c    |  4 ----
 e2fsck/extents.c      |  6 +-----
 lib/ext2fs/blknum.c   | 13 ++++++++++---
 lib/support/mkquota.c |  3 ++-
 misc/fuse2fs.c        | 19 +------------------
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/debugfs/filefrag.c b/debugfs/filefrag.c
index 961b6962..3e818b19 100644
--- a/debugfs/filefrag.c
+++ b/debugfs/filefrag.c
@@ -145,10 +145,6 @@ static void filefrag(ext2_ino_t ino, struct ext2_inode *inode,
 	if (fs->options & VERBOSE_OPT) {
 		blk64_t num_blocks = ext2fs_inode_i_blocks(current_fs, inode);
 
-		if (!ext2fs_has_feature_huge_file(current_fs->super) ||
-		    !(inode->i_flags & EXT4_HUGE_FILE_FL))
-			num_blocks /= current_fs->blocksize / 512;
-
 		fprintf(fs->f, "\n%s has %llu block(s), i_size is %llu\n",
 			fs->name, num_blocks, EXT2_I_SIZE(inode));
 	}
diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 3073725a..d9509297 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -304,11 +304,7 @@ extents_loaded:
 
 	delta = ext2fs_inode_i_blocks(ctx->fs, EXT2_INODE(&inode)) - start_val;
 	if (delta) {
-		if (!ext2fs_has_feature_huge_file(ctx->fs->super) ||
-		    !(inode.i_flags & EXT4_HUGE_FILE_FL))
-			delta <<= 9;
-		else
-			delta *= ctx->fs->blocksize;
+		delta *= 512;
 		quota_data_add(ctx->qctx, &inode, ino, delta);
 	}
 
diff --git a/lib/ext2fs/blknum.c b/lib/ext2fs/blknum.c
index 18af3408..6ab843c4 100644
--- a/lib/ext2fs/blknum.c
+++ b/lib/ext2fs/blknum.c
@@ -80,9 +80,16 @@ blk64_t ext2fs_inode_data_blocks2(ext2_filsys fs,
 blk64_t ext2fs_inode_i_blocks(ext2_filsys fs,
 					struct ext2_inode *inode)
 {
-	return (inode->i_blocks |
-		(ext2fs_has_feature_huge_file(fs->super) ?
-		 (__u64)inode->osd2.linux2.l_i_blocks_hi << 32 : 0));
+	blkcnt_t i_blocks = inode->i_blocks;
+
+	if (ext2fs_has_feature_huge_file(fs->super)) {
+		i_blocks += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
+		if (inode->i_flags & EXT4_HUGE_FILE_FL)
+			i_blocks *= (fs->blocksize / 512);
+
+	}
+
+	return i_blocks;
 }
 
 /*
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index ddb53124..2b0c6fb5 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -504,7 +504,8 @@ errcode_t quota_compute_usage(quota_ctx_t qctx)
 		    (ino == EXT2_ROOT_INO ||
 		     ino >= EXT2_FIRST_INODE(fs->super))) {
 			space = ext2fs_inode_i_blocks(fs,
-						      EXT2_INODE(inode)) << 9;
+						      EXT2_INODE(inode));
+			space *= 512;;
 			quota_data_add(qctx, inode, ino, space);
 			quota_data_inodes(qctx, inode, ino, +1);
 		}
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index dc7a0392..748e3f7c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -755,23 +755,6 @@ static void *op_init(struct fuse_conn_info *conn)
 	return ff;
 }
 
-static blkcnt_t blocks_from_inode(ext2_filsys fs,
-				  struct ext2_inode_large *inode)
-{
-	blkcnt_t b;
-
-	b = inode->i_blocks;
-	if (ext2fs_has_feature_huge_file(fs->super))
-		b += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
-
-	if (!ext2fs_has_feature_huge_file(fs->super) ||
-	    !(inode->i_flags & EXT4_HUGE_FILE_FL))
-		b *= fs->blocksize / 512;
-	b *= EXT2FS_CLUSTER_RATIO(fs);
-
-	return b;
-}
-
 static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 {
 	struct ext2_inode_large inode;
@@ -795,7 +778,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	statbuf->st_gid = inode.i_gid;
 	statbuf->st_size = EXT2_I_SIZE(&inode);
 	statbuf->st_blksize = fs->blocksize;
-	statbuf->st_blocks = blocks_from_inode(fs, &inode);
+	statbuf->st_blocks = ext2fs_inode_i_blocks(fs, &inode);
 	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
 	statbuf->st_atime = tv.tv_sec;
 	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
-- 
2.21.0

