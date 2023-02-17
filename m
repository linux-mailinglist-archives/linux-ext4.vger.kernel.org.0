Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F569A886
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBQJpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 04:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBQJpt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 04:45:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BF449F
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 01:45:48 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PJ6Mf0bJVzGpfh;
        Fri, 17 Feb 2023 17:43:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 17 Feb
 2023 17:45:46 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 1/2] e2fsck: save EXT2_ERROR_FS flag during journal replay
Date:   Fri, 17 Feb 2023 18:09:21 +0800
Message-ID: <20230217100922.588961-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230217100922.588961-1-libaokun1@huawei.com>
References: <20230217100922.588961-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When repairing a file system with s_errno missing from the journal
superblock but the file system superblock contains the ERROR_FS flag,
the ERROR_FS flag on the file system image is overwritten after the
journal replay, followed by a reload of the file system data from disk
and the ERROR_FS flag in memory is overwritten. Also s_errno is not set
and the ERROR_FS flag is not reset. Therefore, when checked later, no
forced check is performed, which makes it possible to have some errors
hidden in the disk image, which may make it read-only when using the
file system. So we save the ERROR_FS flag to the superblock after the
journal replay, instead of just relying on the jsb->s_errno to do this.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 e2fsck/journal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index c7868d89..0144aa45 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 	errcode_t	retval, recover_retval;
 	io_stats	stats = 0;
 	unsigned long long kbytes_written = 0;
+	__u16 s_error_state;
 
 	printf(_("%s: recovering journal\n"), ctx->device_name);
 	if (ctx->options & E2F_OPT_READONLY) {
@@ -1705,6 +1706,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 		ctx->fs->io->manager->get_stats(ctx->fs->io, &stats);
 	if (stats && stats->bytes_written)
 		kbytes_written = stats->bytes_written >> 10;
+	s_error_state = ctx->fs->super->s_state & EXT2_ERROR_FS;
 
 	ext2fs_mmp_stop(ctx->fs);
 	ext2fs_free(ctx->fs);
@@ -1721,6 +1723,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 	ctx->fs->now = ctx->now;
 	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
 	ctx->fs->super->s_kbytes_written += kbytes_written;
+	ctx->fs->super->s_state |= s_error_state;
 
 	/* Set the superblock flags */
 	e2fsck_clear_recover(ctx, recover_retval != 0);
-- 
2.31.1

