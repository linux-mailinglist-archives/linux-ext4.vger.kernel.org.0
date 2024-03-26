Return-Path: <linux-ext4+bounces-1753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D688C3FF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C388307652
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682412BEBA;
	Tue, 26 Mar 2024 13:42:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4E126F30;
	Tue, 26 Mar 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460544; cv=none; b=kp8ndJ94dgnRtLh0lYDnuYZaLI4S6LpPApDDvGutC/F/bG/oW0z8id63nRzARIx2VmXYCjRQuy7MB5TwZDUI5aU3apNWOJmtHzAMcOAQjzc8AvSyHJ3r2RAZIDOmjGH/RKGTqCup9V/3JQMkaO4kNlM5w4cX3/B/KUyc5YQTwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460544; c=relaxed/simple;
	bh=43XEMOYK3ZhQsU0mW9vnq/Hdvqc0TOl/lJ/ZjN8LKxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozCxmopqkqDPyD2wN+dHXFha7OBtB6Jym++jCzjCa/xvIYkYB2c+P41yocXOKMBcHUD5oLNJDe6PeBkaypueKYBZu4zwUjYIPBLVSDnSPA37y4iXdvtSMkrUT1XKWWAz8eg6mgV0XLsdoHo/koXf1mIegAf3YyOYP7cSEprkRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3rZX35QRz4f3jY2;
	Tue, 26 Mar 2024 21:42:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9DCBB1A019F;
	Tue, 26 Mar 2024 21:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S4;
	Tue, 26 Mar 2024 21:42:18 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 2/5] ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
Date: Wed, 27 Mar 2024 05:38:20 +0800
Message-Id: <20240326213823.528302-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW7ur1rJF4DtF1xGF4DArb_yoW5Kw48pa
	yqkFnYkr45Zwsa9w4fC3s7Zw1Sgw1kZr48JryfWF9avFW7Jas3CFn5KFy5GrW0qr4kXrn0
	vFyq9ry7G397CF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jhpndUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add test_mb_mark_used_cost to estimate runtime of mb_mark_used.

Result of unit test is as following:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
...
        # Subtest: test_mb_mark_used_cost
    # test_mb_mark_used_cost: costed jiffies 311
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_mb_mark_used_cost: costed jiffies 304
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
 # SKIP blocksize exceeds pagesize
    # test_mb_mark_used_cost.speed: slow
    # test_mb_mark_used_cost: pass:2 fail:0 skip:1 total:3
    ok 7 test_mb_mark_used_cost
...

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 044ca5238f41..cb1a551f9596 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -859,6 +859,56 @@ static void test_mb_free_blocks(struct kunit *test)
 	ext4_mb_unload_buddy(&e4b);
 }
 
+#define COUNT_FOR_ESTIMATE 1000000
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
@@ -894,6 +944,10 @@ static void mbt_show_layout(const struct mbt_ext4_block_layout *layout,
 }
 KUNIT_ARRAY_PARAM(mbt_layouts, mbt_test_layouts, mbt_show_layout);
 
+static const struct kunit_attributes slow_attr = {
+	.speed = KUNIT_SPEED_SLOW,
+};
+
 static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
@@ -901,6 +955,8 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM_ATTR(test_mb_mark_used_cost, mbt_layouts_gen_params,
+			      slow_attr),
 	{}
 };
 
-- 
2.30.0


