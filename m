Return-Path: <linux-ext4+bounces-1690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004E87FCD6
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 12:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F711B217D9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBA7F499;
	Tue, 19 Mar 2024 11:32:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F7BAFB;
	Tue, 19 Mar 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847936; cv=none; b=mbVi6tm+Hd9UX74Y0D1xN+lg4mXCpORD6WUK5DArOf9NKIWDtvMfTf65Bv11Sjq287tDtON0bVH2/LJMsyR4ftTNw371pdOCYM+/t4Gztvx4/LtAfdkhkIo23cM/RWhamb72lMlCM7WVy3IyqJMQf7WXIyx/xSsqD3mmZZWwLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847936; c=relaxed/simple;
	bh=lX/L+qHXceflKWpS2knqkqT/7LPdILfgwV7UhnUJ9Z8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GC0CeFIE+LIEcikgqPb3QzwuebrM3XzgHSyt0o7qxuolU0xj05E/6dPCGhcnLE7u+Ha8M+JdiIpwXjDegn++8H5i3fxzqszKRWp7UijVd9f3wqxBtwcGb3nJvDqWCXU8bsHkVkA8eDNFekRRZSjDKVpPS3PVeKhf2bSvjrwf/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzTyn0cV6z1h2xl;
	Tue, 19 Mar 2024 19:29:37 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 769DC140124;
	Tue, 19 Mar 2024 19:32:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Mar
 2024 19:32:08 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing BUG_ON/SOOB
Date: Tue, 19 Mar 2024 19:33:16 +0800
Message-ID: <20240319113325.3110393-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Hello everyone,

This patchset is intended to avoid variables that can be modified via sysfs
from overflowing when stored or used and thus causing various problems.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

V3->V4:
  Patch 4: Corrects WARN_ON_ONCE added in V3.

V2->V3:
  Add Reviewed-by tag from Jan Kara.
  Patch 4: Trimming order before the for loop makes the logic easier to
           understand.

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
[V2]: https://lore.kernel.org/all/20240227091148.178435-1-libaokun1@huawei.com/
[V3]: https://lore.kernel.org/all/20240314140906.3064072-1-libaokun1@huawei.com/

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
 fs/ext4/mballoc.c |   5 +-
 fs/ext4/mballoc.h |   2 +-
 fs/ext4/sysfs.c   | 174 ++++++++++++++++++++++++++++------------------
 4 files changed, 112 insertions(+), 72 deletions(-)

-- 
2.31.1


