Return-Path: <linux-ext4+bounces-642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5382272A
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900761F22B53
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65B4A27;
	Wed,  3 Jan 2024 02:51:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753017980;
	Wed,  3 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4Z3H69zjz4f3n6J;
	Wed,  3 Jan 2024 10:50:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 815AA1A017D;
	Wed,  3 Jan 2024 10:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3U0SNy5RlDGn8FQ--.36935S4;
	Wed, 03 Jan 2024 10:50:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ext4: Add unit test of ext4_mb_generate_buddy
Date: Wed,  3 Jan 2024 18:48:57 +0800
Message-Id: <20240103104900.464789-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3U0SNy5RlDGn8FQ--.36935S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUCrWUJFy3GrWDtr1xuFg_yoW3KFWrpa
	s0kF1F9r4UCr4kWw47GrWkZ3WS9w4v9rWrKryxWF15ArWSyas5A3Z5GFyYyFsYyFWxXFs3
	Z3Wjga47CrW2k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsmiiDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test of ext4_mb_generate_buddy

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 207 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 3aac42ea6..6964974fa 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -28,6 +28,50 @@ struct mbt_ext4_super_block {
 #define MBT_CTX(_sb) (&(container_of((_sb), struct mbt_ext4_super_block, sb)->mbt_ctx))
 #define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
 
+static const struct super_operations mbt_sops = {
+};
+
+static int mbt_mb_init(struct super_block *sb)
+{
+	int ret;
+
+	/* needed by ext4_mb_init->bdev_nonrot(sb->s_bdev) */
+	sb->s_bdev = kzalloc(sizeof(*sb->s_bdev), GFP_KERNEL);
+	if (sb->s_bdev == NULL)
+		return -ENOMEM;
+
+	sb->s_bdev->bd_queue = kzalloc(sizeof(struct request_queue), GFP_KERNEL);
+	if (sb->s_bdev->bd_queue == NULL) {
+		kfree(sb->s_bdev);
+		return -ENOMEM;
+	}
+
+	/*
+	 * needed by ext4_mb_init->ext4_mb_init_backend-> sbi->s_buddy_cache =
+	 * new_inode(sb);
+	 */
+	INIT_LIST_HEAD(&sb->s_inodes);
+	sb->s_op = &mbt_sops;
+
+	ret = ext4_mb_init(sb);
+	if (ret != 0)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	kfree(sb->s_bdev->bd_queue);
+	kfree(sb->s_bdev);
+	return ret;
+}
+
+static void mbt_mb_release(struct super_block *sb)
+{
+	ext4_mb_release(sb);
+	kfree(sb->s_bdev->bd_queue);
+	kfree(sb->s_bdev);
+}
+
 static struct super_block *mbt_ext4_alloc_super_block(void)
 {
 	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
@@ -37,8 +81,16 @@ static struct super_block *mbt_ext4_alloc_super_block(void)
 	if (fsb == NULL || sbi == NULL || es == NULL)
 		goto out;
 
+	sbi->s_blockgroup_lock =
+		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
+	if (!sbi->s_blockgroup_lock)
+		goto out;
+
+	bgl_lock_init(sbi->s_blockgroup_lock);
+
 	sbi->s_es = es;
 	fsb->sb.s_fs_info = sbi;
+
 	return &fsb->sb;
 
 out:
@@ -54,6 +106,7 @@ static void mbt_ext4_free_super_block(struct super_block *sb)
 		container_of(sb, struct mbt_ext4_super_block, sb);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
+	kfree(sbi->s_blockgroup_lock);
 	kfree(sbi->s_es);
 	kfree(sbi);
 	kfree(fsb);
@@ -83,6 +136,9 @@ static void mbt_init_sb_layout(struct super_block *sb,
 	sbi->s_clusters_per_group = layout->blocks_per_group >>
 				    layout->cluster_bits;
 	sbi->s_desc_size = layout->desc_size;
+	sbi->s_desc_per_block_bits =
+		sb->s_blocksize_bits - (fls(layout->desc_size) - 1);
+	sbi->s_desc_per_block = 1 << sbi->s_desc_per_block_bits;
 
 	es->s_first_data_block = cpu_to_le32(0);
 	es->s_blocks_count_lo = cpu_to_le32(layout->blocks_per_group *
@@ -240,6 +296,14 @@ static int mbt_kunit_init(struct kunit *test)
 	kunit_activate_static_stub(test,
 				   ext4_mb_mark_context,
 				   ext4_mb_mark_context_stub);
+
+	/* stub function will be called in mt_mb_init->ext4_mb_init */
+	if (mbt_mb_init(sb) != 0) {
+		mbt_ctx_release(sb);
+		mbt_ext4_free_super_block(sb);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -247,6 +311,7 @@ static void mbt_kunit_exit(struct kunit *test)
 {
 	struct super_block *sb = (struct super_block *)test->priv;
 
+	mbt_mb_release(sb);
 	mbt_ctx_release(sb);
 	mbt_ext4_free_super_block(sb);
 }
@@ -392,6 +457,147 @@ static void test_free_blocks_simple(struct kunit *test)
 			ranges[i].start, ranges[i].len);
 }
 
+static void mbt_generate_buddy(struct super_block *sb, void *buddy,
+			       void *bitmap, struct ext4_group_info *grp)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	uint32_t order, off;
+	void *bb, *bb_h;
+	int max;
+
+	memset(buddy, 0xff, sb->s_blocksize);
+	memset(grp, 0, offsetof(struct ext4_group_info,
+				 bb_counters[MB_NUM_ORDERS(sb)]));
+
+	bb = bitmap;
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	bb_h = buddy + sbi->s_mb_offsets[1];
+
+	off = mb_find_next_zero_bit(bb, max, 0);
+	grp->bb_first_free = off;
+	while (off < max) {
+		grp->bb_counters[0]++;
+		grp->bb_free++;
+
+		if (!(off & 1) && !mb_test_bit(off + 1, bb)) {
+			grp->bb_free++;
+			grp->bb_counters[0]--;
+			mb_clear_bit(off >> 1, bb_h);
+			grp->bb_counters[1]++;
+			grp->bb_largest_free_order = 1;
+			off++;
+		}
+
+		off = mb_find_next_zero_bit(bb, max, off + 1);
+	}
+
+	for (order = 1; order < MB_NUM_ORDERS(sb) - 1; order++) {
+		bb = buddy + sbi->s_mb_offsets[order];
+		bb_h = buddy + sbi->s_mb_offsets[order + 1];
+		max = max >> 1;
+		off = mb_find_next_zero_bit(bb, max, 0);
+
+		while (off < max) {
+			if (!(off & 1) && !mb_test_bit(off + 1, bb)) {
+				mb_set_bits(bb, off, 2);
+				grp->bb_counters[order] -= 2;
+				mb_clear_bit(off >> 1, bb_h);
+				grp->bb_counters[order + 1]++;
+				grp->bb_largest_free_order = order + 1;
+				off++;
+			}
+
+			off = mb_find_next_zero_bit(bb, max, off + 1);
+		}
+	}
+
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	off = mb_find_next_zero_bit(bitmap, max, 0);
+	while (off < max) {
+		grp->bb_fragments++;
+
+		off = mb_find_next_bit(bitmap, max, off + 1);
+		if (off + 1 >= max)
+			break;
+
+		off = mb_find_next_zero_bit(bitmap, max, off + 1);
+	}
+}
+
+static void
+mbt_validate_group_info(struct kunit *test, struct ext4_group_info *grp1,
+			struct ext4_group_info *grp2)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	int i;
+
+	KUNIT_ASSERT_EQ(test, grp1->bb_first_free,
+			grp2->bb_first_free);
+	KUNIT_ASSERT_EQ(test, grp1->bb_fragments,
+			grp2->bb_fragments);
+	KUNIT_ASSERT_EQ(test, grp1->bb_free, grp2->bb_free);
+	KUNIT_ASSERT_EQ(test, grp1->bb_largest_free_order,
+			grp2->bb_largest_free_order);
+
+	for (i = 1; i < MB_NUM_ORDERS(sb); i++) {
+		KUNIT_ASSERT_EQ_MSG(test, grp1->bb_counters[i],
+				    grp2->bb_counters[i],
+				    "bb_counters[%d] diffs, expected %d, generated %d",
+				    i, grp1->bb_counters[i],
+				    grp2->bb_counters[i]);
+	}
+}
+
+static void
+do_test_generate_buddy(struct kunit *test, struct super_block *sb, void *bitmap,
+			   void *mbt_buddy, struct ext4_group_info *mbt_grp,
+			   void *ext4_buddy, struct ext4_group_info *ext4_grp)
+{
+	int i;
+
+	mbt_generate_buddy(sb, mbt_buddy, bitmap, mbt_grp);
+
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		ext4_grp->bb_counters[i] = 0;
+	/* needed by validation in ext4_mb_generate_buddy */
+	ext4_grp->bb_free = mbt_grp->bb_free;
+	memset(ext4_buddy, 0xff, sb->s_blocksize);
+	ext4_mb_generate_buddy(sb, ext4_buddy, bitmap, TEST_GOAL_GROUP,
+			       ext4_grp);
+
+	KUNIT_ASSERT_EQ(test, memcmp(mbt_buddy, ext4_buddy, sb->s_blocksize),
+			0);
+	mbt_validate_group_info(test, mbt_grp, ext4_grp);
+}
+
+static void test_mb_generate_buddy(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	void *bitmap, *expected_bb, *generate_bb;
+	struct ext4_group_info *expected_grp, *generate_grp;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i;
+
+	bitmap = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bitmap);
+	expected_bb = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_bb);
+	generate_bb = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, generate_bb);
+	expected_grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
+				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_grp);
+	generate_grp = ext4_get_group_info(sb, TEST_GOAL_GROUP);
+	KUNIT_ASSERT_NOT_NULL(test, generate_grp);
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+	for (i = 0; i < TEST_RANGE_COUNT; i++) {
+		mb_set_bits(bitmap, ranges[i].start, ranges[i].len);
+		do_test_generate_buddy(test, sb, bitmap, expected_bb,
+				       expected_grp, generate_bb, generate_grp);
+	}
+}
+
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
 	{
 		.blocksize_bits = 10,
@@ -430,6 +636,7 @@ KUNIT_ARRAY_PARAM(mbt_layouts, mbt_test_layouts, mbt_show_layout);
 static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


