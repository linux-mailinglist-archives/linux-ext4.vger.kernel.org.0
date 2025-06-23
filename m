Return-Path: <linux-ext4+bounces-8600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77933AE3775
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267913AB0EC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2E22D4E9;
	Mon, 23 Jun 2025 07:47:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2056225413;
	Mon, 23 Jun 2025 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664832; cv=none; b=DOch3hNCbDqKJTfPi7WOogUOseO9Ul9C7/8hDU7e1/D3+qP+Y4LToGplFQfxGWSpAb0gs2zr4XIlEqJkiqRAHALz/VmHW/KRWVEsE4x3rv+y/JKXmXZSKp5fztdAM0ggNwDsHcz+cUWwNpVq+A3UBesc5g1taVHsT5jqWubAPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664832; c=relaxed/simple;
	bh=hBWHrwGIgzWMQsJ34MCwJRKM5kV7QYewRLPHghxKG/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2sCsSqFVYrPrIOZzNO3J3Qr7O4JEp665yPBnL25+3GcsuuOuPSTPdgvm1+E0Fw9zBkAYtC1+jrlfvA2Xt3I8Q6lhIjnb4sgZgHbPOohnAFZVx8ldGR95YND1GLiCGnnkDbpe3xU4MWsDy+SL7m7qHN/oL+rMqkbS3HgtqNEz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bQg9S1R6cz29dkj;
	Mon, 23 Jun 2025 15:45:32 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EABF14027A;
	Mon, 23 Jun 2025 15:47:07 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:47:06 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 15/16] ext4: refactor choose group to scan group
Date: Mon, 23 Jun 2025 15:33:03 +0800
Message-ID: <20250623073304.3275702-16-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250623073304.3275702-1-libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

This commit converts the `choose group` logic to `scan group` using
previously prepared helper functions. This allows us to leverage xarrays
for ordered non-linear traversal, thereby mitigating the "bouncing" issue
inherent in the `choose group` mechanism.

This also decouples linear and non-linear traversals, leading to cleaner
and more readable code.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 310 ++++++++++++++++++++++++----------------------
 fs/ext4/mballoc.h |   1 -
 2 files changed, 159 insertions(+), 152 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 45c7717fcbbd..d8372a649a0c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -432,6 +432,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks);
 
+static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
+			      ext4_group_t group);
+static void ext4_mb_might_prefetch(struct ext4_allocation_context *ac,
+				   ext4_group_t group);
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -873,9 +877,8 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 		     grp->bb_group, new, ret);
 }
 
-static struct ext4_group_info *
-ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
-			       struct xarray *xa, ext4_group_t start)
+static int ext4_mb_scan_groups_xarray(struct ext4_allocation_context *ac,
+				      struct xarray *xa, ext4_group_t start)
 {
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -886,17 +889,19 @@ ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp;
 
 	if (WARN_ON_ONCE(start >= ngroups))
-		return NULL;
+		return 0;
 	end = ngroups - 1;
 
 wrap_around:
 	xa_for_each_range(xa, group, grp, start, end) {
+		int err;
+
 		if (sbi->s_mb_stats)
 			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
 
-		if (!spin_is_locked(ext4_group_lock_ptr(sb, group)) &&
-		    likely(ext4_mb_good_group(ac, group, cr)))
-			return grp;
+		err = ext4_mb_scan_group(ac, grp->bb_group);
+		if (err || ac->ac_status != AC_STATUS_CONTINUE)
+			return err;
 
 		cond_resched();
 	}
@@ -907,95 +912,86 @@ ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
 		goto wrap_around;
 	}
 
-	return NULL;
+	return 0;
 }
 
 /*
  * Find a suitable group of given order from the largest free orders xarray.
  */
-static struct ext4_group_info *
-ext4_mb_find_good_group_largest_free_order(struct ext4_allocation_context *ac,
-					   int order, ext4_group_t start)
+static int
+ext4_mb_scan_groups_largest_free_order(struct ext4_allocation_context *ac,
+				       int order, ext4_group_t start)
 {
 	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_largest_free_orders[order];
 
 	if (xa_empty(xa))
-		return NULL;
+		return 0;
 
-	return ext4_mb_find_good_group_xarray(ac, xa, start);
+	return ext4_mb_scan_groups_xarray(ac, xa, start);
 }
 
 /*
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
  */
-static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
-			enum criteria *new_cr, ext4_group_t *group)
+static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
+					  ext4_group_t group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp;
 	int i;
+	int ret = 0;
 
-	if (ac->ac_status == AC_STATUS_FOUND)
-		return;
-
-	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
-		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
-
+	ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		grp = ext4_mb_find_good_group_largest_free_order(ac, i, *group);
-		if (grp) {
-			*group = grp->bb_group;
-			ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
-			return;
-		}
+		ret = ext4_mb_scan_groups_largest_free_order(ac, i, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			goto out;
 	}
 
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
+
 	/* Increment cr and search again if no group is found */
-	*new_cr = CR_GOAL_LEN_FAST;
+	ac->ac_criteria = CR_GOAL_LEN_FAST;
+out:
+	ac->ac_flags &= ~EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
+	return ret;
 }
 
 /*
  * Find a suitable group of given order from the average fragments xarray.
  */
-static struct ext4_group_info *
-ext4_mb_find_good_group_avg_frag_xarray(struct ext4_allocation_context *ac,
-					int order, ext4_group_t start)
+static int ext4_mb_scan_groups_avg_frag_order(struct ext4_allocation_context *ac,
+					      int order, ext4_group_t start)
 {
 	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_avg_fragment_size[order];
 
 	if (xa_empty(xa))
-		return NULL;
+		return 0;
 
-	return ext4_mb_find_good_group_xarray(ac, xa, start);
+	return ext4_mb_scan_groups_xarray(ac, xa, start);
 }
 
 /*
  * Choose next group by traversing average fragment size list of suitable
  * order. Updates *new_cr if cr level needs an update.
  */
-static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group)
+static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
+					 ext4_group_t group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp = NULL;
-	int i;
-
-	if (unlikely(ac->ac_flags & EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED)) {
-		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_goal_fast_bad_suggestions);
-	}
+	int i, ret = 0;
 
-	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
-	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		grp = ext4_mb_find_good_group_avg_frag_xarray(ac, i, *group);
-		if (grp) {
-			*group = grp->bb_group;
-			ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
-			return;
-		}
+	ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
+	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
+	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
+		ret = ext4_mb_scan_groups_avg_frag_order(ac, i, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			goto out;
 	}
 
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
 	/*
 	 * CR_BEST_AVAIL_LEN works based on the concept that we have
 	 * a larger normalized goal len request which can be trimmed to
@@ -1005,9 +1001,12 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 	 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
 	 */
 	if (ac->ac_flags & EXT4_MB_HINT_DATA)
-		*new_cr = CR_BEST_AVAIL_LEN;
+		ac->ac_criteria = CR_BEST_AVAIL_LEN;
 	else
-		*new_cr = CR_GOAL_LEN_SLOW;
+		ac->ac_criteria = CR_GOAL_LEN_SLOW;
+out:
+	ac->ac_flags &= ~EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
+	return ret;
 }
 
 /*
@@ -1019,19 +1018,14 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
  * preallocations. However, we make sure that we don't trim the request too
  * much and fall to CR_GOAL_LEN_SLOW in that case.
  */
-static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group)
+static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
+					  ext4_group_t group)
 {
+	int ret = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp = NULL;
 	int i, order, min_order;
 	unsigned long num_stripe_clusters = 0;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED)) {
-		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_best_avail_bad_suggestions);
-	}
-
 	/*
 	 * mb_avg_fragment_size_order() returns order in a way that makes
 	 * retrieving back the length using (1 << order) inaccurate. Hence, use
@@ -1062,6 +1056,7 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 	if (1 << min_order < ac->ac_o_ex.fe_len)
 		min_order = fls(ac->ac_o_ex.fe_len);
 
+	ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
 		/*
@@ -1084,18 +1079,19 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 		frag_order = mb_avg_fragment_size_order(ac->ac_sb,
 							ac->ac_g_ex.fe_len);
 
-		grp = ext4_mb_find_good_group_avg_frag_xarray(ac, frag_order,
-							      *group);
-		if (grp) {
-			*group = grp->bb_group;
-			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
-			return;
-		}
+		ret = ext4_mb_scan_groups_avg_frag_order(ac, frag_order, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			goto out;
 	}
 
 	/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
 	ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
-	*new_cr = CR_GOAL_LEN_SLOW;
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
+	ac->ac_criteria = CR_GOAL_LEN_SLOW;
+out:
+	ac->ac_flags &= ~EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
+	return ret;
 }
 
 static inline int should_optimize_scan(struct ext4_allocation_context *ac)
@@ -1110,59 +1106,87 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 }
 
 /*
- * Return next linear group for allocation.
+ * next linear group for allocation.
  */
-static ext4_group_t
-next_linear_group(ext4_group_t group, ext4_group_t ngroups)
+static void next_linear_group(ext4_group_t *group, ext4_group_t ngroups)
 {
 	/*
 	 * Artificially restricted ngroups for non-extent
 	 * files makes group > ngroups possible on first loop.
 	 */
-	return group + 1 >= ngroups ? 0 : group + 1;
+	*group =  *group + 1 >= ngroups ? 0 : *group + 1;
+}
+
+static int ext4_mb_scan_groups_linear(struct ext4_allocation_context *ac,
+		ext4_group_t ngroups, ext4_group_t *start, ext4_group_t count)
+{
+	int ret, i;
+	enum criteria cr = ac->ac_criteria;
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group = *start;
+
+	for (i = 0; i < count; i++, next_linear_group(&group, ngroups)) {
+		ret = ext4_mb_scan_group(ac, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			return ret;
+		cond_resched();
+	}
+
+	*start = group;
+	if (count == ngroups)
+		ac->ac_criteria++;
+
+	/* Processed all groups and haven't found blocks */
+	if (sbi->s_mb_stats && i == ngroups)
+		atomic64_inc(&sbi->s_bal_cX_failed[cr]);
+
+	return 0;
 }
 
 /*
- * ext4_mb_choose_next_group: choose next group for allocation.
+ * ext4_mb_scan_groups: .
  *
  * @ac        Allocation Context
- * @new_cr    This is an output parameter. If the there is no good group
- *            available at current CR level, this field is updated to indicate
- *            the new cr level that should be used.
- * @group     This is an input / output parameter. As an input it indicates the
- *            next group that the allocator intends to use for allocation. As
- *            output, this field indicates the next group that should be used as
- *            determined by the optimization functions.
- * @ngroups   Total number of groups
  */
-static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
 {
-	*new_cr = ac->ac_criteria;
+	int ret = 0;
+	ext4_group_t start;
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
 
-	if (!should_optimize_scan(ac)) {
-		*group = next_linear_group(*group, ngroups);
-		return;
-	}
+	/* non-extent files are limited to low blocks/groups */
+	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
+		ngroups = sbi->s_blockfile_groups;
+
+	/* searching for the right group start from the goal value specified */
+	start = ac->ac_g_ex.fe_group;
+	ac->ac_prefetch_grp = start;
+	ac->ac_prefetch_nr = 0;
+
+	if (!should_optimize_scan(ac))
+		return ext4_mb_scan_groups_linear(ac, ngroups, &start, ngroups);
 
 	/*
 	 * Optimized scanning can return non adjacent groups which can cause
 	 * seek overhead for rotational disks. So try few linear groups before
 	 * trying optimized scan.
 	 */
-	if (ac->ac_groups_linear_remaining) {
-		*group = next_linear_group(*group, ngroups);
-		ac->ac_groups_linear_remaining--;
-		return;
-	}
+	if (sbi->s_mb_max_linear_groups)
+		ret = ext4_mb_scan_groups_linear(ac, ngroups, &start,
+						 sbi->s_mb_max_linear_groups);
+	if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+		return ret;
 
-	if (*new_cr == CR_POWER2_ALIGNED) {
-		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
-	} else if (*new_cr == CR_GOAL_LEN_FAST) {
-		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
-	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
-		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
-	} else {
+	switch (ac->ac_criteria) {
+	case CR_POWER2_ALIGNED:
+		return ext4_mb_scan_groups_p2_aligned(ac, start);
+	case CR_GOAL_LEN_FAST:
+		return ext4_mb_scan_groups_goal_fast(ac, start);
+	case CR_BEST_AVAIL_LEN:
+		return ext4_mb_scan_groups_best_avail(ac, start);
+	default:
 		/*
 		 * TODO: For CR_GOAL_LEN_SLOW, we can arrange groups in an
 		 * rb tree sorted by bb_free. But until that happens, we should
@@ -1170,6 +1194,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		 */
 		WARN_ON(1);
 	}
+
+	return 0;
 }
 
 /*
@@ -2875,6 +2901,18 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 	}
 }
 
+static inline void ac_inc_bad_suggestions(struct ext4_allocation_context *ac)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+
+	if (ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED)
+		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
+	else if (ac->ac_flags & EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED)
+		atomic_inc(&sbi->s_bal_goal_fast_bad_suggestions);
+	else if (ac->ac_flags & EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED)
+		atomic_inc(&sbi->s_bal_best_avail_bad_suggestions);
+}
+
 static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 			      ext4_group_t group)
 {
@@ -2893,7 +2931,8 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 	if (ret <= 0) {
 		if (!ac->ac_first_err)
 			ac->ac_first_err = ret;
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	ret = ext4_mb_load_buddy(sb, group, ac->ac_e4b);
@@ -2916,26 +2955,20 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 	ext4_unlock_group(sb, group);
 out_unload:
 	ext4_mb_unload_buddy(ac->ac_e4b);
+out:
+	if (EXT4_SB(sb)->s_mb_stats && ac->ac_status == AC_STATUS_CONTINUE)
+		ac_inc_bad_suggestions(ac);
 	return ret;
 }
 
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
-	ext4_group_t ngroups, group, i;
-	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
+	ext4_group_t i;
 	int err = 0;
-	struct ext4_sb_info *sbi;
-	struct super_block *sb;
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_buddy e4b;
-	int lost;
-
-	sb = ac->ac_sb;
-	sbi = EXT4_SB(sb);
-	ngroups = ext4_get_groups_count(sb);
-	/* non-extent files are limited to low blocks/groups */
-	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
-		ngroups = sbi->s_blockfile_groups;
 
 	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
 
@@ -2980,48 +3013,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 * start with CR_GOAL_LEN_FAST, unless it is power of 2
 	 * aligned, in which case let's do that faster approach first.
 	 */
+	ac->ac_criteria = CR_GOAL_LEN_FAST;
 	if (ac->ac_2order)
-		cr = CR_POWER2_ALIGNED;
+		ac->ac_criteria = CR_POWER2_ALIGNED;
 
 	ac->ac_e4b = &e4b;
 	ac->ac_prefetch_ios = 0;
 	ac->ac_first_err = 0;
 repeat:
-	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
-		ac->ac_criteria = cr;
-		/*
-		 * searching for the right group start
-		 * from the goal value specified
-		 */
-		group = ac->ac_g_ex.fe_group;
-		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
-		ac->ac_prefetch_grp = group;
-		ac->ac_prefetch_nr = 0;
-
-		for (i = 0, new_cr = cr; i < ngroups; i++,
-		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
-
-			cond_resched();
-			if (new_cr != cr) {
-				cr = new_cr;
-				goto repeat;
-			}
-
-			err = ext4_mb_scan_group(ac, group);
-			if (err)
-				goto out;
-
-			if (ac->ac_status != AC_STATUS_CONTINUE)
-				break;
-		}
-		/* Processed all groups and haven't found blocks */
-		if (sbi->s_mb_stats && i == ngroups)
-			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
+	while (ac->ac_criteria < EXT4_MB_NUM_CRS) {
+		err = ext4_mb_scan_groups(ac);
+		if (err)
+			goto out;
 
-		if (i == ngroups && ac->ac_criteria == CR_BEST_AVAIL_LEN)
-			/* Reset goal length to original goal length before
-			 * falling into CR_GOAL_LEN_SLOW */
-			ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
+		if (ac->ac_status != AC_STATUS_CONTINUE)
+			break;
 	}
 
 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
@@ -3032,6 +3038,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 */
 		ext4_mb_try_best_found(ac, &e4b);
 		if (ac->ac_status != AC_STATUS_FOUND) {
+			int lost;
+
 			/*
 			 * Someone more lucky has already allocated it.
 			 * The only thing we can do is just take first
@@ -3047,7 +3055,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = CR_ANY_FREE;
+			ac->ac_criteria = CR_ANY_FREE;
 			goto repeat;
 		}
 	}
@@ -3060,7 +3068,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
-		 ac->ac_flags, cr, err);
+		 ac->ac_flags, ac->ac_criteria, err);
 
 	if (ac->ac_prefetch_nr)
 		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 721aaea1f83e..65713b847385 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -208,7 +208,6 @@ struct ext4_allocation_context {
 	int ac_first_err;
 
 	__u32 ac_flags;		/* allocation hints */
-	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
 	__u16 ac_found;
 	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
-- 
2.46.1


