Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB27D4685
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjJXDzP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Oct 2023 23:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjJXDzA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Oct 2023 23:55:00 -0400
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873A1FDB;
        Mon, 23 Oct 2023 20:53:02 -0700 (PDT)
X-QQ-mid: bizesmtp89t1698119537tr982wq4
Received: from localhost.localdomain ( [125.76.217.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 24 Oct 2023 11:52:15 +0800 (CST)
X-QQ-SSF: 01400000000000D0H000000A0000000
X-QQ-FEAT: HPkwb3INVpCPQzs9daqTP2TJE9WjMwVOP9848r3CjZin22d53DcZxl3mMHzZT
        mOlu1UICz3HK77Qr16Wpv32nA2XRYwtfgx/LzO2UBXRgmKaiTwXDKLygNVL3Jkt6v7sJqh3
        b7Eo7Ke5uzhjO1iwas64PvM6vEOZMB8xz4erEP46Gc2nsQV2vWfzHXBWRoD5sAm9E1ekfuF
        SOn3dQGn0MQXdLuLYXRwJa18YHMZfcTqpaOU3FcFTvvEQb1/SWIS/Gkq3wGLS2KEvE33J17
        NnqKMmzlVUAwkV+VymuMhxX2btTCxqIRbI2StcJxroO0K5WLjc1X+i8X6pcP0Qf5wksQuV9
        +dUzGTtAsf13pMXXe8g6gjmwWYkcb/CYf8BGfcezxhqd7IxTQjoIfAmBE5cRM8IbFTZE1c8
        OQMfASpWagw=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16941381890066295906
From:   Gou Hao <gouhao@uniontech.com>
To:     gouhao@uniontech.com
Cc:     adilger.kernel@dilger.ca, gouhaojake@163.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: [PATCH V2] ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
Date:   Tue, 24 Oct 2023 11:52:15 +0800
Message-Id: <20231024035215.29474-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231023013416.17246-1-gouhao@uniontech.com>
References: <20231023013416.17246-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
'pnum' and 'block' are equal in this case.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641e..c340d4d7287a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1456,9 +1456,8 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		return 0;
 	}
 
-	block++;
-	pnum = block / blocks_per_page;
-	page = find_or_create_page(inode->i_mapping, pnum, gfp);
+	/* blocks_per_page == 1, hence we need another page for the buddy */
+	page = find_or_create_page(inode->i_mapping, block + 1, gfp);
 	if (!page)
 		return -ENOMEM;
 	BUG_ON(page->mapping != inode->i_mapping);
-- 
2.20.1

