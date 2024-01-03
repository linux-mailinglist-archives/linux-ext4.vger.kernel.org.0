Return-Path: <linux-ext4+bounces-645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E1822731
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14238284ACC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82618042;
	Wed,  3 Jan 2024 02:51:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0217981;
	Wed,  3 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4Z3M49rrz4f3mWP;
	Wed,  3 Jan 2024 10:50:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5373A1A09A9;
	Wed,  3 Jan 2024 10:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3U0SNy5RlDGn8FQ--.36935S3;
	Wed, 03 Jan 2024 10:50:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] ext4: Add unit test for test_free_blocks_simple
Date: Wed,  3 Jan 2024 18:48:56 +0800
Message-Id: <20240103104900.464789-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240103104900.464789-1-shikemeng@huaweicloud.com>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3U0SNy5RlDGn8FQ--.36935S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr17AFyUGFW7tryxGF45Jrb_yoWrXFyUpa
	98AF1F9r45WFsrWa1fJ39Fv3WfWw1vvrWkJryfW345XF4xAr9xJ3WkKF1rta1rtFWxXF1a
	v3Z0vFy7Cr47Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIksgUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test for test_free_blocks_simple.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index f94901fd3..3aac42ea6 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -5,6 +5,7 @@
 
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <linux/random.h>
 
 #include "ext4.h"
 
@@ -112,6 +113,13 @@ static void mbt_ctx_mark_used(struct super_block *sb, ext4_group_t group,
 	mb_set_bits(grp_ctx->bitmap_bh.b_data, start, len);
 }
 
+static void *mbt_ctx_bitmap(struct super_block *sb, ext4_group_t group)
+{
+	struct mbt_grp_ctx *grp_ctx = MBT_GRP_CTX(sb, group);
+
+	return grp_ctx->bitmap_bh.b_data;
+}
+
 /* called after mbt_init_sb_layout */
 static int mbt_ctx_init(struct super_block *sb)
 {
@@ -297,6 +305,93 @@ static void test_new_blocks_simple(struct kunit *test)
 		"unexpectedly get block when no block is available");
 }
 
+#define TEST_RANGE_COUNT 8
+
+struct test_range {
+	ext4_grpblk_t start;
+	ext4_grpblk_t len;
+};
+
+static void
+mbt_generate_test_ranges(struct super_block *sb, struct test_range *ranges,
+			 int count)
+{
+	ext4_grpblk_t start, len, max;
+	int i;
+
+	max = EXT4_CLUSTERS_PER_GROUP(sb) / count;
+	for (i = 0; i < count; i++) {
+		start = get_random_u32() % max;
+		len = get_random_u32() % max;
+		len = min(len, max - start);
+
+		ranges[i].start = start + i * max;
+		ranges[i].len = len;
+	}
+}
+
+static void
+validate_free_blocks_simple(struct kunit *test, struct super_block *sb,
+			    ext4_group_t goal_group, ext4_grpblk_t start,
+			    ext4_grpblk_t len)
+{
+	void *bitmap;
+	ext4_grpblk_t bit, max = EXT4_CLUSTERS_PER_GROUP(sb);
+	ext4_group_t i;
+
+	for (i = 0; i < ext4_get_groups_count(sb); i++) {
+		if (i == goal_group)
+			continue;
+
+		bitmap = mbt_ctx_bitmap(sb, i);
+		bit = mb_find_next_zero_bit(bitmap, max, 0);
+		KUNIT_ASSERT_EQ_MSG(test, bit, max,
+				    "free block on unexpected group %d", i);
+	}
+
+	bitmap = mbt_ctx_bitmap(sb, goal_group);
+	bit = mb_find_next_zero_bit(bitmap, max, 0);
+	KUNIT_ASSERT_EQ(test, bit, start);
+
+	bit = mb_find_next_bit(bitmap, max, bit + 1);
+	KUNIT_ASSERT_EQ(test, bit, start + len);
+}
+
+static void
+test_free_blocks_simple_range(struct kunit *test, ext4_group_t goal_group,
+			      ext4_grpblk_t start, ext4_grpblk_t len)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct inode inode = { .i_sb = sb, };
+	ext4_fsblk_t block;
+
+	if (len == 0)
+		return;
+
+	block = ext4_group_first_block_no(sb, goal_group) +
+		EXT4_C2B(sbi, start);
+	ext4_free_blocks_simple(&inode, block, len);
+	validate_free_blocks_simple(test, sb, goal_group, start, len);
+	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+}
+
+static void test_free_blocks_simple(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
+	ext4_group_t i;
+	struct test_range ranges[TEST_RANGE_COUNT];
+
+	for (i = 0; i < ext4_get_groups_count(sb); i++)
+		mbt_ctx_mark_used(sb, i, 0, max);
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_free_blocks_simple_range(test, TEST_GOAL_GROUP,
+			ranges[i].start, ranges[i].len);
+}
+
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
 	{
 		.blocksize_bits = 10,
@@ -334,6 +429,7 @@ KUNIT_ARRAY_PARAM(mbt_layouts, mbt_test_layouts, mbt_show_layout);
 
 static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


