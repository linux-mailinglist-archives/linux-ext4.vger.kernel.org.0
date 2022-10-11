Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA055FB44A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Oct 2022 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJKOJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Oct 2022 10:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJKOJx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Oct 2022 10:09:53 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5212AFB
        for <linux-ext4@vger.kernel.org>; Tue, 11 Oct 2022 07:09:50 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y4-20020a5e9204000000b006bbffbc3d27so4296901iop.5
        for <linux-ext4@vger.kernel.org>; Tue, 11 Oct 2022 07:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8X+ixEZiN3UNQ79UY9WeGzEkjmbCwuYSfjyFL0qZ3zw=;
        b=UctXsR74bl61hNmSBiM6g6RTD8qeipo2BRZniDtIx2KdTUKMxWPlddQv3DWZ0/3LaY
         R3bKDRyqQ+qN7C6txmJvPQzJtYmiR2qFr/Gyi6Ip/uXJjCTT1dM8EHQyFLRSwUdHnJzp
         MWQgRw9Hsk7RrSTFnW+a78x5gM/QAfaSG97Fmx9kANgK2EuRmWpLcO7V3vuRDB9Bt37e
         4BBupNlsb7L2WVMu3+fIa97uWSxgbCukno7kJXDv1mpTVGdDrl+7leN7c1Ln/mi+YqyK
         1XnnZ1JX5YcbkkhHA/jODjUG3jNY1AlCTA9BKjhokak9+BU7j0cYoPoopXZroe1YBUr2
         be6Q==
X-Gm-Message-State: ACrzQf3tUHHnwBsT9mfYfaBhx9kLtgsscTAfU/4n81/GpTz0C1+1ImYF
        CHScugsBnoNN3nf71GvzpBsdKUGaIvzkLsd12fVbJuthdhjO
X-Google-Smtp-Source: AMsMyM70023WJs3OnUAmW71n9INcevf8/PNPpjUSbXTLREJxSJ2kp4dXU0d05ylDoJVfjWnqiJWSpofXcj3Ssy+jwkzIAfFSQJ4W
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d94:b0:6bb:b6cd:bea7 with SMTP id
 k20-20020a0566022d9400b006bbb6cdbea7mr9265709iow.62.1665497389605; Tue, 11
 Oct 2022 07:09:49 -0700 (PDT)
Date:   Tue, 11 Oct 2022 07:09:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048284505eac2d444@google.com>
Subject: [syzbot] INFO: trying to register non-static key in ext4_xattr_set_handle
From:   syzbot <syzbot+c8fd469c1d2a6c1ea074@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0a28a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c8fd469c1d2a6c1ea074
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8fd469c1d2a6c1ea074@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 18006 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:979
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1292
 __lock_acquire+0xa8/0x30a4 kernel/locking/lockdep.c:4932
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0xd0/0x994 fs/ext4/xattr.c:2309
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_setxattr fs/xattr.c:658 [inline]
 __se_sys_setxattr fs/xattr.c:654 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:654
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
EXT4-fs error (device loop0): ext4_do_update_inode:5149: inode #2: comm syz-executor.0: corrupted inode contents
EXT4-fs error (device loop0): ext4_dirty_inode:5966: inode #2: comm syz-executor.0: mark_inode_dirty error
EXT4-fs error (device loop0): ext4_do_update_inode:5149: inode #2: comm syz-executor.0: corrupted inode contents
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0xffff0000ebdd3500, curr 0xffff0000ebdd3500, list not empty
WARNING: CPU: 0 PID: 18006 at kernel/locking/rwsem.c:1347 __up_write+0xf8/0x184 kernel/locking/rwsem.c:1347
Modules linked in:
CPU: 0 PID: 18006 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_write+0xf8/0x184 kernel/locking/rwsem.c:1347
lr : __up_write+0xf8/0x184 kernel/locking/rwsem.c:1347
sp : ffff800013d43870
x29: ffff800013d43870 x28: ffff0000cab2fee0 x27: ffff0000cab2ff38
x26: 0000000000000001 x25: 00000000ffffff8b x24: ffff800013d43928
x23: 0000000072010010 x22: ffff0000cab30190 x21: ffff80000d30c000
x20: 0000000000000000 x19: ffff0000cab2ff38 x18: 0000000000000212
x17: ffff80000bffd6bc x16: 000000000000b67e x15: 0000000000000d6b
x14: 000000000290d4aa x13: 00000000000003e1 x12: 0000000000040000
x11: 0000000000018154 x10: ffff80001f1f2000 x9 : da54abfe71995e00
x8 : da54abfe71995e00 x7 : 0000000000000000 x6 : ffff800008161d1c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000000 x0 : 0000000000000086
Call trace:
 __up_write+0xf8/0x184 kernel/locking/rwsem.c:1347
 up_write+0x38/0x48 kernel/locking/rwsem.c:1605
 ext4_write_unlock_xattr fs/ext4/xattr.h:173 [inline]
 ext4_xattr_set_handle+0x400/0x994 fs/ext4/xattr.c:2431
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_setxattr fs/xattr.c:658 [inline]
 __se_sys_setxattr fs/xattr.c:654 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:654
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 1127
hardirqs last  enabled at (1127): [<ffff80000bfb8138>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (1127): [<ffff80000bfb8138>] exit_to_kernel_mode+0xe8/0x118 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (1126): [<ffff80000bfc1228>] preempt_schedule_irq+0x80/0x110 kernel/sched/core.c:6807
softirqs last  enabled at (1098): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1096): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
