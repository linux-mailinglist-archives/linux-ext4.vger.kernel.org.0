Return-Path: <linux-ext4+bounces-1446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8286D9F0
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 04:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECA5284596
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF140C15;
	Fri,  1 Mar 2024 03:11:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6F2BAE7;
	Fri,  1 Mar 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262695; cv=none; b=hIwkVZLrdVLAKUEmxCqq8aNNBRu/RguPVAr4A+1CMa+nvBBu3o+Mz+whIzyShN8eSxwbn17agUIEqKhYFT8OZQq1JNJqR1WkzuAuE0mWlRVu/lVkW5i4RSQ9w5EqF+FVXawrfiIaZLf3NsQ2BuzA02JCw0gqrueUxVgFIyycvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262695; c=relaxed/simple;
	bh=96tB+Xmo5ORVupaJgaPgwluk5vwPC5H/0KEdzzg62i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H14Q1UxbsH3DKvE0rEkTdnu7cWtcuJpPGMe5iPCfPr3xV44yj353aLRkTXDy82AGi6GHKOdBEY/6kNXEH0MtUAyWMEB6xlUlpGlSiCDIf5Jo+Lgyn6qqefVIqOlwzJSMRlAyC6Gs+4AinnXTTmkMlpEOOqK7bNlSPmBNn+CrZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmCmG53B8z4f3kKt;
	Fri,  1 Mar 2024 11:11:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B7CD1A0838;
	Fri,  1 Mar 2024 11:11:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgD3SGtfR+FlBJ6mFg--.42023S4;
	Fri, 01 Mar 2024 11:11:29 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH 2/2] ext4: hold group lock in ext4 kunit test
Date: Fri,  1 Mar 2024 20:08:16 +0800
Message-Id: <20240301120816.22581-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240301120816.22581-1-shikemeng@huaweicloud.com>
References: <20240301120816.22581-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3SGtfR+FlBJ6mFg--.42023S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UuFyUArWrur17KFyUJrb_yoW8ArW8pF
	sIkrn0kF45Wr1kuw47G3y0q3Z7K3ykuw1UGrWfC345ArWfJr9rCF98twnxKr48tFs7XF45
	Z3Z0vry3Crs7uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jhUUbUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Although there is no concurrent block allocation/free in unit test,
internal functions mb_mark_used and mb_free_blocks assert group
lock is always held. Acquire group before calling mb_mark_used and
mb_free_blocks in unit test to avoid the assertion.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ext4/mballoc-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 1da52bbf4599..40e878ea8258 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -694,7 +694,10 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 	ex.fe_start = start;
 	ex.fe_len = len;
 	ex.fe_group = TEST_GOAL_GROUP;
+
+	ext4_lock_group(sb, TEST_GOAL_GROUP);
 	mb_mark_used(e4b, &ex);
+	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	mb_set_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -754,7 +757,9 @@ test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
 	if (len == 0)
 		return;
 
+	ext4_lock_group(sb, e4b->bd_group);
 	mb_free_blocks(NULL, e4b, start, len);
+	ext4_unlock_group(sb, e4b->bd_group);
 
 	mb_clear_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -798,7 +803,11 @@ static void test_mb_free_blocks(struct kunit *test)
 	ex.fe_start = 0;
 	ex.fe_len = EXT4_CLUSTERS_PER_GROUP(sb);
 	ex.fe_group = TEST_GOAL_GROUP;
+
+	ext4_lock_group(sb, TEST_GOAL_GROUP);
 	mb_mark_used(&e4b, &ex);
+	ext4_unlock_group(sb, TEST_GOAL_GROUP);
+
 	grp->bb_free = 0;
 	memset(bitmap, 0xff, sb->s_blocksize);
 
-- 
2.30.0


