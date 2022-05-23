Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305485313C3
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiEWODi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiEWODb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 10:03:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08C123163;
        Mon, 23 May 2022 07:03:30 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L6Jt04Slrz1JC8d;
        Mon, 23 May 2022 22:02:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 22:03:28 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/2] ext4: correct the judgment of BUG in ext4_mb_normalize_request
Date:   Mon, 23 May 2022 22:16:58 +0800
Message-ID: <20220523141658.2919003-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523141658.2919003-1-libaokun1@huawei.com>
References: <20220523141658.2919003-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When either of the "start + size <= ac->ac_o_ex.fe_logical" or
"start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
that the fe_logical is not in the allocated range.
In this case, it should be bug_ON.

Fixes: c9de560ded61 ("ext4: Add multi block allocator for ext4")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Change Fixes from dfe076c106f6 to c9de560ded61.

 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6aafc242fe23..61ced468f178 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4185,7 +4185,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	}
 	rcu_read_unlock();
 
-	if (start + size <= ac->ac_o_ex.fe_logical &&
+	if (start + size <= ac->ac_o_ex.fe_logical ||
 			start > ac->ac_o_ex.fe_logical) {
 		ext4_msg(ac->ac_sb, KERN_ERR,
 			 "start %lu, size %lu, fe_logical %lu",
-- 
2.31.1

