Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD753DB79
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Jun 2022 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiFEMzd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Jun 2022 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiFEMzc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Jun 2022 08:55:32 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034E20F48;
        Sun,  5 Jun 2022 05:55:27 -0700 (PDT)
X-QQ-mid: bizesmtp80t1654433716tv156qnv
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 20:55:10 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: 9jBqDpakGOP8ro1Y4QKQqJWJu6iSxtT2tQuydKOwCC/Pns9bIvqT7an+CJUSp
        j+4r4yL0sqOo7pFsifU9WN3Ma+mF+MCW8scBkdgP2eU/WmssdehdYo75xCog6d8lkB74pDW
        qPEx3iOkieCuOXWJ/NMD38JOhyLM5b//HG5TXKvcuqksZ5SjV8KXBM5cTd5del8asCW7ipC
        bOr9BQ9ezqfSQTf0hloQoM45f693iFYSL2J9cecmH/V3Pb4ZRK0ov3NuGC1oQThdtRqmgpj
        n8JinQ1INQMaveAcai4BxfiPCHYVwdM6Spp6ILcl8RFcQfMV8WR6SzvT1PbhdPldrICx2Ev
        q3/IjSCjN7mjrQlYXE=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] fs: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 20:55:09 +0800
Message-Id: <20220605125509.14837-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Delete the redundant word 'not'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/ext2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 360ce3604a2d..e6b932219803 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1549,7 +1549,7 @@ static int __ext2_write_inode(struct inode *inode, int do_sync)
 	if (IS_ERR(raw_inode))
  		return -EIO;
 
-	/* For fields not not tracking in the in-memory inode,
+	/* For fields not tracking in the in-memory inode,
 	 * initialise them to zero for new inodes. */
 	if (ei->i_state & EXT2_STATE_NEW)
 		memset(raw_inode, 0, EXT2_SB(sb)->s_inode_size);
-- 
2.36.1

