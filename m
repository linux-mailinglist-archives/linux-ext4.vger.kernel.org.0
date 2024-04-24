Return-Path: <linux-ext4+bounces-2170-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703F8B01AE
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F2F1C2273F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0716157488;
	Wed, 24 Apr 2024 06:19:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC05156C5D;
	Wed, 24 Apr 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939554; cv=none; b=RVPaaeDmDqwn1WLIpZX96hn6TMbMBYuVoJW/pXrscDmVy/bqVjL6qdwOGDYe7YSVeVN1prqYKZohchZgTfyqvpb4gebuRihx8+DwCHha3pwS7zRoLtflwBChaXkTJiCsVXSr10OYcnlFp4dwjz1+JedGht4pQ+RJVE2yYh6EvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939554; c=relaxed/simple;
	bh=zW/J/B5sp0BaTPxRGgaqDVSl1Ae1DCfweYILs40wZbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eC3yIRERdQNn7Q9TXdSAQH/2No/OLCewDXDiJTB6T7E2hl97QiDX5NcDccdjjpRzFcYIIqG4f1Bs6fPilD3c/7DN4xY0r1I1v83LaQW0Jqp6TN/zgPMIelEmbl7dzUUYg2m8Dai/7lvFqsMgAr8Q0t2/JEeEVIiKJ+qa/Ms7en0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPTMq5hG1z4f3kkV;
	Wed, 24 Apr 2024 14:19:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9DD441A017C;
	Wed, 24 Apr 2024 14:19:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHGRJZpChmpfZBKw--.32510S6;
	Wed, 24 Apr 2024 14:19:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v3 4/5] ext4: use correct criteria name instead stale integer number in comment
Date: Wed, 24 Apr 2024 14:19:03 +0800
Message-Id: <20240424061904.987525-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240424061904.987525-1-shikemeng@huaweicloud.com>
References: <20240424061904.987525-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGRJZpChmpfZBKw--.32510S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWrZFyktFWfZFWkCr43GFg_yoWrGryrp3
	93GF18Kw4SgFy5urZ7Wa1jg3W8Kw409FyUXryF9w1xuFyaqr93tr9xKFW0yFy09r48A3Wr
	XF12qr48CF1S93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use correct criteria name instead stale integer number in comment

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h    |  9 ++++++---
 fs/ext4/mballoc.c | 16 +++++++++-------
 fs/ext4/mballoc.h |  4 ++--
 3 files changed, 17 insertions(+), 12 deletions(-)

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
index 5acf413808a2..3d344a21b7f0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
 	} else {
 		/*
-		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
-		 * bb_free. But until that happens, we should never come here.
+		 * TODO: For CR_GOAL_LEN_SLOW, we can arrange groups in an
+		 * rb tree sorted by bb_free. But until that happens, we should
+		 * never come here.
 		 */
 		WARN_ON(1);
 	}
@@ -2679,7 +2680,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		int ret;
 
 		/*
-		 * cr=CR_POWER2_ALIGNED/CR_GOAL_LEN_FAST is a very optimistic
+		 * CR_POWER2_ALIGNED/CR_GOAL_LEN_FAST is a very optimistic
 		 * search to find large good chunks almost for free. If buddy
 		 * data is not ready, then this optimization makes no sense. But
 		 * we never skip the first block group in a flex_bg, since this
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
+	 * CR_POWER2_ALIGNED. Given CR_POWER2_ALIGNED is an CPU-related
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


