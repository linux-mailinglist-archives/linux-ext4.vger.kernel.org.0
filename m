Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E231B75C28E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGUJJs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGUJJm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 05:09:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A030C1;
        Fri, 21 Jul 2023 02:09:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6kJw5CzXz4f3nVC;
        Fri, 21 Jul 2023 17:09:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFPS7pkqi7fOQ--.527S5;
        Fri, 21 Jul 2023 17:09:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 03/10] ext4: return found group directly in ext4_mb_choose_next_group_p2_aligned
Date:   Sat, 22 Jul 2023 01:10:00 +0800
Message-Id: <20230721171007.2065423-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
References: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFPS7pkqi7fOQ--.527S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8CFyUZF4DZF18Zw17Awb_yoW8tw1Upa
        nxXF10kFWfWw15ur4UGayqq3Wvgw48KayUJryxX3WrJa43Ar9Yyan7tFy8ZF9rCFZ7C3Z3
        Was0v3y5Cryxua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPEf5UUUUU
        =
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

Return good group when it's found in loop to remove unnecessary NULL
initialization of grp and futher check if good group is found after loop.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 33ee3991f62c..4031f8e2a660 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -875,7 +875,7 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *iter, *grp;
+	struct ext4_group_info *iter;
 	int i;
 
 	if (ac->ac_status == AC_STATUS_FOUND)
@@ -884,7 +884,6 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
 		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
 
-	grp = NULL;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
 			continue;
@@ -893,28 +892,22 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
 			continue;
 		}
-		grp = NULL;
 		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
 				    bb_largest_free_order_node) {
 			if (sbi->s_mb_stats)
 				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
 			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
-				grp = iter;
-				break;
+				*group = iter->bb_group;
+				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
+				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
+				return;
 			}
 		}
 		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
-		if (grp)
-			break;
 	}
 
-	if (!grp) {
-		/* Increment cr and search again */
-		*new_cr = CR_GOAL_LEN_FAST;
-	} else {
-		*group = grp->bb_group;
-		ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
-	}
+	/* Increment cr and search again if no group is found */
+	*new_cr = CR_GOAL_LEN_FAST;
 }
 
 /*
-- 
2.30.0

