Return-Path: <linux-ext4+bounces-1058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2358459D5
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5151C21E7C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80BA5D490;
	Thu,  1 Feb 2024 14:16:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EC5D491;
	Thu,  1 Feb 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796991; cv=none; b=oixYbdVrE3zSxPcZCI5kScR92/FmS9pyogkI/cMkjjBV30nVMiL5EGwOvyq5VFNscoVDqgExLFrT8Y9yDbeGUUcqDGaibwcZ68K65alYIPRh16WXAZBy8zkBkuX81sLOAT0FY3/qnYY1O3pev7WAKga9DmqYS43MGm9ZknVOiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796991; c=relaxed/simple;
	bh=7RgMnk9HW84EbxS2xyK1O0Sz4jbb2wR+0AQQeJkbATI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebhtO2pLf57EvzmE2P/3huEcbUyXpnNhHVToLApfLcWntUUc3pQ4FE1XrPsrMyWgNZaCr6u4853SVdLVd9rDKw0gGhbIr1knBNtCUMwlP8aNrDIb0eDfU7qBWwpyt7ZmjDBBDkeeHHzccWRWzgq2e0m1+D0b7yC+14Z6fyFnHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TQgrm679Rz29ktV;
	Thu,  1 Feb 2024 22:14:32 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 518421400D4;
	Thu,  1 Feb 2024 22:16:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 22:16:23 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH v2] ext4: correct best extent lstart adjustment logic
Date: Thu, 1 Feb 2024 22:18:45 +0800
Message-ID: <20240201141845.1879253-1-libaokun1@huawei.com>
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

When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
extent did not completely cover the original request after adjusting the
best extent lstart in ext4_mb_new_inode_pa() as follows:

  original request: 2/10(8)
  normalized request: 0/64(64)
  best extent: 0/9(9)

When we check if best ex can be kept at start of goal, ac_o_ex.fe_logical
is 2 less than the adjusted best extent logical end 9, so we think the
adjustment is done. But obviously 0/9(9) doesn't cover 2/10(8), so we
should determine here if the original request logical end is less than or
equal to the adjusted best extent logical end.

In addition, add a comment stating when adjusted best_ex will not cover
the original request, and remove the duplicate assertion because adjusting
lstart makes no change to b_ex.fe_len.

Link: https://lore.kernel.org/r/3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Cc: stable@kernel.org
Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Remove the problematic BUG_ON and add some comments.

 fs/ext4/mballoc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1ea6491b6b00..20cad0676aab 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5148,10 +5148,16 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			.fe_len = ac->ac_orig_goal_len,
 		};
 		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
+		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
 
-		/* we can't allocate as much as normalizer wants.
-		 * so, found space must get proper lstart
-		 * to cover original request */
+		/*
+		 * We can't allocate as much as normalizer wants, so we try
+		 * to get proper lstart to cover the original request, except
+		 * when the goal doesn't cover the original request as below:
+		 *
+		 * orig_ex:2045/2055(10), isize:8417280 -> normalized:0/2048
+		 * best_ex:0/200(200) -> adjusted: 1848/2048(200)
+		 */
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
@@ -5163,7 +5169,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 * 1. Check if best ex can be kept at end of goal (before
 		 *    cr_best_avail trimmed it) and still cover original start
 		 * 2. Else, check if best ex can be kept at start of goal and
-		 *    still cover original start
+		 *    still cover original end
 		 * 3. Else, keep the best ex at start of original request.
 		 */
 		ex.fe_len = ac->ac_b_ex.fe_len;
@@ -5173,7 +5179,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_g_ex.fe_logical;
-		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+		if (o_ex_end <= extent_logical_end(sbi, &ex))
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_o_ex.fe_logical;
@@ -5181,7 +5187,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
-		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
-- 
2.31.1


