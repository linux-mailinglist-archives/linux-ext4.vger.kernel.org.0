Return-Path: <linux-ext4+bounces-8585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D7AE3745
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D00A171FE6
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DF21FC7CB;
	Mon, 23 Jun 2025 07:47:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D449376;
	Mon, 23 Jun 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664820; cv=none; b=EzQSmDZyHptLk3cqI0pv2Bq3sg0reLOKE5Gma+yVXltSg9hhRhlu5v+og2wbvylkiKnxN/74ov7++YwJDlVMt15ggbDINiEcBqqUHrQyF0/NgTjiCcz4GICmEBnJ10uNxLJdFT+ATI8IJqW60KDCZ0fih1qJlt+GCxTHn1JxVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664820; c=relaxed/simple;
	bh=wSNFclUCUsCTmMmziPFxFmR+/4LVux548FVUQDvdo48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcfCu2JLanB7YV6Aod155YFjwCQTZkhh9JkQ7KZxcB2iEBo+x3DxB4TDMp8KV+0kDOEq8yKv/2p7GxXDAP31WGM3iQ0vQ+em7GY6FhPM9qyQ0pWCZZeRrb1cQ5BSG/l7kOngbIWQQdVq4lPAjCL1rVrFEVpxx09Jc24E+Xt0+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQg6504sqzTgs9;
	Mon, 23 Jun 2025 15:42:37 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 94AB514027D;
	Mon, 23 Jun 2025 15:46:55 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:54 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 01/16] ext4: add ext4_try_lock_group() to skip busy groups
Date: Mon, 23 Jun 2025 15:32:49 +0800
Message-ID: <20250623073304.3275702-2-libaokun1@huawei.com>
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

When ext4 allocates blocks, we used to just go through the block groups
one by one to find a good one. But when there are tons of block groups
(like hundreds of thousands or even millions) and not many have free space
(meaning they're mostly full), it takes a really long time to check them
all, and performance gets bad. So, we added the "mb_optimize_scan" mount
option (which is on by default now). It keeps track of some group lists,
so when we need a free block, we can just grab a likely group from the
right list. This saves time and makes block allocation much faster.

But when multiple processes or containers are doing similar things, like
constantly allocating 8k blocks, they all try to use the same block group
in the same list. Even just two processes doing this can cut the IOPS in
half. For example, one container might do 300,000 IOPS, but if you run two
at the same time, the total is only 150,000.

Since we can already look at block groups in a non-linear way, the first
and last groups in the same list are basically the same for finding a block
right now. Therefore, add an ext4_try_lock_group() helper function to skip
the current group when it is locked by another process, thereby avoiding
contention with other processes. This helps ext4 make better use of having
multiple block groups.

Also, to make sure we don't skip all the groups that have free space
when allocating blocks, we won't try to skip busy groups anymore when
ac_criteria is CR_ANY_FREE.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

                   | Kunpeng 920 / 512GB -P80| AMD 9654 / 1536GB -P96  |
 Disk: 960GB SSD   |-------------------------|-------------------------|
                   | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 2667  | 4821  (+80.7%)  | 3450  | 15371 (+345%)   |
mb_optimize_scan=1 | 2643  | 4784  (+81.0%)  | 3209  | 6101  (+90.0%)  |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    | 23 ++++++++++++++---------
 fs/ext4/mballoc.c | 19 ++++++++++++++++---
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..9df74123e7e6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3541,23 +3541,28 @@ static inline int ext4_fs_is_busy(struct ext4_sb_info *sbi)
 	return (atomic_read(&sbi->s_lock_busy) > EXT4_CONTENTION_THRESHOLD);
 }
 
+static inline bool ext4_try_lock_group(struct super_block *sb, ext4_group_t group)
+{
+	if (!spin_trylock(ext4_group_lock_ptr(sb, group)))
+		return false;
+	/*
+	 * We're able to grab the lock right away, so drop the lock
+	 * contention counter.
+	 */
+	atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
+	return true;
+}
+
 static inline void ext4_lock_group(struct super_block *sb, ext4_group_t group)
 {
-	spinlock_t *lock = ext4_group_lock_ptr(sb, group);
-	if (spin_trylock(lock))
-		/*
-		 * We're able to grab the lock right away, so drop the
-		 * lock contention counter.
-		 */
-		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
-	else {
+	if (!ext4_try_lock_group(sb, group)) {
 		/*
 		 * The lock is busy, so bump the contention counter,
 		 * and then wait on the spin lock.
 		 */
 		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, 1,
 				  EXT4_MAX_CONTENTION);
-		spin_lock(lock);
+		spin_lock(ext4_group_lock_ptr(sb, group));
 	}
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e98c5be4e0a..336d65c4f6a2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -896,7 +896,8 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
 				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
+			if (!spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group)) &&
+			    likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
 				*group = iter->bb_group;
 				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
 				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
@@ -932,7 +933,8 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
 	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
 		if (sbi->s_mb_stats)
 			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
-		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
+		if (!spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group)) &&
+		    likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
 			grp = iter;
 			break;
 		}
@@ -2899,6 +2901,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 							nr, &prefetch_ios);
 			}
 
+			/* prevent unnecessary buddy loading. */
+			if (cr < CR_ANY_FREE &&
+			    spin_is_locked(ext4_group_lock_ptr(sb, group)))
+				continue;
+
 			/* This now checks without needing the buddy page */
 			ret = ext4_mb_good_group_nolock(ac, group, cr);
 			if (ret <= 0) {
@@ -2911,7 +2918,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (err)
 				goto out;
 
-			ext4_lock_group(sb, group);
+			/* skip busy group */
+			if (cr >= CR_ANY_FREE) {
+				ext4_lock_group(sb, group);
+			} else if (!ext4_try_lock_group(sb, group)) {
+				ext4_mb_unload_buddy(&e4b);
+				continue;
+			}
 
 			/*
 			 * We need to check again after locking the
-- 
2.46.1


