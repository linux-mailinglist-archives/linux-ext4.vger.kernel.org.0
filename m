Return-Path: <linux-ext4+bounces-8595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C39AE3758
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436C918947B5
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F46221544;
	Mon, 23 Jun 2025 07:47:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1C2222B0;
	Mon, 23 Jun 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664827; cv=none; b=krO9XuKEN6v+AQjc9hyJb7PL4hUMijKknaPIDLN6AzcRxW6fQf3oFuM3qwewNb7gYYD8p7hOXgRaJwIoj8l3M/uT4tfCC3SPF4htXjNgV8YmVba+w400gOQzRZEYq8TQTtVlukwqE6gsFxhBZN+Pg9B4JEF04Z0/0rQcpQO4LDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664827; c=relaxed/simple;
	bh=+KSWrPtfAV8nq4GefxhPPB9oGsCXuefobotfsfhCvzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZJYtkw22gP9XMa2wOTgp7YoL6bAE3SzGFRvcsiMj73nDAg8PFOZ4t+FSigc7nIq43OjXeRELv2ZW1tYIZnyBo6lHcTBluNt4MEXHff/83B+CGwkJqzCHuZ/71KNtFUs/JJUmbMzZTn+Ua56VN0yOTDZBowlTxfh5SNGm15M+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQg9s5C1vztS2X;
	Mon, 23 Jun 2025 15:45:53 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 379CC1400DC;
	Mon, 23 Jun 2025 15:47:03 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:47:02 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 10/16] ext4: fix largest free orders lists corruption on mb_optimize_scan switch
Date: Mon, 23 Jun 2025 15:32:58 +0800
Message-ID: <20250623073304.3275702-11-libaokun1@huawei.com>
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

The grp->bb_largest_free_order is updated regardless of whether
mb_optimize_scan is enabled. This can lead to inconsistencies between
grp->bb_largest_free_order and the actual s_mb_largest_free_orders list
index when mb_optimize_scan is repeatedly enabled and disabled via remount.

For example, if mb_optimize_scan is initially enabled, largest free
order is 3, and the group is in s_mb_largest_free_orders[3]. Then,
mb_optimize_scan is disabled via remount, block allocations occur,
updating largest free order to 2. Finally, mb_optimize_scan is re-enabled
via remount, more block allocations update largest free order to 1.

At this point, the group would be removed from s_mb_largest_free_orders[3]
under the protection of s_mb_largest_free_orders_locks[2]. This lock
mismatch can lead to list corruption.

To fix this, a new field bb_largest_free_order_idx is added to struct
ext4_group_info to explicitly track the list index. Then still update
bb_largest_free_order unconditionally, but only update
bb_largest_free_order_idx when mb_optimize_scan is enabled. so that there
is no inconsistency between the lock and the data to be protected.

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 003b8d3726e8..0e574378c6a3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3476,6 +3476,7 @@ struct ext4_group_info {
 	int		bb_avg_fragment_size_order;	/* order of average
 							   fragment in BG */
 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
+	ext4_grpblk_t	bb_largest_free_order_idx; /* index of largest frag */
 	ext4_group_t	bb_group;	/* Group number */
 	struct          list_head bb_prealloc_list;
 #ifdef DOUBLE_CHECK
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e6d6c2da3c6e..dc82124f0905 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1152,33 +1152,29 @@ static void
 mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int i;
+	int new, old = grp->bb_largest_free_order_idx;
 
-	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
-		if (grp->bb_counters[i] > 0)
+	for (new = MB_NUM_ORDERS(sb) - 1; new >= 0; new--)
+		if (grp->bb_counters[new] > 0)
 			break;
+
+	grp->bb_largest_free_order = new;
 	/* No need to move between order lists? */
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
-	    i == grp->bb_largest_free_order) {
-		grp->bb_largest_free_order = i;
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || new == old)
 		return;
-	}
 
-	if (grp->bb_largest_free_order >= 0) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+	if (old >= 0) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
 		list_del_init(&grp->bb_largest_free_order_node);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
 	}
-	grp->bb_largest_free_order = i;
-	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+
+	grp->bb_largest_free_order_idx = new;
+	if (new >= 0 && grp->bb_free) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
 		list_add_tail(&grp->bb_largest_free_order_node,
-		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+			      &sbi->s_mb_largest_free_orders[new]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
 	}
 }
 
@@ -3391,6 +3387,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
 	meta_group_info[i]->bb_avg_fragment_size_order = -1;  /* uninit */
+	meta_group_info[i]->bb_largest_free_order_idx = -1;  /* uninit */
 	meta_group_info[i]->bb_group = group;
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
-- 
2.46.1


