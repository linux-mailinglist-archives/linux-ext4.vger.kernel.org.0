Return-Path: <linux-ext4+bounces-3443-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97293BC73
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 08:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259F11C227D7
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B316C69D;
	Thu, 25 Jul 2024 06:18:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BE16B39C
	for <linux-ext4@vger.kernel.org>; Thu, 25 Jul 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888307; cv=none; b=cyHzvs9MYMxQCKieux9nBohbIlfCJY7ESwaelx2BHdmn/BOWsQOov1gltU8aznoMYhwiWWvVv73SfQiMpnK1m5hvd7VNad8zfz9sjqBv6e0hEhqeEGuAQnJs1MlHW69HaLdyA/jEcqRsjmSC4siitJN8dfjideQUA4RO3xPdxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888307; c=relaxed/simple;
	bh=6wdQ515yhUTWZfUcS2Yxg7TYS9w/R44a3ReHNC2M+rU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N9gN1udi6DaLiUNAg3++QFwFdWrTJk98KOsuBUFpUqP3I8XHqCh73RD4+cJb15qMVMNXv6j513Je2mZi/gzQoB1rI/++uV/brdTyUW7LjW8IrnZiQcv+yFOaytVO52YrZmgF8De88Be1Zf5FBK502ZUt6Sgu5TKnHuL9cLLUYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso30657239f.0
        for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 23:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721888305; x=1722493105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0mG+NC9VjYBQk9CiWV5gKANJ3JV1vh6dmYYKhqLceg=;
        b=ZeL6goLoGgkMrVmj7Mj8OLcZjb1xZcjB0VTQ0uxu6ya3ELy8msLEVyG62ErhzVzPws
         nvk5BAqL4YGNq3g/IurizYXzXIyb5HMdqewz3WVbmPcOjcYGla1iZGPnKjIbYoKghV4/
         uoU486r9GFI50GDGzPa3qUniTN23HFjporyx4mL/3sNwjeJ3XjO3e4ufeSn/78bbzKoI
         27FDB4UO2OOPXBetEvma9EWH6TGowrFZqYMucqLqlN2E7tXIR1MTQVno8eSgvnOpcj1N
         zEkpTCwpd+3segCrHvCfe+AUIskqqpoGx/TRLYjqRjglN/Nq081YL46UHWUCyaMATU/L
         QN4g==
X-Forwarded-Encrypted: i=1; AJvYcCWix9L+DOMCORxLWMIFVLfdjhaNSIqm05E+geNzJwJh0o1DiI1/89vFLZ+nLYg7Gbgq54Tiz88pORfxWxHGd/IC3aVmfcoypKzalw==
X-Gm-Message-State: AOJu0YzGm/iAZSN5N9HKnN89ZEXmTcKo7IEuHgVJbXcZBb1zU/J2Bmj5
	k0JnhT2Fc8Fed6EBh0ixd8Eoc798uwZNLCsRcd60o+/zcuTEKX8CNc329OOfVRuzFBsysjscGcC
	SzvGnGRK2D+OiDn6dAf8TFTBB+0Q2Ghs2EuMcqdtsaYHWzOLN8m//ftg=
X-Google-Smtp-Source: AGHT+IH55ScSSc/prev/3PP+sMFyHhpUvzNb7vzhA8ClgYnIIXwOpM9eBH8ekRvfz5vZzQ8+tKDY411GWddDJ5PIIbNVty3nT3pB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8728:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4c29afaf6f2mr100269173.1.1721888305194; Wed, 24 Jul 2024
 23:18:25 -0700 (PDT)
Date: Wed, 24 Jul 2024 23:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c65dc8061e0c5c29@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in sb_start_write
From: syzbot <syzbot+fb3ada58a6c0a3208821@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1615aead980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd768013789223fa
dashboard link: https://syzkaller.appspot.com/bug?extid=fb3ada58a6c0a3208821
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1499b23d099/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2ccae57b0f3/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/501a769c268d/bzImage-786c8248.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb3ada58a6c0a3208821@syzkaller.appspotmail.com

INFO: task syz.2.2299:13275 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.2299      state:D stack:27424 pid:13275 tgid:13255 ppid:12630  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 percpu_rwsem_wait+0x3c2/0x450 kernel/locking/percpu-rwsem.c:162
 __percpu_down_read+0xee/0x130 kernel/locking/percpu-rwsem.c:177
 percpu_down_read include/linux/percpu-rwsem.h:65 [inline]
 __sb_start_write include/linux/fs.h:1675 [inline]
 sb_start_write+0x184/0x1c0 include/linux/fs.h:1811
 file_start_write include/linux/fs.h:2876 [inline]
 vfs_write+0x227/0xc90 fs/read_write.c:586
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77fd175f19
RSP: 002b:00007f77fde67048 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f77fd306110 RCX: 00007f77fd175f19
RDX: 0000000000000016 RSI: 00000000200001c0 RDI: 0000000000000006
RBP: 00007f77fd1e4e68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f77fd306110 R15: 00007fff7a49ea38
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:7/962:
 #0: ffff88802a1a0148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a1a0148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003e87d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003e87d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
2 locks held by getty/4856:
 #0: ffff88802ab2b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
5 locks held by kworker/u8:12/5462:
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004357d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004357d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5fbbd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe9/0xa90 net/core/dev.c:11874
 #4: ffffffff8e33ca38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #4: ffffffff8e33ca38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958
5 locks held by kworker/u8:13/8517:
3 locks held by syz.0.1908/11783:
3 locks held by syz.5.1943/11906:
3 locks held by kworker/0:8/12439:
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900045c7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900045c7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/u8:0/12788:
2 locks held by syz.2.2299/13275:
 #0: ffff88802ba69c48 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x310 fs/file.c:1191
 #1: ffff888051c36420 (sb_writers#4){++++}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #1: ffff888051c36420 (sb_writers#4){++++}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
1 lock held by kmmpd-loop2/13260:
 #0: ffff888051c36420 (sb_writers#4){++++}-{0:0}, at: kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
1 lock held by syz-executor/13644:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13647:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13654:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13657:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
7 locks held by syz-executor/13695:
 #0: ffff888029706420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #0: ffff888029706420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff88805ecb5088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff8880223ddb48 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #3: ffffffff8ef0a8a8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
 #4: ffff88801ba860e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88801ba860e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: ffff88802199d250 (&devlink->lock_key#67){+.+.}-{3:3}, at: nsim_drv_probe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
 #6: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: fib_seq_sum+0x31/0x290 net/core/fib_notifier.c:46
1 lock held by syz-executor/13712:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13722:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13725:
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 61 Comm: kworker/u8:4 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:separate_irq_context kernel/locking/lockdep.c:4613 [inline]
RIP: 0010:__lock_acquire+0xd3e/0x2040 kernel/locking/lockdep.c:5126
Code: e8 48 c1 e8 03 80 3c 38 00 74 12 48 89 ef e8 79 10 8b 00 48 bf 00 00 00 00 00 fc ff df 4c 89 75 00 48 8b 44 24 38 0f b6 04 38 <84> c0 0f 85 2a 0c 00 00 41 8b 5d 00 48 85 db 74 58 83 fb 31 0f 83
RSP: 0018:ffffc900015cf850 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888017f0c6d0 RCX: ffffffff816fbebb
RDX: 0000000000000000 RSI: 0000000000000008 RDI: dffffc0000000000
RBP: ffff888017f0c730 R08: ffffffff930028df R09: 1ffffffff260051b
R10: dffffc0000000000 R11: fffffbfff260051c R12: 0000000000000000
R13: ffff888017f0c6d8 R14: 5fc32a07651d3de9 R15: ffff888017f0c750
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0954dc0ef0 CR3: 000000000e134000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_nc_purge_paths+0xe8/0x3b0 net/batman-adv/network-coding.c:442
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

