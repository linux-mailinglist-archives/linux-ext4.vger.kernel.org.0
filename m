Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB73E5BA791
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIPHnH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIPHnF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 03:43:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F657A2239
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 00:43:03 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTQwn4nSNzBsJp;
        Fri, 16 Sep 2022 15:40:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:43:01 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <tytso@mit.edu>, <adilger@whamcloud.com>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Subject: [PATCH] tune2fs: exit directly when fs freed in ext2fs_run_ext3_journal
Date:   Fri, 16 Sep 2022 15:42:23 +0800
Message-ID: <20220916074223.8885-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext2fs_run_ext3_journal(), fs will be free and reallocate. But
reallocating by ext2fs_open() may fail in some cases, such as device
being offline at the same time. In these cases, goto closefs will
cause segfault, fix it by exiting directly.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 misc/tune2fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e5..ee57dc7c 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3344,8 +3344,11 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			com_err("tune2fs", retval,
 				"while recovering journal.\n");
 			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
-			rc = 1;
-			goto closefs;
+			if (fs) {
+				rc = 1;
+				goto closefs;
+			}
+			exit(1);
 		}
 		sb = fs->super;
 	}
-- 
2.23.0

