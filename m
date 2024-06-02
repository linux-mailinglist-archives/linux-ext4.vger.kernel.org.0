Return-Path: <linux-ext4+bounces-2740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994E8D75D2
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C781F217EB
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2024 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3E3FB1C;
	Sun,  2 Jun 2024 13:53:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007143BBCB
	for <linux-ext4@vger.kernel.org>; Sun,  2 Jun 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336410; cv=none; b=hW79iEmB0khejR2+rlC7PFgbarAzP8QFx6RN8Qin9Meov8yEiqzipzeil/2IJi65dm8Mq2O3IUr1eaahiy1g2+wk1QcOW5KVtG3qj+iq1DJ4PskhGQmeDDx6vN659ncfVDHiYHhnAfS9IKslJXVRCFa1Xy+7BIceCkGy+Pxbi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336410; c=relaxed/simple;
	bh=jWNPKczhQ/ibJrRC7x0ILOTk+Gm57X5fnNFvlbE4iIo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aW8rNx6c7UadLnHxKlWB8BRbhG4YCC/NRPrrcyx8SSoUcrqKrc3+IaJhanhmGE5ioOombk8XGQW9wO6eoU2umkAFqq3kaAaKZUGnPpu8/07rMey+Mp7+pK3aqfCXudJWREpzkHF3VofD10/4ApZy7bCTBHe37bVaNCkBQ6RUPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37499ab1ed3so5717775ab.0
        for <linux-ext4@vger.kernel.org>; Sun, 02 Jun 2024 06:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717336408; x=1717941208;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IG7SYBa9v9VTPJHbhKODV9kFTu6SB9M3s85FT4Ycn/A=;
        b=BfAsuDnkq7394lcAOnWD4nTLJxT6S/yf20ETKCj+gmiuoZ121akUSuPpeBUuEn6lfC
         1jEjqQ5m/kn7v3rjoescdZm6Q7YFkjanVpc44OmkkpcGcwnTXVJZqwdoWpzX/pM/WnY2
         Bz+pikndwLxR6y8ZjBkAy/IjW74uaUa43WjhRvzLE0r7ULV5DSsNb+Za4a7kEg9rhgOV
         5Y6/eAk/qy06FJ+cOPWv9LxU7NTZ+Vz4qOTDesNGdSAk3bjc0oi6VByM63bkaOoaQ+yX
         fhAZ6vSvjTXc/i3aigxnyEDZuzOHocAuJmtRZqguKQV8eej5Q+zxSvXl0rPwQaJdtcDp
         fsTw==
X-Forwarded-Encrypted: i=1; AJvYcCU9heZ0jDMDWG2ZBRjHae0TFkmhY3EX5S/HsEUF4b8+9JB+Qs7lRq/3o2XTRmisXjWxJjN9RCZ4BxVBDT8aNqsIatYCG2dvJ/KS9w==
X-Gm-Message-State: AOJu0YwmKhTtfuvYF3caYcKfN3tBThhYepwOH+BSchTLZx38UnDjm7ev
	ByBZ7QpOVHCPTTFRVhQsNkbRGE+Kw446EE6lRwQOYhFABhrW2v7IpdFUWI+CEZyG8ZG9tPfKWZP
	Ny27oklhFdG8TFazoz07mDXGE+lU7BBSpZLQ23q+ubfy6c0hFWJZmGp4=
X-Google-Smtp-Source: AGHT+IGxxikUdUpRGp+0gWqP5S4xJosqdhFZUOPRek3ikAG40QA+wk+NsoV8fhxOcjOJKAvdi1Z673n3Mo7931ROqQjWJZMkLTsR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:374:5d81:9135 with SMTP id
 e9e14a558f8ab-3748b8f3c4cmr5802285ab.0.1717336408326; Sun, 02 Jun 2024
 06:53:28 -0700 (PDT)
Date: Sun, 02 Jun 2024 06:53:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009416e60619e88a14@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_inline_data_truncate (2)
From: syzbot <syzbot+8bf80f09a0a9767b4308@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10473b3a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=8bf80f09a0a9767b4308
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e0cce98f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb24795b031d/vmlinux-e0cce98f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcfa9241b1bb/bzImage-e0cce98f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bf80f09a0a9767b4308@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0 Not tainted
------------------------------------------------------
syz-executor.0/6609 is trying to acquire lock:
ffff88802a2450c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff88802a2450c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_inline_data_truncate+0x1af/0xc80 fs/ext4/inline.c:1915

but task is already holding lock:
ffff888012ccc610 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6c0 fs/inode.c:667

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1655 [inline]
       sb_start_intwrite include/linux/fs.h:1838 [inline]
       ext4_evict_inode+0xd7b/0x17d0 fs/ext4/inode.c:212
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3890 [inline]
       slab_alloc_node mm/slub.c:3980 [inline]
       __do_kmalloc_node mm/slub.c:4120 [inline]
       __kmalloc_node_noprof+0xbb/0x450 mm/slub.c:4128
       kmalloc_node_noprof include/linux/slab.h:681 [inline]
       kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:634
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1581 [inline]
       ext4_xattr_inode_lookup_create+0x4e8/0x1910 fs/ext4/xattr.c:1568
       ext4_xattr_block_set+0x77a/0x3090 fs/ext4/xattr.c:1910
       ext4_xattr_move_to_block fs/ext4/xattr.c:2663 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2738 [inline]
       ext4_expand_extra_isize_ea+0xf57/0x1990 fs/ext4/xattr.c:2830
       __ext4_expand_extra_isize+0x322/0x450 fs/ext4/inode.c:5782
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5825 [inline]
       __ext4_mark_inode_dirty+0x55a/0x890 fs/ext4/inode.c:5903
       ext4_dirty_inode+0xd9/0x130 fs/ext4/inode.c:5935
       __mark_inode_dirty+0x1f0/0xe70 fs/fs-writeback.c:2486
       generic_update_time+0xcf/0xf0 fs/inode.c:1907
       inode_update_time fs/inode.c:1920 [inline]
       touch_atime+0x4ee/0x5d0 fs/inode.c:1992
       file_accessed include/linux/fs.h:2458 [inline]
       filemap_read+0xb2b/0xd10 mm/filemap.c:2693
       generic_file_read_iter+0x350/0x460 mm/filemap.c:2806
       ext4_file_read_iter+0x1dc/0x6c0 fs/ext4/file.c:147
       __kernel_read+0x3ec/0xb50 fs/read_write.c:434
       kernel_read+0x55/0x70 fs/read_write.c:452
       prepare_binprm fs/exec.c:1732 [inline]
       search_binary_handler fs/exec.c:1781 [inline]
       exec_binprm fs/exec.c:1839 [inline]
       bprm_execve fs/exec.c:1891 [inline]
       bprm_execve+0x61e/0x19b0 fs/exec.c:1867
       do_execveat_common.isra.0+0x5cb/0x750 fs/exec.c:1998
       compat_do_execve fs/exec.c:2099 [inline]
       __do_compat_sys_execve fs/exec.c:2167 [inline]
       __se_compat_sys_execve fs/exec.c:2163 [inline]
       __ia32_compat_sys_execve+0x90/0xc0 fs/exec.c:2163
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_inline_data_truncate+0x1af/0xc80 fs/ext4/inline.c:1915
       ext4_truncate+0x990/0x1400 fs/ext4/inode.c:4095
       ext4_evict_inode+0x7ae/0x17d0 fs/ext4/inode.c:258
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       ext4_orphan_cleanup+0x742/0x1210 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5553 [inline]
       ext4_fill_super+0x8333/0xacf0 fs/ext4/super.c:5676
       get_tree_bdev+0x36f/0x610 fs/super.c:1615
       vfs_get_tree+0x8f/0x380 fs/super.c:1780
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x6e1/0x1f10 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> fs_reclaim --> sb_internal

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal);
                               lock(fs_reclaim);
                               lock(sb_internal);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz-executor.0/6609:
 #0: ffff888012ccc0e0 (&type->s_umount_key#29/1){+.+.}-{3:3}, at: alloc_super+0x23d/0xbd0 fs/super.c:344
 #1: ffff888012ccc610 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6c0 fs/inode.c:667

stack backtrace:
CPU: 0 PID: 6609 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
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
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_inline_data_truncate+0x1af/0xc80 fs/ext4/inline.c:1915
 ext4_truncate+0x990/0x1400 fs/ext4/inode.c:4095
 ext4_evict_inode+0x7ae/0x17d0 fs/ext4/inode.c:258
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 ext4_orphan_cleanup+0x742/0x1210 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5553 [inline]
 ext4_fill_super+0x8333/0xacf0 fs/ext4/super.c:5676
 get_tree_bdev+0x36f/0x610 fs/super.c:1615
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7329579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5efa400 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5efa460 RCX: 0000000020000000
RDX: 0000000020000080 RSI: 000000000000010e RDI: 00000000f5efa4a0
RBP: 00000000f5efa460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
EXT4-fs (loop0): 1 orphan inode deleted
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
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

