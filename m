Return-Path: <linux-ext4+bounces-8992-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D543B03FB2
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FBD1A63FCA
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427C325D8E8;
	Mon, 14 Jul 2025 13:18:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1125C708;
	Mon, 14 Jul 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499128; cv=none; b=M2UJX6KILGhYraSMC6lKnbBAUg7y5t+4hPuwRM3FPq24pIR97HASkxsI/XPJME5XIym0ZcQkBHXuYKjbN9CCRmkXopiZnDQQfmYzsF5r6KOiwYvlDdDc7/gfbuMsr6/cqx1Pnz9DwluRZWg8k9cFhDBdJL1vBbc7R7hGV42Ovvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499128; c=relaxed/simple;
	bh=dFK9KXWwf7d+4+fDMAhnq78iN8DJwhZ4NLC/oTTDzYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeQ5MQ38hdfSNrrtHdGjAHEw5HFysSYKMCGSGpMstxGxgomGi2VLFl9E8oMbJf97o3SUpRWdgQDSb5dQ5jRJY2OybS2UzGll7IP42OzQsUxeadn9W2W5B7gMdNTx5r3tQaBssGyCSS52SysBML8iROn9G5ZJ0/NFB4HDY6bTZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjSf5RxGz14M0X;
	Mon, 14 Jul 2025 21:13:54 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B3DC218006C;
	Mon, 14 Jul 2025 21:18:40 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:39 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 12/17] ext4: factor out __ext4_mb_scan_group()
Date: Mon, 14 Jul 2025 21:03:22 +0800
Message-ID: <20250714130327.1830534-13-libaokun1@huawei.com>
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

Extract __ext4_mb_scan_group() to make the code clearer and to
prepare for the later conversion of 'choose group' to 'scan groups'.
No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 45 +++++++++++++++++++++++++++------------------
 fs/ext4/mballoc.h |  2 ++
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fada0d1b3fdb..650eb6366eb0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2568,6 +2568,30 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	}
 }
 
+static void __ext4_mb_scan_group(struct ext4_allocation_context *ac)
+{
+	bool is_stripe_aligned;
+	struct ext4_sb_info *sbi;
+	enum criteria cr = ac->ac_criteria;
+
+	ac->ac_groups_scanned++;
+	if (cr == CR_POWER2_ALIGNED)
+		return ext4_mb_simple_scan_group(ac, ac->ac_e4b);
+
+	sbi = EXT4_SB(ac->ac_sb);
+	is_stripe_aligned = false;
+	if ((sbi->s_stripe >= sbi->s_cluster_ratio) &&
+	    !(ac->ac_g_ex.fe_len % EXT4_NUM_B2C(sbi, sbi->s_stripe)))
+		is_stripe_aligned = true;
+
+	if ((cr == CR_GOAL_LEN_FAST || cr == CR_BEST_AVAIL_LEN) &&
+	    is_stripe_aligned)
+		ext4_mb_scan_aligned(ac, ac->ac_e4b);
+
+	if (ac->ac_status == AC_STATUS_CONTINUE)
+		ext4_mb_complex_scan_group(ac, ac->ac_e4b);
+}
+
 /*
  * This is also called BEFORE we load the buddy bitmap.
  * Returns either 1 or 0 indicating that the group is either suitable
@@ -2855,6 +2879,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 */
 	if (ac->ac_2order)
 		cr = CR_POWER2_ALIGNED;
+
+	ac->ac_e4b = &e4b;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
@@ -2932,24 +2958,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				continue;
 			}
 
-			ac->ac_groups_scanned++;
-			if (cr == CR_POWER2_ALIGNED)
-				ext4_mb_simple_scan_group(ac, &e4b);
-			else {
-				bool is_stripe_aligned =
-					(sbi->s_stripe >=
-					 sbi->s_cluster_ratio) &&
-					!(ac->ac_g_ex.fe_len %
-					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
-
-				if ((cr == CR_GOAL_LEN_FAST ||
-				     cr == CR_BEST_AVAIL_LEN) &&
-				    is_stripe_aligned)
-					ext4_mb_scan_aligned(ac, &e4b);
-
-				if (ac->ac_status == AC_STATUS_CONTINUE)
-					ext4_mb_complex_scan_group(ac, &e4b);
-			}
+			__ext4_mb_scan_group(ac);
 
 			ext4_unlock_group(sb, group);
 			ext4_mb_unload_buddy(&e4b);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index f8280de3e882..7a60b0103e64 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -204,6 +204,8 @@ struct ext4_allocation_context {
 	__u8 ac_2order;		/* if request is to allocate 2^N blocks and
 				 * N > 0, the field stores N, otherwise 0 */
 	__u8 ac_op;		/* operation, for history only */
+
+	struct ext4_buddy *ac_e4b;
 	struct folio *ac_bitmap_folio;
 	struct folio *ac_buddy_folio;
 	struct ext4_prealloc_space *ac_pa;
-- 
2.46.1


