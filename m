Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0207D280C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 03:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjJWBgH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjJWBgG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 21:36:06 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47880F1;
        Sun, 22 Oct 2023 18:36:01 -0700 (PDT)
X-QQ-mid: bizesmtp83t1698024860tdnh26oy
Received: from localhost.localdomain ( [125.76.217.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 23 Oct 2023 09:34:19 +0800 (CST)
X-QQ-SSF: 01400000000000D0H000000A0000000
X-QQ-FEAT: 96k0+YG2NiUyz1G0D/IM+BKNUxvNFZDTYAB4ZDvOBD+DXNXWXPuQtJWLIipjA
        AqxLFpw5Chk8czVf7bbrJ353Dx55otbHAEY2cKNF9LqaUDFs6Efs0k/nmnf9FVPEFjHPDrU
        NadIZFzEqm03ijmBlbxR4fS+9WUTxSoKRppW4vwgTRc7kmwnzmYKfnY3zUXTGEPLNAn7KN6
        GynZ9sKI+CLu4z05rjSp9Muzyy4JG6Q9+GR0vjElLCB++f7v/ug65JefVE1sGu3LYze+7f6
        izjEbJoZkqSCo8JQDPfzC3ilcvhCoO4RKal37dJ9y5iYjfNq5gqsXv/2SP9LWixumq/HfBc
        /ZkNY32XmtFWZnseebVbk58xI1WTDXUZwrUEwwTc6ldstQmbOK1qwRIKwbLAvfim+goXgn3
        va21GN1LiZI=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7138792497209401315
From:   Gou Hao <gouhao@uniontech.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gouhaojake@163.com
Subject: [PATCH] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date:   Mon, 23 Oct 2023 09:34:16 +0800
Message-Id: <20231023013416.17246-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
'pnum' and 'block' is equal in this case.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Signed-off-by: Gou Hao <gouhaojake@163.com>
---
 fs/ext4/mballoc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641e..8442f5474b25 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1456,9 +1456,7 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		return 0;
 	}
 
-	block++;
-	pnum = block / blocks_per_page;
-	page = find_or_create_page(inode->i_mapping, pnum, gfp);
+	page = find_or_create_page(inode->i_mapping, ++block, gfp);
 	if (!page)
 		return -ENOMEM;
 	BUG_ON(page->mapping != inode->i_mapping);
-- 
2.34.1

