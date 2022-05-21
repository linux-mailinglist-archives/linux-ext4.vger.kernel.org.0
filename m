Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86A52FCDF
	for <lists+linux-ext4@lfdr.de>; Sat, 21 May 2022 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiEUN2p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 May 2022 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbiEUN2o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 May 2022 09:28:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A369299;
        Sat, 21 May 2022 06:28:42 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L54Bq1THYzgY7b;
        Sat, 21 May 2022 21:27:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 21:28:40 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Date:   Sat, 21 May 2022 21:42:16 +0800
Message-ID: <20220521134217.312071-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521134217.312071-1-libaokun1@huawei.com>
References: <20220521134217.312071-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hulk Robot reported a BUG_ON:
==================================================================
kernel BUG at fs/ext4/mballoc.c:3211!
[...]
RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
[...]
Call Trace:
 ext4_mb_new_blocks+0x9df/0x5d30
 ext4_ext_map_blocks+0x1803/0x4d80
 ext4_map_blocks+0x3a4/0x1a10
 ext4_writepages+0x126d/0x2c30
 do_writepages+0x7f/0x1b0
 __filemap_fdatawrite_range+0x285/0x3b0
 file_write_and_wait_range+0xb1/0x140
 ext4_sync_file+0x1aa/0xca0
 vfs_fsync_range+0xfb/0x260
 do_fsync+0x48/0xa0
[...]
==================================================================

Above issue may happen as follows:
-------------------------------------
do_fsync
 vfs_fsync_range
  ext4_sync_file
   file_write_and_wait_range
    __filemap_fdatawrite_range
     do_writepages
      ext4_writepages
       mpage_map_and_submit_extent
        mpage_map_one_extent
         ext4_map_blocks
          ext4_mb_new_blocks
           ext4_mb_normalize_request
            >>> start + size <= ac->ac_o_ex.fe_logical
           ext4_mb_regular_allocator
            ext4_mb_simple_scan_group
             ext4_mb_use_best_found
              ext4_mb_new_preallocation
               ext4_mb_new_inode_pa
                ext4_mb_use_inode_pa
                 >>> set ac->ac_b_ex.fe_len <= 0
           ext4_mb_mark_diskspace_used
            >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);

we can easily reproduce this problem with the following commands:
	`fallocate -l100M disk`
	`mkfs.ext4 -b 1024 -g 256 disk`
	`mount disk /mnt`
	`fsstress -d /mnt -l 0 -n 1000 -p 1`

The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
when the size is truncated. So start should be the start position of
the group where ac_o_ex.fe_logical is located after alignment.
In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
is very large, the value calculated by start_off is more accurate.

Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ea653d19f9ec..32410b79b664 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4107,6 +4107,17 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
+	/*
+	 * Because size must be less than or equal to
+	 * EXT4_BLOCKS_PER_GROUP, start should be the start position of
+	 * the group where ac_o_ex.fe_logical is located after alignment.
+	 * In addition, when the value of fe_logical or
+	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
+	 * by start_off is more accurate.
+	 */
+	start = max(start, round_down(ac->ac_o_ex.fe_logical,
+			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
-- 
2.31.1

