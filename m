Return-Path: <linux-ext4+bounces-8979-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C809B03F86
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55EF17312D
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76E2517B9;
	Mon, 14 Jul 2025 13:18:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E6248F5C;
	Mon, 14 Jul 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499116; cv=none; b=kY93+OkIu8+sdBYGFOexyzF9INGpmaHdeIJWJ3FY2V2H5MgP21HCQF08hX6NsWigxb9FZ8SyPWnh4e6ObqxZFt6apHw9EKHVcQ8BdRrX4w6DUB30U6ov1YTiOu2IhLIHZ2d+6oucX97vVFMe79G+HGQ2DxzlB7wZ6akuV42O5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499116; c=relaxed/simple;
	bh=s4gNMvY9cZOwDGjkUhM/jI1sppzTPno8BNjqtEuLb5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAx2CKul2LSMeWgZzSaH0DtqXDaPttndbqCXBFV0pg/eHsucrFEcnNFGk7dZy2Ms1LDxF/qWGSNZL6uZHV8oJzop1LSLAq8now3uhaeFCQm8D3tLIouDTzWXuhVOG0CvPZk9gMi9Rg8BVbcAqQOjpNxZMsW5mBC4biFgJs72VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjVm6SVXz13Mnb;
	Mon, 14 Jul 2025 21:15:44 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 69D6014011A;
	Mon, 14 Jul 2025 21:18:30 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:29 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 02/17] ext4: separate stream goal hits from s_bal_goals for better tracking
Date: Mon, 14 Jul 2025 21:03:12 +0800
Message-ID: <20250714130327.1830534-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

In ext4_mb_regular_allocator(), after the call to ext4_mb_find_by_goal()
fails to achieve the inode goal, allocation continues with the stream
allocation global goal. Currently, hits for both are combined in
sbi->s_bal_goals, hindering accurate optimization.

This commit separates global goal hits into sbi->s_bal_stream_goals. Since
stream allocation doesn't use ac->ac_g_ex.fe_start, set fe_start to -1.
This prevents stream allocations from being counted in s_bal_goals. Also
clear EXT4_MB_HINT_TRY_GOAL to avoid calling ext4_mb_find_by_goal again.

After adding `stream_goal_hits`, `/proc/fs/ext4/sdx/mb_stats` will show:

mballoc:
	reqs: 840347
	success: 750992
	groups_scanned: 1230506
	cr_p2_aligned_stats:
		hits: 21531
		groups_considered: 411664
		extents_scanned: 21531
		useless_loops: 0
		bad_suggestions: 6
	cr_goal_fast_stats:
		hits: 111222
		groups_considered: 1806728
		extents_scanned: 467908
		useless_loops: 0
		bad_suggestions: 13
	cr_best_avail_stats:
		hits: 36267
		groups_considered: 1817631
		extents_scanned: 156143
		useless_loops: 0
		bad_suggestions: 204
	cr_goal_slow_stats:
		hits: 106396
		groups_considered: 5671710
		extents_scanned: 22540056
		useless_loops: 123747
	cr_any_free_stats:
		hits: 138071
		groups_considered: 724692
		extents_scanned: 23615593
		useless_loops: 585
	extents_scanned: 46804261
		goal_hits: 1307
		stream_goal_hits: 236317
		len_goal_hits: 155549
		2^n_hits: 21531
		breaks: 225096
		lost: 35062
	buddies_generated: 40/40
	buddies_time_used: 48004
	preallocated: 5962467
	discarded: 4847560

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9df74123e7e6..8750ace12935 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1646,6 +1646,7 @@ struct ext4_sb_info {
 	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
 	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
+	atomic_t s_bal_stream_goals;	/* stream allocation global goal hits */
 	atomic_t s_bal_len_goals;	/* len goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 336d65c4f6a2..f56ac477c464 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2849,8 +2849,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		/* TBD: may be hot point */
 		spin_lock(&sbi->s_md_lock);
 		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
-		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
 		spin_unlock(&sbi->s_md_lock);
+		ac->ac_g_ex.fe_start = -1;
+		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
 	}
 
 	/*
@@ -3000,8 +3001,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		}
 	}
 
-	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND)
+	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND) {
 		atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
+		if (ac->ac_flags & EXT4_MB_STREAM_ALLOC &&
+		    ac->ac_b_ex.fe_group == ac->ac_g_ex.fe_group)
+			atomic_inc(&sbi->s_bal_stream_goals);
+	}
 out:
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
@@ -3194,6 +3199,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	seq_printf(seq, "\textents_scanned: %u\n",
 		   atomic_read(&sbi->s_bal_ex_scanned));
 	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
+	seq_printf(seq, "\t\tstream_goal_hits: %u\n",
+		   atomic_read(&sbi->s_bal_stream_goals));
 	seq_printf(seq, "\t\tlen_goal_hits: %u\n",
 		   atomic_read(&sbi->s_bal_len_goals));
 	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
-- 
2.46.1


