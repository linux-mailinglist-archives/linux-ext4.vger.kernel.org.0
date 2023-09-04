Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8237915FE
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352741AbjIDLCR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjIDLCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 07:02:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4151C6;
        Mon,  4 Sep 2023 04:02:11 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfQcD1YFDz1DDZK;
        Mon,  4 Sep 2023 18:58:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 19:02:09 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/2] JBD2: fix printk format type for 'io_block' in do_one_pass()
Date:   Mon, 4 Sep 2023 18:58:17 +0800
Message-ID: <20230904105817.1728356-3-yebin10@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'io_block' is unsinged long but print it by '%ld'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 11380ff1fe51..0567f1aa189b 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -632,7 +632,7 @@ static int do_one_pass(journal_t *journal,
 					success = err;
 					printk(KERN_ERR
 						"JBD2: IO error %d recovering "
-						"block %ld in log\n",
+						"block %lu in log\n",
 						err, io_block);
 				} else {
 					unsigned long long blocknr;
-- 
2.31.1

