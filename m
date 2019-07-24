Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870E172E5F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 14:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfGXMFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 08:05:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbfGXMFX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 24 Jul 2019 08:05:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D1AF773AC3B3BFAE40A0;
        Wed, 24 Jul 2019 20:05:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 20:05:51 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>
Subject: [PATCH] ext4: fix potential use after free in system zone via remount with noblock_validity
Date:   Wed, 24 Jul 2019 20:11:08 +0800
Message-ID: <1563970268-33688-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remount process will release system zone which was allocated before if
"noblock_validity" is specified. If we mount an ext4 file system to two
mountpoints whit default mount options, and then remount one of them
with "noblock_validity", it may trigger a use after free problem when
someone accessing the other one.

 # mount /dev/sda foo
 # mount /dev/sda bar

User access mountpoint "foo"   |   Remount mountpoint "bar"
                               |
ext4_map_blocks()              |   ext4_remount()
check_block_validity()         |   ext4_setup_system_zone()
ext4_data_block_valid()        |   ext4_release_system_zone()
                               |   free system_blks rb nodes
access system_blks rb nodes    |
trigger use after free         |

This patch lock the system zone when accessing it to prevent it being
released when doing a remount with "noblock_validity" mount option.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/block_validity.c | 21 +++++++++++++++++++--
 fs/ext4/ext4.h           |  2 ++
 fs/ext4/super.c          |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 8e83741..d9c4792 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -191,7 +191,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	if (!test_opt(sb, BLOCK_VALIDITY)) {
 		if (sbi->system_blks.rb_node)
-			ext4_release_system_zone(sb);
+			ext4_release_system_zone_lock(sb);
 		return 0;
 	}
 	if (sbi->system_blks.rb_node)
@@ -239,6 +239,14 @@ void ext4_release_system_zone(struct super_block *sb)
 	EXT4_SB(sb)->system_blks = RB_ROOT;
 }
 
+/* Called when (re)mounting the filesystem without BLOCK_VALIDITY */
+void ext4_release_system_zone_lock(struct super_block *sb)
+{
+	spin_lock(&EXT4_SB(sb)->system_blks_lock);
+	ext4_release_system_zone(sb);
+	spin_unlock(&EXT4_SB(sb)->system_blks_lock);
+}
+
 /*
  * Returns 1 if the passed-in block region (start_blk,
  * start_blk+count) is valid; 0 if some part of the block region
@@ -248,7 +256,7 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 			  unsigned int count)
 {
 	struct ext4_system_zone *entry;
-	struct rb_node *n = sbi->system_blks.rb_node;
+	struct rb_node *n;
 
 	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
 	    (start_blk + count < start_blk) ||
@@ -256,6 +264,13 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
 		return 0;
 	}
+
+	/*
+	 * Lock the system zone to prevent it being released concurrently
+	 * when doing a remount with "noblock_validity" mount option.
+	 */
+	spin_lock(&sbi->system_blks_lock);
+	n = sbi->system_blks.rb_node;
 	while (n) {
 		entry = rb_entry(n, struct ext4_system_zone, node);
 		if (start_blk + count - 1 < entry->start_blk)
@@ -264,9 +279,11 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 			n = n->rb_right;
 		else {
 			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
+			spin_unlock(&sbi->system_blks_lock);
 			return 0;
 		}
 	}
+	spin_unlock(&sbi->system_blks_lock);
 	return 1;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa..fd34a7b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1421,6 +1421,7 @@ struct ext4_sb_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
+	spinlock_t system_blks_lock;
 	struct rb_root system_blks;
 
 #ifdef EXTENTS_STATS
@@ -3191,6 +3192,7 @@ extern void ext4_exit_sysfs(void);
 
 /* block_validity */
 extern void ext4_release_system_zone(struct super_block *sb);
+extern void ext4_release_system_zone_lock(struct super_block *sb);
 extern int ext4_setup_system_zone(struct super_block *sb);
 extern int __init ext4_init_system_zone(void);
 extern void ext4_exit_system_zone(void);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605..c95f972 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4490,6 +4490,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	ext4_set_resv_clusters(sb);
 
+	spin_lock_init(&sbi->system_blks_lock);
 	err = ext4_setup_system_zone(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize system "
-- 
2.7.4

