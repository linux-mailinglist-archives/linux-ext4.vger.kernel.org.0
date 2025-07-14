Return-Path: <linux-ext4+bounces-8983-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBEBB03F8F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C92017D651
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458282571C6;
	Mon, 14 Jul 2025 13:18:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC0253950;
	Mon, 14 Jul 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499120; cv=none; b=oFmP4NHC2q1wm0aDjG6Z6dksLEKFMqD5rmofavWaWxM3rjeH7au2ByaeF9aHJmzRXdZker5paGtfk+y0koVYHKKicvLxCGmwp6cCfzWn35oy0ptZvQf1GpjYs9KbUL9ydRBau+fMP60hOQHsLLhackbvSm8kUyPox02B0ojgxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499120; c=relaxed/simple;
	bh=XULyWieM9zg0kqxJskYWGW2vaJqp9xDya4lJBbjdcx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS+nQ7t1noJzJmOUDlLqXoL/FcP8XHEk4Ksfb+OS0PTzD9/PF2vvEPnjM+1wLvxIi7ThyYB8aRDG2v83IG7FB+2tofflwGKDi7t9a/ExEUdM9DaGDJ3SZFema6uLHdczdHreqEi/vseD5akISF4Op+WGv/jCfhKb9WtI125WKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgjSs2vS7zXdyt;
	Mon, 14 Jul 2025 21:14:05 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F75E180450;
	Mon, 14 Jul 2025 21:18:33 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:32 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 05/17] ext4: utilize multiple global goals to reduce contention
Date: Mon, 14 Jul 2025 21:03:15 +0800
Message-ID: <20250714130327.1830534-6-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

When allocating data blocks, if the first try (goal allocation) fails and
stream allocation is on, it tries a global goal starting from the last
group we used (s_mb_last_group). This helps cluster large files together
to reduce free space fragmentation, and the data block contiguity also
accelerates write-back to disk.

However, when multiple processes allocate blocks, having just one global
goal means they all fight over the same group. This drastically lowers
the chances of extents merging and leads to much worse file fragmentation.

To mitigate this multi-process contention, we now employ multiple global
goals, with the number of goals being the minimum between the number of
possible CPUs and one-quarter of the filesystem's total block group count.

To ensure a consistent goal for each inode, we select the corresponding
goal by taking the inode number modulo the total number of goals.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 9636  | 19628 (+103%)  | 337597 | 320885 (-4.9%) |
|mb_optimize_scan=1 | 4834  | 7129  (+47.4%) | 341440 | 321275 (-5.9%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 22341 | 53760 (+140%)  | 219707 | 213145 (-2.9%) |
|mb_optimize_scan=1 | 9177  | 12716 (+38.5%) | 215732 | 215262 (+0.2%) |

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  6 ++++--
 fs/ext4/mballoc.c | 27 +++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7f5c070de0fb..ad97c693d56a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1629,14 +1629,16 @@ struct ext4_sb_info {
 	unsigned int s_mb_order2_reqs;
 	unsigned int s_mb_group_prealloc;
 	unsigned int s_max_dir_size_kb;
-	/* where last allocation was done - for stream allocation */
-	ext4_group_t s_mb_last_group;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
 	unsigned int s_sb_update_sec;
 	unsigned int s_sb_update_kb;
 
+	/* where last allocation was done - for stream allocation */
+	ext4_group_t *s_mb_last_groups;
+	unsigned int s_mb_nr_global_goals;
+
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
 	atomic_t s_bal_success;	/* we found long enough chunks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 025b759ca643..b6aa24b48543 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2168,8 +2168,12 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_buddy_folio = e4b->bd_buddy_folio;
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
-		WRITE_ONCE(sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
+		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+
+		WRITE_ONCE(sbi->s_mb_last_groups[hash], ac->ac_f_ex.fe_group);
+	}
+
 	/*
 	 * As we've just preallocated more space than
 	 * user requested originally, we store allocated
@@ -2842,7 +2846,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	/* if stream allocation is enabled, use global goal */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_group);
+		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
+
+		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
 		ac->ac_g_ex.fe_start = -1;
 		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
 	}
@@ -3722,10 +3728,19 @@ int ext4_mb_init(struct super_block *sb)
 			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
 	}
 
+	sbi->s_mb_nr_global_goals = umin(num_possible_cpus(),
+					 DIV_ROUND_UP(sbi->s_groups_count, 4));
+	sbi->s_mb_last_groups = kcalloc(sbi->s_mb_nr_global_goals,
+					sizeof(ext4_group_t), GFP_KERNEL);
+	if (sbi->s_mb_last_groups == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
 	if (sbi->s_locality_groups == NULL) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_free_last_groups;
 	}
 	for_each_possible_cpu(i) {
 		struct ext4_locality_group *lg;
@@ -3750,6 +3765,9 @@ int ext4_mb_init(struct super_block *sb)
 out_free_locality_groups:
 	free_percpu(sbi->s_locality_groups);
 	sbi->s_locality_groups = NULL;
+out_free_last_groups:
+	kfree(sbi->s_mb_last_groups);
+	sbi->s_mb_last_groups = NULL;
 out:
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
@@ -3854,6 +3872,7 @@ void ext4_mb_release(struct super_block *sb)
 	}
 
 	free_percpu(sbi->s_locality_groups);
+	kfree(sbi->s_mb_last_groups);
 }
 
 static inline int ext4_issue_discard(struct super_block *sb,
-- 
2.46.1


