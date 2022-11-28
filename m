Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2E63A80C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiK1MSx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiK1MSe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 07:18:34 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 04:10:10 PST
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4361F617;
        Mon, 28 Nov 2022 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669637408;
        bh=VkABSKL0kqiWu48bDZCJATYTf4fmeS37uZNwcn8Fcfk=;
        h=From:To:Cc:Subject:Date;
        b=keMbChf+hr0taYUxQ6SJ2fU2Qw78SS/TP2Olvk4DaMiu0igCOMCPTdaAAB7fECmq1
         gRcuc+zOlp3UxHHA99dz25XWC4Xvfi3Y6NA4CWCwxNSte7svwQrna7OFu/HjlDxWpu
         CB7cfyUGqRp6+GJUyF+eRdotrs7PIq9dievbLR3s=
Received: from rtoax.. ([111.199.188.128])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 173256E2; Mon, 28 Nov 2022 20:05:51 +0800
X-QQ-mid: xmsmtpt1669637151tjau8fbke
Message-ID: <tencent_79CB512A440B831AA1D42CEF4B729591D707@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoC6Uyh+3alIKBxd0yiaQ2SVArwyrpkQJSUpfEZgQOmkguM+/R9O
         trLvx4uxB8xk3cLX++eR3GiQR1A5VS8X1IxEVnzuX7PFmYMenq4wLz+MSzYZChx2rwuSmVaFlwGe
         /cZQVHwHxyjrvIOtV7cLgUfGSH4fEg4Ykp6IW6OesRGsH/VHiNI79S+VBuYe5BMwDfh6jQIkXj/N
         hTxxckln83vUBkyw9Q3Eq/+dQFSRFjpEx+2LvTuEUNHxmASyi+ak7W9anJOsoZQgHNxspd89AQl3
         W4Z/OowE9bD66aMJYHCDdzMcjHANE5UmUBqQH+yhJEf5P20Zg8Sj/btKERCPqbCR8WBqUSD6zOwV
         bgp0q7Smi6ovV6NiRlMTFVPfgXya7lTDRHrqlw5sWjknzQSmUGP84WbpG8DzF47hARz6PuyLj01P
         9FCRylU1aCqY9Rl0MxIBUytkaRLMFBHFfOMXJExJiEI1eBX2pAt5mheLf4plpQjIlm4ZSIfwqx1w
         uNpYYbsCjLXrrxZG4y2weJwfPO1ytZO0FKa4wbxW2dKbv0zNE4CjNRrZKQp43YorsnNC8Noaezk5
         3eQCL8LBiujRYioiBBFySvpW3QqkQpJ0jaRtJJNhOtIPHxS88ZBNkeGRW7FFqRpBXLNEUKdJWxx6
         7YpqnqRumEtzY4gOMUIXKZB0UG4EfiWD+L9aclqDTS851woqKCg5XVNA/Ei75Pt4V7p/6+86IrD5
         xKk0EkiXzgcjaX5jdH1iElynmYNYIyhSiWbuUqoIGzwwpoiWpoADkigT6aDy7Yx2RFJvhcEjJLcg
         EHLoM7i0rEsj5kC0gR13Bfhw/pJP8qr6O0Kn104/OnjnjxyHnoLKG7HAPdJT5CYvKOLDEBZqHq1W
         hD8CWfJ3/5e1cFXriv/kUPNfGcO5lPa8RQZF+UXyKAXRGZgu5UpvBIwFvs5U/CMlZtAFGHKawZ0B
         6UFSf65IffNzFz1Md4EncYun8ZN98HCkClPBHCkzU=
From:   Rong Tao <rtoax@foxmail.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rong Tao <rongtao@cestc.cn>
Subject: [PATCH v2] fs/ext2: Fix code indentation
Date:   Mon, 28 Nov 2022 20:05:49 +0800
X-OQ-MSGID: <20221128120549.7210-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

ts=4 can cause misunderstanding in code reading. It is better to replace
8 spaces with one tab.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Modify more indentation lines
v1: https://lore.kernel.org/all/tencent_EEC5C049082D4BF0724AC5E9956BD41E5105@qq.com/
---
 fs/ext2/balloc.c | 12 ++++++------
 fs/ext2/super.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 5dc0a31f4a08..eca60b747c6b 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -667,7 +667,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 {
 	ext2_fsblk_t group_first_block = ext2_group_first_block_no(sb, group);
 	ext2_fsblk_t group_last_block = ext2_group_last_block_no(sb, group);
-       	ext2_grpblk_t start, end;
+	ext2_grpblk_t start, end;
 	unsigned long num = 0;
 
 	start = 0;
@@ -1481,11 +1481,11 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
 		desc_count, bitmap_count);
 	return bitmap_count;
 #else
-        for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-                desc = ext2_get_group_desc (sb, i, NULL);
-                if (!desc)
-                        continue;
-                desc_count += le16_to_cpu(desc->bg_free_blocks_count);
+	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
+		desc = ext2_get_group_desc(sb, i, NULL);
+		if (!desc)
+			continue;
+		desc_count += le16_to_cpu(desc->bg_free_blocks_count);
 	}
 	return desc_count;
 #endif
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 03f2af98b1b4..69c88facfe90 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1648,7 +1648,7 @@ static int __init init_ext2_fs(void)
 	err = init_inodecache();
 	if (err)
 		return err;
-        err = register_filesystem(&ext2_fs_type);
+	err = register_filesystem(&ext2_fs_type);
 	if (err)
 		goto out;
 	return 0;
-- 
2.38.1

