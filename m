Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E797C77F1FE
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbjHQIWB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348842AbjHQIV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 04:21:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917722727
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 01:21:58 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRHxt6GRFz1GDr0;
        Thu, 17 Aug 2023 16:20:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 16:21:55 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <darrick.wong@oracle.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Date:   Thu, 17 Aug 2023 16:18:28 +0800
Message-ID: <20230817081828.934259-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
inodes"), we load all the quotas before we process the orphaned inodes,
and when we load the quotas, we check the checsum of the bbitmap for each
group. If one of the bbitmap checksums is wrong, the following error will
be reported:

“Error initializing quota context in support library:
 Block bitmap checksum does not match bitmap”

But loading quotas comes before checking the current superblock for the
EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
image that contains orphan inodes and has the wrong bbitmap checksum.
So delaying quota loading until after the EXT2_ERROR_FS judgment avoids
the above problem.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 e2fsck/super.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 9495e029..b1aaaed6 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -503,15 +503,6 @@ static int release_orphan_inodes(e2fsck_t ctx)
 	    !ext2fs_has_feature_orphan_present(fs->super))
 		return 0;
 
-	clear_problem_context(&pctx);
-	ino = fs->super->s_last_orphan;
-	pctx.ino = ino;
-	pctx.errcode = e2fsck_read_all_quotas(ctx);
-	if (pctx.errcode) {
-		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
-		return 1;
-	}
-
 	/*
 	 * Win or lose, we won't be using the head of the orphan inode
 	 * list again.
@@ -525,10 +516,16 @@ static int release_orphan_inodes(e2fsck_t ctx)
 	 * be running a full e2fsck run anyway... We clear orphan file contents
 	 * after filesystem is checked to avoid clearing someone else's data.
 	 */
-	if (fs->super->s_state & EXT2_ERROR_FS) {
-		if (ctx->qctx)
-			quota_release_context(&ctx->qctx);
+	if (fs->super->s_state & EXT2_ERROR_FS)
 		return 0;
+
+	clear_problem_context(&pctx);
+	ino = fs->super->s_last_orphan;
+	pctx.ino = ino;
+	pctx.errcode = e2fsck_read_all_quotas(ctx);
+	if (pctx.errcode) {
+		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
+		return 1;
 	}
 
 	if (ino && ((ino < EXT2_FIRST_INODE(fs->super)) ||
-- 
2.31.1

