Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D9778624
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 05:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjHKDm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 23:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjHKDmZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 23:42:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2982D70;
        Thu, 10 Aug 2023 20:42:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMTzX63nmzCrcJ;
        Fri, 11 Aug 2023 11:38:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:42:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH 2/2] ext2: dump current reservation window info before BUG
Date:   Fri, 11 Aug 2023 11:38:57 +0800
Message-ID: <20230811033857.1800578-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811033857.1800578-1-yebin10@huawei.com>
References: <20230811033857.1800578-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's report BUG in 'ext2_try_to_allocate_with_rsv()', although there's
now dump of all reservation windows information. But there's unknown which
window is being processed.So this is not helpful for locating the issue.
To better analyze the problem, dump the information about reservation window
that is being processed.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 039f655febfd..0132b8af546e 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1131,6 +1131,11 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
 
 		if ((my_rsv->rsv_start > group_last_block) ||
 				(my_rsv->rsv_end < group_first_block)) {
+			ext2_error(sb, __func__,
+				   "Out of group %u range goal %d fsb[%lu,%lu] rsv[%lu, %lu]",
+				   group, grp_goal, group_first_block,
+				   group_last_block, my_rsv->rsv_start,
+				   my_rsv->rsv_end);
 			rsv_window_dump(&EXT2_SB(sb)->s_rsv_window_root, 1);
 			BUG();
 		}
-- 
2.31.1

