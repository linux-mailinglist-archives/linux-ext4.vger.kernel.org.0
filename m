Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7816A51EF
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 04:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjB1Dlw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 22:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjB1Dli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 22:41:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A6252B2;
        Mon, 27 Feb 2023 19:41:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQjpN49C3z4f3wQp;
        Tue, 28 Feb 2023 11:41:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrod_1jpDeZEQ--.58449S13;
        Tue, 28 Feb 2023 11:41:34 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 11/20] ext4: remove unnecessary check in ext4_mb_new_blocks
Date:   Tue, 28 Feb 2023 19:42:57 +0800
Message-Id: <20230228114306.3328235-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrod_1jpDeZEQ--.58449S13
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyrZFW5uw13tFW5GFy3Arb_yoWkXFX_KF
        Wvy348Ca1ft34Ska1kAr40qFsYgFZYyF18XFZrKr43ZF15Xw4ru34kArs5Zr1kWa12y3sx
        ur1rAFy0yr4F9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
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

1. remove unnecessary ac check:
We always go to out tag before ac is successfully allocated, then we can
move out tag after free of ac and remove NULL check of ac.

2. remove unnecessary *errp check:
We always go to errout tag if *errp is non-zero, then we can move errout
tag into error handle if *errp is non-zero.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 30d5a0882ebc..fea835d8d241 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5638,16 +5638,15 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		*errp = -ENOSPC;
 	}
 
-errout:
 	if (*errp) {
+errout:
 		ac->ac_b_ex.fe_len = 0;
 		ar->len = 0;
 		ext4_mb_show_ac(ac);
 	}
 	ext4_mb_release_context(ac);
+	kmem_cache_free(ext4_ac_cachep, ac);
 out:
-	if (ac)
-		kmem_cache_free(ext4_ac_cachep, ac);
 	if (inquota && ar->len < inquota)
 		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
 	if (!ar->len) {
-- 
2.30.0

