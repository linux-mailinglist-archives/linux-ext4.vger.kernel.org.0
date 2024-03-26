Return-Path: <linux-ext4+bounces-1756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EFA88C404
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767FEB2314B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99112C7E6;
	Tue, 26 Mar 2024 13:42:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB4763F1;
	Tue, 26 Mar 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460545; cv=none; b=fvWqDdo2YaB69ZlWYGktmWnp7wb+WQ9JDjZmJmNfTms0RPtja+MiBnjwdoFRLWs2Fb+hlYiYQZGWt7zg7cmqEvmXIwEg6XKt5gZs6wjKtKL5sKklzpU/5QCAF101pAGQUi246r03OgA95OYbP9iCFSVaDqQMbaf4fpzlyorFYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460545; c=relaxed/simple;
	bh=9cvyClmLimCu7FtlKLhwseURsexrxNIs8oFN5K4ObEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/mLDv2dtfOUrrDdvI+Gk3Y6mgqmANJxr4xipNyIZa+O7a7lT8XWu4OfePI1glE7p07pmuMQWJjRBKWVkLd3B8Al31jLZSdhIMzazjBImX7MeoeM+IrnFnoB5Ei/jkRr8VD/nzp5nNxRVwB/q/0dKWCII4aAthCzB9n/en5J2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3rZW1JH6z4f3mJ2;
	Tue, 26 Mar 2024 21:42:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4B26C1A01A7;
	Tue, 26 Mar 2024 21:42:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S6;
	Tue, 26 Mar 2024 21:42:19 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 4/5] ext4: use correct criteria name instead stale integer number in comment
Date: Wed, 27 Mar 2024 05:38:22 +0800
Message-Id: <20240326213823.528302-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240326213823.528302-1-shikemeng@huaweicloud.com>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGryxJw1Dury3Xw13KF4DJwb_yoW5uF4rp3
	9ayF18Kw4SgF13u393Ga1jg3W8Gw4I9F1UWryF9w17uFyaqr93tFWDKFW0yFy0vr4rZ3Wr
	XFy7Xw48CF1S93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxD7aUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use correct criteria name instead stale integer number in comment

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h    | 15 ++++++++++++---
 fs/ext4/mballoc.c | 14 ++++++++------
 fs/ext4/mballoc.h |  4 ++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 023571f8dd1b..9b90013c59a3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -213,11 +213,20 @@ enum criteria {
 #define EXT4_MB_USE_RESERVED		0x2000
 /* Do strict check for free blocks while retrying block allocation */
 #define EXT4_MB_STRICT_CHECK		0x4000
-/* Large fragment size list lookup succeeded at least once for cr = 0 */
+/*
+ * Large fragment size list lookup succeeded at least once for cr =
+ * CR_POWER2_ALIGNED
+ */
 #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
+/*
+ * Avg fragment size rb tree lookup succeeded at least once for cr =
+ * CR_GOAL_LEN_FAST
+ */
 #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
-/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
+/*
+ * Avg fragment size rb tree lookup succeeded at least once for cr =
+ * CR_BEST_AVAIL_LEN
+ */
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
 
 struct ext4_allocation_request {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 62d468379722..0f8a34513bf6 100644
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
@@ -3444,10 +3445,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
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


