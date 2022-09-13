Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFD5B6E0C
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIMNPE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMNPD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 09:15:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C9E088
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 06:14:56 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRkNx2Yc1zkWw0;
        Tue, 13 Sep 2022 21:10:57 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 21:14:54 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 13 Sep
 2022 21:14:53 +0800
To:     <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] ext2fs_open2: goto cleanup tag when
 image_header->magic_number != EXT2_ET_MAGIC_E2IMAGE
Message-ID: <703f5bf7-fd63-ad0a-fcbb-0b5affd31d53@huawei.com>
Date:   Tue, 13 Sep 2022 21:14:51 +0800
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


In ext2fs_open2(), fs->image_header is assigned by calling io_channel_read_blk,
successfully. If fs->image_header->magic_number is not equal to EXT2_ET_MAGIC_E2IMAGE,
we should go to cleanup tag to free resouce and return errcode (EXT2_ET_MAGIC_E2IMAGE).

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 lib/ext2fs/openfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index 39229d7c..df73f4f2 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -193,8 +193,10 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 					     fs->image_header);
 		if (retval)
 			goto cleanup;
-		if (ext2fs_le32_to_cpu(fs->image_header->magic_number) != EXT2_ET_MAGIC_E2IMAGE)
-			return EXT2_ET_MAGIC_E2IMAGE;
+		if (ext2fs_le32_to_cpu(fs->image_header->magic_number) != EXT2_ET_MAGIC_E2IMAGE) {
+			retval = EXT2_ET_MAGIC_E2IMAGE;
+			goto cleanup;
+		}
 		superblock = 1;
 		block_size = ext2fs_le32_to_cpu(fs->image_header->fs_blocksize);
 	}
-- 
2.33.0


