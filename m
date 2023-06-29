Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB41C742086
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjF2Gj0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjF2GjR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 02:39:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F22D63;
        Wed, 28 Jun 2023 23:39:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs81W720nz4f4YHT;
        Thu, 29 Jun 2023 14:39:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnUy4LJ51kJfVfMA--.3175S9;
        Thu, 29 Jun 2023 14:39:12 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v5 7/8] ext4: add some kunit stub for mballoc kunit test
Date:   Thu, 29 Jun 2023 22:40:06 +0800
Message-Id: <20230629144007.1263510-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
References: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUy4LJ51kJfVfMA--.3175S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8XFW5Xr15tF15ur1xKrg_yoW5XF43pa
        n0yF1DGr43uw1q9a1Iy340g3WfGw10gr1UJryfur13uFy7JFnrZFWkJFnYyF4YyFZxZF47
        XFy5Zry3Cr1fW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VCY1x0262k0Y48FwI0_
        Jr0_Gr1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
        cSsGvfC2KfnxnUUI43ZEXa7sRizuWDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Multiblocks allocation will read and write block bitmap and group
descriptor which reside on disk. Add kunit stub to function
ext4_get_group_desc, ext4_read_block_bitmap_nowait, ext4_wait_block_bitmap
and ext4_mb_mark_group_bb to avoid real IO to disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c  | 16 ++++++++++++++++
 fs/ext4/mballoc.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1f72f977c6db..d39655fb2f53 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -22,6 +22,7 @@
 #include "mballoc.h"
 
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
 					    ext4_group_t block_group);
@@ -274,6 +275,11 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh_p;
 
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
+				   sb, block_group, bh);
+#endif
+
 	if (block_group >= ngroups) {
 		ext4_error(sb, "block_group >= groups_count - block_group = %u,"
 			   " groups_count = %u", block_group, ngroups);
@@ -468,6 +474,11 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	ext4_fsblk_t bitmap_blk;
 	int err;
 
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_read_block_bitmap_nowait,
+				   sb, block_group, ignore_locked);
+#endif
+
 	desc = ext4_get_group_desc(sb, block_group, NULL);
 	if (!desc)
 		return ERR_PTR(-EFSCORRUPTED);
@@ -563,6 +574,11 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 {
 	struct ext4_group_desc *desc;
 
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_wait_block_bitmap,
+				   sb, block_group, bh);
+#endif
+
 	if (!buffer_new(bh))
 		return 0;
 	desc = ext4_get_group_desc(sb, block_group, NULL);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 54254f08ea0c..dd2fc0546c0b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -17,6 +17,7 @@
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * MUSTDO:
@@ -3970,6 +3971,11 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
 	int err;
 	unsigned int i, already, changed = len;
 
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_mb_mark_group_bb,
+				   mc, group, blkoff, len, flags);
+#endif
+
 	mc->changed = 0;
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh))
-- 
2.30.0

