Return-Path: <linux-ext4+bounces-8982-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DCB03F91
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7021887289
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC03254854;
	Mon, 14 Jul 2025 13:18:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEF24BBEE;
	Mon, 14 Jul 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499117; cv=none; b=ZVuqvVUoHSzMOb/t6tbdBcyZHNUkHzHc9muMxTMVrUM4eOe3j4+5hcrbk33P3pyo8GowyhIF3aZ23Ho2IaN0OQ6/rRcEbB8c/9TVvny+sU6Ms0I+E9NQH79t+rsLCIvZ2uWKFUyy/GFBtyZq5XfmlaUxVidA6HXPUgcBAZGUFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499117; c=relaxed/simple;
	bh=Gjex9zbY6rDfJ6Nyy5o5qQ8vIt7nCR0bSjIsrJBgUy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QofZBr4Utio5xGTbfMtzejgmzLuy44D87sAb7vYkEZA3nTpvDk4TwlYTBnIH07bJHq3Sh81W1LQeVSInaYYoZE0iMRrD5gDa1Zhafa8XZJMlnvOIhi94MErX9Z1waXTGIDExp8lZkgcBT2+jz+wt8k2xk8ydElFx0wHvmeBsQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjSV3lGYz14M0B;
	Mon, 14 Jul 2025 21:13:46 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 78B9218006C;
	Mon, 14 Jul 2025 21:18:32 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:31 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 04/17] ext4: remove unnecessary s_md_lock on update s_mb_last_group
Date: Mon, 14 Jul 2025 21:03:14 +0800
Message-ID: <20250714130327.1830534-5-libaokun1@huawei.com>
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

After we optimized the block group lock, we found another lock
contention issue when running will-it-scale/fallocate2 with multiple
processes. The fallocate's block allocation and the truncate's block
release were fighting over the s_md_lock. The problem is, this lock
protects totally different things in those two processes: the list of
freed data blocks (s_freed_data_list) when releasing, and where to start
looking for new blocks (mb_last_group) when allocating.

Now we only need to track s_mb_last_group and no longer need to track
s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
two are consistent. Since s_mb_last_group is merely a hint and doesn't
require strong synchronization, READ_ONCE/WRITE_ONCE is sufficient.

Besides, the s_mb_last_group data type only requires ext4_group_t
(i.e., unsigned int), rendering unsigned long superfluous.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 4821  | 9636  (+99.8%) | 314065 | 337597 (+7.4%) |
|mb_optimize_scan=1 | 4784  | 4834  (+1.04%) | 316344 | 341440 (+7.9%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 15371 | 22341 (+45.3%) | 205851 | 219707 (+6.7%) |
|mb_optimize_scan=1 | 6101  | 9177  (+50.4%) | 207373 | 215732 (+4.0%) |

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b83095541c98..7f5c070de0fb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1630,7 +1630,7 @@ struct ext4_sb_info {
 	unsigned int s_mb_group_prealloc;
 	unsigned int s_max_dir_size_kb;
 	/* where last allocation was done - for stream allocation */
-	unsigned long s_mb_last_group;
+	ext4_group_t s_mb_last_group;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e3a5103e1620..025b759ca643 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2168,11 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_buddy_folio = e4b->bd_buddy_folio;
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		spin_lock(&sbi->s_md_lock);
-		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-		spin_unlock(&sbi->s_md_lock);
-	}
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
+		WRITE_ONCE(sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
 	/*
 	 * As we've just preallocated more space than
 	 * user requested originally, we store allocated
@@ -2845,10 +2842,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	/* if stream allocation is enabled, use global goal */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		/* TBD: may be hot point */
-		spin_lock(&sbi->s_md_lock);
-		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
-		spin_unlock(&sbi->s_md_lock);
+		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_group);
 		ac->ac_g_ex.fe_start = -1;
 		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
 	}
-- 
2.46.1


