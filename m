Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D069D9ED
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 04:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjBUD5q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 22:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjBUD5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 22:57:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291024CB9;
        Mon, 20 Feb 2023 19:57:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLQV64wg2z4f3jZM;
        Tue, 21 Feb 2023 11:57:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+ktQfRj8VfgDw--.30652S8;
        Tue, 21 Feb 2023 11:57:36 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 6/7] ext4: stop trying to verify just initialized bitmap in ext4_read_block_bitmap_nowait
Date:   Tue, 21 Feb 2023 19:59:18 +0800
Message-Id: <20230221115919.1918161-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3q+ktQfRj8VfgDw--.30652S8
X-Coremail-Antispam: 1UD129KBjvdXoWrury8ZrW7KrW7KFWfCF48WFg_yoW3WFXEga
        srZw1kW3y3Jw1Sk3Wvva90qr4ktF4rJr48WFWaqFyfuF1UK3WfZa1vyw1fuFZxuFy7Aa4D
        AFyYqry7JaySgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUU
        UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For case we initialize a bitmap bh, we will set bitmap bh verified.
We can return immediately instead of goto verify to remove unnecessary
work for trying to verify bitmap bh.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 4de06d68e9e7..dab46274d591 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -484,7 +484,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 		set_buffer_verified(bh);
 		ext4_unlock_group(sb, block_group);
 		unlock_buffer(bh);
-		goto verify;
+		return bh;
 	}
 	ext4_unlock_group(sb, block_group);
 	if (buffer_uptodate(bh)) {
-- 
2.30.0

