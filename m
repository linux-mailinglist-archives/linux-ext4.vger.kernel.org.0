Return-Path: <linux-ext4+bounces-2474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F38C402A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B94D1F21FB3
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2314EC54;
	Mon, 13 May 2024 11:53:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA714D2B6
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601205; cv=none; b=TWSeoif0WL1LLjXuNEe/blDntGVU6imvepyPDHVXRpxz8mCq65XenA0EZ+6/4/NPbKEuOG+4kaG+FocHHNmyHXuVane0Tj0eNJ2V1oxzTAt+2QRlDI8isGRBxbnKiHhWximdjkyN35WFYQ7FlNdyH4VC6b/UKb8UhYjVgq3okKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601205; c=relaxed/simple;
	bh=YiP/sfWwTGsR5kg821UuYMdViqM3bN7AUaiGUv1KAsY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TbcrkPQEyrn0EZGgTf/UDpoKk1DVMfYSPlM+trqccnQCCDIqzpO16sMIE3PstQM2Aihs0k7hkrvU7VT+8PTSmJ8/RfjWH3IBhI92k1xHPOfqFhQw5UsSRN4T7/hlClSH90lHs554okuY1bD+pblMqpQBXk7fm4V1+qU/ZKojMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so347386039f.0
        for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 04:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601202; x=1716206002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPORG2geYdf1K4YmZWN4SZuggEePA8O5U0hHgGUUBpw=;
        b=ZSeP1ufp6gVxwi/Ii5EkmRPlR+cr0Jg3YWaR+G9jLtkmyDWeJPw7BEDuUObFADVbog
         tve6K/A7io9GGMj0yG/cm/zETy0tinh3vkguFEcWA2heDbli404h46/+JIwYdQKBW6xJ
         dgNzAj3J4GB5pDN5obR1GYiuD3LS+ax6dS4dntW+nsdWnIgdD5tngSM8YFeFhQbBYok9
         a1hjgLkCvD+bOrxdm6w82aG21qBiIJBCGy571bddLH5Vqr7G5zuYBfiGeYpJ0bv6/ah3
         iqr+bw6BjllVxWESAaFqgaOkYwHtWdbaCigZAADbKXa4PScra3ZlOQ7fahcF0PGfKPTp
         B17Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL8Qptk12Z+uvVoE5aSKmysLPNNwNHm7SonUrxKx1HWam33KzUyqvk5MZ7FepGGbDmxQtfQln4CKZvaomW19rAqrQ49jUq2s7exA==
X-Gm-Message-State: AOJu0Yx1bxXGfNdAJ/gb4i+CGKSBH8ZHBdLZR4ylYsVqPu49n19KOI4f
	VnwHNrWtwN/En31kyXCYq83AwETpZUNfrVhLRmMQK9kgWUzbb/QB2sZcg9V4gicUAVjwEuQkns9
	9NoPHytLsXGn23UP/MSEPEwYTJXVdRBTwkxh7zhf/OYK8Ib3lzUW8lLc=
X-Google-Smtp-Source: AGHT+IEIKRw3A7mr3kC0MrTYIhFFo4aniIwQNSUFWpeRiy31itd4L6dQSX2CMgK75pNSI7N8bmFcQUDbMAjr2HxI1XisFvF0TBSH
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d0:b0:487:591e:6e04 with SMTP id
 8926c6da1cb9f-48955bde8ebmr772847173.3.1715601202683; Mon, 13 May 2024
 04:53:22 -0700 (PDT)
Date: Mon, 13 May 2024 04:53:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004332130618548876@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (5)
From: syzbot <syzbot+4247fb9b4517c79e3b57@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144a905c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a450595960709c8
dashboard link: https://syzkaller.appspot.com/bug?extid=4247fb9b4517c79e3b57
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-45db3ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c94d1aa6cd96/vmlinux-45db3ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9daddfda2f1/bzImage-45db3ab7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4247fb9b4517c79e3b57@syzkaller.appspotmail.com

EXT4-fs (loop3): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-00056-g45db3ab70092 #0 Not tainted
------------------------------------------------------
syz-executor.3/30481 is trying to acquire lock:
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:312 [inline]
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3752 [inline]
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3833 [inline]
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:3971 [inline]
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node+0xbb/0x480 mm/slub.c:3979

but task is already holding lock:
ffff88802a241ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff88802a241ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x156/0x16d0 fs/ext4/xattr.c:2358

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x156/0x16d0 fs/ext4/xattr.c:2358
       ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2545
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
       vfs_setxattr+0x146/0x350 fs/xattr.c:321
       do_setxattr+0x146/0x170 fs/xattr.c:629
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __ia32_sys_lsetxattr+0xbd/0x160 fs/xattr.c:690
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x1101/0x15e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x358/0x660 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
       ext4_file_open+0x636/0xc80 fs/ext4/file.c:866
       do_dentry_open+0x8da/0x18c0 fs/open.c:955
       do_open fs/namei.c:3642 [inline]
       path_openat+0x1dfb/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_intwrite include/linux/fs.h:1847 [inline]
       ext4_evict_inode+0xd7b/0x17d0 fs/ext4/inode.c:212
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
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
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3752 [inline]
       slab_alloc_node mm/slub.c:3833 [inline]
       __do_kmalloc_node mm/slub.c:3971 [inline]
       __kmalloc_node+0xbb/0x480 mm/slub.c:3979
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

3 locks held by syz-executor.3/30481:
 #0: ffff888076954420 (sb_writers#4){.+.+}-{0:0}, at: path_setxattr+0xc3/0x1e0 fs/xattr.c:669
 #1: ffff88802a242200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:795 [inline]
 #1: ffff88802a242200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_setxattr+0x123/0x350 fs/xattr.c:320
 #2: ffff88802a241ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff88802a241ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x156/0x16d0 fs/ext4/xattr.c:2358

stack backtrace:
CPU: 0 PID: 30481 Comm: syz-executor.3 Not tainted 6.9.0-rc7-syzkaller-00056-g45db3ab70092 #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
 might_alloc include/linux/sched/mm.h:312 [inline]
 slab_pre_alloc_hook mm/slub.c:3752 [inline]
 slab_alloc_node mm/slub.c:3833 [inline]
 __do_kmalloc_node mm/slub.c:3971 [inline]
 __kmalloc_node+0xbb/0x480 mm/slub.c:3979
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
RIP: 0023:0xf72c6579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eb85ac EFLAGS: 00000292 ORIG_RAX: 00000000000000e2
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00000000200001c0
RDX: 0000000020001400 RSI: 0000000000000835 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

