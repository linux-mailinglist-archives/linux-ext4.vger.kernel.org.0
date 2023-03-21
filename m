Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AF6C2BF0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 09:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCUIJd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCUIJb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 04:09:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB2F1ABC5;
        Tue, 21 Mar 2023 01:09:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgklm0lw2z4f3vdV;
        Tue, 21 Mar 2023 16:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbEzZhlk+NQhFw--.4478S5;
        Tue, 21 Mar 2023 16:09:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ojaswin@linux.ibm.com, shikemeng@huaweicloud.com
Subject: [PATCH 3/8] ext4: fix wrong unit use in ext4_mb_new_inode_pa
Date:   Wed, 22 Mar 2023 00:12:15 +0800
Message-Id: <20230321161220.418652-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230321161220.418652-1-shikemeng@huaweicloud.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbEzZhlk+NQhFw--.4478S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWUKw47uF4kZry7GryUWrg_yoW3Zrc_Ca
        1DCr4IvFyrtr1I9a1Syay8Ar9YgF1kJr4jqr45try3ZF18ur42kwsFvr45XayxGry7A3sx
        G3WYgr1FgF1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
        1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
        HMKAUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

fe_logical and win are both in block unit. Remove wrong convertion for
win from block unit to cluster unit.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7f695830621a..86d978e1f7dc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4640,8 +4640,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		if (offs && offs < win)
 			win = offs;
 
-		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
-			EXT4_NUM_B2C(sbi, win);
+		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - win;
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 	}
-- 
2.30.0

