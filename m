Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43F5593C1
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jun 2022 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiFXGvY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jun 2022 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFXGvX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jun 2022 02:51:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A56367E4E
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 23:51:20 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTnlm0kttzhYdD;
        Fri, 24 Jun 2022 14:49:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 14:51:17 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext4: silence the warning when evicting inode with dioread_nolock
Date:   Fri, 24 Jun 2022 15:04:04 +0800
Message-ID: <20220624070404.763603-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
check, so it will not lead to inode use-after-free problem, so every
thing is OK besides this warning, let the WARN_ON_ONCE know the
dioread_nolock case to silence this warning is fine.

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
 fs/ext4/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..3b64d72416b7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -220,11 +220,14 @@ void ext4_evict_inode(struct inode *inode)
 
 	/*
 	 * For inodes with journalled data, transaction commit could have
-	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
-	 * flag but we still need to remove the inode from the writeback lists.
+	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
+	 * extents converting worker could merged extents and also have dirtied
+	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
+	 * we still need to remove the inode from the writeback lists.
 	 */
 	if (!list_empty_careful(&inode->i_io_list)) {
-		WARN_ON_ONCE(!ext4_should_journal_data(inode));
+		WARN_ON_ONCE(!ext4_should_journal_data(inode) &&
+			     !ext4_should_dioread_nolock(inode));
 		inode_io_list_del(inode);
 	}
 
-- 
2.31.1

