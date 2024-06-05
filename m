Return-Path: <linux-ext4+bounces-2788-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EF8FD816
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674AE1C24005
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074815F31F;
	Wed,  5 Jun 2024 21:04:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BF4965B
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621472; cv=none; b=k+srdXU5wu9vE2MFBN6Pho4xBVXFDFSjOOi7I8v14WrwP19qp3bYb9HiB20RzTH2lHoRNstKSpBhrkX32dk5NuOohoxZGuOt8oHg4zbHTvLt2kUN048SP9Ovem9P5ZEBnc1aTm6qT9WH33bkdLQ8f69mLABaTVr+YzSO44F2ULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621472; c=relaxed/simple;
	bh=HlrvAaHQ6lu2hnvUEZeR/KNG2UjbmOFPMYGNEPQP9s0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FNQaoAnT1ibHiJymeGU+qqTUr/MGOOEnSKPAYb0AS9ECYSR5BuAmGx1ShpvzEEYbeeZAzV9v4F9Pju3jWNfTHwJ1eHD8krbqq9Zmtw6YSqlH0WkUc1B6kZaxY4dpjT9+V6G5ZF/z11cvbOSYL2sF1Q6bwdN3W1cJ4djjOxxqVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eb1d659c76so34179039f.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jun 2024 14:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621470; x=1718226270;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcPMQ6bOBhQLwd/XBtZYFAqbBcJIEqz8er2JvGD62zA=;
        b=sfgmT+ZOhietTH2ow1bnmFAOpvr8433ObW/g4fVv7o7xdUkLFY7ZTNj1G18yTcrEfi
         XSkUTc9Np04P1Io03/Ck0mvo76SmMrtnNHCNWY6Msf0AVTrMdgyxvGEMOolh4ZFY6jt0
         /ilg5bYBmlVH5LA+2BOLdIj1qkiCLhuP2DpFesnDc4QoR8uBFKJrFn60Pcb+63twgJve
         u6OhPg5WE5G4BVQhPsSU19+pcIeuHygHo1p32ALjNeOjmNfUiSUU5gvVUOvDoEw+nJwa
         MTlr6lOBG1yagiqpFqheCMKh3/TdlFyIjqcMN7UGCwlztK+VDQCx5xJo+xYiQPTUHC8Y
         11WA==
X-Forwarded-Encrypted: i=1; AJvYcCVySyRN7Z/Teu8uf45nNRt/wdUEpfT3KwjBSCN2zl3L7vUKtZweYPyiwdqUAQt/wlfFwn+/uPphU63yjy3jowUkOaEsleWoX+BZtQ==
X-Gm-Message-State: AOJu0Yww/aoB8QfH7HWSl6TIGAjaK1W17malzCcQHZas6T/4dDVNGNwm
	wH+ddZArBZ8qvLqtFlMq6CSce005n53q5U6InCBHv8ch0O6aWMXJDP86AvNJKEBVI1InEhfQhiO
	yRFz/4731Kon7fYrHWOHS1H68NBUZcSJPPYixqYeH/mdGXy4D7sYK00o=
X-Google-Smtp-Source: AGHT+IFru7FzL2H6dcMX1Wpt7fRn19NIPM5g/TD28s/7jyOVX5AlT3BSdJooRG2HZ7t1lL2baKACXd1c/KQLSr1rZTqc2DILVn74
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341a:b0:7e2:b00:2264 with SMTP id
 ca18e2360f4ac-7eb3c90cecfmr9636839f.2.1717621470358; Wed, 05 Jun 2024
 14:04:30 -0700 (PDT)
Date: Wed, 05 Jun 2024 14:04:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000998dd5061a2ae947@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_setattr (2)
From: syzbot <syzbot+95c8e4be52020572ac05@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc8ed4d0a848 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13986f2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=95c8e4be52020572ac05
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-cc8ed4d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36abdd995432/vmlinux-cc8ed4d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e4e0a6f67db/bzImage-cc8ed4d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95c8e4be52020572ac05@syzkaller.appspotmail.com

overlay: ./bus is not a directory
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848 #0 Not tainted
------------------------------------------------------
syz-executor.3/8218 is trying to acquire lock:
ffff888028d580c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_setattr+0x7fb/0x2700 fs/ext4/inode.c:5318

but task is already holding lock:
ffff88801db3c950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x10db/0x15e0 fs/jbd2/transaction.c:463

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x1101/0x15e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x358/0x660 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
       ext4_file_open+0x636/0xc90 fs/ext4/file.c:865
       do_dentry_open+0x910/0x1930 fs/open.c:955
       do_open fs/namei.c:3650 [inline]
       path_openat+0x1e3a/0x29f0 fs/namei.c:3807
       do_filp_open+0x1dc/0x430 fs/namei.c:3834
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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
       dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
       dput+0x1f/0x30 fs/dcache.c:835
       ovl_stack_put+0x60/0x90 fs/overlayfs/util.c:132
       ovl_destroy_inode+0xc6/0x190 fs/overlayfs/super.c:182
       destroy_inode+0xc4/0x1b0 fs/inode.c:311
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
       kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:634
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
       ext4_set_acl+0x453/0x5a0 fs/ext4/acl.c:263
       set_posix_acl+0x25c/0x320 fs/posix_acl.c:955
       vfs_set_acl+0x53d/0x940 fs/posix_acl.c:1134
       do_set_acl+0xd9/0x1b0 fs/posix_acl.c:1279
       do_setxattr+0xeb/0x170 fs/xattr.c:626
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __ia32_sys_lsetxattr+0xbd/0x160 fs/xattr.c:690
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
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       ext4_setattr+0x7fb/0x2700 fs/ext4/inode.c:5318
       notify_change+0x742/0x11f0 fs/attr.c:497
       chown_common+0x598/0x660 fs/open.c:790
       do_fchownat+0x1af/0x210 fs/open.c:821
       ksys_lchown include/linux/syscalls.h:1244 [inline]
       __do_sys_lchown16 kernel/uid16.c:30 [inline]
       __se_sys_lchown16 kernel/uid16.c:28 [inline]
       __ia32_sys_lchown16+0xe6/0x120 kernel/uid16.c:28
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> sb_internal --> jbd2_handle

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(jbd2_handle);
                               lock(sb_internal);
                               lock(jbd2_handle);
  rlock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz-executor.3/8218:
 #0: ffff88801db38420 (sb_writers#4){.+.+}-{0:0}, at: do_fchownat+0x11b/0x210 fs/open.c:818
 #1: ffff888028d58400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888028d58400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: chown_common+0x331/0x660 fs/open.c:780
 #2: ffff88801db3c950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x10db/0x15e0 fs/jbd2/transaction.c:463

stack backtrace:
CPU: 1 PID: 8218 Comm: syz-executor.3 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848 #0
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
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
 ext4_setattr+0x7fb/0x2700 fs/ext4/inode.c:5318
 notify_change+0x742/0x11f0 fs/attr.c:497
 chown_common+0x598/0x660 fs/open.c:790
 do_fchownat+0x1af/0x210 fs/open.c:821
 ksys_lchown include/linux/syscalls.h:1244 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0xe6/0x120 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf729f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e915ac EFLAGS: 00000292 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 000000000000ee00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
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

