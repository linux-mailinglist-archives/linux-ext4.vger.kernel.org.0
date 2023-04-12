Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8076DF053
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDLJ0j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjDLJ0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 05:26:17 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C047EDC;
        Wed, 12 Apr 2023 02:26:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxHQC2Q80z4f3nwX;
        Wed, 12 Apr 2023 17:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S20;
        Wed, 12 Apr 2023 17:26:13 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 18/19] ext4: add some kunit stub for mballoc kunit test
Date:   Thu, 13 Apr 2023 01:28:32 +0800
Message-Id: <20230412172833.2317696-19-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
References: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S20
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8XFW5Gw48KFWkKr4kWFg_yoW5XFWDpF
        s8AF1UCrW3Wr1Dua1Iy340gF4fGw1vgr1UJryfury3uFyxJrn7ZFyktFn0yF4YyFZrZFsx
        XFy5Zry3Cr1fW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/ext4/balloc.c  | 13 +++++++++++++
 fs/ext4/mballoc.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 094269488183..682336d3dac1 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -22,6 +22,7 @@
 #include "mballoc.h"
 
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
 					    ext4_group_t block_group);
@@ -267,6 +268,10 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 					     ext4_group_t block_group,
 					     struct buffer_head **bh)
 {
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
+				   sb, block_group, bh);
+#endif
 	unsigned int group_desc;
 	unsigned int offset;
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
@@ -423,6 +428,10 @@ struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 			      bool ignore_locked)
 {
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_read_block_bitmap_nowait,
+				   sb, block_group, ignore_locked);
+#endif
 	struct ext4_group_desc *desc;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh;
@@ -522,6 +531,10 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 			   struct buffer_head *bh)
 {
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_wait_block_bitmap,
+				   sb, block_group, bh);
+#endif
 	struct ext4_group_desc *desc;
 
 	if (!buffer_new(bh))
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 64860341ef2d..f95a48bc8e31 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -17,6 +17,7 @@
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * MUSTDO:
@@ -3744,6 +3745,10 @@ static int
 ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
 		      ext4_grpblk_t blkoff, ext4_grpblk_t len, int flags)
 {
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+	KUNIT_STATIC_STUB_REDIRECT(ext4_mb_mark_group_bb,
+				   mc, group, blkoff, len, flags);
+#endif
 	handle_t *handle = mc->handle;
 	struct super_block *sb = mc->sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-- 
2.30.0

