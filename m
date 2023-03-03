Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2EF6A93B8
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCCJUX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCCJT6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:58 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05923DA8;
        Fri,  3 Mar 2023 01:19:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSj9N2h1Xz4f3mKk;
        Fri,  3 Mar 2023 17:19:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S20;
        Fri, 03 Mar 2023 17:19:54 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 18/20] ext4: remove repeat assignment to ac_f_ex
Date:   Sat,  4 Mar 2023 01:21:18 +0800
Message-Id: <20230303172120.3800725-19-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S20
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxGr18Cw1fGF1fGr4UArb_yoW8WF4xp3
        ZxtF1Fkw1fXr1DCFZ2g3WDG3WFkw47Gr1UJry0g3WrJFZxKFW7Gw4kta4Iqa9xCrZ3AFnx
        ZrWxAF1UGrsrK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call trace to assign ac_f_ex:
ext4_mb_use_best_found
	ac->ac_f_ex = ac->ac_b_ex;
	ext4_mb_new_preallocation
		ext4_mb_new_group_pa
			ac->ac_f_ex = ac->ac_b_ex;
		ext4_mb_new_inode_pa
			ac->ac_f_ex = ac->ac_b_ex;

Actually allocated blocks is already stored in ac_f_ex in
ext4_mb_use_best_found, so there is no need to assign ac_f_ex
in ext4_mb_new_group_pa and ext4_mb_new_inode_pa.
Just remove repeat assignment to ac_f_ex in ext4_mb_new_group_pa
and ext4_mb_new_inode_pa.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b9e69f3a678f..d4e226c16baf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4635,10 +4635,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 	}
 
-	/* preallocation can change ac_b_ex, thus we store actually
-	 * allocated blocks for history */
-	ac->ac_f_ex = ac->ac_b_ex;
-
 	pa->pa_lstart = ac->ac_b_ex.fe_logical;
 	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
 	pa->pa_len = ac->ac_b_ex.fe_len;
@@ -4689,10 +4685,6 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 
 	pa = ac->ac_pa;
 
-	/* preallocation can change ac_b_ex, thus we store actually
-	 * allocated blocks for history */
-	ac->ac_f_ex = ac->ac_b_ex;
-
 	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
 	pa->pa_lstart = pa->pa_pstart;
 	pa->pa_len = ac->ac_b_ex.fe_len;
-- 
2.30.0

