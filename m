Return-Path: <linux-ext4+bounces-2161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2D8AE67E
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A51B1C22C9F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E2134CDB;
	Tue, 23 Apr 2024 12:40:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F612DDBE;
	Tue, 23 Apr 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876055; cv=none; b=o1LDRQpxF8zzwUgKMsTbcp98ftYZzWMaNwm/RgRQ2E5VJvEOaTe3edctvfiqCxpPr59bO40WH/kZklOIXgRNsRoA3415/GI+a72u4G8ziwwP9Qy4zkRVX3rBTPtL3DM07fqWZl1X8BrFrNn3OYbIxx0a0vlssThZ+o3RjXdRqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876055; c=relaxed/simple;
	bh=ylHT47/XKgGD/nNUgMAZg1N8Sn+7f52H9bTejBLV0oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWwjVsFHQ/qqV9BE2Ihw7Z+FfRnSQ8GnROyyDwCWccfUCFOHMA6ObxixcUCDArFdokE2fzW+r4F7LMR54PGNboWaWZ5UzVomJTCRJAzWbJaVNW7t3aqbTiHnlbblPugidfV0A8asMUb18qh5kinSsPm0GeTybyY5IwaGXU9xPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VP1tf1wVtz4f3jYR;
	Tue, 23 Apr 2024 20:40:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BE6A11A0175;
	Tue, 23 Apr 2024 20:40:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S7;
	Tue, 23 Apr 2024 20:40:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 5/5] ext4: open coding repeated check in next_linear_group
Date: Tue, 23 Apr 2024 20:40:46 +0800
Message-Id: <20240423124046.974134-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UWrWUWF13Zw13XFW7CFg_yoW8CFyDpF
	sxAry7Wr42gr1DCa9xGayvq3WSgw18Ga1UJrySgr93tF9xCrn8GFW7tr10vFy7XFWDAr13
	Xr45AF4UC3WfCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Open coding repeated check in next_linear_group.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 71b2f9a18875..4afe5bb94bf4 100644
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


