Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C03AA328
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFPSaP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 14:30:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45926 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhFPSaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 14:30:14 -0400
Received: by mail-io1-f69.google.com with SMTP id d2-20020a6b4f020000b02904bacfd7a27eso103309iob.12
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 11:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U2koXaMbJ/hC+FxImJK2eMDjd+s3HAXLCBhecZ9Nls4=;
        b=s74248kQEX1jcg6068FNszQ53PhYhl1+B9Zc7SEKoLeClERo546EO/2ZxqHG+3/NNQ
         T7x6wb46ty5/nLyagfhHoY85FpZR9D610mOZm9ejXdQpniKjZ1CPUCOd1YmsW2zeoLDU
         RhP24uvrY8LZEk6lHTRIOBIbWsjGMHOVXpiUIwYXy5OeIyTTgxdkJ0K5b6LvDj16v5h/
         K5JBr5o3/FcvK0mBe1u9Wo/jU0WrNs9ewH0RyhXA7DKRsZ0lK+YyVdXwS9Yg+pg9fRKR
         QBCIlooS/ia/0Oue+glTccBljb1wAbHbIOMCgXq5VkDNWvo0rJxt4qFKCv57++ZaQWPp
         wtIQ==
X-Gm-Message-State: AOAM532h+Hhwcse4uUhVIh6+pjqJif98Vlb73V3MZWTwzadyLAGGcc6P
        df2Jmq8y0GdTFyjE21asHX1TBjmV1iJO4a/Am0y6tDknSR1H
X-Google-Smtp-Source: ABdhPJyDgM0GFdGbMul6Yn7m82/g9W0s2hwQaIfuHjp5AeLZvi3hSzdDjLI5tCtrG4v1a7Wuj7K0Urittk7K2Bzlt0fL8OSykCq9
MIME-Version: 1.0
X-Received: by 2002:a92:d24c:: with SMTP id v12mr695097ilg.306.1623868087483;
 Wed, 16 Jun 2021 11:28:07 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:28:07 -0700
In-Reply-To: <20210616192213.1d75d8e2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008445ee05c4e6407c@google.com>
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
From:   syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in ext4_stop_mmpd

INFO: task syz-executor.3:10377 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:27568 pid:10377 ppid:  8772 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4322 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5073
 schedule+0xcf/0x270 kernel/sched/core.c:5152
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17a/0x720 kernel/kthread.c:621
 ext4_stop_mmpd+0x47/0xd0 fs/ext4/mmp.c:255
 ext4_fill_super+0x86b5/0xdef0 fs/ext4/super.c:5159
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x132a/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
RSP: 002b:00007f311de49fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000380 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007f311de4a000
RBP: 00007f311de4a040 R08: 00007f311de4a040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 00000000200000c0 R14: 00007f311de4a000 R15: 0000000020000200
INFO: task syz-executor.5:10410 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27568 pid:10410 ppid:  8771 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4322 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5073
 schedule+0xcf/0x270 kernel/sched/core.c:5152
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17a/0x720 kernel/kthread.c:621
 ext4_stop_mmpd+0x47/0xd0 fs/ext4/mmp.c:255
 ext4_fill_super+0x86b5/0xdef0 fs/ext4/super.c:5159
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x132a/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
RSP: 002b:00007fe6fceb8fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000380 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007fe6fceb9000
RBP: 00007fe6fceb9040 R08: 00007fe6fceb9040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 00000000200000c0 R14: 00007fe6fceb9000 R15: 0000000020000200
INFO: task syz-executor.2:10429 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27568 pid:10429 ppid:  8769 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4322 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5073
 schedule+0xcf/0x270 kernel/sched/core.c:5152
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17a/0x720 kernel/kthread.c:621
 ext4_stop_mmpd+0x47/0xd0 fs/ext4/mmp.c:255
 ext4_fill_super+0x86b5/0xdef0 fs/ext4/super.c:5159
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x132a/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
RSP: 002b:00007f92454eafa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000380 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007f92454eb000
RBP: 00007f92454eb040 R08: 00007f92454eb040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 00000000200000c0 R14: 00007f92454eb000 R15: 0000000020000200
INFO: task syz-executor.4:10440 blocked for more than 144 seconds.
      Not tainted 5.12.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27464 pid:10440 ppid:  8774 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4322 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5073
 schedule+0xcf/0x270 kernel/sched/core.c:5152
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17a/0x720 kernel/kthread.c:621
 ext4_stop_mmpd+0x47/0xd0 fs/ext4/mmp.c:255
 ext4_fill_super+0x86b5/0xdef0 fs/ext4/super.c:5159
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x132a/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
RSP: 002b:00007f2fce3c2fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000380 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007f2fce3c3000
RBP: 00007f2fce3c3040 R08: 00007f2fce3c3040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 00000000200000c0 R14: 00007f2fce3c3000 R15: 0000000020000200

Showing all locks held in the system:
2 locks held by kworker/u4:4/217:
 #0: ffff8880b9f35198 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x789/0xe50 kernel/sched/fair.c:10633
 #1: ffffffff8b774320 (rcu_read_lock){....}-{1:2}, at: cpu_of kernel/sched/sched.h:1086 [inline]
 #1: ffffffff8b774320 (rcu_read_lock){....}-{1:2}, at: __update_idle_core+0x39/0x430 kernel/sched/fair.c:6045
1 lock held by khungtaskd/1574:
 #0: ffffffff8b774320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6327
1 lock held by in:imklog/8073:
 #0: ffff8880111a74f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
1 lock held by syz-executor.3/10377:
 #0: ffff8880441a20e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor.5/10410:
 #0: ffff88802ad4e0e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor.2/10429:
 #0: ffff8880446860e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor.4/10440:
 #0: ffff8880446920e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xab0 fs/super.c:229

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1574 Comm: khungtaskd Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd48/0xfb0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 217 Comm: kworker/u4:4 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:5253 [inline]
RIP: 0010:lock_is_held_type+0xa7/0x140 kernel/locking/lockdep.c:5549
Code: 12 e9 88 00 00 00 83 c3 01 41 3b 9c 24 e8 09 00 00 7d 7b 48 63 c3 48 89 ee 48 8d 04 80 4d 8d 7c c5 00 4c 89 ff e8 09 fe ff ff <85> c0 74 d8 41 83 fe ff 41 bd 01 00 00 00 74 12 41 0f b6 47 22 45
RSP: 0018:ffffc900018afaf8 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8b774260 RDI: ffff888013df0a18
RBP: ffffffff8b774260 R08: 0000000000000000 R09: ffffffff8d45978f
R10: fffffbfff1a8b2f1 R11: 0000000000000000 R12: ffff888013df0000
R13: ffff888013df09f0 R14: 00000000ffffffff R15: ffff888013df0a18
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f205c60e020 CR3: 00000000158c4000 CR4: 0000000000350ee0
Call Trace:
 lock_is_held include/linux/lockdep.h:278 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x5d3/0x720 kernel/locking/lockdep.c:5521
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:174 [inline]
 _raw_spin_unlock_bh+0x12/0x30 kernel/locking/spinlock.c:207
 spin_unlock_bh include/linux/spinlock.h:399 [inline]
 batadv_nc_purge_paths+0x2a5/0x3a0 net/batman-adv/network-coding.c:467
 batadv_nc_worker+0x831/0xe50 net/batman-adv/network-coding.c:716
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


Tested on:

commit:         760537ca ext4: fix memory leak in ext4_fill_super
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux refs/changes/76/10176/6
console output: https://syzkaller.appspot.com/x/log.txt?x=14589b50300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9e6832b73135046
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
compiler:       

