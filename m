Return-Path: <linux-ext4+bounces-1398-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C2868BCC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325861C23811
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3052137C3A;
	Tue, 27 Feb 2024 09:10:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CA13666F;
	Tue, 27 Feb 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025013; cv=none; b=Mo9qaIWmO/MKf9ZpIU+MS7TSIkySh5XyL+PA2NvmhGL08JWqK6TWPSXWqsS/3VvqPrOuBHbgPetvtYNzpY6ToFpS4p5xxpvvU3vRlIPBmuUg7JXxiSW5vfMLw8TB1GBX4otr416QzX4T24PS+YqWL0zg4FUd37fSLS1VdoHvGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025013; c=relaxed/simple;
	bh=BJ+SdGuB6w4kyRcYaAM6fSSSXr9/B4LJCjV6jkx4HDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW2Yg4zBO+32GcIs8f529e6V/EKe/v4LGPfw7jNeUoHNsnAw6C7DJydYzin+1+RF/9Ur7a/HuBdQ7NwL92lbUujQSDNBVEutR8IujZhQOINuJNIvhFegJd1D6YzBH9kolq92DLhm26+D2uhvzBa+6GZnBiOhBPMp2RdRAG5QwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TkWq456cgzvW2N;
	Tue, 27 Feb 2024 17:08:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 813FA180073;
	Tue, 27 Feb 2024 17:10:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:08 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 5/9] ext4: add new attr pointer attr_mb_order
Date: Tue, 27 Feb 2024 17:11:44 +0800
Message-ID: <20240227091148.178435-6-libaokun1@huawei.com>
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

The s_mb_best_avail_max_trim_order is of type unsigned int, and has a
range of values well beyond the normal use of the mb_order. Although the
mballoc code is careful enough that large numbers don't matter there, but
this can mislead the sysadmin into thinking that it's normal to set such
values. Hence add a new attr_id attr_mb_order with values in the range
[0, 64] to avoid storing garbage values and make us more resilient to
surprises in the future.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index ddd71673176c..8e0473169458 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -30,6 +30,7 @@ typedef enum {
 	attr_first_error_time,
 	attr_last_error_time,
 	attr_clusters_in_group,
+	attr_mb_order,
 	attr_feature,
 	attr_pointer_ui,
 	attr_pointer_ul,
@@ -210,6 +211,8 @@ EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
 EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
 		 ext4_sb_info, s_mb_group_prealloc);
+EXT4_ATTR_OFFSET(mb_best_avail_max_trim_order, 0644, mb_order,
+		 ext4_sb_info, s_mb_best_avail_max_trim_order);
 EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
 EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
 EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
@@ -225,7 +228,6 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
-EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
@@ -379,6 +381,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
 	switch (a->attr_id) {
 	case attr_inode_readahead:
 	case attr_clusters_in_group:
+	case attr_mb_order:
 	case attr_pointer_ui:
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
 			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
@@ -458,6 +461,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
 		else
 			*((unsigned int *) ptr) = t;
 		return len;
+	case attr_mb_order:
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t > 64)
+			return -EINVAL;
+		*((unsigned int *) ptr) = t;
+		return len;
 	case attr_clusters_in_group:
 		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
-- 
2.31.1


