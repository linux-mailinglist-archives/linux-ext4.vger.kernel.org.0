Return-Path: <linux-ext4+bounces-1396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B4868BC7
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DF41F219EB
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901D1369AC;
	Tue, 27 Feb 2024 09:10:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF702130E48;
	Tue, 27 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025013; cv=none; b=sfEp/1IEHzyrdOv9OVOQz6b0PRG0F924QMpSmWoTxHM8crz5IlMGU+7ePPetTFZn/GN2smr3nkRBHIVvDUGseoblodkNLTjdbPrS7TbNv6Vm+p64zSR06DNRNT9PouDiHYyYsfKf4ChsgDW8bK++m+YLhcmHTjgLkEgw1OjUirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025013; c=relaxed/simple;
	bh=Izaw3Az6TVbjYFt+xV9EKhN5IONbtN7RxO79bw8zW0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT2YwnC2c8p+jBxMrMbIV3+PjYkiiUMCLM/QgZZqyA3ZzrvBrhQyd/zTBT1LO6xN8Z4qIMUmtzvkAFXa+u7//dZ1O3c7d+Guf7r0UYQGewg5rXeQH07ftWYhp4CMF2WBncHlwBTA1KkjcXNK+3EXlqkBS8tX1QmIj78JBMIQ0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TkWqT4bmzzpStH;
	Tue, 27 Feb 2024 17:08:21 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id F146818009E;
	Tue, 27 Feb 2024 17:10:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:08 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 4/9] ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()
Date: Tue, 27 Feb 2024 17:11:43 +0800
Message-ID: <20240227091148.178435-5-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240227091148.178435-1-libaokun1@huawei.com>
References: <20240227091148.178435-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
to be triggered by an attempt to access an element at index 29.

Add a new attr_id attr_clusters_in_group with values in the range
[0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
that type to fix the issue. In addition avoid returning an order
from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
and reduce some useless loops.

Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c |  6 ++++++
 fs/ext4/sysfs.c   | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 85a91a61b761..7ad089df2408 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
 		return 0;
 	if (order == MB_NUM_ORDERS(sb))
 		order--;
+	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
+		order = MB_NUM_ORDERS(sb) - 1;
 	return order;
 }
 
@@ -1057,6 +1059,10 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
 			return;
 		}
+
+		/* Skip some unnecessary loops. */
+		if (unlikely(i > MB_NUM_ORDERS(ac->ac_sb)))
+			i = MB_NUM_ORDERS(ac->ac_sb);
 	}
 
 	/* Reset goal length to original goal length before falling into CR_GOAL_LEN_SLOW */
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 7f455b5f22c0..ddd71673176c 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -29,6 +29,7 @@ typedef enum {
 	attr_trigger_test_error,
 	attr_first_error_time,
 	attr_last_error_time,
+	attr_clusters_in_group,
 	attr_feature,
 	attr_pointer_ui,
 	attr_pointer_ul,
@@ -207,13 +208,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
 
 EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
+EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
+		 ext4_sb_info, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
 EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
 EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
-EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
@@ -376,6 +378,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
 
 	switch (a->attr_id) {
 	case attr_inode_readahead:
+	case attr_clusters_in_group:
 	case attr_pointer_ui:
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
 			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
@@ -455,6 +458,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
 		else
 			*((unsigned int *) ptr) = t;
 		return len;
+	case attr_clusters_in_group:
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t > sbi->s_clusters_per_group)
+			return -EINVAL;
+		*((unsigned int *) ptr) = t;
+		return len;
 	case attr_pointer_ul:
 		ret = kstrtoul(skip_spaces(buf), 0, &lt);
 		if (ret)
-- 
2.31.1


