Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970C652DC5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Dec 2022 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLUIQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Dec 2022 03:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiLUIPt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Dec 2022 03:15:49 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77486336
        for <linux-ext4@vger.kernel.org>; Wed, 21 Dec 2022 00:15:46 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id n10-20020a6b590a000000b006e03471b3eeso6531864iob.11
        for <linux-ext4@vger.kernel.org>; Wed, 21 Dec 2022 00:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBa479myLuUkjat4HKXd5OZuqhcEUZx+Vab6rwmEGzw=;
        b=U5ZuPxwSHanQLnjDCRBngy6pifJ7SCo0P/wKEELd1a7xCA41gSygo2rAbiQh00aKbZ
         PMf7HUFLrGMuWHpXIYSqxxyBw/KcFdUkzD44AZ4CmKjKNU9F9I/Fq3ZyuA+6jA6qrSVL
         H+B8zBnpq92CHYgzqF1pM9L1FT9IU/1FNBtvG5W3t6+rdcbc8NzuY6SNCGruUKcrcpLA
         uT7q5UEl++wu6RVZTvHQxH0txRRWH/mz2qwEJDPTlK4ERdZkdwXB0TGxXT88nuJJSOBE
         V/CYT4efDH514aYpvHXZ7e2T2lDVWU0BUNQ6iedlqePG4AgOIXrQVk6IjNc2g0OC7CEL
         t8DQ==
X-Gm-Message-State: AFqh2kodzSPp7ULSYndKR1SJQLmX6/y1qFUWdSelvSVDH+mQ7kISVsZo
        gNHjq7/oJRXM9rSfWULiLYBqdFXtDaMULDyVfCAoPGGesqEL
X-Google-Smtp-Source: AMrXdXuhsVn7kQmJEIwx9pbMLJ4mKB7ghJUYh3VfjsVxQhGdOtxJ9BoMZxJcWCEgHzJYkPYzjR6MqbaIUOdQHylmpcQ6iu7iaV/f
MIME-Version: 1.0
X-Received: by 2002:a6b:6f08:0:b0:6e4:8c1:d2d7 with SMTP id
 k8-20020a6b6f08000000b006e408c1d2d7mr93816ioc.27.1671610545932; Wed, 21 Dec
 2022 00:15:45 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:15:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb11c705f052285f@google.com>
Subject: [syzbot] [ext4?] inconsistent lock state in ext4_xattr_set_handle
From:   syzbot <syzbot+9fd463c3e6d18ab8a362@syzkaller.appspotmail.com>
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1723a120480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=9fd463c3e6d18ab8a362
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fd463c3e6d18ab8a362@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.5/6055 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff0000c717ffa8 (&irq_desc_lock_class){?.-.}-{2:2}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff0000c717ffa8 (&irq_desc_lock_class){?.-.}-{2:2}, at: ext4_xattr_set_handle+0xd0/0x9a0 fs/ext4/xattr.c:2309
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
  handle_fasteoi_irq+0x38/0x324 kernel/irq/chip.c:693
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  handle_irq_desc kernel/irq/irqdesc.c:648 [inline]
  generic_handle_domain_irq+0x4c/0x6c kernel/irq/irqdesc.c:704
  __gic_handle_irq drivers/irqchip/irq-gic-v3.c:695 [inline]
  __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:746 [inline]
  gic_handle_irq+0x78/0x1b4 drivers/irqchip/irq-gic-v3.c:790
  call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:892
  do_interrupt_handler+0x7c/0xc0 arch/arm64/kernel/entry-common.c:274
  __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
  el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:580
  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:122 [inline]
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
  try_to_wake_up+0x2c4/0x410 kernel/sched/core.c:4194
  wake_up_process+0x18/0x24 kernel/sched/core.c:4326
  set_current_rng+0xa4/0xe4 drivers/char/hw_random/core.c:101
  hwrng_register+0x190/0x47c drivers/char/hw_random/core.c:567
  virtrng_scan+0x24/0x5c drivers/char/hw_random/virtio-rng.c:207
  virtio_dev_probe+0x4f8/0x590 drivers/virtio/virtio.c:314
  call_driver_probe+0x48/0x170
  really_probe+0x13c/0x4c0 drivers/base/dd.c:639
  __driver_probe_device+0x124/0x214 drivers/base/dd.c:778
  driver_probe_device+0x54/0x2f0 drivers/base/dd.c:808
  __driver_attach+0x250/0x374 drivers/base/dd.c:1190
  bus_for_each_dev+0xa8/0x110 drivers/base/bus.c:301
  driver_attach+0x30/0x40 drivers/base/dd.c:1207
  bus_add_driver+0x14c/0x2e4 drivers/base/bus.c:618
  driver_register+0x108/0x19c drivers/base/driver.c:246
  register_virtio_driver+0x54/0x6c drivers/virtio/virtio.c:357
  virtio_rng_driver_init+0x1c/0x28 drivers/char/hw_random/virtio-rng.c:262
  do_one_initcall+0x118/0x22c init/main.c:1303
  do_initcall_level+0xac/0xe4 init/main.c:1376
  do_initcalls+0x58/0xa8 init/main.c:1392
  do_basic_setup+0x20/0x2c init/main.c:1411
  kernel_init_freeable+0xb8/0x148 init/main.c:1631
  kernel_init+0x24/0x290 init/main.c:1519
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 2647
hardirqs last  enabled at (2647): [<ffff80000c096f4c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (2647): [<ffff80000c096f4c>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (2646): [<ffff80000c096d88>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (2646): [<ffff80000c096d88>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (2636): [<ffff80000801c82c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (2634): [<ffff80000801c7f8>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

2 locks held by syz-executor.5/6055:
 #0: ffff000114834460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff0000c71802e0 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff0000c71802e0 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: vfs_setxattr+0xd4/0x1f4 fs/xattr.c:308

stack backtrace:
CPU: 1 PID: 6055 Comm: syz-executor.5 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_usage_bug+0x39c/0x3cc kernel/locking/lockdep.c:3963
 mark_lock_irq+0x4a8/0x4b4
 mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4634
 mark_usage kernel/locking/lockdep.c:4543 [inline]
 __lock_acquire+0x5f8/0x3084 kernel/locking/lockdep.c:5009
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0xd0/0x9a0 fs/ext4/xattr.c:2309
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2496
 ext4_xattr_user_set+0x78/0x90 fs/ext4/xattr_user.c:41
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0xf4/0x1f4 fs/xattr.c:309
 do_setxattr fs/xattr.c:594 [inline]
 setxattr fs/xattr.c:617 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:636
 __do_sys_setxattr fs/xattr.c:652 [inline]
 __se_sys_setxattr fs/xattr.c:648 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:648
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
list_add corruption. prev->next should be next (ffff0000c717ff90), but was 0000000000000000. (prev=ffff80000ef2a260).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
