Return-Path: <linux-ext4+bounces-147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD917F88E3
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 08:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF9A1C20B38
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA648C19;
	Sat, 25 Nov 2023 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F910F4;
	Fri, 24 Nov 2023 23:42:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SckND0QQwz4f3kKt;
	Sat, 25 Nov 2023 15:42:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CEB341A017D;
	Sat, 25 Nov 2023 15:42:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgCX7Ut8pWFlk8TCBw--.12413S6;
	Sat, 25 Nov 2023 15:42:54 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ext4: Add unit test for mb_free_blocks
Date: Sat, 25 Nov 2023 23:41:43 +0800
Message-Id: <20231125154144.3943442-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125154144.3943442-1-shikemeng@huaweicloud.com>
References: <20231125154144.3943442-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCX7Ut8pWFlk8TCBw--.12413S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDAFy8Kry3XFy8Gr1fXrb_yoW5Zr47pa
	sxCF1Ykr45urnruw4fGr4kX3WSgw4vvrWkKryxWF1YqFWayF93KF1vkFy5Jr48tFs7Xa12
	v3Z0qFy7Gr4xuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test for mb_free_blocks.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 38e3644cb..b68f44740 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -675,6 +675,74 @@ static void test_mb_mark_used(struct kunit *test)
 	ext4_mb_unload_buddy(&e4b);
 }
 
+static void
+test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
+			  ext4_grpblk_t start, ext4_grpblk_t len, void *bitmap,
+			  void *buddy, struct ext4_group_info *grp)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	int i;
+
+	/* mb_free_blocks will WARN if len is 0 */
+	if (len == 0)
+		return;
+
+	mb_free_blocks(NULL, e4b, start, len);
+
+	mb_clear_bits(bitmap, start, len);
+	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
+	grp->bb_free += len;
+	memset(buddy, 0xff, sb->s_blocksize);
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		grp->bb_counters[i] = 0;
+	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
+
+	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
+			0);
+	mbt_validate_group_info(test, grp, e4b->bd_info);
+
+}
+
+static void test_mb_free_blocks(struct kunit *test)
+{
+	struct ext4_buddy e4b;
+	struct super_block *sb = (struct super_block *)test->priv;
+	void *bitmap, *buddy;
+	struct ext4_group_info *grp;
+	struct ext4_free_extent ex;
+	int ret;
+	int i;
+	struct test_range ranges[TEST_RANGE_COUNT];
+
+	/* buddy cache assumes that each page contains at least one block */
+	if (sb->s_blocksize > PAGE_SIZE)
+		kunit_skip(test, "blocksize exceeds pagesize");
+
+	bitmap = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bitmap);
+	buddy = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
+	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
+				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
+
+	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ex.fe_start = 0;
+	ex.fe_len = EXT4_CLUSTERS_PER_GROUP(sb);
+	ex.fe_group = TEST_GOAL_GROUP;
+	mb_mark_used(&e4b, &ex);
+	grp->bb_free = 0;
+	memset(bitmap, 0xff, sb->s_blocksize);
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_mb_free_blocks_range(test, &e4b, ranges[i].start,
+					  ranges[i].len, bitmap, buddy, grp);
+
+	ext4_mb_unload_buddy(&e4b);
+}
+
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
 	{
 		.blocksize_bits = 10,
@@ -715,6 +783,7 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


