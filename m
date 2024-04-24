Return-Path: <linux-ext4+bounces-2166-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6068B01A6
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CE128338E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 06:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8F156F31;
	Wed, 24 Apr 2024 06:19:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D0156C4C;
	Wed, 24 Apr 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939553; cv=none; b=jxf9h2lKgnhsGMAjwvGpHpJ6QyF2NfG60Mv19AR01/xO9Rc+YpOGcZkSrrnFeM2suA+ZGOvifLN2WBwW76TebIQd+4xioZg7bu9qrbDELsVN2ava1kb4OH8bDF2IcQ1RiatzcO65YW8swRHe9CEJwU1vf2IDIgq5pFg1BaBrW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939553; c=relaxed/simple;
	bh=t1U/InzqxiUqGU+e34imVaTcWHfcqLRThUU4nLPa18Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxlgcW8dq2tZj37oeWJdSeckQnnXIHWRQzQ3CupFDHMiKH85fG4gOHjS9soz/CVeJQLiPjPGaVvRlZo7UfLGfeu7KPMZtKdEpecUCXyGfuOE+4y7wUTbiZS5/HyRT7p8LXsqdP6CtmO1OfDHijQP/t8mf2wRIYahM2qz+sRN0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPTMk34J7z4f3n6F;
	Wed, 24 Apr 2024 14:18:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9C8551A0572;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHGRJZpChmpfZBKw--.32510S3;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v3 1/5] ext4: keep "prefetch_grp" and "nr" consistent
Date: Wed, 24 Apr 2024 14:19:00 +0800
Message-Id: <20240424061904.987525-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGRJZpChmpfZBKw--.32510S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Uur48urWfuFyfWw1rJFb_yoW8GrWUpF
	nak3y7Cr4rXr1UAayUG3Z0gw18Kw40gw12qFyIkryqq347ZryfJrsrtr4ruFWUZF47AFy3
	uFnIy3W8WF1UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUzoGQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Keep "prefetch_grp" and "nr" consistent to avoid to call
ext4_mb_prefetch_fini with non-prefetched groups.
When we step into next criteria, "prefetch_grp" is set to prefetch start
of new criteria while "nr" is number of the prefetched group in previous
criteria. If previous criteria and next criteria are both inexpensive
(< CR_GOAL_LEN_SLOW) and prefetch_ios reachs sbi->s_mb_prefetch_limit
in previous criteria, "prefetch_grp" and "nr" will be inconsistent and
may introduce unexpected cost to do ext4_mb_init_group for non-prefetched
groups.
Reset "nr" to 0 when we reset "prefetch_grp" to goal group to keep them
consistent.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 12b3f196010b..a61fc52956b2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2856,6 +2856,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		group = ac->ac_g_ex.fe_group;
 		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
 		prefetch_grp = group;
+		nr = 0;
 
 		for (i = 0, new_cr = cr; i < ngroups; i++,
 		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
-- 
2.30.0


