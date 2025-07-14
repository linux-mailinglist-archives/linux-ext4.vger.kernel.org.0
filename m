Return-Path: <linux-ext4+bounces-8978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA386B03F87
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15E33A4F44
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F12505AF;
	Mon, 14 Jul 2025 13:18:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E71F7098;
	Mon, 14 Jul 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499116; cv=none; b=udMyHoEA7DdLrcUSE8PWyLeYBU4pMCJIg5XNZVa14/9fxUC9NJezilr1DfyeXgiEPUZzkP7c2XaMxtrHdW82sudHAjrFy0Q7ceDjJdkgG4XP6UTp0mJ8jKvLrjL2BAusiPnzDSR9rVsVRi5LUOr+wJzTOf7yH+up+6h5EZyUfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499116; c=relaxed/simple;
	bh=Cdd+9N9KlD//MJSEe52uoFJliR6Jnr1/asbx6nksI6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fG34Gb+7xVmTYF6YVtGDkGoj2DUusHcyRpDruKQssqZo2un6SS4OIyZL7IOx1s+TAI7kBDl+HHCHa13EH/xN9uX+9b4r6CjtNDlg7HY4NX74YLWJhHKkHK+qltDW6Nw3d5Zi0JUr9HAiRrGGBeOJqxNOvWZEB1j3dq9IDuvmS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgjSm2b0czXdym;
	Mon, 14 Jul 2025 21:14:00 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 74A2F180450;
	Mon, 14 Jul 2025 21:18:28 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:27 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 00/17] ext4: better scalability for ext4 block allocation
Date: Mon, 14 Jul 2025 21:03:10 +0800
Message-ID: <20250714130327.1830534-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Changes since v2:
 * Collect RVB from Jan Kara. (Thanks for your review!)
 * Add patch 2.
 * Patch 4: Switching to READ_ONCE/WRITE_ONCE (great for single-process)
        over smp_load_acquire/smp_store_release (only slight multi-process
        gain). (Suggested by Jan Kara)
 * Patch 5: The number of global goals is now set to the lesser of the CPU
        count or one-fourth of the group count. This prevents setting too
        many goals for small filesystems, which lead to file dispersion.
        (Suggested by Jan Kara)
 * Patch 5: Directly use kfree() to release s_mb_last_groups instead of
        kvfree(). (Suggested by Julia Lawall)
 * Patch 11: Even without mb_optimize_scan enabled, we now always attempt
        to remove the group from the old order list.(Suggested by Jan Kara)
 * Patch 14-16: Added comments for clarity, refined logic, and removed
        obsolete variables.
 * Update performance test results and indicate raw disk write bandwidth. 

Thanks to Honza for your suggestions!

v2: https://lore.kernel.org/r/20250623073304.3275702-1-libaokun1@huawei.com

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
leading to much lower average fallocate OPS compared to a single
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

Patch 2: Separates stream goal hits from s_bal_goals in preparation for
cleanup of s_mb_last_start.

Patches 3-5: Split stream allocation's global goal into multiple goals and
remove the unnecessary and expensive s_md_lock.

Patches 6-7: minor cleanups

Patches 8: Converted s_mb_free_pending to atomic_t and used memory barriers
for consistency, instead of relying on the expensive s_md_lock.

Patches 9: When inserting free extents, we now attempt to merge them with
already inserted extents first, to reduce s_md_lock contention.

Patches 10: Updates bb_avg_fragment_size_order to -1 when a group is out of
free blocks, eliminating efficiency-impacting "zombie groups."

Patches 11: Fix potential largest free orders lists corruption when the
mb_optimize_scan mount option is switched on or off.

Patches 12-17: Convert mb_optimize_scan's existing unordered list traversal
to ordered xarrays, thereby reducing contention between block allocation
and freeing, similar to linear traversal.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

Here are some performance test data for your reference:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 2667  | 20049 (+651%)  | 314065 | 316724 (+0.8%) |
|mb_optimize_scan=1 | 2643  | 19342 (+631%)  | 316344 | 328324 (+3.7%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 3450  | 52125 (+1410%) | 205851 | 215136 (+4.5%) |
|mb_optimize_scan=1 | 3209  | 50331 (+1468%) | 207373 | 209431 (+0.9%) |

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

Baokun Li (17):
  ext4: add ext4_try_lock_group() to skip busy groups
  ext4: separate stream goal hits from s_bal_goals for better tracking
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
  ext4: convert free groups order lists to xarrays
  ext4: refactor choose group to scan group
  ext4: implement linear-like traversal across order xarrays

 fs/ext4/balloc.c            |   2 +-
 fs/ext4/ext4.h              |  61 +--
 fs/ext4/mballoc.c           | 895 ++++++++++++++++++++----------------
 fs/ext4/mballoc.h           |   9 +-
 include/trace/events/ext4.h |   3 -
 5 files changed, 534 insertions(+), 436 deletions(-)

-- 
2.46.1


