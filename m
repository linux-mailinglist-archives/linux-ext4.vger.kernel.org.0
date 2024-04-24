Return-Path: <linux-ext4+bounces-2168-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0908B01AA
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B641C221B9
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CC157463;
	Wed, 24 Apr 2024 06:19:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E1156C62;
	Wed, 24 Apr 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939554; cv=none; b=SyzNVS5lmdJ5ag2+/KqTGaN3ZYI5vlph7n9ceS5nFdJSYWjLGiPNHKoR/fjD3bpD85jgMd33z+zpZwV6+0rqeJQ9gnK9oz49qrkKy5jKWgWscT2Qarwkrxom9OOSxfScKGvyM6LXmjNunDXj4uPbZm8yWdUKKyMJCd3IslsbKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939554; c=relaxed/simple;
	bh=DRLKy6PWpcyAW3cnassTtwoi1nM6lNE0qZRpoZdKvMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcxHTHmIVckzv2CRabi8uuxs7K7tj+Szzg5EEaqItrYhpylHj1XNf9fd+XYn19Sm1FrvuZ0+pLb52cw5xVKJxMtC7OLpppZvwrpHY/njKGOhslSXh79PCzqYNepmddLJPyKDOcvRv7EEwzBZBHukXD3+h5ctvpC86cpShvTil90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPTMm30K6z4f3jHV;
	Wed, 24 Apr 2024 14:19:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ECC381A115C;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHGRJZpChmpfZBKw--.32510S4;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v3 2/5] ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
Date: Wed, 24 Apr 2024 14:19:01 +0800
Message-Id: <20240424061904.987525-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGRJZpChmpfZBKw--.32510S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fJr1xury7Aw48WryxAFb_yoW5Jr4kpa
	yjkF1Ykr4rWws7uw4fGws7Ww1rKw4kZr48GryxWr9YqF47AFyfC3Z7tFn8Gr48trs7Xrn8
	uFyqqFy7G397CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add test_mb_mark_used_cost to estimate cost of mb_mark_used

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 044ca5238f41..df482782d695 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -859,6 +859,56 @@ static void test_mb_free_blocks(struct kunit *test)
 	ext4_mb_unload_buddy(&e4b);
 }
 
+#define COUNT_FOR_ESTIMATE 100000
+static void test_mb_mark_used_cost(struct kunit *test)
+{
+	struct ext4_buddy e4b;
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct ext4_free_extent ex;
+	int ret;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i, j;
+	unsigned long start, end, all = 0;
+
+	/* buddy cache assumes that each page contains at least one block */
+	if (sb->s_blocksize > PAGE_SIZE)
+		kunit_skip(test, "blocksize exceeds pagesize");
+
+	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ex.fe_group = TEST_GOAL_GROUP;
+	for (j = 0; j < COUNT_FOR_ESTIMATE; j++) {
+		mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+		start = jiffies;
+		for (i = 0; i < TEST_RANGE_COUNT; i++) {
+			if (ranges[i].len == 0)
+				continue;
+
+			ex.fe_start = ranges[i].start;
+			ex.fe_len = ranges[i].len;
+			ext4_lock_group(sb, TEST_GOAL_GROUP);
+			mb_mark_used(&e4b, &ex);
+			ext4_unlock_group(sb, TEST_GOAL_GROUP);
+		}
+		end = jiffies;
+		all += (end - start);
+
+		for (i = 0; i < TEST_RANGE_COUNT; i++) {
+			if (ranges[i].len == 0)
+				continue;
+
+			ext4_lock_group(sb, TEST_GOAL_GROUP);
+			mb_free_blocks(NULL, &e4b, ranges[i].start,
+				       ranges[i].len);
+			ext4_unlock_group(sb, TEST_GOAL_GROUP);
+		}
+	}
+
+	kunit_info(test, "costed jiffies %lu\n", all);
+	ext4_mb_unload_buddy(&e4b);
+}
+
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
 	{
 		.blocksize_bits = 10,
@@ -901,6 +951,8 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM_ATTR(test_mb_mark_used_cost, mbt_layouts_gen_params,
+			      { .speed = KUNIT_SPEED_SLOW }),
 	{}
 };
 
-- 
2.30.0


