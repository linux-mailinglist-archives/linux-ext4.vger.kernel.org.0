Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1E4D97BD
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiCOJgf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiCOJgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 05:36:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B74BFF7
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 02:35:21 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KHpBS5wtSzfZ2g;
        Tue, 15 Mar 2022 17:33:52 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:35:19 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:35:19 +0800
Message-ID: <f714d963-9855-546d-74b8-8c9a883ae65e@huawei.com>
Date:   Tue, 15 Mar 2022 17:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] e2fsck: do not skip deeper checkers when s_last_orphan list
 has truncated inodes
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100025.china.huawei.com (7.185.36.37) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the system crashes when a file is being truncated, we will get a 
problematic inode,
and it will be added into fs->super->s_last_orphan.
When we run `e2fsck -a img`, the s_last_orphan list will be traversed 
and deleted.
During this period, orphan inodes in the s_last_orphan list with 
i_links_count==0 can
be deleted, and orphan inodes with  i_links_count !=0 (ex. the truncated 
inode)
cannot be deleted. However, when there are some orphan inodes with 
i_links_count !=0,
the EXT2_VALID_FS is still assigned to fs->super->s_state, the deeper 
checkers are skipped
with some inconsistency problems.
Here, we will clean EXT2_VALID_FS flag when there is orphan inodes with 
i_links_count !=0
for deeper checkers.

Problems with truncated files.
     [root@localhost ~]# e2fsck -a img
     img: recovering journal
     img: Truncating orphaned inode 188 (uid=0, gid=0, mode=0100666, size=0)
     img: Truncating orphaned inode 174 (uid=0, gid=0, mode=0100666, size=0)
     img: clean, 484/128016 files, 118274/512000 blocks
     [root@localhost ~]# e2fsck -fn img
     e2fsck 1.46.5 (30-Dec-2021)
     Pass 1: Checking inodes, blocks, and sizes
     Inode 174, i_blocks is 2, should be 0.  Fix? no

     Inode 188, i_blocks is 2, should be 0.  Fix? no

     Pass 2: Checking directory structure
     Pass 3: Checking directory connectivity
     Pass 4: Checking reference counts
     Pass 5: Checking group summary information

     img: ********** WARNING: Filesystem still has errors **********

     img: 484/128016 files (24.6% non-contiguous), 118274/512000 blocks
     [root@localhost ~]# e2fsck -a img
     img: clean, 484/128016 files, 118274/512000 blocks

But, if run `e2fsck -f img`, EXT2_VALID_FS flag will be clean, so do 
`e2fsck -a img` again,
can fix this problem.

     [root@localhost ~]# e2fsck -f img
     e2fsck 1.46.5 (30-Dec-2021)
     Pass 1: Checking inodes, blocks, and sizes
     Inode 174, i_blocks is 2, should be 0.  Fix<y>? no
     Inode 188, i_blocks is 2, should be 0.  Fix<y>? no
     Pass 2: Checking directory structure
     Pass 3: Checking directory connectivity
     Pass 4: Checking reference counts
     Pass 5: Checking group summary information

     img: ********** WARNING: Filesystem still has errors **********

     img: 484/128016 files (24.6% non-contiguous), 118274/512000 blocks
     [root@localhost ~]# e2fsck -a img
     img was not cleanly unmounted, check forced.
     img: Inode 174, i_blocks is 2, should be 0.  FIXED.
     img: Inode 188, i_blocks is 2, should be 0.  FIXED.
     img: 484/128016 files (24.6% non-contiguous), 118274/512000 blocks

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  e2fsck/super.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 9495e029..f4a414b7 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -351,6 +351,7 @@ static int release_orphan_inode(e2fsck_t ctx, 
ext2_ino_t *ino, char *block_buf)
          inode.i_dtime = ctx->now;
      } else {
          inode.i_dtime = 0;
+        fs->super->s_state &= ~EXT2_VALID_FS;
      }
      e2fsck_write_inode_full(ctx, *ino, EXT2_INODE(&inode),
                  sizeof(inode), "delete_file");




