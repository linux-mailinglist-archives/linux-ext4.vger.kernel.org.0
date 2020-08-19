Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143EF249782
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHSHbx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHSHbV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514EC061389
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so10962242pgl.11
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeVazqsuvE+plWh7AV3NDjzECC9t3ZgXLAv/gKmrVaE=;
        b=SvQT8UeaNQhI+pp1bzCGAiKYWgIJ8Kmvd6yX8MiXQPfTz81S0sI/7gYgGRcEWkQRfu
         JaRSaCVMH1VYXZDUF0imEFmXizGqHuunelCfCNMjeoWFHN4agqoFq74QzsiIDiZwxb7s
         En1rhXKaF5VsZmMpqBLjhGcXOAuwTRazUb21/8+AwPmJ8ZpWiJd7dntUxAx3Hr4U5H80
         6f9Z1Y25oFcfXMw0SMw+SnWMSNp5U1lBwrw/nv9CvqzZU4XY+gheP2aD4GHONwkVpoPB
         A7yXupdbWhP1JyZujnMYo95j7wokLWMsYa8E/5IzLZw5qUzjGn+WoZJVyzrSn5LENpMQ
         N38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeVazqsuvE+plWh7AV3NDjzECC9t3ZgXLAv/gKmrVaE=;
        b=Q95suP3SUqxmWCn38Cw/RND3csdrKrcQ2aU3tLV2ZJMW+oFWY2zsPnukxnenwkwO7w
         UqtHNLW7POfc9pWhQg0QOktB5q2FoxORVnq8lCBWQig2AtOu4AuM1PZ5utJ+OI28kOnH
         6Lo30rF7uD+HPXBP5jKYwJoWkk0LOUt3Goz+fpieTanNQlJaeKhyKsIZSUkySVGNWOMb
         fSZmhRQlLYoeynHoEhOefg99UgweuMX0oDkdF6mLhaJMAYpS1BlaLnlwyTLifIjRBNHV
         qUptTlXTBwnGWoa/O7c3s8YFDJtrtRyHSKfuXN1cDdTui9+tOd0YbZ5LGrw9I3olXr3A
         P4Ng==
X-Gm-Message-State: AOAM533VipBDpEHeeXKR2liq4/r0vc0/gBllMsnnwyBS84a2hlEq1T82
        KE3XUNE9X0KbEOWkTHkFogsekP4zR/k=
X-Google-Smtp-Source: ABdhPJwlHnrAs1+JPetv/sujEDGNmxSzsayxAtsufaPlGR6CcjJjS1xgbhkJdL76vyAmzuN4t5LjPQ==
X-Received: by 2002:a62:ac05:: with SMTP id v5mr18565762pfe.8.1597822279824;
        Wed, 19 Aug 2020 00:31:19 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:18 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/9] ext4: add freespace tree allocator
Date:   Wed, 19 Aug 2020 00:30:58 -0700
Message-Id: <20200819073104.1141705-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Yuexin Li <lyx1209@gmail.com>

This patch adds a new freespace tree allocator. The allocator
organizes free space regions in a couple of in-memory rbtrees, one
sorted by length and the other by offset. We use these per-flex-bg
level trees to quickly scan length sorted free space regions and
determine the best region for a given request. This feature can be
enabled by passing "-o freespace_tree" mount option.

Signed-off-by: Yuexin Li <lyx1209@gmail.com>
Co-developed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  45 +++
 fs/ext4/mballoc.c | 984 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |  61 ++-
 fs/ext4/resize.c  |   8 +
 fs/ext4/super.c   |  35 +-
 5 files changed, 1084 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4df6f429de1a..3bb2675d4d40 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -363,6 +363,7 @@ struct flex_groups {
 	atomic64_t	free_clusters;
 	atomic_t	free_inodes;
 	atomic_t	used_dirs;
+	struct ext4_frsp_tree	*frsp_tree;
 };
 
 #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
@@ -1197,6 +1198,12 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+
+#define EXT4_MOUNT2_FREESPACE_TREE	0x00000020 /* Enable freespace tree
+						    * allocator (turns buddy
+						    * allocator off)
+						    */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1402,6 +1409,30 @@ struct ext4_super_block {
 #define ext4_has_strict_mode(sbi) \
 	(sbi->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL)
 
+/*
+ * Freespace tree structure
+ */
+struct ext4_frsp_tree {
+	struct rb_root_cached frsp_offset_root;		/* Root for offset
+							 * sorted tree
+							 */
+	struct rb_root_cached frsp_len_root;		/* Root for Length
+							 * sorted tree
+							 */
+	struct mutex frsp_lock;
+	__u8 frsp_flags;
+	__u32 frsp_max_free_len;			/* Max free extent in
+							 * this flex bg
+							 */
+	__u32 frsp_index;				/* Tree index (flex bg
+							 * number)
+							 */
+};
+
+/* Freespace tree flags */
+
+/* Tree is loaded in memory */
+#define EXT4_MB_FRSP_FLAG_LOADED			0x0001
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1539,6 +1570,9 @@ struct ext4_sb_info {
 	struct flex_groups * __rcu *s_flex_groups;
 	ext4_group_t s_flex_groups_allocated;
 
+	/* freespace trees stuff */
+	int s_mb_num_frsp_trees;
+
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
 
@@ -2653,6 +2687,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
 extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 
 /* mballoc.c */
+extern int ext4_mb_add_frsp_trees(struct super_block *sb, int ngroups);
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
@@ -3084,6 +3119,16 @@ static inline ext4_group_t ext4_flex_group(struct ext4_sb_info *sbi,
 	return block_group >> sbi->s_log_groups_per_flex;
 }
 
+static inline struct ext4_frsp_tree *
+ext4_get_frsp_tree(struct super_block *sb, ext4_group_t flex_bg)
+{
+	struct flex_groups *fg;
+
+	fg = sbi_array_rcu_deref(EXT4_SB(sb), s_flex_groups, flex_bg);
+
+	return fg->frsp_tree;
+}
+
 static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
 {
 	return 1 << sbi->s_log_groups_per_flex;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2d8d3d9c7918..74bdc2dcb49c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -333,6 +333,7 @@
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
 static struct kmem_cache *ext4_free_data_cachep;
+static struct kmem_cache *ext4_freespace_node_cachep;
 
 /* We create slab caches for groupinfo data structures based on the
  * superblock block size.  There will be one per mounted filesystem for
@@ -352,6 +353,11 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
+static int ext4_mb_load_allocator(struct super_block *sb, ext4_group_t group,
+			      struct ext4_buddy *e4b, int flags);
+static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex);
+static void ext4_mb_unload_allocator(struct ext4_buddy *e4b);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -395,6 +401,33 @@ static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
 	return addr;
 }
 
+static inline int ext4_blkno_to_flex_offset(struct super_block *sb,
+			ext4_fsblk_t blkno)
+{
+	return blkno % (ext4_flex_bg_size(EXT4_SB(sb)) *
+				EXT4_SB(sb)->s_blocks_per_group);
+}
+
+static inline ext4_fsblk_t ext4_flex_offset_to_blkno(struct super_block *sb,
+			int flex_bg, int flex_offset)
+{
+	return flex_bg * ext4_flex_bg_size(EXT4_SB(sb)) *
+		EXT4_SB(sb)->s_blocks_per_group + flex_offset;
+}
+
+static inline int ext4_mb_frsp_on(struct super_block *sb)
+{
+	return test_opt2(sb, FREESPACE_TREE) &&
+			EXT4_SB(sb)->s_es->s_log_groups_per_flex;
+}
+
+static inline unsigned int ext4_num_grps_to_flexbg(struct super_block *sb,
+							int ngroups)
+{
+	return (ngroups + ext4_flex_bg_size(EXT4_SB(sb)) - 1) >>
+			(EXT4_SB(sb)->s_es->s_log_groups_per_flex);
+}
+
 static inline int mb_test_bit(int bit, void *addr)
 {
 	/*
@@ -453,6 +486,7 @@ static void *mb_find_buddy(struct ext4_buddy *e4b, int order, int *max)
 {
 	char *bb;
 
+	WARN_ON(ext4_mb_frsp_on(e4b->bd_sb));
 	BUG_ON(e4b->bd_bitmap == e4b->bd_buddy);
 	BUG_ON(max == NULL);
 
@@ -620,6 +654,9 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	void *buddy;
 	void *buddy2;
 
+	if (ext4_mb_frsp_on(sb))
+		return 0;
+
 	{
 		static int mb_check_counter;
 		if (mb_check_counter++ % 100 != 0)
@@ -706,6 +743,729 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 #define mb_check_buddy(e4b)
 #endif
 
+/* Generic macro for inserting a new node in cached rbtree */
+#define ext4_mb_rb_insert(__root, __new, __node_t, __entry, __cmp)	do {	\
+	struct rb_node **iter = &((__root)->rb_root.rb_node), *parent = NULL;	\
+	bool leftmost = true;							\
+	__node_t *this = NULL;							\
+										\
+	while (*iter) {								\
+		this = rb_entry(*iter, __node_t, __entry);			\
+		parent = *iter;							\
+		if (__cmp((__new), this)) {					\
+			iter = &((*iter)->rb_left);				\
+		} else {							\
+			iter = &((*iter)->rb_right);				\
+			leftmost = false;					\
+		}								\
+	}									\
+	rb_link_node(&(__new)->__entry, parent, iter);				\
+	rb_insert_color_cached(&(__new)->__entry, __root, leftmost);		\
+} while (0)
+
+static inline int ext4_mb_frsp_offset_cmp(struct ext4_frsp_node *arg1,
+					  struct ext4_frsp_node *arg2)
+{
+	return (arg1->frsp_offset < arg2->frsp_offset);
+}
+
+/*
+ * Free space extents length sorting function, the nodes are sorted in
+ * decreasing order of length
+ */
+static inline int ext4_mb_frsp_len_cmp(struct ext4_frsp_node *arg1,
+				       struct ext4_frsp_node *arg2)
+{
+	return (arg1->frsp_len > arg2->frsp_len);
+}
+
+/* insert to offset-indexed tree */
+static void ext4_mb_frsp_insert_off(struct ext4_frsp_tree *tree,
+				struct ext4_frsp_node *new_entry)
+{
+	memset(&new_entry->frsp_node, 0, sizeof(new_entry->frsp_node));
+	ext4_mb_rb_insert(&tree->frsp_offset_root, new_entry,
+		struct ext4_frsp_node, frsp_node, ext4_mb_frsp_offset_cmp);
+}
+
+/* insert to tree sorted by length */
+static void ext4_mb_frsp_insert_len(struct ext4_frsp_tree *tree,
+				struct ext4_frsp_node *new_entry)
+{
+	memset(&new_entry->frsp_len_node, 0, sizeof(new_entry->frsp_len_node));
+	ext4_mb_rb_insert(&tree->frsp_len_root, new_entry,
+		struct ext4_frsp_node, frsp_len_node,
+		ext4_mb_frsp_len_cmp);
+}
+
+#ifdef CONFIG_EXT4_DEBUG
+/* print freespace_tree in pre-order traversal */
+void ext4_mb_frsp_print_tree_len(struct super_block *sb,
+					struct ext4_frsp_tree *tree)
+{
+	unsigned int count = 0;
+	ext4_fsblk_t blk = 0, blk_end = 0;
+	ext4_group_t group = 0, group_end = 0;
+	struct ext4_frsp_node *entry = NULL;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct rb_node *cur;
+
+	cur = rb_first_cached(&tree->frsp_len_root);
+	mb_debug(sb, "\nTree\tNode\tlength\tblock\tgroup\n");
+
+	while (cur) {
+		entry = rb_entry(cur, struct ext4_frsp_node, frsp_len_node);
+		count++;
+		blk = ext4_flex_offset_to_blkno(sb, tree->frsp_index,
+			entry->frsp_offset);
+		blk_end = ext4_flex_offset_to_blkno(sb, tree->frsp_index,
+			entry->frsp_offset + entry->frsp_len - 1);
+		group = blk / sbi->s_blocks_per_group;
+		group_end = (blk_end-1) / sbi->s_blocks_per_group;
+		mb_debug(sb, "%u\t%u\t%u\t%u(%lld)--%llu\t%u--%u\n",
+			tree->frsp_index, count, entry->frsp_len,
+			entry->frsp_offset, blk, blk_end, group, group_end);
+		cur = rb_next(cur);
+	}
+}
+#endif
+
+static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
+{
+	struct ext4_frsp_node *node;
+
+	node = kmem_cache_alloc(ext4_freespace_node_cachep, GFP_NOFS);
+	if (!node)
+		return NULL;
+
+	RB_CLEAR_NODE(&node->frsp_node);
+	RB_CLEAR_NODE(&node->frsp_len_node);
+
+	return node;
+}
+
+static void ext4_mb_frsp_free_node(struct super_block *sb,
+		struct ext4_frsp_node *node)
+{
+	kmem_cache_free(ext4_freespace_node_cachep, node);
+}
+
+/* Evict a tree from memory */
+void ext4_mb_frsp_free_tree(struct super_block *sb, struct ext4_frsp_tree *tree)
+{
+	struct ext4_frsp_node *frsp_node;
+	struct rb_node *node;
+
+	mb_debug(sb, "Evicting tree %d\n", tree->frsp_index);
+	mutex_lock(&tree->frsp_lock);
+	if (!(tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED))
+		goto out;
+
+	node = rb_first_cached(&tree->frsp_offset_root);
+	while (node) {
+		frsp_node = rb_entry(node, struct ext4_frsp_node, frsp_node);
+		rb_erase_cached(node, &tree->frsp_offset_root);
+		rb_erase_cached(&frsp_node->frsp_len_node,
+				&tree->frsp_len_root);
+		ext4_mb_frsp_free_node(sb, frsp_node);
+		node = rb_first_cached(&tree->frsp_offset_root);
+	}
+	tree->frsp_flags &= ~EXT4_MB_FRSP_FLAG_LOADED;
+	tree->frsp_offset_root = RB_ROOT_CACHED;
+	tree->frsp_len_root = RB_ROOT_CACHED;
+out:
+	mutex_unlock(&tree->frsp_lock);
+}
+
+/*
+ * Search tree by flexbg offset. Returns the node containing "target". If
+ * no such node is present, returns NULL. Must be called with tree mutex held.
+ */
+struct ext4_frsp_node *ext4_mb_frsp_search_by_off(struct super_block *sb,
+				struct ext4_frsp_tree *tree,
+				ext4_grpblk_t target)
+{
+	struct rb_root *root = &tree->frsp_offset_root.rb_root;
+	struct rb_node *node = root->rb_node;
+	struct ext4_frsp_node *this = NULL;
+
+	while (node) {
+		this = rb_entry(node, struct ext4_frsp_node, frsp_node);
+		if (this->frsp_offset == target)
+			return this;
+		else if (target < this->frsp_offset)
+			node = node->rb_left;
+		else
+			node = node->rb_right;
+	}
+	return NULL;
+}
+
+/*
+ * Check if two entries in freespace tree can be merged together. Nodes
+ * can merge together only if they are physically contiguous and belong
+ * to the same block group.
+ */
+int ext4_mb_frsp_node_can_merge(struct super_block *sb,
+	struct ext4_frsp_node *prev_entry, struct ext4_frsp_node *cur_entry)
+{
+	if (prev_entry->frsp_offset + prev_entry->frsp_len !=
+		cur_entry->frsp_offset)
+		return 0;
+	if (prev_entry->frsp_offset / EXT4_SB(sb)->s_blocks_per_group !=
+		cur_entry->frsp_offset / EXT4_SB(sb)->s_blocks_per_group)
+		return 0;
+	return 1;
+}
+
+/*
+ * Add new free space region to tree. We insert the new node in both, the
+ * length sorted and the flex-bg offset sorted trees. Must be called with
+ * tree mutex held.
+ */
+int ext4_mb_frsp_add_region(struct super_block *sb, struct ext4_frsp_tree *tree,
+				ext4_grpblk_t offset, ext4_grpblk_t len)
+{
+	struct ext4_frsp_node *new_entry = NULL, *next_entry = NULL,
+				*prev_entry = NULL;
+	struct rb_node *left = NULL, *right = NULL;
+
+	new_entry = ext4_mb_frsp_alloc_node(sb);
+	if (!new_entry)
+		return -ENOMEM;
+
+	new_entry->frsp_offset = offset;
+	new_entry->frsp_len = len;
+
+	ext4_mb_frsp_insert_off(tree, new_entry);
+	/* try merge to left and right */
+	/* left */
+	left = rb_prev(&new_entry->frsp_node);
+	if (left) {
+		prev_entry = rb_entry(left, struct ext4_frsp_node, frsp_node);
+		if (ext4_mb_frsp_node_can_merge(sb, prev_entry, new_entry)) {
+			new_entry->frsp_offset = prev_entry->frsp_offset;
+			new_entry->frsp_len += prev_entry->frsp_len;
+			rb_erase_cached(left, &tree->frsp_offset_root);
+			rb_erase_cached(&prev_entry->frsp_len_node,
+						&tree->frsp_len_root);
+			ext4_mb_frsp_free_node(sb, prev_entry);
+		}
+	}
+
+	/* right */
+	right = rb_next(&new_entry->frsp_node);
+	if (right) {
+		next_entry = rb_entry(right, struct ext4_frsp_node, frsp_node);
+		if (ext4_mb_frsp_node_can_merge(sb, new_entry, next_entry)) {
+			new_entry->frsp_len += next_entry->frsp_len;
+			rb_erase_cached(right, &tree->frsp_offset_root);
+			rb_erase_cached(&next_entry->frsp_len_node,
+						&tree->frsp_len_root);
+			ext4_mb_frsp_free_node(sb, next_entry);
+		}
+	}
+	ext4_mb_frsp_insert_len(tree, new_entry);
+
+	return 0;
+}
+
+/*
+ * Free length number of blocks starting at block number block in free space
+ * tree.
+ */
+int ext4_mb_frsp_free_blocks(struct super_block *sb, ext4_group_t group,
+				ext4_grpblk_t block, ext4_grpblk_t length)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_frsp_tree *tree =
+		ext4_get_frsp_tree(sb, ext4_flex_group(sbi, group));
+	int err = 0;
+
+	mutex_lock(&tree->frsp_lock);
+	err = ext4_mb_frsp_add_region(sb, tree,
+			ext4_blkno_to_flex_offset(sb, block), length);
+	mutex_unlock(&tree->frsp_lock);
+
+	return err;
+}
+
+/*
+ * Create freespace tree from on-disk bitmap. Must be called with tree mutex
+ * held. Returns 0 on success, error otherwise.
+ */
+int ext4_mb_frsp_bb_to_tree(struct ext4_buddy *e4b, ext4_group_t group,
+			struct buffer_head *bh)
+{
+	struct super_block *sb = e4b->bd_sb;
+	int length = 0, bit = 0, next;
+	int end = EXT4_SB(sb)->s_blocks_per_group;
+	ext4_fsblk_t block;
+	int ret = 0;
+
+	/* find all unused blocks in bitmap, convert them to new tree node */
+	while (bit < end) {
+		bit = mb_find_next_zero_bit(bh->b_data, end, bit);
+		if (bit >= end)
+			break;
+
+		next = mb_find_next_bit(bh->b_data, end, bit);
+		length = next - bit;
+		block = ext4_group_first_block_no(sb, group) + bit;
+
+		ret = ext4_mb_frsp_add_region(sb, e4b->frsp_tree,
+			ext4_blkno_to_flex_offset(sb, block), length);
+		if (ret)
+			break;
+		bit = next + 1;
+	}
+
+	return ret;
+}
+
+/*
+ * Load one freespace_tree from disk. Assume holding mutex lock on tree.
+ */
+int ext4_mb_frsp_load(struct ext4_buddy *e4b)
+{
+	ext4_group_t ngroups, group_start, group_end, grp;
+	struct ext4_sb_info *sbi = EXT4_SB(e4b->bd_sb);
+	int i, ret = 0;
+	struct buffer_head **bh = NULL;
+
+	if (e4b->frsp_tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED)
+		return 0;
+
+	group_start = e4b->frsp_tree->frsp_index * ext4_flex_bg_size(sbi);
+	group_end = min(group_start + ext4_flex_bg_size(sbi),
+			ext4_get_groups_count(e4b->bd_sb)) - 1;
+	ngroups = group_end - group_start + 1;
+
+	bh = kcalloc(ngroups, sizeof(*bh), GFP_KERNEL);
+	if (!bh)
+		return -ENOMEM;
+	for (i = 0; i < ngroups; i++) {
+		grp = i + group_start;
+		bh[i] = ext4_read_block_bitmap_nowait(e4b->bd_sb, grp, false);
+		if (IS_ERR(bh[i])) {
+			ret = PTR_ERR(bh[i]);
+			goto out;
+		}
+	}
+	for (i = 0; i < ngroups; i++) {
+		grp = i + group_start;
+		if (!bitmap_uptodate(bh[i])) {
+			ret = ext4_wait_block_bitmap(e4b->bd_sb, grp, bh[i]);
+			if (ret)
+				goto out;
+		}
+		ret = ext4_mb_frsp_bb_to_tree(e4b, grp, bh[i]);
+		if (ret)
+			goto out;
+	}
+	e4b->frsp_tree->frsp_flags |= EXT4_MB_FRSP_FLAG_LOADED;
+out:
+	for (i = 0; i < ngroups; i++) {
+		if (!IS_ERR_OR_NULL(bh[i]))
+			put_bh(bh[i]);
+		if (!ret && IS_ERR(bh[i]))
+			ret = PTR_ERR(bh[i]);
+	}
+	kfree(bh);
+	return ret;
+
+}
+
+/*
+ * Determine if node with length len is better than what we have found until
+ * now. Return 1 if that is the case, 0 otherwise. If len is exact match,
+ * set *best = 1.
+ */
+static int ext4_mb_frsp_is_better(struct ext4_allocation_context *ac,
+					int len, int *best)
+{
+	struct ext4_tree_extent *btx = &ac->ac_b_tree_ex;
+	struct ext4_free_extent *gex = &ac->ac_g_ex;
+
+	if (best)
+		*best = 0;
+	if (len == gex->fe_len) {
+		if (best)
+			*best = 1;
+		return 1;
+	}
+	if (ac->ac_criteria == 0 && len < gex->fe_len)
+		return 0;
+	/*
+	 * See if the new node is cloer to goal length than
+	 * the best extent found so far
+	 */
+	if (btx->te_len < gex->fe_len && len > btx->te_len)
+		return 1;
+	if (len > gex->fe_len && len < btx->te_len)
+		return 1;
+	return 0;
+}
+
+/*
+ * check if we have scanned sufficient freespace candidates
+ * stop scanning if reached/exceeded s_max_to_scan
+ */
+static void ext4_mb_frsp_check_limits(struct ext4_allocation_context *ac)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+
+	if (ac->ac_status == AC_STATUS_FOUND)
+		return;
+
+	/*
+	 * Exceeded max number of nodes to scan
+	 */
+	if (ac->ac_found > sbi->s_mb_max_to_scan &&
+			!(ac->ac_flags & EXT4_MB_HINT_FIRST))
+		ac->ac_status = AC_STATUS_BREAK;
+}
+
+/*
+ * Mark free space in selected tree node as used and update the tree.
+ * This must be called with tree lock.
+ */
+static void ext4_mb_frsp_use_best_found(struct ext4_allocation_context *ac,
+			ext4_group_t flex, struct ext4_frsp_node *selected)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_tree_extent *btx = &ac->ac_b_tree_ex;
+	struct ext4_free_extent *bex;
+	unsigned int group_no;
+	struct ext4_buddy e4b;
+
+	WARN_ON(ac->ac_status == AC_STATUS_FOUND);
+	btx->te_len = min(btx->te_len, ac->ac_g_ex.fe_len);
+	ac->ac_status = AC_STATUS_FOUND;
+
+	/* update ac best-found-extent */
+	bex = &ac->ac_b_ex;
+	group_no = (btx->te_flex * ext4_flex_bg_size(sbi)) +
+			(btx->te_flex_start / sbi->s_blocks_per_group);
+	bex->fe_start = btx->te_flex_start % sbi->s_blocks_per_group;
+	bex->fe_group = group_no;
+	bex->fe_len = btx->te_len;
+	bex->fe_node = selected;
+
+	/* Add free blocks to our tree */
+	ext4_mb_load_allocator(ac->ac_sb, group_no, &e4b,
+		EXT4_ALLOCATOR_FRSP_NOLOAD);
+	mb_mark_used(&e4b, bex);
+	ext4_mb_unload_allocator(&e4b);
+}
+/*
+ * The routine checks whether found tree node is good enough. If it is,
+ * then the tree node gets marked used and flag is set to the context
+ * to stop scanning.
+ *
+ * Otherwise, the tree node is compared with the previous found extent and
+ * if new one is better, then it's stored in the context.
+ *
+ * Later, the best found tree node will be used, if mballoc can't find good
+ * enough extent.
+ */
+static int ext4_mb_frsp_measure_node(struct ext4_allocation_context *ac,
+				int tree_idx, struct ext4_frsp_node *cur,
+				int goal)
+{
+	struct ext4_tree_extent *btx = &ac->ac_b_tree_ex;
+	ext4_fsblk_t start;
+	int best_found = 0, max;
+
+	WARN_ON(btx->te_len < 0);
+	WARN_ON(ac->ac_status != AC_STATUS_CONTINUE);
+
+	if (goal) {
+		start = ext4_group_first_block_no(ac->ac_sb,
+					ac->ac_g_ex.fe_group) +
+					ac->ac_g_ex.fe_start;
+		if (cur->frsp_offset > ext4_blkno_to_flex_offset(ac->ac_sb,
+						start))
+			return 0;
+		max = cur->frsp_offset + cur->frsp_len -
+			ext4_blkno_to_flex_offset(ac->ac_sb, start);
+		if (max >= ac->ac_g_ex.fe_len &&
+			ac->ac_g_ex.fe_len == EXT4_SB(ac->ac_sb)->s_stripe) {
+			if (do_div(start, EXT4_SB(ac->ac_sb)->s_stripe) != 0)
+				return 0;
+			best_found = 1;
+		} else if (max >= ac->ac_g_ex.fe_len) {
+			best_found = 1;
+		} else if (max > 0 && (ac->ac_flags & EXT4_MB_HINT_MERGE)) {
+			/*
+			 * Sometimes, caller may want to merge even small
+			 * number of blocks to an existing extent
+			 */
+			best_found = 1;
+
+		} else {
+			return 0;
+		}
+		ac->ac_found++;
+		goto use_extent;
+	}
+	ac->ac_found++;
+
+	/* The special case - take what you catch first */
+	if (unlikely(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
+		best_found = 1;
+		goto use_extent;
+	}
+
+	/*
+	 * Prefer not allocating blocks in first group in flex bg for data
+	 * blocks.
+	 */
+	if (unlikely((ac->ac_criteria < 2) &&
+			(ac->ac_flags & EXT4_MB_HINT_DATA) &&
+			(cur->frsp_offset < EXT4_BLOCKS_PER_GROUP(ac->ac_sb))))
+		return 1;
+
+
+	/* If this is first found extent, just store it in the context */
+	if (btx->te_len == 0)
+		goto use_extent;
+
+	if (ext4_mb_frsp_is_better(ac, cur->frsp_len, &best_found))
+		goto use_extent;
+
+	ext4_mb_frsp_check_limits(ac);
+	return 0;
+
+use_extent:
+	btx->te_flex = tree_idx;
+	if (goal) {
+		btx->te_flex_start = ext4_blkno_to_flex_offset(ac->ac_sb,
+								start);
+		btx->te_len = max;
+	} else {
+		btx->te_flex_start = cur->frsp_offset;
+		btx->te_len = cur->frsp_len;
+	}
+	if (best_found)
+		ext4_mb_frsp_use_best_found(ac, tree_idx, cur);
+	ext4_mb_frsp_check_limits(ac);
+	return 1;
+}
+
+/* Search by goal */
+static noinline_for_stack
+void ext4_mb_frsp_find_by_goal(struct ext4_allocation_context *ac)
+{
+	struct ext4_frsp_node *cur = NULL;
+	unsigned int tree_blk;
+	ext4_fsblk_t blk;
+	struct ext4_buddy e4b;
+	int ret;
+
+	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
+		return;
+
+	/* compute start node offset in tree */
+	blk = ext4_group_first_block_no(ac->ac_sb, ac->ac_g_ex.fe_group) +
+			ac->ac_g_ex.fe_start;
+	tree_blk = ext4_blkno_to_flex_offset(ac->ac_sb, blk);
+
+	ret = ext4_mb_load_allocator(ac->ac_sb, ac->ac_g_ex.fe_group, &e4b, 0);
+	if (ret)
+		return;
+
+	/* try goal block and its freespace_tree first */
+	mutex_lock(&e4b.frsp_tree->frsp_lock);
+	cur = ext4_mb_frsp_search_by_off(ac->ac_sb, e4b.frsp_tree, tree_blk);
+	if (cur && tree_blk < cur->frsp_offset + cur->frsp_len - 1)
+		ext4_mb_frsp_measure_node(ac, e4b.frsp_tree->frsp_index, cur,
+						1 /* searching by goal */);
+
+	mutex_unlock(&e4b.frsp_tree->frsp_lock);
+	ext4_mb_unload_allocator(&e4b);
+}
+
+static void ext4_mb_frsp_process(struct ext4_allocation_context *ac,
+				struct ext4_frsp_tree *tree)
+{
+	struct ext4_frsp_node *cur = NULL;
+	struct rb_node *node = NULL;
+	int ret;
+
+	node = rb_first_cached(&tree->frsp_len_root);
+	mb_debug(ac->ac_sb, "Processing tree index %d, flags = %x\n",
+			tree->frsp_index, tree->frsp_flags);
+	/*
+	 * In order to serve the "No data blocks in first group in a flexbg"
+	 * requirement, we cannot do a O(Log N) search here. TODO: it's possible
+	 * to that at CR=2, where that requirement doesn't apply.
+	 */
+	while (node && ac->ac_status == AC_STATUS_CONTINUE) {
+		cur = rb_entry(node, struct ext4_frsp_node, frsp_len_node);
+		if (ac->ac_criteria == 0 && cur->frsp_len < ac->ac_g_ex.fe_len)
+			return;
+		ret = ext4_mb_frsp_measure_node(ac, tree->frsp_index, cur,
+						0 /* searching by len */);
+		if (ret == 0)
+			return;
+		node = rb_next(node);
+	}
+}
+
+/* allocator for freespace_tree */
+static noinline_for_stack int
+ext4_mb_tree_allocator(struct ext4_allocation_context *ac)
+{
+	struct ext4_buddy e4b;
+	struct ext4_sb_info *sbi;
+	struct super_block *sb;
+	struct ext4_frsp_tree *tree = NULL;
+	struct ext4_frsp_node *cur = NULL;
+	struct ext4_tree_extent *btx = NULL;
+	int ret = 0, start_idx = 0, tree_idx, j;
+
+	sb = ac->ac_sb;
+	btx = &ac->ac_b_tree_ex;
+	sbi = EXT4_SB(sb);
+
+	start_idx = ext4_flex_group(sbi, ac->ac_g_ex.fe_group);
+	mb_debug(sb, "requested size %d\n", ac->ac_g_ex.fe_len);
+	/* First try searching from goal blk in start-idx-th freespace tree */
+	ext4_mb_frsp_find_by_goal(ac);
+	if (ac->ac_status == AC_STATUS_FOUND)
+		goto out;
+
+	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
+		goto out;
+
+	ac->ac_criteria = 0;
+	ac->ac_groups_scanned = 0;
+repeat:
+
+	/* Loop through the rest of trees (flex_bg) */
+	for (j = start_idx;
+		(ac->ac_groups_scanned < sbi->s_mb_num_frsp_trees) &&
+			ac->ac_status == AC_STATUS_CONTINUE; j++) {
+		ac->ac_groups_scanned++;
+		tree_idx = (j % sbi->s_mb_num_frsp_trees);
+
+		ret = ext4_mb_load_allocator(sb,
+				tree_idx * ext4_flex_bg_size(sbi), &e4b, 0);
+		if (ret)
+			goto out;
+		mutex_lock(&e4b.frsp_tree->frsp_lock);
+		ext4_mb_frsp_process(ac, e4b.frsp_tree);
+		mutex_unlock(&e4b.frsp_tree->frsp_lock);
+		ext4_mb_unload_allocator(&e4b);
+	}
+
+	if (ac->ac_status != AC_STATUS_FOUND) {
+		if (ac->ac_criteria < 2) {
+			ac->ac_criteria++;
+			ac->ac_groups_scanned = 0;
+			mb_debug(sb, "Falling back to CR=%d", ac->ac_criteria);
+			goto repeat;
+		}
+		if (btx->te_len > 0 && !(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
+			e4b.frsp_flags = 0;
+			ret = ext4_mb_load_allocator(sb, btx->te_flex *
+					ext4_flex_bg_size(sbi), &e4b, 0);
+			if (ret)
+				goto out;
+			tree = e4b.frsp_tree;
+			mutex_lock(&tree->frsp_lock);
+			cur = ext4_mb_frsp_search_by_off(sb, tree,
+					btx->te_flex_start);
+			if (cur) {
+				ext4_mb_frsp_use_best_found(ac, btx->te_flex,
+								cur);
+				mutex_unlock(&tree->frsp_lock);
+				ext4_mb_unload_allocator(&e4b);
+
+			} else {
+				/*
+				 * Someone else took this freespace node before
+				 * us. Reset the best-found tree extent, and
+				 * turn on FIRST HINT (greedy).
+				 */
+				mutex_unlock(&tree->frsp_lock);
+				ac->ac_b_tree_ex.te_flex_start = 0;
+				ac->ac_b_tree_ex.te_flex = 0;
+				ac->ac_b_tree_ex.te_len = 0;
+				ac->ac_status = AC_STATUS_CONTINUE;
+				ac->ac_flags |= EXT4_MB_HINT_FIRST;
+				ac->ac_groups_scanned = 0;
+				ext4_mb_unload_allocator(&e4b);
+				goto repeat;
+			}
+		}
+	}
+
+	ret = btx->te_len ? 0 : -ENOSPC;
+
+out:
+	return ret;
+}
+
+static void ext4_mb_frsp_init_tree(struct ext4_frsp_tree *tree, int index)
+{
+	tree->frsp_offset_root = RB_ROOT_CACHED;
+	tree->frsp_len_root = RB_ROOT_CACHED;
+	mutex_init(&(tree->frsp_lock));
+	tree->frsp_flags = 0;
+	tree->frsp_index = index;
+}
+
+int ext4_mb_init_freespace_trees(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct flex_groups *fg;
+	int i;
+
+	sbi->s_mb_num_frsp_trees =
+		ext4_num_grps_to_flexbg(sb, ext4_get_groups_count(sb));
+
+	for (i = 0; i < sbi->s_mb_num_frsp_trees; i++) {
+		fg = sbi_array_rcu_deref(sbi, s_flex_groups, i);
+		fg->frsp_tree = kzalloc(sizeof(struct ext4_frsp_tree),
+				GFP_KERNEL);
+		if (!fg->frsp_tree)
+			return -ENOMEM;
+		ext4_mb_frsp_init_tree(fg->frsp_tree, i);
+	}
+
+	return 0;
+}
+
+int ext4_mb_add_frsp_trees(struct super_block *sb, int ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int flex_bg_count, old_trees_count = sbi->s_mb_num_frsp_trees;
+	int i;
+
+	if (!ext4_mb_frsp_on(sb))
+		return 0;
+
+	flex_bg_count = ext4_num_grps_to_flexbg(sb, ngroups);
+	if (old_trees_count > 0)
+		ext4_mb_frsp_free_tree(sb, ext4_get_frsp_tree(sb,
+						old_trees_count - 1));
+
+	for (i = old_trees_count; i < flex_bg_count; i++) {
+		struct flex_groups *fg;
+
+		fg = sbi_array_rcu_deref(sbi, s_flex_groups, i);
+		fg->frsp_tree = kzalloc(sizeof(*fg->frsp_tree), GFP_KERNEL);
+		if (!fg->frsp_tree)
+			return -ENOMEM;
+		ext4_mb_frsp_init_tree(fg->frsp_tree, i);
+	}
+	sbi->s_mb_num_frsp_trees = flex_bg_count;
+
+	return 0;
+}
+
 /*
  * Divide blocks started from @first with length @len into
  * smaller chunks with power of 2 blocks.
@@ -1042,6 +1802,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	e4b->bd_buddy_page = NULL;
 	e4b->bd_bitmap_page = NULL;
 
+	if (ext4_mb_frsp_on(sb))
+		return 0;
+
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	/*
 	 * the buddy cache inode stores the block bitmap
@@ -1099,6 +1862,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	struct page *page;
 	int ret = 0;
 
+	WARN_ON(ext4_mb_frsp_on(sb));
 	might_sleep();
 	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
@@ -1156,6 +1920,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
  * Locking note:  This routine calls ext4_mb_init_cache(), which takes the
  * block group lock of all groups for this page; do not hold the BG lock when
  * calling this routine!
+ *
+ * For freespace trees, do not hold tree mutex while calling this routine.
+ * It is okay to hold that mutex only if EXT4_ALLOCATOR_FRSP_NOLOAD flag is
+ * set in e4b->frsp_flags. If that flag is set, this function doesn't try
+ * to load an unloaded tree.
  */
 static noinline_for_stack int
 ext4_mb_load_allocator_gfp(struct super_block *sb, ext4_group_t group,
@@ -1166,7 +1935,7 @@ ext4_mb_load_allocator_gfp(struct super_block *sb, ext4_group_t group,
 	int pnum;
 	int poff;
 	struct page *page;
-	int ret;
+	int ret = 0;
 	struct ext4_group_info *grp;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct inode *inode = sbi->s_buddy_cache;
@@ -1183,6 +1952,22 @@ ext4_mb_load_allocator_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_group = group;
 	e4b->bd_buddy_page = NULL;
 	e4b->bd_bitmap_page = NULL;
+	if (ext4_mb_frsp_on(sb)) {
+		e4b->frsp_tree = ext4_get_frsp_tree(sb,
+					ext4_flex_group(sbi, group));
+		e4b->frsp_flags = flags;
+		if (flags & EXT4_ALLOCATOR_FRSP_NOLOAD)
+			return 0;
+
+		mutex_lock(&e4b->frsp_tree->frsp_lock);
+		if (e4b->frsp_tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED) {
+			mutex_unlock(&e4b->frsp_tree->frsp_lock);
+			return 0;
+		}
+		ret = ext4_mb_frsp_load(e4b);
+		mutex_unlock(&e4b->frsp_tree->frsp_lock);
+		return ret;
+	}
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 		/*
@@ -1305,6 +2090,8 @@ static int ext4_mb_load_allocator(struct super_block *sb, ext4_group_t group,
 
 static void ext4_mb_unload_allocator(struct ext4_buddy *e4b)
 {
+	if (ext4_mb_frsp_on(e4b->bd_sb))
+		return;
 	if (e4b->bd_bitmap_page)
 		put_page(e4b->bd_bitmap_page);
 	if (e4b->bd_buddy_page)
@@ -1497,6 +2284,16 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	if (first < e4b->bd_info->bb_first_free)
 		e4b->bd_info->bb_first_free = first;
 
+	if (ext4_mb_frsp_on(sb)) {
+		ext4_grpblk_t first_blk = EXT4_C2B(EXT4_SB(sb), first) +
+			ext4_group_first_block_no(sb, e4b->bd_group);
+
+		ext4_unlock_group(sb, e4b->bd_group);
+		ext4_mb_frsp_free_blocks(sb, e4b->bd_group, first_blk, count);
+		ext4_lock_group(sb, e4b->bd_group);
+		return;
+	}
+
 	/* access memory sequentially: check left neighbour,
 	 * clear range and then check right neighbour
 	 */
@@ -1563,6 +2360,9 @@ static int mb_find_extent(struct ext4_buddy *e4b, int block,
 	assert_spin_locked(ext4_group_lock_ptr(e4b->bd_sb, e4b->bd_group));
 	BUG_ON(ex == NULL);
 
+	if (ext4_mb_frsp_on(e4b->bd_sb))
+		return 0;
+
 	buddy = mb_find_buddy(e4b, 0, &max);
 	BUG_ON(buddy == NULL);
 	BUG_ON(block >= max);
@@ -1627,17 +2427,74 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	unsigned ret = 0;
 	int len0 = len;
 	void *buddy;
+	ext4_grpblk_t flex_offset;
 
 	BUG_ON(start + len > (e4b->bd_sb->s_blocksize << 3));
 	BUG_ON(e4b->bd_group != ex->fe_group);
+
+	e4b->bd_info->bb_free -= len;
+	if (e4b->bd_info->bb_first_free == start)
+		e4b->bd_info->bb_first_free += len;
+
+	if (ext4_mb_frsp_on(e4b->bd_sb)) {
+		struct ext4_frsp_node *new;
+
+		flex_offset = ext4_blkno_to_flex_offset(e4b->bd_sb,
+					ext4_group_first_block_no(e4b->bd_sb,
+						e4b->bd_group) + ex->fe_start);
+		if (!ex->fe_node) {
+			ex->fe_node = ext4_mb_frsp_search_by_off(e4b->bd_sb,
+					e4b->frsp_tree, flex_offset);
+			if (!ex->fe_node)
+				return 0;
+		}
+		/*
+		 * Remove the node from the trees before we modify these since
+		 * we will change the length and / or offset of this node.
+		 */
+		rb_erase_cached(&ex->fe_node->frsp_node,
+					&e4b->frsp_tree->frsp_offset_root);
+		rb_erase_cached(&ex->fe_node->frsp_len_node,
+					&e4b->frsp_tree->frsp_len_root);
+		RB_CLEAR_NODE(&ex->fe_node->frsp_node);
+		RB_CLEAR_NODE(&ex->fe_node->frsp_len_node);
+		if (flex_offset > ex->fe_node->frsp_offset) {
+			if (flex_offset + ex->fe_len !=
+				ex->fe_node->frsp_offset +
+				ex->fe_node->frsp_len) {
+				/* Need to split the node */
+				new = ext4_mb_frsp_alloc_node(e4b->bd_sb);
+				if (!new)
+					return -ENOMEM;
+				new->frsp_offset = flex_offset + ex->fe_len;
+				new->frsp_len = (ex->fe_node->frsp_offset +
+					ex->fe_node->frsp_len) -
+					new->frsp_offset;
+				ext4_mb_frsp_insert_len(e4b->frsp_tree, new);
+				ext4_mb_frsp_insert_off(e4b->frsp_tree, new);
+			}
+			ex->fe_node->frsp_len = flex_offset -
+						ex->fe_node->frsp_offset;
+		} else if (ex->fe_len < ex->fe_node->frsp_len) {
+			/* used only a part: update node */
+			ex->fe_node->frsp_offset += ex->fe_len;
+			ex->fe_node->frsp_len -= ex->fe_len;
+		} else {
+			ext4_mb_frsp_free_node(e4b->bd_sb, ex->fe_node);
+			return 0;
+		}
+
+		ext4_mb_frsp_insert_len(e4b->frsp_tree, ex->fe_node);
+		ext4_mb_frsp_insert_off(e4b->frsp_tree, ex->fe_node);
+
+		return 0;
+	}
+
 	assert_spin_locked(ext4_group_lock_ptr(e4b->bd_sb, e4b->bd_group));
 	mb_check_buddy(e4b);
 	mb_mark_used_double(e4b, start, len);
 
 	this_cpu_inc(discard_pa_seq);
-	e4b->bd_info->bb_free -= len;
-	if (e4b->bd_info->bb_first_free == start)
-		e4b->bd_info->bb_first_free += len;
 
 	/* let's maintain fragments counter */
 	if (start != 0)
@@ -2778,6 +3635,13 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	rcu_read_lock();
 	kvfree(rcu_dereference(sbi->s_group_info));
 	rcu_read_unlock();
+	if (ext4_mb_frsp_on(sb)) {
+		for (i = 0; i < sbi->s_mb_num_frsp_trees; i++) {
+			struct ext4_frsp_tree *tree = ext4_get_frsp_tree(sb, i);
+
+			kfree(tree);
+		}
+	}
 	return -ENOMEM;
 }
 
@@ -2874,6 +3738,13 @@ int ext4_mb_init(struct super_block *sb)
 		i++;
 	} while (i <= sb->s_blocksize_bits + 1);
 
+	/* init for freespace trees */
+	if (ext4_mb_frsp_on(sb)) {
+		ret = ext4_mb_init_freespace_trees(sb);
+		if (ret)
+			goto out;
+	}
+
 	spin_lock_init(&sbi->s_md_lock);
 	spin_lock_init(&sbi->s_bal_lock);
 	sbi->s_mb_free_pending = 0;
@@ -2940,6 +3811,13 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
 	sbi->s_mb_maxs = NULL;
+	if (ext4_mb_frsp_on(sb)) {
+		for (i = 0; i < sbi->s_mb_num_frsp_trees; i++) {
+			struct ext4_frsp_tree *tree = ext4_get_frsp_tree(sb, i);
+
+			kfree(tree);
+		}
+	}
 	return ret;
 }
 
@@ -3084,8 +3962,10 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
-		put_page(e4b.bd_buddy_page);
-		put_page(e4b.bd_bitmap_page);
+		if (!ext4_mb_frsp_on(sb)) {
+			put_page(e4b.bd_buddy_page);
+			put_page(e4b.bd_bitmap_page);
+		}
 	}
 	ext4_unlock_group(sb, entry->efd_group);
 	kmem_cache_free(ext4_free_data_cachep, entry);
@@ -3163,9 +4043,14 @@ int __init ext4_init_mballoc(void)
 					   SLAB_RECLAIM_ACCOUNT);
 	if (ext4_free_data_cachep == NULL)
 		goto out_ac_free;
+	ext4_freespace_node_cachep = KMEM_CACHE(ext4_frsp_node,
+						SLAB_RECLAIM_ACCOUNT);
+	if (ext4_freespace_node_cachep == NULL)
+		goto out_frsp_free;
 
 	return 0;
-
+out_frsp_free:
+	kmem_cache_destroy(ext4_free_data_cachep);
 out_ac_free:
 	kmem_cache_destroy(ext4_ac_cachep);
 out_pa_free:
@@ -3184,6 +4069,7 @@ void ext4_exit_mballoc(void)
 	kmem_cache_destroy(ext4_pspace_cachep);
 	kmem_cache_destroy(ext4_ac_cachep);
 	kmem_cache_destroy(ext4_free_data_cachep);
+	kmem_cache_destroy(ext4_freespace_node_cachep);
 	ext4_groupinfo_destroy_slabs();
 }
 
@@ -3686,6 +4572,9 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
+	if (ext4_mb_frsp_on(ac->ac_sb))
+		return 0;
+
 	/* first, try per-file preallocation */
 	rcu_read_lock();
 	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
@@ -4362,6 +5251,8 @@ static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
 	struct ext4_prealloc_space *pa;
 
 	BUG_ON(ext4_pspace_cachep == NULL);
+	if (ext4_mb_frsp_on(ac->ac_sb))
+		return 0;
 	pa = kmem_cache_zalloc(ext4_pspace_cachep, GFP_NOFS);
 	if (!pa)
 		return -ENOMEM;
@@ -4374,6 +5265,8 @@ static void ext4_mb_pa_free(struct ext4_allocation_context *ac)
 {
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 
+	if (ext4_mb_frsp_on(ac->ac_sb))
+		return;
 	BUG_ON(!pa);
 	ac->ac_pa = NULL;
 	WARN_ON(!atomic_dec_and_test(&pa->pa_count));
@@ -4547,6 +5440,13 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	ac->ac_o_ex.fe_len = len;
 	ac->ac_g_ex = ac->ac_o_ex;
 	ac->ac_flags = ar->flags;
+	if (ext4_mb_frsp_on(sb))
+		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
+
+	/* set up best-found tree node */
+	ac->ac_b_tree_ex.te_flex_start = 0;
+	ac->ac_b_tree_ex.te_flex = 0;
+	ac->ac_b_tree_ex.te_len = 0;
 
 	/* we have to define context: we'll we work with a file or
 	 * locality group. this is a policy, actually */
@@ -4867,7 +5767,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			goto errout;
 repeat:
 		/* allocate space in core */
-		*errp = ext4_mb_regular_allocator(ac);
+		if (ext4_mb_frsp_on(sb))
+			*errp = ext4_mb_tree_allocator(ac);
+		else
+			*errp = ext4_mb_regular_allocator(ac);
+
 		/*
 		 * pa allocated above is added to grp->bb_prealloc_list only
 		 * when we were able to allocate some block i.e. when
@@ -4880,8 +5784,13 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
 		}
-		if (ac->ac_status == AC_STATUS_FOUND &&
-			ac->ac_o_ex.fe_len >= ac->ac_f_ex.fe_len)
+		/*
+		 * Freespace trees should never return more than what was asked
+		 * for.
+		 */
+		if (!ext4_mb_frsp_on(sb) &&
+			(ac->ac_status == AC_STATUS_FOUND &&
+			ac->ac_o_ex.fe_len >= ac->ac_f_ex.fe_len))
 			ext4_mb_pa_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
@@ -4972,13 +5881,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	struct rb_node *parent = NULL, *new_node;
 
 	BUG_ON(!ext4_handle_valid(handle));
-	BUG_ON(e4b->bd_bitmap_page == NULL);
-	BUG_ON(e4b->bd_buddy_page == NULL);
+	BUG_ON(!ext4_mb_frsp_on(sb) && e4b->bd_bitmap_page == NULL);
 
 	new_node = &new_entry->efd_node;
 	cluster = new_entry->efd_start_cluster;
 
-	if (!*n) {
+	if (!*n && !ext4_mb_frsp_on(sb)) {
 		/* first free block exent. We need to
 		   protect buddy cache from being freed,
 		 * otherwise we'll refresh it from
@@ -5457,6 +6365,7 @@ __acquires(bitlock)
 	ex.fe_start = start;
 	ex.fe_group = group;
 	ex.fe_len = count;
+	ex.fe_node = NULL;
 
 	/*
 	 * Mark blocks used, so no one can reuse them while
@@ -5496,6 +6405,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	void *bitmap;
 	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
+	struct buffer_head *bh = NULL;
 	int ret = 0;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
@@ -5506,7 +6416,17 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
+
+	if (ext4_mb_frsp_on(sb)) {
+		bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bh)) {
+			ret = PTR_ERR(bh);
+			goto out;
+		}
+		bitmap = bh->b_data;
+	} else {
+		bitmap = e4b.bd_bitmap;
+	}
 
 	ext4_lock_group(sb, group);
 	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
@@ -5553,6 +6473,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
 	}
 out:
+	if (!IS_ERR_OR_NULL(bh))
+		brelse(bh);
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_allocator(&e4b);
 
@@ -5613,7 +6535,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
 		/* We only do this if the grp has never been initialized */
-		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
+		if (unlikely(!ext4_mb_frsp_on(sb) && EXT4_MB_GRP_NEED_INIT(grp))) {
 			ret = ext4_mb_init_group(sb, group, GFP_NOFS);
 			if (ret)
 				break;
@@ -5667,16 +6589,25 @@ ext4_mballoc_query_range(
 	ext4_grpblk_t			next;
 	struct ext4_buddy		e4b;
 	int				error;
+	struct buffer_head		*bh = NULL;
 
-	error = ext4_mb_load_allocator(sb, group, &e4b, 0);
-	if (error)
-		return error;
-	bitmap = e4b.bd_bitmap;
-
+	if (ext4_mb_frsp_on(sb)) {
+		bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bh)) {
+			error = PTR_ERR(bh);
+			goto out_unload;
+		}
+		bitmap = bh->b_data;
+	} else {
+		error = ext4_mb_load_allocator(sb, group, &e4b, 0);
+		if (error)
+			return error;
+		bitmap = e4b.bd_bitmap;
+	}
 	ext4_lock_group(sb, group);
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	if (!ext4_mb_frsp_on(sb))
+		start = (e4b.bd_info->bb_first_free > start) ?
+			e4b.bd_info->bb_first_free : start;
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
@@ -5685,19 +6616,20 @@ ext4_mballoc_query_range(
 		if (start > end)
 			break;
 		next = mb_find_next_bit(bitmap, end + 1, start);
-
 		ext4_unlock_group(sb, group);
 		error = formatter(sb, group, start, next - start, priv);
 		if (error)
 			goto out_unload;
 		ext4_lock_group(sb, group);
-
 		start = next + 1;
 	}
 
 	ext4_unlock_group(sb, group);
 out_unload:
-	ext4_mb_unload_allocator(&e4b);
+	if (!IS_ERR_OR_NULL(bh))
+		brelse(bh);
+	if (!ext4_mb_frsp_on(sb))
+		ext4_mb_unload_allocator(&e4b);
 
 	return error;
 }
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6b4d17c2935d..32b9ee452de7 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -74,6 +74,20 @@
 #define MB_DEFAULT_GROUP_PREALLOC	512
 
 
+/*
+ * Struct for tree node in freespace_tree
+ */
+struct ext4_frsp_node {
+	ext4_grpblk_t frsp_offset;	/* Start block offset inside
+					 * current flexible group
+					 */
+	ext4_grpblk_t frsp_len;		/*
+					 * Length of the free space in
+					 * number of clusters
+					 */
+	struct rb_node frsp_node;
+	struct rb_node frsp_len_node;
+};
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
@@ -121,6 +135,7 @@ struct ext4_free_extent {
 	ext4_grpblk_t fe_start;	/* In cluster units */
 	ext4_group_t fe_group;
 	ext4_grpblk_t fe_len;	/* In cluster units */
+	struct ext4_frsp_node *fe_node;
 };
 
 /*
@@ -141,7 +156,14 @@ struct ext4_locality_group {
 	spinlock_t		lg_prealloc_lock;
 };
 
+struct ext4_tree_extent {
+	ext4_group_t te_flex;		/* flex_bg index (tree index) */
+	ext4_grpblk_t te_flex_start;	/* block offset w.r.t flex bg */
+	ext4_grpblk_t te_len;		/* length */
+};
+
 struct ext4_allocation_context {
+	__u32	ac_id;
 	struct inode *ac_inode;
 	struct super_block *ac_sb;
 
@@ -154,8 +176,16 @@ struct ext4_allocation_context {
 	/* the best found extent */
 	struct ext4_free_extent ac_b_ex;
 
-	/* copy of the best found extent taken before preallocation efforts */
-	struct ext4_free_extent ac_f_ex;
+	/* With freespace trees, we don't use preallocation anymore. */
+	union {
+		/*
+		 * copy of the best found extent taken before
+		 * preallocation efforts
+		 */
+		struct ext4_free_extent ac_f_ex;
+		/* the best found tree extent */
+		struct ext4_tree_extent ac_b_tree_ex;
+	};
 
 	__u16 ac_groups_scanned;
 	__u16 ac_found;
@@ -177,14 +207,31 @@ struct ext4_allocation_context {
 #define AC_STATUS_FOUND		2
 #define AC_STATUS_BREAK		3
 
+/*
+ * Freespace tree flags
+ */
+#define EXT4_ALLOCATOR_FRSP_NOLOAD		0x0001	/*
+							 * Don't load freespace
+							 * tree, if it's not
+							 * in memory.
+							 */
+
 struct ext4_buddy {
-	struct page *bd_buddy_page;
-	void *bd_buddy;
-	struct page *bd_bitmap_page;
-	void *bd_bitmap;
+	union {
+		struct {
+			struct page *bd_buddy_page;
+			void *bd_buddy;
+			struct page *bd_bitmap_page;
+			void *bd_bitmap;
+			__u16 bd_blkbits;
+		};
+		struct {
+			struct ext4_frsp_tree *frsp_tree;
+			__u32 frsp_flags;
+		};
+	};
 	struct ext4_group_info *bd_info;
 	struct super_block *bd_sb;
-	__u16 bd_blkbits;
 	ext4_group_t bd_group;
 };
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a50b51270ea9..6a0e1fc18e95 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1679,6 +1679,10 @@ int ext4_group_add(struct super_block *sb, struct ext4_new_group_data *input)
 	if (err)
 		goto out;
 
+	err = ext4_mb_add_frsp_trees(sb, input->group + 1);
+	if (err)
+		goto out;
+
 	flex_gd.count = 1;
 	flex_gd.groups = input;
 	flex_gd.bg_flags = &bg_flags;
@@ -2051,6 +2055,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	if (err)
 		goto out;
 
+	err = ext4_mb_add_frsp_trees(sb, n_group + 1);
+	if (err)
+		goto out;
+
 	flex_gd = alloc_flex_gd(flexbg_size);
 	if (flex_gd == NULL) {
 		err = -ENOMEM;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 98aa12602b68..2f4b7061365f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1521,7 +1521,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_freespace_tree,
 };
 
 static const match_table_t tokens = {
@@ -1608,6 +1608,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_freespace_tree, "freespace_tree"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
@@ -1834,6 +1835,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_freespace_tree, EXT4_MOUNT2_FREESPACE_TREE,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -4740,12 +4743,19 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount4a;
 	}
 
+	if (ext4_has_feature_flex_bg(sb))
+		if (!ext4_fill_flex_info(sb)) {
+			ext4_msg(sb, KERN_ERR,
+			       "unable to initialize flex_bg meta info!");
+			goto failed_mount5;
+		}
+
 	ext4_ext_init(sb);
 	err = ext4_mb_init(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
 			 err);
-		goto failed_mount5;
+		goto failed_mount6;
 	}
 
 	block = ext4_count_free_clusters(sb);
@@ -4775,14 +4785,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount6;
 	}
 
-	if (ext4_has_feature_flex_bg(sb))
-		if (!ext4_fill_flex_info(sb)) {
-			ext4_msg(sb, KERN_ERR,
-			       "unable to initialize "
-			       "flex_bg meta info!");
-			goto failed_mount6;
-		}
-
 	err = ext4_register_li_request(sb, first_not_zeroed);
 	if (err)
 		goto failed_mount6;
@@ -4856,7 +4858,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_unregister_li_request(sb);
 failed_mount6:
 	ext4_mb_release(sb);
+	percpu_counter_destroy(&sbi->s_freeclusters_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 	rcu_read_lock();
+
+failed_mount5:
 	flex_groups = rcu_dereference(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
@@ -4864,12 +4873,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		kvfree(flex_groups);
 	}
 	rcu_read_unlock();
-	percpu_counter_destroy(&sbi->s_freeclusters_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
-	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_writepages_rwsem);
-failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
 failed_mount4a:
-- 
2.28.0.220.ged08abb693-goog

