Return-Path: <linux-ext4+bounces-2158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F958AE678
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2984F1F226F1
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBB130E5B;
	Tue, 23 Apr 2024 12:40:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12512E1E3;
	Tue, 23 Apr 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876054; cv=none; b=qsDRQyd3ZF3knXAV52f3xxdDBlJgs8IHfQWOQplckpRCePETEP61fVn0ZMG1GyJlJ9finDeexn4LyHUnNDZ2u88Nieh2UuP/DGK5pgp6YlbHR3jBxsSZoN1yavtn2Z6B6Vgvh9/iHZhS63YqroD9/q41HN2holHUHUqLy+8Bcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876054; c=relaxed/simple;
	bh=aUNHPylXkkW1aZBTyMMYM2v0i+K8pnMrfM1kA2WBtqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THCHzHBmD2SaoshtR56swMg/c1mRvHgf6EGsp+rchTOzJcenSIM3qItKknIpSiCYrIjOV9olQEpqq6p2O9S6fh5TXOD60ACtPP84hI2IlNXxZgn89BhoxUpqh5xJ6YBKBUpO2kS5eB9tqfKaSIXSUU4yQtTSN/nOKmem2QZ00MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VP1td6n2Jz4f3jYJ;
	Tue, 23 Apr 2024 20:40:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 713651A0568;
	Tue, 23 Apr 2024 20:40:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S6;
	Tue, 23 Apr 2024 20:40:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 4/5] ext4: use correct criteria name instead stale integer number in comment
Date: Tue, 23 Apr 2024 20:40:45 +0800
Message-Id: <20240423124046.974134-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423124046.974134-1-shikemeng@huaweicloud.com>
References: <20240423124046.974134-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xArWkWr17WFWDJw1rtFb_yoW5uFWxp3
	9ayF18Kw4SgFy5u397Wa1UK3W8Kw4I9F1UXryF9r17uFyaqr93tFZxKFW0yFy09r4rA3Wr
	XF17Xw48CF1S93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use correct criteria name instead stale integer number in comment

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h    |  9 ++++++---
 fs/ext4/mballoc.c | 14 ++++++++------
 fs/ext4/mballoc.h |  4 ++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..9bd3764d1121 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -213,11 +213,14 @@ enum criteria {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
-/* Large fragment size list lookup succeeded at least once for cr = 0 */
+/* Large fragment size list lookup succeeded at least once for
+ * CR_POWER2_ALIGNED */
 #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
+/* Avg fragment size rb tree lookup succeeded at least once for
+ * CR_GOAL_LEN_FAST */
 #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
+/* Avg fragment size rb tree lookup succeeded at least once for
+ * CR_BEST_AVAIL_LEN */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
 
 struct ext4_allocation_request {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5acf413808a2..71b2f9a18875 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
 	} else {
 		/*
-		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
-		 * bb_free. But until that happens, we should never come here.
+		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
+		 * rb tree sorted by bb_free. But until that happens, we should
+		 * never come here.
 		 */
 		WARN_ON(1);
 	}
@@ -3445,10 +3446,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	}
 	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
 		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
-	/* now many real IOs to prefetch within a single allocation at cr=0
-	 * given cr=0 is an CPU-related optimization we shouldn't try to
-	 * load too many groups, at some point we should start to use what
-	 * we've got in memory.
+	/*
+	 * now many real IOs to prefetch within a single allocation at
+	 * cr=CR_POWER2_ALIGNED. Given cr=CR_POWER2_ALIGNED is an CPU-related
+	 * optimization we shouldn't try to load too many groups, at some point
+	 * we should start to use what we've got in memory.
 	 * with an average random access time 5ms, it'd take a second to get
 	 * 200 groups (* N with flex_bg), so let's make this limit 4
 	 */
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 56938532b4ce..042437d8860f 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -187,8 +187,8 @@ struct ext4_allocation_context {
 	struct ext4_free_extent ac_f_ex;
 
 	/*
-	 * goal len can change in CR1.5, so save the original len. This is
-	 * used while adjusting the PA window and for accounting.
+	 * goal len can change in CR_BEST_AVAIL_LEN, so save the original len.
+	 * This is used while adjusting the PA window and for accounting.
 	 */
 	ext4_grpblk_t	ac_orig_goal_len;
 
-- 
2.30.0


