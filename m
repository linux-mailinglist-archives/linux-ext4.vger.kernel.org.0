Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA686E3DC5
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDQDEg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 23:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDQDED (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 23:04:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4E12718;
        Sun, 16 Apr 2023 20:04:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q0Bht5C8Fz4f4bKD;
        Mon, 17 Apr 2023 11:03:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODIXtzxkfzJgHA--.17426S20;
        Mon, 17 Apr 2023 11:03:59 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 18/19] ext4: add some kunit stub for mballoc kunit test
Date:   Mon, 17 Apr 2023 19:06:16 +0800
Message-Id: <20230417110617.2664129-19-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODIXtzxkfzJgHA--.17426S20
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8XF1kJw4rXFyxAFWkZwb_yoW5XF43pa
        n0yF1DGr43uw1q9F4Iy34Fg3WfGw10gr1UJry3ur13uFy7JrnrZayktFnYyF4YvFZxZFsr
        XF15Zry3Cr1fW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVb
        yDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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
index 094269488183..c195c5c23256 100644
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
@@ -429,6 +435,11 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
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
@@ -524,6 +535,11 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
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
index 6aac3ee1bb6d..e03589586122 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -17,6 +17,7 @@
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * MUSTDO:
@@ -3752,6 +3753,11 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
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

