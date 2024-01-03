Return-Path: <linux-ext4+bounces-646-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483BB822732
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA7C1F22BD4
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2BF18043;
	Wed,  3 Jan 2024 02:51:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDE1798F;
	Wed,  3 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4Z3L70MBz4f3kF6;
	Wed,  3 Jan 2024 10:50:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F5651A017D;
	Wed,  3 Jan 2024 10:50:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3U0SNy5RlDGn8FQ--.36935S7;
	Wed, 03 Jan 2024 10:50:58 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
Date: Wed,  3 Jan 2024 18:49:00 +0800
Message-Id: <20240103104900.464789-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3U0SNy5RlDGn8FQ--.36935S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1rCw18tFWUKFyDKFWxWFg_yoW5JFW3pa
	15uFn0kr45JrnxWw4SgrZrC3W3Kw4kZrWktryfWrn0vFW7GF98Aa1kKF15Gw48Jr4kXa43
	Z3Z0qa47Gr4xCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test for ext4_mb_mark_diskspace_used

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index b68f44740..12d0b22ca 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -470,6 +470,57 @@ static void test_free_blocks_simple(struct kunit *test)
 			ranges[i].start, ranges[i].len);
 }
 
+static void
+test_mark_diskspace_used_range(struct kunit *test,
+			       struct ext4_allocation_context *ac,
+			       ext4_grpblk_t start,
+			       ext4_grpblk_t len)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	int ret;
+	void *bitmap;
+	ext4_grpblk_t i, max;
+
+	/* ext4_mb_mark_diskspace_used will BUG if len is 0 */
+	if (len == 0)
+		return;
+
+	ac->ac_b_ex.fe_group = TEST_GOAL_GROUP;
+	ac->ac_b_ex.fe_start = start;
+	ac->ac_b_ex.fe_len = len;
+
+	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
+	memset(bitmap, 0, sb->s_blocksize);
+	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	i = mb_find_next_bit(bitmap, max, 0);
+	KUNIT_ASSERT_EQ(test, i, start);
+	i = mb_find_next_zero_bit(bitmap, max, i + 1);
+	KUNIT_ASSERT_EQ(test, i, start + len);
+	i = mb_find_next_bit(bitmap, max, i + 1);
+	KUNIT_ASSERT_EQ(test, max, i);
+}
+
+static void test_mark_diskspace_used(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct inode inode = { .i_sb = sb, };
+	struct ext4_allocation_context ac;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i;
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+
+	ac.ac_status = AC_STATUS_FOUND;
+	ac.ac_sb = sb;
+	ac.ac_inode = &inode;
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_mark_diskspace_used_range(test, &ac, ranges[i].start,
+					       ranges[i].len);
+}
+
 static void mbt_generate_buddy(struct super_block *sb, void *buddy,
 			       void *bitmap, struct ext4_group_info *grp)
 {
@@ -784,6 +835,7 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


