Return-Path: <linux-ext4+bounces-8179-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDEAC1F38
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686D73B2957
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB97225776;
	Fri, 23 May 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127A2222B8;
	Fri, 23 May 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990997; cv=none; b=Rio+VHv6azMWTcDosFEcnLf3fqTANbx+T6ik6nFwVkL9/Dg7BE5X0qh+FuiBU9ztS7coefwYk0n03dHScyb+j3pa5/7Y8vCIvNUUGCMBvPhXDKLIVPRg9wdmP0Bp3HyQSe9c/c5FlWJsXFPG/P4OSdoae3itcOE79zNGbHuNGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990997; c=relaxed/simple;
	bh=g/oPaA6mtIU5FilTVbMzKUiYTPHj4nBFEkgpOFOKyLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+ici4JV1Gfm1yAaKQ5XFteppueiIn6u2Mo998eBhwQwqaktBsbiLtiLAFyDunIbsuAjfhVbMoIjNoPOKpOruch8ZMkGZgNJhJU9VWobzFZIkgyzAsfoWc5xlg4dSQRG496jVQxLz5TCazwRtI89zyiOpKRV1IAxHxn3unEKC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4b3fLt4JRFz4f3jYG;
	Fri, 23 May 2025 17:02:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0E2E1A0A43;
	Fri, 23 May 2025 17:03:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_MOTBocBILNQ--.27999S6;
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
Subject: [PATCH 2/4] ext4: move mb_last_[group|start] to ext4_inode_info
Date: Fri, 23 May 2025 16:58:19 +0800
Message-Id: <20250523085821.1329392-3-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCH61_MOTBocBILNQ--.27999S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy5ur45uF1xJw43JFykGrg_yoW7Ary7pr
	s7G3WrJF4rXw18uw4kW3yDWr1rKa1xGFWUJr1Sgw1jvry3XFySg3ZrtF18ZF97ArZ3ZF1Y
	vryjya1UCr47Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjfU1lkVUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWgwLIEFawAAsO

From: Baokun Li <libaokun1@huawei.com>

After we optimized the block group lock, we found another lock
contention issue when running will-it-scale/fallocate2 with multiple
processes. The fallocate's block allocation and the truncate's block
release were fighting over the s_md_lock. The problem is, this lock
protects totally different things in those two processes: the list of
freed data blocks (s_freed_data_list) when releasing, and where to start
looking for new blocks (mb_last_[group|start]) when allocating.

Moreover, when allocating data blocks, if the first try (goal allocation)
fails and stream allocation is on, it tries a global goal starting from
the last group we used (s_mb_last_group). This can make things faster by
writing blocks close together on the disk. But when many processes are
allocating, they all fight over s_md_lock and might even try to use the
same group. This makes it harder to merge extents and can make files more
fragmented. If different processes allocate chunks of very different sizes,
the free space on the disk can also get fragmented. A small allocation
might fit in a partially full group, but a big allocation might have
skipped it, leading to the small IO ending up in a more empty group.

So, we're changing stream allocation to work per inode. First, it tries
the goal, then the last group where that inode successfully allocated a
block. This keeps an inode's data closer together. Plus, after moving
mb_last_[group|start] to ext4_inode_info, we don't need s_md_lock during
block allocation anymore because we already have the write lock on
i_data_sem. This gets rid of the contention between allocating and
releasing blocks, which gives a huge performance boost to fallocate2.

Performance test data follows:

CPU: HUAWEI Kunpeng 920
Memory: 480GB
Disk: 480GB SSD SATA 3.2
Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
Observation: Average fallocate operations per container per second.

                      base     patched
mb_optimize_scan=0    6755     23280 (+244.6%)
mb_optimize_scan=1    4302     10430 (+142.4%)

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  7 ++++---
 fs/ext4/mballoc.c | 20 +++++++++-----------
 fs/ext4/super.c   |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9c665a620a46..16c14dd09df6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1171,6 +1171,10 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+	/* where last allocation was done - for stream allocation */
+	ext4_group_t i_mb_last_group;
+	ext4_grpblk_t i_mb_last_start;
 };
 
 /*
@@ -1603,9 +1607,6 @@ struct ext4_sb_info {
 	unsigned int s_mb_order2_reqs;
 	unsigned int s_mb_group_prealloc;
 	unsigned int s_max_dir_size_kb;
-	/* where last allocation was done - for stream allocation */
-	unsigned long s_mb_last_group;
-	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5c13d9f8a1cc..ee9696f9bac8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2138,7 +2138,6 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 					struct ext4_buddy *e4b)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	int ret;
 
 	BUG_ON(ac->ac_b_ex.fe_group != e4b->bd_group);
@@ -2169,10 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		spin_lock(&sbi->s_md_lock);
-		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
-		spin_unlock(&sbi->s_md_lock);
+		EXT4_I(ac->ac_inode)->i_mb_last_group = ac->ac_f_ex.fe_group;
+		EXT4_I(ac->ac_inode)->i_mb_last_start = ac->ac_f_ex.fe_start;
 	}
 	/*
 	 * As we've just preallocated more space than
@@ -2844,13 +2841,14 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 							   MB_NUM_ORDERS(sb));
 	}
 
-	/* if stream allocation is enabled, use global goal */
+	/* if stream allocation is enabled, use last goal */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
-		/* TBD: may be hot point */
-		spin_lock(&sbi->s_md_lock);
-		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
-		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
-		spin_unlock(&sbi->s_md_lock);
+		struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+
+		if (ei->i_mb_last_group || ei->i_mb_last_start) {
+			ac->ac_g_ex.fe_group = ei->i_mb_last_group;
+			ac->ac_g_ex.fe_start = ei->i_mb_last_start;
+		}
 	}
 
 	/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..6c49c43bb2cb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1416,6 +1416,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
+	ei->i_mb_last_group = 0;
+	ei->i_mb_last_start = 0;
 	return &ei->vfs_inode;
 }
 
-- 
2.46.1


