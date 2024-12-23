Return-Path: <linux-ext4+bounces-5837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDA9FA8EC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 02:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7343A1883146
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 01:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51054DDC3;
	Mon, 23 Dec 2024 01:23:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DA746E
	for <linux-ext4@vger.kernel.org>; Mon, 23 Dec 2024 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917011; cv=none; b=GJ6yvVmmjCO7SklIZDH6Ywqld1YF8tV73A/41tQv3LkWyYuJpD1OkXvhfMrrBWjrbX4CWe+5V+sUEHOIUehrXPKVu4BtOH2fxJcwubUXuwSeKL84Y483FCS19ezpuJ4clq8g8A5hkUAVQJQGxO4+eOAjVmTReblDtuutM3MHC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917011; c=relaxed/simple;
	bh=6S0IRCIwXcOCUzvDSF1i6aBxqDRyJ0V7nR62abo+WwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aFK7LrboCmpbvWpc2KwJiiRkpnPAlnTNkahJvbKECvCrTIJ8T7ACEpB8UmU+EQ4CtD0m86nNMXAfHUo3lBfK4gRY899ox5Rvjmyk3rYtolhl5TYipJ+vHySHVMhikU3hyPPjxI6JiyfhfhPAR5mRHEOnYR1rioRBj4+yHZM6vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a814406be9so71158155ab.1
        for <linux-ext4@vger.kernel.org>; Sun, 22 Dec 2024 17:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734917006; x=1735521806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfVjyUM/Exrz8Kvuz06jUHAOZTqmwup1gBtk3xIpndg=;
        b=BORTOZyl986/zuZgK0t0eTG5ltbbQrLlAomWKZHnSXIpAuNUYge+AxRdgjFIE/K0qw
         kaeAAe3bYywVj1TF5L9OywFHIR5eZY3cNhYSbmX14H/XWUueoT60c5wdOeewTKX4rd+l
         V0KsVuZjG5utZPlBSZgAj11oRNaKitDZkHj6Hqy/MJ7maVpOYdXSQn4iB7B1OaBmFLVe
         6FT+nvaRPkz1YL3+Rmf9nVj5orzvcul2M2dqKPw5P3en/2pVBVFuio611NB8LwNdNkdK
         LF/6o1Qulvowk7nQH3McopvM0v7GJjw9SxmM6PZ0e1yG0OvJn6t5Ge3txqMCqvdNFDCL
         yLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjTvPcNA2dkoM4ud3wzW3AZ7U9ayfQTsgMetyRY0ZmFReUYH/En8PwJjy3MbA9DkecvqKrAoXGoreZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXkf79Q2ozf1H8C1WS8Ri315fJEpxDsmFOI26lbFK/81F2T2T
	UDBuVxumutbje1kXeIqL/UXElQQSnIpThPEluKMo80lpPMmXXChsoQCGaVINkzQArMbWftnyAx9
	S9pFoociZOcJQDe3wEzCpfhJLM4D1LSc01PWEGXa0Fh7KNJfc+gI+BXY=
X-Google-Smtp-Source: AGHT+IE/VOWbO710TS+59nPa+dJdIWOAk6z42Ir0w8g5nwISOX/Kndcr+VjeDUS1RmeEJTssseRJauFE+Wnw+C2aOSDLjVvrSj2C
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cf:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3c2d257934dmr106963565ab.9.1734917006199; Sun, 22 Dec 2024
 17:23:26 -0800 (PST)
Date: Sun, 22 Dec 2024 17:23:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6768bb8e.050a0220.2f3838.0012.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in find_inode_fast (4)
From: syzbot <syzbot+fd5533bcd0f7343bb8ca@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa366f1b6e3 Add linux-next specific files for 20241218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159f6f44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26a4b4cc7f877b28
dashboard link: https://syzkaller.appspot.com/bug?extid=fd5533bcd0f7343bb8ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b822df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76406ccde331/disk-7fa366f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c56a285987/vmlinux-7fa366f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d20cf0cd8a/bzImage-7fa366f1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2782fc07dd62/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd5533bcd0f7343bb8ca@syzkaller.appspotmail.com

INFO: task syz.1.1247:10997 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1247      state:D stack:23416 pid:10997 tgid:10996 ppid:5936   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 __wait_on_freeing_inode+0x1c7/0x2f0 fs/inode.c:2502
 find_inode_fast+0x2ab/0x480 fs/inode.c:1103
 iget_locked+0x96/0x5a0 fs/inode.c:1475
 __ext4_iget+0x25e/0x3fe0 fs/ext4/inode.c:4760
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1548 [inline]
 ext4_xattr_inode_lookup_create+0x3b1/0x1c90 fs/ext4/xattr.c:1587
 ext4_xattr_block_set+0x272/0x3160 fs/ext4/xattr.c:1916
 ext4_xattr_set_handle+0xce0/0x1580 fs/ext4/xattr.c:2458
 ext4_xattr_set+0x280/0x3e0 fs/ext4/xattr.c:2560
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25b4b85d29
RSP: 002b:00007f25b5a9b038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f25b4d75fa0 RCX: 00007f25b4b85d29
RDX: 0000000020001400 RSI: 00000000200001c0 RDI: 0000000020000200
RBP: 00007f25b4c01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f25b4d75fa0 R15: 00007ffc3db80438
 </TASK>
INFO: task syz.1.1247:11010 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1247      state:D stack:25968 pid:11010 tgid:10996 ppid:5936   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 mb_cache_entry_wait_unused+0x166/0x250 fs/mbcache.c:148
 ext4_evict_ea_inode+0x14a/0x2f0 fs/ext4/xattr.c:480
 ext4_evict_inode+0x194/0xf50 fs/ext4/inode.c:185
 evict+0x4e8/0x9a0 fs/inode.c:796
 ext4_xattr_set_entry+0x17f2/0x1f60 fs/ext4/xattr.c:1847
 ext4_xattr_block_set+0x19fa/0x3160 fs/ext4/xattr.c:1959
 ext4_xattr_set_handle+0xf89/0x1580 fs/ext4/xattr.c:2449
 ext4_xattr_set+0x280/0x3e0 fs/ext4/xattr.c:2560
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25b4b85d29
RSP: 002b:00007f25b5a7a038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f25b4d76080 RCX: 00007f25b4b85d29
RDX: 0000000020000280 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007f25b4c01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000001b R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f25b4d76080 R15: 00007ffc3db80438
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
 #0: ffffffff8e93d1f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e93d1f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
3 locks held by kworker/u8:0/11:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000107c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000107c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
1 lock held by khungtaskd/30:
 #0: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
4 locks held by kworker/u8:2/35:
 #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000ab7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcab410 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x16a/0xd50 net/core/net_namespace.c:602
 #3: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1669
3 locks held by kworker/u8:3/51:
1 lock held by dhcpcd/5500:
 #0: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x31a/0x1ac0 net/ipv4/devinet.c:1129
2 locks held by getty/5588:
 #0: ffff88814dc720a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by syz.1.1247/10997:
 #0: ffff888064ac6420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff88807f3db580 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff88807f3db580 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff88807f3db250 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 #2: ffff88807f3db250 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x277/0x1580 fs/ext4/xattr.c:2373
3 locks held by syz.1.1247/11010:
 #0: ffff888064ac6420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff8880770cb580 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff8880770cb580 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff8880770cb250 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 #2: ffff8880770cb250 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x277/0x1580 fs/ext4/xattr.c:2373
3 locks held by syz-executor/17768:
 #0: ffffffff8f465a40 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8f465a40 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8f465a40 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
 #1: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
 #1: ffffffff8fcb78c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xbcb/0x2150 net/core/rtnetlink.c:4010
 #2: ffffffff8e93d1f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #2: ffffffff8e93d1f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 17997 Comm: syz.5.2995 Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:409
Code: 30 97 49 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 11 0c b0 fc 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c
RSP: 0018:ffffc90004a8eb18 EFLAGS: 00000002
RAX: 1ffffffff34e3c00 RBX: ffffffff9a71e060 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff85759916 R09: 1ffff11004923046
R10: dffffc0000000000 R11: ffffffff857598d0 R12: dffffc0000000000
R13: ffffffff9a418f30 R14: 00000000000003fd R15: dffffc0000000000
FS:  00007f4547f756c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f453de7f000 CR3: 000000007faac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2088 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3335 [inline]
 serial8250_console_write+0x1373/0x1ed0 drivers/tty/serial/8250/8250_port.c:3413
 console_emit_next_record kernel/printk/printk.c:3122 [inline]
 console_flush_all+0x869/0xeb0 kernel/printk/printk.c:3210
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 set_capacity_and_notify+0x1ae/0x240 block/genhd.c:86
 loop_set_size+0x44/0xb0 drivers/block/loop.c:232
 loop_configure+0x9ec/0xeb0 drivers/block/loop.c:1101
 lo_ioctl+0x846/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f454718592b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f4547f74dc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f454718592b
RDX: 0000000000000003 RSI: 0000000000004c00 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000564
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f4547f74ef0 R14: 00007f4547f74eb0 R15: 00007f453de00000
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

