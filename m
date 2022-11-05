Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0120961DBEB
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Nov 2022 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKEQIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Nov 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKEQIt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Nov 2022 12:08:49 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D6DFC0
        for <linux-ext4@vger.kernel.org>; Sat,  5 Nov 2022 09:08:47 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id f17-20020a5d8591000000b006bcbe59b6cdso4814166ioj.14
        for <linux-ext4@vger.kernel.org>; Sat, 05 Nov 2022 09:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ1Od+xsdMr6k20I8cvfOK3HexjHYgYidaBXRxxGchc=;
        b=kXBzrQyxvvjCAu0NNzzWhGnySKf0660+2W3vFxcZFKZ8dMs4GDo26Wop/OxbpvT/DY
         noSzOsK5kwNnZX36+RtZEy9rYu6Z8k4E16jmcNL1dj35VHtvaL989NG3ObXYRB7R+xxr
         MmUr8MdPoctW07CZsfh/g9w4TjQAGTGr6z4lVKaRkUkfh9oanXelbrpkMySUthbZKhOu
         Fv1C210l3ihon17MC7E5wLM8ZGfcMIsmb8cT/Q1c3tvz+sFfLi5TbeA/asLke4myrK6W
         tJ/esvmU8Y0EMqU6KG3zAkOKWF5z1h2t43dYKjp2sW1EYPBhuPqVChFliI8gpC2X4u4/
         XrKA==
X-Gm-Message-State: ACrzQf2NMNAChJIToXRHT7OhSPY5qOIsFyuKv3xWLhHrj8QdBSnfEOJo
        CdYphLW6GjhORjFxUre0o7GnfNnpyp0YgcAgPF0nhVLlyNom
X-Google-Smtp-Source: AMsMyM4DhzlDCwFRIPWU7TkkARa055Hu3eF32I5+nCxnZWTv/qA3leVNuCSxwbFXhi9fJ1CXIF+hq0gR8XKckih3XZhmGne3Py9s
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168d:b0:6d6:f4e:ddcf with SMTP id
 s13-20020a056602168d00b006d60f4eddcfmr7612541iow.177.1667664526653; Sat, 05
 Nov 2022 09:08:46 -0700 (PDT)
Date:   Sat, 05 Nov 2022 09:08:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b73e8e05ecbb6729@google.com>
Subject: [syzbot] possible deadlock in ext4_move_extents
From:   syzbot <syzbot+1fec0eebb32ecfda77fd@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    64c3dd0b98f5 Merge tag 'xfs-6.1-fixes-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1643bf39880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=1fec0eebb32ecfda77fd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73b570348401/disk-64c3dd0b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e50e0711d5ae/vmlinux-64c3dd0b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/562350d6d20e/bzImage-64c3dd0b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fec0eebb32ecfda77fd@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc3-syzkaller-00280-g64c3dd0b98f5 #0 Not tainted
------------------------------------------------------
syz-executor.4/4429 is trying to acquire lock:
ffff8880756faaa8 (&ei->i_data_sem/1){+.+.}-{3:3}, at: ext4_move_extents+0x37b/0xe70 fs/ext4/move_extent.c:610

but task is already holding lock:
ffff88801e7d34b0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_double_down_write_data_sem+0x28/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->i_data_sem/2){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       ext4_map_blocks+0x398/0x1cc0 fs/ext4/inode.c:568
       ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:858
       ext4_bread+0x2a/0x170 fs/ext4/inode.c:914
       ext4_quota_write+0x225/0x570 fs/ext4/super.c:7082
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
       do_insert_tree+0x271/0x1b50 fs/quota/quota_tree.c:340
       do_insert_tree+0x744/0x1b50 fs/quota/quota_tree.c:375
       do_insert_tree+0x744/0x1b50 fs/quota/quota_tree.c:375
       do_insert_tree+0x744/0x1b50 fs/quota/quota_tree.c:375
       dq_insert_tree fs/quota/quota_tree.c:401 [inline]
       qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
       v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
       dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6738
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
       ext4_create+0xb0/0x560 fs/ext4/namei.c:2794
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __x64_sys_openat+0x243/0x290 fs/open.c:1337
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
       dquot_acquire+0x186/0x670 fs/quota/dquot.c:435
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6738
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x291/0xcf0 fs/quota/dquot.c:1492
       ext4_create+0xb0/0x560 fs/ext4/namei.c:2794
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&dquot->dq_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       dquot_commit+0x58/0x4e0 fs/quota/dquot.c:479
       ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6722
       mark_dquot_dirty fs/quota/dquot.c:346 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
       __dquot_alloc_space+0xa09/0x1030 fs/quota/dquot.c:1722
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_space include/linux/quotaops.h:313 [inline]
       swap_inode_boot_loader fs/ext4/ioctl.c:493 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
       ext4_ioctl+0x4f3a/0x5430 fs/ext4/ioctl.c:1607
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ei->i_data_sem/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write_nested+0xa2/0x280 kernel/locking/rwsem.c:1672
       ext4_move_extents+0x37b/0xe70 fs/ext4/move_extent.c:610
       __ext4_ioctl fs/ext4/ioctl.c:1351 [inline]
       ext4_ioctl+0x36ed/0x5430 fs/ext4/ioctl.c:1607
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem/1 --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/2);
                               lock(&s->s_dquot.dqio_sem);
                               lock(&ei->i_data_sem/2);
  lock(&ei->i_data_sem/1);

 *** DEADLOCK ***

4 locks held by syz-executor.4/4429:
 #0: ffff88807e866460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
 #1: ffff88801e7d3628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88801e7d3628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: lock_two_nondirectories+0xdd/0x130 fs/inode.c:1121
 #2: ffff8880756fac20 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: ext4_move_extents+0x360/0xe70 fs/ext4/move_extent.c:603
 #3: ffff88801e7d34b0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_double_down_write_data_sem+0x28/0x40

stack backtrace:
CPU: 1 PID: 4429 Comm: syz-executor.4 Not tainted 6.1.0-rc3-syzkaller-00280-g64c3dd0b98f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_write_nested+0xa2/0x280 kernel/locking/rwsem.c:1672
 ext4_move_extents+0x37b/0xe70 fs/ext4/move_extent.c:610
 __ext4_ioctl fs/ext4/ioctl.c:1351 [inline]
 ext4_ioctl+0x36ed/0x5430 fs/ext4/ioctl.c:1607
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47c4e8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47c5bf0168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f47c4fac120 RCX: 00007f47c4e8b5a9
RDX: 00000000200000c0 RSI: 00000000c028660f RDI: 0000000000000003
RBP: 00007f47c4ee67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff5e92a5bf R14: 00007f47c5bf0300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
