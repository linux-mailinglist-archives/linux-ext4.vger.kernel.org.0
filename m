Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD4596F8A
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiHQNQU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiHQNP4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 09:15:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154C870B1;
        Wed, 17 Aug 2022 06:15:29 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M77hj6KHrzkWPY;
        Wed, 17 Aug 2022 21:12:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 21:15:26 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
Date:   Wed, 17 Aug 2022 21:27:01 +0800
Message-ID: <20220817132701.3015912-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220817132701.3015912-1-libaokun1@huawei.com>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.

In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
the function returns -ENOMEM.

In __getblk_slow, if the return value of grow_buffers is less than 0,
the function returns NULL.

When the three processes are connected in series like the following stack,
an infinite loop may occur:

do_writepages					<--- keep retrying
 ext4_writepages
  mpage_map_and_submit_extent
   mpage_map_one_extent
    ext4_map_blocks
     ext4_ext_map_blocks
      ext4_ext_handle_unwritten_extents
       ext4_ext_convert_to_initialized
        ext4_split_extent
         ext4_split_extent_at
          __ext4_ext_dirty
           __ext4_mark_inode_dirty
            ext4_reserve_inode_write
             ext4_get_inode_loc
              __ext4_get_inode_loc		<--- return -ENOMEM
               sb_getblk
                __getblk_gfp
                 __getblk_slow			<--- return NULL
                  grow_buffers
                   grow_dev_page		<--- return -ENXIO
                    ret = (block < end_block) ? 1 : -ENXIO;

In this issue, bg_inode_table_hi is overwritten as an incorrect value.
As a result, `block < end_block` cannot be met in grow_dev_page.
Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
keeps retrying. As a result, the writeback process is in the D state due
to an infinite loop.

Add a check on inode table block in the __ext4_get_inode_loc function by
referring to ext4_read_inode_bitmap to avoid this infinite loop.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..5e171879fa23 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4466,9 +4466,17 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
 	inode_offset = ((ino - 1) %
 			EXT4_INODES_PER_GROUP(sb));
-	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
 	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
 
+	block = ext4_inode_table(sb, gdp);
+	if ((block <= le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) ||
+	    (block >= ext4_blocks_count(EXT4_SB(sb)->s_es))) {
+		ext4_error(sb, "Invalid inode table block %llu in "
+			   "block_group %u", block, iloc->block_group);
+		return -EFSCORRUPTED;
+	}
+	block += (inode_offset / inodes_per_block);
+
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
-- 
2.31.1

