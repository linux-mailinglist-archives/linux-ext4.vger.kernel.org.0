Return-Path: <linux-ext4+bounces-2139-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A988E8A933B
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D93B2164D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96128385;
	Thu, 18 Apr 2024 06:39:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401462576F;
	Thu, 18 Apr 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422361; cv=none; b=T2BmbXGhteFbuVDLpGoQwNv9568pPj7VGVv9C1X269ugU/FRiBCwwW7OKWT2ACm+bojgPrMnZnI36A8s23pziH8l6Vo28BSbm0iuXcRhfC0nHdwS7/FoSV6PnIZxqvSDMR+NIgi79Y5MyoJ55JOTHdkDFrxDXLsAqFzxjsNCTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422361; c=relaxed/simple;
	bh=xQyiMEsIdiJhs93q72XSg3tw9OAlgu9mfCr2axjAnTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0pbzS9e5tFoLWiB4JZA9jufEcYXlw+zOqJ8rWdIFcHcPhxShaGHazzpIHKOiYPnwdUd4pSLnks7+jlyv1ryHV+R7lXE0WvshvPjR8je9giihORA1CDNqJoT7oOVN2cKEAfmUhV2P8ww01z2Yywoe10L67eThlS0wsViiNMaGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKp4j4vsDzYdmG;
	Thu, 18 Apr 2024 14:38:13 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BFED18006B;
	Thu, 18 Apr 2024 14:39:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 14:39:14 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH] e2fsck: fix acl block leak when process orphan list
Date: Thu, 18 Apr 2024 14:39:46 +0800
Message-ID: <20240418063946.2802835-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)

There's a issue:
[]$~/e2fsprogs/e2fsck/e2fsck -f scsi-disk2.img
e2fsck 1.47.0 (5-Feb-2023)
scsi-disk2.img: recovering journal
Clearing orphaned inode 12 (uid=0, gid=0, mode=0140777, size=0)
Pass 1: Checking inodes, blocks, and sizes
Extended attribute block 4247 has reference count 3, should be 2.  Fix<y>? no
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong (249189, counted=249188).
Fix<y>? no
Free inodes count wrong (65526, counted=65523).
Fix<y>? no

scsi-disk2.img: ***** FILE SYSTEM WAS MODIFIED *****

scsi-disk2.img: ********** WARNING: Filesystem still has errors **********

scsi-disk2.img: 10/65536 files (0.0% non-contiguous), 12955/262144 blocks

Above issue can reproduce as follows:
step1: socat UNIX-LISTEN:/home/test/mysocket.sock,mode=777,reuseaddr,fork EXEC:/home/test  &
step2: setfacl some xattr for mysocket.sock
step3: cp -a /home/test/mysocket.sock /home/test/sock1
       cp -a /home/test/mysocket.sock /home/test/sock2
step4: sync
step5: Power-off
step6: run e2fsck

As after commit 42475e281d22 add ext2fs_inode_has_valid_blocks() judgement in
release_inode_blocks() which means socket type file skip realse block include
ACL block. The kernel does not restrict the setting of extended attributes for
socket files. So this will lead to ACL block leak.
To solve above issue there's need to release ACL block for other kind of
special file.

Fixes: 42475e281d22 ("super.c (release_inode_blocks): Don't try to release the blocks if the orphaned inode is a device file, symlink, or some other kind of special file that doesn't have a block list.")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 e2fsck/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index be40dd8f..cefc2b07 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -196,7 +196,7 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
 	__u32				count;
 
 	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(inode)))
-		return 0;
+		goto release_acl;
 
 	pb.buf = block_buf + 3 * ctx->fs->blocksize;
 	pb.ctx = ctx;
@@ -235,7 +235,7 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
 	if (pb.truncated_blocks)
 		ext2fs_iblk_sub_blocks(fs, EXT2_INODE(inode),
 				pb.truncated_blocks);
-
+release_acl:
 	blk = ext2fs_file_acl_block(fs, EXT2_INODE(inode));
 	if (blk) {
 		retval = ext2fs_adjust_ea_refcount3(fs, blk, block_buf, -1,
-- 
2.31.1


