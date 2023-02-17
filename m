Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03A69A887
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBQJpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 04:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBQJpu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 04:45:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1155B8A
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 01:45:49 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PJ6Ll1b1hzRs98;
        Fri, 17 Feb 2023 17:43:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 17 Feb
 2023 17:45:47 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 2/2] tune2fs/fuse2fs/debugfs: save error information during journal replay
Date:   Fri, 17 Feb 2023 18:09:22 +0800
Message-ID: <20230217100922.588961-3-libaokun1@huawei.com>
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

Saving error information during journal replay, as in the kernel,
prevents information loss from making problems difficult to locate.
We save these error information until someone uses e2fsck to check
for and fix possible errors.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 debugfs/journal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 5bac0d3b..79e3fff8 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -789,6 +789,8 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 	char *fsname;
 	int fsflags;
 	int fsblocksize;
+	char *save;
+	__u16 s_error_state;
 
 	if (!(fs->flags & EXT2_FLAG_RW))
 		return EXT2_ET_FILE_RO;
@@ -808,6 +810,12 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 	if (stats && stats->bytes_written)
 		kbytes_written = stats->bytes_written >> 10;
 
+	save = malloc(EXT4_S_ERR_LEN);
+	if (save)
+		memcpy(save, ((char *) fs->super) + EXT4_S_ERR_START,
+		       EXT4_S_ERR_LEN);
+	s_error_state = fs->super->s_state & EXT2_ERROR_FS;
+
 	ext2fs_mmp_stop(fs);
 	fsname = fs->device_name;
 	fs->device_name = NULL;
@@ -818,11 +826,15 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 	retval = ext2fs_open(fsname, fsflags, 0, fsblocksize, io_ptr, fsp);
 	ext2fs_free_mem(&fsname);
 	if (retval)
-		return retval;
+		goto outfree;
 
 	fs = *fsp;
 	fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
 	fs->super->s_kbytes_written += kbytes_written;
+	fs->super->s_state |= s_error_state;
+	if (save)
+		memcpy(((char *) fs->super) + EXT4_S_ERR_START, save,
+		       EXT4_S_ERR_LEN);
 
 	/* Set the superblock flags */
 	ext2fs_clear_recover(fs, recover_retval != 0);
@@ -832,6 +844,9 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
 	 * the EXT2_ERROR_FS flag in the fs superblock if needed.
 	 */
 	retval = ext2fs_check_ext3_journal(fs);
+
+outfree:
+	free(save);
 	return retval ? retval : recover_retval;
 }
 
-- 
2.31.1

