Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0765D326785
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZTh2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBZThK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A8C061788
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u12so6464701pjr.2
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoQ4291LUPGHLddIcyjSf6Ltz5mHnmJzKhShJsXqt/w=;
        b=U/sB53m2KMEzW2pO1ECObTcqxhmn7ywXokfPPZ3pJpmnt3kQ32kF+ADR/40EWggX7+
         LaqtG2v+NM67S3yX5GvPplVb/InVN8Yf2OKymd/309Vt3PRFZyFHxCPtNnO2fra4W26e
         mFm7S7zqz9xHFiEOeytq/5GtUD2MiqkfClCEw7vDVO/0cvHazsDCNAbP1psm7I8GnIGG
         biVA3pVI2SDAAU5lzVtpRAZmnRFyeOiHDazB28KPY3aQXEBcLyrMT7TLPnXmUaPDHAD3
         xD0CTpftZJqHagmxqI2Dq0k/Bvf1tJd2l5erOm04zmSk+o4t8XATyvAvT94QguggqOhZ
         5G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoQ4291LUPGHLddIcyjSf6Ltz5mHnmJzKhShJsXqt/w=;
        b=WB7ti3YxHHuQR6EHCo/cECu3fKzG5B6oaqeZtrD+VodhgSMR2kPvgyhGtpYhChUqNh
         JDwUG90lff00qNP0WhTUJdb4qVILNFnR+Dm7v8Zt4bTFKbAROjSm/GXKoPtJ8EM15OBN
         pE81tb4VmyK0FLoAxjctUn4nJmNfsovl5yb+a7FqRUnBX/1HwPVEX6/lTM16toSsb5hV
         L4mVWB6lluR2ssTqCis6yLEQcbLk3acfg0569l9474PNOF4mMitF5GfojA4d3utGH0cn
         dOtHCxVdoioOATqwdvYgF7/kx2+ksaaU4pWG98oVxGYiWXCqaN3aKVJxRkKBESvapjbO
         soFw==
X-Gm-Message-State: AOAM533jeQ8bc3IMkSl+Sq/BflgAfTsbQC9+bbYjL/tV3EyKS+/jasul
        c239juq08T+0D780rrxzKLELuVPLd9Y=
X-Google-Smtp-Source: ABdhPJzesO7k7rXGawpqSuxOmLT3qj2N0Pt81m6s4IrJWTXY0jc5dcpEr8GgeyAN52LZU6LJ1C44pw==
X-Received: by 2002:a17:902:8f8c:b029:e3:7e6c:36fa with SMTP id z12-20020a1709028f8cb02900e37e6c36famr4641956plo.77.1614368188747;
        Fri, 26 Feb 2021 11:36:28 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:27 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Fri, 26 Feb 2021 11:36:11 -0800
Message-Id: <20210226193612.1199321-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
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

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/ext4.h    |  14 +-
 fs/ext4/mballoc.c | 374 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |  14 ++
 fs/ext4/super.c   |   6 +-
 fs/ext4/sysfs.c   |   2 +
 5 files changed, 397 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3e906a3d553a..d792418c39ca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -162,6 +162,8 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
+/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
+#define EXT4_MB_CR1_OPTIMIZED		0x8000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
@@ -1247,7 +1249,9 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
 #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
 #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
-
+#define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
+						    * scanning in mballoc
+						    */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
@@ -1527,9 +1531,14 @@ struct ext4_sb_info {
 	unsigned int s_mb_free_pending;
 	struct list_head s_freed_data_list;	/* List of blocks to be freed
 						   after commit completed */
+	struct rb_root s_mb_avg_fragment_size_root;
+	rwlock_t s_mb_rb_lock;
+	struct list_head *s_mb_largest_free_orders;
+	rwlock_t *s_mb_largest_free_orders_locks;
 
 	/* tunables */
 	unsigned long s_stripe;
+	unsigned int s_mb_linear_limit;
 	unsigned int s_mb_stream_request;
 	unsigned int s_mb_max_to_scan;
 	unsigned int s_mb_min_to_scan;
@@ -3308,11 +3317,14 @@ struct ext4_group_info {
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
index 161412070fef..bcfd849bc61e 100644
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
@@ -744,6 +801,243 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
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
+ * Choose next group by traversing largest_free_order lists. Return 0 if next
+ * group was selected optimally. Return 1 if next group was not selected
+ * optimally. Updates *new_cr if cr level needs an update.
+ */
+static int ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
+		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_group_info *iter, *grp;
+	int i;
+
+	if (ac->ac_status == AC_STATUS_FOUND)
+		return 1;
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
+			ac->ac_groups_considered++;
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
+	}
+	return 0;
+}
+
+/*
+ * Choose next group by traversing average fragment size tree. Return 0 if next
+ * group was selected optimally. Return 1 if next group could not selected
+ * optimally (due to lock contention). Updates *new_cr if cr lvel needs an
+ * update.
+ */
+static int ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
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
+	if (!read_trylock(&sbi->s_mb_rb_lock))
+		return 1;
+
+	if (ac->ac_flags & EXT4_MB_CR1_OPTIMIZED) {
+		/* We have found something at CR 1 in the past */
+		grp = ext4_get_group_info(ac->ac_sb, ac->ac_last_optimal_group);
+		for (found = rb_next(&grp->bb_avg_fragment_size_rb); found != NULL;
+		     found = rb_next(found)) {
+			grp = rb_entry(found, struct ext4_group_info,
+				       bb_avg_fragment_size_rb);
+			ac->ac_groups_considered++;
+			if (likely(ext4_mb_good_group(ac, grp->bb_group, 1)))
+				break;
+		}
+
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
+		/*
+		 * Perform this check without locking, we'll lock later to confirm.
+		 */
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
+	return 0;
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
+	int ret;
+
+	*new_cr = ac->ac_criteria;
+
+	if (!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN) ||
+	    *new_cr >= 2 ||
+	    !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
+		goto inc_and_return;
+
+	if (ac->ac_groups_linear_remaining) {
+		ac->ac_groups_linear_remaining--;
+		goto inc_and_return;
+	}
+
+	if (*new_cr == 0) {
+		ret = ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
+		if (ret)
+			goto inc_and_return;
+	}
+	if (*new_cr == 1) {
+		ret = ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
+		if (ret)
+			goto inc_and_return;
+	}
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
@@ -751,18 +1045,33 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
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
@@ -818,6 +1127,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	period = get_cycles() - period;
 	atomic_inc(&sbi->s_mb_buddies_generated);
 	atomic64_add(period, &sbi->s_mb_generation_time);
+	mb_update_avg_fragment_size(sb, grp);
 }
 
 /* The buddy information is attached the buddy cache inode
@@ -1517,6 +1827,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
 done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
+	mb_update_avg_fragment_size(sb, e4b->bd_info);
 	mb_check_buddy(e4b);
 }
 
@@ -1653,6 +1964,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	}
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
+	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
 	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
 	mb_check_buddy(e4b);
 
@@ -2346,17 +2658,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		ac->ac_last_optimal_group = group;
+		ac->ac_groups_linear_remaining = sbi->s_mb_linear_limit;
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
@@ -2696,7 +3012,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
+	INIT_LIST_HEAD(&meta_group_info[i]->bb_largest_free_order_node);
+	RB_CLEAR_NODE(&meta_group_info[i]->bb_avg_fragment_size_rb);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
+	meta_group_info[i]->bb_group = group;
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
@@ -2886,6 +3205,22 @@ int ext4_mb_init(struct super_block *sb)
 		i++;
 	} while (i < MB_NUM_ORDERS(sb));
 
+	sbi->s_mb_avg_fragment_size_root = RB_ROOT;
+	sbi->s_mb_largest_free_orders =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
+			GFP_KERNEL);
+	if (!sbi->s_mb_largest_free_orders)
+		goto out;
+	sbi->s_mb_largest_free_orders_locks =
+		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
+			GFP_KERNEL);
+	if (!sbi->s_mb_largest_free_orders_locks)
+		goto out;
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
+		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
+		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
+	}
+	rwlock_init(&sbi->s_mb_rb_lock);
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
@@ -2938,6 +3273,20 @@ int ext4_mb_init(struct super_block *sb)
 		spin_lock_init(&lg->lg_prealloc_lock);
 	}
 
+	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
+		sbi->s_mb_linear_limit = 0;
+	else
+		sbi->s_mb_linear_limit = MB_DEFAULT_LINEAR_LIMIT;
+#ifndef CONFIG_EXT4_DEBUG
+	/*
+	 * Disable mb_optimize scan if we don't have enough groups. If
+	 * CONFIG_EXT4_DEBUG is set, we don't disable this MB_OPTIMIZE_SCAN even
+	 * for small file systems. This allows us to test correctness on small
+	 * file systems.
+	 */
+	if (ext4_get_groups_count(sb) < MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
+		clear_opt2(sb, MB_OPTIMIZE_SCAN);
+#endif
 	/* init file for buddy data */
 	ret = ext4_mb_init_backend(sb);
 	if (ret != 0)
@@ -2949,6 +3298,8 @@ int ext4_mb_init(struct super_block *sb)
 	free_percpu(sbi->s_locality_groups);
 	sbi->s_locality_groups = NULL;
 out:
+	kfree(sbi->s_mb_largest_free_orders);
+	kfree(sbi->s_mb_largest_free_orders_locks);
 	kfree(sbi->s_mb_offsets);
 	sbi->s_mb_offsets = NULL;
 	kfree(sbi->s_mb_maxs);
@@ -3005,6 +3356,7 @@ int ext4_mb_release(struct super_block *sb)
 		kvfree(group_info);
 		rcu_read_unlock();
 	}
+	kfree(sbi->s_mb_largest_free_orders);
 	kfree(sbi->s_mb_offsets);
 	kfree(sbi->s_mb_maxs);
 	iput(sbi->s_buddy_cache);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 02861406932f..5c0275f832a0 100644
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
@@ -166,8 +178,10 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	ext4_group_t ac_last_optimal_group;
 	__u32 ac_groups_considered;
 	__u16 ac_groups_scanned;
+	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
 	__u16 ac_tail;
 	__u16 ac_buddy;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 071d131fadd8..aa92d3ebe13d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -154,6 +154,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, int op_flags,
 	clear_buffer_verified(bh);
 
 	bh->b_end_io = end_io ? end_io : end_buffer_read_sync;
+
 	get_bh(bh);
 	submit_bh(REQ_OP_READ, op_flags, bh);
 }
@@ -1687,7 +1688,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1788,6 +1789,7 @@ static const match_table_t tokens = {
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
+	{Opt_mb_optimize_scan, "mb_optimize_scan"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
@@ -2008,6 +2010,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 59ca9d73b42f..16b8a838f631 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -213,6 +213,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
+EXT4_RW_ATTR_SBI_UI(mb_linear_limit, s_mb_linear_limit);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
@@ -260,6 +261,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
 	ATTR_LIST(mb_max_inode_prealloc),
+	ATTR_LIST(mb_linear_limit),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
 	ATTR_LIST(trigger_fs_error),
-- 
2.30.1.766.gb4fecdf3b7-goog

