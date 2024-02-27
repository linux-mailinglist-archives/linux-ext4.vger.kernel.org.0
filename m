Return-Path: <linux-ext4+bounces-1395-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D35868BC6
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F742284649
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AF13699E;
	Tue, 27 Feb 2024 09:10:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB9136667;
	Tue, 27 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025012; cv=none; b=hkmKvM9amaT3XJXDU4f5riKOEadpddoiOt/4RunKnzsU+zKyqy9BmcDWIX1nNnU3XBmoBqUPvxonYf7L622TRov2ntUdVMp7Lxx2oI7fOQg+N5lZWVHJEI9NZPMOFPZCyYHnxmlVsnwq+r7GLPMyZRufyl0dzNJojk3qc1amdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025012; c=relaxed/simple;
	bh=cZ+XTunPaB9DFMt5pkmdrXeMidg2e5JBHgUaRVeuS4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cXyeiFr8MVQN0MFsdWAQ50KxvJEg6xzNNZnKDX2KMcgKGtq11WTAH+zq4LaBF2jQWi+6qS4514XRg4cXI+78nrF3NlRcRtMWiq8x1WfY265YFe/vJDK9jNgpmsv1+y0DR/wydgPolPkRXfa6S7SFsf1HnJgFNrPVsVykdnFmv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TkWq16GGlzvW3q;
	Tue, 27 Feb 2024 17:07:57 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id AA863180073;
	Tue, 27 Feb 2024 17:10:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:06 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 0/9] ext4: avoid sysfs variables overflow causing BUG_ON/SOOB
Date: Tue, 27 Feb 2024 17:11:39 +0800
Message-ID: <20240227091148.178435-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Hello everyone,

This patchset is intended to avoid variables that can be modified via sysfs
from overflowing when stored or used and thus causing various problems.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

V1->V2:
  Patch 1: Use kstrtouint() as suggested by Alexey and Honza.
  Patch 2: Adapted to patch 1 changes.
  Patch 3: Add Reviewed-by tag.
  Patch 4: Avoid useless loops as suggested by Ojaswin and rename
	   attr_group_prealloc to attr_clusters_in_group.
  Patch 5: New patch added to limit mb_best_avail_max_trim_order < 64
	   as Honza's suggestion. 
  Patch 6: Reordered and updated description.
  Patch 7: Add Reviewed-by tag.
  Patch 8: Keep unrelated variables on different lines as suggested by Honza.
  Patch 9: New patch to fix warnings found during compile checking.

[V1]: https://lore.kernel.org/all/20240126085716.1363019-1-libaokun1@huawei.com/

Baokun Li (9):
  ext4: avoid overflow when setting values via sysfs
  ext4: refactor out ext4_generic_attr_store()
  ext4: refactor out ext4_generic_attr_show()
  ext4: fix slab-out-of-bounds in
    ext4_mb_find_good_group_avg_frag_lists()
  ext4: add new attr pointer attr_mb_order
  ext4: add positive int attr pointer to avoid sysfs variables overflow
  ext4: set type of ac_groups_linear_remaining to __u32 to avoid
    overflow
  ext4: set the type of max_zeroout to unsigned int to avoid overflow
  ext4: clean up s_mb_rb_lock to fix build warnings with C=1

 fs/ext4/extents.c |   3 +-
 fs/ext4/mballoc.c |   7 +-
 fs/ext4/mballoc.h |   2 +-
 fs/ext4/sysfs.c   | 174 ++++++++++++++++++++++++++++------------------
 4 files changed, 114 insertions(+), 72 deletions(-)

-- 
2.31.1


