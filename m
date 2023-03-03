Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0A6A93AF
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCCJUR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCCJTz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:55 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2783DBDB;
        Fri,  3 Mar 2023 01:19:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSj9L1105z4f3jpm;
        Fri,  3 Mar 2023 17:19:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S13;
        Fri, 03 Mar 2023 17:19:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 11/20] ext4: remove unnecessary check in ext4_mb_new_blocks
Date:   Sat,  4 Mar 2023 01:21:11 +0800
Message-Id: <20230303172120.3800725-12-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S13
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyrZFW5uw13tFW5GFy3Arb_yoWkXFXEga
        yvyw18Ca1ft34Ska1kAr40gFs0gFs5tF18XFZrKr43uF15X3yrW34kZrs5Zr1kWay2y3sx
        ur1rArWvyr4S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
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
index 6eea1296b82a..e53bf9d5a48d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5641,16 +5641,15 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
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

