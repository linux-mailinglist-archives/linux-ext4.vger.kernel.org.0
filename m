Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF327605E91
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Oct 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJTLPR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Oct 2022 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJTLPO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Oct 2022 07:15:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071FAEA1E;
        Thu, 20 Oct 2022 04:15:09 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtQ0N3KM0zpSsj;
        Thu, 20 Oct 2022 19:11:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 19:15:07 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 2/2] ext4: fix bug_on in __es_tree_search caused by wrong boot loader inode
Date:   Thu, 20 Oct 2022 19:37:07 +0800
Message-ID: <20221020113707.3349399-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020113707.3349399-1-libaokun1@huawei.com>
References: <20221020113707.3349399-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got a issue as fllows:
==================================================================
 kernel BUG at fs/ext4/extents_status.c:203!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 1 PID: 945 Comm: cat Not tainted 6.0.0-next-20221007-dirty #349
 RIP: 0010:ext4_es_end.isra.0+0x34/0x42
 RSP: 0018:ffffc9000143b768 EFLAGS: 00010203
 RAX: 0000000000000000 RBX: ffff8881769cd0b8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff8fc27cf7 RDI: 00000000ffffffff
 RBP: ffff8881769cd0bc R08: 0000000000000000 R09: ffffc9000143b5f8
 R10: 0000000000000001 R11: 0000000000000001 R12: ffff8881769cd0a0
 R13: ffff8881768e5668 R14: 00000000768e52f0 R15: 0000000000000000
 FS: 00007f359f7f05c0(0000)GS:ffff88842fd00000(0000)knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f359f5a2000 CR3: 000000017130c000 CR4: 00000000000006e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  __es_tree_search.isra.0+0x6d/0xf5
  ext4_es_cache_extent+0xfa/0x230
  ext4_cache_extents+0xd2/0x110
  ext4_find_extent+0x5d5/0x8c0
  ext4_ext_map_blocks+0x9c/0x1d30
  ext4_map_blocks+0x431/0xa50
  ext4_mpage_readpages+0x48e/0xe40
  ext4_readahead+0x47/0x50
  read_pages+0x82/0x530
  page_cache_ra_unbounded+0x199/0x2a0
  do_page_cache_ra+0x47/0x70
  page_cache_ra_order+0x242/0x400
  ondemand_readahead+0x1e8/0x4b0
  page_cache_sync_ra+0xf4/0x110
  filemap_get_pages+0x131/0xb20
  filemap_read+0xda/0x4b0
  generic_file_read_iter+0x13a/0x250
  ext4_file_read_iter+0x59/0x1d0
  vfs_read+0x28f/0x460
  ksys_read+0x73/0x160
  __x64_sys_read+0x1e/0x30
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  </TASK>
==================================================================

In the above issue, ioctl invokes the swap_inode_boot_loader function to
swap inode<5> and inode<12>. However, inode<5> contain incorrect imode and
disordered extents, and i_nlink is set to 1. The extents check for inode in
the ext4_iget function can be bypassed bacause 5 is EXT4_BOOT_LOADER_INO.
While links_count is set to 1, the extents are not initialized in
swap_inode_boot_loader. After the ioctl command is executed successfully,
the extents are swapped to inode<12>, in this case, run the `cat` command
to view inode<12>. And Bug_ON is triggered due to the incorrect extents.

When the boot loader inode is not initialized, it is marked as bad_inode
in ext4_iget because imode is abnormal. After initialization, imode is set
to S_IFREG. In this case, the ext4_ext_check_inode function is used for
check, and no issue is triggered. Therefore, we can determine whether an
inode needs to be initialized by checking whether the boot loader inode is
a bad inode instead of i_nlink.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ded535535b27..82b54f73f089 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -425,7 +425,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(inode, inode_bl);
 
-	if (inode_bl->i_nlink == 0) {
+	if (is_bad_inode(inode_bl)) {
 		/* this inode has never been used as a BOOT_LOADER */
 		set_nlink(inode_bl, 1);
 		i_uid_write(inode_bl, 0);
-- 
2.31.1

