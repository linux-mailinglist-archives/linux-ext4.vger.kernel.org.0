Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B631681D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Feb 2021 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBJNgP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Feb 2021 08:36:15 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43403 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBJNgB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Feb 2021 08:36:01 -0500
Received: by mail-io1-f70.google.com with SMTP id d8so2166317ion.10
        for <linux-ext4@vger.kernel.org>; Wed, 10 Feb 2021 05:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kNxnIzZ5neR9H2UAtt/mBNzMdeD8j+FUzpcQKMPLil0=;
        b=XaSaE8Z/rErQnCH3/pJBKs96GSuq9S9tapkw91Rj0yUpgNtn8Fmu+SQ9Y9JR5kfuk8
         uX8Yf4yVcmX9XfxOkjXF1PVy8APpo1px4VjRrFTzD6cTZtz+hnvwUe7kPJqdaI3Gq8wj
         YqQ3oRa8tIFTiv8ZQsmzDkWtfqtpTWJ++Bf6F2BmKKwzcizfpHuS4h7M/XviFdht4atx
         hcF9r8i06NKNeH82fyZ+GqteaPv5uuVSbpDK7J36ogOlbfloysvTL4sRp5UzcJV/s2Xt
         03z+oQ60aWblDr1kbtPOqwgFp/nkroko79N5Y4jY8KatiG2ofdX8sLM3b5k1OTraqwrC
         dEIw==
X-Gm-Message-State: AOAM533v5nXtbHOiS6srrlQuthCYEmjNju4EEcnbdCnZcRBkytSasBmv
        W1MlPOgZtWf7NNRo8aJqz2tMBOh53Sp+jpGtKQz0izWZm8Gl
X-Google-Smtp-Source: ABdhPJyMrmt/CHXQRRWixWAA0us3GDu/SbuwXtm5kr27RcWCy7HGSjk6w7kOzUNf8n5eesh+5xQxREEMc3gviWExWuu20q9dLDAE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:205:: with SMTP id e5mr3365236jaq.142.1612964118803;
 Wed, 10 Feb 2021 05:35:18 -0800 (PST)
Date:   Wed, 10 Feb 2021 05:35:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000563a0205bafb7970@google.com>
Subject: possible deadlock in start_this_handle (2)
From:   syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e0d27fc Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cbce90d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd1f72220b2e57eb
dashboard link: https://syzkaller.appspot.com/bug?extid=bfdded10ab7dcd7507ae
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.11.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/2246 is trying to acquire lock:
ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444

but task is already holding lock:
ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
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

-> #1 (&ei->xattr_sem){++++}-{3:3}:
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

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2868 [inline]
       check_prevs_add kernel/locking/lockdep.c:2993 [inline]
       validate_chain kernel/locking/lockdep.c:3608 [inline]
       __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
       lock_acquire kernel/locking/lockdep.c:5442 [inline]
       lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
       start_this_handle+0xfb4/0x1380 fs/jbd2/transaction.c:446
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:503
       __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
       ext4_dirty_inode+0xbc/0x130 fs/ext4/inode.c:5951
       __mark_inode_dirty+0x81f/0x1070 fs/fs-writeback.c:2262
       mark_inode_dirty_sync include/linux/fs.h:2186 [inline]
       iput.part.0+0x57/0x810 fs/inode.c:1676
       iput+0x58/0x70 fs/inode.c:1669
       dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:374
       __dentry_kill+0x3c0/0x640 fs/dcache.c:579
       shrink_dentry_list+0x144/0x480 fs/dcache.c:1148
       prune_dcache_sb+0xe7/0x140 fs/dcache.c:1229
       super_cache_scan+0x336/0x590 fs/super.c:105
       do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
       shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
       shrink_node_memcgs mm/vmscan.c:2665 [inline]
       shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
       kswapd_shrink_node mm/vmscan.c:3523 [inline]
       balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
       kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> &ei->xattr_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ei->xattr_sem);
                               lock(fs_reclaim);
  lock(jbd2_handle);

 *** DEADLOCK ***

3 locks held by kswapd0/2246:
 #0: ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
 #1: ffffffff8be507f0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xc7/0x5d0 mm/vmscan.c:662
 #2: ffff8880442660e0 (&type->s_umount_key#38){++++}-{3:3}, at: trylock_super fs/super.c:418 [inline]
 #2: ffff8880442660e0 (&type->s_umount_key#38){++++}-{3:3}, at: super_cache_scan+0x6c/0x590 fs/super.c:80

stack backtrace:
CPU: 0 PID: 2246 Comm: kswapd0 Not tainted 5.11.0-rc6-syzkaller #0
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
 start_this_handle+0xfb4/0x1380 fs/jbd2/transaction.c:446
 jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
 ext4_dirty_inode+0xbc/0x130 fs/ext4/inode.c:5951
 __mark_inode_dirty+0x81f/0x1070 fs/fs-writeback.c:2262
 mark_inode_dirty_sync include/linux/fs.h:2186 [inline]
 iput.part.0+0x57/0x810 fs/inode.c:1676
 iput+0x58/0x70 fs/inode.c:1669
 dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:374
 __dentry_kill+0x3c0/0x640 fs/dcache.c:579
 shrink_dentry_list+0x144/0x480 fs/dcache.c:1148
 prune_dcache_sb+0xe7/0x140 fs/dcache.c:1229
 super_cache_scan+0x336/0x590 fs/super.c:105
 do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
 shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
 shrink_node_memcgs mm/vmscan.c:2665 [inline]
 shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
 kswapd_shrink_node mm/vmscan.c:3523 [inline]
 balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
 kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
