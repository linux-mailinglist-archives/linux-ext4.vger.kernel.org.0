Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4277CBBF
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjHOLaH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 07:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjHOL3v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 07:29:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101201BE8;
        Tue, 15 Aug 2023 04:29:40 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ8CS09wyz1GDW8;
        Tue, 15 Aug 2023 19:28:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 19:29:38 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 3/4] ext2: fix race between setxattr and write back
Date:   Tue, 15 Aug 2023 19:26:11 +0800
Message-ID: <20230815112612.221145-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815112612.221145-1-yebin10@huawei.com>
References: <20230815112612.221145-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
To solve about issue don't use reservation window when allocate block for xattr.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/balloc.c | 15 +++++++++------
 fs/ext2/xattr.c  |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 99a19f2ecd6f..4ff1d831bb80 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1247,13 +1247,16 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 	 * it's a regular file, and
 	 * the desired window size is greater than 0 (One could use ioctl
 	 * command EXT2_IOC_SETRSVSZ to set the window size to 0 to turn off
-	 * reservation on that particular file)
+	 * reservation on that particular file), and unspecified Do not use
+	 * reservation window.
 	 */
-	block_i = EXT2_I(inode)->i_block_alloc_info;
-	if (block_i) {
-		windowsz = block_i->rsv_window_node.rsv_goal_size;
-		if (windowsz > 0)
-			my_rsv = &block_i->rsv_window_node;
+	if (!(flag & EXT2_ALLOC_NORESERVE)) {
+		block_i = EXT2_I(inode)->i_block_alloc_info;
+		if (block_i) {
+			windowsz = block_i->rsv_window_node.rsv_goal_size;
+			if (windowsz > 0)
+				my_rsv = &block_i->rsv_window_node;
+		}
 	}
 
 	if (!ext2_has_free_blocks(sbi)) {
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index e076386a26f4..21725b8d04c8 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -743,8 +743,8 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
 			unsigned long count = 1;
-			int block = ext2_new_blocks(inode, goal, &count,
-						    &error, 0);
+			int block = ext2_new_blocks(inode, goal, &count, &error,
+						    EXT2_ALLOC_NORESERVE);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
-- 
2.31.1

