Return-Path: <linux-ext4+bounces-8592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE01AE375B
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A6F3B5C0C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C62B222596;
	Mon, 23 Jun 2025 07:47:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3721F873B;
	Mon, 23 Jun 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664825; cv=none; b=JNcENpB/nFbK3fQMEEBdWWpwpooheHjItegOTZPXPdBeuq5piihgiSW5ScWN7e0kG5HtddMNd/HrgEQr32QjfOTEgfY2ip2KbCFv1MDg2sfXAw/uU2GO0eL3tyJUyZ6rz6fFAyvleb9/RuXYwbtlbNuL5yVN+lJqlP3qB116PNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664825; c=relaxed/simple;
	bh=gJ2vImNIjZMqWgvCr44KX88669L0OzhjtbTYuJvlBVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UV+okVkGPDyvcbSmJCsXn1nNrOJeHbN2mgOYUiQPm4Oo6S5qAHyps8B6JPYGlYq0aCDXEdVH+1GadhV38gVpRYWnlaDnvzUh6b+j2E1N9muNisIZEIVHDANAS6Bfr0GGAfqbrInk+V8uqyQkdY/IX/7/D/2DQA9VS7apFfkDPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bQg6b72mTz2Cfbr;
	Mon, 23 Jun 2025 15:43:03 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 966E61A0188;
	Mon, 23 Jun 2025 15:47:00 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:59 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 07/16] ext4: convert sbi->s_mb_free_pending to atomic_t
Date: Mon, 23 Jun 2025 15:32:55 +0800
Message-ID: <20250623073304.3275702-8-libaokun1@huawei.com>
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

                   | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
 Disk: 960GB SSD   |-------------------------|-------------------------|
                   | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 19699 | 20982 (+6.5%)   | 53093 | 50629 (-4.6%)   |
mb_optimize_scan=1 | 9862  | 10703 (+8.5%)   | 14401 | 14856 (+3.1%)   |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
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
index 294198c05cdd..003b8d3726e8 100644
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
index 216b332a5054..5410fb3688ee 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3680,7 +3680,7 @@ int ext4_mb_init(struct super_block *sb)
 	}
 
 	spin_lock_init(&sbi->s_md_lock);
-	sbi->s_mb_free_pending = 0;
+	atomic_set(&sbi->s_mb_free_pending, 0);
 	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
 	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
 	INIT_LIST_HEAD(&sbi->s_discard_list);
@@ -3894,10 +3894,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
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
@@ -6392,7 +6389,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 
 	spin_lock(&sbi->s_md_lock);
 	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
-	sbi->s_mb_free_pending += clusters;
+	atomic_add(clusters, &sbi->s_mb_free_pending);
 	spin_unlock(&sbi->s_md_lock);
 }
 
-- 
2.46.1


