Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB85AD6B6
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiIEPkJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Sep 2022 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiIEPkI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Sep 2022 11:40:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB711839
        for <linux-ext4@vger.kernel.org>; Mon,  5 Sep 2022 08:40:06 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLszW3p8wzZcKr;
        Mon,  5 Sep 2022 23:35:35 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 23:40:03 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 23:40:03 +0800
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] tune2fs: tune2fs_main() should return rc when some error,
 occurs
Message-ID: <7a6e1a43-d041-c3cf-a3dd-a9761d8dd4d6@huawei.com>
Date:   Mon, 5 Sep 2022 23:40:01 +0800
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


If some error occurs, tune2fs_main() will go to closefs tag for
releasing resource, and it should return correct value (rc) instead
of 0 when ext2fs_close_free(&fs) successes.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 misc/tune2fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 25ade2fa..088f87e5 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3481,6 +3481,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			fputs(_("Error in using clear_mmp. "
 				"It must be used with -f\n"),
 			      stderr);
+			rc = 1;
 			goto closefs;
 		}
 	}
@@ -3744,5 +3745,5 @@ closefs:

 	if (feature_64bit)
 		convert_64bit(fs, feature_64bit);
-	return (ext2fs_close_free(&fs) ? 1 : 0);
+	return (ext2fs_close_free(&fs) ? 1 : rc);
 }
-- 
2.33.0


