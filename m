Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B805214E8
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiEJMP4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiEJMPy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 08:15:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95933A3A;
        Tue, 10 May 2022 05:11:57 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyGzl38wHzGpcX;
        Tue, 10 May 2022 20:09:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 20:11:54 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2] ext4: fix warning in ext4_handle_inode_extension
Date:   Tue, 10 May 2022 20:25:45 +0800
Message-ID: <20220510122545.1770410-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
EXT4-fs error (device loop0) in ext4_reserve_inode_write:5741: Out of memory
EXT4-fs error (device loop0): ext4_setattr:5462: inode #13: comm syz-executor.0: mark_inode_dirty error
EXT4-fs error (device loop0) in ext4_setattr:5519: Out of memory
EXT4-fs error (device loop0): ext4_ind_map_blocks:595: inode #13: comm syz-executor.0: Can't allocate blocks for non-extent mapped inodes with bigalloc
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4361 at fs/ext4/file.c:301 ext4_file_write_iter+0x11c9/0x1220
Modules linked in:
CPU: 1 PID: 4361 Comm: syz-executor.0 Not tainted 5.10.0+ #1
RIP: 0010:ext4_file_write_iter+0x11c9/0x1220
RSP: 0018:ffff924d80b27c00 EFLAGS: 00010282
RAX: ffffffff815a3379 RBX: 0000000000000000 RCX: 000000003b000000
RDX: ffff924d81601000 RSI: 00000000000009cc RDI: 00000000000009cd
RBP: 000000000000000d R08: ffffffffbc5a2c6b R09: 0000902e0e52a96f
R10: ffff902e2b7c1b40 R11: ffff902e2b7c1b40 R12: 000000000000000a
R13: 0000000000000001 R14: ffff902e0e52aa10 R15: ffffffffffffff8b
FS:  00007f81a7f65700(0000) GS:ffff902e3bc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000012db88001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_iter_readv_writev+0x2e5/0x360
 do_iter_write+0x112/0x4c0
 do_pwritev+0x1e5/0x390
 __x64_sys_pwritev2+0x7e/0xa0
 do_syscall_64+0x37/0x50
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Above issue may happen as follows:
Assume
inode.i_size=4096
EXT4_I(inode)->i_disksize=4096

step 1: set inode->i_isize = 8192
ext4_setattr
  if (attr->ia_size != inode->i_size)
    EXT4_I(inode)->i_disksize = attr->ia_size;
    rc = ext4_mark_inode_dirty
       ext4_reserve_inode_write
          ext4_get_inode_loc
            __ext4_get_inode_loc
              sb_getblk --> return -ENOMEM
   ...
   if (!error)  ->will not update i_size
     i_size_write(inode, attr->ia_size);
Now:
inode.i_size=4096
EXT4_I(inode)->i_disksize=8192

step 2: Direct write 4096 bytes
ext4_file_write_iter
 ext4_dio_write_iter
   iomap_dio_rw ->return error
 if (extend)
   ext4_handle_inode_extension
     WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
->Then trigger warning.

To solve above issue, when ext4_reserve_inode_write failed we abort jbd2
instead of only record error information.
This modification scheme is based on Jan Kara's suggestion:
"Well, firstly, errors=continue was always the best effort. There are no
guarantees which failures we are able to withstand and which not.
Generally, I think we try to withstand on-disk filesystem inconsistency but
not inconsistency coming from programming errors or other external factors
like out-of-memory conditions. Secondly, we already do abort the journal
when e.g. jbd2_journal_get_write_access() fails (although that generally
means some internal inconsistency) or when say revoke handling fails to
allocate memory for a revoke record. So it won't be a new thing. Thirdly,
and perhaps most importantly, you have found and fixed just one fairly
innocent problem happening due to in memory inode state getting
inconsistent after we fail to record the inode in the journal. There are
almost 80 callsites of ext4_mark_inode_dirty() and honestly I suspect that
e.g. inconsistent states resulting from extent tree manipulations being
aborted in the middle due to ext4_ext_dirty() failing due to ENOMEM will
also trigger all sorts of "interesting" behavior. So that's why I'd rather
abort the journal than try to continue when we almost certainly now we
cannot."

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 987ea77e672d..0a30661953ef 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5735,10 +5735,10 @@ int
 ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			 struct ext4_iloc *iloc)
 {
-	int err;
+	int err = -EIO;;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
-		return -EIO;
+		goto out;
 
 	err = ext4_get_inode_loc(inode, iloc);
 	if (!err) {
@@ -5750,7 +5750,9 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			iloc->bh = NULL;
 		}
 	}
-	ext4_std_error(inode->i_sb, err);
+out:
+	if (err)
+		ext4_abort(inode->i_sb, -err, "Detect reserve inode write failed");
 	return err;
 }
 
-- 
2.31.1

