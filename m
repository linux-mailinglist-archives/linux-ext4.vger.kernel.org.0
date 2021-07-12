Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383413C4345
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 06:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGLErD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 00:47:03 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39861 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLErD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 00:47:03 -0400
Received: by mail-il1-f199.google.com with SMTP id g14-20020a926b0e0000b02901bb2deb9d71so11152499ilc.6
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jul 2021 21:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=escPaiYQMKQoo4fDKLaDrY4/ndjEorVwOX4C4DbfMdM=;
        b=ELIA0Z3x8CsyjzM6x2Wmk6Fl4gNDuNhyQEROMFty6zrMmy0tCzlnddB0FPpxSxPYa4
         p7shoU2DRoNefJSQS6wPjTPbtX5J3LzIWzsfkIUhEVCRCcDPOPfXdL8zIObA2BpLIV1L
         aopromMFieGoNsV3NwECcYhwT74UFYRTlTpG9dFizuk8WljQIwlcy2XButT84P5aSdov
         0DsW3FnURfzTPg1AqBvlEZc88FRchCUQUk3CVvb8cSLCxxnogZzrpSDrgtv8vvGVXr0D
         BouVnn0j8gFm8fPPUZoGZmMqqpPEscxd20GrHsmvVnq1wdFCJywrFhY08dGBgyaishJO
         DDyQ==
X-Gm-Message-State: AOAM532oYZ2VEvFuXcMyoSc8h4M5T0awg4cREmMZoHNZoOFBXQvkUiig
        j/vE547udqO6NxpOJ1vD6gWOTl1X1xL9VOdNcp1I5MJsa21y
X-Google-Smtp-Source: ABdhPJz96PjZLikPBG31OEuF0Quze9PPeFlrMd5iEgQnpQf6GCLbDyb8bCBNqaRQKLqHkOQEr4YE6RPVu3nMLeZZpSgFnWf138DF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3291:: with SMTP id f17mr11170365jav.143.1626065055617;
 Sun, 11 Jul 2021 21:44:15 -0700 (PDT)
Date:   Sun, 11 Jul 2021 21:44:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005966505c6e5c637@google.com>
Subject: [syzbot] KASAN: use-after-free Write in ext4_stop_mmpd
From:   syzbot <syzbot+2ab2ee3b98cc853e6ee2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156a39c2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=2ab2ee3b98cc853e6ee2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ab2ee3b98cc853e6ee2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
BUG: KASAN: use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: use-after-free in get_task_struct include/linux/sched/task.h:104 [inline]
BUG: KASAN: use-after-free in kthread_stop+0x90/0x720 kernel/kthread.c:643
Write of size 4 at addr ffff88801bf51c68 by task syz-executor.4/8462

CPU: 1 PID: 8462 Comm: syz-executor.4 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x720 kernel/kthread.c:643
 ext4_stop_mmpd+0x47/0xd0 fs/ext4/mmp.c:254
 ext4_put_super+0x918/0x10b0 fs/ext4/super.c:1251
 generic_shutdown_super+0x14c/0x370 fs/super.c:465
 kill_block_super+0x97/0xf0 fs/super.c:1395
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1136
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467a37
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff6ba5618 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000467a37
RDX: 00007ffff6ba56ec RSI: 0000000000000002 RDI: 00007ffff6ba56e0
RBP: 00007ffff6ba56e0 R08: 00000000ffffffff R09: 00007ffff6ba54b0
R10: 0000000002bd48e3 R11: 0000000000000246 R12: 00000000004bee70
R13: 00007ffff6ba67b0 R14: 0000000002bd4810 R15: 00007ffff6ba67f0

Allocated by task 2:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2970 [inline]
 kmem_cache_alloc_node+0x266/0x3e0 mm/slub.c:3006
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct kernel/fork.c:871 [inline]
 copy_process+0x5c8/0x74c0 kernel/fork.c:1952
 kernel_clone+0xe7/0xab0 kernel/fork.c:2509
 kernel_thread+0xb5/0xf0 kernel/fork.c:2561
 create_kthread kernel/kthread.c:342 [inline]
 kthreadd+0x4ea/0x750 kernel/kthread.c:685
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 19:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1639 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1664
 slab_free mm/slub.c:3224 [inline]
 kmem_cache_free+0x8e/0x5a0 mm/slub.c:3240
 __put_task_struct+0x26f/0x400 kernel/fork.c:748
 put_task_struct include/linux/sched/task.h:113 [inline]
 delayed_put_task_struct+0x1f6/0x340 kernel/exit.c:173
 rcu_do_batch kernel/rcu/tree.c:2558 [inline]
 rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2793
 __do_softirq+0x29b/0x9bd kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3038 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3113
 put_task_struct_rcu_user+0x7f/0xb0 kernel/exit.c:179
 context_switch kernel/sched/core.c:4686 [inline]
 __schedule+0x93c/0x2710 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x24e/0x690 kernel/time/hrtimer.c:1896
 hrtimer_nanosleep+0x1f9/0x4a0 kernel/time/hrtimer.c:1949
 common_nsleep+0xa2/0xc0 kernel/time/posix-timers.c:1227
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3038 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3113
 put_task_struct_rcu_user+0x7f/0xb0 kernel/exit.c:179
 context_switch kernel/sched/core.c:4686 [inline]
 __schedule+0x93c/0x2710 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x14a/0x290 kernel/entry/common.c:209
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:315
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638

The buggy address belongs to the object at ffff88801bf51c40
 which belongs to the cache task_struct of size 6976
The buggy address is located 40 bytes inside of
 6976-byte region [ffff88801bf51c40, ffff88801bf53780)
The buggy address belongs to the page:
page:ffffea00006fd400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bf50
head:ffffea00006fd400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 0000000100000001 ffff888140006280
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, ts 6232954027, free_ts 0
 prep_new_page mm/page_alloc.c:2445 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4178
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1702 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1842
 new_slab mm/slub.c:1905 [inline]
 new_slab_objects mm/slub.c:2651 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2814
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2854
 slab_alloc_node mm/slub.c:2936 [inline]
 kmem_cache_alloc_node+0x12c/0x3e0 mm/slub.c:3006
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct kernel/fork.c:871 [inline]
 copy_process+0x5c8/0x74c0 kernel/fork.c:1952
 kernel_clone+0xe7/0xab0 kernel/fork.c:2509
 kernel_thread+0xb5/0xf0 kernel/fork.c:2561
 create_kthread kernel/kthread.c:342 [inline]
 kthreadd+0x4ea/0x750 kernel/kthread.c:685
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801bf51b00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801bf51b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801bf51c00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff88801bf51c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801bf51d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
