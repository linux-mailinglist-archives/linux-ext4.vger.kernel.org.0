Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E053A96B2
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhFPJ6c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 05:58:32 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39620 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhFPJ61 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 05:58:27 -0400
Received: by mail-il1-f198.google.com with SMTP id g14-20020a926b0e0000b02901bb2deb9d71so1316312ilc.6
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 02:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gE9dw5WMmJMATlrvCfZBYGK+85dpprCimqGF9O/Ic1Y=;
        b=H6DDNTc0JnSR9jXxdhcxe9TwDypkiFrKuf4jo9nFiA/gpDyxACdAsRQVMVYpLFw7N/
         +fh17utoXVrrbAfQJ61wAIzVcDYGLrx7qPbfcMYek4+QrXWibbcYzvcKyVx+xxgFm/0v
         G0WZG4XbmAcfaTp/hZVCSy1JX1hPkfgP4H7G/5zvdJJw/vPA91cvIZOoxUJPly+nhhXz
         BsTouxGrQflDarHi/2HEffziBewT6/x+g63qDjp9koxUaR4FhPwUaF1KwvY1MFlX6ggY
         fCcER50TD+ssbLRRNouEBMIkbQjBjcEyJonBCOnbi6G8bitVlYl6Qo7uZ2KbUnnsNUeF
         kSKw==
X-Gm-Message-State: AOAM531EWJ0WwfZJYsPH2BvT4jD94XXoDPRD+Ea0EqiuXwV05ZA/3WNZ
        ghUXuhb4TG3KzIkTVs3z1vJQWkyBjYepIQ1a+OSafLajjbDb
X-Google-Smtp-Source: ABdhPJxv4zDj+OMA9833jIn7GCRnBTP8Gdukw/zexEndylnIIF6g27A59ABDPT9RHyduAUfzuy5+ULO2LGNDCQrxZw3gGqThMfvz
MIME-Version: 1.0
X-Received: by 2002:a5d:8190:: with SMTP id u16mr3096128ion.158.1623837381524;
 Wed, 16 Jun 2021 02:56:21 -0700 (PDT)
Date:   Wed, 16 Jun 2021 02:56:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c80e405c4df1a2d@google.com>
Subject: [syzbot] INFO: task hung in ext4_fill_super
From:   syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>
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

HEAD commit:    f21b807c Merge tag 'drm-fixes-2021-06-11' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165fca57d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d19ce0300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108d7988300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1646b8d0300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1546b8d0300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1146b8d0300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com

INFO: task syz-executor768:8567 blocked for more than 143 seconds.
      Not tainted 5.13.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor768 state:D stack:27544 pid: 8567 ppid:  8423 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0x916/0x23e0 kernel/sched/core.c:5147
 schedule+0xcf/0x270 kernel/sched/core.c:5226
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17a/0x720 kernel/kthread.c:642
 ext4_fill_super+0x87ac/0xdfa0 fs/ext4/super.c:5190
 mount_bdev+0x34d/0x410 fs/super.c:1368
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x132a/0x1fa0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445b2a
RSP: 002b:00007ffc5efbf598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc5efbf5f0 RCX: 0000000000445b2a
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007ffc5efbf5b0
RBP: 00007ffc5efbf5b0 R08: 00007ffc5efbf5f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200003f8
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000005

Showing all locks held in the system:
1 lock held by khungtaskd/1636:
 #0: ffffffff8bf79620 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6333
2 locks held by in:imklog/8117:
 #0: ffff888015be9770 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
 #1: ffff888021bc3958 (&mm->mmap_lock#2){++++}-{3:3}, at: file_ctx security/apparmor/include/file.h:33 [inline]
 #1: ffff888021bc3958 (&mm->mmap_lock#2){++++}-{3:3}, at: aa_file_perm+0x119/0x1170 security/apparmor/file.c:609
1 lock held by syz-executor768/8567:
 #0: ffff88802ac340e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xab0 fs/super.c:229

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1636 Comm: khungtaskd Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd48/0xfb0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:108 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:513


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
