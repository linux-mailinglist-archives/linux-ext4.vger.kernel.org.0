Return-Path: <linux-ext4+bounces-8598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C483AE375D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CD18942AE
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CEA22A7E5;
	Mon, 23 Jun 2025 07:47:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D92264BF;
	Mon, 23 Jun 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664830; cv=none; b=M78ktSSNq/UJrKCSheafRX8hBcMkSwbzJlGggOw1Wi0cKNMZbtbHWBJfzbyHHkifVboPn7aNvo3zOxJD5Bbl27QWRQJR9CeLQXeIr8vaWrJX2njy7PiIzsWRUo+XQO8IMisteT7/RLtPXvhWRNMLepr69zlyrUpBzbivcBBlEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664830; c=relaxed/simple;
	bh=tNupaSWSP01py596cKyGiIw4oa9w6oKuqTrHZ/XFIKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWLX8+Egb0fPztm6cKgOdrMqqRETbbqRyRanEWlv5YmEDSu8pEVokKmMTHbE7M8jxWRnt+RStppKob7+3CeKo/LAg85tQBtoGaJnG2T++K/k9kJHIkjG043zdpsj76pi/ZFkOQP54dzNBzgKQ1Gp0mVlWrSnjDBj8Id+vRgJoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQg9w2Dp0ztS4G;
	Mon, 23 Jun 2025 15:45:56 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C495B180B3F;
	Mon, 23 Jun 2025 15:47:05 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:47:04 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 13/16] ext4: factor out ext4_mb_scan_group()
Date: Mon, 23 Jun 2025 15:33:01 +0800
Message-ID: <20250623073304.3275702-14-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250623073304.3275702-1-libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Extract ext4_mb_scan_group() to make the code clearer and to
prepare for the later conversion of 'choose group' to 'scan groups'.
No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 93 +++++++++++++++++++++++++----------------------
 fs/ext4/mballoc.h |  2 +
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 683e7f8faab6..2c4c2cf3e180 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2846,12 +2846,56 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 	}
 }
 
+static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
+			      ext4_group_t group)
+{
+	int ret;
+	struct super_block *sb = ac->ac_sb;
+	enum criteria cr = ac->ac_criteria;
+
+	ext4_mb_might_prefetch(ac, group);
+
+	/* prevent unnecessary buddy loading. */
+	if (cr < CR_ANY_FREE && spin_is_locked(ext4_group_lock_ptr(sb, group)))
+		return 0;
+
+	/* This now checks without needing the buddy page */
+	ret = ext4_mb_good_group_nolock(ac, group, cr);
+	if (ret <= 0) {
+		if (!ac->ac_first_err)
+			ac->ac_first_err = ret;
+		return 0;
+	}
+
+	ret = ext4_mb_load_buddy(sb, group, ac->ac_e4b);
+	if (ret)
+		return ret;
+
+	/* skip busy group */
+	if (cr >= CR_ANY_FREE)
+		ext4_lock_group(sb, group);
+	else if (!ext4_try_lock_group(sb, group))
+		goto out_unload;
+
+	/* We need to check again after locking the block group. */
+	if (unlikely(!ext4_mb_good_group(ac, group, cr)))
+		goto out_unlock;
+
+	__ext4_mb_scan_group(ac);
+
+out_unlock:
+	ext4_unlock_group(sb, group);
+out_unload:
+	ext4_mb_unload_buddy(ac->ac_e4b);
+	return ret;
+}
+
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t ngroups, group, i;
 	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
-	int err = 0, first_err = 0;
+	int err = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	struct ext4_buddy e4b;
@@ -2912,6 +2956,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	ac->ac_e4b = &e4b;
 	ac->ac_prefetch_ios = 0;
+	ac->ac_first_err = 0;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
@@ -2926,7 +2971,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 		for (i = 0, new_cr = cr; i < ngroups; i++,
 		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
-			int ret = 0;
 
 			cond_resched();
 			if (new_cr != cr) {
@@ -2934,49 +2978,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				goto repeat;
 			}
 
-			ext4_mb_might_prefetch(ac, group);
-
-			/* prevent unnecessary buddy loading. */
-			if (cr < CR_ANY_FREE &&
-			    spin_is_locked(ext4_group_lock_ptr(sb, group)))
-				continue;
-
-			/* This now checks without needing the buddy page */
-			ret = ext4_mb_good_group_nolock(ac, group, cr);
-			if (ret <= 0) {
-				if (!first_err)
-					first_err = ret;
-				continue;
-			}
-
-			err = ext4_mb_load_buddy(sb, group, &e4b);
+			err = ext4_mb_scan_group(ac, group);
 			if (err)
 				goto out;
 
-			/* skip busy group */
-			if (cr >= CR_ANY_FREE) {
-				ext4_lock_group(sb, group);
-			} else if (!ext4_try_lock_group(sb, group)) {
-				ext4_mb_unload_buddy(&e4b);
-				continue;
-			}
-
-			/*
-			 * We need to check again after locking the
-			 * block group
-			 */
-			ret = ext4_mb_good_group(ac, group, cr);
-			if (ret == 0) {
-				ext4_unlock_group(sb, group);
-				ext4_mb_unload_buddy(&e4b);
-				continue;
-			}
-
-			__ext4_mb_scan_group(ac);
-
-			ext4_unlock_group(sb, group);
-			ext4_mb_unload_buddy(&e4b);
-
 			if (ac->ac_status != AC_STATUS_CONTINUE)
 				break;
 		}
@@ -3021,8 +3026,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND)
 		atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
 out:
-	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
-		err = first_err;
+	if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
+		err = ac->ac_first_err;
 
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 772ee0264d33..721aaea1f83e 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -205,6 +205,8 @@ struct ext4_allocation_context {
 	unsigned int ac_prefetch_ios;
 	unsigned int ac_prefetch_nr;
 
+	int ac_first_err;
+
 	__u32 ac_flags;		/* allocation hints */
 	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-- 
2.46.1


