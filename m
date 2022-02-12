Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DC4B3302
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Feb 2022 05:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiBLEtq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Feb 2022 23:49:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBLEtq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Feb 2022 23:49:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5A260
        for <linux-ext4@vger.kernel.org>; Fri, 11 Feb 2022 20:49:43 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JwdKf0jBlzRBsm
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 12:48:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Feb
 2022 12:49:41 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.cz>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext2: correct max file size computing
Date:   Sat, 12 Feb 2022 13:05:32 +0800
Message-ID: <20220212050532.179055-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We need to calculate the max file size accurately if the total blocks
that can address by block tree exceed the upper_limit. But this check is
not correct now, it only compute the total data blocks but missing
metadata blocks are needed. So in the case of "data blocks < upper_limit
&& total blocks > upper_limit", we will get wrong result. Fortunately,
this case could not happen in reality, but it's confused and better to
correct the computing.

  bits   data blocks   metadatablocks   upper_limit
  10        16843020            66051    2147483647
  11       134480396           263171    1073741823
  12      1074791436          1050627     536870911 (*)
  13      8594130956          4198403     268435455 (*)
  14     68736258060         16785411     134217727 (*)
  15    549822930956         67125251      67108863 (*)
  16   4398314962956        268468227      33554431 (*)

  [*] Need to calculate in depth.

Fixes: 1c2d14212b15 ("ext2: Fix underflow in ext2_max_size()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext2/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 94f1fbd7d3ac..6d4f5ef74766 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -753,8 +753,12 @@ static loff_t ext2_max_size(int bits)
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
+	/* Compute how many metadata blocks are needed */
+	meta_blocks = 1;
+	meta_blocks += 1 + ppb;
+	meta_blocks += 1 + ppb + ppb * ppb;
 	/* Does block tree limit file size? */
-	if (res < upper_limit)
+	if (res + meta_blocks <= upper_limit)
 		goto check_lfs;
 
 	res = upper_limit;
-- 
2.31.1

