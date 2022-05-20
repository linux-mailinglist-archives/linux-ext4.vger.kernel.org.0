Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9152E268
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiETCSm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 22:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiETCSk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 22:18:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124D12E327
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 19:18:39 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L49LQ14GmzQkGM;
        Fri, 20 May 2022 10:15:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 10:18:37 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2] ext4: fix warning when submitting superblock in ext4_commit_super()
Date:   Fri, 20 May 2022 10:32:16 +0800
Message-ID: <20220520023216.3065073-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

We have already check the io_error and uptodate flag before submitting
the superblock buffer, and re-set the uptodate flag if it has been
failed to write out. But it was lockless and could be raced by another
ext4_commit_super(), and finally trigger '!uptodate' WARNING when
marking buffer dirty. Fix it by submit buffer directly.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v2->v1:
 - Add clear_buffer_dirty() before submit_bh().

 fs/ext4/super.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1466fbdbc8e3..9f6892665be4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6002,7 +6002,6 @@ static void ext4_update_super(struct super_block *sb)
 static int ext4_commit_super(struct super_block *sb)
 {
 	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
-	int error = 0;
 
 	if (!sbh)
 		return -EINVAL;
@@ -6011,6 +6010,13 @@ static int ext4_commit_super(struct super_block *sb)
 
 	ext4_update_super(sb);
 
+	lock_buffer(sbh);
+	/* Buffer got discarded which means block device got invalidated */
+	if (!buffer_mapped(sbh)) {
+		unlock_buffer(sbh);
+		return -EIO;
+	}
+
 	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
@@ -6025,17 +6031,21 @@ static int ext4_commit_super(struct super_block *sb)
 		clear_buffer_write_io_error(sbh);
 		set_buffer_uptodate(sbh);
 	}
-	BUFFER_TRACE(sbh, "marking dirty");
-	mark_buffer_dirty(sbh);
-	error = __sync_dirty_buffer(sbh,
-		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
+	get_bh(sbh);
+	/* Clear potential dirty bit if it was journalled update */
+	clear_buffer_dirty(sbh);
+	sbh->b_end_io = end_buffer_write_sync;
+	submit_bh(REQ_OP_WRITE,
+		  REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0), sbh);
+	wait_on_buffer(sbh);
 	if (buffer_write_io_error(sbh)) {
 		ext4_msg(sb, KERN_ERR, "I/O error while writing "
 		       "superblock");
 		clear_buffer_write_io_error(sbh);
 		set_buffer_uptodate(sbh);
+		return -EIO;
 	}
-	return error;
+	return 0;
 }
 
 /*
-- 
2.31.1

