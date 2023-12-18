Return-Path: <linux-ext4+bounces-491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B187181733F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539C7B24577
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6F3A1D0;
	Mon, 18 Dec 2023 14:14:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4E3A1A9;
	Mon, 18 Dec 2023 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sv1zg1CjNzMnxK;
	Mon, 18 Dec 2023 22:14:39 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F89014040D;
	Mon, 18 Dec 2023 22:14:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Dec
 2023 22:14:51 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/4] ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
Date: Mon, 18 Dec 2023 22:18:13 +0800
Message-ID: <20231218141814.1477338-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231218141814.1477338-1-libaokun1@huawei.com>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

After updating bb_free in mb_free_blocks, it is possible to return without
updating bb_fragments because the block being freed is found to have
already been freed, which leads to inconsistency between bb_free and
bb_fragments.

Since the group may be unlocked in ext4_grp_locked_error(), this can lead
to problems such as dividing by zero when calculating the average fragment
length. Therefore, to ensure consistency, move the update of bb_free to
after the block double-free check.

Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
CC: stable@vger.kernel.org # 3.10
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a95fa6e2b0f9..2fbee0f0f5c3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1892,11 +1892,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	mb_check_buddy(e4b);
 	mb_free_blocks_double(inode, e4b, first, count);
 
-	this_cpu_inc(discard_pa_seq);
-	e4b->bd_info->bb_free += count;
-	if (first < e4b->bd_info->bb_first_free)
-		e4b->bd_info->bb_first_free = first;
-
 	/* access memory sequentially: check left neighbour,
 	 * clear range and then check right neighbour
 	 */
@@ -1922,9 +1917,14 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		}
-		goto done;
+		return;
 	}
 
+	this_cpu_inc(discard_pa_seq);
+	e4b->bd_info->bb_free += count;
+	if (first < e4b->bd_info->bb_first_free)
+		e4b->bd_info->bb_first_free = first;
+
 	/* let's maintain fragments counter */
 	if (left_is_free && right_is_free)
 		e4b->bd_info->bb_fragments--;
@@ -1949,7 +1949,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	if (first <= last)
 		mb_buddy_mark_free(e4b, first >> 1, last >> 1);
 
-done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
 	mb_update_avg_fragment_size(sb, e4b->bd_info);
 	mb_check_buddy(e4b);
-- 
2.31.1


