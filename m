Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC38249779
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHSHbi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgHSHbY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6FC061343
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so10974670pgh.6
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74EpnU46L5lL7P5VTblWA2IyRLUasvskweHuiMzndos=;
        b=TK1cW1ppqYM35StG5dBdy5HF+D6YytsfzgEGlUdRBECY2WhV+WmEUWZB4EyfMa4CwE
         tT1K9gWdQ+X5H5K7rFglKKB0OlOAEj2BeUwlPMDTbbGetWtZIabjaPtN8yQsh54TLYMa
         M0+BDZUTspx0swphaHSvdKj36yar4f/Gs8KaV/WDvO7WvB5QSJaKybclfcdXmOXjyIDz
         n+RGdKrKWR2wGZ+DCL1m4D9mvgZQKsxiR6OZ6walosTosJ00EgH+rh6rNFBEICENXCBZ
         JjSJ9fwNn1eEYH8or833inSJI6dpHYRUQuG6apnrwm4rvI0ZHmHo7ntVayxErd5z9BZ2
         OuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74EpnU46L5lL7P5VTblWA2IyRLUasvskweHuiMzndos=;
        b=Qv6eIx7NZcWvCv91Sz80IS46kRRaidDt3c+VrJzHTJ6A84Hees842fWe5V/BkEJePC
         Plutu2Bo2RviwOaK2AV1gB7CeDntQnrgqIbemgopAeLgQ7nYrDu2u8DvJPiVM5jmKc5G
         UMWLuISeQX1hE5e+pU5762pvN0n+GnG982/7upytUX06FU09ILtwDMcpm8kAKb/MUJ//
         zdgrTAXw9WLK1tjiMSpR/vmqDKQiUrlWZdDp/G9jk42pJFNO00LteDaexApDRtp7HcDK
         WyNVLXa+mOuv5Hwmq1e3TgdKT480HlHhW8zmVeGF2NmeNd90FcNaL4Cg6O/5oq7yu2Vm
         KCKQ==
X-Gm-Message-State: AOAM530T2lPsBJu4TVHiJ2gLNk53ZNv8iAMM0I6+XQKsq7ntBoLwSNCF
        r9xVvyYSrd+zKgxMxY0tUC4Sg3GvDx8=
X-Google-Smtp-Source: ABdhPJxRh8Fp0VYRJjQedfYL7lenOiWUmCMAuqwpI1q7bet1b2H5/aVaJ6OvM73oM+0820wWlWY7iw==
X-Received: by 2002:a63:161a:: with SMTP id w26mr9506348pgl.211.1597822282553;
        Wed, 19 Aug 2020 00:31:22 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 5/9] ext4: add freespace tree optimizations
Date:   Wed, 19 Aug 2020 00:31:00 -0700
Message-Id: <20200819073104.1141705-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds an optimization on top of our freespace tree
allocator. We add a new meta-tree which contains tree node sorted by
length of their largest extent. We use this tree to optimize an
allocation request so that it immediately gets a hit or it falls back
to next CR level.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  17 +++++
 fs/ext4/mballoc.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.h |   1 +
 fs/ext4/super.c   |   9 +++
 4 files changed, 205 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3bb2675d4d40..8cfe089ebea6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -153,6 +153,8 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
+/* Disable freespace optimizations on ac */
+#define EXT4_MB_FRSP_NO_OPTIMIZE	0x8000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
@@ -1427,12 +1429,22 @@ struct ext4_frsp_tree {
 	__u32 frsp_index;				/* Tree index (flex bg
 							 * number)
 							 */
+	struct list_head frsp_list_node;
+	struct rb_node frsp_len_node;
 };
 
 /* Freespace tree flags */
 
 /* Tree is loaded in memory */
 #define EXT4_MB_FRSP_FLAG_LOADED			0x0001
+/* Tree is inserted into meta tree */
+#define EXT4_MB_FRSP_FLAG_CACHED			0x2
+
+/* Freespace tree cache aggression levels */
+#define EXT4_MB_FRSP_MIN_CACHE_AGGRESSION		0x0
+#define EXT4_MB_FRSP_DEFAULT_CACHE_AGGRESSION		0x1
+#define EXT4_MB_FRSP_MAX_CACHE_AGGRESSION		0x3
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1572,6 +1584,11 @@ struct ext4_sb_info {
 
 	/* freespace trees stuff */
 	int s_mb_num_frsp_trees;
+	struct rb_root_cached s_mb_frsp_meta_tree;
+	rwlock_t s_mb_frsp_lock;
+	atomic_t s_mb_num_frsp_trees_cached;
+	struct list_head s_mb_uncached_trees;
+	u32 s_mb_frsp_cache_aggression;
 
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1f4e69c6f488..fa027b626abe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -779,6 +779,13 @@ static inline int ext4_mb_frsp_len_cmp(struct ext4_frsp_node *arg1,
 	return (arg1->frsp_len > arg2->frsp_len);
 }
 
+/* Compare function for meta tree */
+static inline int ext4_mb_frsp_meta_cmp(struct ext4_frsp_tree *arg1,
+					struct ext4_frsp_tree *arg2)
+{
+	return (arg1->frsp_max_free_len > arg2->frsp_max_free_len);
+}
+
 /* insert to offset-indexed tree */
 static void ext4_mb_frsp_insert_off(struct ext4_frsp_tree *tree,
 				struct ext4_frsp_node *new_entry)
@@ -798,6 +805,35 @@ static void ext4_mb_frsp_insert_len(struct ext4_frsp_tree *tree,
 		ext4_mb_frsp_len_cmp);
 }
 
+void ext4_mb_frsp_meta_reinsert(struct super_block *sb,
+	struct ext4_frsp_tree *tree)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_frsp_node *node;
+	struct rb_node *first = rb_first_cached(&tree->frsp_len_root);
+	struct rb_root_cached *meta_root = &EXT4_SB(sb)->s_mb_frsp_meta_tree;
+	int expected_len = 0;
+
+	if (!(tree->frsp_flags & EXT4_MB_FRSP_FLAG_LOADED))
+		return;
+
+	if (first) {
+		node = rb_entry(first, struct ext4_frsp_node, frsp_len_node);
+		expected_len = node->frsp_len;
+	}
+
+	if (tree->frsp_max_free_len == expected_len)
+		return;
+
+	write_lock(&sbi->s_mb_frsp_lock);
+	tree->frsp_max_free_len = expected_len;
+	rb_erase_cached(&tree->frsp_len_node, &sbi->s_mb_frsp_meta_tree);
+	RB_CLEAR_NODE(&tree->frsp_len_node);
+	ext4_mb_rb_insert(meta_root, tree, struct ext4_frsp_tree, frsp_len_node,
+		ext4_mb_frsp_meta_cmp);
+	write_unlock(&sbi->s_mb_frsp_lock);
+}
+
 #ifdef CONFIG_EXT4_DEBUG
 /* print freespace_tree in pre-order traversal */
 void ext4_mb_frsp_print_tree_len(struct super_block *sb,
@@ -966,6 +1002,7 @@ int ext4_mb_frsp_add_region(struct super_block *sb, struct ext4_frsp_tree *tree,
 		}
 	}
 	ext4_mb_frsp_insert_len(tree, new_entry);
+	ext4_mb_frsp_meta_reinsert(sb, tree);
 
 	return 0;
 }
@@ -1063,6 +1100,9 @@ int ext4_mb_frsp_load(struct ext4_buddy *e4b)
 		if (ret)
 			goto out;
 	}
+	if (!(e4b->frsp_tree->frsp_flags & EXT4_MB_FRSP_FLAG_CACHED))
+		atomic_inc(&sbi->s_mb_num_frsp_trees_cached);
+	e4b->frsp_tree->frsp_flags |= EXT4_MB_FRSP_FLAG_CACHED;
 	e4b->frsp_tree->frsp_flags |= EXT4_MB_FRSP_FLAG_LOADED;
 out:
 	for (i = 0; i < ngroups; i++) {
@@ -1156,6 +1196,7 @@ static void ext4_mb_frsp_use_best_found(struct ext4_allocation_context *ac,
 	ext4_mb_load_allocator(ac->ac_sb, group_no, &e4b,
 		EXT4_ALLOCATOR_FRSP_NOLOAD);
 	mb_mark_used(&e4b, bex);
+	ext4_mb_frsp_meta_reinsert(ac->ac_sb, e4b.frsp_tree);
 	ext4_mb_unload_allocator(&e4b);
 }
 /*
@@ -1286,6 +1327,124 @@ void ext4_mb_frsp_find_by_goal(struct ext4_allocation_context *ac)
 	ext4_mb_unload_allocator(&e4b);
 }
 
+/*
+ * Determine if caching of trees is necessary. This function returns 1 if it is,
+ * 0 if it is not.
+ */
+static int ext4_mb_frsp_should_cache(struct ext4_allocation_context *ac)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+
+	if (list_empty(&sbi->s_mb_uncached_trees))
+		return 0;
+
+	if (sbi->s_mb_frsp_cache_aggression >=
+		EXT4_MB_FRSP_MAX_CACHE_AGGRESSION)
+		return 1;
+
+	if (sbi->s_mb_frsp_cache_aggression ==
+		EXT4_MB_FRSP_MIN_CACHE_AGGRESSION)
+		return 0;
+
+	/* At cache aggression level 1, skip caching at CR 0 */
+	if (sbi->s_mb_frsp_cache_aggression == 1 && ac->ac_criteria == 0)
+		return 0;
+
+	/*
+	 * At cache aggression level 2, perform caching for every alternate
+	 * optimization.
+	 */
+	return (ac->ac_num_optimizations & 0x1);
+}
+
+/*
+ * Optimize allocation request. This function _tries_ to lookup the meta-tree
+ * and if it can optimize the search in any way, it does so. As a result
+ * this function returns 1, if the optimization was performed. In this case,
+ * the caller should restart the search from tree mentioned in *tree_idx.
+ */
+int ext4_mb_frsp_optimize(struct ext4_allocation_context *ac, int *tree_idx)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_frsp_tree *cur = NULL;
+	struct rb_node *node = NULL;
+	int found = 0, best = 0, cache_more_trees = 0, better_len = 0, ret = 0;
+
+	if (ac->ac_flags & EXT4_MB_HINT_FIRST ||
+		ac->ac_flags & EXT4_MB_FRSP_NO_OPTIMIZE ||
+		ac->ac_status != AC_STATUS_CONTINUE)
+		return 0;
+
+	ac->ac_num_optimizations++;
+	if (!read_trylock(&sbi->s_mb_frsp_lock))
+		return 0;
+
+	node = sbi->s_mb_frsp_meta_tree.rb_root.rb_node;
+	while (node) {
+		cur = rb_entry(node, struct ext4_frsp_tree, frsp_len_node);
+		if (ext4_mb_frsp_is_better(ac, cur->frsp_max_free_len, &best)) {
+			/*
+			 * This tree definitely has a better node than the best
+			 * found so far.
+			 */
+			found = 1;
+			ret = 1;
+			*tree_idx = cur->frsp_index;
+			better_len = cur->frsp_max_free_len;
+			if (best)
+				break;
+		}
+		if (cur->frsp_max_free_len > ac->ac_g_ex.fe_len)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+
+	if (ac->ac_found == 0 && !found) {
+		/*
+		 * If we haven't found a good match above, and we hadn't found
+		 * any match before us, that means we need to loosen our
+		 * criteria. Note that, if we had found something earlier,
+		 * not finding a better node doesn't imply that there is no
+		 * better node available.
+		 * TODO - in this case determine probabilistically which tree
+		 * may have a better node and direct our allocator there.
+		 */
+		if (ext4_mb_frsp_should_cache(ac)) {
+			cache_more_trees = 1;
+		} else if (ac->ac_criteria < 2) {
+			ac->ac_criteria++;
+			ac->ac_groups_scanned = 0;
+			*tree_idx = 0;
+			ret = 1;
+		} else {
+			ac->ac_flags |= EXT4_MB_HINT_FIRST;
+		}
+	} else if (!best && !list_empty(&sbi->s_mb_uncached_trees)) {
+		cache_more_trees = ext4_mb_frsp_should_cache(ac);
+	}
+
+	if (cache_more_trees) {
+		cur = list_first_entry(&sbi->s_mb_uncached_trees,
+				struct ext4_frsp_tree, frsp_list_node);
+		list_del_init(&cur->frsp_list_node);
+		*tree_idx = cur->frsp_index;
+		ret = 1;
+	}
+	read_unlock(&sbi->s_mb_frsp_lock);
+
+	/*
+	 * If we couldn't optimize now, it's unlikely that we'll be able to
+	 * optimize this request anymore
+	 */
+	if (!ret)
+		ac->ac_flags |= EXT4_MB_FRSP_NO_OPTIMIZE;
+	mb_debug(ac->ac_sb,
+		"Optimizer suggestion: found = %d, tree = %d, len = %d, cr = %d\n",
+		found, *tree_idx, better_len, ac->ac_criteria);
+	return ret;
+}
+
 static void ext4_mb_frsp_process(struct ext4_allocation_context *ac,
 				struct ext4_frsp_tree *tree)
 {
@@ -1324,6 +1483,7 @@ ext4_mb_tree_allocator(struct ext4_allocation_context *ac)
 	struct ext4_frsp_node *cur = NULL;
 	struct ext4_tree_extent *btx = NULL;
 	int ret = 0, start_idx = 0, tree_idx, j;
+	int optimize;
 
 	sb = ac->ac_sb;
 	btx = &ac->ac_b_tree_ex;
@@ -1341,6 +1501,8 @@ ext4_mb_tree_allocator(struct ext4_allocation_context *ac)
 
 	ac->ac_criteria = 0;
 	ac->ac_groups_scanned = 0;
+	ext4_mb_frsp_optimize(ac, &start_idx);
+
 repeat:
 
 	/* Loop through the rest of trees (flex_bg) */
@@ -1357,13 +1519,17 @@ ext4_mb_tree_allocator(struct ext4_allocation_context *ac)
 		mutex_lock(&e4b.frsp_tree->frsp_lock);
 		ext4_mb_frsp_process(ac, e4b.frsp_tree);
 		mutex_unlock(&e4b.frsp_tree->frsp_lock);
+		optimize = ext4_mb_frsp_optimize(ac, &start_idx);
 		ext4_mb_unload_allocator(&e4b);
+		if (optimize)
+			goto repeat;
 	}
 
 	if (ac->ac_status != AC_STATUS_FOUND) {
 		if (ac->ac_criteria < 2) {
 			ac->ac_criteria++;
 			ac->ac_groups_scanned = 0;
+			ac->ac_flags &= ~EXT4_MB_FRSP_NO_OPTIMIZE;
 			mb_debug(sb, "Falling back to CR=%d", ac->ac_criteria);
 			goto repeat;
 		}
@@ -1415,6 +1581,7 @@ static void ext4_mb_frsp_init_tree(struct ext4_frsp_tree *tree, int index)
 	mutex_init(&(tree->frsp_lock));
 	tree->frsp_flags = 0;
 	tree->frsp_index = index;
+	INIT_LIST_HEAD(&tree->frsp_list_node);
 }
 
 int ext4_mb_init_freespace_trees(struct super_block *sb)
@@ -1425,6 +1592,8 @@ int ext4_mb_init_freespace_trees(struct super_block *sb)
 
 	sbi->s_mb_num_frsp_trees =
 		ext4_num_grps_to_flexbg(sb, ext4_get_groups_count(sb));
+	sbi->s_mb_frsp_meta_tree = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&sbi->s_mb_uncached_trees);
 
 	for (i = 0; i < sbi->s_mb_num_frsp_trees; i++) {
 		fg = sbi_array_rcu_deref(sbi, s_flex_groups, i);
@@ -1433,7 +1602,11 @@ int ext4_mb_init_freespace_trees(struct super_block *sb)
 		if (!fg->frsp_tree)
 			return -ENOMEM;
 		ext4_mb_frsp_init_tree(fg->frsp_tree, i);
+		list_add(&fg->frsp_tree->frsp_list_node,
+				&sbi->s_mb_uncached_trees);
 	}
+	rwlock_init(&sbi->s_mb_frsp_lock);
+	atomic_set(&sbi->s_mb_num_frsp_trees_cached, 0);
 
 	return 0;
 }
@@ -1460,6 +1633,11 @@ int ext4_mb_add_frsp_trees(struct super_block *sb, int ngroups)
 		if (!fg->frsp_tree)
 			return -ENOMEM;
 		ext4_mb_frsp_init_tree(fg->frsp_tree, i);
+		write_lock(&sbi->s_mb_frsp_lock);
+		list_add(&fg->frsp_tree->frsp_list_node,
+				&sbi->s_mb_uncached_trees);
+		write_unlock(&sbi->s_mb_frsp_lock);
+		ext4_mb_frsp_meta_reinsert(sb, fg->frsp_tree);
 	}
 	sbi->s_mb_num_frsp_trees = flex_bg_count;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 32b9ee452de7..ac65f7eac611 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -196,6 +196,7 @@ struct ext4_allocation_context {
 	__u8 ac_criteria;
 	__u8 ac_2order;		/* if request is to allocate 2^N blocks and
 				 * N > 0, the field stores N, otherwise 0 */
+	__u8 ac_num_optimizations;
 	__u8 ac_op;		/* operation, for history only */
 	struct page *ac_bitmap_page;
 	struct page *ac_buddy_page;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2f4b7061365f..97b63e521b97 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1522,6 +1522,8 @@ enum {
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_prefetch_block_bitmaps, Opt_freespace_tree,
+	Opt_frsp_cache_aggression,
+
 };
 
 static const match_table_t tokens = {
@@ -1615,6 +1617,7 @@ static const match_table_t tokens = {
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
+	{Opt_frsp_cache_aggression, "frsp_cache_aggression=%u"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
@@ -1831,6 +1834,7 @@ static const struct mount_opts {
 	{Opt_jqfmt_vfsv0, QFMT_VFS_V0, MOPT_QFMT},
 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
+	{Opt_frsp_cache_aggression, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
@@ -2038,6 +2042,10 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		sbi->s_li_wait_mult = arg;
 	} else if (token == Opt_max_dir_size_kb) {
 		sbi->s_max_dir_size_kb = arg;
+	} else if (token == Opt_frsp_cache_aggression) {
+		sbi->s_mb_frsp_cache_aggression =
+			min(EXT4_MB_FRSP_MAX_CACHE_AGGRESSION,
+				max(EXT4_MB_FRSP_MIN_CACHE_AGGRESSION, arg));
 	} else if (token == Opt_stripe) {
 		sbi->s_stripe = arg;
 	} else if (token == Opt_resuid) {
@@ -3959,6 +3967,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
+	sbi->s_mb_frsp_cache_aggression = EXT4_MB_FRSP_DEFAULT_CACHE_AGGRESSION;
 
 	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
 		set_opt(sb, BARRIER);
-- 
2.28.0.220.ged08abb693-goog

