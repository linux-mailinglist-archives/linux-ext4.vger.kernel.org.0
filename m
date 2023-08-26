Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B255D789478
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHZHvW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHZHut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1226A1;
        Sat, 26 Aug 2023 00:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpsG1xvFz4f3lVF;
        Sat, 26 Aug 2023 15:50:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S9;
        Sat, 26 Aug 2023 15:50:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/11] ext4: Separate block bitmap and buddy bitmap freeing in ext4_group_add_blocks()
Date:   Sat, 26 Aug 2023 23:50:24 +0800
Message-Id: <20230826155028.4019470-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDJw4fuw43WFWkKry8Krg_yoW8KF4Upr
        9Fkr15Crn5GrnruFs7C34jq3W8K3ykCF45GrWrZr1xCF9xXF9ak3WvyF15Ja1UtFs3AFsF
        q3yY934xuw129aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
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

This patch separates block bitmap and buddy bitmap freeing in order to
udpate block bitmap with ext4_mb_mark_context in following patch.
The reason why this can be sperated is explained in previous submit.
Put the explanation here to simplify the code archeology to
ext4_group_add_blocks():

Separated freeing is safe with concurrent allocation as long as:
1. Firstly allocate block in buddy bitmap, and then in block bitmap.
2. Firstly free block in block bitmap, and then buddy bitmap.
Then freed block will only be available to allocation when both buddy
bitmap and block bitmap are updated by freeing.
Allocation obeys rule 1 already, just do sperated freeing with rule 2.

Separated freeing has no race with generate_buddy as:
Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
buddy page can be found in sbi->s_buddy_cache and no more buddy
initialization of the buddy page will be executed concurrently until
buddy page is unloaded. As we always do free in "load buddy, free,
unload buddy" sequence, separated freeing has no race with generate_buddy.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 25265531cb6a..bb08a71a6e61 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6764,20 +6764,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	if (err)
 		goto error_return;
 
-	/*
-	 * need to update group_info->bb_free and bitmap
-	 * with group lock held. generate_buddy look at
-	 * them with group lock_held
-	 */
 	ext4_lock_group(sb, block_group);
 	mb_clear_bits(bitmap_bh->b_data, bit, cluster_count);
-	mb_free_blocks(NULL, &e4b, bit, cluster_count);
 	free_clusters_count = clusters_freed +
 		ext4_free_group_clusters(sb, desc);
 	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
 	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
 	ext4_group_desc_csum_set(sb, block_group, desc);
 	ext4_unlock_group(sb, block_group);
+
+	ext4_lock_group(sb, block_group);
+	mb_free_blocks(NULL, &e4b, bit, cluster_count);
+	ext4_unlock_group(sb, block_group);
+
 	percpu_counter_add(&sbi->s_freeclusters_counter,
 			   clusters_freed);
 
-- 
2.30.0

