Return-Path: <linux-ext4+bounces-8310-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B8ACE6BD
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jun 2025 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F82718874FD
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jun 2025 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C30225A34;
	Wed,  4 Jun 2025 22:40:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3A179A3
	for <linux-ext4@vger.kernel.org>; Wed,  4 Jun 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076825; cv=none; b=QROF2UMeHoeMyDXjnTQ0XHCJduFKShr7u0cgAxbtIJWXkO1L3gdBpsMWeK6QItA63L6PNuJnyDJijaU7jwa9y5Z/Onkq0cQbVqDo/A0d74SamOXSY+2cKr5LjCWyRvuEEDAg5BaJ+Zegk50mLLa93PWK+uWuWQR8M74eh5r5WJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076825; c=relaxed/simple;
	bh=yJKEo6PKKsFEaoY+Wb+NuTVHnNoK8lm+1WZEK3Oda0s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uXUgUcoCavyC5oD7sj7ejLNEkuJo2aDel3a0S1DXgXGJ42p7eUBH6GSXRb+4tfPI4odG2S5/Z5u4U/8dpppPwIf66lY0OfTXblW/MKFcxBTW6GcAFsM2UjLjC7yFxFffjavtGFK4Fe7Fd7RR6D0v73GnGP8h8feaGfjRwyvSirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc1f84ab5so7766275ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Jun 2025 15:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749076822; x=1749681622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3CVkFYSih42dMa4crK8+2r1dGR38THO+9uTUAByLCA=;
        b=YG/H29JeUcOCd7Mwch4OBJOurw5XFTLStdnKYagAZ0Xvq4GbE6pHwEK70ytCca7Fq7
         mNEBl65u3X4qzxKuuTs23zrmPwu61owwwTSDsSS3owXt8gBkMwphJQNyMDR2XwugYJ9W
         0/cbvSaJbIopf7IxB8Zg5URgl0AjFN1B3yXSocE6uNcVDb6ueIcW/ncobQYyfdeyQ6cC
         E0I3LkCIONo6eQCP/2laaeEXG+BoKU2vRV6ZHxQv2wSJjr3qbwRrXetApMbEUQ879Niw
         DQ+6KRCj09+IR5qaFfcaws0uJC/EZMVKKUdJ1sOzEqth8blYVxN+sa0z42hUFWCK5UjS
         5bdw==
X-Forwarded-Encrypted: i=1; AJvYcCXX9sqhlP9nYV1NNZ0NiFUE7/AJlnxseh8/FXWjdE8pW9F4uOyq5bFUr08eCrgcNHGvoXHB2T58qNHY@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNXO+WN0RVQ7blT+BVXCiD3RaZsrlSWHgsePEw2gcTXRZB2TB
	Q+47nkAaKwKTfsqbz5jxAq2V/bVbgBO2mIZ/YJNQlxoQXU2mmd2LAchOLsXRXRLp15wuVWpiRs8
	lfusQbAkrxcqL3UoAtARkqlwTlfg9Qy8bG1KKV/pPyC1Z9qRvPpAlVrUyLOI=
X-Google-Smtp-Source: AGHT+IFKEm94hei2X92UPF3Njhb1nrH8QDmc/JVW364mYXZ44FCQBlnszvgmqeD1KinChAldYeR4HW+NW5Cz2fvi7aow2w4Axee9
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398d:b0:3db:877a:dff4 with SMTP id
 e9e14a558f8ab-3ddbed62af1mr53474965ab.14.1749076822447; Wed, 04 Jun 2025
 15:40:22 -0700 (PDT)
Date: Wed, 04 Jun 2025 15:40:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6840cb56.a00a0220.d4325.000f.GAE@google.com>
Subject: [syzbot] [v9fs?] [ext4?] INFO: task hung in __iterate_supers
From: syzbot <syzbot+b10aefdd9ef275e9368d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a83b350b5be Add linux-next specific files for 20250530
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=127da00c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28859360c84ac63d
dashboard link: https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13765970580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f4b00c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e18e458d13c9/disk-3a83b350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1c40854811c/vmlinux-3a83b350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/571f670b130a/bzImage-3a83b350.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f51e108aa24a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15765970580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b10aefdd9ef275e9368d@syzkaller.appspotmail.com

INFO: task syz-executor419:5916 blocked for more than 143 seconds.
      Not tainted 6.15.0-next-20250530-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor419 state:D stack:29576 pid:5916  tgid:5890  ppid:5883   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 super_lock+0x1c8/0x3b0 fs/super.c:115
 __iterate_supers+0x126/0x250 fs/super.c:923
 ksys_sync+0x94/0x150 fs/sync.c:102
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
RSP: 002b:00007f9054678218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f90547706f8 RCX: 00007f90546eea09
RDX: 00007f90546c5526 RSI: 0000000000000000 RDI: 00007f9054678fb0
RBP: 00007f90547706f0 R08: 00007ffc16b879e7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 000000000000006e R14: 0000200000000040 R15: 00007ffc16b879e8
 </TASK>
INFO: task syz-executor419:5913 blocked for more than 144 seconds.
      Not tainted 6.15.0-next-20250530-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor419 state:D stack:28584 pid:5913  tgid:5891  ppid:5881   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 super_lock+0x1c8/0x3b0 fs/super.c:115
 __iterate_supers+0x126/0x250 fs/super.c:923
 ksys_sync+0x94/0x150 fs/sync.c:102
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
RSP: 002b:00007f9054678218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f90547706f8 RCX: 00007f90546eea09
RDX: 00007f90546c5526 RSI: 0000000000000000 RDI: 00007f9054678fb0
RBP: 00007f90547706f0 R08: 00007ffc16b879e7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 000000000000006e R14: 0000200000000040 R15: 00007ffc16b879e8
 </TASK>
INFO: task syz-executor419:5914 blocked for more than 144 seconds.
      Not tainted 6.15.0-next-20250530-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor419 state:D stack:29544 pid:5914  tgid:5892  ppid:5882   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 super_lock+0x1c8/0x3b0 fs/super.c:115
 __iterate_supers+0x126/0x250 fs/super.c:923
 ksys_sync+0x94/0x150 fs/sync.c:102
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
RSP: 002b:00007f9054678218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f90547706f8 RCX: 00007f90546eea09
RDX: 00007f90546c5526 RSI: 0000000000000000 RDI: 00007f9054678fb0
RBP: 00007f90547706f0 R08: 00007ffc16b879e7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 000000000000006e R14: 0000200000000040 R15: 00007ffc16b879e8
 </TASK>
INFO: task syz-executor419:5915 blocked for more than 145 seconds.
      Not tainted 6.15.0-next-20250530-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor419 state:D stack:29576 pid:5915  tgid:5893  ppid:5880   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 super_lock+0x1c8/0x3b0 fs/super.c:115
 __iterate_supers+0x126/0x250 fs/super.c:923
 ksys_sync+0x94/0x150 fs/sync.c:102
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
RSP: 002b:00007f9054678218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f90547706f8 RCX: 00007f90546eea09
RDX: 00007f90546c5526 RSI: 0000000000000000 RDI: 00007f9054678fb0
RBP: 00007f90547706f0 R08: 00007ffc16b879e7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 000000000000006e R14: 0000200000000040 R15: 00007ffc16b879e8
 </TASK>
INFO: task syz-executor419:5917 blocked for more than 145 seconds.
      Not tainted 6.15.0-next-20250530-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor419 state:D stack:29576 pid:5917  tgid:5895  ppid:5879   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 super_lock+0x1c8/0x3b0 fs/super.c:115
 __iterate_supers+0x126/0x250 fs/super.c:923
 ksys_sync+0x94/0x150 fs/sync.c:102
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
RSP: 002b:00007f9054678218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f90547706f8 RCX: 00007f90546eea09
RDX: 00007f90546eea09 RSI: 0000000000000000 RDI: 0000000000000080
RBP: 00007f90547706f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc16b879e7 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 000000000000006e R14: 0000200000000040 R15: 00007ffc16b879e8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f140 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f140 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f140 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by getty/5595:
 #0: ffff888034dd90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor419/5894:
1 lock held by syz-executor419/5897:
1 lock held by syz-executor419/5896:
1 lock held by syz-executor419/5898:
1 lock held by syz-executor419/5900:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5900 Comm: syz-executor419 Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:its_return_thunk+0x0/0x10 arch/x86/lib/retpoline.S:412
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <c3> cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e9 8b 84 ca f5 cc
RSP: 0018:ffffc9000469fa38 EFLAGS: 00000293
RAX: ffffffff81ad3201 RBX: ffffc9000469fb20 RCX: ffff88807fc99e00
RDX: 0000000000000000 RSI: 746e756f6d65723d RDI: 000000003b9ac9ff
RBP: ffffc9000469faf0 R08: ffffffff8fa127f7 R09: 1ffffffff1f424fe
R10: dffffc0000000000 R11: fffffbfff1f424ff R12: ffffc9000469fa80
R13: ffffffffc4653600 R14: 195d9dfa908f7e3d R15: 73726f73f98510d7
FS:  00007f90546996c0(0000) GS:ffff888125d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606f52b3168 CR3: 0000000077c1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_normalized_timespec64+0xc1/0x1a0 kernel/time/time.c:497
 inode_set_ctime_to_ts+0x126/0x2f0 fs/inode.c:2666
 inode_set_ctime include/linux/fs.h:1773 [inline]
 v9fs_stat2inode_dotl+0x4f6/0xad0 fs/9p/vfs_inode_dotl.c:656
 v9fs_qid_iget_dotl fs/9p/vfs_inode_dotl.c:128 [inline]
 v9fs_inode_from_fid_dotl+0x206/0x2b0 fs/9p/vfs_inode_dotl.c:154
 v9fs_get_new_inode_from_fid fs/9p/v9fs.h:251 [inline]
 v9fs_mount+0x6cb/0xa10 fs/9p/vfs_super.c:142
 legacy_get_tree+0xfa/0x1a0 fs/fs_context.c:666
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1802
 do_new_mount+0x24a/0xa40 fs/namespace.c:3856
 do_mount fs/namespace.c:4193 [inline]
 __do_sys_mount fs/namespace.c:4404 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90546eea09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9054699218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f90547706e8 RCX: 00007f90546eea09
RDX: 0000200000000b80 RSI: 0000200000000040 RDI: 0000000000000000
RBP: 00007f90547706e0 R08: 0000200000000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f905473ca1c
R13: 0000200000000580 R14: 0000200000000040 R15: 00007f905473c04d
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

