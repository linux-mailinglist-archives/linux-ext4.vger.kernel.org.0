Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4588751C122
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348504AbiEENqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 May 2022 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiEENqu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 May 2022 09:46:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875357158;
        Thu,  5 May 2022 06:43:10 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvFHx3QByzhYqf;
        Thu,  5 May 2022 21:42:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 21:43:07 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: fix bug_on in ext4_writepages
Date:   Thu, 5 May 2022 21:57:08 +0800
Message-ID: <20220505135708.2629657-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

we got issue as follows:
EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2708!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
RIP: 0010:ext4_writepages+0x1977/0x1c10
RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_writepages+0x130/0x3a0
 filemap_fdatawrite_wbc+0x83/0xa0
 filemap_flush+0xab/0xe0
 ext4_alloc_da_blocks+0x51/0x120
 __ext4_ioctl+0x1534/0x3210
 __x64_sys_ioctl+0x12c/0x170
 do_syscall_64+0x3b/0x90

It may happen as follows:
1. write inline_data inode
vfs_write
  new_sync_write
    ext4_file_write_iter
      ext4_buffered_write_iter
        generic_perform_write
	  ext4_da_write_begin
	    ext4_da_write_inline_data_begin -> If inline data size too
	    small will allocate block to write, then mapping will has
	    dirty page
	    	ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
2. fallocate
do_vfs_ioctl
  ioctl_preallocate
    vfs_fallocate
      ext4_fallocate
        ext4_convert_inline_data
	  ext4_convert_inline_data_nolock
	    ext4_map_blocks -> fail will goto restore data
	    ext4_restore_inline_data
	      ext4_create_inline_data
	      ext4_write_inline_data
	      ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
3. writepages
__ext4_ioctl
  ext4_alloc_da_blocks
    filemap_flush
      filemap_fdatawrite_wbc
        do_writepages
	  ext4_writepages
	    if (ext4_has_inline_data(inode))
	      BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))

To solved this issue, record origin 'EXT4_STATE_MAY_INLINE_DATA' flag, then pass
value to 'ext4_restore_inline_data', 'ext4_restore_inline_data' will
decide to if recovery 'EXT4_STATE_MAY_INLINE_DATA' flag according to parameter.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inline.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9c076262770d..407061c79adc 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1125,8 +1125,8 @@ static int ext4_update_inline_dir(handle_t *handle, struct inode *dir,
 }
 
 static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
-				     struct ext4_iloc *iloc,
-				     void *buf, int inline_size)
+				     struct ext4_iloc *iloc, void *buf,
+				     int inline_size, bool has_data)
 {
 	int ret;
 
@@ -1138,7 +1138,8 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 		return;
 	}
 	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
-	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	if (has_data)
+		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 }
 
 static int ext4_finish_convert_inline_dir(handle_t *handle,
@@ -1194,6 +1195,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	struct buffer_head *data_bh = NULL;
 	struct ext4_map_blocks map;
 	int inline_size;
+	bool has_data;
 
 	inline_size = ext4_get_inline_size(inode);
 	buf = kmalloc(inline_size, GFP_NOFS);
@@ -1222,6 +1224,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (error)
 		goto out;
 
+	has_data = !!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+
 	map.m_lblk = 0;
 	map.m_len = 1;
 	map.m_flags = 0;
@@ -1262,7 +1266,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	unlock_buffer(data_bh);
 out_restore:
 	if (error)
-		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
+		ext4_restore_inline_data(handle, inode, iloc, buf,
+					 inline_size, has_data);
 
 out:
 	brelse(data_bh);
-- 
2.31.1

