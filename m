Return-Path: <linux-ext4+bounces-864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8990836344
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jan 2024 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CC11C2358A
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jan 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD33C46C;
	Mon, 22 Jan 2024 12:31:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816933B194;
	Mon, 22 Jan 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926668; cv=none; b=MeWje550DJWHZuB5j27t6PE/Mxbh6/OuE8SVYp6NH1n2sGMLd0bWVUGpyrI4CosDZJtllYI9Fl6JrgJr3Jf+13KZbkEKf+3PxZo2eP89LULT3rSBzT/JvEvmIFL/XmznIvkv8DFy15OZPHCRFSsdguzp1A9Rv5cRdMpCSFpOkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926668; c=relaxed/simple;
	bh=PzVDQgEDXAINlYBLlMfa+i8t8rPrBLpAvoIASPJEaJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONbNYTKlbN6Tv57i5WhPPSj8hlRo1VANe0bBe68eurwIzLFQV8zBZ97h9870Au34UiYrliCDKPuKo4UJbCArP8V+5+A3/2lDOrQw+Arrni5iS3NCIaOhev0xVecamaUkLZULiX2NTI5KvmPC+8X+MUZrPkrem1U+Km62gL/NstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TJTwz0Vzmz1FJgF;
	Mon, 22 Jan 2024 20:26:43 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 894181A0172;
	Mon, 22 Jan 2024 20:31:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 20:31:01 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH] ext4: correct best extent lstart adjustment logic
Date: Mon, 22 Jan 2024 20:33:32 +0800
Message-ID: <20240122123332.555370-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Moreover, the best extent len is not modified during the adjustment
process, and it is already checked by the previous assertion, so replace
the check for fe_len with a check for the best extent logical end.

Cc: stable@kernel.org
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f44f668e407f..fa5977fe8d72 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5146,6 +5146,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			.fe_len = ac->ac_orig_goal_len,
 		};
 		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
+		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -5161,7 +5162,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 * 1. Check if best ex can be kept at end of goal (before
 		 *    cr_best_avail trimmed it) and still cover original start
 		 * 2. Else, check if best ex can be kept at start of goal and
-		 *    still cover original start
+		 *    still cover original end
 		 * 3. Else, keep the best ex at start of original request.
 		 */
 		ex.fe_len = ac->ac_b_ex.fe_len;
@@ -5171,7 +5172,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_g_ex.fe_logical;
-		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+		if (o_ex_end <= extent_logical_end(sbi, &ex))
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_o_ex.fe_logical;
@@ -5179,7 +5180,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
-		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
+		BUG_ON(o_ex_end > extent_logical_end(sbi, &ex));
 		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
-- 
2.31.1


