Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B198602113
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Oct 2022 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJRCUu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Oct 2022 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJRCUo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Oct 2022 22:20:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4112D7E026;
        Mon, 17 Oct 2022 19:20:37 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mrxs22v4XzVhwZ;
        Tue, 18 Oct 2022 10:00:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 10:04:57 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>,
        <syzbot+c740bb18df70ad00952e@syzkaller.appspotmail.com>
Subject: [PATCH -next v2] ext4: fix warning in 'ext4_da_release_space'
Date:   Tue, 18 Oct 2022 10:27:01 +0800
Message-ID: <20221018022701.683489-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzkaller report issue as follows:
EXT4-fs (loop0): Free/Dirty block details
EXT4-fs (loop0): free_blocks=0
EXT4-fs (loop0): dirty_blocks=0
EXT4-fs (loop0): Block reservation details
EXT4-fs (loop0): i_reserved_data_blocks=0
EXT4-fs warning (device loop0): ext4_da_release_space:1527: ext4_da_release_space: ino 18, to_free 1 with only 0 reserved data blocks
------------[ cut here ]------------
WARNING: CPU: 0 PID: 92 at fs/ext4/inode.c:1528 ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1524
Modules linked in:
CPU: 0 PID: 92 Comm: kworker/u4:4 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1528
RSP: 0018:ffffc900015f6c90 EFLAGS: 00010296
RAX: 42215896cd52ea00 RBX: 0000000000000000 RCX: 42215896cd52ea00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 1ffff1100e907d96 R08: ffffffff816aa79d R09: fffff520002bece5
R10: fffff520002bece5 R11: 1ffff920002bece4 R12: ffff888021fd2000
R13: ffff88807483ecb0 R14: 0000000000000001 R15: ffff88807483e740
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555569ba628 CR3: 000000000c88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_es_remove_extent+0x1ab/0x260 fs/ext4/extents_status.c:1461
 mpage_release_unused_pages+0x24d/0xef0 fs/ext4/inode.c:1589
 ext4_writepages+0x12eb/0x3be0 fs/ext4/inode.c:2852
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1587
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1870
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2044
 wb_do_writeback fs/fs-writeback.c:2187 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2227
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Above issue may happens as follows:
ext4_da_write_begin
  ext4_create_inline_data
    ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
    ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
__ext4_ioctl
  ext4_ext_migrate -> will lead to eh->eh_entries not zero, and set extent flag
ext4_da_write_begin
  ext4_da_convert_inline_data_to_extent
    ext4_da_write_inline_data_begin
      ext4_da_map_blocks
        ext4_insert_delayed_block
	  if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
	    if (!ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
	      ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk)); -> will return 1
	       allocated = true;
          ext4_es_insert_delayed_block(inode, lblk, allocated);
ext4_writepages
  mpage_map_and_submit_extent(handle, &mpd, &give_up_on_write); -> return -ENOSPC
  mpage_release_unused_pages(&mpd, give_up_on_write); -> give_up_on_write == 1
    ext4_es_remove_extent
      ext4_da_release_space(inode, reserved);
        if (unlikely(to_free > ei->i_reserved_data_blocks))
	  -> to_free == 1  but ei->i_reserved_data_blocks == 0
	  -> then trigger warning as above

To solve above issue, forbid inode do migrate which has inline data.

Reported-by: syzbot+c740bb18df70ad00952e@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 0a220ec9862d..a19a9661646e 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -424,7 +424,8 @@ int ext4_ext_migrate(struct inode *inode)
 	 * already is extent-based, error out.
 	 */
 	if (!ext4_has_feature_extents(inode->i_sb) ||
-	    (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) ||
+	    ext4_has_inline_data(inode))
 		return -EINVAL;
 
 	if (S_ISLNK(inode->i_mode) && inode->i_blocks == 0)
-- 
2.31.1

