Return-Path: <linux-ext4+bounces-1755-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3CB88C402
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED251F63C66
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8012C54A;
	Tue, 26 Mar 2024 13:42:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AE12AAF5;
	Tue, 26 Mar 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460545; cv=none; b=M9MFq28UbTFA3koJMRFLaOJlLp2wIPptA/tB8gMMfH5ew1EwAfqqDLwPcCyjUhe43AnQlRFiXnbZAmW2gmbWgetzEN3A0F8+crl/xk2bNoT1RG5o7AAB6pqbRl44UkusmtHImZrLQcDdUoRMmV2n6E8Cw6uhS64oHFyEsqEoAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460545; c=relaxed/simple;
	bh=rTsyKJ+6cQulWFeCm9Ty6fR+GXC23ReLWDU/rqmdMYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THuwM3QZ7ey4/RipYcSejN4114j2lAE7jFYgn0lndHl0kvQlDgcj65hq3rx4VnmLVEYYrvXXe4vbjB3b6SWrlAl28TPzu2414QHT0kN6kGO5Wl4Z4UtfmCPi0aoa50Bql4agBnMF6fVA0hSY5PwGQQsD2FFlUEX0bVoAA+8KBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3rZW3QSMz4f3nKG;
	Tue, 26 Mar 2024 21:42:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 92DBF1A016E;
	Tue, 26 Mar 2024 21:42:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S7;
	Tue, 26 Mar 2024 21:42:19 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 5/5] ext4: expand next_linear_group to remove repeat check for linear scan.
Date: Wed, 27 Mar 2024 05:38:23 +0800
Message-Id: <20240326213823.528302-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW3Xr1xGFyDJFykWrW5Awb_yoW8ZF43pa
	nxGFy7ur1xWFn8GFZ8Ga9Yg3WfKw18GF1UAryfG3s3tF13Arn8GFW2yr10vFy7GFZrCrnx
	Xr45AF1UC3Z7CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Expand next_linear_group to remove repat check for linear scan.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0f8a34513bf6..561780a274cd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1075,31 +1075,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 	return 1;
 }
 
-/*
- * Return next linear group for allocation. If linear traversal should not be
- * performed, this function just returns the same group
- */
-static ext4_group_t
-next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
-		  ext4_group_t ngroups)
-{
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
-	/*
-	 * Artificially restricted ngroups for non-extent
-	 * files makes group > ngroups possible on first loop.
-	 */
-	return group + 1 >= ngroups ? 0 : group + 1;
-}
-
 /*
  * ext4_mb_choose_next_group: choose next group for allocation.
  *
@@ -1118,12 +1093,12 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 {
 	*new_cr = ac->ac_criteria;
 
-	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
-		*group = next_linear_group(ac, *group, ngroups);
-		return;
-	}
-
-	if (*new_cr == CR_POWER2_ALIGNED) {
+	if (!should_optimize_scan(ac))
+		*group = *group + 1 >= ngroups ? 0 : *group + 1;
+	else if (ac->ac_groups_linear_remaining) {
+		ac->ac_groups_linear_remaining--;
+		*group = *group + 1 >= ngroups ? 0 : *group + 1;
+	} else if (*new_cr == CR_POWER2_ALIGNED) {
 		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
 	} else if (*new_cr == CR_GOAL_LEN_FAST) {
 		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
-- 
2.30.0


