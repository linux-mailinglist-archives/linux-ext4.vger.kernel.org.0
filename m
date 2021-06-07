Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA1339E74C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFGTRV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 15:17:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48987 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFGTRU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 15:17:20 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 71F391BF205;
        Mon,  7 Jun 2021 19:15:26 +0000 (UTC)
Date:   Mon, 7 Jun 2021 12:15:24 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] fs: ext4: Add check to prevent attempting to resize an
 fs with sparse_super2
Message-ID: <74b8ae78405270211943cd7393e65586c5faeed1.1623093259.git.josh@joshtriplett.org>
References: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The in-kernel ext4 resize code doesn't support filesystem with the
sparse_super2 feature. It fails with errors like this and doesn't finish
the resize:
EXT4-fs (loop0): resizing filesystem from 16640 to 7864320 blocks
EXT4-fs warning (device loop0): verify_reserved_gdb:760: reserved GDT 2 missing grp 1 (32770)
EXT4-fs warning (device loop0): ext4_resize_fs:2111: error (-22) occurred during file system resize
EXT4-fs (loop0): resized filesystem to 2097152

To reproduce:
mkfs.ext4 -b 4096 -I 256 -J size=32 -E resize=$((256*1024*1024)) -O sparse_super2 ext4.img 65M
truncate -s 30G ext4.img
mount ext4.img /mnt
python3 -c 'import fcntl, os, struct ; fd = os.open("/mnt", os.O_RDONLY | os.O_DIRECTORY) ; fcntl.ioctl(fd, 0x40086610, struct.pack("Q", 30 * 1024 * 1024 * 1024 // 4096), False) ; os.close(fd)'
dmesg | tail
e2fsck ext4.img

The userspace resize2fs tool has a check for this case: it checks if the
filesystem has sparse_super2 set and if the kernel provides
/sys/fs/ext4/features/sparse_super2. However, the former check requires
manually reading and parsing the filesystem superblock.

Detect this case in ext4_resize_begin and error out early with a clear
error message.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 fs/ext4/resize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index d13bb9e76482..fc885914c88a 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -78,6 +78,10 @@ int ext4_resize_begin(struct super_block *sb)
 		ext4_msg(sb, KERN_ERR, "Online resizing not supported with bigalloc");
 		return -EOPNOTSUPP;
 	}
+	if (ext4_has_feature_sparse_super2(sb)) {
+		ext4_msg(sb, KERN_ERR, "Online resizing not supported with sparse_super2");
+		return -EOPNOTSUPP;
+	}
 
 	if (test_and_set_bit_lock(EXT4_FLAGS_RESIZING,
 				  &EXT4_SB(sb)->s_ext4_flags))
-- 
2.32.0.rc2

