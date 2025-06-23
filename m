Return-Path: <linux-ext4+bounces-8589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777EAE3754
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FEF3B47DC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD221A451;
	Mon, 23 Jun 2025 07:47:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC241F6667;
	Mon, 23 Jun 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664823; cv=none; b=kq/2A9mQHKjbZLP1llrfxru6VATpX8POQMAFywdUtndcuTxA9D8RyswZO4ppjdDpFyY5QqmGqx7LICNfLQhlwddG2zbBd1Bvg9zCBCE8U4+c56P8j4f1HE/FqOg13RDzO3IDWITEIquXhwrKny6pJg1BRzJ2sCh8k0eaRgI+7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664823; c=relaxed/simple;
	bh=sYtqUFt4brvDA+yF4dcv6k3g1PaR0DyYG66HfGgJ7PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuW4p3KOhL2MRSlJzjrTcz8K4IDeJM/aYz5AAAQXfuRcRaIh6vjD4j/scx+d7QG7fJa6G5aFTsrL9/Y2bfkI59UYMu5+jHZrO/6UwFMtHIynf9a1LZHu/X1v/N7ud2wi5sBSeb91+WNnaVK1fHptKzoDoTT87JGeIwUDVnmZTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQg9H39fFz2TSJG;
	Mon, 23 Jun 2025 15:45:23 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A0501401F2;
	Mon, 23 Jun 2025 15:46:58 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:57 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 04/16] ext4: utilize multiple global goals to reduce contention
Date: Mon, 23 Jun 2025 15:32:52 +0800
Message-ID: <20250623073304.3275702-5-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250623073304.3275702-1-libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
goals, with the number of goals being the CPU count rounded up to the
nearest power of 2. To ensure a consistent goal for each inode, we select
the corresponding goal by taking the inode number modulo the total number
of goals.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

                   | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
 Disk: 960GB SSD   |-------------------------|-------------------------|
                   | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 7612  | 19699 (+158%)   | 21647 | 53093 (+145%)   |
mb_optimize_scan=1 | 7568  | 9862  (+30.3%)  | 9117  | 14401 (+57.9%)  |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 31 ++++++++++++++++++++++++-------
 fs/ext4/mballoc.h |  9 +++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 93f03d8c3dca..c3f16aba7b79 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1630,7 +1630,7 @@ struct ext4_sb_info {
 	unsigned int s_mb_group_prealloc;
 	unsigned int s_max_dir_size_kb;
 	/* where last allocation was done - for stream allocation */
-	ext4_group_t s_mb_last_group;
+	ext4_group_t *s_mb_last_groups;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3f103919868b..216b332a5054 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2168,9 +2168,12 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_buddy_folio = e4b->bd_buddy_folio;
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
-		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
-		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
+		int hash = ac->ac_inode->i_ino % MB_LAST_GROUPS;
+		/* Pairs with smp_load_acquire in ext4_mb_regular_allocator() */
+		smp_store_release(&sbi->s_mb_last_groups[hash],
+				  ac->ac_f_ex.fe_group);
+	}
 	/*
 	 * As we've just preallocated more space than
 	 * user requested originally, we store allocated
@@ -2842,9 +2845,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	}
 
 	/* if stream allocation is enabled, use global goal */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
-		/* pairs with smp_store_release in ext4_mb_use_best_found() */
-		ac->ac_g_ex.fe_group = smp_load_acquire(&sbi->s_mb_last_group);
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
+		int hash = ac->ac_inode->i_ino % MB_LAST_GROUPS;
+		/* Pairs with smp_store_release in ext4_mb_use_best_found() */
+		ac->ac_g_ex.fe_group = smp_load_acquire(
+						&sbi->s_mb_last_groups[hash]);
+	}
 
 	/*
 	 * Let's just scan groups to find more-less suitable blocks We
@@ -3715,10 +3721,17 @@ int ext4_mb_init(struct super_block *sb)
 			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
 	}
 
+	sbi->s_mb_last_groups = kcalloc(MB_LAST_GROUPS, sizeof(ext4_group_t),
+					GFP_KERNEL);
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
@@ -3743,6 +3756,9 @@ int ext4_mb_init(struct super_block *sb)
 out_free_locality_groups:
 	free_percpu(sbi->s_locality_groups);
 	sbi->s_locality_groups = NULL;
+out_free_last_groups:
+	kvfree(sbi->s_mb_last_groups);
+	sbi->s_mb_last_groups = NULL;
 out:
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
@@ -3847,6 +3863,7 @@ void ext4_mb_release(struct super_block *sb)
 	}
 
 	free_percpu(sbi->s_locality_groups);
+	kvfree(sbi->s_mb_last_groups);
 }
 
 static inline int ext4_issue_discard(struct super_block *sb,
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index f8280de3e882..38c37901728d 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -97,6 +97,15 @@
  */
 #define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
 
+/*
+ * Number of mb last groups
+ */
+#ifdef CONFIG_SMP
+#define MB_LAST_GROUPS roundup_pow_of_two(nr_cpu_ids)
+#else
+#define MB_LAST_GROUPS 1
+#endif
+
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
-- 
2.46.1


