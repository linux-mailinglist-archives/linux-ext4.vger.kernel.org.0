Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E08483EE6
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 10:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiADJMB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 04:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiADJMA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 04:12:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5EC061761;
        Tue,  4 Jan 2022 01:12:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o185so79113115ybo.12;
        Tue, 04 Jan 2022 01:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6nqj+x4yUS5MOaJwLLNecM1pz7RDfAhvTI8ZjtjZa3s=;
        b=eblUYaLJBct/VHWF2hgU15vsNseK7rrJ+N7JWnC6Y/lmi2MHT6GhPHSf9ZX+Z3xhnV
         byJPyVFeAWZ14mvvFjghyJRgineQaL62I5VrwbXxAg5ubQxfEYj+890W9B6UQYQPC7nj
         8fnpiuKagshU6EVXBkyAGuCthjEPNeJbCSUiosMCNdnkFhNs6qFOmGxxbfrgVeuEAdZ9
         K3hRHZJIxQuvnDJrMX+z8o4jBmGsUIgYtfBPnM4a7iI07yC1RJWV/IGVTPfcvvpprq9W
         ccRlJOSdqNyETz9JG1O5thY4g6bdvONyxdl6XpOlHQIMTgrmtZvelyhGWQfCzW5fR+rX
         OV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6nqj+x4yUS5MOaJwLLNecM1pz7RDfAhvTI8ZjtjZa3s=;
        b=lQtGXaOltIX9X+8jsi5r7cAPKLwybIyuBS4ld0Kdlqfr3wSGE/3fXKGslW9DF0Emyc
         AB7atm0Wu7AMRMftYVS4X4Nnhf+xbsEKgjGZCyzsSubzBjrhyDs47tZE+kLDlAWl/RNh
         xXrcNWL6PVymJTbz/IjUXEjOwGtpblTq4FcaYDJ7TSPO0+t/rFwFwjQjUc54CdYZld/j
         U1qGzDN8TkAK+awezNBqMqKDMBbp/YYJPZQUDKRAWEbk7HIvpjtqaSjLUZgRxqTjMbrd
         c3BgfOA5q/3xmWa/Oz6PdTujJjJ75YyFu3EhqtQn3UnTZNVa36s/pW39T272pgY8F0T0
         Msig==
X-Gm-Message-State: AOAM530v+gdkm2AsyiNXS1YqwirJf4VTEtzA1CoI1tbM9WNVow6iDevJ
        JSItoOwDquzUq3Q6dgzu5fI+6httr4/Zlsyinvc=
X-Google-Smtp-Source: ABdhPJx8hfh8Csx2F19hJ/hHHbVal+yiGE/c4Z3j/fzvzlqC4NF7YaPAynsrQx+dSdzQQUrWzxsjy6EhMmADtg0GvJo=
X-Received: by 2002:a25:3006:: with SMTP id w6mr65331796ybw.691.1641287519432;
 Tue, 04 Jan 2022 01:11:59 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 17:11:48 +0800
Message-ID: <CAFkrUshN-T1RciBE_dp_hF9DjJYQ7-YezaVYmO-GjrD2qP8YaQ@mail.gmail.com>
Subject: INFO: task hung in ext4_journal_finish_inode_data_buffers
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/5kWHmvcH97/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
C reproducer: https://paste.ubuntu.com/p/pjQdPQHrM4/plain/
Syzlang reproducer: https://paste.ubuntu.com/p/DZRcCcQRPs/

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task jbd2/sda-8:3027 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda-8      state:D stack:26288 pid: 3027 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 io_schedule+0xb3/0x120 kernel/sched/core.c:8371 kernel/sched/core.c:8371
 folio_wait_bit_common mm/filemap.c:1371 [inline]
 folio_wait_bit_common mm/filemap.c:1371 [inline] mm/filemap.c:1431
 folio_wait_bit+0x1e3/0x5d0 mm/filemap.c:1431 mm/filemap.c:1431
 folio_wait_writeback+0x37/0x300 mm/page-writeback.c:2925
mm/page-writeback.c:2925
 __filemap_fdatawait_range+0x13b/0x420 mm/filemap.c:543 mm/filemap.c:543
 filemap_fdatawait_range_keep_errors+0x21/0x30 mm/filemap.c:592 mm/filemap.c:592
 ext4_journal_finish_inode_data_buffers+0x5f/0x80 fs/ext4/super.c:541
fs/ext4/super.c:541
 journal_finish_inode_data_buffers fs/jbd2/commit.c:299 [inline]
 journal_finish_inode_data_buffers fs/jbd2/commit.c:299 [inline]
fs/jbd2/commit.c:786
 jbd2_journal_commit_transaction+0x2ba4/0x6c90 fs/jbd2/commit.c:786
fs/jbd2/commit.c:786
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213 fs/jbd2/journal.c:213
 kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
kernel/locking/lockdep.c:6458
4 locks held by kworker/1:3/3063:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
kernel/workqueue.c:2269
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
kernel/workqueue.c:2269
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline] kernel/workqueue.c:2269
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline] kernel/workqueue.c:2269
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
kernel/workqueue.c:2269
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
kernel/workqueue.c:2269
 #1: ffffc900012efdc8
((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
kernel/workqueue.c:2273
 #2: ffff88801a83c2a0 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at:
ata_scsi_dev_rescan+0x38/0x230 drivers/ata/libata-scsi.c:4646
drivers/ata/libata-scsi.c:4646
 #3: ffff8881075a23e0 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #3: ffff8881075a23e0 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline] drivers/scsi/scsi_scan.c:1555
 #3: ffff8881075a23e0 (&dev->mutex){....}-{3:3}, at:
scsi_rescan_device+0x28/0x210 drivers/scsi/scsi_scan.c:1555
drivers/scsi/scsi_scan.c:1555
1 lock held by in:imklog/6744:
4 locks held by kworker/u9:2/6762:
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
kernel/workqueue.c:2269
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
kernel/workqueue.c:2269
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline] kernel/workqueue.c:2269
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline] kernel/workqueue.c:2269
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
kernel/workqueue.c:2269
 #0: ffff888100b90138 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
kernel/workqueue.c:2269
 #1: ffffc90001c1fdc8
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
kernel/workqueue.c:2273
 #2: ffff88810b1740e0 (&type->s_umount_key#36){++++}-{3:3}, at:
trylock_super+0x1d/0x100 fs/super.c:418 fs/super.c:418
 #3: ffff88810b176bd8 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at:
do_writepages+0x19b/0x610 mm/page-writeback.c:2364
mm/page-writeback.c:2364

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
kernel/hung_task.c:295
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
kernel/hung_task.c:295
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 3
CPU: 3 PID: 3050 Comm: systemd-journal Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
RIP: 0010:test_bit
include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:199 [inline]
RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
kernel/locking/lockdep.c:4583
RIP: 0010:test_bit
include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
kernel/locking/lockdep.c:4583
RIP: 0010:hlock_class kernel/locking/lockdep.c:199 [inline]
kernel/locking/lockdep.c:4583
RIP: 0010:mark_lock.part.0+0xfc/0x27c0 kernel/locking/lockdep.c:4583
kernel/locking/lockdep.c:4583
Code: b7 54 24 20 66 81 e2 ff 1f 0f b7 d2 be 08 00 00 00 48 89 d0 48
89 54 24 38 48 c1 f8 06 48 8d 3c c5 40 09 f7 8f e8 34 40 62 00 <48> 8b
54 24 38 48 0f a3 15 77 1e 9b 0e 0f 83 c8 00 00 00 48 8d 04
RSP: 0018:ffffc9000126f920 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 1ffff9200024df2c RCX: ffffffff815beabc
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8ff70950
RBP: ffffc9000126fa88 R08: 0000000000000001 R09: fffffbfff1fee12b
R10: ffffffff8ff70957 R11: fffffbfff1fee12a R12: ffff888106d226e0
R13: 0000000000000040 R14: 0000000000000006 R15: ffff888106d22700
FS:  00007fcf3a5dd8c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf37926000 CR3: 0000000017de1000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 mark_lock kernel/locking/lockdep.c:4569 [inline]
 mark_usage kernel/locking/lockdep.c:4518 [inline]
 mark_lock kernel/locking/lockdep.c:4569 [inline] kernel/locking/lockdep.c:4981
 mark_usage kernel/locking/lockdep.c:4518 [inline] kernel/locking/lockdep.c:4981
 __lock_acquire+0x8c9/0x57e0 kernel/locking/lockdep.c:4981
kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
kernel/locking/lockdep.c:5602
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
kernel/locking/lockdep.c:5602
 __fs_reclaim_acquire mm/page_alloc.c:4535 [inline]
 __fs_reclaim_acquire mm/page_alloc.c:4535 [inline] mm/page_alloc.c:4549
 fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4549 mm/page_alloc.c:4549
 might_alloc include/linux/sched/mm.h:227 [inline]
 slab_pre_alloc_hook mm/slab.h:492 [inline]
 slab_alloc_node mm/slub.c:3148 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 might_alloc include/linux/sched/mm.h:227 [inline] mm/slub.c:3247
 slab_pre_alloc_hook mm/slab.h:492 [inline] mm/slub.c:3247
 slab_alloc_node mm/slub.c:3148 [inline] mm/slub.c:3247
 slab_alloc mm/slub.c:3242 [inline] mm/slub.c:3247
 kmem_cache_alloc+0x3e/0x380 mm/slub.c:3247 mm/slub.c:3247
 getname_flags fs/namei.c:138 [inline]
 getname_flags fs/namei.c:138 [inline] fs/namei.c:128
 getname_flags+0xd2/0x5b0 fs/namei.c:128 fs/namei.c:128
 do_sys_openat2+0x448/0x9a0 fs/open.c:1206 fs/open.c:1206
 do_sys_open+0xc3/0x140 fs/open.c:1228 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcf39b6d840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007fff8229bca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fff8229bfb0 RCX: 00007fcf39b6d840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 000055bc132b8300
RBP: 000000000000000d R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000055bc132b4040 R14: 00007fff8229bf70 R15: 000055bc132bfe10
 </TASK>
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
arch/x86/kernel/process.c:733
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
arch/x86/kernel/process.c:733
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733 arch/x86/kernel/process.c:733
NMI backtrace for cpu 2
CPU: 2 PID: 6745 Comm: rs:main Q:Reg Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kasan_set_free_info+0x9/0x30 mm/kasan/generic.c:367
mm/kasan/generic.c:367
Code: 00 be 01 00 00 00 e9 d6 fc ff ff 66 0f 1f 44 00 00 31 f6 e9 c9
fc ff ff 66 0f 1f 84 00 00 00 00 00 53 48 89 f3 e8 d7 e3 ff ff <48> 85
c0 74 20 48 8d 78 08 be 00 08 00 00 48 c1 eb 03 e8 70 e1 ff
RSP: 0018:ffffc900013cf7d8 EFLAGS: 00000293
RAX: ffff888014e45268 RBX: ffff888014e45268 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888014e45268 RDI: ffff8880161872c0
RBP: ffff888014e45268 R08: 0000000000000058 R09: ffffed10029c8a4d
R10: 0000000000000007 R11: fffffbfff1fee13b R12: ffff8880161872c0
R13: ffffffff82263856 R14: ffffffff82263856 R15: 0000000000000000
FS:  00007f178f952700(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf37920010 CR3: 0000000020054000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 ____kasan_slab_free mm/kasan/common.c:366 [inline] mm/kasan/common.c:374
 ____kasan_slab_free mm/kasan/common.c:328 [inline] mm/kasan/common.c:374
 __kasan_slab_free+0x100/0x140 mm/kasan/common.c:374 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1723 [inline]
 slab_free_freelist_hook mm/slub.c:1749 [inline]
 slab_free mm/slub.c:3513 [inline]
 kasan_slab_free include/linux/kasan.h:235 [inline] mm/slub.c:3530
 slab_free_hook mm/slub.c:1723 [inline] mm/slub.c:3530
 slab_free_freelist_hook mm/slub.c:1749 [inline] mm/slub.c:3530
 slab_free mm/slub.c:3513 [inline] mm/slub.c:3530
 kmem_cache_free+0xdc/0x440 mm/slub.c:3530 mm/slub.c:3530
 jbd2_free_handle include/linux/jbd2.h:1608 [inline]
 jbd2_free_handle include/linux/jbd2.h:1608 [inline] fs/jbd2/transaction.c:1937
 jbd2_journal_stop+0x656/0xf20 fs/jbd2/transaction.c:1937
fs/jbd2/transaction.c:1937
 __ext4_journal_stop+0xde/0x1f0 fs/ext4/ext4_jbd2.c:127 fs/ext4/ext4_jbd2.c:127
 ext4_dirty_inode+0xe8/0x110 fs/ext4/inode.c:5920 fs/ext4/inode.c:5920
 __mark_inode_dirty+0x53d/0xfe0 fs/fs-writeback.c:2399 fs/fs-writeback.c:2399
 mark_inode_dirty include/linux/fs.h:2451 [inline]
 mark_inode_dirty include/linux/fs.h:2451 [inline] fs/buffer.c:2202
 generic_write_end+0x2fd/0x3e0 fs/buffer.c:2202 fs/buffer.c:2202
 ext4_da_write_end+0x1c2/0x9d0 fs/ext4/inode.c:3059 fs/ext4/inode.c:3059
 generic_perform_write+0x2c4/0x510 mm/filemap.c:3765 mm/filemap.c:3765
 ext4_buffered_write_iter+0x170/0x360 fs/ext4/file.c:269 fs/ext4/file.c:269
 ext4_file_write_iter+0x42e/0x14a0 fs/ext4/file.c:681 fs/ext4/file.c:681
 call_write_iter include/linux/fs.h:2162 [inline]
 call_write_iter include/linux/fs.h:2162 [inline] fs/read_write.c:503
 new_sync_write+0x432/0x660 fs/read_write.c:503 fs/read_write.c:503
 vfs_write+0x678/0xae0 fs/read_write.c:590 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f17923961cd
Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b
3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f178f951590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f178400d6e0 RCX: 00007f17923961cd
RDX: 00000000000008d8 RSI: 00007f178400d6e0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f17914efd57
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f178400d460
R13: 00007f178f9515b0 R14: 00005571eb1657c0 R15: 00000000000008d8
 </TASK>
----------------
Code disassembly (best guess):
   0: b7 54                 mov    $0x54,%bh
   2: 24 20                 and    $0x20,%al
   4: 66 81 e2 ff 1f       and    $0x1fff,%dx
   9: 0f b7 d2             movzwl %dx,%edx
   c: be 08 00 00 00       mov    $0x8,%esi
  11: 48 89 d0             mov    %rdx,%rax
  14: 48 89 54 24 38       mov    %rdx,0x38(%rsp)
  19: 48 c1 f8 06           sar    $0x6,%rax
  1d: 48 8d 3c c5 40 09 f7 lea    -0x7008f6c0(,%rax,8),%rdi
  24: 8f
  25: e8 34 40 62 00       callq  0x62405e
* 2a: 48 8b 54 24 38       mov    0x38(%rsp),%rdx <-- trapping instruction
  2f: 48 0f a3 15 77 1e 9b bt     %rdx,0xe9b1e77(%rip)        # 0xe9b1eae
  36: 0e
  37: 0f 83 c8 00 00 00     jae    0x105
  3d: 48                   rex.W
  3e: 8d                   .byte 0x8d
  3f: 04                   .byte 0x4
----------------
Code disassembly (best guess):
   0: b7 54                 mov    $0x54,%bh
   2: 24 20                 and    $0x20,%al
   4: 66 81 e2 ff 1f       and    $0x1fff,%dx
   9: 0f b7 d2             movzwl %dx,%edx
   c: be 08 00 00 00       mov    $0x8,%esi
  11: 48 89 d0             mov    %rdx,%rax
  14: 48 89 54 24 38       mov    %rdx,0x38(%rsp)
  19: 48 c1 f8 06           sar    $0x6,%rax
  1d: 48 8d 3c c5 40 09 f7 lea    -0x7008f6c0(,%rax,8),%rdi
  24: 8f
  25: e8 34 40 62 00       callq  0x62405e
* 2a: 48 8b 54 24 38       mov    0x38(%rsp),%rdx <-- trapping instruction
  2f: 48 0f a3 15 77 1e 9b bt     %rdx,0xe9b1e77(%rip)        # 0xe9b1eae
  36: 0e
  37: 0f 83 c8 00 00 00     jae    0x105
  3d: 48                   rex.W
  3e: 8d                   .byte 0x8d
  3f: 04                   .byte 0x4



Best Regards,
Yiru
