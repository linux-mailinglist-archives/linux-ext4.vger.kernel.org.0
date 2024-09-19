Return-Path: <linux-ext4+bounces-4219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB597C5DE
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDA1C22C09
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D49198E9E;
	Thu, 19 Sep 2024 08:31:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C054206D
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734685; cv=none; b=LvRH5nnRfrGF0aiQimSctZip83n/5r2An2bZE50aWbS/30jy1xq1oj9y0PPjiDMDKsGCDS+Ct2eRCfJjCdGRBaeHQ5tllTsGs3B2f27Zm6LggRh/p9Ezwq4N3gN7JZ++7VCluRHAD7d7nCLbAivbIgjzpq7QvHnUhvr0x6cxJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734685; c=relaxed/simple;
	bh=aHk9QBVaJH+O/zrRDCSedXguPyG7jF/unDYpFHKCDOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fw9DB2LUS1hlVH43EJdGP9z8eQwbKswiA1S6xVI1/OsC6fJto40ue+8K6v8PRlaEGrlzz2gkuIE7LoRLIuaFUyxyNcDjeXicA7iKaN0D+N0nS8YQL8guhJXsWxGpmnJK9+zimqRxP9UL6dFu7km21Hsh/KyDoG0KJVNFzoHexH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ac0d22edso8665255ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734683; x=1727339483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAVNz62uBC3jP6mZc6b1omvbI9iIPgXF/EDiS76HP2g=;
        b=xM/3pY5Pjqsc+Ozd4SUbKG3bRDNnOHzfG6BlmAZ0NI9ASNP+pQ0jty5VrHQYrR4iCj
         X4rVSA4ND1CWNzQvXLnohiZ5mercW7R9d3bUgpPjgqN5R6WBs0CG39a/8Yg055JVgNsf
         Lnp1IKHWcyoQNuunxbXhuTYNeVBIuWAcoS/DCph14c4Hh9UOQpvb0oHR9jwA/vKGnuiN
         LH3f056ByVfwTGOAlcT5XLLnuyayjko/X+tIELeumWYCzwadHPehvjaDZikauijjBOQL
         f3WL9gTPY/0dk6gnUyzWaZ35r/i5NT7qwCc8CZ2DmTNbpMZ/7vAISz3Gg7XidzMETFnv
         mVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUXQdlWeoR5oTfSVf+QZgdWD8l0SEOfdeAoIFGMj1brr6JOyZYCtNopUU32GOEcTtd6TfpdNcyJR346@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/h3WPF2c3Zfgq3egCsMDbLnGxoDEF+2B0abQF7P3ebri7ymHL
	8WOkFsu74Lpi6OOA36Xp/S4YRa5I7+F5louddByMolv9fyXMQim+0GXFIiwvQtRgFcY5ZHUzNBF
	sW2JCxVAW28Ph3V9m8qmI5cLBBd33+6uxe0rrprJPwSgwoUeD0DSlfbI=
X-Google-Smtp-Source: AGHT+IFa71Lf9+rTP7kYiyO0R9i1EVfOubuVJwl2gK+3bft51jEE8W+cMh1zg4Nn3k/HVytQBetBNOqSF/e0kYYgqhYljLl00qiR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:3a0:98f7:101d with SMTP id
 e9e14a558f8ab-3a098f711d0mr156136735ab.21.1726734683024; Thu, 19 Sep 2024
 01:31:23 -0700 (PDT)
Date: Thu, 19 Sep 2024 01:31:22 -0700
In-Reply-To: <000000000000690606061ce1fe7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ebe15a.050a0220.115905.002b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fbd177980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9b53363496e/disk-4a39ac5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9672b80e5c11/vmlinux-4a39ac5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f81bbed7f77/bzImage-4a39ac5b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fe146a421716/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com

INFO: task syz-executor257:5252 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor257 state:D stack:19952 pid:5252  tgid:5252  ppid:5245   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x640 kernel/kthread.c:710
 ext4_stop_mmpd+0x47/0xb0 fs/ext4/mmp.c:261
 ext4_put_super+0x753/0xd50 fs/ext4/super.c:1365
 generic_shutdown_super+0x13b/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1696
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7289
 deactivate_locked_super+0xc6/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x251/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f05996b6607
RSP: 002b:00007ffd8732a2c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f05996b6607
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd8732a380
RBP: 00007ffd8732a380 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffd8732b3f0
R13: 000055557bf766c0 R14: 000000000005bf62 R15: 000000000000010a
 </TASK>
INFO: task kmmpd-loop1:9789 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kmmpd-loop1     state:D stack:28592 pid:9789  tgid:9789  ppid:2      flags:0x00024000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 percpu_rwsem_wait+0x3c2/0x450 kernel/locking/percpu-rwsem.c:162
 __percpu_down_read+0xee/0x130 kernel/locking/percpu-rwsem.c:177
 percpu_down_read include/linux/percpu-rwsem.h:65 [inline]
 __sb_start_write include/linux/fs.h:1715 [inline]
 sb_start_write include/linux/fs.h:1851 [inline]
 write_mmp_block+0x2f2/0x3a0 fs/ext4/mmp.c:66
 kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
1 lock held by syslogd/4661:
 #0: ffff8880b883e998 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
1 lock held by udevd/4679:
 #0: ffff8880b883e998 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
2 locks held by getty/4976:
 #0: ffff888031bda0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor257/5252:
 #0: ffff88807636c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807636c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807636c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
1 lock held by syz-executor257/5254:
 #0: ffff88807fd480e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807fd480e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807fd480e0 (&type->s_umount_key#32){++++}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
1 lock held by udevd/5277:
 #0: ffff8880b893e998 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
1 lock held by kmmpd-loop1/9789:
 #0: ffff88807636c420 (sb_writers#4){++++}-{0:0}, at: kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
1 lock held by kmmpd-loop5/10429:
 #0: ffff88807fd48420 (sb_writers#4){++++}-{0:0}, at: kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
6 locks held by syz-executor257/15576:
 #0: ffff888148c85db0 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at: bdev_freeze+0x2a/0x220 block/bdev.c:248
 #1: ffff888030d26420 (sb_writers#4){++++}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #1: ffff888030d26420 (sb_writers#4){++++}-{0:0}, at: freeze_super+0x4e9/0xee0 fs/super.c:2085
 #2: ffff888030d260e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #2: ffff888030d260e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #2: ffff888030d260e0 (&type->s_umount_key#32){++++}-{3:3}, at: freeze_super+0x4f1/0xee0 fs/super.c:2086
 #3: ffff888030d26518 (sb_pagefaults){+.+.}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #3: ffff888030d26518 (sb_pagefaults){+.+.}-{0:0}, at: freeze_super+0x519/0xee0 fs/super.c:2090
 #4: ffff888030d26610 (sb_internal){++++}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #4: ffff888030d26610 (sb_internal){++++}-{0:0}, at: freeze_super+0x7cc/0xee0 fs/super.c:2104
 #5: ffffffff8e93e0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #5: ffffffff8e93e0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
5 locks held by syz-executor257/15579:
 #0: ffff888148c846b0 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at: bdev_freeze+0x2a/0x220 block/bdev.c:248
 #1: ffff888012982420 (sb_writers#4){++++}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #1: ffff888012982420 (sb_writers#4){++++}-{0:0}, at: freeze_super+0x4e9/0xee0 fs/super.c:2085
 #2: ffff8880129820e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #2: ffff8880129820e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #2: ffff8880129820e0 (&type->s_umount_key#32){++++}-{3:3}, at: freeze_super+0x4f1/0xee0 fs/super.c:2086
 #3: ffff888012982518 (sb_pagefaults){+.+.}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #3: ffff888012982518 (sb_pagefaults){+.+.}-{0:0}, at: freeze_super+0x519/0xee0 fs/super.c:2090
 #4: ffffffff8e93e0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #4: ffffffff8e93e0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
4 locks held by syz-executor257/15584:
 #0: ffff888148c86930 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at: bdev_freeze+0x2a/0x220 block/bdev.c:248
 #1: ffff8880784fc420 (sb_writers#4){++++}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #1: ffff8880784fc420 (sb_writers#4){++++}-{0:0}, at: freeze_super+0x4e9/0xee0 fs/super.c:2085
 #2: ffff8880784fc0e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #2: ffff8880784fc0e0 (&type->s_umount_key#32){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #2: ffff8880784fc0e0 (&type->s_umount_key#32){++++}-{3:3}, at: freeze_super+0x4f1/0xee0 fs/super.c:2086
 #3: ffff8880784fc518 (sb_pagefaults){+.+.}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #3: ffff8880784fc518 (sb_pagefaults){+.+.}-{0:0}, at: freeze_super+0x519/0xee0 fs/super.c:2090
2 locks held by syz-executor257/15587:
 #0: ffff888148c874b0 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at: bdev_freeze+0x2a/0x220 block/bdev.c:248
 #1: ffff88807d342420 (sb_writers#4){++++}-{0:0}, at: sb_wait_write fs/super.c:1896 [inline]
 #1: ffff88807d342420 (sb_writers#4){++++}-{0:0}, at: freeze_super+0x4e9/0xee0 fs/super.c:2085

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4668 Comm: klogd Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:srso_alias_safe_ret+0x0/0x7 arch/x86/lib/retpoline.S:171
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <48> 8d 64 24 08 c3 cc e8 f4 ff ff ff 0f 0b cc cc cc cc cc cc cc cc
RSP: 0018:ffffc9000db3fa70 EFLAGS: 00000293
RAX: ffffffff815f5458 RBX: 1ffff92001b67f78 RCX: ffff88807dec5a00
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000000
RBP: ffffc9000db3fc70 R08: ffffffff8a5a09bb R09: 1ffff1100fdaf538
R10: dffffc0000000000 R11: ffffed100fdaf539 R12: 000000000000008b
R13: dffffc0000000000 R14: ffffc9000db3fbc0 R15: dffffc0000000000
FS:  00007fa7b527c380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd87329b18 CR3: 000000007ddda000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:181
 scm_destroy_cred include/net/scm.h:80 [inline]
 scm_destroy+0x35/0x90 include/net/scm.h:86
 unix_dgram_sendmsg+0x14a5/0x1f80 net/unix/af_unix.c:2169
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 __sys_sendto+0x398/0x4f0 net/socket.c:2210
 __do_sys_sendto net/socket.c:2222 [inline]
 __se_sys_sendto net/socket.c:2218 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7b53de9b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffeaae3a018 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa7b53de9b5
RDX: 000000000000008b RSI: 000055fd5541ce20 RDI: 0000000000000003
RBP: 000055fd55418910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007fa7b556c212 R14: 00007ffeaae3a118 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

