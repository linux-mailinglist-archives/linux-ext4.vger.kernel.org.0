Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE14277D55
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 03:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgIYBBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 21:01:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgIYBBp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 21:01:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C48F31017809A2C5B21;
        Fri, 25 Sep 2020 09:01:43 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 09:01:37 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <yi.zhang@huawei.com>, <tytso@mit.edu>, <jack@suse.cz>,
        <linux-ext4@vger.kernel.org>
CC:     <adilger.kernel@dilger.ca>
Subject: [PATCH v2] ext4: Fix bdev write error check failed when mount fs with ro
Date:   Thu, 24 Sep 2020 21:01:42 -0400
Message-ID: <20200925010142.3711176-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If some errors has occurred on the device, and the orphan list not empty,
then mount the device with 'ro', the bdev write error check will failed:
  ext4_check_bdev_write_error:193: comm mount: Error while async write back metadata

Since the sbi->s_bdev_wb_err wouldn't be initialized when mount file system
with 'ro', when clean up the orphan list and access the iloc buffer, bdev
write error check will failed.

So we should always initialize the sbi->s_bdev_wb_err even if mount the
file system with 'ro'.

Fixes: bc71726c7257 ("ext4: abort the filesystem if failed to async write metadata buffer")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/ext4/super.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..0303e6e17190 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4814,9 +4814,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	if (!sb_rdonly(sb))
-		errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
-					 &sbi->s_bdev_wb_err);
+	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+				 &sbi->s_bdev_wb_err);
 	sb->s_bdev->bd_super = sb;
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
@@ -5707,14 +5706,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 			}
 
-			/*
-			 * Update the original bdev mapping's wb_err value
-			 * which could be used to detect the metadata async
-			 * write error.
-			 */
-			errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
-						 &sbi->s_bdev_wb_err);
-
 			/*
 			 * Mounting a RDONLY partition read-write, so reread
 			 * and store the current valid flag.  (It may have
-- 
2.25.4

