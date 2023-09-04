Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9FA790F93
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350234AbjIDBOY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 21:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349864AbjIDBOY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 21:14:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C908DE;
        Sun,  3 Sep 2023 18:14:15 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rf9Zh1zSzzVk5K;
        Mon,  4 Sep 2023 09:11:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 09:14:13 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH 1/2] JBD2: print io_block if check data block checksum failed when do recovery
Date:   Mon, 4 Sep 2023 09:10:20 +0800
Message-ID: <20230904011021.3884879-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230904011021.3884879-1-yebin10@huawei.com>
References: <20230904011021.3884879-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now, if check data block checksum failed only print data's block number
then skip write data. However, one data block may in more than one transaction.
In some scenarios, offline analysis is inconvenient. As a result, it is
difficult to locate the areas where data is faulty.
So print 'io_block' if check data block checksum failed.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index c269a7d29a46..a2e2bdaed9f8 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -661,7 +661,8 @@ static int do_one_pass(journal_t *journal,
 						printk(KERN_ERR "JBD2: Invalid "
 						       "checksum recovering "
 						       "data block %llu in "
-						       "log\n", blocknr);
+						       "log %lu\n", blocknr,
+						       io_block);
 						block_error = 1;
 						goto skip_write;
 					}
-- 
2.31.1

