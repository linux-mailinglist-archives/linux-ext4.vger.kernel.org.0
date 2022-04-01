Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C34EECDC
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbiDAMJc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 08:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiDAMJb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 08:09:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B227794E;
        Fri,  1 Apr 2022 05:07:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KVJlP2cw7zDqFY;
        Fri,  1 Apr 2022 20:05:21 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 20:07:36 +0800
Message-ID: <92fcc3a6-7d77-8c09-4126-377fcb4c46a5@huawei.com>
Date:   Fri, 1 Apr 2022 20:07:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH] ext4, doc: Fix incorrect h_reserved size
Content-Language: en-US
From:   "wangjianjian (C)" <wangjianjian3@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com>
In-Reply-To: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.108.234.194]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

According to document and code, ext4_xattr_header's size is 32 bytes, so
h_reserved size should be 3.

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
  Documentation/filesystems/ext4/attributes.rst | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/attributes.rst 
b/Documentation/filesystems/ext4/attributes.rst
index 54386a010a8d..871d2da7a0a9 100644
--- a/Documentation/filesystems/ext4/attributes.rst
+++ b/Documentation/filesystems/ext4/attributes.rst
@@ -76,7 +76,7 @@ The beginning of an extended attribute block is in
       - Checksum of the extended attribute block.
     * - 0x14
       - \_\_u32
-     - h\_reserved[2]
+     - h\_reserved[3]
       - Zero.

  The checksum is calculated against the FS UUID, the 64-bit block number
-- 
2.32.0
