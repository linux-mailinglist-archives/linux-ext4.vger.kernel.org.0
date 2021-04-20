Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA0365D71
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhDTQf5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Apr 2021 12:35:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35700 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTQfv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Apr 2021 12:35:51 -0400
Received: by mail-io1-f69.google.com with SMTP id l2-20020a5e82020000b02903c2fa852f92so12869502iom.2
        for <linux-ext4@vger.kernel.org>; Tue, 20 Apr 2021 09:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MwT/es4Aiemxjx9cez/WLSegZn+lxPOHsKmbpZuVDbQ=;
        b=hq6samYB6pjvQTJsg/A1pZaXdxq7NmUSL7qM7eYxp2wBSgLKAZzDtEg2legzdswm4m
         yqx1+2dBftEoEH6csfrvI+JnW7lN1aiGHIUg4WlChWc7MM1zceKs8CtH6yKuKN9RzqFa
         RN4kMwzKtD3BSR4aF4jYRtZDaIsxCuJP7JTcfsFBqPYzpcXp2/h6iWrzW0VUO/dq9Hx8
         28i9zUZckr1bK26ShZTR/lbJAdpoixf2xaXOipzYtoBkpLsy/rote8qFBnuu1HHurmh0
         6RlMHWmwYGJpkctXLSQPQDh64Mv6tETpoqVHowIrsXdgH1BQ6+6QFwoQXxnDLvlQ7gqi
         lgjA==
X-Gm-Message-State: AOAM531+othjULR/xeCJosUDFO3YyLyIGqktOLYisXrXfrEaJJBD+j92
        tf2ynWau8VcafsbqV4f0HZizBc7GpbWiaXoEiBXAgtDt0oD2
X-Google-Smtp-Source: ABdhPJzyYZHJ4Zfiy37SXj/KQYA0d11lPLktOmGoYYdbml584MG/dH9+ptSpcGQCfe+6rxOER02zFzTSoaRi76Dlgyv+BRZBIedR
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:: with SMTP id j6mr23606325ils.234.1618936519371;
 Tue, 20 Apr 2021 09:35:19 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b33a05c06a088d@google.com>
Subject: [syzbot] KASAN: use-after-free Write in ext4_put_super
From:   syzbot <syzbot+2c925312fddc3493aff7@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2f7b98d1 Merge tag 'drm-fixes-2021-04-16' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14299cb6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=398c4d0fe6f66e68
dashboard link: https://syzkaller.appspot.com/bug?extid=2c925312fddc3493aff7

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c925312fddc3493aff7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
BUG: KASAN: use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: use-after-free in get_task_struct include/linux/sched/task.h:104 [inline]
BUG: KASAN: use-after-free in kthread_stop+0x90/0x720 kernel/kthread.c:616
Write of size 4 at addr ffff8880655f1c68 by task syz-executor.0/8403

CPU: 1 PID: 8403 Comm: syz-executor.0 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x720 kernel/kthread.c:616
 ext4_put_super+0x926/0x10c0 fs/ext4/super.c:1248
 generic_shutdown_super+0x144/0x370 fs/super.c:464
 kill_block_super+0x97/0xf0 fs/super.c:1394
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1136
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4678b7
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd26bfbf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000004678b7
RDX: 00007ffdd26bfccb RSI: 0000000000000002 RDI: 00007ffdd26bfcc0
RBP: 00007ffdd26bfcc0 R08: 00000000ffffffff R09: 00007ffdd26bfa90
R10: 00000000026228e3 R11: 0000000000000246 R12: 00000000004bebb2
R13: 00007ffdd26c0d90 R14: 0000000002622810 R15: 00007ffdd26c0dd0

Allocated by task 2:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 __kasan_slab_alloc+0x75/0x90 mm/kasan/common.c:460
 kasan_slab_alloc include/linux/kasan.h:223 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 kmem_cache_alloc_node+0x164/0x3b0 mm/slub.c:2943
 alloc_task_struct_node kernel/fork.c:170 [inline]
 dup_task_struct kernel/fork.c:860 [inline]
 copy_process+0x613/0x71a0 kernel/fork.c:1948
 kernel_clone+0xe7/0xab0 kernel/fork.c:2500
 kernel_thread+0xb5/0xf0 kernel/fork.c:2552
 create_kthread kernel/kthread.c:315 [inline]
 kthreadd+0x52a/0x790 kernel/kthread.c:658
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 12218:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x92/0x210 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kmem_cache_free+0x8a/0x740 mm/slub.c:3177
 __put_task_struct+0x267/0x3f0 kernel/fork.c:742
 put_task_struct include/linux/sched/task.h:113 [inline]
 delayed_put_task_struct+0x1f6/0x340 kernel/exit.c:173
 rcu_do_batch kernel/rcu/tree.c:2559 [inline]
 rcu_core+0x74a/0x12f0 kernel/rcu/tree.c:2794
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:345

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3114
 put_task_struct_rcu_user+0x7f/0xb0 kernel/exit.c:179
 context_switch kernel/sched/core.c:4325 [inline]
 __schedule+0x919/0x21b0 kernel/sched/core.c:5073
 schedule+0xcf/0x270 kernel/sched/core.c:5152
 freezable_schedule include/linux/freezer.h:172 [inline]
 futex_wait_queue_me+0x2a7/0x570 kernel/futex.c:2606
 futex_wait+0x1db/0x5f0 kernel/futex.c:2708
 do_futex+0x15d/0x1710 kernel/futex.c:3734
 __do_sys_futex+0x2a2/0x470 kernel/futex.c:3797
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3114
 put_task_struct_rcu_user+0x7f/0xb0 kernel/exit.c:179
 release_task+0xc99/0x1680 kernel/exit.c:225
 wait_task_zombie kernel/exit.c:1107 [inline]
 wait_consider_task+0x2fb5/0x3b40 kernel/exit.c:1334
 do_wait_thread kernel/exit.c:1397 [inline]
 do_wait+0x376/0xa00 kernel/exit.c:1468
 kernel_wait4+0x14c/0x260 kernel/exit.c:1630
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880655f1c40
 which belongs to the cache task_struct of size 6976
The buggy address is located 40 bytes inside of
 6976-byte region [ffff8880655f1c40, ffff8880655f3780)
The buggy address belongs to the page:
page:ffffea0001957c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x655f0
head:ffffea0001957c00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 0000000000000000 0000000200000001 ffff888140005000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880655f1b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880655f1b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880655f1c00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff8880655f1c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880655f1d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
