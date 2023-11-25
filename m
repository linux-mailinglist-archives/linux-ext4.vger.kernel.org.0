Return-Path: <linux-ext4+bounces-146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A67F88E1
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E360A281945
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069E8F7A;
	Sat, 25 Nov 2023 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBA10FB;
	Fri, 24 Nov 2023 23:42:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SckND1h0kz4f3kKv;
	Sat, 25 Nov 2023 15:42:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05F4C1A0373;
	Sat, 25 Nov 2023 15:42:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgCX7Ut8pWFlk8TCBw--.12413S7;
	Sat, 25 Nov 2023 15:42:54 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
Date: Sat, 25 Nov 2023 23:41:44 +0800
Message-Id: <20231125154144.3943442-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCX7Ut8pWFlk8TCBw--.12413S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ktFW5Aw4xXw43Zr17GFg_yoW5Gryfpa
	15urn0kr45XrnxWr43WrZrC3W3Kw4kZrWktryfWrn0qF47GF98Aa10kF15Gw48Jr4kXa43
	Z3Wqqa47Gr4xCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test for ext4_mb_mark_diskspace_used

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index b68f44740..8d5d27ab5 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -470,6 +470,59 @@ static void test_free_blocks_simple(struct kunit *test)
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
+	ext4_grpblk_t max;
+	struct ext4_allocation_context ac;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i;
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+
+	ac.ac_status = AC_STATUS_FOUND;
+	ac.ac_sb = sb;
+	ac.ac_inode = &inode;
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_mark_diskspace_used_range(test, &ac, ranges[i].start,
+					       ranges[i].len);
+}
+
 static void mbt_generate_buddy(struct super_block *sb, void *buddy,
 			       void *bitmap, struct ext4_group_info *grp)
 {
@@ -784,6 +837,7 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


