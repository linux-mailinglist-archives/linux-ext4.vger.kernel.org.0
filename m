Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC02217D89E
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 05:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgCIEgF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 00:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgCIEgF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 00:36:05 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EBD20674;
        Mon,  9 Mar 2020 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583728564;
        bh=95aZjjyluMSPfUmxYUpMbl+whha09PwjkKv5ZZumBk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQQ6DEN8+XJaawHtRNhj/z+JL18YZZxUvKHYoy1UUAkrkQf6O8L2J8vuWKAJKTXrk
         8GGZPnH3C4FzAOG9dnoBPEyudRM524LjnLTBEGt4MC1TvcYLnOvQ+PrWRkbYRZKJn2
         lYyzFzWrBSTO0fOGKXPrgg/6Bc231NkYRVrsuTuU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Date:   Sun,  8 Mar 2020 21:34:30 -0700
Message-Id: <20200309043430.143206-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309010410.GA371527@sol.localdomain>
References: <20200309010410.GA371527@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
during do_exit().  That can confuse things.  For example, if BSD process
accounting is enabled and the accounting file has FS_SYNC_FL set and is
located on an ext4 filesystem without a journal, then do_exit() ends up
calling ext4_write_inode().  That triggers the
WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
(appropriately) that inodes aren't written when allocating memory.

Fix this in xfsaild() by using the helper functions to save and restore
PF_MEMALLOC.

This can be reproduced as follows in the kvm-xfstests test appliance
modified to add the 'acct' Debian package, and with kvm-xfstests's
recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:

	mkfs.ext2 -F /dev/vdb
	mount /vdb -t ext4
	touch /vdb/file
	chattr +S /vdb/file
	accton /vdb/file
	mkfs.xfs -f /dev/vdc
	mount /vdc
	umount /vdc

It causes:
	WARNING: CPU: 0 PID: 332 at fs/ext4/inode.c:5097 ext4_write_inode+0x140/0x1a0
	CPU: 0 PID: 332 Comm: xfsaild/vdc Not tainted 5.6.0-rc5 #5
	[...]
	RIP: 0010:ext4_write_inode+0x140/0x1a0 fs/ext4/inode.c:5097
	[...]
	Call Trace:
	 write_inode fs/fs-writeback.c:1312 [inline]
	 __writeback_single_inode+0x465/0x5f0 fs/fs-writeback.c:1511
	 writeback_single_inode+0xad/0x120 fs/fs-writeback.c:1565
	 sync_inode fs/fs-writeback.c:2602 [inline]
	 sync_inode_metadata+0x3d/0x57 fs/fs-writeback.c:2622
	 ext4_fsync_nojournal fs/ext4/fsync.c:94 [inline]
	 ext4_sync_file+0x243/0x4b0 fs/ext4/fsync.c:172
	 generic_write_sync include/linux/fs.h:2867 [inline]
	 ext4_buffered_write_iter+0xe1/0x130 fs/ext4/file.c:277
	 call_write_iter include/linux/fs.h:1901 [inline]
	 new_sync_write+0x130/0x1d0 fs/read_write.c:483
	 __kernel_write+0x54/0xe0 fs/read_write.c:515
	 do_acct_process+0x122/0x170 kernel/acct.c:522
	 slow_acct_process kernel/acct.c:581 [inline]
	 acct_process+0x1d4/0x27c kernel/acct.c:607
	 do_exit+0x83d/0xbc0 kernel/exit.c:791
	 kthread+0xf1/0x140 kernel/kthread.c:257
	 ret_from_fork+0x27/0x50 arch/x86/entry/entry_64.S:352

This case was originally reported by syzbot at
https://lore.kernel.org/r/0000000000000e7156059f751d7b@google.com.

Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: include more details in the commit message.

 fs/xfs/xfs_trans_ail.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 00cc5b8734be8..3bc570c90ad97 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -529,8 +529,9 @@ xfsaild(
 {
 	struct xfs_ail	*ailp = data;
 	long		tout = 0;	/* milliseconds */
+	unsigned int	noreclaim_flag;
 
-	current->flags |= PF_MEMALLOC;
+	noreclaim_flag = memalloc_noreclaim_save();
 	set_freezable();
 
 	while (1) {
@@ -601,6 +602,7 @@ xfsaild(
 		tout = xfsaild_push(ailp);
 	}
 
+	memalloc_noreclaim_restore(noreclaim_flag);
 	return 0;
 }
 
-- 
2.25.1

