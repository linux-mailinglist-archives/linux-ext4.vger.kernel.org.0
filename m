Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F067915FF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352719AbjIDLCQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243138AbjIDLCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 07:02:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8780191;
        Mon,  4 Sep 2023 04:02:11 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RfQdz72RtzrSWw;
        Mon,  4 Sep 2023 19:00:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 19:02:09 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 1/2] JBD2: print io_block if check data block checksum failed when do recovery
Date:   Mon, 4 Sep 2023 18:58:16 +0800
Message-ID: <20230904105817.1728356-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230904105817.1728356-1-yebin10@huawei.com>
References: <20230904105817.1728356-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index c269a7d29a46..11380ff1fe51 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -661,7 +661,8 @@ static int do_one_pass(journal_t *journal,
 						printk(KERN_ERR "JBD2: Invalid "
 						       "checksum recovering "
 						       "data block %llu in "
-						       "log\n", blocknr);
+						       "journal block %lu\n",
+						       blocknr, io_block);
 						block_error = 1;
 						goto skip_write;
 					}
-- 
2.31.1

