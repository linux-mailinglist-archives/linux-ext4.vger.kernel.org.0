Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01BC20FC8
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEPUzc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 16:55:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:57142 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfEPUzc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 16:55:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 13:55:31 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2019 13:55:31 -0700
Date:   Thu, 16 May 2019 13:56:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>
Subject: Can ext4_break_layouts() ever fail?
Message-ID: <20190516205615.GA2926@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


While testing truncate failure options for FS DAX with GUP pins; I discovered
that if ext4_break_layouts() returns an error it can result in orphan'ed inodes
being left on the orphan list resulting in the following error when the FS is
unmounted.

        EXT4-fs (pmem0): Inode 12 (00000000d274c438): orphan list check failed!
        00000000d274c438: 0001f30a 00000004 00000000 00000000 ................
        000000001fa30de6: 0000000a 00008600 00000000 00000000 ................
        000000003948cb2f: 00000000 00000000 00000000 00000000 ................

        [snip]

        000000009acf82ac: 00000003 00000003 00000000 00000000 ................
        00000000d0cb8f52: 00000000 00000000 00000000 00000000 ................
        000000001edc0c35: bf718fee 00000000 ..q.....
        CPU: 5 PID: 1806 Comm: umount Not tainted 5.1.0-rc2+ #56
        Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/4
        Call Trace:
         dump_stack+0x5c/0x80
         ext4_destroy_inode+0x86/0x90
         dispose_list+0x48/0x60
         evict_inodes+0x160/0x1b0
         generic_shutdown_super+0x3f/0x100
         kill_block_super+0x21/0x50
         deactivate_locked_super+0x34/0x70
         cleanup_mnt+0x3b/0x70
         task_work_run+0x8a/0xb0
         exit_to_usermode_loop+0xb9/0xc0
         do_syscall_64+0x153/0x180
         entry_SYSCALL_64_after_hwframe+0x44/0xa9
        RIP: 0033:0x7fc5ed56f6bb
        Code: 27 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 008
        RSP: 002b:00007ffd524be128 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
        RAX: 0000000000000000 RBX: 000055867f9b2fb0 RCX: 00007fc5ed56f6bb
        RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055867f9b3190
        RBP: 0000000000000000 R08: 000055867f9b31b0 R09: 00007fc5ed5f1e80
        R10: 0000000000000000 R11: 0000000000000246 R12: 000055867f9b3190
        R13: 00007fc5ed7261a4 R14: 0000000000000000 R15: 00007ffd524be398
        EXT4-fs (pmem0): sb orphan head is 12
        sb_info orphan list:
          inode pmem0:12 at 00000000120c1727: mode 100644, nlink 1, next 0

Followed by this panic:

        ------------[ cut here ]------------
        kernel BUG at fs/ext4/super.c:1022!
        invalid opcode: 0000 [#1] SMP PTI
        CPU: 5 PID: 1806 Comm: umount Not tainted 5.1.0-rc2+ #56
        Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/4
        RIP: 0010:ext4_put_super+0x369/0x370
        Code: 24 d0 03 00 00 48 8b 40 68 83 60 60 fb 0f b7 83 a0 00 00 00 66 41 89 46 3a 41 f6 44 24 50 01 0f 85 71 fd ff ff e9 5f fd8
        RSP: 0018:ffffc900029cfe68 EFLAGS: 00010206
        RAX: ffff888000691dd0 RBX: ffff88800e78f800 RCX: 0000000000000000
        RDX: 0000000000000000 RSI: ffff88800fc96838 RDI: ffff88800fc96838
        RBP: ffff88800e78f9f8 R08: 0000000000000603 R09: 0000000000aaaaaa
        R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800e78e800
        R13: ffff88800e78f9f8 R14: ffffffff820b3a50 R15: ffff888016521f70
        FS:  00007fc5ed3b8080(0000) GS:ffff88800fc80000(0000) knlGS:0000000000000000
        CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        CR2: 00007f55f82181a0 CR3: 0000000015e9a000 CR4: 00000000000006e0
        Call Trace:
         generic_shutdown_super+0x6c/0x100
         kill_block_super+0x21/0x50
         deactivate_locked_super+0x34/0x70
         cleanup_mnt+0x3b/0x70
         task_work_run+0x8a/0xb0
         exit_to_usermode_loop+0xb9/0xc0
         do_syscall_64+0x153/0x180
         entry_SYSCALL_64_after_hwframe+0x44/0xa9
        RIP: 0033:0x7fc5ed56f6bb
        Code: 27 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 008
        RSP: 002b:00007ffd524be128 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
        RAX: 0000000000000000 RBX: 000055867f9b2fb0 RCX: 00007fc5ed56f6bb
        RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055867f9b3190
        RBP: 0000000000000000 R08: 000055867f9b31b0 R09: 00007fc5ed5f1e80
        R10: 0000000000000000 R11: 0000000000000246 R12: 000055867f9b3190
        R13: 00007fc5ed7261a4 R14: 0000000000000000 R15: 00007ffd524be398
        Modules linked in: xfs libcrc32c ib_isert iscsi_target_mod rpcrdma ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_c
        ---[ end trace c300122aad5fcd86 ]---
        RIP: 0010:ext4_put_super+0x369/0x370
        Code: 24 d0 03 00 00 48 8b 40 68 83 60 60 fb 0f b7 83 a0 00 00 00 66 41 89 46 3a 41 f6 44 24 50 01 0f 85 71 fd ff ff e9 5f fd8
        RSP: 0018:ffffc900029cfe68 EFLAGS: 00010206
        RAX: ffff888000691dd0 RBX: ffff88800e78f800 RCX: 0000000000000000
        RDX: 0000000000000000 RSI: ffff88800fc96838 RDI: ffff88800fc96838
        RBP: ffff88800e78f9f8 R08: 0000000000000603 R09: 0000000000aaaaaa
        R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800e78e800
        R13: ffff88800e78f9f8 R14: ffffffff820b3a50 R15: ffff888016521f70
        FS:  00007fc5ed3b8080(0000) GS:ffff88800fc80000(0000) knlGS:0000000000000000
        CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        CR2: 00007f55f82181a0 CR3: 0000000015e9a000 CR4: 00000000000006e0
        Kernel panic - not syncing: Fatal exception
        Kernel Offset: disabled
        ---[ end Kernel panic - not syncing: Fatal exception ]---
        ------------[ cut here ]------------

I kind of worked around this by removing the orphan inode from the orphan list
if ext4_break_layouts() fails.[1]  But I don't think this unwinds everything
properly.

Failing the truncate for GUP'ed pages could be done outside of
ext4_break_layouts() so it is not absolutely necessary that it return an error.

But this begs the question can ext4_break_layouts() fail?

It looks to me like it is possible for ext4_break_layouts() to fail if
prepare_to_wait_event() sees a pending signal.  Therefore I think this is a bug
in ext4 regardless of how I may implement a truncate failure.

Is that true?
Ira



[1] as shown here.

---
 fs/ext4/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 41eb643d75ff..134f5eebee4a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5648,6 +5648,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
                if (rc) {  
                        up_write(&EXT4_I(inode)->i_mmap_sem);
                        error = rc;
+                       if (orphan)
+                               ext4_orphan_del(NULL, inode);
                        goto err_out;
                }


