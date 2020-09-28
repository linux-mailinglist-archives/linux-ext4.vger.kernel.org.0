Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6327A550
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI1CGF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Sep 2020 22:06:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbgI1CGF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 27 Sep 2020 22:06:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C4426564A44FD1E0ABB3;
        Mon, 28 Sep 2020 10:06:03 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 10:05:56 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <yi.zhang@huawei.com>, <tytso@mit.edu>, <jack@suse.cz>,
        <linux-ext4@vger.kernel.org>
CC:     <adilger.kernel@dilger.ca>
Subject: [PATCH v3] ext4: Fix bdev write error check failed when mount fs with ro
Date:   Sun, 27 Sep 2020 22:05:56 -0400
Message-ID: <20200928020556.710971-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Consider a situation when a filesystem was uncleanly shutdown and the
orphan list is not empty and a read-only mount is attempted. The orphan
list cleanup during mount will fail with:

ext4_check_bdev_write_error:193: comm mount: Error while async write back metadata

This happens because sbi->s_bdev_wb_err is not initialized when mounting
the filesystem in read only mode and so ext4_check_bdev_write_error()
falsely triggers.

Initialize sbi->s_bdev_wb_err unconditionally to avoid this problem.

Fixes: bc71726c7257 ("ext4: abort the filesystem if failed to async write metadata buffer")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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

