Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454E6BF790
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 04:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCRDgK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 23:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRDgJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 23:36:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779261CF47
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 20:36:07 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdmmH3ZN1znXLJ;
        Sat, 18 Mar 2023 11:33:03 +0800 (CST)
Received: from [10.174.179.254] (10.174.179.254) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 11:36:04 +0800
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger@whamcloud.com>,
        Jan Kara <jack@suse.cz>, linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, <libaokun1@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] tune2fs: check whether dev is mounted or in use before
 setting
Message-ID: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
Date:   Sat, 18 Mar 2023 11:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

tune2fs is used to adjust various tunable filesystem pars, which
may conflict with kernel operations. So we should check whether
device is mounted or in use at the begin similar to e2fsck and mke2fs.

Of course, we can ignore this check if -f is set.

Reported-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 misc/tune2fs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 458f7cf6..b667e1f4 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3327,6 +3327,22 @@ retry_open:
 		goto closefs;
 	}

+	if (open_flag & EXT2_FLAG_RW) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fprintf(stderr, _("Warning! %s is mounted.\n"), device_name);
+			if (!f_flag) {
+				rc = 1;
+				goto closefs;
+			}
+		} else if (mount_flags & EXT2_MF_BUSY) {
+			fprintf(stderr, _("Warning! %s is in use by the system.\n"),
+					device_name);
+			if (!f_flag) {
+				rc = 1;
+				goto closefs;
+			}
+		}
+	}
 #ifdef NO_RECOVERY
 	/* Warn if file system needs recovery and it is opened for writing. */
 	if ((open_flag & EXT2_FLAG_RW) && !(mount_flags & EXT2_MF_MOUNTED) &&
-- 
2.33.0
