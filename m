Return-Path: <linux-ext4+bounces-2160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10778AE67B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F391F2327D
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527F13443E;
	Tue, 23 Apr 2024 12:40:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0112D777;
	Tue, 23 Apr 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876055; cv=none; b=F52xvvSOYP7r7+Hmt4+lSRTgAU1VQFtOY5Ef5Vkrb86fvdqRz/l26zd2OPytXvZ9hj4KWaHoYnc281S/s6HGj7MFsNOFDR9BV3OweQwe5apNqw7HNjo/QhetXj1tey7uA3WCd/yU5QPRwNI6wr8Y6hCi3cHgeMCchAUbL9g79Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876055; c=relaxed/simple;
	bh=t1U/InzqxiUqGU+e34imVaTcWHfcqLRThUU4nLPa18Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpNWE+EZxpXDuk8T25qMMuTMJijkhSaqMFDz9vx5Dj7chuWaKuTs+9jJ8JeEILxekH8qqPDeMirfbsVUxsLo9PLaMWv3JjHIwrOsDVfIoXvl/GjqOxXdg8wSlKdqzRa/Rct1DmkRsmw3jz7PMpWdzphu4lzUIQlZ4QjVEw+g9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP1tg4nx2z4f3kkd;
	Tue, 23 Apr 2024 20:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7BEA01A0179;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S3;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 1/5] ext4: keep "prefetch_grp" and "nr" consistent
Date: Tue, 23 Apr 2024 20:40:42 +0800
Message-Id: <20240423124046.974134-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Uur48urWfuFyfWw1rJFb_yoW8GrWUpF
	nak3y7Cr4rXr1UAayUG3Z0gw18Kw40gw12qFyIkryqq347ZryfJrsrtr4ruFWUZF47AFy3
	uFnIy3W8WF1UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU1X_-DUUUUU==
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


