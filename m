Return-Path: <linux-ext4+bounces-8993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9AB03FA4
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008DD4A13A7
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A12550AF;
	Mon, 14 Jul 2025 13:18:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074225B311;
	Mon, 14 Jul 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499129; cv=none; b=Wj2w5S8jppFhSLFCitinFA8KPI7buYAtq6CYIcGZVUFwhyhRuNDvR6f0aVhdR3dUW0vXSo/OLpob28H5ZrU/YnQliLsfyhT+9oC0XDDqR4rTs9sFkJ/eMMmY/pWLPBloBKn3Bo/tOMqfTirmrmKW7sKQV3wEe4ngEVldFVUHqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499129; c=relaxed/simple;
	bh=LrjfXJ/dqd74/iQS83AvO7Shl8OfYWxeFZgDz4/+onM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkcQ0MzpouQ/qUoqZvXa0g47Z+qVL2Qi3Hy/SPMLD5eZOd9tnFEpKOpDXCC136S0G1gn6K04pnCw+NHIvOjV8amACyQqUy+2pOxm0rYCpiP2zwL/atDTP6hLz4utrvx/zsRYSpSui3WqLWG0g91om3EmUAbzLQq+ItLnTTmAB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgjXy1jD2ztSml;
	Mon, 14 Jul 2025 21:17:38 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id D0A0718006C;
	Mon, 14 Jul 2025 21:18:43 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:42 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Date: Mon, 14 Jul 2025 21:03:25 +0800
Message-ID: <20250714130327.1830534-16-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

While traversing the list, holding a spin_lock prevents load_buddy, making
direct use of ext4_try_lock_group impossible. This can lead to a bouncing
scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
fails, forcing the list traversal to repeatedly restart from grp_A.

In contrast, linear traversal directly uses ext4_try_lock_group(),
avoiding this bouncing. Therefore, we need a lockless, ordered traversal
to achieve linear-like efficiency.

Therefore, this commit converts both average fragment size lists and
largest free order lists into ordered xarrays.

In an xarray, the index represents the block group number and the value
holds the block group information; a non-empty value indicates the block
group's presence.

While insertion and deletion complexity remain O(1), lookup complexity
changes from O(1) to O(nlogn), which may slightly reduce single-threaded
performance.

Additionally, xarray insertions might fail, potentially due to memory
allocation issues. However, since we have linear traversal as a fallback,
this isn't a major problem. Therefore, we've only added a warning message
for insertion failures here.

A helper function ext4_mb_find_good_group_xarray() is added to find good
groups in the specified xarray starting at the specified position start,
and when it reaches ngroups-1, it wraps around to 0 and then to start-1.
This ensures an ordered traversal within the xarray.

Performance test results are as follows: Single-process operations
on an empty disk show negligible impact, while multi-process workloads
demonstrate a noticeable performance gain.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 20097 | 19555 (-2.6%)  | 316141 | 315636 (-0.2%) |
|mb_optimize_scan=1 | 13318 | 15496 (+16.3%) | 325273 | 323569 (-0.5%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 53603 | 53192 (-0.7%)  | 214243 | 212678 (-0.7%) |
|mb_optimize_scan=1 | 20887 | 37636 (+80.1%) | 213632 | 214189 (+0.2%) |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |   8 +-
 fs/ext4/mballoc.c | 254 +++++++++++++++++++++++++---------------------
 2 files changed, 140 insertions(+), 122 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 52a72af6ec34..ea412fdb0b76 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1608,10 +1608,8 @@ struct ext4_sb_info {
 	struct list_head s_discard_list;
 	struct work_struct s_discard_work;
 	atomic_t s_retry_alloc_pending;
-	struct list_head *s_mb_avg_fragment_size;
-	rwlock_t *s_mb_avg_fragment_size_locks;
-	struct list_head *s_mb_largest_free_orders;
-	rwlock_t *s_mb_largest_free_orders_locks;
+	struct xarray *s_mb_avg_fragment_size;
+	struct xarray *s_mb_largest_free_orders;
 
 	/* tunables */
 	unsigned long s_stripe;
@@ -3485,8 +3483,6 @@ struct ext4_group_info {
 	void            *bb_bitmap;
 #endif
 	struct rw_semaphore alloc_sem;
-	struct list_head bb_avg_fragment_size_node;
-	struct list_head bb_largest_free_order_node;
 	ext4_grpblk_t	bb_counters[];	/* Nr of free power-of-two-block
 					 * regions, index is order.
 					 * bb_counters[3] = 5 means
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0c3cbc7e2e85..a9eb997b8c9b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -132,25 +132,30 @@
  * If "mb_optimize_scan" mount option is set, we maintain in memory group info
  * structures in two data structures:
  *
- * 1) Array of largest free order lists (sbi->s_mb_largest_free_orders)
+ * 1) Array of largest free order xarrays (sbi->s_mb_largest_free_orders)
  *
- *    Locking: sbi->s_mb_largest_free_orders_locks(array of rw locks)
+ *    Locking: Writers use xa_lock, readers use rcu_read_lock.
  *
- *    This is an array of lists where the index in the array represents the
+ *    This is an array of xarrays where the index in the array represents the
  *    largest free order in the buddy bitmap of the participating group infos of
- *    that list. So, there are exactly MB_NUM_ORDERS(sb) (which means total
- *    number of buddy bitmap orders possible) number of lists. Group-infos are
- *    placed in appropriate lists.
+ *    that xarray. So, there are exactly MB_NUM_ORDERS(sb) (which means total
+ *    number of buddy bitmap orders possible) number of xarrays. Group-infos are
+ *    placed in appropriate xarrays.
  *
- * 2) Average fragment size lists (sbi->s_mb_avg_fragment_size)
+ * 2) Average fragment size xarrays (sbi->s_mb_avg_fragment_size)
  *
- *    Locking: sbi->s_mb_avg_fragment_size_locks(array of rw locks)
+ *    Locking: Writers use xa_lock, readers use rcu_read_lock.
  *
- *    This is an array of lists where in the i-th list there are groups with
+ *    This is an array of xarrays where in the i-th xarray there are groups with
  *    average fragment size >= 2^i and < 2^(i+1). The average fragment size
  *    is computed as ext4_group_info->bb_free / ext4_group_info->bb_fragments.
- *    Note that we don't bother with a special list for completely empty groups
- *    so we only have MB_NUM_ORDERS(sb) lists.
+ *    Note that we don't bother with a special xarray for completely empty
+ *    groups so we only have MB_NUM_ORDERS(sb) xarrays. Group-infos are placed
+ *    in appropriate xarrays.
+ *
+ * In xarray, the index is the block group number, the value is the block group
+ * information, and a non-empty value indicates the block group is present in
+ * the current xarray.
  *
  * When "mb_optimize_scan" mount option is set, mballoc consults the above data
  * structures to decide the order in which groups are to be traversed for
@@ -852,21 +857,75 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	if (new == old)
 		return;
 
-	if (old >= 0) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[old]);
-		list_del(&grp->bb_avg_fragment_size_node);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[old]);
-	}
+	if (old >= 0)
+		xa_erase(&sbi->s_mb_avg_fragment_size[old], grp->bb_group);
 
 	grp->bb_avg_fragment_size_order = new;
 	if (new >= 0) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[new]);
-		list_add_tail(&grp->bb_avg_fragment_size_node,
-				&sbi->s_mb_avg_fragment_size[new]);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[new]);
+		/*
+		* Cannot use __GFP_NOFAIL because we hold the group lock.
+		* Although allocation for insertion may fails, it's not fatal
+		* as we have linear traversal to fall back on.
+		*/
+		int err = xa_insert(&sbi->s_mb_avg_fragment_size[new],
+				    grp->bb_group, grp, GFP_ATOMIC);
+		if (err)
+			mb_debug(sb, "insert group: %u to s_mb_avg_fragment_size[%d] failed, err %d",
+				 grp->bb_group, new, err);
 	}
 }
 
+static struct ext4_group_info *
+ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
+			       struct xarray *xa, ext4_group_t start)
+{
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	enum criteria cr = ac->ac_criteria;
+	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	unsigned long group = start;
+	ext4_group_t end = ngroups;
+	struct ext4_group_info *grp;
+
+	if (WARN_ON_ONCE(start >= end))
+		return NULL;
+
+wrap_around:
+	xa_for_each_range(xa, group, grp, start, end - 1) {
+		if (sbi->s_mb_stats)
+			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
+
+		if (!spin_is_locked(ext4_group_lock_ptr(sb, group)) &&
+		    likely(ext4_mb_good_group(ac, group, cr)))
+			return grp;
+
+		cond_resched();
+	}
+
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
+
+	return NULL;
+}
+
+/*
+ * Find a suitable group of given order from the largest free orders xarray.
+ */
+static struct ext4_group_info *
+ext4_mb_find_good_group_largest_free_order(struct ext4_allocation_context *ac,
+					   int order, ext4_group_t start)
+{
+	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_largest_free_orders[order];
+
+	if (xa_empty(xa))
+		return NULL;
+
+	return ext4_mb_find_good_group_xarray(ac, xa, start);
+}
+
 /*
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
@@ -875,7 +934,7 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 			enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *iter;
+	struct ext4_group_info *grp;
 	int i;
 
 	if (ac->ac_status == AC_STATUS_FOUND)
@@ -885,26 +944,12 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
 
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
-			continue;
-		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
-		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
-			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
-			continue;
-		}
-		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
-				    bb_largest_free_order_node) {
-			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
-			if (!spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group)) &&
-			    likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
-				*group = iter->bb_group;
-				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
-				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
-				return;
-			}
+		grp = ext4_mb_find_good_group_largest_free_order(ac, i, *group);
+		if (grp) {
+			*group = grp->bb_group;
+			ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
+			return;
 		}
-		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
 	}
 
 	/* Increment cr and search again if no group is found */
@@ -912,35 +957,18 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 }
 
 /*
- * Find a suitable group of given order from the average fragments list.
+ * Find a suitable group of given order from the average fragments xarray.
  */
 static struct ext4_group_info *
-ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int order)
+ext4_mb_find_good_group_avg_frag_xarray(struct ext4_allocation_context *ac,
+					int order, ext4_group_t start)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct list_head *frag_list = &sbi->s_mb_avg_fragment_size[order];
-	rwlock_t *frag_list_lock = &sbi->s_mb_avg_fragment_size_locks[order];
-	struct ext4_group_info *grp = NULL, *iter;
-	enum criteria cr = ac->ac_criteria;
+	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_avg_fragment_size[order];
 
-	if (list_empty(frag_list))
+	if (xa_empty(xa))
 		return NULL;
-	read_lock(frag_list_lock);
-	if (list_empty(frag_list)) {
-		read_unlock(frag_list_lock);
-		return NULL;
-	}
-	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
-		if (sbi->s_mb_stats)
-			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
-		if (!spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group)) &&
-		    likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
-			grp = iter;
-			break;
-		}
-	}
-	read_unlock(frag_list_lock);
-	return grp;
+
+	return ext4_mb_find_good_group_xarray(ac, xa, start);
 }
 
 /*
@@ -961,7 +989,7 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 
 	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		grp = ext4_mb_find_good_group_avg_frag_lists(ac, i);
+		grp = ext4_mb_find_good_group_avg_frag_xarray(ac, i, *group);
 		if (grp) {
 			*group = grp->bb_group;
 			ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
@@ -1057,7 +1085,8 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 		frag_order = mb_avg_fragment_size_order(ac->ac_sb,
 							ac->ac_g_ex.fe_len);
 
-		grp = ext4_mb_find_good_group_avg_frag_lists(ac, frag_order);
+		grp = ext4_mb_find_good_group_avg_frag_xarray(ac, frag_order,
+							      *group);
 		if (grp) {
 			*group = grp->bb_group;
 			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
@@ -1162,18 +1191,25 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 	if (new == old)
 		return;
 
-	if (old >= 0 && !list_empty(&grp->bb_largest_free_order_node)) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
-		list_del_init(&grp->bb_largest_free_order_node);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
+	if (old >= 0) {
+		struct xarray *xa = &sbi->s_mb_largest_free_orders[old];
+
+		if (!xa_empty(xa) && xa_load(xa, grp->bb_group))
+			xa_erase(xa, grp->bb_group);
 	}
 
 	grp->bb_largest_free_order = new;
 	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && new >= 0 && grp->bb_free) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
-		list_add_tail(&grp->bb_largest_free_order_node,
-			      &sbi->s_mb_largest_free_orders[new]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
+		/*
+		* Cannot use __GFP_NOFAIL because we hold the group lock.
+		* Although allocation for insertion may fails, it's not fatal
+		* as we have linear traversal to fall back on.
+		*/
+		int err = xa_insert(&sbi->s_mb_largest_free_orders[new],
+				    grp->bb_group, grp, GFP_ATOMIC);
+		if (err)
+			mb_debug(sb, "insert group: %u to s_mb_largest_free_orders[%d] failed, err %d",
+				 grp->bb_group, new, err);
 	}
 }
 
@@ -3269,6 +3305,7 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 	unsigned long position = ((unsigned long) v);
 	struct ext4_group_info *grp;
 	unsigned int count;
+	unsigned long idx;
 
 	position--;
 	if (position >= MB_NUM_ORDERS(sb)) {
@@ -3277,11 +3314,8 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 			seq_puts(seq, "avg_fragment_size_lists:\n");
 
 		count = 0;
-		read_lock(&sbi->s_mb_avg_fragment_size_locks[position]);
-		list_for_each_entry(grp, &sbi->s_mb_avg_fragment_size[position],
-				    bb_avg_fragment_size_node)
+		xa_for_each(&sbi->s_mb_avg_fragment_size[position], idx, grp)
 			count++;
-		read_unlock(&sbi->s_mb_avg_fragment_size_locks[position]);
 		seq_printf(seq, "\tlist_order_%u_groups: %u\n",
 					(unsigned int)position, count);
 		return 0;
@@ -3293,11 +3327,8 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 		seq_puts(seq, "max_free_order_lists:\n");
 	}
 	count = 0;
-	read_lock(&sbi->s_mb_largest_free_orders_locks[position]);
-	list_for_each_entry(grp, &sbi->s_mb_largest_free_orders[position],
-			    bb_largest_free_order_node)
+	xa_for_each(&sbi->s_mb_largest_free_orders[position], idx, grp)
 		count++;
-	read_unlock(&sbi->s_mb_largest_free_orders_locks[position]);
 	seq_printf(seq, "\tlist_order_%u_groups: %u\n",
 		   (unsigned int)position, count);
 
@@ -3417,8 +3448,6 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
-	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
-	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
 	meta_group_info[i]->bb_avg_fragment_size_order = -1;  /* uninit */
 	meta_group_info[i]->bb_group = group;
@@ -3628,6 +3657,20 @@ static void ext4_discard_work(struct work_struct *work)
 		ext4_mb_unload_buddy(&e4b);
 }
 
+static inline void ext4_mb_avg_fragment_size_destory(struct ext4_sb_info *sbi)
+{
+	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
+		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
+	kfree(sbi->s_mb_avg_fragment_size);
+}
+
+static inline void ext4_mb_largest_free_orders_destory(struct ext4_sb_info *sbi)
+{
+	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
+		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
+	kfree(sbi->s_mb_largest_free_orders);
+}
+
 int ext4_mb_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -3673,41 +3716,24 @@ int ext4_mb_init(struct super_block *sb)
 	} while (i < MB_NUM_ORDERS(sb));
 
 	sbi->s_mb_avg_fragment_size =
-		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct xarray),
 			GFP_KERNEL);
 	if (!sbi->s_mb_avg_fragment_size) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	sbi->s_mb_avg_fragment_size_locks =
-		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
-			GFP_KERNEL);
-	if (!sbi->s_mb_avg_fragment_size_locks) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
-		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
-		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
-	}
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		xa_init(&sbi->s_mb_avg_fragment_size[i]);
+
 	sbi->s_mb_largest_free_orders =
-		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct xarray),
 			GFP_KERNEL);
 	if (!sbi->s_mb_largest_free_orders) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	sbi->s_mb_largest_free_orders_locks =
-		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
-			GFP_KERNEL);
-	if (!sbi->s_mb_largest_free_orders_locks) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
-		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
-		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
-	}
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		xa_init(&sbi->s_mb_largest_free_orders[i]);
 
 	spin_lock_init(&sbi->s_md_lock);
 	atomic_set(&sbi->s_mb_free_pending, 0);
@@ -3792,10 +3818,8 @@ int ext4_mb_init(struct super_block *sb)
 	kfree(sbi->s_mb_last_groups);
 	sbi->s_mb_last_groups = NULL;
 out:
-	kfree(sbi->s_mb_avg_fragment_size);
-	kfree(sbi->s_mb_avg_fragment_size_locks);
-	kfree(sbi->s_mb_largest_free_orders);
-	kfree(sbi->s_mb_largest_free_orders_locks);
+	ext4_mb_avg_fragment_size_destory(sbi);
+	ext4_mb_largest_free_orders_destory(sbi);
 	kfree(sbi->s_mb_offsets);
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
@@ -3862,10 +3886,8 @@ void ext4_mb_release(struct super_block *sb)
 		kvfree(group_info);
 		rcu_read_unlock();
 	}
-	kfree(sbi->s_mb_avg_fragment_size);
-	kfree(sbi->s_mb_avg_fragment_size_locks);
-	kfree(sbi->s_mb_largest_free_orders);
-	kfree(sbi->s_mb_largest_free_orders_locks);
+	ext4_mb_avg_fragment_size_destory(sbi);
+	ext4_mb_largest_free_orders_destory(sbi);
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
 	iput(sbi->s_buddy_cache);
-- 
2.46.1


