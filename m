Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1924C9BB
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHUBzx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgHUBzk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FCC061342
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so162747plb.12
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFS9GNHqqK+EAPWE0eVP9FHbiH67Dx9oq9Ra6pNYcCI=;
        b=bmwoVvcpSWObBnr9EEgoPT1MnVXiGhm5p855kmgk37cJwxxOm8nVfeOp8pedCy4tpm
         qH+ay7OdTi58txT5KyCr1/x4V3zEIbwsSbOXCKjGHEzNlNyOGnxpWTsVn7dgustzg/rG
         hcIrv9ObQk6kU93kzfoO7B1EDHR0vUiaGwwQU2LyLtqYtqGGIuJNAzeMYmdUn7hEgjoe
         KYkteZa21nafX2nP0+Km8BWw+C8KA/SC/02ERwRoC6j8PWUWXi8SdlPA4KKv9nzjhVcM
         iLJCj1foJ7J63ONAKhIAwIOyFuufkDhOc/JnXnSjcvfb5MSgNcdHJRqAKr2mlPxfIJby
         Fiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFS9GNHqqK+EAPWE0eVP9FHbiH67Dx9oq9Ra6pNYcCI=;
        b=gOg21cqmPg2GbsoWm95vvovARhX7duqZtN6ePfwo1KDWfKsvCgXJJzeJtx1yBQ/ZJJ
         cjbLeeKohkJKGbvKS8/LlgTou8kXxnZK7mScxP2fQv1zSGr5S9ttY6bjKcFgfpmKHMqb
         NMOQfN7ouH+9HdlI6Rfewu+cCjQujdTy/9fmCUyIPA0pNLssAjWrImUqbxNuGHQALQ0z
         BLXSmjTv++1TGPEg8mZi9fV7+c+IAtrm/d7zXNiR5RjVSNkuVCJ66BDDdX6QpyYo0zTj
         Msu5vvf3bYGlYwcGut7lFVXdjTuDMNeuKpsYXqwB8uhRYBo+YhL7wyZkr6k9+jOLweWb
         PyVA==
X-Gm-Message-State: AOAM530i+Ij/Y3bv1MuhLbmstIHACLQpxquKrx7b4gQB+0LKdaqCeHlK
        jTgwa0XOPFcp7EpOHtiesW3aLsI+OP8=
X-Google-Smtp-Source: ABdhPJxYIEVHOWlau1rEVEMJV08UNZqfoWgN3qWZxj6IjTTjgnPuw9J4j+YO4fZNjnqToWOS1e70/w==
X-Received: by 2002:a17:902:323:: with SMTP id 32mr540344pld.59.1597974937949;
        Thu, 20 Aug 2020 18:55:37 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:36 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 7/9] ext4: add LRU eviction for free space trees
Date:   Thu, 20 Aug 2020 18:55:21 -0700
Message-Id: <20200821015523.1698374-8-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds LRU eviction policy for freespace trees. In order to
avoid contention on one LRU lock, the LRU scheme is implemented as two
lists - an active list and an inactive list. Trees in active list
aren't moved inside the list thereby avoiding the need of a
lock. Trees in inactive list become active only if they are accessed
twice in a short interval thereby avoiding outliers to enter the
active list.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  46 +++++++++++++
 fs/ext4/mballoc.c | 164 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 197 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 93bf2fe35cf1..64d0dbbcd517 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1454,6 +1454,10 @@ struct ext4_frsp_tree {
 							 */
 	struct list_head frsp_list_node;
 	struct rb_node frsp_len_node;
+	atomic_t frsp_fragments;
+	struct list_head frsp_lru_active_node;
+	unsigned long frsp_last_access;
+	atomic_t frsp_ref;
 };
 
 /* Freespace tree flags */
@@ -1468,6 +1472,47 @@ struct ext4_frsp_tree {
 #define EXT4_MB_FRSP_DEFAULT_CACHE_AGGRESSION		0x1
 #define EXT4_MB_FRSP_MAX_CACHE_AGGRESSION		0x3
 
+/* LRU management for free space trees */
+struct ext4_mb_frsp_lru {
+	rwlock_t frsp_lru_lock;
+	atomic_t frsp_active_fragments;		/* Current #of fragments in
+						 * the active queue
+						 */
+	u32 frsp_max_active_fragments;
+	/*
+	 * List of active trees. Trees at tail are oldest trees in active set.
+	 */
+	struct list_head frsp_lru_active;
+	/*
+	 * List of inactive trees but loaded trees.
+	 */
+	struct list_head frsp_lru_inactive;
+	struct super_block *frsp_lru_sb;
+};
+
+/*
+ * Minimum memory needed for our allocator. The pathological worst case for
+ * freespace trees is when every other block is allocated. In this case,
+ * the allocator will end up storing an extent node of length 1 for each free
+ * block. We need to make sure that the minimum memory available for the
+ * allocator is as much memory needed for 1 worst-case tree. This ensures that
+ * we can at-least keep 1 tree in memory. This way we avoid thrashing.
+ */
+#define EXT4_MB_FRSP_MEM_MIN(sb)					\
+	((sizeof(struct ext4_frsp_node) * ext4_flex_bg_size(EXT4_SB(sb))) \
+		* (EXT4_BLOCKS_PER_GROUP(sb) / 2))
+
+/* Half of the total memory available is allowed for active list */
+#define EXT4_MB_FRSP_MAX_ACTIVE_FRAGMENTS(sb)				\
+	((EXT4_SB(sb)->s_mb_frsp_mem_limit /				\
+		(2 * sizeof(struct ext4_frsp_node))))
+
+/*
+ * Maximum number of jiffies allowed between two successive hits on a freespace
+ * tree before we move it to the "active" queue.
+ */
+#define EXT4_MB_FRSP_ACTIVE_THRESHOLD_JIFFIES		100
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1615,6 +1660,7 @@ struct ext4_sb_info {
 	u32 s_mb_frsp_cache_aggression;
 	atomic_t s_mb_num_fragments;
 	u32 s_mb_frsp_mem_limit;
+	struct ext4_mb_frsp_lru s_mb_frsp_lru;
 
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b28b7fb0506e..aea0eb8d28da 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -866,10 +866,12 @@ void ext4_mb_frsp_print_tree_len(struct super_block *sb,
 }
 #endif
 
-static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
+static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb,
+			struct ext4_frsp_tree *tree)
 {
 	struct ext4_frsp_node *node;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_mb_frsp_lru *lru = &EXT4_SB(sb)->s_mb_frsp_lru;
 
 	node = kmem_cache_alloc(ext4_freespace_node_cachep, GFP_NOFS);
 	if (!node)
@@ -879,6 +881,11 @@ static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
 	RB_CLEAR_NODE(&node->frsp_len_node);
 
 	atomic_inc(&sbi->s_mb_num_fragments);
+	atomic_inc(&tree->frsp_fragments);
+	read_lock(&lru->frsp_lru_lock);
+	if (!list_empty(&tree->frsp_lru_active_node))
+		atomic_inc(&lru->frsp_active_fragments);
+	read_unlock(&lru->frsp_lru_lock);
 
 	if (sbi->s_mb_frsp_mem_limit &&
 		atomic_read(&sbi->s_mb_num_fragments) >
@@ -892,12 +899,18 @@ static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
 }
 
 static void ext4_mb_frsp_free_node(struct super_block *sb,
-		struct ext4_frsp_node *node)
+		struct ext4_frsp_tree *tree, struct ext4_frsp_node *node)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_mb_frsp_lru *lru = &EXT4_SB(sb)->s_mb_frsp_lru;
 
 	kmem_cache_free(ext4_freespace_node_cachep, node);
 	atomic_dec(&sbi->s_mb_num_fragments);
+	atomic_dec(&tree->frsp_fragments);
+	read_lock(&lru->frsp_lru_lock);
+	if (!list_empty(&tree->frsp_lru_active_node))
+		atomic_dec(&lru->frsp_active_fragments);
+	read_unlock(&lru->frsp_lru_lock);
 
 	if (!sbi->s_mb_frsp_mem_limit ||
 		atomic_read(&sbi->s_mb_num_fragments) <
@@ -915,6 +928,8 @@ void ext4_mb_frsp_free_tree(struct super_block *sb, struct ext4_frsp_tree *tree)
 	mutex_lock(&tree->frsp_lock);
 	if (!(tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED))
 		goto out;
+	if (atomic_read(&tree->frsp_ref))
+		goto out;
 
 	node = rb_first_cached(&tree->frsp_offset_root);
 	while (node) {
@@ -922,7 +937,7 @@ void ext4_mb_frsp_free_tree(struct super_block *sb, struct ext4_frsp_tree *tree)
 		rb_erase_cached(node, &tree->frsp_offset_root);
 		rb_erase_cached(&frsp_node->frsp_len_node,
 				&tree->frsp_len_root);
-		ext4_mb_frsp_free_node(sb, frsp_node);
+		ext4_mb_frsp_free_node(sb, tree, frsp_node);
 		node = rb_first_cached(&tree->frsp_offset_root);
 	}
 	tree->frsp_flags &= ~EXT4_MB_FRSP_FLAG_LOADED;
@@ -985,7 +1000,7 @@ int ext4_mb_frsp_add_region(struct super_block *sb, struct ext4_frsp_tree *tree,
 				*prev_entry = NULL;
 	struct rb_node *left = NULL, *right = NULL;
 
-	new_entry = ext4_mb_frsp_alloc_node(sb);
+	new_entry = ext4_mb_frsp_alloc_node(sb, tree);
 	if (!new_entry)
 		return -ENOMEM;
 
@@ -1004,7 +1019,7 @@ int ext4_mb_frsp_add_region(struct super_block *sb, struct ext4_frsp_tree *tree,
 			rb_erase_cached(left, &tree->frsp_offset_root);
 			rb_erase_cached(&prev_entry->frsp_len_node,
 						&tree->frsp_len_root);
-			ext4_mb_frsp_free_node(sb, prev_entry);
+			ext4_mb_frsp_free_node(sb, tree, prev_entry);
 		}
 	}
 
@@ -1017,7 +1032,7 @@ int ext4_mb_frsp_add_region(struct super_block *sb, struct ext4_frsp_tree *tree,
 			rb_erase_cached(right, &tree->frsp_offset_root);
 			rb_erase_cached(&next_entry->frsp_len_node,
 						&tree->frsp_len_root);
-			ext4_mb_frsp_free_node(sb, next_entry);
+			ext4_mb_frsp_free_node(sb, tree, next_entry);
 		}
 	}
 	ext4_mb_frsp_insert_len(tree, new_entry);
@@ -1601,6 +1616,10 @@ static void ext4_mb_frsp_init_tree(struct ext4_frsp_tree *tree, int index)
 	tree->frsp_flags = 0;
 	tree->frsp_index = index;
 	INIT_LIST_HEAD(&tree->frsp_list_node);
+	atomic_set(&tree->frsp_fragments, 0);
+	tree->frsp_last_access = 0;
+	INIT_LIST_HEAD(&tree->frsp_lru_active_node);
+	atomic_set(&tree->frsp_ref, 0);
 }
 
 int ext4_mb_init_freespace_trees(struct super_block *sb)
@@ -1627,6 +1646,15 @@ int ext4_mb_init_freespace_trees(struct super_block *sb)
 	rwlock_init(&sbi->s_mb_frsp_lock);
 	atomic_set(&sbi->s_mb_num_frsp_trees_cached, 0);
 	atomic_set(&sbi->s_mb_num_fragments, 0);
+	INIT_LIST_HEAD(&sbi->s_mb_frsp_lru.frsp_lru_active);
+	INIT_LIST_HEAD(&sbi->s_mb_frsp_lru.frsp_lru_inactive);
+	rwlock_init(&sbi->s_mb_frsp_lru.frsp_lru_lock);
+	/* Set the default hard-limit to be as much as buddy bitmaps */
+	sbi->s_mb_frsp_mem_limit = ext4_get_groups_count(sb) <<
+				(sb->s_blocksize_bits + 1);
+	if (sbi->s_mb_frsp_mem_limit < EXT4_MB_FRSP_MEM_MIN(sb))
+		sbi->s_mb_frsp_mem_limit = EXT4_MB_FRSP_MEM_MIN(sb);
+	atomic_set(&sbi->s_mb_frsp_lru.frsp_active_fragments, 0);
 
 	return 0;
 }
@@ -1664,6 +1692,99 @@ int ext4_mb_add_frsp_trees(struct super_block *sb, int ngroups)
 	return 0;
 }
 
+/*
+ * Evict one tree from inactive list.
+ */
+static void ext4_frsp_evict(struct super_block *sb)
+{
+	struct ext4_mb_frsp_lru *lru = &EXT4_SB(sb)->s_mb_frsp_lru;
+	struct ext4_frsp_tree *tree = NULL;
+	bool found = false;
+
+	write_lock(&lru->frsp_lru_lock);
+	if (!list_empty(&lru->frsp_lru_inactive)) {
+		/* Evict from front, insert at tail */
+		found = 0;
+		list_for_each_entry(tree, &lru->frsp_lru_inactive,
+			frsp_list_node) {
+			if (!atomic_read(&tree->frsp_ref)) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			list_del_init(&tree->frsp_list_node);
+	}
+	write_unlock(&lru->frsp_lru_lock);
+	if (found)
+		ext4_mb_frsp_free_tree(sb, tree);
+}
+
+/*
+ * This function maintains LRU lists. "tree" has just been accessed.
+ */
+static void ext4_mb_frsp_maintain_lru(struct super_block *sb,
+					struct ext4_frsp_tree *tree)
+{
+	struct ext4_mb_frsp_lru *lru = &EXT4_SB(sb)->s_mb_frsp_lru;
+	struct ext4_frsp_tree *last;
+	unsigned long current_jiffies = jiffies;
+
+	read_lock(&lru->frsp_lru_lock);
+	if (!list_empty(&tree->frsp_lru_active_node)) {
+		/* Already active, nothing to do */
+		read_unlock(&lru->frsp_lru_lock);
+		goto out;
+	}
+
+	/*
+	 * Check if this tree needs to be moved to active list. We move it to
+	 * active list if one of the following three conditions is true:
+	 * - This is the first access to this tree
+	 * - We haven't yet reached the max active fragments threshold, so there
+	 *   is space in active list.
+	 * - This tree was accessed twice in
+	 *   EXT4_MB_FRSP_ACTIVE_THRESHOLD_JIFFIES interval.
+	 */
+	if (tree->frsp_last_access &&
+		EXT4_MB_FRSP_MAX_ACTIVE_FRAGMENTS(sb) &&
+		atomic_read(&lru->frsp_active_fragments) >
+			EXT4_MB_FRSP_MAX_ACTIVE_FRAGMENTS(sb) &&
+		current_jiffies - tree->frsp_last_access >
+		EXT4_MB_FRSP_ACTIVE_THRESHOLD_JIFFIES) {
+		read_unlock(&lru->frsp_lru_lock);
+		goto out;
+	}
+	read_unlock(&lru->frsp_lru_lock);
+
+	write_lock(&lru->frsp_lru_lock);
+	/* Check again just in case */
+	if (!list_empty(&tree->frsp_lru_active_node)) {
+		write_unlock(&lru->frsp_lru_lock);
+		goto out;
+	}
+	list_add(&tree->frsp_lru_active_node, &lru->frsp_lru_active);
+	list_del_init(&tree->frsp_list_node);
+	atomic_add(atomic_read(&tree->frsp_fragments),
+			&lru->frsp_active_fragments);
+	/* Remove trees from active queue until we are below the limit */
+	while (EXT4_MB_FRSP_MAX_ACTIVE_FRAGMENTS(sb) &&
+		atomic_read(&lru->frsp_active_fragments) >
+			EXT4_MB_FRSP_MAX_ACTIVE_FRAGMENTS(sb)) {
+		last = list_last_entry(&lru->frsp_lru_active,
+				struct ext4_frsp_tree, frsp_lru_active_node);
+		list_del_init(&last->frsp_lru_active_node);
+		/* Evict from front, insert at tail */
+		list_add_tail(&last->frsp_list_node, &lru->frsp_lru_inactive);
+		atomic_sub(atomic_read(&last->frsp_fragments),
+			&lru->frsp_active_fragments);
+	}
+	write_unlock(&lru->frsp_lru_lock);
+
+out:
+	tree->frsp_last_access = current_jiffies;
+}
+
 /*
  * Divide blocks started from @first with length @len into
  * smaller chunks with power of 2 blocks.
@@ -2154,10 +2275,12 @@ ext4_mb_load_allocator_gfp(struct super_block *sb, ext4_group_t group,
 		e4b->frsp_tree = ext4_get_frsp_tree(sb,
 					ext4_flex_group(sbi, group));
 		e4b->frsp_flags = flags;
+		ext4_mb_frsp_maintain_lru(sb, e4b->frsp_tree);
 		if (flags & EXT4_ALLOCATOR_FRSP_NOLOAD)
 			return 0;
 
 		mutex_lock(&e4b->frsp_tree->frsp_lock);
+		atomic_inc(&e4b->frsp_tree->frsp_ref);
 		if (e4b->frsp_tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED) {
 			mutex_unlock(&e4b->frsp_tree->frsp_lock);
 			return 0;
@@ -2285,8 +2408,15 @@ static int ext4_mb_load_allocator(struct super_block *sb, ext4_group_t group,
 
 static void ext4_mb_unload_allocator(struct ext4_buddy *e4b)
 {
-	if (ext4_mb_frsp_on(e4b->bd_sb))
+	if (ext4_mb_frsp_on(e4b->bd_sb)) {
+		if (!e4b->frsp_tree ||
+			e4b->frsp_flags & EXT4_ALLOCATOR_FRSP_NOLOAD)
+			return;
+		atomic_dec(&e4b->frsp_tree->frsp_ref);
+		if (test_opt2(e4b->bd_sb, FRSP_MEM_CRUNCH))
+			ext4_frsp_evict(e4b->bd_sb);
 		return;
+	}
 	if (e4b->bd_bitmap_page)
 		put_page(e4b->bd_bitmap_page);
 	if (e4b->bd_buddy_page)
@@ -2658,7 +2788,8 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 				ex->fe_node->frsp_offset +
 				ex->fe_node->frsp_len) {
 				/* Need to split the node */
-				new = ext4_mb_frsp_alloc_node(e4b->bd_sb);
+				new = ext4_mb_frsp_alloc_node(e4b->bd_sb,
+								e4b->frsp_tree);
 				if (!new)
 					return -ENOMEM;
 				new->frsp_offset = flex_offset + ex->fe_len;
@@ -2675,7 +2806,8 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 			ex->fe_node->frsp_offset += ex->fe_len;
 			ex->fe_node->frsp_len -= ex->fe_len;
 		} else {
-			ext4_mb_frsp_free_node(e4b->bd_sb, ex->fe_node);
+			ext4_mb_frsp_free_node(e4b->bd_sb, e4b->frsp_tree,
+							ex->fe_node);
 			return 0;
 		}
 
@@ -4166,7 +4298,9 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
-		if (!ext4_mb_frsp_on(sb)) {
+		if (ext4_mb_frsp_on(sb)) {
+			atomic_dec(&e4b.frsp_tree->frsp_ref);
+		} else {
 			put_page(e4b.bd_buddy_page);
 			put_page(e4b.bd_bitmap_page);
 		}
@@ -6146,14 +6280,18 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	new_node = &new_entry->efd_node;
 	cluster = new_entry->efd_start_cluster;
 
-	if (!*n && !ext4_mb_frsp_on(sb)) {
+	if (!*n) {
 		/* first free block exent. We need to
 		   protect buddy cache from being freed,
 		 * otherwise we'll refresh it from
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
-		get_page(e4b->bd_buddy_page);
-		get_page(e4b->bd_bitmap_page);
+		if (ext4_mb_frsp_on(sb)) {
+			atomic_inc(&e4b->frsp_tree->frsp_ref);
+		} else {
+			get_page(e4b->bd_buddy_page);
+			get_page(e4b->bd_bitmap_page);
+		}
 	}
 	while (*n) {
 		parent = *n;
-- 
2.28.0.297.g1956fa8f8d-goog

