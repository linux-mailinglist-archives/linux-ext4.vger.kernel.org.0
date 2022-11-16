Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723662B3B1
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Nov 2022 08:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKPHGn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 02:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiKPHGl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 02:06:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131513EBF;
        Tue, 15 Nov 2022 23:06:41 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBvGT1DdGzHw0l;
        Wed, 16 Nov 2022 15:06:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:06:39 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/3] ext4: fix corrupt backup group descriptors after online resize
Date:   Wed, 16 Nov 2022 15:28:01 +0800
Message-ID: <20221116072802.526990-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116072802.526990-1-libaokun1@huawei.com>
References: <20221116072802.526990-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

In commit 9a8c5b0d0615 ("ext4: update the backup superblock's at the end
of the online resize"), it is assumed that update_backups() only updates
backup superblocks, so each b_data is treated as a backupsuper block to
update its s_block_group_nr and s_checksum. However, update_backups()
also updates the backup group descriptors, which causes the backup group
descriptors to be corrupted.

The above commit fixes the problem of invalid checksum of the backup
superblock. The root cause of this problem is that the checksum of
ext4_update_super() is not set correctly. This problem has been fixed
in the previous patch ("ext4: fix bad checksum after online resize").
Therefore, roll back some modifications in the above commit.

Fixes: 9a8c5b0d0615 ("ext4: update the backup superblock's at the end of the online resize")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/resize.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index cb99b410c9fa..32fbfc173571 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1158,7 +1158,6 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 	while (group < sbi->s_groups_count) {
 		struct buffer_head *bh;
 		ext4_fsblk_t backup_block;
-		struct ext4_super_block *es;
 
 		/* Out of journal space, and can't get more - abort - so sad */
 		err = ext4_resize_ensure_credits_batch(handle, 1);
@@ -1187,10 +1186,6 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 		memcpy(bh->b_data, data, size);
 		if (rest)
 			memset(bh->b_data + size, 0, rest);
-		es = (struct ext4_super_block *) bh->b_data;
-		es->s_block_group_nr = cpu_to_le16(group);
-		if (ext4_has_metadata_csum(sb))
-			es->s_checksum = ext4_superblock_csum(sb, es);
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
-- 
2.31.1

