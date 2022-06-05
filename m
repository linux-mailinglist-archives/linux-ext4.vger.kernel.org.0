Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494053DAF7
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Jun 2022 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiFEJP0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Jun 2022 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFEJPZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Jun 2022 05:15:25 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BF4183AD;
        Sun,  5 Jun 2022 02:15:18 -0700 (PDT)
X-QQ-mid: bizesmtp82t1654420511t5b06fm1
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 17:15:04 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000C00A0000000
X-QQ-FEAT: q6FcPYdgG0iyR/MZ/f4VEtfkCoZ7SlzPGsHbotv7cJd/I2HHCU7IC2QNhmZ+J
        qzFegwGnDxBon8IjzVdcuZFqUizRfdh5eEj74vkBBjBDtlWHWr580BYo3prj0Mue8hC5lMf
        GEMaMqxOcd5RpENz+whH/RdJAvL/74OnGJk7W6bSpN5hl3IncTIvrcdPBiULpV9jSqji3dM
        hfsnEg2fzsm4VJttSUbCMpV9PXdgvPdhEr/CQfs/WhtOY/CjOTGK7fjMj+U9Py4oeq7wqQ7
        Q6uWP0/g42ir4i0vVJqvhx3HLiilRDYVaHJSaRQ10KX88Zhgj6kEZotgQ+nd1jwOn0mbhfN
        JV2GL0P7/NOCj6od/c=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] fs/ext4: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 17:15:03 +0800
Message-Id: <20220605091503.12513-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Delete the redundant word 'need'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 7a5353a8cfd7..42f590518b4c 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -438,7 +438,7 @@ int ext4_ext_migrate(struct inode *inode)
 
 	/*
 	 * Worst case we can touch the allocation bitmaps and a block
-	 * group descriptor block.  We do need need to worry about
+	 * group descriptor block.  We do need to worry about
 	 * credits for modifying the quota inode.
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE,
-- 
2.36.1

