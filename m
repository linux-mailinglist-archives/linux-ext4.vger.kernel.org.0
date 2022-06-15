Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4854C070
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiFODyy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbiFODyQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 23:54:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0C13EBA;
        Tue, 14 Jun 2022 20:53:38 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNBG74LpWzjY6D;
        Wed, 15 Jun 2022 11:52:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 11:53:35 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH v2 2/4] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Wed, 15 Jun 2022 12:06:28 +0800
Message-ID: <20220615040630.808783-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220615040630.808783-1-libaokun1@huawei.com>
References: <20220615040630.808783-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hulk Robot reported a issue:
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x18ab/0x3500
Write of size 4105 at addr ffff8881675ef5f4 by task syz-executor.0/7092

CPU: 1 PID: 7092 Comm: syz-executor.0 Not tainted 4.19.90-dirty #17
Call Trace:
[...]
 memcpy+0x34/0x50 mm/kasan/kasan.c:303
 ext4_xattr_set_entry+0x18ab/0x3500 fs/ext4/xattr.c:1747
 ext4_xattr_ibody_inline_set+0x86/0x2a0 fs/ext4/xattr.c:2205
 ext4_xattr_set_handle+0x940/0x1300 fs/ext4/xattr.c:2386
 ext4_xattr_set+0x1da/0x300 fs/ext4/xattr.c:2498
 __vfs_setxattr+0x112/0x170 fs/xattr.c:149
 __vfs_setxattr_noperm+0x11b/0x2a0 fs/xattr.c:180
 __vfs_setxattr_locked+0x17b/0x250 fs/xattr.c:238
 vfs_setxattr+0xed/0x270 fs/xattr.c:255
 setxattr+0x235/0x330 fs/xattr.c:520
 path_setxattr+0x176/0x190 fs/xattr.c:539
 __do_sys_lsetxattr fs/xattr.c:561 [inline]
 __se_sys_lsetxattr fs/xattr.c:557 [inline]
 __x64_sys_lsetxattr+0xc2/0x160 fs/xattr.c:557
 do_syscall_64+0xdf/0x530 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x459fe9
RSP: 002b:00007fa5e54b4c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 000000000051bf60 RCX: 0000000000459fe9
RDX: 00000000200003c0 RSI: 0000000020000180 RDI: 0000000020000140
RBP: 000000000051bf60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000001009 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc73c93fc0 R14: 000000000051bf60 R15: 00007fa5e54b4d80
[...]
==================================================================

Above issue may happen as follows:
-------------------------------------
ext4_xattr_set
  ext4_xattr_set_handle
    ext4_xattr_ibody_find
      >> s->end < s->base
      >> no EXT4_STATE_XATTR
      >> xattr_check_inode is not executed
    ext4_xattr_ibody_set
      ext4_xattr_set_entry
       >> size_t min_offs = s->end - s->base
       >> UAF in memcpy

we can easily reproduce this problem with the following commands:
    mkfs.ext4 -F /dev/sda
    mount -o debug_want_extra_isize=128 /dev/sda /mnt
    touch /mnt/file
    setfattr -n user.cat -v `seq -s z 4096|tr -d '[:digit:]'` /mnt/file

In ext4_xattr_ibody_find, we have the following assignment logic:
  header = IHDR(inode, raw_inode)
         = raw_inode + EXT4_GOOD_OLD_INODE_SIZE + i_extra_isize
  is->s.base = IFIRST(header)
             = header + sizeof(struct ext4_xattr_ibody_header)
  is->s.end = raw_inode + s_inode_size

In ext4_xattr_set_entry
  min_offs = s->end - s->base
           = s_inode_size - EXT4_GOOD_OLD_INODE_SIZE - i_extra_isize -
	     sizeof(struct ext4_xattr_ibody_header)
  last = s->first
  free = min_offs - ((void *)last - s->base) - sizeof(__u32)
       = s_inode_size - EXT4_GOOD_OLD_INODE_SIZE - i_extra_isize -
         sizeof(struct ext4_xattr_ibody_header) - sizeof(__u32)

In the calculation formula, all values except s_inode_size and
i_extra_size are fixed values. When i_extra_size is the maximum value
s_inode_size - EXT4_GOOD_OLD_INODE_SIZE, min_offs is -4 and free is -8.
The value overflows. As a result, the preceding issue is triggered when
memcpy is executed.

   EXT4_GOOD_OLD_INODE_SIZE  extra_isize  header   entry   pad   data
|---------------------------|------------|------|---------|---|--------|

As shown above, when adding an xattr to an inode, we must ensure that the
inode_size is not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 042325349098..c95f9fd747b6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2176,8 +2176,9 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	struct ext4_inode *raw_inode;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!EXT4_INODE_HAVE_XATTR_SPACE(inode))
 		return 0;
+
 	raw_inode = ext4_raw_inode(&is->iloc);
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
@@ -2205,8 +2206,9 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_search *s = &is->s;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!EXT4_INODE_HAVE_XATTR_SPACE(inode))
 		return -ENOSPC;
+
 	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
 	if (error)
 		return error;
-- 
2.31.1

