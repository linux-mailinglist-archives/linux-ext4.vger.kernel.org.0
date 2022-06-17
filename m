Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FE54EEC7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379483AbiFQB0i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 21:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFQB0h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 21:26:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E8633BE;
        Thu, 16 Jun 2022 18:26:36 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LPLvW22g4zjXY8;
        Fri, 17 Jun 2022 09:25:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 09:26:33 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2] ext4: fix warning in ext4_iomap_begin as race between bmap and write
Date:   Fri, 17 Jun 2022 09:39:35 +0800
Message-ID: <20220617013935.397596-1-yebin10@huawei.com>
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

We got issue as follows:
------------[ cut here ]------------
WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
RIP: 0010:ext4_iomap_begin+0x182/0x5d0
RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 iomap_apply+0x119/0x570
 iomap_bmap+0x124/0x150
 ext4_bmap+0x14f/0x250
 bmap+0x55/0x80
 do_vfs_ioctl+0x952/0xbd0
 __x64_sys_ioctl+0xc6/0x170
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Above issue may happen as follows:
          bmap                    write
bmap
  ext4_bmap
    iomap_bmap
      ext4_iomap_begin
                            ext4_file_write_iter
			      ext4_buffered_write_iter
			        generic_perform_write
				  ext4_da_write_begin
				    ext4_da_write_inline_data_begin
				      ext4_prepare_inline_data
				        ext4_create_inline_data
					  ext4_set_inode_flag(inode,
						EXT4_INODE_INLINE_DATA);
      if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on

To solved above issue hold inode lock in ext4_bamp.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 53877ffe3c41..9e520a324e37 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3142,13 +3142,15 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	journal_t *journal;
+	sector_t ret = 0;
 	int err;
 
+	inode_lock_shared(inode);
 	/*
 	 * We can get here for an inline file via the FIBMAP ioctl
 	 */
 	if (ext4_has_inline_data(inode))
-		return 0;
+		goto out;
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
 			test_opt(inode->i_sb, DELALLOC)) {
@@ -3187,10 +3189,14 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 		jbd2_journal_unlock_updates(journal);
 
 		if (err)
-			return 0;
+			goto out;
 	}
 
-	return iomap_bmap(mapping, block, &ext4_iomap_ops);
+	ret = iomap_bmap(mapping, block, &ext4_iomap_ops);
+
+out:
+	inode_unlock_shared(inode);
+	return ret;
 }
 
 static int ext4_read_folio(struct file *file, struct folio *folio)
-- 
2.31.1

