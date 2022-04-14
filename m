Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C050045E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Apr 2022 04:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiDNCkT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Apr 2022 22:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDNCkS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Apr 2022 22:40:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D022B0F;
        Wed, 13 Apr 2022 19:37:54 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kf3Rf2hPLzCqwc;
        Thu, 14 Apr 2022 10:33:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 10:37:52 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: fix use-after-free in ext4_rename_dir_prepare
Date:   Thu, 14 Apr 2022 10:52:23 +0800
Message-ID: <20220414025223.4113128-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got issue as follows:
EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
ext4_get_first_dir_block: bh->b_data=0xffff88810bee6000 len=34478
ext4_get_first_dir_block: *parent_de=0xffff88810beee6ae bh->b_data=0xffff88810bee6000
ext4_rename_dir_prepare: [1] parent_de=0xffff88810beee6ae
==================================================================
BUG: KASAN: use-after-free in ext4_rename_dir_prepare+0x152/0x220
Read of size 4 at addr ffff88810beee6ae by task rep/1895

CPU: 13 PID: 1895 Comm: rep Not tainted 5.10.0+ #241
Call Trace:
 dump_stack+0xbe/0xf9
 print_address_description.constprop.0+0x1e/0x220
 kasan_report.cold+0x37/0x7f
 ext4_rename_dir_prepare+0x152/0x220
 ext4_rename+0xf44/0x1ad0
 ext4_rename2+0x11c/0x170
 vfs_rename+0xa84/0x1440
 do_renameat2+0x683/0x8f0
 __x64_sys_renameat+0x53/0x60
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f45a6fc41c9
RSP: 002b:00007ffc5a470218 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f45a6fc41c9
RDX: 0000000000000005 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007ffc5a470240 R08: 00007ffc5a470160 R09: 0000000020000080
R10: 00000000200001c0 R11: 0000000000000246 R12: 0000000000400bb0
R13: 00007ffc5a470320 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:00000000440015ce refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x10beee
flags: 0x200000000000000()
raw: 0200000000000000 ffffea00043ff4c8 ffffea0004325608 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810beee580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88810beee600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88810beee680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                  ^
 ffff88810beee700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88810beee780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
Disabling lock debugging due to kernel taint
ext4_rename_dir_prepare: [2] parent_de->inode=3537895424
ext4_rename_dir_prepare: [3] dir=0xffff888124170140
ext4_rename_dir_prepare: [4] ino=2
ext4_rename_dir_prepare: ent->dir->i_ino=2 parent=-757071872

Reason is first directory entry which 'rec_len' is 34478, then will get illegal
parent entry. Now, we do not check directory entry after read directory block
in 'ext4_get_first_dir_block'.
To solve this issue, check directory entry in 'ext4_get_first_dir_block'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/namei.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e37da8d5cd0c..2f78544b1d47 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3455,6 +3455,9 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 	struct buffer_head *bh;
 
 	if (!ext4_has_inline_data(inode)) {
+		struct ext4_dir_entry_2 *de;
+		unsigned int offset;
+
 		/* The first directory block must not be a hole, so
 		 * treat it as DIRENT_HTREE
 		 */
@@ -3463,9 +3466,28 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 			*retval = PTR_ERR(bh);
 			return NULL;
 		}
-		*parent_de = ext4_next_entry(
-					(struct ext4_dir_entry_2 *)bh->b_data,
-					inode->i_sb->s_blocksize);
+
+		de = (struct ext4_dir_entry_2 *) bh->b_data;
+		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
+					 bh->b_size, 0) ||
+		    le32_to_cpu(de->inode) != inode->i_ino ||
+		    strcmp(".", de->name)) {
+			ext4_warning_inode(inode, "directory missing '.'");
+			brelse(bh);
+			return NULL;
+		}
+		offset = ext4_rec_len_from_disk(de->rec_len,
+						inode->i_sb->s_blocksize);
+		de = ext4_next_entry(de, inode->i_sb->s_blocksize);
+		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
+					 bh->b_size, offset) ||
+		    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
+			ext4_warning_inode(inode, "directory missing '..'");
+			brelse(bh);
+			return NULL;
+		}
+		*parent_de = de;
+
 		return bh;
 	}
 
-- 
2.31.1

