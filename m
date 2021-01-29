Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF330901B
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhA2Wa7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 17:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhA2Waw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 17:30:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02365C061756
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so7597258pgc.8
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwzL66l78YC9XHSG0HI0SpBsDatauoevS1vnmN19GMs=;
        b=p7FHgMic34q0cuhdTck8fH303XPTQ2UwyNV4aqKL7UxAlTwXTm8TPN+IpfBGiXE01Z
         72rNUBNoY0rZDy0OjDmxNj2dAvLUklxD8oVghcq/4OL0b/4F5s5jr58NanoELrtLIoga
         Y72YTV1nEkHdSGhys2EXSZqqFGIPk+3q13hF89JWh/nPs6J7eZ2+QUJNvVeJ/FilKVGz
         vC3gWVrXJsQnCpt4lp00nRx5Vm6YPp3wgGuZm7bHhYpz/c4lBbTHC3VNw7XEUpq9A2tF
         e+IcksZe2yGgTyLkSN/gnNfkJoia21uylBSPkfpOcyteErfBPLhYc+cS/tgzE7DlGzC1
         PfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwzL66l78YC9XHSG0HI0SpBsDatauoevS1vnmN19GMs=;
        b=htcj8gnFwYqDI+5qC+0vbrQ3sqd23pgsEDCi0IKFTRiAcXr9aWj9qARFQCtHb3LlF8
         NHcFHixk53MgTyFcmiJtGBCugBz5S2yrWT7z8e43SSyXE5lT3gR7f27k8/S8snothMAv
         DGcGpx2JHACWm+jyHXadlt9hg/z+7uZFwUSAHQXmxgByTC4HXDGPFqMf3b8O6A4/qzUa
         TbiwuTdi9PzPFpOLD3e7SGsbKMJWL+uBL6q4w8GHI2NED/Gb/K8BoGl78RcRNt/Wqu2k
         Kk4ze8bYaSM9T7p2UL1kKfNAys8DM6ggGwiouGfs7yb3WhFRg7mZ3+7gflj7prVDi5PG
         Y+ug==
X-Gm-Message-State: AOAM531mv/ZEHmfFfLMJM48pXkHwS8+JtPhuU534Y4Jjppo0O4P6Yd34
        1aBj5ts2P3rLjWc9eixOL2UwmsYTgzM=
X-Google-Smtp-Source: ABdhPJztDcPmJCyNJwUuXnfKa6dhKF7qkZ/yXIn5vQtLsGooRht6vNGmztSXCXwq+Y+ufuRNGhgttg==
X-Received: by 2002:a63:6686:: with SMTP id a128mr6530885pgc.109.1611959410872;
        Fri, 29 Jan 2021 14:30:10 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id d14sm9719358pfo.156.2021.01.29.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:30:10 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/4] ext4: improve cr 0 / cr 1 group scanning
Date:   Fri, 29 Jan 2021 14:29:30 -0800
Message-Id: <20210129222931.623008-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of traversing through groups linearly, scan groups in specific
orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
largest free order >= the order of the request. So, with this patch,
we maintain all the ext4_group_info structs in lists for each possible
order. During cr 0 allocation, we traverse these lists in the
increasing order of largest free orders. This allows us to find a
group with the best available cr 0 match in constant time. If nothing
can be found, we fallback to cr 1 immediately.

At CR1, the story is slightly different. We want to traverse in the
order of increasing average fragment size. For CR1, we maintain a rb
tree of groupinfos which is sorted by average fragment size. Instead
of traversing linearly, at CR1, we traverse in the order of increasing
average fragment size, starting at the most optimal group. This brings
down cr 1 search complexity to log(num groups).

For cr >= 2, we just perform the linear search as before. Also, in
case of lock contention, we intermittently fallback to linear search
even in CR 0 and CR 1 cases. This allows us to proceed during the
allocation path even in case of high contention.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |   6 ++
 fs/ext4/mballoc.c | 223 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |   1 +
 3 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6dd127942208..da12a083bf52 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1527,6 +1527,9 @@ struct ext4_sb_info {
 	unsigned int s_mb_free_pending;
 	struct list_head s_freed_data_list;	/* List of blocks to be freed
 						   after commit completed */
+	struct rb_root s_mb_avg_fragment_size_root;
+	struct list_head *s_mb_largest_free_orders;
+	rwlock_t s_mb_rb_lock;
 
 	/* tunables */
 	unsigned long s_stripe;
@@ -3304,11 +3307,14 @@ struct ext4_group_info {
 	ext4_grpblk_t	bb_free;	/* total free blocks */
 	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
+	ext4_group_t	bb_group;	/* Group number */
 	struct          list_head bb_prealloc_list;
 #ifdef DOUBLE_CHECK
 	void            *bb_bitmap;
 #endif
 	struct rw_semaphore alloc_sem;
+	struct rb_node	bb_avg_fragment_size_rb;
+	struct list_head bb_largest_free_order_node;
 	ext4_grpblk_t	bb_counters[];	/* Nr of free power-of-two-block
 					 * regions, index is order.
 					 * bb_counters[3] = 5 means
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 11c56b0e6f35..413259477b03 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -744,6 +744,193 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
 	}
 }
 
+static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
+			int (*cmp)(struct rb_node *, struct rb_node *))
+{
+	struct rb_node **iter = &root->rb_node, *parent = NULL;
+
+	while (*iter) {
+		parent = *iter;
+		if (cmp(new, *iter))
+			iter = &((*iter)->rb_left);
+		else
+			iter = &((*iter)->rb_right);
+	}
+
+	rb_link_node(new, parent, iter);
+	rb_insert_color(new, root);
+}
+
+static int
+ext4_mb_avg_fragment_size_cmp(struct rb_node *rb1, struct rb_node *rb2)
+{
+	struct ext4_group_info *grp1 = rb_entry(rb1,
+						struct ext4_group_info,
+						bb_avg_fragment_size_rb);
+	struct ext4_group_info *grp2 = rb_entry(rb2,
+						struct ext4_group_info,
+						bb_avg_fragment_size_rb);
+	int num_frags_1, num_frags_2;
+
+	num_frags_1 = grp1->bb_fragments ?
+		grp1->bb_free / grp1->bb_fragments : 0;
+	num_frags_2 = grp2->bb_fragments ?
+		grp2->bb_free / grp2->bb_fragments : 0;
+
+	return (num_frags_1 < num_frags_2);
+}
+
+/*
+ * Reinsert grpinfo into the avg_fragment_size tree and into the appropriate
+ * largest_free_order list.
+ */
+static void
+ext4_mb_reinsert_grpinfo(struct super_block *sb, struct ext4_group_info *grp)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	write_lock(&sbi->s_mb_rb_lock);
+	if (!RB_EMPTY_NODE(&grp->bb_avg_fragment_size_rb)) {
+		rb_erase(&grp->bb_avg_fragment_size_rb,
+				&sbi->s_mb_avg_fragment_size_root);
+		RB_CLEAR_NODE(&grp->bb_avg_fragment_size_rb);
+	}
+
+	ext4_mb_rb_insert(&sbi->s_mb_avg_fragment_size_root,
+		&grp->bb_avg_fragment_size_rb,
+		ext4_mb_avg_fragment_size_cmp);
+
+	list_del_init(&grp->bb_largest_free_order_node);
+	if (grp->bb_largest_free_order >= 0)
+		list_add(&grp->bb_largest_free_order_node,
+			 &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
+	write_unlock(&sbi->s_mb_rb_lock);
+}
+
+/*
+ * ext4_mb_choose_next_group: choose next group for allocation.
+ *
+ * @ac        Allocation Context
+ * @new_cr    This is an output parameter. If the there is no good group available
+ *            at current CR level, this field is updated to indicate the new cr
+ *            level that should be used.
+ * @group     This is an input / output parameter. As an input it indicates the last
+ *            group used for allocation. As output, this field indicates the
+ *            next group that should be used.
+ * @ngroups   Total number of groups
+ */
+static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
+		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	int avg_fragment_size, best_so_far, i;
+	struct rb_node *node, *found;
+	struct ext4_group_info *grp;
+
+	*new_cr = ac->ac_criteria;
+	if (*new_cr >= 2 ||
+	    !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
+		goto inc_and_return;
+
+	/*
+	 * If there is contention on the lock, instead of waiting for the lock
+	 * to become available, just continue searching lineraly.
+	 */
+	if (!read_trylock(&sbi->s_mb_rb_lock))
+		goto inc_and_return;
+
+	if (*new_cr == 0) {
+		grp = NULL;
+
+		if (ac->ac_status == AC_STATUS_FOUND)
+			goto inc_and_return;
+
+		for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
+			if (list_empty(&sbi->s_mb_largest_free_orders[i]))
+				continue;
+			grp = list_first_entry(&sbi->s_mb_largest_free_orders[i],
+					       struct ext4_group_info,
+					       bb_largest_free_order_node);
+			break;
+		}
+
+		if (grp) {
+			*group = grp->bb_group;
+			goto done;
+		}
+		/* Increment cr and search again */
+		*new_cr = 1;
+	}
+
+	/*
+	 * At CR 1, if enough groups are not loaded, we just fallback to
+	 * linear search
+	 */
+	if (atomic_read(&sbi->s_mb_buddies_generated) <
+	    ext4_get_groups_count(ac->ac_sb)) {
+		read_unlock(&sbi->s_mb_rb_lock);
+		goto inc_and_return;
+	}
+
+	if (*new_cr == 1) {
+		if (ac->ac_f_ex.fe_len > 0) {
+			/* We have found something at CR 1 in the past */
+			grp = ext4_get_group_info(ac->ac_sb, ac->ac_last_optimal_group);
+			found = rb_next(&grp->bb_avg_fragment_size_rb);
+			if (found) {
+				grp = rb_entry(found, struct ext4_group_info,
+					       bb_avg_fragment_size_rb);
+				*group = grp->bb_group;
+			} else {
+				*new_cr = 2;
+			}
+			goto done;
+		}
+
+		/* This is the first time we are searching in the tree */
+		node = sbi->s_mb_avg_fragment_size_root.rb_node;
+		best_so_far = 0;
+		found = NULL;
+
+		while (node) {
+			grp = rb_entry(node, struct ext4_group_info,
+				bb_avg_fragment_size_rb);
+			avg_fragment_size = grp->bb_fragments ?
+				grp->bb_free / grp->bb_fragments : 0;
+			if (avg_fragment_size > ac->ac_g_ex.fe_len) {
+				if (!best_so_far || avg_fragment_size < best_so_far) {
+					best_so_far = avg_fragment_size;
+					found = node;
+				}
+			}
+			if (avg_fragment_size > ac->ac_g_ex.fe_len)
+				node = node->rb_right;
+			else
+				node = node->rb_left;
+		}
+		if (found) {
+			grp = rb_entry(found, struct ext4_group_info,
+				bb_avg_fragment_size_rb);
+			*group = grp->bb_group;
+		} else {
+			*new_cr = 2;
+		}
+	}
+done:
+	read_unlock(&sbi->s_mb_rb_lock);
+	ac->ac_last_optimal_group = *group;
+	return;
+
+inc_and_return:
+	/*
+	 * Artificially restricted ngroups for non-extent
+	 * files makes group > ngroups possible on first loop.
+	 */
+	*group = *group + 1;
+	if (*group >= ngroups)
+		*group = 0;
+}
+
 /*
  * Cache the order of the largest free extent we have available in this block
  * group.
@@ -818,6 +1005,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	period = get_cycles() - period;
 	atomic_inc(&sbi->s_mb_buddies_generated);
 	atomic64_add(period, &sbi->s_mb_generation_time);
+	ext4_mb_reinsert_grpinfo(sb, grp);
 }
 
 /* The buddy information is attached the buddy cache inode
@@ -1517,6 +1705,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
 done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
+	ext4_mb_reinsert_grpinfo(sb, e4b->bd_info);
 	mb_check_buddy(e4b);
 }
 
@@ -1653,6 +1842,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	}
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
+	ext4_mb_reinsert_grpinfo(e4b->bd_sb, e4b->bd_info);
 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
 	mb_check_buddy(e4b);
 
@@ -2345,17 +2535,20 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		ac->ac_last_optimal_group = group;
 		prefetch_grp = group;
 
-		for (i = 0; i < ngroups; group++, i++) {
-			int ret = 0;
+		for (i = 0; i < ngroups; i++) {
+			int ret = 0, new_cr;
+
 			cond_resched();
-			/*
-			 * Artificially restricted ngroups for non-extent
-			 * files makes group > ngroups possible on first loop.
-			 */
-			if (group >= ngroups)
-				group = 0;
+
+			ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups);
+
+			if (new_cr != cr) {
+				cr = new_cr;
+				goto repeat;
+			}
 
 			/*
 			 * Batch reads of the block allocation bitmaps
@@ -2650,7 +2843,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
+	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
+	RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
+	meta_group_info[i]->bb_group = group;
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
@@ -2840,6 +3036,15 @@ int ext4_mb_init(struct super_block *sb)
 		i++;
 	} while (i < MB_NUM_ORDERS(sb));
 
+	sbi->s_mb_avg_fragment_size_root = RB_ROOT;
+	sbi->s_mb_largest_free_orders =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+			GFP_KERNEL);
+	if (!sbi->s_mb_largest_free_orders)
+		goto out;
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
+	rwlock_init(&sbi->s_mb_rb_lock);
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
@@ -2903,6 +3108,7 @@ int ext4_mb_init(struct super_block *sb)
 	free_percpu(sbi->s_locality_groups);
 	sbi->s_locality_groups = NULL;
 out:
+	kfree(sbi->s_mb_largest_free_orders);
 	kfree(sbi->s_mb_offsets);
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
@@ -2959,6 +3165,7 @@ int ext4_mb_release(struct super_block *sb)
 		kvfree(group_info);
 		rcu_read_unlock();
 	}
+	kfree(sbi->s_mb_largest_free_orders);
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
 	iput(sbi->s_buddy_cache);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 68111a10cfee..57b44c7320b2 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -166,6 +166,7 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	ext4_group_t ac_last_optimal_group;
 	__u16 ac_groups_scanned;
 	__u16 ac_found;
 	__u16 ac_tail;
-- 
2.30.0.365.g02bc693789-goog

