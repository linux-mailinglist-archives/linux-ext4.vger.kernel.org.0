Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2C741F0F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 06:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjF2EAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 00:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjF2D7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 23:59:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319B72D69;
        Wed, 28 Jun 2023 20:59:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs4Tf3WPMz4f3x6K;
        Thu, 29 Jun 2023 11:59:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quiwAZ1kw6DMMg--.26995S15;
        Thu, 29 Jun 2023 11:59:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] ext4: remove unnecessary initialization of count2 in set_flexbg_block_bitmap
Date:   Thu, 29 Jun 2023 20:00:44 +0800
Message-Id: <20230629120044.1261968-14-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quiwAZ1kw6DMMg--.26995S15
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWkXr4xZF43tw1kJF1kZrb_yoWfCrb_tF
        ZrAry8ZF4rZw1rKFyjqw45XFZ3tw4kJryUury5tr1ru3WqyayFya4Dury7Cr109r15Awn0
        yFn3Jry3A34SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
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

We always overwrite count2 to "EXT4_CLUSTERS_PER_GROUP(sb) -
(first_cluster - start)" after its initialization in for loop
initialization statement .
Just remove unnecessary initialization of count2.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/resize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index d2b3ee50af31..327475c2e2e7 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -453,8 +453,7 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 
 	ext4_debug("mark clusters [%llu-%llu] used\n", first_cluster,
 		   last_cluster);
-	for (count2 = count; count > 0;
-	     count -= count2, first_cluster += count2) {
+	for (; count > 0; count -= count2, first_cluster += count2) {
 		ext4_fsblk_t start;
 		struct buffer_head *bh;
 		ext4_group_t group;
-- 
2.30.0

