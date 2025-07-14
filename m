Return-Path: <linux-ext4+bounces-8989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A0B03F9F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2764A0491
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86525B693;
	Mon, 14 Jul 2025 13:18:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB10259C94;
	Mon, 14 Jul 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499124; cv=none; b=OKnnzhWc/hV6BdatYYBIEZYORlWhjz1kyjaubrleLHMxRFQ7a335sMWKdJUk9+9KCjRh8PQBqjKoKxv+pCEF5QpItnGpYk9Uh7nafE04zhidAUHEPSV7sujB/V2zJgsq4Ns0GjgcPgYzVlFA25xSi3XnuznS/DkTAc55qb2RQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499124; c=relaxed/simple;
	bh=o+D8a/79NxtbMn5ghc10dsgUJUbi2CKg8I/NGszDWXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGEoViarbDA39jSrn+3vz0fuWniqpZ0dv8QSzlo1yk2h5CJbjfZcDjXBb+SL9Vevki9PCdXTqPLImTYVlowI0kiR+HsL5Y7TPh+EotoBR3NyWsM4ZGQGhIIO8lKCt+zdMKNcqtjWbFzOAD1HbKAYYgNxWus5lvOQUQXMDLXNyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bgjTP21YvzHrVM;
	Mon, 14 Jul 2025 21:14:33 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id AC1B11402C7;
	Mon, 14 Jul 2025 21:18:39 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:38 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 11/17] ext4: fix largest free orders lists corruption on mb_optimize_scan switch
Date: Mon, 14 Jul 2025 21:03:21 +0800
Message-ID: <20250714130327.1830534-12-libaokun1@huawei.com>
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

To fix this, whenever grp->bb_largest_free_order changes, we now always
attempt to remove the group from its old order list. However, we only
insert the group into the new order list if `mb_optimize_scan` is enabled.
This approach helps prevent lock inconsistencies and ensures the data in
the order lists remains reliable.

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
CC: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72b20fc52bbf..fada0d1b3fdb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1152,33 +1152,28 @@ static void
 mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int i;
+	int new, old = grp->bb_largest_free_order;
 
-	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
-		if (grp->bb_counters[i] > 0)
+	for (new = MB_NUM_ORDERS(sb) - 1; new >= 0; new--)
+		if (grp->bb_counters[new] > 0)
 			break;
+
 	/* No need to move between order lists? */
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
-	    i == grp->bb_largest_free_order) {
-		grp->bb_largest_free_order = i;
+	if (new == old)
 		return;
-	}
 
-	if (grp->bb_largest_free_order >= 0) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+	if (old >= 0 && !list_empty(&grp->bb_largest_free_order_node)) {
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
+	grp->bb_largest_free_order = new;
+	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && new >= 0 && grp->bb_free) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
 		list_add_tail(&grp->bb_largest_free_order_node,
-		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+			      &sbi->s_mb_largest_free_orders[new]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
 	}
 }
 
-- 
2.46.1


