Return-Path: <linux-ext4+bounces-6340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B0A29BA4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 22:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C962E167F01
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00656214A6D;
	Wed,  5 Feb 2025 21:10:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5D211A11
	for <linux-ext4@vger.kernel.org>; Wed,  5 Feb 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789820; cv=none; b=JYk/4wCAYV4C0TdFgsehxGS7AOQml0ye6UxbdWDyT7KxIkGnc8NBDApUOXAOLO9Mzel7zZZMimQ2QQU4UjKwrWc/4YiDnQva9wXXcWXWQ5AR25UlDKtYNvbKqiM0f3ME6Z3jy8SxG/awHhUxqq7UJcnJZ89xF9VUiR1NylYRTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789820; c=relaxed/simple;
	bh=vYOcD7rhpGmtm3XUW63CkQNsHfKm0kQtTFTg59GN+30=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GmZR4YypmBnBDYyaGjro9PmnQPyycJxCSlxIlE+skAfwpU/ZEjfIFyt7bj5uqDuBQLS82dDPGjkKgL30h7XGceee67wZpb36ETKpopk9V7ZTo1TrVuIxaIK9pAdfdNonEHmSG9nfwcHm8mzWnltPiyUnx6WNZIVbrGRz5rHk6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d057805941so3937135ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2025 13:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789818; x=1739394618;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gC+NsQB9BaWxUyUOlNn9ow4nyoc/KNneTLYl8npJro8=;
        b=Y8rpzWHe8oV6EknfOivxwGOoykaIoo3qdDhw3Appn6DfTzsfl70bpiD+MNafzX6ugC
         +68oiefxWeyV6nA4sYP+KNEvec4waAV0xB9zOgQ0+HuP0tDVjadXSJ7qZxOgK2UmloGS
         ENQK56gttUjPdCuJ0U2YaMUvIfDBsaljPjjD5jQ7MCRCQgkyrD5QbTsxuHSZJzGbHxSJ
         U7wMjjmndvfL0uBQ9ZpFqoX2qWFBIADlSkFDl61mQzkneO8Zy/THSBe001nk3iPuT9EN
         amc91zSJ3DljSTTzkxRsKUmI2C3Gjp0kV5VcJydoHnTW6JgifoMXksZeUv2UvepbteKx
         087A==
X-Forwarded-Encrypted: i=1; AJvYcCVcL90QaGHFCIbGzG6ud7/wgHSbfyvID2f+5U4ND0Kh5TeLeKKwDSl3h2Y5yoAQIXNypqbvP3Ra+nJH@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQpeiRt41CTNK9qYbWk7wcaqS02C4mlq1dLkfvvFsvkemdKg1
	1WhDVXAtf9IOZ0WDNzXt9Z0D0QxsiGWbo2QeRbxGugMHF65/EwlxABZJwr6BBxoa5g3HOK1gyEF
	VlOCihKUPkwiKynJk+TJahF8dnAdMankJPZ8UzSgRXxseCJ4TQgxBea4=
X-Google-Smtp-Source: AGHT+IGF7Wd6MDWq3r64xNG75X64vtyJ/WtRsKCc6wHW9S1owhcHXBKnT+O9esJRNyB5HoPlgPYG8PdWSNyzcO3aWaj43kZ33unc
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:3cf:c7bc:4523 with SMTP id
 e9e14a558f8ab-3d05a5b493cmr7175125ab.6.1738789817871; Wed, 05 Feb 2025
 13:10:17 -0800 (PST)
Date: Wed, 05 Feb 2025 13:10:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a3d3b9.050a0220.19061f.05ed.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode (3)
From: syzbot <syzbot+dcbb6d5fad7fa4c81139@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14284eb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=dcbb6d5fad7fa4c81139
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13502d18580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c358838d66a/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29a6852a21ee/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb214c6e7c43/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b7a4167b060b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcbb6d5fad7fa4c81139@syzkaller.appspotmail.com

INFO: task syz.1.2697:16598 blocked for more than 143 seconds.
      Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.2697      state:D stack:22944 pid:16598 tgid:16595 ppid:5964   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6856
 mb_cache_entry_wait_unused+0x166/0x250 fs/mbcache.c:148
 ext4_evict_ea_inode+0x14a/0x2f0 fs/ext4/xattr.c:480
 ext4_evict_inode+0x194/0xf50 fs/ext4/inode.c:185
 evict+0x4ea/0x9a0 fs/inode.c:796
 ext4_xattr_ibody_set+0x590/0x730 fs/ext4/xattr.c:2287
 ext4_xattr_set_handle+0xba6/0x1580 fs/ext4/xattr.c:2446
 ext4_xattr_set+0x280/0x3e0 fs/ext4/xattr.c:2560
 __vfs_setxattr+0x46a/0x4a0 fs/xattr.c:200
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
RIP: 0033:0x7f35bf18cda9
RSP: 002b:00007f35bffc8038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f35bf3a5fa0 RCX: 00007f35bf18cda9
RDX: 0000000020001400 RSI: 00000000200001c0 RDI: 00000000200003c0
RBP: 00007f35bf20e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f35bf3a5fa0 R15: 00007ffea2505538
 </TASK>
INFO: task syz.1.2697:16609 blocked for more than 143 seconds.
      Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.2697      state:D stack:26384 pid:16609 tgid:16595 ppid:5964   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6856
 __wait_on_freeing_inode+0x1c7/0x2f0 fs/inode.c:2502
 find_inode_fast+0x2ab/0x480 fs/inode.c:1103
 iget_locked+0x96/0x5a0 fs/inode.c:1475
 __ext4_iget+0x25e/0x3fe0 fs/ext4/inode.c:4760
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1548 [inline]
 ext4_xattr_inode_lookup_create+0x3b1/0x1c90 fs/ext4/xattr.c:1587
 ext4_xattr_ibody_set+0x214/0x730 fs/ext4/xattr.c:2269
 ext4_xattr_set_handle+0xba6/0x1580 fs/ext4/xattr.c:2446
 ext4_xattr_set+0x280/0x3e0 fs/ext4/xattr.c:2560
 __vfs_setxattr+0x46a/0x4a0 fs/xattr.c:200
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
RIP: 0033:0x7f35bf18cda9
RSP: 002b:00007f35bffa7038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f35bf3a6080 RCX: 00007f35bf18cda9
RDX: 0000000020001400 RSI: 00000000200001c0 RDI: 0000000020000380
RBP: 00007f35bf20e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f35bf3a6080 R15: 00007ffea2505538
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
 #0: ffffffff8e93dc78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:334 [inline]
 #0: ffffffff8e93dc78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:996
3 locks held by kworker/u8:0/11:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc90000107c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000107c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:285
2 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e9387a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e9387a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e9387a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
3 locks held by kworker/u8:3/36:
5 locks held by kworker/u8:4/64:
2 locks held by kworker/u8:6/1328:
1 lock held by udevd/5202:
2 locks held by dhcpcd/5496:
 #0: ffff8880121426c8 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2397
 #1: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6779
2 locks held by getty/5590:
 #0: ffff88814dcc60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by udevd/6016:
 #0: ffff888148d3e540 (mapping.invalidate_lock#2){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:920 [inline]
 #0: ffff888148d3e540 (mapping.invalidate_lock#2){.+.+}-{4:4}, at: filemap_update_page mm/filemap.c:2440 [inline]
 #0: ffff888148d3e540 (mapping.invalidate_lock#2){.+.+}-{4:4}, at: filemap_get_pages+0xb24/0x1fb0 mm/filemap.c:2602
5 locks held by kworker/u8:9/7617:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc9000bb07c60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000bb07c60 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffffffff8fcb2bd0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x17a/0xd60 net/core/net_namespace.c:606
 #3: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xe9/0xaa0 net/core/dev.c:12323
 #4: ffffffff8e93dc78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:334 [inline]
 #4: ffffffff8e93dc78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:996
3 locks held by syz.1.2697/16598:
 #0: ffff88805cf4c420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:547
 #1: ffff88806dead338 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:865 [inline]
 #1: ffff88806dead338 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff88806dead008 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 #2: ffff88806dead008 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x277/0x1580 fs/ext4/xattr.c:2373
3 locks held by syz.1.2697/16609:
 #0: ffff88805cf4c420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:547
 #1: ffff88805874c950 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:865 [inline]
 #1: ffff88805874c950 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff88805874c620 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 #2: ffff88805874c620 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x277/0x1580 fs/ext4/xattr.c:2373
1 lock held by syz-executor/23600:
 #0: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #0: ffffffff8fcbf148 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xce2/0x2210 net/core/rtnetlink.c:4020

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7ab/0x920 kernel/kthread.c:464
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: bat_events batadv_tt_purge
RIP: 0010:trace_irq_enable+0x3d/0x120 include/trace/events/preemptirq.h:40
Code: 48 89 d8 48 c1 e8 06 48 8d 3c c5 70 40 1b 90 be 08 00 00 00 e8 e4 d3 5e 00 48 0f a3 1d 1c 10 54 0e 73 12 e8 25 06 de ff 84 c0 <75> 09 80 3d c5 25 3e 0e 00 74 0e 5b 41 5e e9 9b 10 49 ff 90 0f 0b
RSP: 0018:ffffc90000117920 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81c7304c
RDX: 0000000000000000 RSI: ffffffff8c608040 RDI: ffffffff8c608000
RBP: ffffc900001179f8 R08: ffffffff901b4077 R09: 1ffffffff203680e
R10: dffffc0000000000 R11: fffffbfff203680f R12: dffffc0000000000
R13: 1ffff92000022f30 R14: ffffc90000117980 R15: 0000000000000201
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556c57d588 CR3: 000000007fcae000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 trace_hardirqs_on+0x18/0x40 kernel/trace/trace_preemptirq.c:73
 __local_bh_enable_ip+0x168/0x200 kernel/softirq.c:394
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_tt_local_purge+0x2a0/0x340 net/batman-adv/translation-table.c:1315
 batadv_tt_purge+0x35/0xa40 net/batman-adv/translation-table.c:3509
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7ab/0x920 kernel/kthread.c:464
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:148
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

