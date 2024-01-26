Return-Path: <linux-ext4+bounces-925-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F383D63D
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17B31C224AC
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E92111C;
	Fri, 26 Jan 2024 08:54:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD401947E;
	Fri, 26 Jan 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259293; cv=none; b=SLdFeYoppOHTYqdEXO1/XcXg+hChSPJiLnHHxdrdXMBntImseQseDBjXcLna+bM40FK1vzD8pOjBtefi1eu2y1fjlTKpDdnyd15EBBMmXTxFpttmRrI6sn6P8w8UqBkoHgksyjRw5RI4yrx4cstQnpU8t3jEHF6ufwteAZdSaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259293; c=relaxed/simple;
	bh=TYOB8k5ylm5/BON07VvvhEpqCRaH6lb7Vlx10EFQvf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2IBcsN0KkD2bLwkhYXiRIx/0UIsV191qaIKpqTYMdqJ95ljkZDLZ3lyKhXStdnMeSPfcnoL0f+sM9MTxcZyP+5PJseom1vofBFOsN9VTKWNSDX+DKorNR9p/ff11VpjLbJt+60osnsPd47EpuhOJ9k3fs/nuz7fcIa34k6EBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLs192QmjzXgnM;
	Fri, 26 Jan 2024 16:53:33 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 84D5218001C;
	Fri, 26 Jan 2024 16:54:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:47 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 5/7] ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()
Date: Fri, 26 Jan 2024 16:57:14 +0800
Message-ID: <20240126085716.1363019-6-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126085716.1363019-1-libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

We can trigger a slab-out-of-bounds with the following commands:

    mkfs.ext4 -F /dev/$disk 10G
    mount /dev/$disk /tmp/test
    echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
    echo test > /tmp/test/file && sync

==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
Call Trace:
 dump_stack_lvl+0x2c/0x50
 kasan_report+0xb6/0xf0
 ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
 ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
 ext4_mb_new_blocks+0x88a/0x1370 [ext4]
 ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
 ext4_map_blocks+0x569/0xea0 [ext4]
 ext4_do_writepages+0x10f6/0x1bc0 [ext4]
[...]
==================================================================

The flow of issue triggering is as follows:

// Set s_mb_group_prealloc to 2147483647 via sysfs
ext4_mb_new_blocks
  ext4_mb_normalize_request
    ext4_mb_normalize_group_request
      ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
  ext4_mb_regular_allocator
    ext4_mb_choose_next_group
      ext4_mb_choose_next_group_best_avail
        mb_avg_fragment_size_order
          order = fls(len) - 2 = 29
        ext4_mb_find_good_group_avg_frag_lists
          frag_list = &sbi->s_mb_avg_fragment_size[order]
          if (list_empty(frag_list)) // Trigger SOOB!

At 4k block size, the length of the s_mb_avg_fragment_size list is 14, but
an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds to be
triggered by an attempt to access an element at index 29.

Therefore it is not allowed to set s_mb_group_prealloc to a value greater
than s_clusters_per_group via sysfs, and to avoid returning an order from
mb_avg_fragment_size_order() that is greater than MB_NUM_ORDERS(sb).

Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 2 ++
 fs/ext4/sysfs.c   | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f44f668e407f..1ea6491b6b00 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -832,6 +832,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
 		return 0;
 	if (order == MB_NUM_ORDERS(sb))
 		order--;
+	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
+		order = MB_NUM_ORDERS(sb) - 1;
 	return order;
 }
 
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6f9f96e00f2f..60ca7b2797b2 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -29,6 +29,7 @@ typedef enum {
 	attr_trigger_test_error,
 	attr_first_error_time,
 	attr_last_error_time,
+	attr_group_prealloc,
 	attr_feature,
 	attr_pointer_pi,
 	attr_pointer_ui,
@@ -211,13 +212,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
 
 EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
+EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, group_prealloc,
+		 ext4_sb_info, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
 EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
 EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
-EXT4_RW_ATTR_SBI_PI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
@@ -380,6 +382,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
 
 	switch (a->attr_id) {
 	case attr_inode_readahead:
+	case attr_group_prealloc:
 	case attr_pointer_pi:
 	case attr_pointer_ui:
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
@@ -453,6 +456,10 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
 		return ret;
 
 	switch (a->attr_id) {
+	case attr_group_prealloc:
+		if (t > sbi->s_clusters_per_group)
+			return -EINVAL;
+		fallthrough;
 	case attr_pointer_pi:
 		if ((int)t < 0)
 			return -EINVAL;
-- 
2.31.1


