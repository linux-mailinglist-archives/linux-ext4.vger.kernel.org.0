Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B526DF04C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDLJ0a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjDLJ0P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 05:26:15 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0726195;
        Wed, 12 Apr 2023 02:26:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PxHQ76bwvz4f42Yr;
        Wed, 12 Apr 2023 17:26:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S8;
        Wed, 12 Apr 2023 17:26:09 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 06/19] ext4: remove ext4_block_group and ext4_block_group_offset declaration
Date:   Thu, 13 Apr 2023 01:28:20 +0800
Message-Id: <20230412172833.2317696-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
References: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S8
X-Coremail-Antispam: 1UD129KBjvdXoWrtF17JFyUWF1fJF18CryrXrb_yoWDWFX_Aw
        17Jr4kGFWfJw1Ska1jgrs8Ars5tr4xXr4DWa18WryrX3WDXF4jva4DCrn7Ars8u3WUAF13
        Ar9rXF17JFy8XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUU
        UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For ext4_block_group and ext4_block_group_offset, there are only
declaration without definition. Just remove them.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9b2cfc32cf78..f25f13a357de 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2697,10 +2697,6 @@ extern void ext4_get_group_no_and_offset(struct super_block *sb,
 extern ext4_group_t ext4_get_group_number(struct super_block *sb,
 					  ext4_fsblk_t block);
 
-extern unsigned int ext4_block_group(struct super_block *sb,
-			ext4_fsblk_t blocknr);
-extern ext4_grpblk_t ext4_block_group_offset(struct super_block *sb,
-			ext4_fsblk_t blocknr);
 extern int ext4_bg_has_super(struct super_block *sb, ext4_group_t group);
 extern unsigned long ext4_bg_num_gdb(struct super_block *sb,
 			ext4_group_t group);
-- 
2.30.0

