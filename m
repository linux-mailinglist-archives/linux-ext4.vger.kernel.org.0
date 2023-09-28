Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05197B1596
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjI1IFH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjI1IE5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:57 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9592;
        Thu, 28 Sep 2023 01:04:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cM4XgLz4f3kkH;
        Thu, 28 Sep 2023 16:04:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S12;
        Thu, 28 Sep 2023 16:04:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] ext4: add some kunit stub for mballoc kunit test
Date:   Fri, 29 Sep 2023 00:04:05 +0800
Message-Id: <20230928160407.142069-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S12
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8uF47Kr1fGw48Cr4rZrb_yoW5GFW5p3
        ZFyF1UGr43Ww1q9F4Ika40q3WxWw1xKF1DJryfury3uF97JFnxZFZ7JF90ya1YvFZIvFsr
        X3W5Zry3Cr1fW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Multiblocks allocation will read and write block bitmap and group
descriptor which reside on disk. Add kunit stub to function
ext4_get_group_desc, ext4_read_block_bitmap_nowait, ext4_wait_block_bitmap
and ext4_mb_mark_context to avoid real IO to disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/balloc.c  | 10 ++++++++++
 fs/ext4/mballoc.c |  5 +++++
 2 files changed, 15 insertions(+)

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
index d0cc6d7e2ffb..c85a09b4434f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -18,6 +18,7 @@
 #include <linux/backing-dev.h>
 #include <linux/freezer.h>
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * MUSTDO:
@@ -3967,6 +3968,10 @@ ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
 	int err;
 	unsigned int i, already, changed = len;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_mb_mark_context,
+				   handle, sb, state, group, blkoff, len,
+				   flags, ret_changed);
+
 	if (ret_changed)
 		*ret_changed = 0;
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
-- 
2.30.0

