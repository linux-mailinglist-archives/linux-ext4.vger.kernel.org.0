Return-Path: <linux-ext4+bounces-2518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1068C5F85
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 05:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DD5283A25
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3138385;
	Wed, 15 May 2024 03:54:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECF381B9
	for <linux-ext4@vger.kernel.org>; Wed, 15 May 2024 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745272; cv=none; b=RzMfAOhxJa1Fnar2Fu0zNe23Ow8umAcvlLNVnRRqaVA8aRSnGq0gEyajBJvqWRciaJGD/qsMzCXX4EAvcDQARNjQOmDCXSxT9uPRkp1UL/WQM6NocwW2NZARJx7sGgyPgO7I3SuwofUf7ZMFRrhlp2MDWtxCS/qVYQrmQqQn4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745272; c=relaxed/simple;
	bh=/PGUz2q/03R5zYjmSf1lB0Kt7YdHYGzxnEPfbkOgAVk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y9tLyEqEopQwBykCKROKY2UAUwuIV66mDDrGKuB/KRDWQEjHs66Ymr41tOLm6n0NQqKjU1Q3eZDDKU3fXNZ06QTO5fx6B/WOm5vFWvMvtfoEtaMbORM9KLFsmqdbkvKzmspjomf0CsYq2nDp3cXiYM9lSnwS8pb4zOm4vjVdYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1bbace584so589385839f.1
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2024 20:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715745270; x=1716350070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSfl1qxsyG2z/8DU4PRL7FZx3ItPbPasEvLrxLRmM3c=;
        b=g+c2aQf/LctOaBrS8dq6lMRos/Ne1+xb0Qkmgz0qTplKa2nApqd8CfPamOOXvYOUFb
         Xz7VCy83BIa5I0a/EjJK6Rqo8UPpcaksaxsnD/5ZeMZmnL+Awux7Gp958NHzJuxNEn4G
         g8rV5B6mv96W9QRiFT7gw1wjaQykJ/MXihzNJ1ApCt2UY4dcaVNngECbxLezF7qt5bMJ
         PO6GiR47a/NaxOt53wIQkoB9pZH88YUcxtsbn3h4fksy7dfpJxHRfh1qfc6TRGOfgYNr
         m3lykPd6Vrypx/YFwfKBchQnGs3dXDAMpiY5jmwtipBwlM083bXTbMykQMmTQGwygpFQ
         mczw==
X-Forwarded-Encrypted: i=1; AJvYcCUs+xgniFmcZ0n+he1Mt/QHV7MnGQgPqEP/chyxtmg+5yGS1wxODUAmk4pkIRFWym2X+XzHORvOSNihv1XOmMgrusso5ceI+QgwoQ==
X-Gm-Message-State: AOJu0Yxuaqx+6UduzkxBMYR+oWyLW/7jBbAUqhzwD+qvQJvJZgpv9bUA
	A2jq03XzP9XbiXhBsYpyTlZhicYjyNIT1o68FriNI26L9ebTojuxR+Opjszs1zf/Dnt38fw9ruV
	MnidJVfCrm4pdHFYf/3qrGuZnFMnfebEJi9scjbi/pJgnJa8WmV8v4fc=
X-Google-Smtp-Source: AGHT+IG2JK+6DMSyVhxNJsv/XS6umy2WDDW57uTpAqcvVyX12CON+TtXPaiE3MNQkpGaxHzLkNzNaF4Kj7Xk9tpWY9nBZdDsmUNl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-48957ebc573mr1074132173.0.1715745270108; Tue, 14 May 2024
 20:54:30 -0700 (PDT)
Date: Tue, 14 May 2024 20:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059a7eb06187613b2@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in jbd2_journal_commit_transaction (5)
From: syzbot <syzbot+3071bdd0a9953bc0d177@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6ba6c795dc73 Add linux-next specific files for 20240513
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16473c3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8af44e051929224
dashboard link: https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1583acd0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4fc6f95559c/disk-6ba6c795.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bf6271325de/vmlinux-6ba6c795.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2551e051938/bzImage-6ba6c795.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3071bdd0a9953bc0d177@syzkaller.appspotmail.com

INFO: task jbd2/sda1-8:4509 blocked for more than 143 seconds.
      Not tainted 6.9.0-next-20240513-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D
 stack:25008 pid:4509  tgid:4509  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 io_schedule+0x8d/0x110 kernel/sched/core.c:9043
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
 wait_on_buffer include/linux/buffer_head.h:415 [inline]
 journal_wait_on_commit_record fs/jbd2/commit.c:171 [inline]
 jbd2_journal_commit_transaction+0x3d7f/0x6760 fs/jbd2/commit.c:887
 kjournald2+0x463/0x850 fs/jbd2/journal.c:201
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u8:0/11:
1 lock held by khungtaskd/30:
 #0: 
ffffffff8e333e60
 (
rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
6 locks held by kworker/1:2/57:
2 locks held by udevd/4546:
2 locks held by getty/4856:
 #0: 
ffff88802a7140a0
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc90002f0e2f0
 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by kworker/1:1/5128:
1 lock held by syz-executor.4/5185:
 #0: 
ffff8880b943e7d8
 (
&rq->__lock
){-.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
6 locks held by kworker/0:2/5189:
 #0: 
ffff88801ce9b148
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3206 [inline]
, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: 
ffffc900043bfd00
 (
(work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3207 [inline]
, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: 
ffff8880237e9190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: 
ffff888078c2b190
 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: 
ffff888066cb2160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: 
ffffffff8f0a3d68
 (
input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xae5/0x1090 drivers/input/input.c:2389
4 locks held by udevd/5229:
 #0: 
ffff888078f50418
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: 
ffff88801e7efc88
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: 
ffff88801c2e8788
 (
kn->active
#29
){.+.+}-{0:0}
, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: 
ffff888078c2b190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:1014 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
6 locks held by kworker/1:3/5230:
4 locks held by udevd/5231:
 #0: 
ffff888026f578b8
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: 
ffff88807b2f7c88
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: 
ffff888077d4b878 (kn->active
#29
){.+.+}-{0:0}
, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: 
ffff888079d16190
 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1014 [inline]
 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
3 locks held by kworker/1:4/5232:
6 locks held by kworker/0:5/5234:
 #0: 
ffff88801ce9b148
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3206 [inline]
, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: 
ffffc900046afd00
 (
(work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3207 [inline]
, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: 
ffff888023870190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: 
ffff88802dc98190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: ffff888015bf8160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888015bf8160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: 
ffffffff8f0a3d68
 (
input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xae5/0x1090 drivers/input/input.c:2389
5 locks held by kworker/1:5/5235:
4 locks held by udevd/5267:
 #0: 
ffff888019f879e0
 (
&p->lock
){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: 
ffff888079983488
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: 
ffff88807c938878 (kn->active#29){.+.+}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: 
ffff88802d3f2190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:1014 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
4 locks held by udevd/5269:
 #0: 
ffff88802b088c30
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: 
ffff8880235e4888
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: 
ffff888078faac38
 (
kn->active
#29
){.+.+}-{0:0}
, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: 
ffff88802dc98190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:1014 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
6 locks held by kworker/0:8/5273:
 #0: 
ffff88801ce9b148
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3206 [inline]
, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: 
ffffc900047dfd00
 (
(work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3207 [inline]
, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: 
ffff88802389c190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: 
ffff88807ba7a190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: 
ffff88807b7de160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: 
ffffffff8f0a3d68
 (
input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xae5/0x1090 drivers/input/input.c:2389
4 locks held by udevd/5285:
 #0: 
ffff888078e04418
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: 
ffff88807bb22488
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff88802f75ed28 (kn->active#29){.+.+}-{0:0}
, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: 
ffff88807ba7a190
 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1014 [inline]
 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.9.0-next-20240513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
yealink 1-1:36.0: urb_irq_callback - urb status -71
NMI backtrace for cpu 1
CPU: 1 PID: 5230 Comm: kworker/1:3 Not tainted 6.9.0-next-20240513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_long defense_work_handler
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:406
Code: 30 58 57 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 b1 11 bd fc 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c
RSP: 0018:ffffc90000a16bb8 EFLAGS: 00000002
RAX: 1ffffffff295b600 RBX: ffffffff94adb1a0 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff853ef446 R09: 1ffff11003eb9046
R10: dffffc0000000000 R11: ffffffff853ef400 R12: dffffc0000000000
R13: 00000000000026cb R14: 00000000000003fd R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055da977a1328 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:117 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2068 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
 serial8250_console_write+0x1099/0x1770 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:2928 [inline]
 console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_err+0x122/0x170 drivers/base/core.c:5017
 urb_irq_callback+0x37e/0x5b0 drivers/input/misc/yealink.c:416
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:memset_orig+0x98/0xb0 arch/x86/lib/memset_64.S:110
Code: 00 00 ff c9 48 89 07 48 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01 75 f6 4c 89 d0 c3 cc cc cc cc 48 83 fa 07 76 e3 <48> 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff
RSP: 0018:ffffc90000a17bf0 EFLAGS: 00000206
RAX: fcfcfcfcfcfcfcfc RBX: ffff888069636800 RCX: 00000000000000fc
RDX: 000000000000001e RSI: 00000000000000fc RDI: ffffed100d2c6d62
RBP: 0000000000000310 R08: dffffc0000000000 R09: 0000000000000002
R10: ffffed100d2c6d62 R11: fffff52000142ffc R12: 0000000000000920
R13: ffff888015041dc0 R14: 0000000000000920 R15: ffff888015041dc0
 poison_kmalloc_redzone mm/kasan/common.c:362 [inline]
 __kasan_kmalloc+0x83/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x200/0x410 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xd5/0x2870 net/mac80211/parse.c:880
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2330 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2337 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1049/0x2330 net/wireless/scan.c:2277
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3101
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3191
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x2b00/0x3780 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_tasklet_handler+0xeb/0x1f0 net/mac80211/main.c:438
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__might_resched+0x2ef/0x780 kernel/sched/core.c:10198
Code: e7 28 99 0c 48 8b 05 00 58 33 11 48 29 c1 48 83 c1 9c 79 57 48 85 c0 74 52 48 c7 44 24 40 0e 36 e0 45 4a c7 04 3a 00 00 00 00 <42> c7 44 3a 09 00 00 00 00 66 42 c7 44 3a 0d 00 00 42 c6 44 3a 0f
RSP: 0018:ffffc9000403faa0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff92000807f68 RCX: ffff888020370000
RDX: dffffc0000000000 RSI: ffff888020370000 RDI: ffffc9000403fb40
RBP: ffffc9000403fbb0 R08: ffffffff81613494 R09: 1ffffffff1f5a6bd
R10: dffffc0000000000 R11: fffffbfff1f5a6be R12: 0000000000000000
R13: ffff888020370444 R14: 0000000000000cc0 R15: 1ffff92000807f5c
 process_one_work kernel/workqueue.c:3264 [inline]
 process_scheduled_works+0xcb4/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71


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

