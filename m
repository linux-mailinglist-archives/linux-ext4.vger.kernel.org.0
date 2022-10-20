Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8224D605E93
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Oct 2022 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJTLPT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Oct 2022 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJTLPP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Oct 2022 07:15:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2CF01BC;
        Thu, 20 Oct 2022 04:15:09 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtPyr6X7XzVhlW;
        Thu, 20 Oct 2022 19:10:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 19:15:07 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 1/2] ext4: fix bug_on in __es_tree_search caused by wrong s_usr_quota_inum
Date:   Thu, 20 Oct 2022 19:37:06 +0800
Message-ID: <20221020113707.3349399-2-libaokun1@huawei.com>
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
 kernel BUG at fs/ext4/extents_status.c:202!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 1 PID: 810 Comm: mount Not tainted 6.1.0-rc1-next-g9631525255e3 #352
 RIP: 0010:__es_tree_search.isra.0+0xb8/0xe0
 RSP: 0018:ffffc90001227900 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000077512a0f RCX: 0000000000000000
 RDX: 0000000000000002 RSI: 0000000000002a10 RDI: ffff8881004cd0c8
 RBP: ffff888177512ac8 R08: 47ffffffffffffff R09: 0000000000000001
 R10: 0000000000000001 R11: 00000000000679af R12: 0000000000002a10
 R13: ffff888177512d88 R14: 0000000077512a10 R15: 0000000000000000
 FS: 00007f4bd76dbc40(0000)GS:ffff88842fd00000(0000)knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00005653bf993cf8 CR3: 000000017bfdf000 CR4: 00000000000006e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ext4_es_cache_extent+0xe2/0x210
  ext4_cache_extents+0xd2/0x110
  ext4_find_extent+0x5d5/0x8c0
  ext4_ext_map_blocks+0x9c/0x1d30
  ext4_map_blocks+0x431/0xa50
  ext4_getblk+0x82/0x340
  ext4_bread+0x14/0x110
  ext4_quota_read+0xf0/0x180
  v2_read_header+0x24/0x90
  v2_check_quota_file+0x2f/0xa0
  dquot_load_quota_sb+0x26c/0x760
  dquot_load_quota_inode+0xa5/0x190
  ext4_enable_quotas+0x14c/0x300
  __ext4_fill_super+0x31cc/0x32c0
  ext4_fill_super+0x115/0x2d0
  get_tree_bdev+0x1d2/0x360
  ext4_get_tree+0x19/0x30
  vfs_get_tree+0x26/0xe0
  path_mount+0x81d/0xfc0
  do_mount+0x8d/0xc0
  __x64_sys_mount+0xc0/0x160
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  </TASK>
==================================================================

Above issue may happen as follows:
-------------------------------------
ext4_fill_super
 ext4_orphan_cleanup
  ext4_enable_quotas
   ext4_quota_enable
    ext4_iget --> get error inode <5>
     ext4_ext_check_inode --> Wrong imode makes it escape inspection
     make_bad_inode(inode) --> EXT4_BOOT_LOADER_INO set imode
    dquot_load_quota_inode
     vfs_setup_quota_inode --> check pass
     dquot_load_quota_sb
      v2_check_quota_file
       v2_read_header
        ext4_quota_read
         ext4_bread
          ext4_getblk
           ext4_map_blocks
            ext4_ext_map_blocks
             ext4_find_extent
              ext4_cache_extents
               ext4_es_cache_extent
                __es_tree_search.isra.0
                 ext4_es_end --> Wrong extents trigger BUG_ON

In the above issue, s_usr_quota_inum is set to 5, but inode<5> contains
incorrect imode and disordered extents. Because 5 is EXT4_BOOT_LOADER_INO,
the ext4_ext_check_inode check in the ext4_iget function can be bypassed,
finally, the extents that are not checked trigger the BUG_ON in the
__es_tree_search function. To solve this issue, check whether qf_inode
obtained by ext4_iget is bad_inode.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7a57dadfe256..5a5f95c6a0cb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6907,9 +6907,9 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 		return -EPERM;
 
 	qf_inode = ext4_iget(sb, qf_inums[type], EXT4_IGET_SPECIAL);
-	if (IS_ERR(qf_inode)) {
+	if (IS_ERR(qf_inode) || is_bad_inode(qf_inode)) {
 		ext4_error(sb, "Bad quota inode # %lu", qf_inums[type]);
-		return PTR_ERR(qf_inode);
+		return IS_ERR(qf_inode) ? PTR_ERR(qf_inode) : -EUCLEAN;
 	}
 
 	/* Don't account quota for quota files to avoid recursion */
-- 
2.31.1

