Return-Path: <linux-ext4+bounces-6293-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451FBA24F6D
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8111188400C
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3841FBEB7;
	Sun,  2 Feb 2025 18:31:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8C1DDA24
	for <linux-ext4@vger.kernel.org>; Sun,  2 Feb 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738521082; cv=none; b=HCEs7ZqPNYEfKNQYnJ4uuuRG9Gbt8KJgp1bjEeGNbGHk8ieEJl0tp4TdMScanLBITJtTpa4qDpCjlSqt3gBJMOa98tC8bRfbPJCS4QVQw3RGC2wtNuCcwm+aWH3osWuBy3QjbeoTjPgzrHgEQOLeFCqFIc8gAEnVEPTUHLymm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738521082; c=relaxed/simple;
	bh=XcUb5AP0TJwdEkn87gzDSt86eEp24w6UPdxJ4r+A3fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=msMpp7anXS6AnZKuAn4c5GQaglnTGqg4ZcYlw5g2sQFSz/kvft6E7ej6DdNpHdSNad0R+CrjzOA7sNzLIQUSvqU3pcq0MBXy/2vYTCsEFGUgkypXd9YOXxRZ0pKfHNHRpR1+sadHTx4HUvNhl3x+WZgqHKF7WY8FkqmJl+aS5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3cffe6b867fso52382975ab.2
        for <linux-ext4@vger.kernel.org>; Sun, 02 Feb 2025 10:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738521079; x=1739125879;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXhBuWoRWFoQZifx4KO+M41PHhOTwZgNBj5+jbA++/M=;
        b=Eken1smFSmT14RulVaO0RSOf2FSzQsr6X83kTx9CF7dQYkcukPFyYhvNIeZWC3WI0y
         2OOI86W7B+y/0e/jVdPp6IOYU3zxCe/wY1n/kruflJyX7ukGfG3USz3A4wInh0w2p6vN
         E0myrzcVcEGEsb40LZfMIkzkh1IJ+7k2+VMGk5eRd3O78fbukdUK3XTECoD+iuJy1e3K
         n7+e2TbUipwvlvL3C4adPnM4OTfj8Qwtiv7gZvlkycoOMG+VCHSVskO2ly/JFuJXCBNY
         V1yHmzaaZ18CzIiC4LXrk1qKHWnG4xxAo22FOY8Gd4pA6XBQgskg1YVoYFLQiA7dNn1W
         8fqA==
X-Forwarded-Encrypted: i=1; AJvYcCUa4/x5DHqGuaGfOjm5XwfKYYgn5PaSCxO7d/A9n7ue6mUUJGDBCLFR9BgFKTzTuoXtitEHdQzaZSNc@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsdpgfwLUTf6FTy2OZ9lEUUKjnp30cVLq8yAZEYzJ0Cd31CVY
	lMfYbdzdt9wad/jcaYkpUuVxuZJ3k6+Kj+JfNddgoKMS8YfLLpVyCR9ZIRL1BPA01ROrtW1JS9Z
	VQyxnM1zDk4gWEGgRrC+Aqpqi5V/Vsk/S6YKJoP4AQJMTP1kIogGUP60=
X-Google-Smtp-Source: AGHT+IFF4/AZA0qkuXMtFIFZrwBV859uuWEKScN/8+KqUVSuXQ+6ad9n7MTE7h+VeiA3Fnx0UU65O+vZOB8HA0NaPkrOtZ6Uo93M
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c567:0:b0:3cf:fb97:c313 with SMTP id
 e9e14a558f8ab-3cffe4679dbmr191601835ab.18.1738521079554; Sun, 02 Feb 2025
 10:31:19 -0800 (PST)
Date: Sun, 02 Feb 2025 10:31:19 -0800
In-Reply-To: <67423e2b.050a0220.1cc393.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679fb9f7.050a0220.d7c5a.0075.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in do_get_write_access (3)
From: syzbot <syzbot+e7c786ece54bad9d1e43@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132935f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d83cc1742b7377
dashboard link: https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10809724580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132f03df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d07b0558b0e/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5e2250eb3b1/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e676d17effc/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7c786ece54bad9d1e43@syzkaller.appspotmail.com

INFO: task kworker/u8:5:76 blocked for more than 143 seconds.
      Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:23760 pid:76    tgid:76    ppid:2      task_flags:0x4248060 flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0xf43/0x5890 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6856
 io_schedule+0xbf/0x130 kernel/sched/core.c:7689
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:247
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:105 [inline]
 do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
 jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x6a/0x340 fs/ext4/ext4_jbd2.c:239
 ext4_reserve_inode_write+0x13b/0x270 fs/ext4/inode.c:5831
 __ext4_mark_inode_dirty+0x1ab/0x860 fs/ext4/inode.c:6005
 __ext4_ext_dirty+0x1a8/0x220 fs/ext4/extents.c:207
 ext4_ext_insert_extent+0x12c7/0x3e70 fs/ext4/extents.c:2190
 ext4_ext_map_blocks+0x2044/0x5ab0 fs/ext4/extents.c:4400
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x457/0x1370 fs/ext4/inode.c:702
 mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
 ext4_do_writepages+0x198d/0x32d0 fs/ext4/inode.c:2735
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2824
 do_writepages+0x1b3/0x820 mm/page-writeback.c:2687
 __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x606/0xfa0 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2047
 wb_writeback+0x803/0xb80 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0x8c0/0xbc0 fs/fs-writeback.c:2343
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task jbd2/sda1-8:5171 blocked for more than 144 seconds.
      Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D stack:26432 pid:5171  tgid:5171  ppid:2      task_flags:0x240040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0xf43/0x5890 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6856
 io_schedule+0xbf/0x130 kernel/sched/core.c:7689
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:247
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:105 [inline]
 __wait_on_buffer+0x64/0x70 fs/buffer.c:123
 wait_on_buffer include/linux/buffer_head.h:414 [inline]
 jbd2_journal_commit_transaction+0x3823/0x6760 fs/jbd2/commit.c:810
 kjournald2+0x1f8/0x760 fs/jbd2/journal.c:201
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1bc080 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bc080 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bc080 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6746
6 locks held by kworker/u8:5/76:
 #0: ffff88801eac1148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3211
 #1: ffffc9000216fd18 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3212
 #2: ffff88814e6840e0 (&type->s_umount_key#31){++++}-{4:4}, at: super_trylock_shared+0x1e/0xf0 fs/super.c:562
 #3: ffff88814e686b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1b3/0x820 mm/page-writeback.c:2687
 #4: ffff88814e690950 (jbd2_handle){.+.+}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
 #5: ffff888053bfef80 (&ei->i_data_sem){++++}-{4:4}, at: ext4_map_blocks+0x352/0x1370 fs/ext4/inode.c:701
2 locks held by getty/5595:
 #0: ffff8880351f20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
2 locks held by syz-executor350/13863:
 #0: ffff8880b873ed18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
 #1: ffff8880b8728a88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x203/0x8e0 kernel/sched/psi.c:975

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0xf62/0x12b0 kernel/hung_task.c:399
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 13875 Comm: syz-executor350 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:file_set_fsnotify_mode+0xe/0x5d0 fs/notify/fsnotify.c:652
Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 41 57 41 56 41 55 41 54 55 53 <48> 89 fb 48 83 ec 10 e8 76 b6 76 ff 48 8d bb 88 00 00 00 48 b8 00
RSP: 0018:ffffc900032e79c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88802fc64c40 RCX: ffffffff822b6e68
RDX: ffff888021b99e00 RSI: ffffffff822b6e76 RDI: ffff88802fc64c40
RBP: ffff888077665038 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802fc64c88
R13: ffff88802fc64cc8 R14: 0000000000000000 R15: ffff88802fc64c90
FS:  0000555583826380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cf9a1a01d CR3: 000000002a1c8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 do_dentry_open+0x59e/0x1c40 fs/open.c:941
 vfs_open+0x82/0x3f0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1e88/0x2d80 fs/namei.c:3989
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1453
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cf99d0ae1
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 8a 85 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffd1d04c410 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007f6cf99d0ae1
RDX: 0000000000080001 RSI: 00007f6cf9a1a022 RDI: 00000000ffffff9c
RBP: 00007f6cf9a1a022 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd1d04c4b0
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.450 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

