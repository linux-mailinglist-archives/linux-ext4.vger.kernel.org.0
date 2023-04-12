Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072F6DF043
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDLJ0V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDLJ0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 05:26:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743BD7AB8;
        Wed, 12 Apr 2023 02:26:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PxHQ72lDlz4f4NNp;
        Wed, 12 Apr 2023 17:26:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S7;
        Wed, 12 Apr 2023 17:26:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 05/19] ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
Date:   Thu, 13 Apr 2023 01:28:19 +0800
Message-Id: <20230412172833.2317696-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
References: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18JFy3uFy5ur1rtr1DJrb_yoW8tw47pF
        W3JF15Crsagwn7W39agw15Gw1rKw48K34rJryfWr1rZrWxGrsrCanrt348uFyqyr4rZFn8
        ZF4Yv3y7Gr4xu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_mb_use_preallocated will ignore the demand to alloc goal blocks,
although the EXT4_MB_HINT_GOAL_ONLY is requested.
For group pa, ext4_mb_group_or_file will not set EXT4_MB_HINT_GROUP_ALLOC
if EXT4_MB_HINT_GOAL_ONLY is set. So we will not alloc goal blocks from
group pa if EXT4_MB_HINT_GOAL_ONLY is set.
For inode pa, ext4_mb_pa_goal_check is added to check if free extent in
found inode pa meets goal blocks when EXT4_MB_HINT_GOAL_ONLY is set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b75f16d2fdfc..be1115ea1800 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4351,6 +4351,37 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 	return pa;
 }
 
+/*
+ * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
+ */
+static bool
+ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
+		      struct ext4_prealloc_space *pa)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	ext4_fsblk_t start;
+
+	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY)))
+		return true;
+
+	/*
+	 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
+	 * in ext4_mb_normalize_request and will keep same with ac_o_ex
+	 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
+	 * consistent with ext4_mb_find_by_goal.
+	 */
+	start = pa->pa_pstart +
+		(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+	if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
+		return false;
+
+	if (ac->ac_g_ex.fe_len > pa->pa_len -
+	    EXT4_B2C(sbi, ac->ac_g_ex.fe_logical - pa->pa_lstart))
+		return false;
+
+	return true;
+}
+
 /*
  * search goal blocks in preallocated space
  */
@@ -4387,7 +4418,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 		/* found preallocated blocks, use them */
 		spin_lock(&pa->pa_lock);
-		if (pa->pa_deleted == 0 && pa->pa_free) {
+		if (pa->pa_deleted == 0 && pa->pa_free &&
+		    likely(ext4_mb_pa_goal_check(ac, pa))) {
 			atomic_inc(&pa->pa_count);
 			ext4_mb_use_inode_pa(ac, pa);
 			spin_unlock(&pa->pa_lock);
-- 
2.30.0

