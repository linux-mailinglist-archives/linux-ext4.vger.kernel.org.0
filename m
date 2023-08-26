Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED0789545
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHZJid (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHZJiG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:38:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC92719;
        Sat, 26 Aug 2023 02:37:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXsDv3HQhz4f3k6P;
        Sat, 26 Aug 2023 17:37:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3E6bqx+lkNx57Bg--.59420S13;
        Sat, 26 Aug 2023 17:37:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] ext4: simplify the gdbblock calculation in add_new_gdb_meta_bg
Date:   Sun, 27 Aug 2023 01:37:33 +0800
Message-Id: <20230826173735.4023594-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
References: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3E6bqx+lkNx57Bg--.59420S13
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkAF48trW5uFyxuF15Jwb_yoW8uFy3pa
        n7AF1rCr95GFyDuayxA3y0grn3Cw1xGry8JryfJ348Cr9xGr1kWF93tFyFyFyjgFW3tr12
        qr15Ary7Ar1kG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
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

We always call add_new_gdb_meta_bg with first group in mete_bg. Remove the
unnecessary ext4_meta_bg_first_group conversion to simplify the gdbblock
calculation.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/resize.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e2c81b589de8..4dc68400ba19 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -110,12 +110,6 @@ static ext4_group_t ext4_meta_bg_first_group(struct super_block *sb,
 	       EXT4_DESC_PER_BLOCK_BITS(sb);
 }
 
-static ext4_fsblk_t ext4_meta_bg_first_block_no(struct super_block *sb,
-					     ext4_group_t group) {
-	group = ext4_meta_bg_first_group(sb, group);
-	return ext4_group_first_block_no(sb, group);
-}
-
 static ext4_grpblk_t ext4_group_overhead_blocks(struct super_block *sb,
 						ext4_group_t group) {
 	ext4_grpblk_t overhead;
@@ -944,7 +938,13 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
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
@@ -954,8 +954,8 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
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

