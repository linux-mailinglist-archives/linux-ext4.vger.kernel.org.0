Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5837F78956D
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjHZJr5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjHZJra (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:47:30 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71C172D;
        Sat, 26 Aug 2023 02:47:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXsRt4hQQz4f3jYF;
        Sat, 26 Aug 2023 17:47:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDH9DAryulkN08gBg--.20254S10;
        Sat, 26 Aug 2023 17:47:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] ext4: calculate free_clusters_count in cluster unit in verify_group_input
Date:   Sun, 27 Aug 2023 01:47:07 +0800
Message-Id: <20230826174712.4059355-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
References: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDH9DAryulkN08gBg--.20254S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWrJFyfJF15Cr18Aw4Dtwb_yoW8JF4fpa
        9xAF95KryrWryUWanxJ3yDXa1rWw4FyF15XFW8u34Sgr9rX3s3trnxtryYv3W5tan3CF9F
        q3WSgry7uFnrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jcjjkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The field free_cluster_count in struct ext4_new_group_data should be
in units of clusters.  In verify_group_input() this field is being
filled in units of blocks.  Fortunately, we don't support online
resizing of bigalloc file systems, and for non-bigalloc file systems,
the cluster size == block size.  But fix this in case we do support
online resizing of bigalloc file systems in the future.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/resize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a370ca1a2bd6..3ad2b1a900ad 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -154,8 +154,9 @@ static int verify_group_input(struct super_block *sb,
 
 	overhead = ext4_group_overhead_blocks(sb, group);
 	metaend = start + overhead;
-	input->free_clusters_count = free_blocks_count =
-		input->blocks_count - 2 - overhead - sbi->s_itb_per_group;
+	free_blocks_count = input->blocks_count - 2 - overhead -
+			    sbi->s_itb_per_group;
+	input->free_clusters_count = EXT4_B2C(sbi, free_blocks_count);
 
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT4-fs: adding %s group %u: %u blocks "
-- 
2.30.0

