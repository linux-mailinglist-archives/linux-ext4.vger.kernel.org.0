Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96FB17E7A9
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCIS6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 14:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgCIS6u (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 14:58:50 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C906820866;
        Mon,  9 Mar 2020 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780330;
        bh=B1UyNcxLW8PyJe3Q75G0rqEkEz05Wmj5+QamNjOuhpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7PsOBZw10bgq729PHYbEjWzwCGV7EzrsIszS8j0MmdQNps/ZBwz1vdlaqCCZT5TV
         kYdLL1f3WRO8gXYwXh2WInGSNQZKlkEw/OwvgL8V95Zex7gvHoHc+q1daW5TZ5fXwS
         nQgFwKiYLC9xg3s7LNqzl4cHDR7qK93ab5NWmqnQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Date:   Mon,  9 Mar 2020 11:57:14 -0700
Message-Id: <20200309185714.42850-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309181332.GJ1752567@magnolia>
References: <20200309181332.GJ1752567@magnolia>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
during do_exit().  That can confuse things.  In particular, if BSD
process accounting is enabled, then do_exit() writes data to an
accounting file.  If that file has FS_SYNC_FL set, then this write
occurs synchronously and can misbehave if PF_MEMALLOC is set.

For example, if the accounting file is located on an XFS filesystem,
then a WARN_ON_ONCE() in iomap_do_writepage() is triggered and the data
doesn't get written when it should.  Or if the accounting file is
located on an ext4 filesystem without a journal, then a WARN_ON_ONCE()
in ext4_write_inode() is triggered and the inode doesn't get written.

Fix this in xfsaild() by using the helper functions to save and restore
PF_MEMALLOC.

This can be reproduced as follows in the kvm-xfstests test appliance
modified to add the 'acct' Debian package, and with kvm-xfstests's
recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:

        mkfs.xfs -f /dev/vdb
        mount /vdb
        touch /vdb/file
        chattr +S /vdb/file
        accton /vdb/file
        mkfs.xfs -f /dev/vdc
        mount /vdc
        umount /vdc

It causes:
	WARNING: CPU: 1 PID: 336 at fs/iomap/buffered-io.c:1534
	CPU: 1 PID: 336 Comm: xfsaild/vdc Not tainted 5.6.0-rc5 #3
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
	RIP: 0010:iomap_do_writepage+0x16b/0x1f0 fs/iomap/buffered-io.c:1534
	[...]
	Call Trace:
	 write_cache_pages+0x189/0x4d0 mm/page-writeback.c:2238
	 iomap_writepages+0x1c/0x33 fs/iomap/buffered-io.c:1642
	 xfs_vm_writepages+0x65/0x90 fs/xfs/xfs_aops.c:578
	 do_writepages+0x41/0xe0 mm/page-writeback.c:2344
	 __filemap_fdatawrite_range+0xd2/0x120 mm/filemap.c:421
	 file_write_and_wait_range+0x71/0xc0 mm/filemap.c:760
	 xfs_file_fsync+0x7a/0x2b0 fs/xfs/xfs_file.c:114
	 generic_write_sync include/linux/fs.h:2867 [inline]
	 xfs_file_buffered_aio_write+0x379/0x3b0 fs/xfs/xfs_file.c:691
	 call_write_iter include/linux/fs.h:1901 [inline]
	 new_sync_write+0x130/0x1d0 fs/read_write.c:483
	 __kernel_write+0x54/0xe0 fs/read_write.c:515
	 do_acct_process+0x122/0x170 kernel/acct.c:522
	 slow_acct_process kernel/acct.c:581 [inline]
	 acct_process+0x1d4/0x27c kernel/acct.c:607
	 do_exit+0x83d/0xbc0 kernel/exit.c:791
	 kthread+0xf1/0x140 kernel/kthread.c:257
	 ret_from_fork+0x27/0x50 arch/x86/entry/entry_64.S:352

This bug was originally reported by syzbot at
https://lore.kernel.org/r/0000000000000e7156059f751d7b@google.com.

Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v3: updated commit message again, this time to take into account the bug
    also being reproducible when the accounting file is located on XFS.

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

