Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF19B6A939F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCCJUC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCCJTx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714A3A853;
        Fri,  3 Mar 2023 01:19:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSj9H5XNjz4f3nTT;
        Fri,  3 Mar 2023 17:19:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S6;
        Fri, 03 Mar 2023 17:19:49 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 04/20] ext4: correct calculation of s_mb_preallocated
Date:   Sat,  4 Mar 2023 01:21:04 +0800
Message-Id: <20230303172120.3800725-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDCFykAw4DKryrWFW8Crg_yoW8Gr15pa
        nxGr1UGwn3ur1Ykayvgwn8Ww1Ika1xKr45GryIgr4xuFZrJryakF1DtrW8WF9avr48ZFnI
        vrW2vryUCrWI937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We will add pa_free to s_mb_preallocated when new ext4_prealloc_space is
created. In ext4_mb_new_inode_pa, we will call ext4_mb_use_inode_pa
before adding pa_free to s_mb_preallocated. However, ext4_mb_use_inode_pa
will consume pa_free for block allocation which triggerred the creation
of ext4_prealloc_space. Add pa_free to s_mb_preallocated before
ext4_mb_use_inode_pa to correct calculation of s_mb_preallocated.
There is no such problem in ext4_mb_new_group_pa as pa_free of group pa
is consumed in ext4_mb_release_context instead of ext4_mb_use_group_pa.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d1c5b6ea57da..d7ea3c2014ff 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4670,8 +4670,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_inode_pa(ac, pa);
 
-	ext4_mb_use_inode_pa(ac, pa);
 	atomic_add(pa->pa_free, &sbi->s_mb_preallocated);
+	ext4_mb_use_inode_pa(ac, pa);
 
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
-- 
2.30.0

