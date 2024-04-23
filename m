Return-Path: <linux-ext4+bounces-2159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098068AE679
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40DC1F227C6
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340613280E;
	Tue, 23 Apr 2024 12:40:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8212DDA7;
	Tue, 23 Apr 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876054; cv=none; b=QUpKs1NmKR8d6YekWFOQQVaILfWkygfg3Mgrh25oO2x2w62Y2vq792ZJ/nnkPOLhJmhb7bN0AFXOhRiCLNIdCYzfxVtkMjd7GC61xcSASdfN4LLFj1XsqPnuGk61KTMURy9ya2N0/52FMGhauPgTogan8T3p7T+1cRHqp2Kdfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876054; c=relaxed/simple;
	bh=DRLKy6PWpcyAW3cnassTtwoi1nM6lNE0qZRpoZdKvMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KL6nUbPdHdd4Td4KKG6HuenkRwwlksFei/FJTBZ7NhwG1wOrmqcp6pdVI5oD6q+sOtSewKv/d436K3QInhpGSgtfB8ywaoi8Eln6my2DD6TgRQd44c2gmkG2FWd88IXoEf7NzCgNYgtLDZXLOS2hjG2fBvGX3COM7aQm1Zn/qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP1tg6txVz4f3knx;
	Tue, 23 Apr 2024 20:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C61101A058D;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S4;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 2/5] ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
Date: Tue, 23 Apr 2024 20:40:43 +0800
Message-Id: <20240423124046.974134-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fJr1xury7Aw48WryxAFb_yoW5Jr4kpa
	yjkF1Ykr4rWws7uw4fGws7Ww1rKw4kZr48GryxWr9YqF47AFyfC3Z7tFn8Gr48trs7Xrn8
	uFyqqFy7G397CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU86wZ7UUUUU==
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


