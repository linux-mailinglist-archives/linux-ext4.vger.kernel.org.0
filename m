Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A56761182
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjGYKwH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjGYKvP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 06:51:15 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C192728;
        Tue, 25 Jul 2023 03:50:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9DMl0hJSz4f4VkP;
        Tue, 25 Jul 2023 18:50:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quj+qL9kl7XQOg--.17520S12;
        Tue, 25 Jul 2023 18:50:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 10/10] ext4: correct some stale comment of criteria
Date:   Wed, 26 Jul 2023 02:51:06 +0800
Message-Id: <20230725185106.2147273-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
References: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quj+qL9kl7XQOg--.17520S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xWrWxXrykCF47trW3Awb_yoW8GF1fpr
        4aka4xGF1fXr1UCa1Du3WkWw4Dua1xWFy7Xr929r4FvFy3JFyfuF4Dta4kXFy8Ars3X3WY
        yrW5ZFW7G3WUua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVb
        yDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We named criteria with CR_XXX, correct stale comment to criteria with
raw number.

Fixes: f52f3d2b9fba ("ext4: Give symbolic names to mballoc criterias")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 36eea63eaace..de5da76e6748 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2777,8 +2777,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	/*
 	 * ac->ac_2order is set only if the fe_len is a power of 2
-	 * if ac->ac_2order is set we also set criteria to 0 so that we
-	 * try exact allocation using buddy.
+	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
+	 * so that we try exact allocation using buddy.
 	 */
 	i = fls(ac->ac_g_ex.fe_len);
 	ac->ac_2order = 0;
@@ -2835,8 +2835,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			/*
 			 * Batch reads of the block allocation bitmaps
 			 * to get multiple READs in flight; limit
-			 * prefetching at cr=0/1, otherwise mballoc can
-			 * spend a lot of time loading imperfect groups
+			 * prefetching at cr below CR_FAST, otherwise mballoc
+			 * can spend a lot of time loading imperfect groups
 			 */
 			if ((prefetch_grp == group) &&
 			    (cr >= CR_FAST ||
-- 
2.30.0

