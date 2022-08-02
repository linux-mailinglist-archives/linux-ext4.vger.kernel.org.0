Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6658756D
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 04:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiHBCLD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 22:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHBCLC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 22:11:02 -0400
Received: from out29-77.mail.aliyun.com (out29-77.mail.aliyun.com [115.124.29.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC1B84E;
        Mon,  1 Aug 2022 19:10:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08153923|-1;BR=01201311R701S18rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00132903-2.06163e-05-0.99865;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Ojh14Qc_1659406238;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.Ojh14Qc_1659406238)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 10:10:39 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH] ext4: fix error when itable blocks is greater than s_itb_per_group
Date:   Tue,  2 Aug 2022 10:10:29 +0800
Message-Id: <20220802021029.16046-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following error occurs when mounting the ext4 image made by image
making tool:
"ext4_init_inode_table:1301:comm ext4lazyinit:Something is wrong with group
0: used itable blocks: 491; itable unused count: 0."

Currently all the inodes in block group0 and ext4 image is divided by
s_inodes_per_group. That leads to a hazard: we can't ensure all
s_inodes_per_group are divisible by s_inodes_per_block. For example, when
the s_inodes_per_group (equals to 7851) is divided by s_inodes_per_block
(which is 16), because 7851 is undivisible by 16, we get the wrong result
490, while 491 is expected.

So, we suggest that s_itb_per_group should equal to
DIV_ROUND_UP(s_inodes_per_group, s_inodes_per_block) instead of directly
getting the result from s_inodes_per_group/s_inodes_per_block.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..76cbd638ea10 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4796,8 +4796,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			 sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
-	sbi->s_itb_per_group = sbi->s_inodes_per_group /
-					sbi->s_inodes_per_block;
+	sbi->s_itb_per_group = DIV_ROUND_UP(sbi->s_inodes_per_group,
+					    sbi->s_inodes_per_block);
 	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
-- 
2.29.0

