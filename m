Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F294378956F
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHZJr6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHZJrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:47:31 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8DC4;
        Sat, 26 Aug 2023 02:47:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXsRv2xw3z4f3kFb;
        Sat, 26 Aug 2023 17:47:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDH9DAryulkN08gBg--.20254S13;
        Sat, 26 Aug 2023 17:47:26 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] ext4: simplify the gdbblock calculation in add_new_gdb_meta_bg
Date:   Sun, 27 Aug 2023 01:47:10 +0800
Message-Id: <20230826174712.4059355-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
References: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDH9DAryulkN08gBg--.20254S13
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkAF13Kr4xArykKryrtFb_yoW8Kr48pa
        n3AF1fCr98KFWDua97A3y0gwn3Cw1xJw1kJrWfJ348Cr9rGF4kWF93tFyFyFyj9FW3tr12
        qr15AryUCr1kG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxD7aUUUUU
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

We always call add_new_gdb_meta_bg with first group in mete_bg. Remove the
unnecessary ext4_meta_bg_first_group conversion to simplify the gdbblock
calculation.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/resize.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e2c81b589de8..5e9084ff131c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -104,18 +104,6 @@ int ext4_resize_end(struct super_block *sb, bool update_backups)
 	return 0;
 }
 
-static ext4_group_t ext4_meta_bg_first_group(struct super_block *sb,
-					     ext4_group_t group) {
-	return (group >> EXT4_DESC_PER_BLOCK_BITS(sb)) <<
-	       EXT4_DESC_PER_BLOCK_BITS(sb);
-}
-
-static ext4_fsblk_t ext4_meta_bg_first_block_no(struct super_block *sb,
-					     ext4_group_t group) {
-	group = ext4_meta_bg_first_group(sb, group);
-	return ext4_group_first_block_no(sb, group);
-}
-
 static ext4_grpblk_t ext4_group_overhead_blocks(struct super_block *sb,
 						ext4_group_t group) {
 	ext4_grpblk_t overhead;
@@ -944,7 +932,13 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 }
 
 /*
- * add_new_gdb_meta_bg is the sister of add_new_gdb.
+ * If there is no available space in the existing block group descriptors for
+ * the new block group and there are no reserved block group descriptors, then
+ * the meta_bg feature will get enabled, and es->s_first_meta_bg will get set
+ * to the first block group that is managed using meta_bg and s_first_meta_bg
+ * must be a multiple of EXT4_DESC_PER_BLOCK(sb).
+ * This function will be called when first group of meta_bg is added to bring
+ * new group descriptors block of new added meta_bg.
  */
 static int add_new_gdb_meta_bg(struct super_block *sb,
 			       handle_t *handle, ext4_group_t group) {
@@ -954,8 +948,8 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	unsigned long gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 	int err;
 
-	gdblock = ext4_meta_bg_first_block_no(sb, group) +
-		   ext4_bg_has_super(sb, group);
+	gdblock = ext4_group_first_block_no(sb, group) +
+		  ext4_bg_has_super(sb, group);
 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
 	if (IS_ERR(gdb_bh))
 		return PTR_ERR(gdb_bh);
-- 
2.30.0

