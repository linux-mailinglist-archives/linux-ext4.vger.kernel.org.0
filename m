Return-Path: <linux-ext4+bounces-8587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E79AE3748
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C941893DA1
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D120DD52;
	Mon, 23 Jun 2025 07:47:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9FB663;
	Mon, 23 Jun 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664822; cv=none; b=RAilhNhSE37V58AqMHeyHb4E0S1VohBlSp06N9fJ3AOoky2YtApn9YnPCZ4acJEP2jLx6XUosQMEM1VH5NE4MU6OeQ/IWEk3hmc0JKcCDtwOsjKTOPtLIQSj4CfRDQWfLb+8FRSxNgSyRfiXrq0e+yJRzaHTKStGe0xiqyFuyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664822; c=relaxed/simple;
	bh=KzMNTELuuskW0uCA7SkqERTlbKozlKZvL7dBzfTUAAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fzk6X8fan19UqzmHBTWbN5/MrDzIT7RSzHopIl4MWIDfj6jYxKoewNNP/b7dvFXZEBGHekZlrrqM4tw9IQVAUEvwhFb7tuqPDVnyiQIFkZJrXF+VgewWAUZeIqOR0nOBjZS9xPY/bDdxD8eEq/k72p9qELmXxv6KnK0NmJAaiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bQg6T6CRMzPtBv;
	Mon, 23 Jun 2025 15:42:57 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B207014027D;
	Mon, 23 Jun 2025 15:46:54 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:53 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 00/16] ext4: better scalability for ext4 block allocation
Date: Mon, 23 Jun 2025 15:32:48 +0800
Message-ID: <20250623073304.3275702-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Changes since v1:
 * Patch 1: Prioritize checking if a group is busy to avoid unnecessary
       checks and buddy loading. (Thanks to Ojaswin for the suggestion!)
 * Patch 4: Using multiple global goals instead of moving the goal to the
       inode level. (Thanks to Honza for the suggestion!)
 * Collect RVB from Jan Kara and Ojaswin Mujoo.(Thanks for your review!)
 * Add patch 2,3,7-16.
 * Due to the change of test server, the relevant test data was refreshed.

v1: https://lore.kernel.org/r/20250523085821.1329392-1-libaokun@huaweicloud.com

Since servers have more and more CPUs, and we're running more containers
on them, we've been using will-it-scale to test how well ext4 scales. The
fallocate2 test (append 8KB to 1MB, truncate to 0, repeat) run concurrently
on 64 containers revealed significant contention in block allocation/free,
leading to much lower aggregate fallocate OPS compared to a single
container (see below).

   1   |    2   |    4   |    8   |   16   |   32   |   64
-------|--------|--------|--------|--------|--------|-------
295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588

Under this test scenario, the primary operations are block allocation
(fallocate) and block deallocation (truncate). The main bottlenecks for
these operations are the group lock and s_md_lock. Therefore, this patch
series primarily focuses on optimizing the code related to these two locks.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1: Add ext4_try_lock_group() to skip busy groups to take advantage
of the large number of ext4 groups.

Patches 2-4: Split stream allocation's global goal into multiple goals and
protect them with memory barriers instead of the expensive s_md_lock.

Patches 5-6: minor cleanups

Patches 7: Converted s_mb_free_pending to atomic_t and used memory barriers
for consistency, instead of relying on the expensive s_md_lock.

Patches 8: When inserting free extents, we now attempt to merge them with
already inserted extents first, to reduce s_md_lock contention.

Patches 9: Updates bb_avg_fragment_size_order to -1 when a group is out of
free blocks, eliminating efficiency-impacting "zombie groups."

Patches 10: Fix potential largest free orders lists corruption when the
mb_optimize_scan mount option is switched on or off.

Patches 11-16: Convert mb_optimize_scan's existing unordered list traversal
to an ordered xarray, thereby reducing contention between block allocation
and freeing, similar to linear traversal.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

Here are some performance test data for your reference:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

CPU: Kunpeng 920   |          P80            |            P1           |
Memory: 512GB      |-------------------------|-------------------------|
Disk: 960GB SSD    | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 2667  | 20619  (+673.1%)| 314065| 299238 (-4.7%)  |
mb_optimize_scan=1 | 2643  | 20119  (+661.2%)| 316344| 315268 (-0.3%)  |

CPU: AMD 9654 * 2  |          P96            |            P1           |
Memory: 1536GB     |-------------------------|-------------------------|
Disk: 960GB SSD    | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 3450  | 51983 (+1406.7%)| 205851| 207033 (+0.5%)  |
mb_optimize_scan=1 | 3209  | 48486 (+1410.9%)| 207373| 202415 (-2.3%)  |

Tests also evaluated this patch set's impact on fragmentation: a minor
increase in free space fragmentation for multi-process workloads, but a
significant decrease in file fragmentation:

Test Script：
```shell
#!/bin/bash

dir="/tmp/test"
disk="/dev/sda"

mkdir -p $dir

for scan in 0 1 ; do
    mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0 \
              -O orphan_file $disk 200G
    mount -o mb_optimize_scan=$scan $disk $dir

    fio -directory=$dir -direct=1 -iodepth 128 -thread -ioengine=falloc \
        -rw=write -bs=4k -fallocate=none -numjobs=64 -file_append=1 \
        -size=1G -group_reporting -name=job1 -cpus_allowed_policy=split

    e2freefrag $disk
    e4defrag -c $dir # Without the patch, this could take 5-6 hours.
    filefrag ${dir}/job* | awk '{print $2}' | \
                           awk '{sum+=$1} END {print sum/NR}'
    umount $dir
done
```

Test results:
-------------------------------------------------------------|
                         |       base      |      patched    |
-------------------------|--------|--------|--------|--------|
mb_optimize_scan         | linear |opt_scan| linear |opt_scan|
-------------------------|--------|--------|--------|--------|
bw(MiB/s)                | 217    | 217    | 5718   | 5626   |
-------------------------|-----------------------------------|
Avg. free extent size(KB)| 1943732| 1943732| 1316212| 1171208|
Num. free extent         | 71     | 71     | 105    | 118    |
-------------------------------------------------------------|
Avg. extents per file    | 261967 | 261973 | 588    | 570    |
Avg. size per extent(KB) | 4      | 4      | 1780   | 1837   |
Fragmentation score      | 100    | 100    | 2      | 2      |
-------------------------------------------------------------| 

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (16):
  ext4: add ext4_try_lock_group() to skip busy groups
  ext4: remove unnecessary s_mb_last_start
  ext4: remove unnecessary s_md_lock on update s_mb_last_group
  ext4: utilize multiple global goals to reduce contention
  ext4: get rid of some obsolete EXT4_MB_HINT flags
  ext4: fix typo in CR_GOAL_LEN_SLOW comment
  ext4: convert sbi->s_mb_free_pending to atomic_t
  ext4: merge freed extent with existing extents before insertion
  ext4: fix zombie groups in average fragment size lists
  ext4: fix largest free orders lists corruption on mb_optimize_scan
    switch
  ext4: factor out __ext4_mb_scan_group()
  ext4: factor out ext4_mb_might_prefetch()
  ext4: factor out ext4_mb_scan_group()
  ext4: convert free group lists to ordered xarrays
  ext4: refactor choose group to scan group
  ext4: ensure global ordered traversal across all free groups xarrays

 fs/ext4/balloc.c            |   2 +-
 fs/ext4/ext4.h              |  45 +-
 fs/ext4/mballoc.c           | 898 +++++++++++++++++++++---------------
 fs/ext4/mballoc.h           |  18 +-
 include/trace/events/ext4.h |   3 -
 5 files changed, 553 insertions(+), 413 deletions(-)

-- 
2.46.1


