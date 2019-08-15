Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681CA8EA7F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2019 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfHOLlC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 07:41:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfHOLlB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Aug 2019 07:41:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA6AF3F37D17B1F3DD13;
        Thu, 15 Aug 2019 19:40:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 19:40:49 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v5] ext4: fix potential use after free in system zone via remount with noblock_validity
Date:   Thu, 15 Aug 2019 19:47:19 +0800
Message-ID: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
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
mountpoints with default mount options, and then remount one of them
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

This problem can also be reproduced by one mountpint, At the same time,
add_system_zone() can get called during remount as well so there can be
racing ext4_data_block_valid() reading the rbtree at the same time.

This patch add RCU to protect system zone from releasing or building
when doing a remount which inverse current "noblock_validity" mount
option. It assign the rbtree after the whole tree was complete and
do actual freeing after rcu grace period, avoid any intermediate state.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes since v4:
 - Update comments before ext4_[setup|release]_system_zone().
 - Add reviewed-by tag.

 fs/ext4/block_validity.c | 188 ++++++++++++++++++++++++++++++++++-------------
 fs/ext4/ext4.h           |  10 ++-
 2 files changed, 146 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 8e83741..003dc1d 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -38,6 +38,7 @@ int __init ext4_init_system_zone(void)
 
 void ext4_exit_system_zone(void)
 {
+	rcu_barrier();
 	kmem_cache_destroy(ext4_system_zone_cachep);
 }
 
@@ -49,17 +50,26 @@ static inline int can_merge(struct ext4_system_zone *entry1,
 	return 0;
 }
 
+static void release_system_zone(struct ext4_system_blocks *system_blks)
+{
+	struct ext4_system_zone	*entry, *n;
+
+	rbtree_postorder_for_each_entry_safe(entry, n,
+				&system_blks->root, node)
+		kmem_cache_free(ext4_system_zone_cachep, entry);
+}
+
 /*
  * Mark a range of blocks as belonging to the "system zone" --- that
  * is, filesystem metadata blocks which should never be used by
  * inodes.
  */
-static int add_system_zone(struct ext4_sb_info *sbi,
+static int add_system_zone(struct ext4_system_blocks *system_blks,
 			   ext4_fsblk_t start_blk,
 			   unsigned int count)
 {
 	struct ext4_system_zone *new_entry = NULL, *entry;
-	struct rb_node **n = &sbi->system_blks.rb_node, *node;
+	struct rb_node **n = &system_blks->root.rb_node, *node;
 	struct rb_node *parent = NULL, *new_node = NULL;
 
 	while (*n) {
@@ -91,7 +101,7 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 		new_node = &new_entry->node;
 
 		rb_link_node(new_node, parent, n);
-		rb_insert_color(new_node, &sbi->system_blks);
+		rb_insert_color(new_node, &system_blks->root);
 	}
 
 	/* Can we merge to the left? */
@@ -101,7 +111,7 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 		if (can_merge(entry, new_entry)) {
 			new_entry->start_blk = entry->start_blk;
 			new_entry->count += entry->count;
-			rb_erase(node, &sbi->system_blks);
+			rb_erase(node, &system_blks->root);
 			kmem_cache_free(ext4_system_zone_cachep, entry);
 		}
 	}
@@ -112,7 +122,7 @@ static int add_system_zone(struct ext4_sb_info *sbi,
 		entry = rb_entry(node, struct ext4_system_zone, node);
 		if (can_merge(new_entry, entry)) {
 			new_entry->count += entry->count;
-			rb_erase(node, &sbi->system_blks);
+			rb_erase(node, &system_blks->root);
 			kmem_cache_free(ext4_system_zone_cachep, entry);
 		}
 	}
@@ -126,7 +136,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 	int first = 1;
 
 	printk(KERN_INFO "System zones: ");
-	node = rb_first(&sbi->system_blks);
+	node = rb_first(&sbi->system_blks->root);
 	while (node) {
 		entry = rb_entry(node, struct ext4_system_zone, node);
 		printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
@@ -137,7 +147,47 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 	printk(KERN_CONT "\n");
 }
 
-static int ext4_protect_reserved_inode(struct super_block *sb, u32 ino)
+/*
+ * Returns 1 if the passed-in block region (start_blk,
+ * start_blk+count) is valid; 0 if some part of the block region
+ * overlaps with filesystem metadata blocks.
+ */
+static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
+				     struct ext4_system_blocks *system_blks,
+				     ext4_fsblk_t start_blk,
+				     unsigned int count)
+{
+	struct ext4_system_zone *entry;
+	struct rb_node *n;
+
+	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (start_blk + count < start_blk) ||
+	    (start_blk + count > ext4_blocks_count(sbi->s_es))) {
+		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
+		return 0;
+	}
+
+	if (system_blks == NULL)
+		return 1;
+
+	n = system_blks->root.rb_node;
+	while (n) {
+		entry = rb_entry(n, struct ext4_system_zone, node);
+		if (start_blk + count - 1 < entry->start_blk)
+			n = n->rb_left;
+		else if (start_blk >= (entry->start_blk + entry->count))
+			n = n->rb_right;
+		else {
+			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int ext4_protect_reserved_inode(struct super_block *sb,
+				       struct ext4_system_blocks *system_blks,
+				       u32 ino)
 {
 	struct inode *inode;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -163,14 +213,15 @@ static int ext4_protect_reserved_inode(struct super_block *sb, u32 ino)
 		if (n == 0) {
 			i++;
 		} else {
-			if (!ext4_data_block_valid(sbi, map.m_pblk, n)) {
+			if (!ext4_data_block_valid_rcu(sbi, system_blks,
+						map.m_pblk, n)) {
 				ext4_error(sb, "blocks %llu-%llu from inode %u "
 					   "overlap system zone", map.m_pblk,
 					   map.m_pblk + map.m_len - 1, ino);
 				err = -EFSCORRUPTED;
 				break;
 			}
-			err = add_system_zone(sbi, map.m_pblk, n);
+			err = add_system_zone(system_blks, map.m_pblk, n);
 			if (err < 0)
 				break;
 			i += n;
@@ -180,94 +231,129 @@ static int ext4_protect_reserved_inode(struct super_block *sb, u32 ino)
 	return err;
 }
 
+static void ext4_destroy_system_zone(struct rcu_head *rcu)
+{
+	struct ext4_system_blocks *system_blks;
+
+	system_blks = container_of(rcu, struct ext4_system_blocks, rcu);
+	release_system_zone(system_blks);
+	kfree(system_blks);
+}
+
+/*
+ * Build system zone rbtree which is used for block validity checking.
+ *
+ * The update of system_blks pointer in this function is protected by
+ * sb->s_umount semaphore. However we have to be careful as we can be
+ * racing with ext4_data_block_valid() calls reading system_blks rbtree
+ * protected only by RCU. That's why we first build the rbtree and then
+ * swap it in place.
+ */
 int ext4_setup_system_zone(struct super_block *sb)
 {
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
 	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	if (!test_opt(sb, BLOCK_VALIDITY)) {
-		if (sbi->system_blks.rb_node)
+		if (sbi->system_blks)
 			ext4_release_system_zone(sb);
 		return 0;
 	}
-	if (sbi->system_blks.rb_node)
+	if (sbi->system_blks)
 		return 0;
 
+	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
+	if (!system_blks)
+		return -ENOMEM;
+
 	for (i=0; i < ngroups; i++) {
 		cond_resched();
 		if (ext4_bg_has_super(sb, i) &&
 		    ((i < 5) || ((i % flex_size) == 0)))
-			add_system_zone(sbi, ext4_group_first_block_no(sb, i),
+			add_system_zone(system_blks,
+					ext4_group_first_block_no(sb, i),
 					ext4_bg_num_gdb(sb, i) + 1);
 		gdp = ext4_get_group_desc(sb, i, NULL);
-		ret = add_system_zone(sbi, ext4_block_bitmap(sb, gdp), 1);
+		ret = add_system_zone(system_blks,
+				ext4_block_bitmap(sb, gdp), 1);
 		if (ret)
-			return ret;
-		ret = add_system_zone(sbi, ext4_inode_bitmap(sb, gdp), 1);
+			goto err;
+		ret = add_system_zone(system_blks,
+				ext4_inode_bitmap(sb, gdp), 1);
 		if (ret)
-			return ret;
-		ret = add_system_zone(sbi, ext4_inode_table(sb, gdp),
+			goto err;
+		ret = add_system_zone(system_blks,
+				ext4_inode_table(sb, gdp),
 				sbi->s_itb_per_group);
 		if (ret)
-			return ret;
+			goto err;
 	}
 	if (ext4_has_feature_journal(sb) && sbi->s_es->s_journal_inum) {
-		ret = ext4_protect_reserved_inode(sb,
+		ret = ext4_protect_reserved_inode(sb, system_blks,
 				le32_to_cpu(sbi->s_es->s_journal_inum));
 		if (ret)
-			return ret;
+			goto err;
 	}
 
+	/*
+	 * System blks rbtree complete, announce it once to prevent racing
+	 * with ext4_data_block_valid() accessing the rbtree at the same
+	 * time.
+	 */
+	rcu_assign_pointer(sbi->system_blks, system_blks);
+
 	if (test_opt(sb, DEBUG))
 		debug_print_tree(sbi);
 	return 0;
+err:
+	release_system_zone(system_blks);
+	kfree(system_blks);
+	return ret;
 }
 
-/* Called when the filesystem is unmounted */
+/*
+ * Called when the filesystem is unmounted or when remounting it with
+ * noblock_validity specified.
+ *
+ * The update of system_blks pointer in this function is protected by
+ * sb->s_umount semaphore. However we have to be careful as we can be
+ * racing with ext4_data_block_valid() calls reading system_blks rbtree
+ * protected only by RCU. So we first clear the system_blks pointer and
+ * then free the rbtree only after RCU grace period expires.
+ */
 void ext4_release_system_zone(struct super_block *sb)
 {
-	struct ext4_system_zone	*entry, *n;
+	struct ext4_system_blocks *system_blks;
 
-	rbtree_postorder_for_each_entry_safe(entry, n,
-			&EXT4_SB(sb)->system_blks, node)
-		kmem_cache_free(ext4_system_zone_cachep, entry);
+	system_blks = rcu_dereference(EXT4_SB(sb)->system_blks);
+	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
 
-	EXT4_SB(sb)->system_blks = RB_ROOT;
+	if (system_blks)
+		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
 }
 
-/*
- * Returns 1 if the passed-in block region (start_blk,
- * start_blk+count) is valid; 0 if some part of the block region
- * overlaps with filesystem metadata blocks.
- */
 int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 			  unsigned int count)
 {
-	struct ext4_system_zone *entry;
-	struct rb_node *n = sbi->system_blks.rb_node;
+	struct ext4_system_blocks *system_blks;
+	int ret;
 
-	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
-	    (start_blk + count < start_blk) ||
-	    (start_blk + count > ext4_blocks_count(sbi->s_es))) {
-		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
-		return 0;
-	}
-	while (n) {
-		entry = rb_entry(n, struct ext4_system_zone, node);
-		if (start_blk + count - 1 < entry->start_blk)
-			n = n->rb_left;
-		else if (start_blk >= (entry->start_blk + entry->count))
-			n = n->rb_right;
-		else {
-			sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
-			return 0;
-		}
-	}
-	return 1;
+	/*
+	 * Lock the system zone to prevent it being released concurrently
+	 * when doing a remount which inverse current "[no]block_validity"
+	 * mount option.
+	 */
+	rcu_read_lock();
+	system_blks = rcu_dereference(sbi->system_blks);
+	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
+					count);
+	rcu_read_unlock();
+	return ret;
 }
 
 int ext4_check_blockref(const char *function, unsigned int line,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa..c025efc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -185,6 +185,14 @@ struct ext4_map_blocks {
 };
 
 /*
+ * Block validity checking, system zone rbtree.
+ */
+struct ext4_system_blocks {
+	struct rb_root root;
+	struct rcu_head rcu;
+};
+
+/*
  * Flags for ext4_io_end->flags
  */
 #define	EXT4_IO_END_UNWRITTEN	0x0001
@@ -1421,7 +1429,7 @@ struct ext4_sb_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
-	struct rb_root system_blks;
+	struct ext4_system_blocks __rcu *system_blks;
 
 #ifdef EXTENTS_STATS
 	/* ext4 extents stats */
-- 
2.7.4

