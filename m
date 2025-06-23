Return-Path: <linux-ext4+bounces-8588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A0AE374A
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A801893A79
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9A21A433;
	Mon, 23 Jun 2025 07:47:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52581388;
	Mon, 23 Jun 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664823; cv=none; b=mc4enlcAOb+wgeaFIj3kSjSIGyVoXLgI9fRo2EcwJWBdYdQ1FTQUKe8D5qxvF2FSsBDeVhYqYhXM3/5vGCAsPbCsOebStIxrZOm5VfrFRDLwO5ALqX0/iA6TP7QZto19/WJKhq0/tKDy/H2ySk3oNeujyLUYL+kBHLfPC4hNy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664823; c=relaxed/simple;
	bh=jsK+9dugOTCQLSNIxqMiLiZ14gIE22FtPTOf9JWnmqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE7A2f/+bGO2BfbOVQx99wU8kV98UKoCOsRNr5rFpAdGt/2oYdgXvb5lPOJNff/JgmxhvLHJgf6ePG77Wk5EmVFvHMBhtL6PvsAQxTfCKvQkH4MHRiP9HUrgMQO0g5MMJj21q8aygczFUrDtgIM4hB/8QVQebfXbcR+RUMHgk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQg9H0Rcvz2BdVh;
	Mon, 23 Jun 2025 15:45:23 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AA441A0188;
	Mon, 23 Jun 2025 15:46:57 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:56 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update s_mb_last_group
Date: Mon, 23 Jun 2025 15:32:51 +0800
Message-ID: <20250623073304.3275702-4-libaokun1@huawei.com>
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

After we optimized the block group lock, we found another lock
contention issue when running will-it-scale/fallocate2 with multiple
processes. The fallocate's block allocation and the truncate's block
release were fighting over the s_md_lock. The problem is, this lock
protects totally different things in those two processes: the list of
freed data blocks (s_freed_data_list) when releasing, and where to start
looking for new blocks (mb_last_group) when allocating.

Now we only need to track s_mb_last_group and no longer need to track
s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
two are consistent, and we can ensure that the s_mb_last_group read is up
to date by using smp_store_release/smp_load_acquire.

Besides, the s_mb_last_group data type only requires ext4_group_t
(i.e., unsigned int), rendering unsigned long superfluous.

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

                   | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
 Disk: 960GB SSD   |-------------------------|-------------------------|
                   | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cfb60f8fbb63..93f03d8c3dca 100644
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
index 5cdae3bda072..3f103919868b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_buddy_folio = e4b->bd_buddy_folio;
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		spin_lock(&sbi->s_md_lock);
-		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-		spin_unlock(&sbi->s_md_lock);
-	}
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
+		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
+		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
 	/*
 	 * As we've just preallocated more space than
 	 * user requested originally, we store allocated
@@ -2844,12 +2842,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	}
 
 	/* if stream allocation is enabled, use global goal */
-	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		/* TBD: may be hot point */
-		spin_lock(&sbi->s_md_lock);
-		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
-		spin_unlock(&sbi->s_md_lock);
-	}
+	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
+		/* pairs with smp_store_release in ext4_mb_use_best_found() */
+		ac->ac_g_ex.fe_group = smp_load_acquire(&sbi->s_mb_last_group);
 
 	/*
 	 * Let's just scan groups to find more-less suitable blocks We
-- 
2.46.1


