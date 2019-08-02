Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF567FBD9
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfHBONk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 10:13:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389092AbfHBONk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 10:13:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0CB7FA07455651F3DF01;
        Fri,  2 Aug 2019 22:13:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 22:13:29 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: fix potential use after free in system zone via remount with noblock_validity
Date:   Fri, 2 Aug 2019 22:19:26 +0800
Message-ID: <1564755566-4378-1-git-send-email-yi.zhang@huawei.com>
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

At the same time, add_system_zone() can get called during remount as
well so there can be racing ext4_data_block_valid() reading the rbtree
at the same time.

This patch add RCU and seqlock to protect system zone from releasing or
building when doing a remount which inverse current "noblock_validity"
mount option.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
 - I use fio test my v1 patch, it has about 10% perfoamance regression
   on my machine (CPU: Intel E5-2690 v3, 10G ramdisk), switch to use
   seqlock and RCU to protect system zone instead of spinlock, and this
   synchronization scheme seems not affect the perfoamance now.

 fs/ext4/block_validity.c | 63 +++++++++++++++++++++++++++++++++++++++---------
 fs/ext4/ext4.h           |  1 +
 fs/ext4/super.c          |  1 +
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 8e83741..a510e4a 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -21,7 +21,10 @@
 #include "ext4.h"
 
 struct ext4_system_zone {
-	struct rb_node	node;
+	union {
+		struct rcu_head rcu;
+		struct rb_node	node;
+	};
 	ext4_fsblk_t	start_blk;
 	unsigned int	count;
 };
@@ -49,6 +52,12 @@ static inline int can_merge(struct ext4_system_zone *entry1,
 	return 0;
 }
 
+static void destroy_system_zone(struct rcu_head *rcu)
+{
+	kmem_cache_free(ext4_system_zone_cachep,
+			container_of(rcu, struct ext4_system_zone, rcu));
+}
+
 /*
  * Mark a range of blocks as belonging to the "system zone" --- that
  * is, filesystem metadata blocks which should never be used by
@@ -59,9 +68,12 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 			   unsigned int count)
 {
 	struct ext4_system_zone *new_entry = NULL, *entry;
-	struct rb_node **n = &sbi->system_blks.rb_node, *node;
+	struct rb_node **n, *node;
 	struct rb_node *parent = NULL, *new_node = NULL;
 
+	write_seqlock(&sbi->system_blks_lock);
+
+	n = &sbi->system_blks.rb_node;
 	while (*n) {
 		parent = *n;
 		entry = rb_entry(parent, struct ext4_system_zone, node);
@@ -84,13 +96,15 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 	if (!new_entry) {
 		new_entry = kmem_cache_alloc(ext4_system_zone_cachep,
 					     GFP_KERNEL);
-		if (!new_entry)
+		if (!new_entry) {
+			write_sequnlock(&sbi->system_blks_lock);
 			return -ENOMEM;
+		}
 		new_entry->start_blk = start_blk;
 		new_entry->count = count;
 		new_node = &new_entry->node;
 
-		rb_link_node(new_node, parent, n);
+		rb_link_node_rcu(new_node, parent, n);
 		rb_insert_color(new_node, &sbi->system_blks);
 	}
 
@@ -102,7 +116,7 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 			new_entry->start_blk = entry->start_blk;
 			new_entry->count += entry->count;
 			rb_erase(node, &sbi->system_blks);
-			kmem_cache_free(ext4_system_zone_cachep, entry);
+			call_rcu(&entry->rcu, destroy_system_zone);
 		}
 	}
 
@@ -113,9 +127,12 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 		if (can_merge(new_entry, entry)) {
 			new_entry->count += entry->count;
 			rb_erase(node, &sbi->system_blks);
-			kmem_cache_free(ext4_system_zone_cachep, entry);
+			call_rcu(&entry->rcu, destroy_system_zone);
 		}
 	}
+
+	write_sequnlock(&sbi->system_blks_lock);
+
 	return 0;
 }
 
@@ -232,11 +249,11 @@ void ext4_release_system_zone(struct super_block *sb)
 {
 	struct ext4_system_zone	*entry, *n;
 
+	rcu_assign_pointer(EXT4_SB(sb)->system_blks.rb_node, NULL);
+
 	rbtree_postorder_for_each_entry_safe(entry, n,
 			&EXT4_SB(sb)->system_blks, node)
-		kmem_cache_free(ext4_system_zone_cachep, entry);
-
-	EXT4_SB(sb)->system_blks = RB_ROOT;
+		call_rcu(&entry->rcu, destroy_system_zone);
 }
 
 /*
@@ -248,7 +265,9 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 			  unsigned int count)
 {
 	struct ext4_system_zone *entry;
-	struct rb_node *n = sbi->system_blks.rb_node;
+	struct rb_node *n;
+	unsigned seq = 0;
+	int ret = 1;
 
 	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
 	    (start_blk + count < start_blk) ||
@@ -256,6 +275,17 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
 		return 0;
 	}
+
+	/*
+	 * Lock the system zone to prevent it being released concurrently
+	 * when doing a remount which inverse current "[no]block_validity"
+	 * mount option.
+	 */
+	rcu_read_lock();
+retry:
+	read_seqbegin_or_lock(&sbi->system_blks_lock, &seq);
+
+	n = rcu_dereference_raw(sbi->system_blks.rb_node);
 	while (n) {
 		entry = rb_entry(n, struct ext4_system_zone, node);
 		if (start_blk + count - 1 < entry->start_blk)
@@ -264,10 +294,19 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 			n = n->rb_right;
 		else {
 			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
-			return 0;
+			ret = 0;
+			break;
 		}
 	}
-	return 1;
+	if (!(seq & 1))
+		rcu_read_unlock();
+	if (need_seqretry(&sbi->system_blks_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry(&sbi->system_blks_lock, seq);
+
+	return ret;
 }
 
 int ext4_check_blockref(const char *function, unsigned int line,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa..bbf986f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1421,6 +1421,7 @@ struct ext4_sb_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
+	seqlock_t system_blks_lock;
 	struct rb_root system_blks;
 
 #ifdef EXTENTS_STATS
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605..3082b1e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4490,6 +4490,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	ext4_set_resv_clusters(sb);
 
+	seqlock_init(&sbi->system_blks_lock);
 	err = ext4_setup_system_zone(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize system "
-- 
2.7.4

