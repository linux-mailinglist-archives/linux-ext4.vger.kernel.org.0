Return-Path: <linux-ext4+bounces-8601-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0552AE3760
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AED41734C9
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484A22D785;
	Mon, 23 Jun 2025 07:47:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0386226CE1;
	Mon, 23 Jun 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664832; cv=none; b=dIJPqQUH/bWgwS4Wp6lWY9dyWhuUiFFWevxEl8dffEpfV+wjhwo25iOj+au0JfImM3Eq1wukVxg0j3RZoYkNGF/VQhwBf3g8+obMomBKQmn8IICsfsd8WzIHUrMzxWU++cqRbgB4edOsm2xzAkF5+zFfGmihifADid3Up+yUD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664832; c=relaxed/simple;
	bh=/3XoxWpy1bvkEBHAB3eTe7ji9Z2uO/Fts96126NwKyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCJS9vmcFCLBt6oayCzKx8ty3T7JoeJuOT7mGTnx3lYKW0eEyeZkLUTtFD07E3P/svQiBOaZ+A+yq7xrgEANd+Sr9lkSCvx1i2J72M5moFmsTdtsJeRNqrAnVvx+GyR8CdrvhXhTUuexYKI2J9+Qv7unjwq5q4FeM0Z3T+P37/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQg9V0zD5z2BdVj;
	Mon, 23 Jun 2025 15:45:34 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F8E818005F;
	Mon, 23 Jun 2025 15:47:08 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:47:07 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 16/16] ext4: ensure global ordered traversal across all free groups xarrays
Date: Mon, 23 Jun 2025 15:33:04 +0800
Message-ID: <20250623073304.3275702-17-libaokun1@huawei.com>
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

Although we now perform ordered traversal within an xarray, this is
currently limited to a single xarray, traversing right then left. However,
we have multiple such xarrays, which prevents us from guaranteeing a
linear-like traversal where all groups on the right are visited before all
groups on the left.

Therefore, this change modifies the traversal to first iterate through
all right groups across all xarrays, and then all left groups across all
xarrays. This achieves a linear-like effect, mitigating contention
between block allocation and block freeing paths.

Performance test data follows:

CPU: Kunpeng 920   |          P80            |            P1           |
Memory: 512GB      |-------------------------|-------------------------|
Disk: 960GB SSD    | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 20976 | 20619  (-1.7%)  | 319396| 299238 (-6.3%)  |
mb_optimize_scan=1 | 14580 | 20119  (+37.9%) | 319237| 315268 (-1.2%)  |

CPU: AMD 9654 * 2  |          P96            |            P1           |
Memory: 1536GB     |-------------------------|-------------------------|
Disk: 960GB SSD    | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 51713 | 51983 (+0.5%)   | 206655| 207033 (0.18%)  |
mb_optimize_scan=1 | 35527 | 48486 (+36.4%)  | 212574| 202415 (+4.7%)  |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 69 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d8372a649a0c..d26a0e8e3f7e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -877,22 +877,20 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 		     grp->bb_group, new, ret);
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
-	ext4_group_t end;
 	struct ext4_group_info *grp;
 
-	if (WARN_ON_ONCE(start >= ngroups))
+	if (WARN_ON_ONCE(end >= ngroups || start > end))
 		return 0;
-	end = ngroups - 1;
 
-wrap_around:
 	xa_for_each_range(xa, group, grp, start, end) {
 		int err;
 
@@ -906,28 +904,23 @@ static int ext4_mb_scan_groups_xarray(struct ext4_allocation_context *ac,
 		cond_resched();
 	}
 
-	if (start) {
-		end = start - 1;
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
+	return ext4_mb_scan_groups_xa_range(ac, xa, start, end - 1);
 }
 
 /*
@@ -940,13 +933,23 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i;
 	int ret = 0;
+	ext4_group_t start, end;
 
 	ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		ret = ext4_mb_scan_groups_largest_free_order(ac, i, group);
+		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
+								   start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			goto out;
 	}
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
 
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
@@ -961,15 +964,17 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
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
+	return ext4_mb_scan_groups_xa_range(ac, xa, start, end - 1);
 }
 
 /*
@@ -981,14 +986,24 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i, ret = 0;
+	ext4_group_t start, end;
 
 	ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		ret = ext4_mb_scan_groups_avg_frag_order(ac, i, group);
+		ret = ext4_mb_scan_groups_avg_frag_order_range(ac, i,
+							       start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			goto out;
 	}
+	if (start) {
+		end = start;
+		start = 0;
+		goto wrap_around;
+	}
 
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_failed[ac->ac_criteria]);
@@ -1025,6 +1040,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int i, order, min_order;
 	unsigned long num_stripe_clusters = 0;
+	ext4_group_t start, end;
 
 	/*
 	 * mb_avg_fragment_size_order() returns order in a way that makes
@@ -1057,6 +1073,9 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		min_order = fls(ac->ac_o_ex.fe_len);
 
 	ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
+	start = group;
+	end = ext4_get_groups_count(ac->ac_sb);
+wrap_around:
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
 		/*
@@ -1079,10 +1098,16 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		frag_order = mb_avg_fragment_size_order(ac->ac_sb,
 							ac->ac_g_ex.fe_len);
 
-		ret = ext4_mb_scan_groups_avg_frag_order(ac, frag_order, group);
+		ret = ext4_mb_scan_groups_avg_frag_order_range(ac, frag_order,
+							       start, end);
 		if (ret || ac->ac_status != AC_STATUS_CONTINUE)
 			goto out;
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


