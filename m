Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD2757D03
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjGRNNz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGRNNr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 09:13:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741CB0;
        Tue, 18 Jul 2023 06:13:45 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4zp6576szNmSP;
        Tue, 18 Jul 2023 21:10:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 21:13:41 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH 4/4] ext4: avoid prealloc space being skipped due to overflow
Date:   Tue, 18 Jul 2023 21:10:52 +0800
Message-ID: <20230718131052.283350-5-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230718131052.283350-1-libaokun1@huawei.com>
References: <20230718131052.283350-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there is a pa in the i_prealloc_list of an inode with a tmp_pa_end
of 4294967296(0x100000000), since tmp_pa_end is of type ext4_lblk_t,
tmp_pa_end will be recognized as 0 due to overflow, which causes
(ac->ac_o_ ex.fe_logical >= tmp_pa_end) always holds, so that pa will
always be skipped. This then triggers the regular allocation process,
and if the excess tail of the free extent from that allocation is put
into the i_prealloc_list again, it will again not be used. This ends up
leaving us with a lot of free physical blocks in the i_prealloc_list.

We avoid this problem by using pa_end() to compute tmp_pa_end and
declaring tmp_pa_end to be of type loff_t.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 77d47af525d9..06db40fb29d6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4765,7 +4765,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	ext4_lblk_t tmp_pa_start;
+	loff_t tmp_pa_end;
 	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
@@ -4784,7 +4785,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_end(sbi, tmp_pa);
 
 		/* original request start doesn't lie in this PA */
 		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
-- 
2.31.1

