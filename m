Return-Path: <linux-ext4+bounces-1693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C187FCDD
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDAAB221A1
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C031680033;
	Tue, 19 Mar 2024 11:32:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708437FBDA;
	Tue, 19 Mar 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847942; cv=none; b=aIr5HVP4tb/ynGrovYQ5+uOmcWlz/Ri2MKTlZS6EzN67iM4ehOawjgYSSpuKvOVhbwu4L0ANe0MiiByi0zV/2R0Jm+8m3I6656Cg3qqBMVZYYNnqhMtPcPVp090OvDfV7SsmY2Juy6MUKazwHMxjDqpW8TP+9E3Ftd7hvluoZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847942; c=relaxed/simple;
	bh=PG8dxu2wmb6J4SvE44TEF7QKq15BiMIinNoTBc5u7gI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AclWtG8ipTC0n4SFSkQ5DpuMwvfonNxl34GqsfiU3y6ydOO38h8rHXE1cl72FLGNbF6nFn1D2Lxw2+3KOgsvTSRgRIwhDUYNJkyI6O8dYRxP1vGZUxpUcPGK9H0JlHAiEu5dkvPYdbzg7/xvJ2YDTEjsEZSaL04tC+lik3Flpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TzTz92F1jztQb4;
	Tue, 19 Mar 2024 19:29:57 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 40B3B18007B;
	Tue, 19 Mar 2024 19:32:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Mar
 2024 19:32:11 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 5/9] ext4: add new attr pointer attr_mb_order
Date: Tue, 19 Mar 2024 19:33:21 +0800
Message-ID: <20240319113325.3110393-6-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319113325.3110393-1-libaokun1@huawei.com>
References: <20240319113325.3110393-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


