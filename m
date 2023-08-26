Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03211789472
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjHZHvS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjHZHut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACF1FD7;
        Sat, 26 Aug 2023 00:50:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpsH25Prz4f3lDW;
        Sat, 26 Aug 2023 15:50:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S13;
        Sat, 26 Aug 2023 15:50:44 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/11] ext4: run mballoc test with different layouts setting
Date:   Sat, 26 Aug 2023 23:50:28 +0800
Message-Id: <20230826155028.4019470-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43KFWUCr47tr4xWw1DGFg_yoW5GFy7pa
        nIkF1Fkr1UWFsF9w4fK397Zw13Kw1kur48JryxW34FkF1xAws7GFs7tryYya4qqrWkZFn0
        vF1Y9w17u3y8Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIVyIUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use KUNIT_CASE_PARAM to run mbalaloc test with different layouts setting.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d643c56ac003..af48a39c8ba2 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -196,21 +196,11 @@ static int ext4_mb_mark_context_stub(struct ext4_mark_context *mc,
 	return 0;
 }
 
-#define TEST_BLOCKSIZE_BITS 10
-#define TEST_CLUSTER_BITS 3
-#define TEST_BLOCKS_PER_GROUP 8192
-#define TEST_GROUP_COUNT 4
-#define TEST_DESC_SIZE 64
 #define TEST_GOAL_GROUP 1
 static int mbt_kunit_init(struct kunit *test)
 {
-	struct mbt_ext4_block_layout layout = {
-		.blocksize_bits = TEST_BLOCKSIZE_BITS,
-		.cluster_bits = TEST_CLUSTER_BITS,
-		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
-		.group_count = TEST_GROUP_COUNT,
-		.desc_size = TEST_DESC_SIZE,
-	};
+	struct mbt_ext4_block_layout *layout =
+		(struct mbt_ext4_block_layout *)(test->param_value);
 	struct super_block *sb;
 	int ret;
 
@@ -218,7 +208,7 @@ static int mbt_kunit_init(struct kunit *test)
 	if (sb == NULL)
 		return -ENOMEM;
 
-	mbt_init_sb_layout(sb, &layout);
+	mbt_init_sb_layout(sb, layout);
 
 	ret = mbt_ctx_init(sb);
 	if (ret != 0) {
@@ -304,9 +294,43 @@ static void test_new_blocks_simple(struct kunit *test)
 		"unexpectedly get block when no block is available");
 }
 
+static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
+	{
+		.blocksize_bits = 10,
+		.cluster_bits = 3,
+		.blocks_per_group = 8192,
+		.group_count = 4,
+		.desc_size = 64,
+	},
+	{
+		.blocksize_bits = 12,
+		.cluster_bits = 3,
+		.blocks_per_group = 8192,
+		.group_count = 4,
+		.desc_size = 64,
+	},
+	{
+		.blocksize_bits = 18,
+		.cluster_bits = 3,
+		.blocks_per_group = 8192,
+		.group_count = 4,
+		.desc_size = 64,
+	},
+};
+
+static void mbt_show_layout(const struct mbt_ext4_block_layout *layout,
+			    char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "block_bits=%d cluster_bits=%d "
+			"blocks_per_group=%d group_count=%d desc_size=%d\n",
+			layout->blocksize_bits, layout->cluster_bits,
+			layout->blocks_per_group, layout->group_count,
+			layout->desc_size);
+}
+KUNIT_ARRAY_PARAM(mbt_layouts, mbt_test_layouts, mbt_show_layout);
 
 static struct kunit_case mbt_test_cases[] = {
-	KUNIT_CASE(test_new_blocks_simple),
+	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0

