Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F955F34D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 04:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiF2CRE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2CRD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 22:17:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D72175A9
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 19:17:01 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXlSg4brJz9sxT;
        Wed, 29 Jun 2022 10:16:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 10:16:59 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 1/2] ext4: silence the warning when evicting inode with dioread_nolock
Date:   Wed, 29 Jun 2022 10:29:39 +0800
Message-ID: <20220629022940.2855538-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When evicting an inode with default dioread_nolock, it could be raced by
the unwritten extents converting kworker after writeback some new
allocated dirty blocks. It convert unwritten extents to written, the
extents could be merged to upper level and free extent blocks, so it
could mark the inode dirty again even this inode has been marked
I_FREEING. But the inode->i_io_list check and warning in
ext4_evict_inode() missing this corner case. Fortunately,
ext4_evict_inode() will wait all extents converting finished before this
check, so it will not lead to inode use-after-free problem, every thing
is OK besides this warning. The WARN_ON_ONCE was originally designed
for finding inode use-after-free issues in advance, but if we add
current dioread_nolock case in, it will become not quite useful, so fix
this warning by just remove this check.

 ======
 WARNING: CPU: 7 PID: 1092 at fs/ext4/inode.c:227
 ext4_evict_inode+0x875/0xc60
 ...
 RIP: 0010:ext4_evict_inode+0x875/0xc60
 ...
 Call Trace:
  <TASK>
  evict+0x11c/0x2b0
  iput+0x236/0x3a0
  do_unlinkat+0x1b4/0x490
  __x64_sys_unlinkat+0x4c/0xb0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7fa933c1115b
 ======

rm                          kworker
                            ext4_end_io_end()
vfs_unlink()
 ext4_unlink()
                             ext4_convert_unwritten_io_end_vec()
                              ext4_convert_unwritten_extents()
                               ext4_map_blocks()
                                ext4_ext_map_blocks()
                                 ext4_ext_try_to_merge_up()
                                  __mark_inode_dirty()
                                   check !I_FREEING
                                   locked_inode_to_wb_and_lock_list()
 iput()
  iput_final()
   evict()
    ext4_evict_inode()
     truncate_inode_pages_final() //wait release io_end
                                    inode_io_list_move_locked()
                             ext4_release_io_end()
     trigger WARN_ON_ONCE()

Fixes: ceff86fddae8 ("ext4: Avoid freeing inodes on dirty list")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..702cc208689a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -220,13 +220,13 @@ void ext4_evict_inode(struct inode *inode)
 
 	/*
 	 * For inodes with journalled data, transaction commit could have
-	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
-	 * flag but we still need to remove the inode from the writeback lists.
+	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
+	 * extents converting worker could merge extents and also have dirtied
+	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
+	 * we still need to remove the inode from the writeback lists.
 	 */
-	if (!list_empty_careful(&inode->i_io_list)) {
-		WARN_ON_ONCE(!ext4_should_journal_data(inode));
+	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
-	}
 
 	/*
 	 * Protect us against freezing - iput() caller didn't have to have any
-- 
2.31.1

