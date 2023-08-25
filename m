Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1440778888D
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjHYN01 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Aug 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbjHYN0Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Aug 2023 09:26:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C81FF0
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 06:26:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXLK83NpTzfbgY;
        Fri, 25 Aug 2023 21:24:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 21:26:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <darrick.wong@oracle.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH v2] e2fsck: delay quotas loading in release_orphan_inodes()
Date:   Fri, 25 Aug 2023 21:22:37 +0800
Message-ID: <20230825132237.2869251-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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
image that contains orphan inodes and has the wrong bbitmap checksum. So
delaying quota loading until after the EXT2_ERROR_FS judgment avoids the
above problem. Moreover, since we don't care if the bitmap checksum is
wrong before Pass5, e2fsck_read_bitmaps() is called before loading the
quota to avoid bitmap checksum errors that would cause e2fsck to exit.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Add e2fsck_read_bitmaps() to avoid bitmap checksum errors causing
	e2fsck to exit.

 e2fsck/super.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 9495e029..69ea6795 100644
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
@@ -525,10 +516,18 @@ static int release_orphan_inodes(e2fsck_t ctx)
 	 * be running a full e2fsck run anyway... We clear orphan file contents
 	 * after filesystem is checked to avoid clearing someone else's data.
 	 */
-	if (fs->super->s_state & EXT2_ERROR_FS) {
-		if (ctx->qctx)
-			quota_release_context(&ctx->qctx);
+	if (fs->super->s_state & EXT2_ERROR_FS)
 		return 0;
+
+	e2fsck_read_bitmaps(ctx);
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

