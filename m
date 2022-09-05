Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA185AD14A
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiIELQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Sep 2022 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiIELQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Sep 2022 07:16:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76A5508A
        for <linux-ext4@vger.kernel.org>; Mon,  5 Sep 2022 04:16:07 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLm996zkCznTdX;
        Mon,  5 Sep 2022 19:13:33 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 19:16:05 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 19:16:05 +0800
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger@whamcloud.com>,
        "Ext4 Developers List" <linux-ext4@vger.kernel.org>,
        zhanchengbin <zhanchengbin1@huawei.com>
CC:     wuguanghao <wuguanghao3@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] tune2fs: fix tune2fs segfault when ext2fs_run_ext3_journal()
 fails
Message-ID: <8e87fbc3-674a-af30-1234-54b36eb5ca5d@huawei.com>
Date:   Mon, 5 Sep 2022 19:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


When ext2fs_run_ext3_journal() fails, tune2fs cmd will occur one
segfault problem as follows.
(gdb) bt
#0  0x00007fdadad69917 in ext2fs_mmp_stop (fs=0x0) at mmp.c:405
#1  0x0000558fa5a9365a in main (argc=<optimized out>, argv=<optimized out>) at tune2fs.c:3440

misc/tune2fs.c:
main()
  -> ext2fs_open2(&fs)
    -> ext2fs_mmp_start
  ......
  -> retval = ext2fs_run_ext3_journal(&fs)
  -> if (retval)
    // if ext2fs_run_ext3_journal fails, close and free fs.
    -> ext2fs_close_free(&fs)
    -> rc = 1
    -> goto closefs
  ......
closefs:
  -> if (rc)
    -> ext2fs_mmp_stop(fs)     // fs has been set to NULL, boom!!
  -> (ext2fs_close_free(&fs) ? 1 : 0); // close and free fs

In main() of tune2fs cmd, if ext2fs_run_ext3_journal() fails,
we should set rc=1 and goto closefs tag, in which will release fs
resource.

Fix: a2292f8a5108 ("tune2fs: reset MMP state on error exit")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 misc/tune2fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 9f0d4379..25ade2fa 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3344,8 +3344,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			com_err("tune2fs", retval,
 				"while recovering journal.\n");
 			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
-			if (fs)
-				ext2fs_close_free(&fs);
 			rc = 1;
 			goto closefs;
 		}
-- 
2.33.0


