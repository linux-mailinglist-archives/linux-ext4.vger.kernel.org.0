Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174267B159C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjI1IFK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjI1IE6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3095;
        Thu, 28 Sep 2023 01:04:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cL5f3Nz4f3nJb;
        Thu, 28 Sep 2023 16:04:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S13;
        Thu, 28 Sep 2023 16:04:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
Date:   Fri, 29 Sep 2023 00:04:06 +0800
Message-Id: <20230928160407.142069-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S13
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWftw45WrWUuF4xGr4UArb_yoWDuF4Dpa
        n3AF1rur43WFsrWayxtryFv3WSgw18ZryUtryfuw1YkFyxAr93J3Z7tF10yF4F9FWxJFnx
        Xa1YkryUCrWxGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Here are prepared work:
1. Include mballoc-test.c to mballoc.c to be able test static function
in mballoc.c.
2. Implement static stub to avoid read IO to disk.
3. Construct fake super_block. Only partial members are set, more members
will be set when more functions are tested.
Then unit test for ext4_mb_new_blocks_simple is added.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc-test.c | 325 +++++++++++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.c      |   4 +
 2 files changed, 329 insertions(+)
 create mode 100644 fs/ext4/mballoc-test.c

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
new file mode 100644
index 000000000000..120c4944d2e1
--- /dev/null
+++ b/fs/ext4/mballoc-test.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 multiblocks allocation.
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+
+#include "ext4.h"
+
+struct mbt_grp_ctx {
+	struct buffer_head bitmap_bh;
+	/* desc and gd_bh are just the place holders for now */
+	struct ext4_group_desc desc;
+	struct buffer_head gd_bh;
+};
+
+struct mbt_ctx {
+	struct mbt_grp_ctx *grp_ctx;
+};
+
+struct mbt_ext4_super_block {
+	struct super_block sb;
+	struct mbt_ctx mbt_ctx;
+};
+
+#define MBT_CTX(_sb) (&(container_of((_sb), struct mbt_ext4_super_block, sb)->mbt_ctx))
+#define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
+
+static struct super_block *mbt_ext4_alloc_super_block(void)
+{
+	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
+	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
+
+	if (fsb == NULL || sbi == NULL || es == NULL)
+		goto out;
+
+	sbi->s_es = es;
+	fsb->sb.s_fs_info = sbi;
+	return &fsb->sb;
+
+out:
+	kfree(fsb);
+	kfree(sbi);
+	kfree(es);
+	return NULL;
+}
+
+static void mbt_ext4_free_super_block(struct super_block *sb)
+{
+	struct mbt_ext4_super_block *fsb =
+		container_of(sb, struct mbt_ext4_super_block, sb);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	kfree(sbi->s_es);
+	kfree(sbi);
+	kfree(fsb);
+}
+
+struct mbt_ext4_block_layout {
+	unsigned char blocksize_bits;
+	unsigned int cluster_bits;
+	uint32_t blocks_per_group;
+	ext4_group_t group_count;
+	uint16_t desc_size;
+};
+
+static void mbt_init_sb_layout(struct super_block *sb,
+			       struct mbt_ext4_block_layout *layout)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+
+	sb->s_blocksize = 1UL << layout->blocksize_bits;
+	sb->s_blocksize_bits = layout->blocksize_bits;
+
+	sbi->s_groups_count = layout->group_count;
+	sbi->s_blocks_per_group = layout->blocks_per_group;
+	sbi->s_cluster_bits = layout->cluster_bits;
+	sbi->s_cluster_ratio = 1U << layout->cluster_bits;
+	sbi->s_clusters_per_group = layout->blocks_per_group >>
+				    layout->cluster_bits;
+	sbi->s_desc_size = layout->desc_size;
+
+	es->s_first_data_block = cpu_to_le32(0);
+	es->s_blocks_count_lo = cpu_to_le32(layout->blocks_per_group *
+					    layout->group_count);
+}
+
+static int mbt_grp_ctx_init(struct super_block *sb,
+			    struct mbt_grp_ctx *grp_ctx)
+{
+	grp_ctx->bitmap_bh.b_data = kzalloc(EXT4_BLOCK_SIZE(sb), GFP_KERNEL);
+	if (grp_ctx->bitmap_bh.b_data == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void mbt_grp_ctx_release(struct mbt_grp_ctx *grp_ctx)
+{
+	kfree(grp_ctx->bitmap_bh.b_data);
+	grp_ctx->bitmap_bh.b_data = NULL;
+}
+
+static void mbt_ctx_mark_used(struct super_block *sb, ext4_group_t group,
+			      unsigned int start, unsigned int len)
+{
+	struct mbt_grp_ctx *grp_ctx = MBT_GRP_CTX(sb, group);
+
+	mb_set_bits(grp_ctx->bitmap_bh.b_data, start, len);
+}
+
+/* called after mbt_init_sb_layout */
+static int mbt_ctx_init(struct super_block *sb)
+{
+	struct mbt_ctx *ctx = MBT_CTX(sb);
+	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
+
+	ctx->grp_ctx = kcalloc(ngroups, sizeof(struct mbt_grp_ctx),
+			       GFP_KERNEL);
+	if (ctx->grp_ctx == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ngroups; i++)
+		if (mbt_grp_ctx_init(sb, &ctx->grp_ctx[i]))
+			goto out;
+
+	/*
+	 * first data block(first cluster in first group) is used by
+	 * metadata, mark it used to avoid to alloc data block at first
+	 * block which will fail ext4_sb_block_valid check.
+	 */
+	mb_set_bits(ctx->grp_ctx[0].bitmap_bh.b_data, 0, 1);
+
+	return 0;
+out:
+	while (i-- > 0)
+		mbt_grp_ctx_release(&ctx->grp_ctx[i]);
+	kfree(ctx->grp_ctx);
+	return -ENOMEM;
+}
+
+static void mbt_ctx_release(struct super_block *sb)
+{
+	struct mbt_ctx *ctx = MBT_CTX(sb);
+	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
+
+	for (i = 0; i < ngroups; i++)
+		mbt_grp_ctx_release(&ctx->grp_ctx[i]);
+	kfree(ctx->grp_ctx);
+}
+
+static struct buffer_head *
+ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
+				   bool ignore_locked)
+{
+	struct mbt_grp_ctx *grp_ctx = MBT_GRP_CTX(sb, block_group);
+
+	/* paired with brelse from caller of ext4_read_block_bitmap_nowait */
+	get_bh(&grp_ctx->bitmap_bh);
+	return &grp_ctx->bitmap_bh;
+}
+
+static int ext4_wait_block_bitmap_stub(struct super_block *sb,
+				       ext4_group_t block_group,
+				       struct buffer_head *bh)
+{
+	return 0;
+}
+
+static struct ext4_group_desc *
+ext4_get_group_desc_stub(struct super_block *sb, ext4_group_t block_group,
+			 struct buffer_head **bh)
+{
+	struct mbt_grp_ctx *grp_ctx = MBT_GRP_CTX(sb, block_group);
+
+	if (bh != NULL)
+		*bh = &grp_ctx->gd_bh;
+
+	return &grp_ctx->desc;
+}
+
+static int
+ext4_mb_mark_context_stub(handle_t *handle, struct super_block *sb, bool state,
+			  ext4_group_t group, ext4_grpblk_t blkoff,
+			  ext4_grpblk_t len, int flags,
+			  ext4_grpblk_t *ret_changed)
+{
+	struct mbt_grp_ctx *grp_ctx = MBT_GRP_CTX(sb, group);
+	struct buffer_head *bitmap_bh = &grp_ctx->bitmap_bh;
+
+	if (state)
+		mb_set_bits(bitmap_bh->b_data, blkoff, len);
+	else
+		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+
+	return 0;
+}
+
+#define TEST_BLOCKSIZE_BITS 10
+#define TEST_CLUSTER_BITS 3
+#define TEST_BLOCKS_PER_GROUP 8192
+#define TEST_GROUP_COUNT 4
+#define TEST_DESC_SIZE 64
+#define TEST_GOAL_GROUP 1
+static int mbt_kunit_init(struct kunit *test)
+{
+	struct mbt_ext4_block_layout layout = {
+		.blocksize_bits = TEST_BLOCKSIZE_BITS,
+		.cluster_bits = TEST_CLUSTER_BITS,
+		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
+		.group_count = TEST_GROUP_COUNT,
+		.desc_size = TEST_DESC_SIZE,
+	};
+	struct super_block *sb;
+	int ret;
+
+	sb = mbt_ext4_alloc_super_block();
+	if (sb == NULL)
+		return -ENOMEM;
+
+	mbt_init_sb_layout(sb, &layout);
+
+	ret = mbt_ctx_init(sb);
+	if (ret != 0) {
+		mbt_ext4_free_super_block(sb);
+		return ret;
+	}
+
+	test->priv = sb;
+	kunit_activate_static_stub(test,
+				   ext4_read_block_bitmap_nowait,
+				   ext4_read_block_bitmap_nowait_stub);
+	kunit_activate_static_stub(test,
+				   ext4_wait_block_bitmap,
+				   ext4_wait_block_bitmap_stub);
+	kunit_activate_static_stub(test,
+				   ext4_get_group_desc,
+				   ext4_get_group_desc_stub);
+	kunit_activate_static_stub(test,
+				   ext4_mb_mark_context,
+				   ext4_mb_mark_context_stub);
+	return 0;
+}
+
+static void mbt_kunit_exit(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+
+	mbt_ctx_release(sb);
+	mbt_ext4_free_super_block(sb);
+}
+
+static void test_new_blocks_simple(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct inode inode = { .i_sb = sb, };
+	struct ext4_allocation_request ar;
+	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
+	int err = 0;
+	ext4_fsblk_t found;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	ar.inode = &inode;
+
+	/* get block at goal */
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test, ar.goal, found,
+		"failed to alloc block at goal, expected %llu found %llu",
+		ar.goal, found);
+
+	/* get block after goal in goal group */
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test, ar.goal + EXT4_C2B(sbi, 1), found,
+		"failed to alloc block after goal in goal group, expected %llu found %llu",
+		ar.goal + 1, found);
+
+	/* get block after goal group */
+	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test,
+		ext4_group_first_block_no(sb, goal_group + 1), found,
+		"failed to alloc block after goal group, expected %llu found %llu",
+		ext4_group_first_block_no(sb, goal_group + 1), found);
+
+	/* get block before goal group */
+	for (i = goal_group; i < ext4_get_groups_count(sb); i++)
+		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test,
+		ext4_group_first_block_no(sb, 0) + EXT4_C2B(sbi, 1), found,
+		"failed to alloc block before goal group, expected %llu found %llu",
+		ext4_group_first_block_no(sb, 0 + EXT4_C2B(sbi, 1)), found);
+
+	/* no block available, fail to allocate block */
+	for (i = 0; i < ext4_get_groups_count(sb); i++)
+		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_NE_MSG(test, err, 0,
+		"unexpectedly get block when no block is available");
+}
+
+
+static struct kunit_case mbt_test_cases[] = {
+	KUNIT_CASE(test_new_blocks_simple),
+	{}
+};
+
+static struct kunit_suite mbt_test_suite = {
+	.name = "ext4_mballoc_test",
+	.init = mbt_kunit_init,
+	.exit = mbt_kunit_exit,
+	.test_cases = mbt_test_cases,
+};
+
+kunit_test_suites(&mbt_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c85a09b4434f..d72a5e132b9f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -7026,3 +7026,7 @@ ext4_mballoc_query_range(
 
 	return error;
 }
+
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+#include "mballoc-test.c"
+#endif
-- 
2.30.0

