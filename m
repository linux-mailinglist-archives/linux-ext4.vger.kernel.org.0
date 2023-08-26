Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2E789473
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjHZHvT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjHZHut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A226A6;
        Sat, 26 Aug 2023 00:50:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXpsH3r2Jz4f3jq3;
        Sat, 26 Aug 2023 15:50:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S11;
        Sat, 26 Aug 2023 15:50:44 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/11] ext4: add some kunit stub for mballoc kunit test
Date:   Sat, 26 Aug 2023 23:50:26 +0800
Message-Id: <20230826155028.4019470-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8Xw15JFWDZryUGrW3KFg_yoW5Jw4rp3
        ZrAF1DGr43Ww1q9F4Ika40q3WxGw1xKF1UJryfur13uFW7JrnxuFWktFn0yF4YvFsxZFsr
        X3W5Zry3Cr1fW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Multiblocks allocation will read and write block bitmap and group
descriptor which reside on disk. Add kunit stub to function
ext4_get_group_desc, ext4_read_block_bitmap_nowait, ext4_wait_block_bitmap
and ext4_mb_mark_context to avoid real IO to disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c  | 10 ++++++++++
 fs/ext4/mballoc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 79b20d6ae39e..b0bf255b159f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -22,6 +22,7 @@
 #include "mballoc.h"
 
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
 					    ext4_group_t block_group);
@@ -274,6 +275,9 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh_p;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
+				   sb, block_group, bh);
+
 	if (block_group >= ngroups) {
 		ext4_error(sb, "block_group >= groups_count - block_group = %u,"
 			   " groups_count = %u", block_group, ngroups);
@@ -468,6 +472,9 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	ext4_fsblk_t bitmap_blk;
 	int err;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_read_block_bitmap_nowait,
+				   sb, block_group, ignore_locked);
+
 	desc = ext4_get_group_desc(sb, block_group, NULL);
 	if (!desc)
 		return ERR_PTR(-EFSCORRUPTED);
@@ -563,6 +570,9 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 {
 	struct ext4_group_desc *desc;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_wait_block_bitmap,
+				   sb, block_group, bh);
+
 	if (!buffer_new(bh))
 		return 0;
 	desc = ext4_get_group_desc(sb, block_group, NULL);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fdffa3b40bcd..5961b08ae7df 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -17,6 +17,7 @@
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * MUSTDO:
@@ -3990,6 +3991,9 @@ ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
 	int err;
 	unsigned int i, already, changed = len;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_mb_mark_context,
+				   mc, group, blkoff, len, flags);
+
 	mc->changed = 0;
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh))
-- 
2.30.0

