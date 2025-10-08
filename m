Return-Path: <linux-ext4+bounces-10668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE0BC520E
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9D189C642
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA724501E;
	Wed,  8 Oct 2025 13:07:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84625522B
	for <linux-ext4@vger.kernel.org>; Wed,  8 Oct 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928849; cv=none; b=U9hEYvTIXTN5TVGBlM/hCajcHCkK+ifZ4kh+J5zrY6Qk9LQTmNuHIUIqc4MCx5d1OuVPssXmT7SPZRReAk8qm+X7XKnxnGV1JsneuiO+eJ/RI/rvi9y0JnAkVyF9VV80jeLSeu5nm+rp/itVuQYCVCqpP48sq9y0NfucBuRUALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928849; c=relaxed/simple;
	bh=i0lrF19IErTYbbVG+UY1LEim06Ab43fposzYwrg0id4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pUAo3p3/LxuMv8BnIXStLa2aAemfgmj8OjCaRmz9Q80nCPVR9+PzEAh0kJrjqJinwl3UyKHLyue1xoNvYXDXZt9P9f1q5t+GCt9acIraD7vghcekqFLyVEUbwoE2BiglFVBg8GpYdwk0r0VX6obr1yzx0WwQoxV01yCXRWsC+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42594b7f324so21031175ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Oct 2025 06:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928846; x=1760533646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQCSSWeDYUbVW+Ju6kzqoilJ5OIw0y/nQnioY7MchMs=;
        b=bl4SIzPO6lSN+iN6lsLwnqQzTTmyi/KuOsIBjSP7bhWiKE7CzyqzCrv+YTOg8wTjcf
         jb2oCpFfhKbt7+4R7oRV/ly3vtdiMjduK63x6EkVOr1zZYn1IWDVeVslpFU/rsrK0gCi
         p0GqTp2PRiq4ob6y2fqxbsprIld5M0ja0HpqgKtyWBhwf2EmOf7MJ1yxaERsYwQajDo9
         0wcBEdfOcKVLiOx/euMLSwESfr0Yd5jRq4a/ZpidFZbUt8zWDfI73/v/xrkbFW3IWb5F
         yr3h6BAqONBm4rwBuGGgqWAyRiSaKj1Q7gz4AOhpf3vxgAXLDku8na5B/jibP0vzHUER
         sHiA==
X-Forwarded-Encrypted: i=1; AJvYcCWBdHZNuNHf9QWFa0C0w14SLcweJLUvcMPol+v17C4CrmWKEzPzb8DakSZIELbEANR7kZpkpS/YReQh@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUp5QIvmyTmnHtaRFjIHv3IG14YSHO389SqnnEGJclyv5rBv0
	1s90O8mMAwngA5+Mr5TVvfAHPC/0nV9VqaWuGnOBXApe6EEGicyyDTsXrtTvIj0eQcWLuCzse4o
	oPGzgjsXPrVbPTx0i1vVU5Tlqc1WCES0FpTpeY+9XDGDghJ1tITb8ELIpJK8=
X-Google-Smtp-Source: AGHT+IEHLDKnfsjCQYsF9bazIbCdMmwOhnBBRGrKPju1XxQORy3HOk0OyQHK9b5VEOGXL3RL43IAdWGekisM2Ygec5DwhK5TbbQ6
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-42f874727c4mr26322605ab.11.1759928846107; Wed, 08 Oct 2025
 06:07:26 -0700 (PDT)
Date: Wed, 08 Oct 2025 06:07:26 -0700
In-Reply-To: <6768bb8e.050a0220.2f3838.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e6620e.050a0220.256323.003a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in find_inode_fast (4)
From: syzbot <syzbot+fd5533bcd0f7343bb8ca@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    971199ad2a0f Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1503c1e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d115f113a86997de
dashboard link: https://syzkaller.appspot.com/bug?extid=fd5533bcd0f7343bb8ca
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc052f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d3da7c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/406943a8345c/disk-971199ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06d218aee5c4/vmlinux-971199ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56c432aaadf2/bzImage-971199ad.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cc46824d9bfa/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1719f334580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd5533bcd0f7343bb8ca@syzkaller.appspotmail.com

INFO: task syz.1.551:8496 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.551       state:D stack:24424 pid:8496  tgid:8495  ppid:5991   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 __wait_on_freeing_inode+0x1c5/0x2f0 fs/inode.c:2494
 find_inode_fast+0x2b0/0x470 fs/inode.c:1070
 iget_locked+0xaf/0x580 fs/inode.c:1433
 __ext4_iget+0x242/0x41c0 fs/ext4/inode.c:5210
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1545 [inline]
 ext4_xattr_inode_lookup_create+0x438/0x1c20 fs/ext4/xattr.c:1584
 ext4_xattr_ibody_set+0x202/0x6a0 fs/ext4/xattr.c:2263
 ext4_xattr_set_handle+0xc9a/0x1590 fs/ext4/xattr.c:2440
 ext4_xattr_set+0x230/0x320 fs/ext4/xattr.c:2554
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16b/0x2f0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x274/0x600 fs/xattr.c:665
 path_setxattrat+0x364/0x3a0 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdacd18eec9
RSP: 002b:00007fdace024038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fdacd3e5fa0 RCX: 00007fdacd18eec9
RDX: 0000200000001400 RSI: 00002000000001c0 RDI: 0000200000000380
RBP: 00007fdacd211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdacd3e6038 R14: 00007fdacd3e5fa0 R15: 00007fff7468a358
 </TASK>
INFO: task syz.1.551:8508 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.551       state:D stack:26056 pid:8508  tgid:8495  ppid:5991   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 mb_cache_entry_wait_unused+0x165/0x250 fs/mbcache.c:148
 ext4_evict_ea_inode+0x14d/0x2f0 fs/ext4/xattr.c:481
 ext4_evict_inode+0x16f/0xee0 fs/ext4/inode.c:183
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_xattr_ibody_set+0x510/0x6a0 fs/ext4/xattr.c:2281
 ext4_xattr_set_handle+0xc9a/0x1590 fs/ext4/xattr.c:2440
 ext4_xattr_set+0x230/0x320 fs/ext4/xattr.c:2554
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16b/0x2f0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x274/0x600 fs/xattr.c:665
 path_setxattrat+0x364/0x3a0 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdacd18eec9
RSP: 002b:00007fdace003038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fdacd3e6090 RCX: 00007fdacd18eec9
RDX: 0000200000001400 RSI: 00002000000001c0 RDI: 0000200000000200
RBP: 00007fdacd211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdacd3e6128 R14: 00007fdacd3e6090 R15: 00007fff7468a358
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u8:0/12:
1 lock held by ksoftirqd/1/23:
 #0: ffff888024985b18 (&fq->mq_flush_lock){..-.}-{3:3}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
1 lock held by khungtaskd/31:
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5577:
 #0: ffff88814d3930a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036bb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by udevd/5892:
 #0: ffff888140ac0188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_dop_revalidate+0x9e/0x5d0 fs/kernfs/dir.c:1180
2 locks held by syz-executor/5988:
 #0: ffff888024845358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x1a9/0x650 block/bdev.c:1128
 #1: ffff8880b863a058 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
1 lock held by syz-executor/5999:
1 lock held by syz-executor/6000:
1 lock held by syz-executor/6003:
 #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:957
3 locks held by syz.1.551/8496:
 #0: ffff88807b85c420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888058a1ed10 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff888058a1ed10 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: vfs_setxattr+0x144/0x2f0 fs/xattr.c:320
 #2: 
ffff888058a1e9f8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff888058a1e9f8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2367
3 locks held by syz.1.551/8508:
 #0: ffff88807b85c420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888058a02a20 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff888058a02a20 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: vfs_setxattr+0x144/0x2f0 fs/xattr.c:320
 #2: ffff888058a02708 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 #2: ffff888058a02708 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2367
3 locks held by syz.0.1661/13268:
1 lock held by syz.3.1660/13273:
1 lock held by syz.6.1659/13274:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 13273 Comm: syz.3.1660 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 6e 6e a4 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 cf 0c 0a fd 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 55 1b f5 fb cc 44 89 f9 80 e1 07
RSP: 0018:ffffc9000e50f270 EFLAGS: 00000002
RAX: 1ffffffff33a2900 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffffff99d14e70 R08: ffff8880240a0237 R09: 1ffff11004814046
R10: dffffc0000000000 R11: ffffffff851b2530 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff99d14be0 R15: 0000000000000000
FS:  00007f6d1fcb56c0(0000) GS:ffff888125e12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1b77495000 CR3: 0000000026505000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1a1/0x2f0 drivers/tty/serial/8250/8250_port.c:1961
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3234 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3257 [inline]
 serial8250_console_write+0x134c/0x1ba0 drivers/tty/serial/8250/8250_port.c:3342
 console_emit_next_record kernel/printk/printk.c:3111 [inline]
 console_flush_all+0x6f3/0xb10 kernel/printk/printk.c:3199
 __console_flush_and_unlock kernel/printk/printk.c:3258 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3298
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 __ext4_msg+0x20a/0x2a0 fs/ext4/super.c:992
 ext4_parse_param+0x3b3/0x24c0 fs/ext4/super.c:-1
 vfs_parse_fs_param+0x1a9/0x420 fs/fs_context.c:146
 vfs_parse_fs_qstr fs/fs_context.c:187 [inline]
 vfs_parse_fs_string include/linux/fs_context.h:142 [inline]
 vfs_parse_monolithic_sep+0x25d/0x320 fs/fs_context.c:227
 do_new_mount+0x2cb/0xa10 fs/namespace.c:3723
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d1ed9066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d1fcb4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6d1fcb4ef0 RCX: 00007f6d1ed9066a
RDX: 0000200000000040 RSI: 0000200000000140 RDI: 00007f6d1fcb4eb0
RBP: 0000200000000040 R08: 00007f6d1fcb4ef0 R09: 0000000000200044
R10: 0000000000200044 R11: 0000000000000246 R12: 0000200000000140
R13: 00007f6d1fcb4eb0 R14: 000000000000056a R15: 000000000000002c
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

