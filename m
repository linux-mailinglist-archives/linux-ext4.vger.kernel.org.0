Return-Path: <linux-ext4+bounces-2573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D28C91E9
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70616B21355
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF25381D;
	Sat, 18 May 2024 18:31:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132A53364
	for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716057093; cv=none; b=kb4N/pLXv63c2N0+DgOsGQ1Zg4MPdxq56r2L9jwNjrsybuuxB65XDD9VXz7iyB1qhzVfxhT9Ycji6/SRDGES4dzgO5QlpqKEbrGO/kYHv0fytbjq1O3XXUAmpgCXZUUjGyIFSLFzfAVidYZnf4B4V4GbM8Dm9DXgbm6zb7VvU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716057093; c=relaxed/simple;
	bh=tJgHkhuFNie1SuQOCRc4FA/230sI9YFUx1P/L50kQNY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HJKNuVO8/GKmNL7CMbt4wNaZI2DyV3E89kC8q7KIYqtYX0hH/VB+NqmUDRcugJLX00qegrB/ydcEZ4OvjeHVZI/3Te8x4cDzSyKW8+ZgPBTTEViNrGUfczUqC+PtSUHnEYhrmXE7VDBfJ5H098SEcEsQnHuXS666pxVN2QN8ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1ac2fbcb7so1223553439f.0
        for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 11:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716057090; x=1716661890;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZVTn15843LKOoA0qurxiaspfnZTru/i/a3hJ54j8+0=;
        b=TWkrSbEgOoyA141+kmu7nHKZ1rhfOe3OuTFUbvq1mx1wWiJDB1/N58nU4kDFABZEAF
         LRn2FJvFuhyI4pucd7Zfg1r3GPig/fztya0AjkbAN0mt1OE3fxE0+YrOn8pnVkvtDZDJ
         0FfPDGSzACG83w+lTaOsHumAmyqI/x6Ado13IKBde9yKQAakAIpxVp2kOebtjs6qE0Cb
         GSqj98Pz6GI3Hp9Rqqz5RoVFvvUncCtvBho2yMZBR4SPbmfVbQ6XS76bgEViLGcpToV5
         yvK0seYbKFYV5MXdoIjC0jFsyB1iLBf8H+B/p2h01SHg3qHAu4HuldjnL4IQCbeVmsS/
         kGYw==
X-Forwarded-Encrypted: i=1; AJvYcCU+HrjHWelT7us7iLAoEkg5SabfB5BGyA/bW4ag+g6SJJkb21LcCFHVxbOK96IA538b7ryFXAG14eLe270XhnHqO4t7dJpEIG7wjg==
X-Gm-Message-State: AOJu0YwZQFcrSX5IfuRG+lBYi5vzo34DeO+O6DzYTKvucVTJOg/k/dgF
	8w5TiJxbp3a3jyTrZ437QgcGYf6Lf54hiZaXxbb6k29SjcTPNlGB7+rlt3BqwC5umLddpwyrA8Q
	tVft/dmRoYqUjjyjH2EVsJVat8iIHfkNzIn7X9FbhhmDiUnmREyezVoM=
X-Google-Smtp-Source: AGHT+IHQgEwx7XPKRDBBXDz3SqVtjePlfZJwNMvv9Zwzccpt5RWnnXq3PDUULeVSiS+rN1Vx7+QW33/Xpk4KRH5LBuw+J4AJnZ1E
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:d9fb:b418 with SMTP id
 8926c6da1cb9f-4895933e5a1mr1419458173.6.1716057090033; Sat, 18 May 2024
 11:31:30 -0700 (PDT)
Date: Sat, 18 May 2024 11:31:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000441aab0618beadc5@google.com>
Subject: [syzbot] [ext4?] possible deadlock in wait_transaction_locked
From: syzbot <syzbot+007d621ed59411ae5fd0@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3c999d1ae3c7 Merge tag 'wq-for-6.10' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134e8ae0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60e9f916d152f01c
dashboard link: https://syzkaller.appspot.com/bug?extid=007d621ed59411ae5fd0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3c999d1a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2cbecb7d711/vmlinux-3c999d1a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f89ef5a44a32/bzImage-3c999d1a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+007d621ed59411ae5fd0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-07726-g3c999d1ae3c7 #0 Not tainted
------------------------------------------------------
kswapd0/111 is trying to acquire lock:
ffff88801dc5c950 (jbd2_handle){++++}-{0:0}, at: wait_transaction_locked+0x188/0x230 fs/jbd2/transaction.c:177

but task is already holding lock:
ffffffff8dd38f00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3819 [inline]
       slab_alloc_node mm/slub.c:3900 [inline]
       __do_kmalloc_node mm/slub.c:4038 [inline]
       __kmalloc_node+0xbb/0x480 mm/slub.c:4046
       kmalloc_node include/linux/slab.h:648 [inline]
       kvmalloc_node+0x9d/0x1a0 mm/util.c:634
       kvmalloc include/linux/slab.h:766 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1581 [inline]
       ext4_xattr_set_entry+0xdc3/0x3b20 fs/ext4/xattr.c:1718
       ext4_xattr_block_set+0xd07/0x3080 fs/ext4/xattr.c:2037
       ext4_xattr_set_handle+0xf24/0x16d0 fs/ext4/xattr.c:2443
       ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2545
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
       vfs_setxattr+0x146/0x350 fs/xattr.c:321
       do_setxattr+0x146/0x170 fs/xattr.c:629
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_setxattr fs/xattr.c:687 [inline]
       __se_sys_setxattr fs/xattr.c:683 [inline]
       __ia32_sys_setxattr+0xc0/0x160 fs/xattr.c:683
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x156/0x16d0 fs/ext4/xattr.c:2358
       ext4_set_context+0x400/0x5a0 fs/ext4/crypto.c:202
       set_encryption_policy+0x2cc/0x470 fs/crypto/policy.c:500
       fscrypt_ioctl_set_policy+0x4a2/0x500 fs/crypto/policy.c:553
       __ext4_ioctl+0x2f67/0x4700 fs/ext4/ioctl.c:1520
       ext4_ioctl fs/ext4/ioctl.c:1627 [inline]
       ext4_compat_ioctl+0xca/0x460 fs/ext4/ioctl.c:1703
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1004
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       wait_transaction_locked+0x192/0x230 fs/jbd2/transaction.c:177
       add_transaction_credits+0x10a/0xb80 fs/jbd2/transaction.c:241
       start_this_handle+0x3a3/0x15e0 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x358/0x660 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0xa1/0x130 fs/ext4/inode.c:5939
       __mark_inode_dirty+0x1f0/0xe70 fs/fs-writeback.c:2486
       mark_inode_dirty_sync include/linux/fs.h:2426 [inline]
       iput.part.0+0x5b/0x7f0 fs/inode.c:1764
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

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

2 locks held by kswapd0/111:
 #0: ffffffff8dd38f00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88801dc580e0 (&type->s_umount_key#33){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88801dc580e0 (&type->s_umount_key#33){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 0 PID: 111 Comm: kswapd0 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 wait_transaction_locked+0x192/0x230 fs/jbd2/transaction.c:177
 add_transaction_credits+0x10a/0xb80 fs/jbd2/transaction.c:241
 start_this_handle+0x3a3/0x15e0 fs/jbd2/transaction.c:422
 jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x358/0x660 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0xa1/0x130 fs/ext4/inode.c:5939
 __mark_inode_dirty+0x1f0/0xe70 fs/fs-writeback.c:2486
 mark_inode_dirty_sync include/linux/fs.h:2426 [inline]
 iput.part.0+0x5b/0x7f0 fs/inode.c:1764
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

