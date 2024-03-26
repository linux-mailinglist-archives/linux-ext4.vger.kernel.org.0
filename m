Return-Path: <linux-ext4+bounces-1752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 784AC88C3FC
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13E7B2211F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709212BE8F;
	Tue, 26 Mar 2024 13:42:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA53763EA;
	Tue, 26 Mar 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460544; cv=none; b=nO4cPLARw12jweGWmil8nGMtZm6enCrw3SXUEOogt2MK+1daBs5ppinqE9ImBJKysqdFQdtoRjhXKUrHKekErhWuhNUCeOLjtc/fxGjRaZAVtc5bxQTXlwNUNrVtXSxJgeKh7rOdQ3uOQAaYYZWk20kjxlpXyORbtxg88gpCljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460544; c=relaxed/simple;
	bh=ACWwNC11SBuRtxRdJI4E8zgSXRpzLp99IRIbOoj2qco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yn+vzbHTwrY+kpNo7t5P7EKnHwoEatuYo7pQRz+9bz1/6igfSVtggqiueZeFEvQVGm7fh/nLNFxELB1saeyoBM2vAmCvXf+JAFGMndBIBllm+mIHGmEGjjomEqvWJzAum+rdje959SobX0dwWE15i+SPENyB5zpdvTfuMqwUtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3rZV1TSsz4f3mHL;
	Tue, 26 Mar 2024 21:42:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 507B61A0B1E;
	Tue, 26 Mar 2024 21:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S3;
	Tue, 26 Mar 2024 21:42:16 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 1/5] ext4: keep "prefetch_grp" and "nr" consistent
Date: Wed, 27 Mar 2024 05:38:19 +0800
Message-Id: <20240326213823.528302-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Uur48urWfuFyfWw1rJFb_yoW8Jw48pr
	9akrW7Cw43Zr1UAayUG3Z0gw1kGw40gw12qFyIk34qqa47ZryfGFsFyr4ruFWUZF47AFy3
	Cr9Iya48WF1UWa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIc_fUUUUU=
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
Reset "nr" to 0 when we reset "prefetch_grp" to start of prefech in next
criteria to ensure "prefetch_grp" and "nr" are consistent.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


