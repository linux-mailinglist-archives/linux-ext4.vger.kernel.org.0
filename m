Return-Path: <linux-ext4+bounces-8995-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91373B03FB8
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0A51A636F8
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEA24E4C6;
	Mon, 14 Jul 2025 13:18:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A925C838;
	Mon, 14 Jul 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499130; cv=none; b=R5+MDsoWV/rpMSnfKYKaz74vBHfSsLFNg+iMkIv4R9RfII3uD0seLNADMbVI8wMWUqpfiyF8PGZoqVq39TeENQgf4jlE0nGwcqTbt8XGHf9YHxK4XnqsIeBBOPDFD1AMWwMgTzrEsK3htQ2Bw8pquMJjHEBAC4LfJ14yImnrNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499130; c=relaxed/simple;
	bh=TBdP69I3tQAgATC2WnfYyL1KXYt6iZ5jfHMuPG3EBvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apPWEs4JdPlyTxKwuclCcD+1DX7efjMoG/CSkVR1hYCdpW/ckEBp9mGBxzUwjd+KLROOOpgt5or6xRs06tzKZJGCtUrtNnWxlPVC1obvhoAWmdQ8FCPOWa9WCQgYn4FiHdItnFNnOxvlQiCcppIoL/I7aPl4laIzkS4mDbv16JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgjT45HY5zXdyr;
	Mon, 14 Jul 2025 21:14:16 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id D1991180450;
	Mon, 14 Jul 2025 21:18:44 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:43 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 16/17] ext4: refactor choose group to scan group
Date: Mon, 14 Jul 2025 21:03:26 +0800
Message-ID: <20250714130327.1830534-17-libaokun1@huawei.com>
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

This commit converts the `choose group` logic to `scan group` using
previously prepared helper functions. This allows us to leverage xarrays
for ordered non-linear traversal, thereby mitigating the "bouncing" issue
inherent in the `choose group` mechanism.

This also decouples linear and non-linear traversals, leading to cleaner
and more readable code.

Key changes:

 * ext4_mb_choose_next_group() is refactored to ext4_mb_scan_groups().

 * Replaced ext4_mb_good_group() with ext4_mb_scan_group() in non-linear
   traversals, and related functions now return error codes instead of
   group info.

 * Added ext4_mb_scan_groups_linear() for performing linear scans starting
   from a specific group for a set number of times.

 * Linear scans now execute up to sbi->s_mb_max_linear_groups times,
   so ac_groups_linear_remaining is removed as it's no longer used.

 * ac->ac_criteria is now used directly instead of passing cr around.
   Also, ac->ac_criteria is incremented directly after groups scan fails
   for the corresponding criteria.

 * Since we're now directly scanning groups instead of finding a good group
   then scanning, the following variables and flags are no longer needed,
   s_bal_cX_groups_considered is sufficient.

    s_bal_p2_aligned_bad_suggestions
    s_bal_goal_fast_bad_suggestions
    s_bal_best_avail_bad_suggestions
    EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED
    EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED
    EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  12 --
 fs/ext4/mballoc.c | 292 +++++++++++++++++++++-------------------------
 fs/ext4/mballoc.h |   1 -
 3 files changed, 131 insertions(+), 174 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ea412fdb0b76..6afd3447bfca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -207,15 +207,6 @@ enum criteria {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
-/* Large fragment size list lookup succeeded at least once for
- * CR_POWER2_ALIGNED */
-#define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
-/* Avg fragment size rb tree lookup succeeded at least once for
- * CR_GOAL_LEN_FAST */
-#define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
-/* Avg fragment size rb tree lookup succeeded at least once for
- * CR_BEST_AVAIL_LEN */
-#define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
@@ -1643,9 +1634,6 @@ struct ext4_sb_info {
 	atomic_t s_bal_len_goals;	/* len goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
-	atomic_t s_bal_p2_aligned_bad_suggestions;
-	atomic_t s_bal_goal_fast_bad_suggestions;
-	atomic_t s_bal_best_avail_bad_suggestions;
 	atomic64_t s_bal_cX_groups_considered[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_hits[EXT4_MB_NUM_CRS];
 	atomic64_t s_bal_cX_failed[EXT4_MB_NUM_CRS];		/* cX loop didn't find blocks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9eb997b8c9b..79b2c6b37fbd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -425,8 +425,8 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 					ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
-static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
-			       ext4_group_t group, enum criteria cr);
+static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
+			      ext4_group_t group);
 
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
@@ -875,9 +875,8 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	}
 }
 
-static struct ext4_group_info *
-ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
-			       struct xarray *xa, ext4_group_t start)
+static int ext4_mb_scan_groups_xarray(struct ext4_allocation_context *ac,
+				      struct xarray *xa, ext4_group_t start)
 {
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -888,16 +887,18 @@ ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp;
 
 	if (WARN_ON_ONCE(start >= end))
-		return NULL;
+		return 0;
 
 wrap_around:
 	xa_for_each_range(xa, group, grp, start, end - 1) {
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
@@ -908,95 +909,82 @@ ext4_mb_find_good_group_xarray(struct ext4_allocation_context *ac,
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
-
-	if (ac->ac_status == AC_STATUS_FOUND)
-		return;
-
-	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
-		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
+	int ret = 0;
 
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		grp = ext4_mb_find_good_group_largest_free_order(ac, i, *group);
-		if (grp) {
-			*group = grp->bb_group;
-			ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
-			return;
-		}
+		ret = ext4_mb_scan_groups_largest_free_order(ac, i, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			return ret;
 	}
 
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
+
 	/* Increment cr and search again if no group is found */
-	*new_cr = CR_GOAL_LEN_FAST;
+	ac->ac_criteria = CR_GOAL_LEN_FAST;
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
+	int i, ret = 0;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED)) {
-		if (sbi->s_mb_stats)
-			atomic_inc(&sbi->s_bal_goal_fast_bad_suggestions);
-	}
-
-	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
-	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		grp = ext4_mb_find_good_group_avg_frag_xarray(ac, i, *group);
-		if (grp) {
-			*group = grp->bb_group;
-			ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
-			return;
-		}
+	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
+	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
+		ret = ext4_mb_scan_groups_avg_frag_order(ac, i, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			return ret;
 	}
 
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
 	/*
 	 * CR_BEST_AVAIL_LEN works based on the concept that we have
 	 * a larger normalized goal len request which can be trimmed to
@@ -1006,9 +994,11 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 	 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
 	 */
 	if (ac->ac_flags & EXT4_MB_HINT_DATA)
-		*new_cr = CR_BEST_AVAIL_LEN;
+		ac->ac_criteria = CR_BEST_AVAIL_LEN;
 	else
-		*new_cr = CR_GOAL_LEN_SLOW;
+		ac->ac_criteria = CR_GOAL_LEN_SLOW;
+
+	return ret;
 }
 
 /*
@@ -1020,19 +1010,14 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
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
@@ -1085,18 +1070,18 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
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
+			return ret;
 	}
 
 	/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
 	ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
-	*new_cr = CR_GOAL_LEN_SLOW;
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
+	ac->ac_criteria = CR_GOAL_LEN_SLOW;
+
+	return ret;
 }
 
 static inline int should_optimize_scan(struct ext4_allocation_context *ac)
@@ -1111,59 +1096,82 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
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
 }
 
-/*
- * ext4_mb_choose_next_group: choose next group for allocation.
- *
- * @ac        Allocation Context
- * @new_cr    This is an output parameter. If the there is no good group
- *            available at current CR level, this field is updated to indicate
- *            the new cr level that should be used.
- * @group     This is an input / output parameter. As an input it indicates the
- *            next group that the allocator intends to use for allocation. As
- *            output, this field indicates the next group that should be used as
- *            determined by the optimization functions.
- * @ngroups   Total number of groups
- */
-static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+static int ext4_mb_scan_groups_linear(struct ext4_allocation_context *ac,
+		ext4_group_t ngroups, ext4_group_t *start, ext4_group_t count)
 {
-	*new_cr = ac->ac_criteria;
+	int ret, i;
+	enum criteria cr = ac->ac_criteria;
+	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group = *start;
 
-	if (!should_optimize_scan(ac)) {
-		*group = next_linear_group(*group, ngroups);
-		return;
+	for (i = 0; i < count; i++, next_linear_group(&group, ngroups)) {
+		ret = ext4_mb_scan_group(ac, group);
+		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
+			return ret;
+		cond_resched();
 	}
 
+	*start = group;
+	if (count == ngroups)
+		ac->ac_criteria++;
+
+	/* Processed all groups and haven't found blocks */
+	if (sbi->s_mb_stats && i == ngroups)
+		atomic64_inc(&sbi->s_bal_cX_failed[cr]);
+
+	return 0;
+}
+
+static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
+{
+	int ret = 0;
+	ext4_group_t start;
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
+
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
+
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
@@ -1171,6 +1179,8 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		 */
 		WARN_ON(1);
 	}
+
+	return 0;
 }
 
 /*
@@ -2928,20 +2938,11 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
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
 
@@ -2987,48 +2988,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -3039,6 +3013,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 */
 		ext4_mb_try_best_found(ac, &e4b);
 		if (ac->ac_status != AC_STATUS_FOUND) {
+			int lost;
+
 			/*
 			 * Someone more lucky has already allocated it.
 			 * The only thing we can do is just take first
@@ -3054,7 +3030,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
-			cr = CR_ANY_FREE;
+			ac->ac_criteria = CR_ANY_FREE;
 			goto repeat;
 		}
 	}
@@ -3071,7 +3047,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
-		 ac->ac_flags, cr, err);
+		 ac->ac_flags, ac->ac_criteria, err);
 
 	if (ac->ac_prefetch_nr)
 		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
@@ -3197,8 +3173,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_POWER2_ALIGNED]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR_POWER2_ALIGNED]));
-	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_p2_aligned_bad_suggestions));
 
 	/* CR_GOAL_LEN_FAST stats */
 	seq_puts(seq, "\tcr_goal_fast_stats:\n");
@@ -3211,8 +3185,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_GOAL_LEN_FAST]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR_GOAL_LEN_FAST]));
-	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_goal_fast_bad_suggestions));
 
 	/* CR_BEST_AVAIL_LEN stats */
 	seq_puts(seq, "\tcr_best_avail_stats:\n");
@@ -3226,8 +3198,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 		   atomic_read(&sbi->s_bal_cX_ex_scanned[CR_BEST_AVAIL_LEN]));
 	seq_printf(seq, "\t\tuseless_loops: %llu\n",
 		   atomic64_read(&sbi->s_bal_cX_failed[CR_BEST_AVAIL_LEN]));
-	seq_printf(seq, "\t\tbad_suggestions: %u\n",
-		   atomic_read(&sbi->s_bal_best_avail_bad_suggestions));
 
 	/* CR_GOAL_LEN_SLOW stats */
 	seq_puts(seq, "\tcr_goal_slow_stats:\n");
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 83886fc9521b..15a049f05d04 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -199,7 +199,6 @@ struct ext4_allocation_context {
 	int ac_first_err;
 
 	__u32 ac_flags;		/* allocation hints */
-	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
 	__u16 ac_found;
 	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
-- 
2.46.1


