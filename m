Return-Path: <linux-ext4+bounces-2581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4248C97FA
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 04:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBBB1C21411
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62FC2FD;
	Mon, 20 May 2024 02:41:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE906AB8
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172895; cv=none; b=OM+xVe5fVoA9fSVMeqpRoAhBkaJ/Qe1Nlf0cF5/h9zMzQb9e4P8dtoZzmQHx01zIJOmVGy74V6hfe6jNhJ0w+WxAhuZ8RxDqECdSQjxBRRQPKHz72WfriOIrHHqisBGMXG+meOI9OEY3VM8eq/DfwFE8uz2O0HPMmwyiYOQkTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172895; c=relaxed/simple;
	bh=2jvu3OyErGEZA19rAd/lqVthu1osydrnc/KBMMjdGWw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kl/DHvcvyvCbBZ3QwU928ZWzhsj8lJeWkTpnLocVeWKcJmRNR7rFKnEDV5Hv4/AFkB14+cIJenSKOKM7SBtiUF+0J52T+GWl9XfP2ZXx0h6hvvEdVDdfQhy45y2ZMw4VLPxFyqEQ2CoCw5HwXvwOEW7d2wZ2V/GRUMeOz0u2cvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1c22e7280so1127233439f.0
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 19:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716172893; x=1716777693;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GREGxmlAkH4tRO1qU2439hT78wZWCYqpWA7NBx8Kts=;
        b=ehW/ch+gKOA9zrv7fRYrQFiZhW2vcya9Sw0gdZ4bqNzhjey9DeR+GZzbeC2rt36Q0G
         fLkIN4FVQPoMHGjVB2Rmob0R5ae/M5XT8phPj91yn/1J61+IONmoPVamKxLzYUkr6S8r
         8p2uYjy0MzDdp72U9TmVo3pp3KpOXXNZPm/uRW65jbKWmT+0UiBYwneNNvrisRFCYQPn
         tp8fKarb5tZZvHDzD2sVGbN065mC3YqCJyC3XBCTGOR6mInJWo2TzaK1ts4fNDm7Paqk
         gtJBgiZ5FxCsKgFfpKZblQFRrQUJeNd2UAzRlITWDCZ41gedyHdb0+WPmLrYogUrba6g
         cO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVNizsTgH//OxNFJrhAy3/1PRwFmHqGMyHrgHXcpJIXejhHgXp+ycOfQrU6P46mFxzpPX8IxHgt4BuE0H3wHvQMs9LNsfk2FmuPQ==
X-Gm-Message-State: AOJu0Yw9cnhn8PrmKmI3ay07nRI1B+GJdOlUFARBWwnEMk8EuLOfVnSk
	m59omnUrP6dDwqLHw/N7EvM4OpgGrAdJ+5c54SAUIMpZqGhgk2+UMcW4qUzvBXANGDUN+zXcX0P
	LQvYM7QKr9SD2I6+yqlh7lJFJF8SWoSZa6Kzyvsr3riNVYd9dLKdhn7M=
X-Google-Smtp-Source: AGHT+IEJQ4sxWJGaLdFrZXs4CifFzHzy1q03Ym5ryd17YY7SPjzjbushVooZQXjbWyjYcvOIQruzRsJJKyJuqp0rriIAvybjyQNW
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:36f:32f0:5849 with SMTP id
 e9e14a558f8ab-36f32f058dfmr14015ab.5.1716172893098; Sun, 19 May 2024 19:41:33
 -0700 (PDT)
Date: Sun, 19 May 2024 19:41:33 -0700
In-Reply-To: <00000000000059a7eb06187613b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaa2170618d9a3df@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in jbd2_journal_commit_transaction
 (5)
From: syzbot <syzbot+3071bdd0a9953bc0d177@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    51474ab44abf drm/bridge: aux-hpd-bridge: correct devm_drm_..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17a7b8ec980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34bb6f7ae9107006
dashboard link: https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1564be58980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c0b3d0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8034495d66c0/disk-51474ab4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccf40ed0b79d/vmlinux-51474ab4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f1b37ef191d/bzImage-51474ab4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3071bdd0a9953bc0d177@syzkaller.appspotmail.com

INFO: task jbd2/sda1-8:2368 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc7-syzkaller-00158-g51474ab44abf #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D
 stack:26032 pid:2368  tgid:2368  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xca6/0x3170 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 io_schedule+0xbf/0x130 kernel/sched/core.c:9044
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer+0x64/0x70 fs/buffer.c:123
 wait_on_buffer include/linux/buffer_head.h:389 [inline]
 journal_wait_on_commit_record fs/jbd2/commit.c:171 [inline]
 jbd2_journal_commit_transaction+0x4824/0x65d0 fs/jbd2/commit.c:888
 kjournald2+0x1f8/0x8f0 fs/jbd2/journal.c:201
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:1/8:
 #0: 
ffff888104efdd48
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: 
ffffc9000008fd80
 ((work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: 
ffff88810938f190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: hub_event+0x1be/0x4f50 drivers/usb/core/hub.c:5849
 #3: 
ffff888113cc7190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #4: 
ffff88810c794160
 (&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #5: 
ffffffff890da0a8
 (
input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xa2b/0x1140 drivers/input/input.c:2389
1 lock held by khungtaskd/29:
 #0: 
ffffffff884b4560
 (
rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
6 locks held by kworker/1:1/35:
 #0: 
ffff888104efdd48
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: 
ffffc90000257d80
 ((work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: 
ffff88810975f190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: hub_event+0x1be/0x4f50 drivers/usb/core/hub.c:5849
 #3: 
ffff888104ee1190
 (&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #4: ffff88811eec1160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #5: 
ffffffff890da0a8
 (input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xa2b/0x1140 drivers/input/input.c:2389
6 locks held by kworker/0:2/694:
 #0: ffff888104efdd48
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: 
ffffc90001bdfd80
 ((work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: 
ffff88810977f190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: hub_event+0x1be/0x4f50 drivers/usb/core/hub.c:5849
 #3: 
ffff888113cc6190
 (&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #4: ffff888113cc4160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #5: 
ffffffff890da0a8
 (input_mutex
){+.+.}-{3:3}
, at: input_register_device+0xa2b/0x1140 drivers/input/input.c:2389
6 locks held by kworker/1:2/725:
 #0: ffff888104efdd48
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: 
ffffc90001d6fd80
 ((work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: 
ffff888109b4f190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: hub_event+0x1be/0x4f50 drivers/usb/core/hub.c:5849
 #3: 
ffff888104ee2190
 (&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: 
ffff88811eec0160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:990 [inline]
, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1290
 #5: 
ffffffff890da0a8
 (input_mutex
){+.+.}-{3:3}
, at: __input_unregister_device+0x136/0x450 drivers/input/input.c:2219
2 locks held by getty/2463:
 #0: 
ffff88810f3160a0
 (&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900000432f0
 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
6 locks held by kworker/0:0/2501:
4 locks held by udevd/2525:
 #0: ffff888104eb68b8
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: 
ffff88810b6b6c88
 (&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: 
ffff8881135110f8
 (
kn->active
#18){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff88810b367190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:995 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
4 locks held by udevd/2526:
4 locks held by udevd/2527:
 #0: ffff88810bede540
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: 
ffff888120d2d088
 (&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888112a3a1e8
 (
kn->active
#18){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff888113cc6190
 (&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:995 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
5 locks held by kworker/0:4/2528:
4 locks held by udevd/2529:
 #0: 
ffff88810e68b418
 (&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: ffff88811f889888
 (&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: 
ffff8881139ce0f8
 (
kn->active#18
){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888104ee1190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:995 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
4 locks held by udevd/2531:
 #0: 
ffff88810b71ee80
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: 
ffff888120d2f088
 (&of->mutex
#2){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: 
ffff88810fb7d968
 (
kn->active
#18){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff888113cc7190
 (&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:995 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.9.0-rc7-syzkaller-00158-g51474ab44abf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:380
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
yealink 2-1:36.0: urb_irq_callback - urb status -71
NMI backtrace for cpu 0
CPU: 0 PID: 2528 Comm: kworker/0:4 Not tainted 6.9.0-rc7-syzkaller-00158-g51474ab44abf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events kfree_rcu_monitor
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x8/0x20 kernel/kcov.c:290
Code: bf 06 00 00 00 e9 b8 fe ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <40> 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 86 fe ff ff 66 0f 1f 44
RSP: 0000:ffffc900000070c0 EFLAGS: 00000046
RAX: 0000000000010002 RBX: ffffc900000074a7 RCX: ffffffff8685fac0
RDX: ffff8881047c9d00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000006 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000235118 R12: 0000000000000010
R13: 0000000000000000 R14: ffffc9008000749f R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f4168ea1c8 CR3: 000000011628c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 number+0x5d0/0xb80 lib/vsprintf.c:527
 vsnprintf+0x92a/0x1880 lib/vsprintf.c:2890
 sprintf+0xcd/0x110 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1330 [inline]
 info_print_prefix+0x25c/0x350 kernel/printk/printk.c:1356
 record_print_text+0x141/0x400 kernel/printk/printk.c:1405
 printk_get_next_message+0x2a6/0x670 kernel/printk/printk.c:2840
 console_emit_next_record kernel/printk/printk.c:2880 [inline]
 console_flush_all+0x3b2/0xd70 kernel/printk/printk.c:2979
 console_unlock+0xae/0x290 kernel/printk/printk.c:3048
 vprintk_emit kernel/printk/printk.c:2348 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2303
 dev_vprintk_emit drivers/base/core.c:4950 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4961
 __dev_printk+0xf5/0x270 drivers/base/core.c:4973
 _dev_err+0xe5/0x120 drivers/base/core.c:5016
 urb_irq_callback+0x454/0x700 drivers/input/misc/yealink.c:416
 __usb_hcd_giveback_urb+0x364/0x5c0 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1732
 dummy_timer+0x17f6/0x3900 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x8b/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 56 4b a1 fa 48 89 df e8 ae c7 a1 fa f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 85 35 96 fa 65 8b 05 d6 db 73 79 85 c0 74 16 5b
RSP: 0000:ffffc900014cfa58 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff8d3e3620 RCX: 1ffffffff1954b05
RDX: 0000000000000000 RSI: ffffffff86c7cf00 RDI: ffffffff86e73ce0
RBP: 0000000000000206 R08: 0000000000000001 R09: fffffbfff194f3b1
R10: ffffffff8ca79d8f R11: 0000000000000002 R12: 0000000000000009
R13: dffffc0000000000 R14: ffff88811aeb3700 R15: 1ffff92000299f50
 debug_object_deactivate+0x1f0/0x370 lib/debugobjects.c:778
 debug_rcu_head_unqueue kernel/rcu/rcu.h:239 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:2949 [inline]
 kvfree_rcu_bulk+0x12c/0x550 kernel/rcu/tree.c:3026
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3207 [inline]
 kfree_rcu_monitor+0x47b/0x12d0 kernel/rcu/tree.c:3225
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.795 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

