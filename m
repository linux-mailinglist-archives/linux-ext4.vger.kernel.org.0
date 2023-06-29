Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB8741F09
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjF2EAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjF2D7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 23:59:55 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E432D62;
        Wed, 28 Jun 2023 20:59:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qs4Tc4c2Yz4f3tDn;
        Thu, 29 Jun 2023 11:59:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quiwAZ1kw6DMMg--.26995S13;
        Thu, 29 Jun 2023 11:59:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] ext4: correct gdblock calculation in add_new_gdb_meta_bg to support non first group
Date:   Thu, 29 Jun 2023 20:00:42 +0800
Message-Id: <20230629120044.1261968-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quiwAZ1kw6DMMg--.26995S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xuw1xWrWkCF4kAr4Dtwb_yoW8Cw4kpa
        n7AFy5Kry8Gr4q9ayxA3y0qrn5Cw18W3yDJrWfW348Cry7Gw1xGFn3tFyFyF1YgFW3Xr12
        qr4Yvry7Ar48W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
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

In add_new_gdb_meta_bg, we assume that group could be non first
group in meta block group as we call ext4_meta_bg_first_block_no
to get first block of meta block group rather than call
ext4_group_first_block_no for passed group directly. Then ext4_bg_has_super
should be called with first group in meta group rather than new added
group. Or we can call ext4_group_first_block_no instead of
ext4_meta_bg_first_block_no to assume only first group of
meta group will be passed.
Either way, ext4_meta_bg_first_block_no will be useless and
could be removed.

This patch do it in first way to make add_new_gdb_meta_bg support non
first group in meta block group.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/resize.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b9507e432496..da832466ce74 100644
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
@@ -954,8 +948,9 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	unsigned long gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 	int err;
 
-	gdblock = ext4_meta_bg_first_block_no(sb, group) +
-		   ext4_bg_has_super(sb, group);
+	group = ext4_meta_bg_first_group(sb, group);
+	gdblock = ext4_group_first_block_no(sb, group) +
+		  ext4_bg_has_super(sb, group);
 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
 	if (IS_ERR(gdb_bh))
 		return PTR_ERR(gdb_bh);
-- 
2.30.0

