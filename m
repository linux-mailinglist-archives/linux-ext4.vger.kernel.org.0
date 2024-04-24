Return-Path: <linux-ext4+bounces-2169-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF258B01AB
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57713283418
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BB157474;
	Wed, 24 Apr 2024 06:19:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14138156C64;
	Wed, 24 Apr 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939554; cv=none; b=Jf2fTYS+x37Z2BONWOO2wpB8iOdOdVLAy5O1FygqvQjBCaAQnLe1H59QclzMYAOEavT7/Ruuv1hQ4xjC6or2xTf5f3nrf9KZsk/7frm0w1t5cKpbbWexg1U6GatEqQD47Vt43prng2w2l+OHXmyLM0xNWfNEP/hvHb/3tR3Xtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939554; c=relaxed/simple;
	bh=Q2xaLIEV8BtfJUj+p2EXVQqVrRzAUXZJ9zUs7OeqwAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AX4rXY2yRxH6LBTiT44m+pSidXPRc9q8dgfp3cx1Uv44t4tnzrZ4uOWwOz6FwhI/8YkVoB876gQuvg33zNmbfESxh+TkXAQCm6E+5Gz3zNGadsuK61xAvyZsgmAxl0DzWoAV333yuXlB2g9w+JsPOSImEUVuLXwDkEPkRRphTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPTMn2w1Zz4f3khg;
	Wed, 24 Apr 2024 14:19:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E97D51A058D;
	Wed, 24 Apr 2024 14:19:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHGRJZpChmpfZBKw--.32510S7;
	Wed, 24 Apr 2024 14:19:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v3 5/5] ext4: open coding repeated check in next_linear_group
Date: Wed, 24 Apr 2024 14:19:04 +0800
Message-Id: <20240424061904.987525-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGRJZpChmpfZBKw--.32510S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UWrykAF15tw4fCFW7Arb_yoW8Zr18pF
	sxAry7Wr42gr1DCa9xGayvq3WSgw48Ga1UJryfWr93tF9xCrn8GFW3tr10vFy7XFWDAr13
	Xr43AF4Uu3Z3CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Open coding repeated check in next_linear_group.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3d344a21b7f0..9f73a76d679a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1076,23 +1076,11 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 }
 
 /*
- * Return next linear group for allocation. If linear traversal should not be
- * performed, this function just returns the same group
+ * Return next linear group for allocation.
  */
 static ext4_group_t
-next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
-		  ext4_group_t ngroups)
+next_linear_group(ext4_group_t group, ext4_group_t ngroups)
 {
-	if (!should_optimize_scan(ac))
-		goto inc_and_return;
-
-	if (ac->ac_groups_linear_remaining) {
-		ac->ac_groups_linear_remaining--;
-		goto inc_and_return;
-	}
-
-	return group;
-inc_and_return:
 	/*
 	 * Artificially restricted ngroups for non-extent
 	 * files makes group > ngroups possible on first loop.
@@ -1118,8 +1106,19 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 {
 	*new_cr = ac->ac_criteria;
 
-	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
-		*group = next_linear_group(ac, *group, ngroups);
+	if (!should_optimize_scan(ac)) {
+		*group = next_linear_group(*group, ngroups);
+		return;
+	}
+
+	/*
+	 * Optimized scanning can return non adjacent groups which can cause
+	 * seek overhead for rotational disks. So try few linear groups before
+	 * trying optimized scan.
+	 */
+	if (ac->ac_groups_linear_remaining) {
+		*group = next_linear_group(*group, ngroups);
+		ac->ac_groups_linear_remaining--;
 		return;
 	}
 
-- 
2.30.0


