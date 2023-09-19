Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC77A6265
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjISMQb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjISMQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8598E3;
        Tue, 19 Sep 2023 05:16:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqgcV43Knz4f400Y;
        Tue, 19 Sep 2023 20:16:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S14;
        Tue, 19 Sep 2023 20:16:11 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/12] ext4: run mballoc test with different layouts setting
Date:   Wed, 20 Sep 2023 04:15:32 +0800
Message-Id: <20230919201532.310085-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S14
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xZrWkCryrGw4rXrWrKrg_yoW5Xryfpa
        nIkF1Fkr15WFsF93W3K3s7Zw1agw1kur18Jry7W34FyFn7Aws7JFsrtryYya40qrWkXFn0
        vFn09r17C3y8Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
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

Use KUNIT_CASE_PARAM to run mballoc test with different layouts setting.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 120c4944d2e1..f94901fd3835 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -199,21 +199,11 @@ ext4_mb_mark_context_stub(handle_t *handle, struct super_block *sb, bool state,
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
 
@@ -221,7 +211,7 @@ static int mbt_kunit_init(struct kunit *test)
 	if (sb == NULL)
 		return -ENOMEM;
 
-	mbt_init_sb_layout(sb, &layout);
+	mbt_init_sb_layout(sb, layout);
 
 	ret = mbt_ctx_init(sb);
 	if (ret != 0) {
@@ -307,9 +297,43 @@ static void test_new_blocks_simple(struct kunit *test)
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
+		.blocksize_bits = 16,
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
+		 "blocks_per_group=%d group_count=%d desc_size=%d\n",
+		 layout->blocksize_bits, layout->cluster_bits,
+		 layout->blocks_per_group, layout->group_count,
+		 layout->desc_size);
+}
+KUNIT_ARRAY_PARAM(mbt_layouts, mbt_test_layouts, mbt_show_layout);
 
 static struct kunit_case mbt_test_cases[] = {
-	KUNIT_CASE(test_new_blocks_simple),
+	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0

