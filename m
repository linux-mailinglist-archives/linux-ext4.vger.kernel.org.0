Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCF52E293
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 04:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiETCmF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiETCmE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 22:42:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822A985BF;
        Thu, 19 May 2022 19:42:03 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L49sP0zvYzQkHZ;
        Fri, 20 May 2022 10:39:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 10:42:00 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: Fix warning in ext4_da_release_space
Date:   Fri, 20 May 2022 10:55:40 +0800
Message-ID: <20220520025540.3189247-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

We got issue as follows:
WARNING: CPU: 2 PID: 1936 at fs/ext4/inode.c:1511 ext4_da_release_space+0x1b9/0x266
Modules linked in:
CPU: 2 PID: 1936 Comm: dd Not tainted 5.10.0+ #344
RIP: 0010:ext4_da_release_space+0x1b9/0x266
RSP: 0018:ffff888127307848 EFLAGS: 00010292
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff843f67cc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffed1024e60ed9
RBP: ffff888124dc8140 R08: 0000000000000083 R09: ffffed1075da6d23
R10: ffff8883aed36917 R11: ffffed1075da6d22 R12: ffff888124dc83f0
R13: ffff888124dc844c R14: ffff888124dc8168 R15: 000000000000000c
FS:  00007f6b7247d740(0000) GS:ffff8883aed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc1a0b7dd8 CR3: 00000001065ce000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_es_remove_extent+0x187/0x230
 mpage_release_unused_pages+0x3af/0x470
 ext4_writepages+0xb9b/0x1160
 do_writepages+0xbb/0x1e0
 __filemap_fdatawrite_range+0x1b1/0x1f0
 file_write_and_wait_range+0x80/0xe0
 ext4_sync_file+0x13d/0x800
 vfs_fsync_range+0x75/0x140
 do_fsync+0x4d/0x90
 __x64_sys_fsync+0x1d/0x30
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Above issue may happens as follows:
	process1                        process2
ext4_da_write_begin
  ext4_da_reserve_space
    ext4_es_insert_delayed_block[1/1]
                                    ext4_da_write_begin
				      ext4_es_insert_delayed_block[0/1]
ext4_writepages
  ****Delayed block allocation failed****
  mpage_release_unused_pages
    ext4_es_remove_extent[1/1]
      ext4_da_release_space [reserved 0]

ext4_da_write_begin
  ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)
   ->As there exist [0, 1] extent, so will return true
                                   ext4_writepages
				   ****Delayed block allocation failed****
                                     mpage_release_unused_pages
				       ext4_es_remove_extent[0/1]
				         ext4_da_release_space [reserved 1]
					   ei->i_reserved_data_blocks [1->0]

  ext4_es_insert_delayed_block[1/1]

ext4_writepages
  ****Delayed block allocation failed****
  mpage_release_unused_pages
  ext4_es_remove_extent[1/1]
   ext4_da_release_space [reserved 1]
    ei->i_reserved_data_blocks[0, -1]
    ->As ei->i_reserved_data_blocks already is zero but to_free is 1,
    will trigger warning.

To solve above issue, introduce i_clu_lock to protect insert delayed
block and remove block under cluster delay allocate mode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4.h           |  3 +++
 fs/ext4/extents_status.c |  5 +++++
 fs/ext4/inode.c          | 11 +++++++++--
 fs/ext4/super.c          |  1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bcd3b9bf8069..47c88ac4d4a8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1169,6 +1169,9 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+	/* Protect concurrent add cluster delayed block and remove block */
+	struct mutex i_clu_lock;
 };
 
 /*
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9a3a8996aacf..dd679014db98 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1433,6 +1433,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			  ext4_lblk_t len)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t end;
 	int err = 0;
 	int reserved = 0;
@@ -1455,9 +1456,13 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * so that we are sure __es_shrink() is done with the inode before it
 	 * is reclaimed.
 	 */
+	if (sbi->s_cluster_ratio != 1)
+		mutex_lock(&EXT4_I(inode)->i_clu_lock);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 	err = __es_remove_extent(inode, lblk, end, &reserved);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (sbi->s_cluster_ratio != 1)
+		mutex_unlock(&EXT4_I(inode)->i_clu_lock);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
 	return err;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..1109d77ad60b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1649,17 +1649,22 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 			goto errout;
 		reserved = true;
 	} else {   /* bigalloc */
+		mutex_lock(&EXT4_I(inode)->i_clu_lock);
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
 					      &ext4_es_is_mapped, lblk)) {
 				ret = ext4_clu_mapped(inode,
 						      EXT4_B2C(sbi, lblk));
-				if (ret < 0)
+				if (ret < 0) {
+					mutex_unlock(&EXT4_I(inode)->i_clu_lock);
 					goto errout;
+				}
 				if (ret == 0) {
 					ret = ext4_da_reserve_space(inode);
-					if (ret != 0)   /* ENOSPC */
+					if (ret != 0) {   /* ENOSPC */
+						mutex_unlock(&EXT4_I(inode)->i_clu_lock);
 						goto errout;
+					}
 					reserved = true;
 				} else {
 					allocated = true;
@@ -1671,6 +1676,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	}
 
 	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
+	if (sbi->s_cluster_ratio != 1)
+		mutex_unlock(&EXT4_I(inode)->i_clu_lock);
 	if (ret && reserved)
 		ext4_da_release_space(inode, 1);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5021ca0a28a..aa6f2a68bf41 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1347,6 +1347,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
+	mutex_init(&ei->i_clu_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.31.1

