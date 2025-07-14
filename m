Return-Path: <linux-ext4+bounces-8985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE57B03F92
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C187A2301
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D14257AD3;
	Mon, 14 Jul 2025 13:18:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAA2561AA;
	Mon, 14 Jul 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499121; cv=none; b=Lwd0Wj2wZlDiqVG0UvuL+iAUMXBYrxlqybtUkjBwBnHnrI3WIp33B2owrLeAamazzHB7qe5V799eIQWJKYY7unojBHTXBLc2Gc+m9PwJ6zK36dhYHNM9u4h6fFsoRqoy3PLQE6vnkIACZP5TDau960mGX4vLdMHbcK83xR/nAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499121; c=relaxed/simple;
	bh=yISilfdq1aynH/B0nTo1wGYPwP+08qT1V257vVEa1HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUi668vzODzWldZJscVj9FZJEuIMK+EZjxNGWc25QQTsSlfiDgdR2QFG0uaJTlibKEgWC3uR5HnSm7qSe0MIWNDfy0MEib3uu7nBTvIv6BfnUUM6rhl961mYF7/G2duZ0HVleAVWJLCK3xaApMFNxP8ZjzrvTthtkChoXYtLr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjSZ4KPmz14M0P;
	Mon, 14 Jul 2025 21:13:50 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C09D180450;
	Mon, 14 Jul 2025 21:18:36 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:35 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 08/17] ext4: convert sbi->s_mb_free_pending to atomic_t
Date: Mon, 14 Jul 2025 21:03:18 +0800
Message-ID: <20250714130327.1830534-9-libaokun1@huawei.com>
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

Previously, s_md_lock was used to protect s_mb_free_pending during
modifications, while smp_mb() ensured fresh reads, so s_md_lock just
guarantees the atomicity of s_mb_free_pending. Thus we optimized it by
converting s_mb_free_pending into an atomic variable, thereby eliminating
s_md_lock and minimizing lock contention. This also prepares for future
lockless merging of free extents.

Following this modification, s_md_lock is exclusively responsible for
managing insertions and deletions within s_freed_data_list, along with
operations involving list_splice.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 19628 | 20043 (+2.1%)  | 320885 | 314331 (-2.0%) |
|mb_optimize_scan=1 | 7129  | 7290  (+2.2%)  | 321275 | 324226 (+0.9%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 53760 | 54999 (+2.3%)  | 213145 | 214380 (+0.5%) |
|mb_optimize_scan=1 | 12716 | 13497 (+6.1%)  | 215262 | 216276 (+0.4%) |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/balloc.c  | 2 +-
 fs/ext4/ext4.h    | 2 +-
 fs/ext4/mballoc.c | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c48fd36b2d74..c9329ed5c094 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -703,7 +703,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	 * possible we just missed a transaction commit that did so
 	 */
 	smp_mb();
-	if (sbi->s_mb_free_pending == 0) {
+	if (atomic_read(&sbi->s_mb_free_pending) == 0) {
 		if (test_opt(sb, DISCARD)) {
 			atomic_inc(&sbi->s_retry_alloc_pending);
 			flush_work(&sbi->s_discard_work);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0379f2974252..52a72af6ec34 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1602,7 +1602,7 @@ struct ext4_sb_info {
 	unsigned short *s_mb_offsets;
 	unsigned int *s_mb_maxs;
 	unsigned int s_group_info_size;
-	unsigned int s_mb_free_pending;
+	atomic_t s_mb_free_pending;
 	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
 						   after commit completed */
 	struct list_head s_discard_list;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b6aa24b48543..ba3cdacbc9f9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3687,7 +3687,7 @@ int ext4_mb_init(struct super_block *sb)
 	}
 
 	spin_lock_init(&sbi->s_md_lock);
-	sbi->s_mb_free_pending = 0;
+	atomic_set(&sbi->s_mb_free_pending, 0);
 	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
 	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
 	INIT_LIST_HEAD(&sbi->s_discard_list);
@@ -3903,10 +3903,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	/* we expect to find existing buddy because it's pinned */
 	BUG_ON(err != 0);
 
-	spin_lock(&EXT4_SB(sb)->s_md_lock);
-	EXT4_SB(sb)->s_mb_free_pending -= entry->efd_count;
-	spin_unlock(&EXT4_SB(sb)->s_md_lock);
-
+	atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
 	db = e4b.bd_info;
 	/* there are blocks to put in buddy to make them really free */
 	count += entry->efd_count;
@@ -6401,7 +6398,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 
 	spin_lock(&sbi->s_md_lock);
 	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
-	sbi->s_mb_free_pending += clusters;
+	atomic_add(clusters, &sbi->s_mb_free_pending);
 	spin_unlock(&sbi->s_md_lock);
 }
 
-- 
2.46.1


