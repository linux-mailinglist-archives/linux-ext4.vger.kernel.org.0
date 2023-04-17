Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B876E4B66
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDQOY2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Apr 2023 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDQOY1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Apr 2023 10:24:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8210C;
        Mon, 17 Apr 2023 07:24:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q0Nyj14Jjz4f40ly;
        Mon, 17 Apr 2023 18:46:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+mOIz1kzuPtHQ--.31500S2;
        Mon, 17 Apr 2023 18:46:38 +0800 (CST)
From:   Wu Bo <wubo@huaweicloud.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        qiuchangqi.qiu@huawei.com, wubo40@huawei.com
Subject: [PATCH] ext4: Remove unnecessary variable assignments
Date:   Mon, 17 Apr 2023 19:32:15 +0800
Message-Id: <1681731135-18768-1-git-send-email-wubo@huaweicloud.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: Syh0CgC3q+mOIz1kzuPtHQ--.31500S2
X-Coremail-Antispam: 1UD129KBjvdXoWrGFWUWr13Gr17WF4kJryfXrb_yoWxWrg_t3
        WUAr48A3yrJr1SkF1kXrsxtr40qan5Ar18AFZ3tryfuF1UXa1rua1kArySyrnruay2yasx
        uas3KryUJryFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr
        1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8oGQDUUUUU==
X-CM-SenderInfo: pzxe0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just remove unnecessary variable assignments.

Signed-off-by: Wu Bo <wubo@huaweicloud.com>
---
 fs/ext4/mballoc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37..f0b790d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5842,7 +5842,6 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
-		err = PTR_ERR(bitmap_bh);
 		pr_warn("Failed to read block bitmap\n");
 		return;
 	}
-- 
1.8.3.1

