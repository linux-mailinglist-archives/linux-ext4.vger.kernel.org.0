Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19F76A91F
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 08:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHAGbz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjHAGbx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 02:31:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B0133;
        Mon, 31 Jul 2023 23:31:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFQHm0qBMz4f3l8s;
        Tue,  1 Aug 2023 14:31:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrQpshkMcvqPA--.21719S5;
        Tue, 01 Aug 2023 14:31:48 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v3 03/10] ext4: return found group directly in ext4_mb_choose_next_group_p2_aligned
Date:   Tue,  1 Aug 2023 22:31:57 +0800
Message-Id: <20230801143204.2284343-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230801143204.2284343-1-shikemeng@huaweicloud.com>
References: <20230801143204.2284343-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrQpshkMcvqPA--.21719S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8CFyktw4UKr45XF1rXrb_yoW8KrWrpa
        nxXF10kFWfWw15Ww4UGayqq3Wvgw48KayUJryxX3WrX343AryvyanrtFy8ZF9rCFZ7CFn5
        W3Z0v3y5Cryxua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiyCJDUUUUU=
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Return good group when it's found in loop to remove unnecessary NULL
initialization of grp and futher check if good group is found after loop.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a6635cba291a..4cbbe930e010 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -874,7 +874,7 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *iter, *grp;
+	struct ext4_group_info *iter;
 	int i;
 
 	if (ac->ac_status == AC_STATUS_FOUND)
@@ -883,7 +883,6 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 	if (unlikely(sbi->s_mb_stats && ac->ac_flags & EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED))
 		atomic_inc(&sbi->s_bal_p2_aligned_bad_suggestions);
 
-	grp = NULL;
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
 			continue;
@@ -892,28 +891,22 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
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

