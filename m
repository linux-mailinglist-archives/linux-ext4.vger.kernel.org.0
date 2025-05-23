Return-Path: <linux-ext4+bounces-8181-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B659AC1F3D
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9403A8179
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD8B227BA4;
	Fri, 23 May 2025 09:03:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF388223702;
	Fri, 23 May 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990998; cv=none; b=jUMLhdkCLmim3/TbQjm+ADi9YTP2/1N22/0bsC+BnibC8IribFSih/BmydxNTLSAZ2i74zFXHqSnuvQkjF7+mYQ9EHoQYIkgtVeI++4uh4V9w/VcIoXKIUUg5UQDEka14eqNfXYpRmjmeobNgANMMtsGcYn30rI+Ee3pgmkBy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990998; c=relaxed/simple;
	bh=J3SxiOMpPZbohVP3HSSPnrrxas0MoAU8ASSoVi9x3+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkZOX6CaviON03RT9qmnEvPYZ8Ep8y5+4T4jwq05U6LZ73XJwtOMRqIIhRA12sP+t94RzvpfzZMVQg0gMqnpfqB2A6ta/4xMuT97dvo98FkohIYBEkFjaVse9xLeR3boJH64KWjXfOc03PUorkQ7i5XvGAXHtNxsbwySGFad7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b3fLz2cvnz4f3jt8;
	Fri, 23 May 2025 17:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D2A01A018D;
	Fri, 23 May 2025 17:03:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_MOTBocBILNQ--.27999S5;
	Fri, 23 May 2025 17:03:11 +0800 (CST)
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
Subject: [PATCH 1/4] ext4: add ext4_try_lock_group() to skip busy groups
Date: Fri, 23 May 2025 16:58:18 +0800
Message-Id: <20250523085821.1329392-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250523085821.1329392-1-libaokun@huaweicloud.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_MOTBocBILNQ--.27999S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWDWr1UZry5WrW3XryUGFg_yoW7GryUpw
	srZ3Z8Ar45Wwn8uws7G3y0qw4Fkw40gFWUJrWfuw17Zry3Xrna9as7tF17AF9FgFs3JFnx
	X3Wav3y7Cr13u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUegAzUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgARBWgwLIYF3AAAs9

From: Baokun Li <libaokun1@huawei.com>

When ext4 allocates blocks, we used to just go through the block groups
one by one to find a good one. But when there are tons of block groups
(like hundreds of thousands or even millions) and not many have free space
(meaning they're mostly full), it takes a really long time to check them
all, and performance gets bad. So, we added the "mb_optimize_scan" mount
option (which is on by default now). It keeps track of some group lists,
so when we need a free block, we can just grab a likely group from the
right list. This saves time and makes block allocation much faster.

But when multiple processes or containers are doing similar things, like
constantly allocating 8k blocks, they all try to use the same block group
in the same list. Even just two processes doing this can cut the IOPS in
half. For example, one container might do 300,000 IOPS, but if you run two
at the same time, the total is only 150,000.

Since we can already look at block groups in a non-linear way, the first
and last groups in the same list are basically the same for finding a block
right now. Therefore, add an ext4_try_lock_group() helper function to skip
the current group when it is locked by another process, thereby avoiding
contention with other processes. This helps ext4 make better use of having
multiple block groups.

Also, to make sure we don't skip all the groups that have free space
when allocating blocks, we won't try to skip busy groups anymore when
ac_criteria is CR_ANY_FREE.

Performance test data follows:

CPU: HUAWEI Kunpeng 920
Memory: 480GB
Disk: 480GB SSD SATA 3.2
Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
Observation: Average fallocate operations per container per second.

                      base    patched
mb_optimize_scan=0    3588    6755 (+88.2%)
mb_optimize_scan=1    3588    4302 (+19.8%)

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    | 23 ++++++++++++++---------
 fs/ext4/mballoc.c | 14 +++++++++++---
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..9c665a620a46 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3494,23 +3494,28 @@ static inline int ext4_fs_is_busy(struct ext4_sb_info *sbi)
 	return (atomic_read(&sbi->s_lock_busy) > EXT4_CONTENTION_THRESHOLD);
 }
 
+static inline bool ext4_try_lock_group(struct super_block *sb, ext4_group_t group)
+{
+	if (!spin_trylock(ext4_group_lock_ptr(sb, group)))
+		return false;
+	/*
+	 * We're able to grab the lock right away, so drop the lock
+	 * contention counter.
+	 */
+	atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
+	return true;
+}
+
 static inline void ext4_lock_group(struct super_block *sb, ext4_group_t group)
 {
-	spinlock_t *lock = ext4_group_lock_ptr(sb, group);
-	if (spin_trylock(lock))
-		/*
-		 * We're able to grab the lock right away, so drop the
-		 * lock contention counter.
-		 */
-		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
-	else {
+	if (!ext4_try_lock_group(sb, group)) {
 		/*
 		 * The lock is busy, so bump the contention counter,
 		 * and then wait on the spin lock.
 		 */
 		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, 1,
 				  EXT4_MAX_CONTENTION);
-		spin_lock(lock);
+		spin_lock(ext4_group_lock_ptr(sb, group));
 	}
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e98c5be4e0a..5c13d9f8a1cc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -896,7 +896,8 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
 				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
+			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED)) &&
+			    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
 				*group = iter->bb_group;
 				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
 				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
@@ -932,7 +933,8 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
 	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
 		if (sbi->s_mb_stats)
 			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
-		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
+		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr)) &&
+		    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
 			grp = iter;
 			break;
 		}
@@ -2911,7 +2913,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (err)
 				goto out;
 
-			ext4_lock_group(sb, group);
+			/* skip busy group */
+			if (cr >= CR_ANY_FREE) {
+				ext4_lock_group(sb, group);
+			} else if (!ext4_try_lock_group(sb, group)) {
+				ext4_mb_unload_buddy(&e4b);
+				continue;
+			}
 
 			/*
 			 * We need to check again after locking the
-- 
2.46.1


