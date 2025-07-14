Return-Path: <linux-ext4+bounces-8994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B08B03FA6
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E144A1889
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460F25EFBE;
	Mon, 14 Jul 2025 13:18:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DE25DB07;
	Mon, 14 Jul 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499130; cv=none; b=lmRKbz80SEgFalR3DppHImbqWp89hAZrYY3raMLUTGopO9i3kGzn1VxvRn6s4wcH3fOoGkLtjAthv1fzL1Jc/YB25oyRM5Gh561Itu4SjYR3OmFpH0n9W09MGWg9B6SsZzptB76qAwV9EJBw2XjM9xk35QQc1ArvCxRraLnEcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499130; c=relaxed/simple;
	bh=eTCTy6pujNn4ijrPbF3C+LkW3BUQLjeqwj7hkS2cXw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9bPueYf/OQXhkehsxVYuBd/Y88Gw3wOdT1xZ9bmPMllRBVWv6LpAzjqTvmPQfwsQzwt4nTPm/qK5IX6RBMbPTAc7jfd+u8x9T1bv/YaBWfcKHnlspEVAVvztAOLVsNQR00yT97yLaOrZz76erwVvoQXrDpFqY2LPf52JTCuluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgjTW4w2Gz2Cdk8;
	Mon, 14 Jul 2025 21:14:39 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id D31F71A016C;
	Mon, 14 Jul 2025 21:18:45 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:44 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 17/17] ext4: implement linear-like traversal across order xarrays
Date: Mon, 14 Jul 2025 21:03:27 +0800
Message-ID: <20250714130327.1830534-18-libaokun1@huawei.com>
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

Although we now perform ordered traversal within an xarray, this is
currently limited to a single xarray. However, we have multiple such
xarrays, which prevents us from guaranteeing a linear-like traversal
where all groups on the right are visited before all groups on the left.

For example, suppose we have 128 block groups, with a target group of 64,
a target length corresponding to an order of 1, and available free groups
of 16 (order 1) and group 65 (order 8):

For linear traversal, when no suitable free block is found in group 64, it
will search in the next block group until group 127, then start searching
from 0 up to block group 63. It ensures continuous forward traversal, which
is consistent with the unidirectional rotation behavior of HDD platters.

Additionally, the block group lock contention during freeing block is
unavoidable. The goal increasing from 0 to 64 indicates that previously
scanned groups (which had no suitable free space and are likely to free
blocks later) and skipped groups (which are currently in use) have newly
freed some used blocks. If we allocate blocks in these groups, the
probability of competing with other processes increases.

For non-linear traversal, we first traverse all groups in order_1. If only
group 16 has free space in this list, we first traverse [63, 128), then
traverse [0, 64) to find the available group 16, and then allocate blocks
in group 16. Therefore, it cannot guarantee continuous traversal in one
direction, thus increasing the probability of contention.

So refactor ext4_mb_scan_groups_xarray() to ext4_mb_scan_groups_xa_range()
to only traverse a fixed range of groups, and move the logic for handling
wrap around to the caller. The caller first iterates through all xarrays
in the range [start, ngroups) and then through the range [0, start). This
approach simulates a linear scan, which reduces contention between freeing
blocks and allocating blocks.

Assume we have the following groups, where "|" denotes the xarray traversal
start position:

order_1_groups: AB | CD
order_2_groups: EF | GH

Traversal order:
Before: C > D > A > B > G > H > E > F
After:  C > D > G > H > A > B > E > F

Performance test data follows:

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 19555 | 20049 (+2.5%)  | 315636 | 316724 (-0.3%) |
|mb_optimize_scan=1 | 15496 | 19342 (+24.8%) | 323569 | 328324 (+1.4%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 53192 | 52125 (-2.0%)  | 212678 | 215136 (+1.1%) |
|mb_optimize_scan=1 | 37636 | 50331 (+33.7%) | 214189 | 209431 (-2.2%) |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 68 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 79b2c6b37fbd..742124c8213b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -875,21 +875,20 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	}
 }
 
-static int ext4_mb_scan_groups_xarray(struct ext4_allocation_context *ac,
-				      struct xarray *xa, ext4_group_t start)
+static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
+					struct xarray *xa,
+					ext4_group_t start, ext4_group_t end)
 {
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	enum criteria cr = ac->ac_criteria;
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	unsigned long group = start;
-	ext4_group_t end = ngroups;
 	struct ext4_group_info *grp;
 
-	if (WARN_ON_ONCE(start >= end))
+	if (WARN_ON_ONCE(end > ngroups || start >= end))
 		return 0;
 
-wrap_around:
 	xa_for_each_range(xa, group, grp, start, end - 1) {
 		int err;
 
@@ -903,28 +902,23 @@ static int ext4_mb_scan_groups_xarray(struct ext4_allocation_context *ac,
 		cond_resched();
 	}
 
-	if (start) {
-		end = start;
-		start = 0;
-		goto wrap_around;
-	}
-
 	return 0;
 }
 
 /*
  * Find a suitable group of given order from the largest free orders xarray.
  */
-static int
-ext4_mb_scan_groups_largest_free_order(struct ext4_allocation_context *ac,
-				       int order, ext4_group_t start)
+static inline int
+ext4_mb_scan_groups_largest_free_order_range(struct ext4_allocation_context *ac,
+					     int order, ext4_group_t start,
+					     ext4_group_t end)
 {
 	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_largest_free_orders[order];
 
 	if (xa_empty(xa))
 		return 0;
 
-	return ext4_mb_scan_groups_xarray(ac, xa, start);
+	return ext4_mb_scan_groups_xa_range(ac, xa, start, end);
 }
 
 /*
@@ -937,12 +931,22 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i;
 	int ret = 0;
+	ext4_group_t start, end;
 
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		ret = ext4_mb_scan_groups_largest_free_order(ac, i, group);
+		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
+								   start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			return ret;
 	}
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
 
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
@@ -955,15 +959,17 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 /*
  * Find a suitable group of given order from the average fragments xarray.
  */
-static int ext4_mb_scan_groups_avg_frag_order(struct ext4_allocation_context *ac,
-					      int order, ext4_group_t start)
+static int
+ext4_mb_scan_groups_avg_frag_order_range(struct ext4_allocation_context *ac,
+					 int order, ext4_group_t start,
+					 ext4_group_t end)
 {
 	struct xarray *xa = &EXT4_SB(ac->ac_sb)->s_mb_avg_fragment_size[order];
 
 	if (xa_empty(xa))
 		return 0;
 
-	return ext4_mb_scan_groups_xarray(ac, xa, start);
+	return ext4_mb_scan_groups_xa_range(ac, xa, start, end);
 }
 
 /*
@@ -975,13 +981,23 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i, ret = 0;
+	ext4_group_t start, end;
 
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		ret = ext4_mb_scan_groups_avg_frag_order(ac, i, group);
+		ret = ext4_mb_scan_groups_avg_frag_order_range(ac, i,
+							       start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			return ret;
 	}
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
 
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
@@ -1017,6 +1033,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i, order, min_order;
 	unsigned long num_stripe_clusters = 0;
+	ext4_group_t start, end;
 
 	/*
 	 * mb_avg_fragment_size_order() returns order in a way that makes
@@ -1048,6 +1065,9 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 	if (1 << min_order < ac->ac_o_ex.fe_len)
 		min_order = fls(ac->ac_o_ex.fe_len);
 
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
 		/*
@@ -1070,10 +1090,16 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		frag_order = mb_avg_fragment_size_order(ac->ac_sb,
 							ac->ac_g_ex.fe_len);
 
-		ret = ext4_mb_scan_groups_avg_frag_order(ac, frag_order, group);
+		ret = ext4_mb_scan_groups_avg_frag_order_range(ac, frag_order,
+							       start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			return ret;
 	}
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
 
 	/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
 	ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
-- 
2.46.1


