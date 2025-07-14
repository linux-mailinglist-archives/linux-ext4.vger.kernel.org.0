Return-Path: <linux-ext4+bounces-8990-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99183B03FAA
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A156D1A63C2A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8DE24E4D4;
	Mon, 14 Jul 2025 13:18:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCA25B2E1;
	Mon, 14 Jul 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499126; cv=none; b=VHS4HaYMeMliO8jTgMvuHQTCeaHaQuyWXbBr41jjUN1zRkZJI++WzoLbqgob32qDGTyPwv5pVtmbQ2cUl5C0nmK6UT2UIqjQypnuCkfLFNziaHjONT6p91ppUCvvJ/s+gTYcI2xosfLD5Qbqfq53L46lOp7M8Xs/Wfbsk+tgyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499126; c=relaxed/simple;
	bh=GPRJ5GoM3SwV4dyvAcG5wABuAhG1VZrIaYIKoiDktIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trs6vSpQW6k6TcAFFZH/QO1nFd27oZmiJ8InzVr/4jFtG3v5U0YMvsm2WrhVaQB09Wcpff02neDJ2nJyYpX+W678U1iW3oEt1tyzTsRc5G6ESA98hSXJvWnmmvP6KfKrH8cUGgQ7kBXg6bPOf7PnrF0ME1zoOC3gpVE14QOqEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjSg5X89z14M0b;
	Mon, 14 Jul 2025 21:13:55 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B75091401F2;
	Mon, 14 Jul 2025 21:18:41 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:40 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 13/17] ext4: factor out ext4_mb_might_prefetch()
Date: Mon, 14 Jul 2025 21:03:23 +0800
Message-ID: <20250714130327.1830534-14-libaokun1@huawei.com>
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

Extract ext4_mb_might_prefetch() to make the code clearer and to
prepare for the later conversion of 'choose group' to 'scan groups'.
No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 62 +++++++++++++++++++++++++++++------------------
 fs/ext4/mballoc.h |  4 +++
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 650eb6366eb0..52ec59f58c36 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2781,6 +2781,37 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 	return group;
 }
 
+/*
+ * Batch reads of the block allocation bitmaps to get
+ * multiple READs in flight; limit prefetching at inexpensive
+ * CR, otherwise mballoc can spend a lot of time loading
+ * imperfect groups
+ */
+static void ext4_mb_might_prefetch(struct ext4_allocation_context *ac,
+				   ext4_group_t group)
+{
+	struct ext4_sb_info *sbi;
+
+	if (ac->ac_prefetch_grp != group)
+		return;
+
+	sbi = EXT4_SB(ac->ac_sb);
+	if (ext4_mb_cr_expensive(ac->ac_criteria) ||
+	    ac->ac_prefetch_ios < sbi->s_mb_prefetch_limit) {
+		unsigned int nr = sbi->s_mb_prefetch;
+
+		if (ext4_has_feature_flex_bg(ac->ac_sb)) {
+			nr = 1 << sbi->s_log_groups_per_flex;
+			nr -= group & (nr - 1);
+			nr = umin(nr, sbi->s_mb_prefetch);
+		}
+
+		ac->ac_prefetch_nr = nr;
+		ac->ac_prefetch_grp = ext4_mb_prefetch(ac->ac_sb, group, nr,
+						       &ac->ac_prefetch_ios);
+	}
+}
+
 /*
  * Prefetching reads the block bitmap into the buffer cache; but we
  * need to make sure that the buddy bitmap in the page cache has been
@@ -2817,10 +2848,9 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
-	ext4_group_t prefetch_grp = 0, ngroups, group, i;
+	ext4_group_t ngroups, group, i;
 	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
 	int err = 0, first_err = 0;
-	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	struct ext4_buddy e4b;
@@ -2881,6 +2911,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		cr = CR_POWER2_ALIGNED;
 
 	ac->ac_e4b = &e4b;
+	ac->ac_prefetch_ios = 0;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
@@ -2890,8 +2921,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 */
 		group = ac->ac_g_ex.fe_group;
 		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
-		prefetch_grp = group;
-		nr = 0;
+		ac->ac_prefetch_grp = group;
+		ac->ac_prefetch_nr = 0;
 
 		for (i = 0, new_cr = cr; i < ngroups; i++,
 		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
@@ -2903,24 +2934,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				goto repeat;
 			}
 
-			/*
-			 * Batch reads of the block allocation bitmaps
-			 * to get multiple READs in flight; limit
-			 * prefetching at inexpensive CR, otherwise mballoc
-			 * can spend a lot of time loading imperfect groups
-			 */
-			if ((prefetch_grp == group) &&
-			    (ext4_mb_cr_expensive(cr) ||
-			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
-				nr = sbi->s_mb_prefetch;
-				if (ext4_has_feature_flex_bg(sb)) {
-					nr = 1 << sbi->s_log_groups_per_flex;
-					nr -= group & (nr - 1);
-					nr = min(nr, sbi->s_mb_prefetch);
-				}
-				prefetch_grp = ext4_mb_prefetch(sb, group,
-							nr, &prefetch_ios);
-			}
+			ext4_mb_might_prefetch(ac, group);
 
 			/* prevent unnecessary buddy loading. */
 			if (cr < CR_ANY_FREE &&
@@ -3018,8 +3032,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
 
-	if (nr)
-		ext4_mb_prefetch_fini(sb, prefetch_grp, nr);
+	if (ac->ac_prefetch_nr)
+		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
 
 	return err;
 }
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 7a60b0103e64..9f66b1d5db67 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -192,6 +192,10 @@ struct ext4_allocation_context {
 	 */
 	ext4_grpblk_t	ac_orig_goal_len;
 
+	ext4_group_t ac_prefetch_grp;
+	unsigned int ac_prefetch_ios;
+	unsigned int ac_prefetch_nr;
+
 	__u32 ac_flags;		/* allocation hints */
 	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-- 
2.46.1


