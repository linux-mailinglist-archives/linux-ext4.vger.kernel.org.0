Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33533437F09
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Oct 2021 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhJVUEq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Oct 2021 16:04:46 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49854 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhJVUEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Oct 2021 16:04:46 -0400
Received: by mail-il1-f200.google.com with SMTP id e10-20020a92194a000000b00258acd999afso3153636ilm.16
        for <linux-ext4@vger.kernel.org>; Fri, 22 Oct 2021 13:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K0CA4DbXhnS18bYrOqDfpinqPZ1ed4dX5SXvxg+qWqE=;
        b=AqIZZ1r54dOHf6Tf3RePXy9kTSSvSoo8LRIk0ySIbx6klIlkf2KKm+l5MwJH8MiNQd
         /Wv124R8rAo7rT7Ab0FYGMxtvXPZSrpALD6n0PAlEEOEkIi6RY85EDsxXV4Fn9Z7R9Yv
         KP7JKz905k2RJjHFvNLKrR+oECxXZau9Q8q5+SAXuJLu0am0OEwjlLrbzl/E6c0QWI4p
         SAm/AiygkPmM8OB5lmvHNs5YJQvuWku1A5GquOB+4xtzbabmOtOiS+OBDbXmz2Rh12ww
         0bXdM3hTB8BCcjDo2RMDvRtm8wEDloVwuTswO/3bWwfFuRa6lRzeYrGzuDPT400WpfFC
         c8MQ==
X-Gm-Message-State: AOAM5306yn2TPcRzAjIGZnoRYwCqAte20UQ7BZ09aRwxVZrXPZl9V0uB
        2dms14Zc8QGvGdxn+yymzUmIRDu03p9KT2x7OaVOF6EWKInT
X-Google-Smtp-Source: ABdhPJxqo7WwlOlr26McEz7XqSGXvVZ7DRb1WBomtRwTnGNNB2FyjbqHSJaFwgKquMJqI49cvvbhLuxs5c3tcyazKHQejFZ9A63R
MIME-Version: 1.0
X-Received: by 2002:a6b:8dd6:: with SMTP id p205mr1104340iod.192.1634932948052;
 Fri, 22 Oct 2021 13:02:28 -0700 (PDT)
Date:   Fri, 22 Oct 2021 13:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099afce05cef67da8@google.com>
Subject: [syzbot] possible deadlock in ext4_xattr_set_handle
From:   syzbot <syzbot+151cb6793a95b59e826d@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    519d81956ee2 Linux 5.15-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144b3d42b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3b8275c629a0586
dashboard link: https://syzkaller.appspot.com/bug?extid=151cb6793a95b59e826d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+151cb6793a95b59e826d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/20558 is trying to acquire lock:
ffffffff8ba9ef80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:198 [inline]
ffffffff8ba9ef80 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:492 [inline]
ffffffff8ba9ef80 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slab.c:3222 [inline]
ffffffff8ba9ef80 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_trace+0x4a/0x5d0 mm/slab.c:3617

but task is already holding lock:
ffff8880241e7488 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
ffff8880241e7488 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2294

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x92/0x150 kernel/locking/rwsem.c:1517
       ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
       ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2294
       ext4_initxattrs+0xb5/0x120 fs/ext4/xattr_security.c:44
       security_inode_init_security+0x1c4/0x370 security/security.c:1099
       __ext4_new_inode+0x472b/0x5ba0 fs/ext4/ialloc.c:1325
       ext4_create+0x2d6/0x4d0 fs/ext4/namei.c:2746
       lookup_open.isra.0+0xfe4/0x13d0 fs/namei.c:3282
       open_last_lookups fs/namei.c:3352 [inline]
       path_openat+0x9a5/0x2740 fs/namei.c:3558
       do_filp_open+0x1aa/0x400 fs/namei.c:3588
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_openat fs/open.c:1232 [inline]
       __se_sys_openat fs/open.c:1227 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfb7/0x1390 fs/jbd2/transaction.c:468
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:525
       __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
       ext4_sample_last_mounted fs/ext4/file.c:821 [inline]
       ext4_file_open+0x5f3/0xb60 fs/ext4/file.c:850
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3428 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3561
       do_filp_open+0x1aa/0x400 fs/namei.c:3588
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_openat fs/open.c:1232 [inline]
       __se_sys_openat fs/open.c:1227 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1812 [inline]
       sb_start_intwrite include/linux/fs.h:1929 [inline]
       ext4_evict_inode+0xe78/0x1950 fs/ext4/inode.c:241
       evict+0x2ed/0x6b0 fs/inode.c:588
       iput_final fs/inode.c:1664 [inline]
       iput.part.0+0x539/0x850 fs/inode.c:1690
       iput+0x58/0x70 fs/inode.c:1680
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:376
       __dentry_kill+0x3c0/0x640 fs/dcache.c:582
       dentry_kill fs/dcache.c:720 [inline]
       dput+0x66b/0xbc0 fs/dcache.c:888
       ovl_entry_stack_free fs/overlayfs/super.c:61 [inline]
       ovl_dentry_release+0xca/0x130 fs/overlayfs/super.c:74
       __dentry_kill+0x42b/0x640 fs/dcache.c:587
       shrink_dentry_list+0x128/0x490 fs/dcache.c:1176
       prune_dcache_sb+0xe7/0x140 fs/dcache.c:1257
       super_cache_scan+0x336/0x590 fs/super.c:105
       do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:758
       shrink_slab_memcg mm/vmscan.c:827 [inline]
       shrink_slab+0x3e4/0x6e0 mm/vmscan.c:906
       shrink_node_memcgs mm/vmscan.c:3018 [inline]
       shrink_node+0x8c1/0x1eb0 mm/vmscan.c:3139
       shrink_zones mm/vmscan.c:3342 [inline]
       do_try_to_free_pages+0x386/0x1480 mm/vmscan.c:3397
       try_to_free_pages+0x29f/0x750 mm/vmscan.c:3632
       __perform_reclaim mm/page_alloc.c:4592 [inline]
       __alloc_pages_direct_reclaim mm/page_alloc.c:4613 [inline]
       __alloc_pages_slowpath.constprop.0+0x828/0x21b0 mm/page_alloc.c:5017
       __alloc_pages+0x412/0x500 mm/page_alloc.c:5388
       alloc_migration_target+0x4e8/0x7e0 mm/migrate.c:1640
       unmap_and_move mm/migrate.c:1207 [inline]
       migrate_pages+0x8aa/0x39e0 mm/migrate.c:1488
       do_move_pages_to_node mm/migrate.c:1670 [inline]
       move_pages_and_store_status.isra.0+0xf4/0x230 mm/migrate.c:1760
       do_pages_move mm/migrate.c:1856 [inline]
       kernel_move_pages+0x9d4/0x1580 mm/migrate.c:2033
       __do_sys_move_pages mm/migrate.c:2047 [inline]
       __se_sys_move_pages mm/migrate.c:2042 [inline]
       __x64_sys_move_pages+0xdd/0x1b0 mm/migrate.c:2042
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __fs_reclaim_acquire mm/page_alloc.c:4539 [inline]
       fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4553
       might_alloc include/linux/sched/mm.h:198 [inline]
       slab_pre_alloc_hook mm/slab.h:492 [inline]
       slab_alloc_node mm/slab.c:3222 [inline]
       kmem_cache_alloc_node_trace+0x4a/0x5d0 mm/slab.c:3617
       __do_kmalloc_node mm/slab.c:3639 [inline]
       __kmalloc_node+0x38/0x60 mm/slab.c:3647
       kmalloc_node include/linux/slab.h:614 [inline]
       kvmalloc_node+0xb4/0x120 mm/util.c:587
       kvmalloc include/linux/mm.h:805 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1472 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1515 [inline]
       ext4_xattr_set_entry+0x1d94/0x3890 fs/ext4/xattr.c:1656
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2210
       ext4_xattr_set_handle+0x964/0x1500 fs/ext4/xattr.c:2367
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2480
       __vfs_setxattr+0x115/0x180 fs/xattr.c:180
       __vfs_setxattr_noperm+0x125/0x5e0 fs/xattr.c:214
       __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:275
       vfs_setxattr+0x13f/0x330 fs/xattr.c:301
       setxattr+0x218/0x2b0 fs/xattr.c:575
       path_setxattr+0x197/0x1c0 fs/xattr.c:595
       __do_sys_setxattr fs/xattr.c:611 [inline]
       __se_sys_setxattr fs/xattr.c:607 [inline]
       __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:607
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

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

3 locks held by syz-executor.2/20558:
 #0: ffff8880772fc460 (sb_writers#6){.+.+}-{0:0}, at: path_setxattr+0xb2/0x1c0 fs/xattr.c:593
 #1: ffff8880241e77b0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: inode_lock include/linux/fs.h:786 [inline]
 #1: ffff8880241e77b0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: vfs_setxattr+0x11c/0x330 fs/xattr.c:300
 #2: ffff8880241e7488 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
 #2: ffff8880241e7488 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2294

stack backtrace:
CPU: 1 PID: 20558 Comm: syz-executor.2 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __fs_reclaim_acquire mm/page_alloc.c:4539 [inline]
 fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4553
 might_alloc include/linux/sched/mm.h:198 [inline]
 slab_pre_alloc_hook mm/slab.h:492 [inline]
 slab_alloc_node mm/slab.c:3222 [inline]
 kmem_cache_alloc_node_trace+0x4a/0x5d0 mm/slab.c:3617
 __do_kmalloc_node mm/slab.c:3639 [inline]
 __kmalloc_node+0x38/0x60 mm/slab.c:3647
 kmalloc_node include/linux/slab.h:614 [inline]
 kvmalloc_node+0xb4/0x120 mm/util.c:587
 kvmalloc include/linux/mm.h:805 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1472 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1515 [inline]
 ext4_xattr_set_entry+0x1d94/0x3890 fs/ext4/xattr.c:1656
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2210
 ext4_xattr_set_handle+0x964/0x1500 fs/ext4/xattr.c:2367
 ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2480
 __vfs_setxattr+0x115/0x180 fs/xattr.c:180
 __vfs_setxattr_noperm+0x125/0x5e0 fs/xattr.c:214
 __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:275
 vfs_setxattr+0x13f/0x330 fs/xattr.c:301
 setxattr+0x218/0x2b0 fs/xattr.c:575
 path_setxattr+0x197/0x1c0 fs/xattr.c:595
 __do_sys_setxattr fs/xattr.c:611 [inline]
 __se_sys_setxattr fs/xattr.c:607 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7d5d80ea39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d5ad63188 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f7d5d912020 RCX: 00007f7d5d80ea39
RDX: 0000000020000380 RSI: 00000000200000c0 RDI: 0000000020000080
RBP: 00007f7d5d868c5f R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000c001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd05b3b40f R14: 00007f7d5ad63300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
