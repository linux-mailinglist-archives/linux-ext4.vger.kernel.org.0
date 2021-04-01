Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1935199C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhDARzo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhDARrZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:47:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EDC0319CE
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g15so1945763pfq.3
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rj1vAZl2CLNraKcq64zHtn9SYUJCd/31uFNw6mZsVOo=;
        b=BhN5xtV2PWbQAPeo2o9AY5ZCupogctYmDSskplznWVUHqwTTurstdlha6sS2KGY/xs
         Dzk/VEjq6frJM34adC0OZbSVZXnhX7euF0lBvDRAv2nuRXE491StjqARYee/30BWA6I7
         cMKc3V2hgF1PYKbDUqsTYR2VHPEFbqcwo4qynJyN/G2UURjKfnbemCRh/wmeZpniTjfn
         GqFSqQF8OiB8agKf7FgUN5EhLqGMQiKQGxYJyJFMp8vECMwwdb9Fn42RqlMB8DxQbpU1
         ZAu2VDC+cR+e3qOuII5oyZuF3Qv2a/hEQN+JWyrTDq+4uUK6bhZNqKuReLcEZD8HuqmF
         fyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rj1vAZl2CLNraKcq64zHtn9SYUJCd/31uFNw6mZsVOo=;
        b=PNICuz7mS0C+K+ww4H661u5TvemoT9HaL6iRujTUdD+n21pcde6+N5z9VCk0Y2r17j
         9enYTwuavzqYXi9L2B1EMN1MudBylYXKlopkBLmq9qFameSdC+HIOaL1Hea4ZBQpNxXA
         pv26HunTFnIT/GI3gmhOxGc6TXwNfGYp9yjSQYLJn0fsGg7qBHr18dXH9WzJVtv9N0PD
         ly9CWemnTealsXLIyY9tycNpeE53I9rKGZ+/UAul0ooSorSsGmHj7QiYGkR1DBp6wVM0
         S6Zw+lwilFxXEDhZC+Wu9wcsYfeojjqnbH3F1KIYesknEKCuWorQK0unIf2jEPaVOrc/
         sfVw==
X-Gm-Message-State: AOAM531TAvtTbiJd2urFmzBlR8aAthMxLsAXw7MCOn/lx7jcPoe/Mu82
        lh4CwsGOeWPkMZ7jzSQzvUrJDm2fjkw=
X-Google-Smtp-Source: ABdhPJyqIf63datl/DlWxcCp/fyTjHAW7lD9K52Ntfx187clH/kR4Wk+VQFjaZcArBBhTlllBNZVXQ==
X-Received: by 2002:a63:115d:: with SMTP id 29mr1067963pgr.259.1617297703780;
        Thu, 01 Apr 2021 10:21:43 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:43 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v6 5/7] ext4: improve cr 0 / cr 1 group scanning
Date:   Thu,  1 Apr 2021 10:21:27 -0700
Message-Id: <20210401172129.189766-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of traversing through groups linearly, scan groups in specific
orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
largest free order >= the order of the request. So, with this patch,
we maintain lists for each possible order and insert each group into a
list based on the largest free order in its buddy bitmap. During cr 0
allocation, we traverse these lists in the increasing order of largest
free orders. This allows us to find a group with the best available cr
0 match in constant time. If nothing can be found, we fallback to cr 1
immediately.

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

There is an opportunity to do optimization at CR2 too. That's because
at CR2 we only consider groups where bb_free counter (number of free
blocks) is greater than the request extent size. That's left as future
work.

All the changes introduced in this patch are protected under a new
mount option "mb_optimize_scan".

With this patchset, following experiment was performed:

Created a highly fragmented disk of size 65TB. The disk had no
contiguous 2M regions. Following command was run consecutively for 3
times:

time dd if=/dev/urandom of=file bs=2M count=10

Here are the results with and without cr 0/1 optimizations introduced
in this patch:

|---------+------------------------------+---------------------------|
|         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
|---------+------------------------------+---------------------------|
| 1st run | 5m1.871s                     | 2m47.642s                 |
| 2nd run | 2m28.390s                    | 0m0.611s                  |
| 3rd run | 2m26.530s                    | 0m1.255s                  |
|---------+------------------------------+---------------------------|

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/ext4.h    |  21 ++-
 fs/ext4/mballoc.c | 399 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |  17 +-
 fs/ext4/super.c   |  28 +++-
 fs/ext4/sysfs.c   |   2 +
 5 files changed, 452 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 85eeeba3bca3..1029716928c2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -162,7 +162,12 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
-
+/* Large fragment size list lookup succeeded at least once for cr = 0 */
+#define EXT4_MB_CR0_OPTIMIZED		0x8000
+/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
+#define EXT4_MB_CR1_OPTIMIZED		0x00010000
+/* Perform linear traversal for one group */
+#define EXT4_MB_SEARCH_NEXT_LINEAR	0x00020000
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
 	struct inode *inode;
@@ -1247,7 +1252,9 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
 #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
 #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
-
+#define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
+						    * scanning in mballoc
+						    */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
@@ -1527,9 +1534,14 @@ struct ext4_sb_info {
 	unsigned int s_mb_free_pending;
 	struct list_head s_freed_data_list;	/* List of blocks to be freed
 						   after commit completed */
+	struct rb_root s_mb_avg_fragment_size_root;
+	rwlock_t s_mb_rb_lock;
+	struct list_head *s_mb_largest_free_orders;
+	rwlock_t *s_mb_largest_free_orders_locks;
 
 	/* tunables */
 	unsigned long s_stripe;
+	unsigned int s_mb_max_linear_groups;
 	unsigned int s_mb_stream_request;
 	unsigned int s_mb_max_to_scan;
 	unsigned int s_mb_min_to_scan;
@@ -1553,6 +1565,8 @@ struct ext4_sb_info {
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
+	atomic_t s_bal_cr0_bad_suggestions;
+	atomic_t s_bal_cr1_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[4];
 	atomic64_t s_bal_cX_hits[4];
 	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find blocks */
@@ -3309,11 +3323,14 @@ struct ext4_group_info {
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
index 15127d815461..bb4da7c4d113 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -127,11 +127,50 @@
  * smallest multiple of the stripe value (sbi->s_stripe) which is
  * greater than the default mb_group_prealloc.
  *
+ * If "mb_optimize_scan" mount option is set, we maintain in memory group info
+ * structures in two data structures:
+ *
+ * 1) Array of largest free order lists (sbi->s_mb_largest_free_orders)
+ *
+ *    Locking: sbi->s_mb_largest_free_orders_locks(array of rw locks)
+ *
+ *    This is an array of lists where the index in the array represents the
+ *    largest free order in the buddy bitmap of the participating group infos of
+ *    that list. So, there are exactly MB_NUM_ORDERS(sb) (which means total
+ *    number of buddy bitmap orders possible) number of lists. Group-infos are
+ *    placed in appropriate lists.
+ *
+ * 2) Average fragment size rb tree (sbi->s_mb_avg_fragment_size_root)
+ *
+ *    Locking: sbi->s_mb_rb_lock (rwlock)
+ *
+ *    This is a red black tree consisting of group infos and the tree is sorted
+ *    by average fragment sizes (which is calculated as ext4_group_info->bb_free
+ *    / ext4_group_info->bb_fragments).
+ *
+ * When "mb_optimize_scan" mount option is set, mballoc consults the above data
+ * structures to decide the order in which groups are to be traversed for
+ * fulfilling an allocation request.
+ *
+ * At CR = 0, we look for groups which have the largest_free_order >= the order
+ * of the request. We directly look at the largest free order list in the data
+ * structure (1) above where largest_free_order = order of the request. If that
+ * list is empty, we look at remaining list in the increasing order of
+ * largest_free_order. This allows us to perform CR = 0 lookup in O(1) time.
+ *
+ * At CR = 1, we only consider groups where average fragment size > request
+ * size. So, we lookup a group which has average fragment size just above or
+ * equal to request size using our rb tree (data structure 2) in O(log N) time.
+ *
+ * If "mb_optimize_scan" mount option is not set, mballoc traverses groups in
+ * linear order which requires O(N) search time for each CR 0 and CR 1 phase.
+ *
  * The regular allocator (using the buddy cache) supports a few tunables.
  *
  * /sys/fs/ext4/<partition>/mb_min_to_scan
  * /sys/fs/ext4/<partition>/mb_max_to_scan
  * /sys/fs/ext4/<partition>/mb_order2_req
+ * /sys/fs/ext4/<partition>/mb_linear_limit
  *
  * The regular allocator uses buddy scan only if the request len is power of
  * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
@@ -149,6 +188,16 @@
  * can be used for allocation. ext4_mb_good_group explains how the groups are
  * checked.
  *
+ * When "mb_optimize_scan" is turned on, as mentioned above, the groups may not
+ * get traversed linearly. That may result in subsequent allocations being not
+ * close to each other. And so, the underlying device may get filled up in a
+ * non-linear fashion. While that may not matter on non-rotational devices, for
+ * rotational devices that may result in higher seek times. "mb_linear_limit"
+ * tells mballoc how many groups mballoc should search linearly before
+ * performing consulting above data structures for more efficient lookups. For
+ * non rotational devices, this value defaults to 0 and for rotational devices
+ * this is set to MB_DEFAULT_LINEAR_LIMIT.
+ *
  * Both the prealloc space are getting populated as above. So for the first
  * request we will hit the buddy cache which will result in this prealloc
  * space getting filled. The prealloc space is then later used for the
@@ -299,6 +348,8 @@
  *  - bitlock on a group	(group)
  *  - object (inode/locality)	(object)
  *  - per-pa lock		(pa)
+ *  - cr0 lists lock		(cr0)
+ *  - cr1 tree lock		(cr1)
  *
  * Paths:
  *  - new pa
@@ -328,6 +379,9 @@
  *    group
  *        object
  *
+ *  - allocation path (ext4_mb_regular_allocator)
+ *    group
+ *    cr0/cr1
  */
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
@@ -351,6 +405,9 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
+static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
+			       ext4_group_t group, int cr);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -744,6 +801,269 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
 	}
 }
 
+static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
+			int (*cmp)(struct rb_node *, struct rb_node *))
+{
+	struct rb_node **iter = &root->rb_node, *parent = NULL;
+
+	while (*iter) {
+		parent = *iter;
+		if (cmp(new, *iter) > 0)
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
+	return (num_frags_2 - num_frags_1);
+}
+
+/*
+ * Reinsert grpinfo into the avg_fragment_size tree with new average
+ * fragment size.
+ */
+static void
+mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+		return;
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
+	write_unlock(&sbi->s_mb_rb_lock);
+}
+
+/*
+ * Choose next group by traversing largest_free_order lists. Updates *new_cr if
+ * cr level needs an update.
+ */
+static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
+			int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *iter, *grp;
+	int i;
+
+	if (ac->ac_status == AC_STATUS_FOUND)
+		return;
+
+	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR0_OPTIMIZED))
+		atomic_inc(&sbi->s_bal_cr0_bad_suggestions);
+
+	grp = NULL;
+	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
+		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
+			continue;
+		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
+		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
+			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
+			continue;
+		}
+		grp = NULL;
+		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
+				    bb_largest_free_order_node) {
+			if (sbi->s_mb_stats)
+				atomic64_inc(&sbi->s_bal_cX_groups_considered[0]);
+			if (likely(ext4_mb_good_group(ac, iter->bb_group, 0))) {
+				grp = iter;
+				break;
+			}
+		}
+		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
+		if (grp)
+			break;
+	}
+
+	if (!grp) {
+		/* Increment cr and search again */
+		*new_cr = 1;
+	} else {
+		*group = grp->bb_group;
+		ac->ac_last_optimal_group = *group;
+		ac->ac_flags |= EXT4_MB_CR0_OPTIMIZED;
+	}
+}
+
+/*
+ * Choose next group by traversing average fragment size tree. Updates *new_cr
+ * if cr lvel needs an update. Sets EXT4_MB_SEARCH_NEXT_LINEAR to indicate that
+ * the linear search should continue for one iteration since there's lock
+ * contention on the rb tree lock.
+ */
+static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
+		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	int avg_fragment_size, best_so_far;
+	struct rb_node *node, *found;
+	struct ext4_group_info *grp;
+
+	/*
+	 * If there is contention on the lock, instead of waiting for the lock
+	 * to become available, just continue searching lineraly. We'll resume
+	 * our rb tree search later starting at ac->ac_last_optimal_group.
+	 */
+	if (!read_trylock(&sbi->s_mb_rb_lock)) {
+		ac->ac_flags |= EXT4_MB_SEARCH_NEXT_LINEAR;
+		return;
+	}
+
+	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
+		if (sbi->s_mb_stats)
+			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
+		/* We have found something at CR 1 in the past */
+		grp = ext4_get_group_info(ac->ac_sb, ac->ac_last_optimal_group);
+		for (found = rb_next(&grp->bb_avg_fragment_size_rb); found != NULL;
+		     found = rb_next(found)) {
+			grp = rb_entry(found, struct ext4_group_info,
+				       bb_avg_fragment_size_rb);
+			if (sbi->s_mb_stats)
+				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
+			if (likely(ext4_mb_good_group(ac, grp->bb_group, 1)))
+				break;
+		}
+		goto done;
+	}
+
+	node = sbi->s_mb_avg_fragment_size_root.rb_node;
+	best_so_far = 0;
+	found = NULL;
+
+	while (node) {
+		grp = rb_entry(node, struct ext4_group_info,
+			       bb_avg_fragment_size_rb);
+		avg_fragment_size = 0;
+		if (ext4_mb_good_group(ac, grp->bb_group, 1)) {
+			avg_fragment_size = grp->bb_fragments ?
+				grp->bb_free / grp->bb_fragments : 0;
+			if (!best_so_far || avg_fragment_size < best_so_far) {
+				best_so_far = avg_fragment_size;
+				found = node;
+			}
+		}
+		if (avg_fragment_size > ac->ac_g_ex.fe_len)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+
+done:
+	if (found) {
+		grp = rb_entry(found, struct ext4_group_info,
+			       bb_avg_fragment_size_rb);
+		*group = grp->bb_group;
+		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
+	} else {
+		*new_cr = 2;
+	}
+
+	read_unlock(&sbi->s_mb_rb_lock);
+	ac->ac_last_optimal_group = *group;
+}
+
+static inline int should_optimize_scan(struct ext4_allocation_context *ac)
+{
+	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
+		return 0;
+	if (ac->ac_criteria >= 2)
+		return 0;
+	if (ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
+		return 0;
+	return 1;
+}
+
+/*
+ * Return next linear group for allocation. If linear traversal should not be
+ * performed, this function just returns the same group
+ */
+static int
+next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
+{
+	if (!should_optimize_scan(ac))
+		goto inc_and_return;
+
+	if (ac->ac_groups_linear_remaining) {
+		ac->ac_groups_linear_remaining--;
+		goto inc_and_return;
+	}
+
+	if (ac->ac_flags & EXT4_MB_SEARCH_NEXT_LINEAR) {
+		ac->ac_flags &= ~EXT4_MB_SEARCH_NEXT_LINEAR;
+		goto inc_and_return;
+	}
+
+	return group;
+inc_and_return:
+	/*
+	 * Artificially restricted ngroups for non-extent
+	 * files makes group > ngroups possible on first loop.
+	 */
+	return group + 1 >= ngroups ? 0 : group + 1;
+}
+
+/*
+ * ext4_mb_choose_next_group: choose next group for allocation.
+ *
+ * @ac        Allocation Context
+ * @new_cr    This is an output parameter. If the there is no good group
+ *            available at current CR level, this field is updated to indicate
+ *            the new cr level that should be used.
+ * @group     This is an input / output parameter. As an input it indicates the
+ *            next group that the allocator intends to use for allocation. As
+ *            output, this field indicates the next group that should be used as
+ *            determined by the optimization functions.
+ * @ngroups   Total number of groups
+ */
+static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
+		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	*new_cr = ac->ac_criteria;
+
+	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining)
+		return;
+
+	if (*new_cr == 0) {
+		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
+	} else if (*new_cr == 1) {
+		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
+	} else {
+		/*
+		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
+		 * bb_free. But until that happens, we should never come here.
+		 */
+		WARN_ON(1);
+	}
+}
+
 /*
  * Cache the order of the largest free extent we have available in this block
  * group.
@@ -751,18 +1071,33 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
 static void
 mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int i;
-	int bits;
 
+	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order >= 0) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[
+					      grp->bb_largest_free_order]);
+		list_del_init(&grp->bb_largest_free_order_node);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[
+					      grp->bb_largest_free_order]);
+	}
 	grp->bb_largest_free_order = -1; /* uninit */
 
-	bits = MB_NUM_ORDERS(sb) - 1;
-	for (i = bits; i >= 0; i--) {
+	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--) {
 		if (grp->bb_counters[i] > 0) {
 			grp->bb_largest_free_order = i;
 			break;
 		}
 	}
+	if (test_opt2(sb, MB_OPTIMIZE_SCAN) &&
+	    grp->bb_largest_free_order >= 0 && grp->bb_free) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[
+					      grp->bb_largest_free_order]);
+		list_add_tail(&grp->bb_largest_free_order_node,
+		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[
+					      grp->bb_largest_free_order]);
+	}
 }
 
 static noinline_for_stack
@@ -818,6 +1153,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	period = get_cycles() - period;
 	atomic_inc(&sbi->s_mb_buddies_generated);
 	atomic64_add(period, &sbi->s_mb_generation_time);
+	mb_update_avg_fragment_size(sb, grp);
 }
 
 /* The buddy information is attached the buddy cache inode
@@ -1517,6 +1853,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
 done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
+	mb_update_avg_fragment_size(sb, e4b->bd_info);
 	mb_check_buddy(e4b);
 }
 
@@ -1653,6 +1990,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	}
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
+	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
 	mb_check_buddy(e4b);
 
@@ -2347,17 +2685,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		ac->ac_last_optimal_group = group;
+		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
 		prefetch_grp = group;
 
-		for (i = 0; i < ngroups; group++, i++) {
-			int ret = 0;
+		for (i = 0; i < ngroups; group = next_linear_group(ac, group, ngroups),
+			     i++) {
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
+			if (new_cr != cr) {
+				cr = new_cr;
+				goto repeat;
+			}
 
 			/*
 			 * Batch reads of the block allocation bitmaps
@@ -2578,6 +2920,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[0]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[0]));
+	seq_printf(seq, "\t\tbad_suggestions: %u\n",
+		   atomic_read(&sbi->s_bal_cr0_bad_suggestions));
 
 	seq_puts(seq, "\tcr1_stats:\n");
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[1]));
@@ -2585,6 +2929,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic64_read(&sbi->s_bal_cX_groups_considered[1]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[1]));
+	seq_printf(seq, "\t\tbad_suggestions: %u\n",
+		   atomic_read(&sbi->s_bal_cr1_bad_suggestions));
 
 	seq_puts(seq, "\tcr2_stats:\n");
 	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[2]));
@@ -2719,7 +3065,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
+	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
+	RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
+	meta_group_info[i]->bb_group = group;
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
@@ -2909,6 +3258,26 @@ int ext4_mb_init(struct super_block *sb)
 		i++;
 	} while (i < MB_NUM_ORDERS(sb));
 
+	sbi->s_mb_avg_fragment_size_root = RB_ROOT;
+	sbi->s_mb_largest_free_orders =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+			GFP_KERNEL);
+	if (!sbi->s_mb_largest_free_orders) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sbi->s_mb_largest_free_orders_locks =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
+			GFP_KERNEL);
+	if (!sbi->s_mb_largest_free_orders_locks) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
+		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
+		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
+	}
+	rwlock_init(&sbi->s_mb_rb_lock);
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
@@ -2961,6 +3330,10 @@ int ext4_mb_init(struct super_block *sb)
 		spin_lock_init(&lg->lg_prealloc_lock);
 	}
 
+	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
+		sbi->s_mb_max_linear_groups = 0;
+	else
+		sbi->s_mb_max_linear_groups = MB_DEFAULT_LINEAR_LIMIT;
 	/* init file for buddy data */
 	ret = ext4_mb_init_backend(sb);
 	if (ret != 0)
@@ -2972,6 +3345,8 @@ int ext4_mb_init(struct super_block *sb)
 	free_percpu(sbi->s_locality_groups);
 	sbi->s_locality_groups = NULL;
 out:
+	kfree(sbi->s_mb_largest_free_orders);
+	kfree(sbi->s_mb_largest_free_orders_locks);
 	kfree(sbi->s_mb_offsets);
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
@@ -3028,6 +3403,8 @@ int ext4_mb_release(struct super_block *sb)
 		kvfree(group_info);
 		rcu_read_unlock();
 	}
+	kfree(sbi->s_mb_largest_free_orders);
+	kfree(sbi->s_mb_largest_free_orders_locks);
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
 	iput(sbi->s_buddy_cache);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 68111a10cfee..02585e3cbcad 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -78,6 +78,18 @@
  */
 #define MB_DEFAULT_MAX_INODE_PREALLOC	512
 
+/*
+ * Number of groups to search linearly before performing group scanning
+ * optimization.
+ */
+#define MB_DEFAULT_LINEAR_LIMIT		4
+
+/*
+ * Minimum number of groups that should be present in the file system to perform
+ * group scanning optimizations.
+ */
+#define MB_DEFAULT_LINEAR_SCAN_THRESHOLD	16
+
 /*
  * Number of valid buddy orders
  */
@@ -166,11 +178,14 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	ext4_group_t ac_last_optimal_group;
+	__u32 ac_groups_considered;
+	__u32 ac_flags;		/* allocation hints */
 	__u16 ac_groups_scanned;
+	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
 	__u16 ac_tail;
 	__u16 ac_buddy;
-	__u16 ac_flags;		/* allocation hints */
 	__u8 ac_status;
 	__u8 ac_criteria;
 	__u8 ac_2order;		/* if request is to allocate 2^N blocks and
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3a2cd9fb7e73..6116640081c0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1687,7 +1687,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1788,6 +1788,7 @@ static const match_table_t tokens = {
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
+	{Opt_mb_optimize_scan, "mb_optimize_scan=%d"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
@@ -1820,6 +1821,8 @@ static ext4_fsblk_t get_sb_block(void **data)
 }
 
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
+#define DEFAULT_MB_OPTIMIZE_SCAN	(-1)
+
 static const char deprecated_msg[] =
 	"Mount option \"%s\" will be removed by %s\n"
 	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
@@ -2008,6 +2011,7 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -2092,6 +2096,7 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 struct ext4_parsed_options {
 	unsigned long journal_devnum;
 	unsigned int journal_ioprio;
+	int mb_optimize_scan;
 };
 
 static int handle_mount_opt(struct super_block *sb, char *opt, int token,
@@ -2388,6 +2393,13 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		sbi->s_mount_opt |= m->mount_opt;
 	} else if (token == Opt_data_err_ignore) {
 		sbi->s_mount_opt &= ~m->mount_opt;
+	} else if (token == Opt_mb_optimize_scan) {
+		if (arg != 0 && arg != 1) {
+			ext4_msg(sb, KERN_WARNING,
+				 "mb_optimize_scan should be set to 0 or 1.");
+			return -1;
+		}
+		parsed_opts->mb_optimize_scan = arg;
 	} else {
 		if (!args->from)
 			arg = 1;
@@ -4034,6 +4046,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	/* Set defaults for the variables that will be set during parsing */
 	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	parsed_opts.journal_devnum = 0;
+	parsed_opts.mb_optimize_scan = DEFAULT_MB_OPTIMIZE_SCAN;
 
 	if ((data && !orig_data) || !sbi)
 		goto out_free_base;
@@ -4984,6 +4997,19 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_fc_replay_cleanup(sb);
 
 	ext4_ext_init(sb);
+
+	/*
+	 * Enable optimize_scan if number of groups is > threshold. This can be
+	 * turned off by passing "mb_optimize_scan=0". This can also be
+	 * turned on forcefully by passing "mb_optimize_scan=1".
+	 */
+	if (parsed_opts.mb_optimize_scan == 1)
+		set_opt2(sb, MB_OPTIMIZE_SCAN);
+	else if (parsed_opts.mb_optimize_scan == 0)
+		clear_opt2(sb, MB_OPTIMIZE_SCAN);
+	else if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
+		set_opt2(sb, MB_OPTIMIZE_SCAN);
+
 	err = ext4_mb_init(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 59ca9d73b42f..67e2f70cb84f 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -213,6 +213,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
+EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
@@ -260,6 +261,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
 	ATTR_LIST(mb_max_inode_prealloc),
+	ATTR_LIST(mb_max_linear_groups),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
 	ATTR_LIST(trigger_fs_error),
-- 
2.31.0.291.g576ba9dcdaf-goog

