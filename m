Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2031830C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBKB0F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Feb 2021 20:26:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39458 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBKB0A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Feb 2021 20:26:00 -0500
Received: by mail-io1-f70.google.com with SMTP id r140so4124704iod.6
        for <linux-ext4@vger.kernel.org>; Wed, 10 Feb 2021 17:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bucdl9qLgWxIaUXn6aXF56fRpOSbYgHtg+698czooKc=;
        b=WfoQfDes7lKg8QjiLJDTj74pPRC3AbH6QfO4XClhOaY7YEc0G9I+S7XFHXfACPqXEh
         Y/EmIEa+ocS9flgZny2F7Lx6C4xKdEQZHB9LkH/DERWHDNb7Hxq3G4mGcrJGu9ztY+rV
         3LIJTFUKMpt+om3p23qlGrF/tpqUwHnl2l6yf0Y66ds/TESjV73jiWRLQOZ/Q8V/U4L9
         uML4HHISJb8whVQo98boeD1M++wYjfv0pDRhtCOSyjemAjT/UmwzSUpp6tgt0FGvsRqD
         quBVeqSD59M64xOQCBqo4XK7p5/Krdr2fWq2NzI8bqd9DJ0fQVutp68iCx/OLXfVozSV
         lEHA==
X-Gm-Message-State: AOAM530rPXRsDO5iUvr5m8AqSYfy7g+6EKTeFy5XB7qtYe9Rb8DvC9jo
        lzIFsTcimpMoYSE1OIMOiSgNyORxHDLo2Ym9hEULPe4tXcMx
X-Google-Smtp-Source: ABdhPJxQskuHg1Zi+7C86ZLRqmaudByKDD4u8WVuts4JLYcNnfUwSD8oPrUYtGYp4M5+WP6Y2YIjQFgc2JIWj17byBy3jWiFOXv1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3491:: with SMTP id t17mr6144607jal.81.1613006719315;
 Wed, 10 Feb 2021 17:25:19 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:25:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086723c05bb056425@google.com>
Subject: possible deadlock in fs_reclaim_acquire (2)
From:   syzbot <syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    825b5991 Merge tag '5.11-rc6-smb3' of git://git.samba.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117927bf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd1f72220b2e57eb
dashboard link: https://syzkaller.appspot.com/bug?extid=a7ab8df042baaf42ae3c
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.11.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/24553 is trying to acquire lock:
ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire+0xf7/0x150 mm/page_alloc.c:4348

but task is already holding lock:
ffff888019b6b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
ffff888019b6b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x13e0 fs/ext4/xattr.c:2308

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
       down_read+0x95/0x440 kernel/locking/rwsem.c:1353
       ext4_setattr+0x570/0x1fd0 fs/ext4/inode.c:5375
       notify_change+0xb60/0x10a0 fs/attr.c:336
       chown_common+0x4a9/0x550 fs/open.c:674
       vfs_fchown fs/open.c:741 [inline]
       vfs_fchown fs/open.c:733 [inline]
       ksys_fchown+0x111/0x170 fs/open.c:752
       __do_sys_fchown fs/open.c:760 [inline]
       __se_sys_fchown fs/open.c:758 [inline]
       __x64_sys_fchown+0x6f/0xb0 fs/open.c:758
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfb4/0x1380 fs/jbd2/transaction.c:446
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:503
       __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
       ext4_sample_last_mounted fs/ext4/file.c:804 [inline]
       ext4_file_open+0x613/0xb40 fs/ext4/file.c:832
       do_dentry_open+0x4b9/0x11b0 fs/open.c:817
       do_open fs/namei.c:3254 [inline]
       path_openat+0x1b9a/0x2730 fs/namei.c:3371
       do_filp_open+0x17e/0x3c0 fs/namei.c:3398
       do_open_execat+0x116/0x690 fs/exec.c:913
       bprm_execve fs/exec.c:1801 [inline]
       bprm_execve+0x4be/0x19a0 fs/exec.c:1788
       do_execveat_common+0x626/0x7c0 fs/exec.c:1915
       do_execve fs/exec.c:1983 [inline]
       __do_sys_execve fs/exec.c:2059 [inline]
       __se_sys_execve fs/exec.c:2054 [inline]
       __x64_sys_execve+0x8f/0xc0 fs/exec.c:2054
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1592 [inline]
       sb_start_intwrite include/linux/fs.h:1709 [inline]
       ext4_evict_inode+0xe6f/0x1940 fs/ext4/inode.c:241
       evict+0x2ed/0x6b0 fs/inode.c:577
       iput_final fs/inode.c:1653 [inline]
       iput.part.0+0x57e/0x810 fs/inode.c:1679
       iput fs/inode.c:1669 [inline]
       inode_lru_isolate+0x301/0x4f0 fs/inode.c:778
       __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
       list_lru_walk_one+0x99/0xd0 mm/list_lru.c:266
       list_lru_shrink_walk include/linux/list_lru.h:195 [inline]
       prune_icache_sb+0xdc/0x140 fs/inode.c:803
       super_cache_scan+0x38d/0x590 fs/super.c:107
       do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
       shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
       shrink_node_memcgs mm/vmscan.c:2665 [inline]
       shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
       kswapd_shrink_node mm/vmscan.c:3523 [inline]
       balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
       kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2868 [inline]
       check_prevs_add kernel/locking/lockdep.c:2993 [inline]
       validate_chain kernel/locking/lockdep.c:3608 [inline]
       __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
       lock_acquire kernel/locking/lockdep.c:5442 [inline]
       lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
       __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
       fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
       might_alloc include/linux/sched/mm.h:193 [inline]
       slab_pre_alloc_hook mm/slab.h:493 [inline]
       slab_alloc_node mm/slub.c:2817 [inline]
       __kmalloc_node+0x5f/0x430 mm/slub.c:4015
       kmalloc_node include/linux/slab.h:575 [inline]
       kvmalloc_node+0x61/0xf0 mm/util.c:587
       kvmalloc include/linux/mm.h:781 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
       ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
       ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
       ext4_xattr_user_set+0xbc/0x100 fs/ext4/xattr_user.c:40
       __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
       __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
       __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
       vfs_setxattr+0x135/0x320 fs/xattr.c:291
       setxattr+0x1ff/0x290 fs/xattr.c:553
       path_setxattr+0x170/0x190 fs/xattr.c:572
       __do_sys_setxattr fs/xattr.c:587 [inline]
       __se_sys_setxattr fs/xattr.c:583 [inline]
       __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:583
       do_syscall_32_irqs_on arch/x86/entry/common.c:77 [inline]
       __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:139
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:164
       entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.3/24553:
 #0: ffff888065bae460 (sb_writers#5){.+.+}-{0:0}, at: path_setxattr+0xb5/0x190 fs/xattr.c:570
 #1: ffff888019b6b688 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: inode_lock include/linux/fs.h:773 [inline]
 #1: ffff888019b6b688 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: vfs_setxattr+0x117/0x320 fs/xattr.c:290
 #2: ffff888019b6b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
 #2: ffff888019b6b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x13e0 fs/ext4/xattr.c:2308

stack backtrace:
CPU: 1 PID: 24553 Comm: syz-executor.3 Not tainted 5.11.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
 check_prev_add kernel/locking/lockdep.c:2868 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
 __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
 fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
 might_alloc include/linux/sched/mm.h:193 [inline]
 slab_pre_alloc_hook mm/slab.h:493 [inline]
 slab_alloc_node mm/slub.c:2817 [inline]
 __kmalloc_node+0x5f/0x430 mm/slub.c:4015
 kmalloc_node include/linux/slab.h:575 [inline]
 kvmalloc_node+0x61/0xf0 mm/util.c:587
 kvmalloc include/linux/mm.h:781 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
 ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
 ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
 ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
 ext4_xattr_user_set+0xbc/0x100 fs/ext4/xattr_user.c:40
 __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
 __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
 __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
 vfs_setxattr+0x135/0x320 fs/xattr.c:291
 setxattr+0x1ff/0x290 fs/xattr.c:553
 path_setxattr+0x170/0x190 fs/xattr.c:572
 __do_sys_setxattr fs/xattr.c:587 [inline]
 __se_sys_setxattr fs/xattr.c:583 [inline]
 __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:583
 do_syscall_32_irqs_on arch/x86/entry/common.c:77 [inline]
 __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:164
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fe7549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f55c05fc EFLAGS: 00000296 ORIG_RAX: 00000000000000e2
RAX: ffffffffffffffda RBX: 00000000200000c0 RCX: 00000000200001c0
RDX: 0000000020001700 RSI: 0000000000000e01 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
