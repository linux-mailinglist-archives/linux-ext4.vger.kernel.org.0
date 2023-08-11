Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E94778621
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 05:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHKDmV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 23:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHKDmU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 23:42:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6161F211B;
        Thu, 10 Aug 2023 20:42:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMTzX1D4JzCrcK;
        Fri, 11 Aug 2023 11:38:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:42:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH 1/2] ext2: fix race between setxattr and write back
Date:   Fri, 11 Aug 2023 11:38:56 +0800
Message-ID: <20230811033857.1800578-2-yebin10@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's a issue as follows:
Block Allocation Reservation Windows Map (ext2_try_to_allocate_with_rsv):
reservation window 0x000000006f105382 start: 0, end: 0
reservation window 0x000000008fd1a555 start: 1044, end: 1059
Window map complete.
kernel BUG at fs/ext2/balloc.c:1158!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
RIP: 0010:ext2_try_to_allocate_with_rsv.isra.0+0x15c4/0x1800
Call Trace:
 <TASK>
 ext2_new_blocks+0x935/0x1690
 ext2_new_block+0x73/0xa0
 ext2_xattr_set2+0x74f/0x1730
 ext2_xattr_set+0x12b6/0x2260
 ext2_xattr_user_set+0x9c/0x110
 __vfs_setxattr+0x139/0x1d0
 __vfs_setxattr_noperm+0xfc/0x370
 __vfs_setxattr_locked+0x205/0x2c0
 vfs_setxattr+0x19d/0x3b0
 do_setxattr+0xff/0x220
 setxattr+0x123/0x150
 path_setxattr+0x193/0x1e0
 __x64_sys_setxattr+0xc8/0x170
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue may happens as follows:
        setxattr                             write back
ext2_xattr_set
  ext2_xattr_set2
    ext2_new_block
      ext2_new_blocks
        ext2_try_to_allocate_with_rsv
	  alloc_new_reservation
	  --> group=0 [0, 1023] rsv [1016, 1023]
	                                do_writepages
					  mpage_writepages
					    write_cache_pages
					      __mpage_writepage
					        ext2_get_block
						  ext2_get_blocks
						   ext2_alloc_branch
						    ext2_new_blocks
						     ext2_try_to_allocate_with_rsv
						       alloc_new_reservation
		                     -->group=1 [1024, 2047] rsv [1044, 1059]
	  if ((my_rsv->rsv_start > group_last_block) ||
	      (my_rsv->rsv_end < group_first_block)
	      rsv_window_dump
	      BUG();
Now ext2 mkwrite delay allocate new blocks. So there maybe allocate blocks when
do write back. However, there is no concurrent protection between
ext2_xattr_set() and do_writepages().
To solve about issue hold '&ei->truncate_mutex' lock when new block for xattr.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c8049c90323d..039f655febfd 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1432,8 +1432,14 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
 {
 	unsigned long count = 1;
+	struct ext2_inode_info *ei = EXT2_I(inode);
+	ext2_fsblk_t ret;
+
+	mutex_lock(&ei->truncate_mutex);
+	ret = ext2_new_blocks(inode, goal, &count, errp);
+	mutex_unlock(&ei->truncate_mutex);
 
-	return ext2_new_blocks(inode, goal, &count, errp);
+	return ret;
 }
 
 #ifdef EXT2FS_DEBUG
-- 
2.31.1

