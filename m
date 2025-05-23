Return-Path: <linux-ext4+bounces-8177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CAAC1F3C
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598E44E41A9
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51A2253B5;
	Fri, 23 May 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CE222582;
	Fri, 23 May 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990997; cv=none; b=aUgHAmfG5pygdQN2yEuO9/KQJzEDe+KRZtOmN3teqepaeULaUvirImBNLOs1TjsLNfBuWTL+DqsE1gRwWQIPpnJffN9Xl0O0FKviRfy0dRn7gSmv7Oaz85Qsn8ZBvcMt3gdj1vzWPJVmxYPr32gjSEHY92NbvNgVi+vsYpOLdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990997; c=relaxed/simple;
	bh=0Ei6K/vWbQWuglVPaCmuTBsOppFwqr1RCJb3YqV8Q7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uUmBGOSDctThfxxM0mKdOTnX1XvoZC+MRfXCClVRlVMpojoj1t5qHp6tzHNTJDp0cRRlOkmQsQk7yrtLgECAGonduid50a3zuFpV1WscrVVw3aLx1zGkQfSZU36BPXDXnef6MiQOKLMFIoe4ApNW4niRJLcAdDZT0xootfrBp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4b3fLs5cPwz4f3jdk;
	Fri, 23 May 2025 17:02:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFB401A07BB;
	Fri, 23 May 2025 17:03:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_MOTBocBILNQ--.27999S4;
	Fri, 23 May 2025 17:03:10 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 0/4] ext4: better scalability for ext4 block allocation
Date: Fri, 23 May 2025 16:58:17 +0800
Message-Id: <20250523085821.1329392-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_MOTBocBILNQ--.27999S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4ktr17CFy3WFy8Cw4fAFb_yoW5KF48p3
	sxtrnxJr1UJr48Xw43tw1UWr1rGw48Gr4UGr12gF18Xr1UAr4UKr40qry0yryUArWxXr15
	Xw17XryUGr1DCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWfzh3x0ewABsp

From: Baokun Li <libaokun1@huawei.com>

Since servers have more and more CPUs, and we're running more containers
on them, we've been using will-it-scale to test how well ext4 scales. The
fallocate2 test (append 8KB to 1MB, truncate to 0, repeat) run concurrently
on 64 containers revealed significant contention in block allocation/free,
leading to much lower aggregate fallocate OPS compared to a single
container (see below).

   1   |    2   |    4   |    8   |   16   |   32   |   64
-------|--------|--------|--------|--------|--------|-------
295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588

The main bottleneck was the ext4_lock_group(), which both block allocation
and free fought over. While the block group for block free is fixed and
unoptimizable, the block group for allocation is selectable. Consequently,
the ext4_try_lock_group() helper function was added to avoid contention on
busy groups, and you can see more in Patch 1.

After we fixed the ext4_lock_group bottleneck, another one showed up:
s_md_lock. This lock protects different data when allocating and freeing
blocks. We got rid of the s_md_lock call in block allocation by making
stream allocation work per inode instead of globally. You can find more
details in Patch 2.

Patches 3 and 4 are just some minor cleanups.

Performance test data follows:

CPU: HUAWEI Kunpeng 920
Memory: 480GB
Disk: 480GB SSD SATA 3.2
Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
Observation: Average fallocate operations per container per second.

|--------|--------|--------|--------|--------|--------|--------|--------|
|    -   |    1   |    2   |    4   |    8   |   16   |   32   |   64   |
|--------|--------|--------|--------|--------|--------|--------|--------|
|  base  | 295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588  |
|--------|--------|--------|--------|--------|--------|--------|--------|
| linear | 286328 | 123102 | 119542 | 90653  | 60344  | 35302  | 23280  |
|        | -3.0%  | 74.20% | 252.9% | 367.5% | 497.2% | 531.6% | 548.7% |
|--------|--------|--------|--------|--------|--------|--------|--------|
|mb_optim| 292498 | 133305 | 103069 | 61727  | 29702  | 16845  | 10430  |
|ize_scan| -0.9%  | 88.64% | 204.3% | 218.3% | 193.9% | 201.4% | 190.6% |
|--------|--------|--------|--------|--------|--------|--------|--------|

Running "kvm-xfstests -c ext4/all -g auto" showed that 1k/generic/347 often
fails. The test seems to think that a dm-thin device with a virtual size of
5000M but a real size of 500M, after being formatted as ext4, would have
500M free.

But it doesn't – we run out of space after making about 430 1M
files. Since the block size is 1k, making so many files turns on dir_index,
and dm-thin waits a minute, sees no free space, and then throws IO error.
This can cause a directory index block to fail to write and abort journal.

What's worse is that _dmthin_check_fs doesn't replay the journal, so fsck
finds inconsistencies and the test failed. I think the problem is with the
test itself, and I'll send a patch to fix it soon.

Comments and questions are, as always, welcome.

Thanks,
Baokun


Baokun Li (4):
  ext4: add ext4_try_lock_group() to skip busy groups
  ext4: move mb_last_[group|start] to ext4_inode_info
  ext4: get rid of some obsolete EXT4_MB_HINT flags
  ext4: fix typo in CR_GOAL_LEN_SLOW comment

 fs/ext4/ext4.h              | 38 ++++++++++++++++++-------------------
 fs/ext4/mballoc.c           | 34 +++++++++++++++++++--------------
 fs/ext4/super.c             |  2 ++
 include/trace/events/ext4.h |  3 ---
 4 files changed, 41 insertions(+), 36 deletions(-)

-- 
2.46.1


