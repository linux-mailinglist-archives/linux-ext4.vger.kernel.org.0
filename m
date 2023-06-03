Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D7720E41
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjFCHCL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFCHCK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 03:02:10 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E5E5B;
        Sat,  3 Jun 2023 00:02:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QY9lr4D63z4f3nq4;
        Sat,  3 Jun 2023 15:02:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCHOKxk5Xpk+MxPKw--.30174S7;
        Sat, 03 Jun 2023 15:02:02 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v4 05/19] ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
Date:   Sat,  3 Jun 2023 23:03:13 +0800
Message-Id: <20230603150327.3596033-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHOKxk5Xpk+MxPKw--.30174S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18JFy3uFy5ur1rtr1DJrb_yoW8KrWUpF
        ZxJF1YkrnIgwn7u39xWw15Cw1fKw48K348JrWSgr1rArWxGr43Canxt348uFyqkrWrXFn8
        ZF45Zay7Gr4xu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7ef95bdde91d..839db9c46aea 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4531,6 +4531,37 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
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
@@ -4581,7 +4612,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 		/* found preallocated blocks, use them */
 		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
+		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free &&
+		    likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
-- 
2.30.0

