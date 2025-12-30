Return-Path: <linux-ext4+bounces-12531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52797CE9928
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Dec 2025 12:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AA7430060E7
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Dec 2025 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1303D2EA178;
	Tue, 30 Dec 2025 11:48:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DD280317
	for <linux-ext4@vger.kernel.org>; Tue, 30 Dec 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095308; cv=none; b=dgqremS7RQJtZxq9w00N2ur4602xZ5M2TL/VXvEnzwA3jW7gfFZxMM+IFze8LFZhB13wOIJ4EHDiwQr2W1kwd0XEeijSCMTn96f2ALTMUPm7+9gI7wRLgzOHRcaWgOEn+3VnbsO6jlyo/iZzqKfFYyawQKas22s0/ZmvYYcFUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095308; c=relaxed/simple;
	bh=OAVqcnesl+4941j64kLR+lVilt41CCTBFJOiOR2ej4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NkQCHuQWkWjEZgkUBYEmA+xjcPStMq0QnA81nQbFkbc2frVbIQFc9kY3M2crcOqPrLEBgH03ePy43cqK+tqfFTuSbZ+mHXCUQ8ENINvOePfup2KvFQpsW00dhmu88aDke5V9hG0qRvBRYTkRn/Rzg43xt//EW5HiBdcpxEs1e5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7ce031c61ccso2254128a34.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Dec 2025 03:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095305; x=1767700105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITeqqpPpxAut+DnobFXTlCH7OD3JuOzo/FU2J6DkIRQ=;
        b=Spu9I3VkDjG4aXMmcxUhx3k+nL54psnn+qijsnkjGeb9Vj5sfx+q2/kWQ9FjRP6Jfy
         MZUHfhxv0wmlqVMgE74h+hQoPkk01Pe9NrBcrBSlo5x2SXaQScHrC6w4FPZjwf0xIjbK
         Uis25JbI7dXAu3XSLs2N+UY6ghRl1Ebu8dzWt+AD8V5yAOxF/UVYopcDHge0vtKlja+4
         sQuu16ZXpXSP5TDno5lujKirWYBjseHPHGVns7hBncx+31n4nEf3mp39v0ib+xMxDWQc
         UyKqR2lcFbLIVZPehi16TdGqQ70a1l8MqpTgRaTl13hJJ93l4zElVsDutjsyAzi2qvZO
         Lc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZr4EuTErPUti8tLTT8jkPdoPKsUQTi3fN63ozDQ0KxD+Jtl4ZH2tankD37WxXfdhMQYjqO6vl0k0k@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBsdCyja3mpwiiy9yEINJ2Imvok8U4oj/oHw64J/pwKVNQWpd
	ruf/rr8O8y/GQlE59XmX1yUfRruvMO2qvcqzwIQ9TBio80mjQ9ioWJiqlQBdAdNS9CXk3fI1F6L
	7z0UjMwDKDbFGB5C+M+gSn3eNpMU8rqjoCozI5hzAuJ1H8wDAROzZLRPENNk=
X-Google-Smtp-Source: AGHT+IFWQxjngUYb9BwtZhChKFw8+BbKcrnThTpFlpwtewvxEV71RBKs0z7uStnheTjDYiTWALrbKZLG1bDCfeS9O+s9aoDXmV9y
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:e15:b0:65b:8181:e191 with SMTP id
 006d021491bc7-65cfe76f5bfmr12473791eaf.29.1767095305489; Tue, 30 Dec 2025
 03:48:25 -0800 (PST)
Date: Tue, 30 Dec 2025 03:48:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953bc09.050a0220.329c0f.0592.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in wait_transaction_locked (3)
From: syzbot <syzbot+5d19358d7eb30ffb0cc5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8640b74557fc Merge tag 'kbuild-fixes-6.19-1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142bbb92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=5d19358d7eb30ffb0cc5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1a701044e2e/disk-8640b745.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8fd3c918355/vmlinux-8640b745.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf28e4692fb2/bzImage-8640b745.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d19358d7eb30ffb0cc5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
kworker/u8:4/64 is trying to acquire lock:
ffff88803375a950 (jbd2_handle){++++}-{0:0}, at: wait_transaction_locked+0x19d/0x270 fs/jbd2/transaction.c:151

but task is already holding lock:
ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
       ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
       writeback_single_inode+0x493/0xc70 fs/fs-writeback.c:1858
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2924
       iput_final fs/inode.c:1941 [inline]
       iput+0xa77/0x1030 fs/inode.c:2003
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2203
       ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2831
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6349
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
       __ext4_mark_inode_dirty+0x45c/0x6e0 fs/ext4/inode.c:6470
       ext4_evict_inode+0x79c/0xe60 fs/ext4/inode.c:253
       evict+0x5f4/0xae0 fs/inode.c:837
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:472
       __ext4_fill_super fs/ext4/super.c:5658 [inline]
       ext4_fill_super+0x58a1/0x6160 fs/ext4/super.c:5777
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2a0 fs/super.c:1751
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3636 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3712
       do_mount fs/namespace.c:4035 [inline]
       __do_sys_mount fs/namespace.c:4224 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4201
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ei->xattr_sem){++++}-{4:4}:
       down_read+0x47/0x2e0 kernel/locking/rwsem.c:1537
       ext4_setattr+0x855/0x1bc0 fs/ext4/inode.c:5865
       notify_change+0xc1a/0xf40 fs/attr.c:546
       chown_common+0x40c/0x5b0 fs/open.c:788
       do_fchownat+0x161/0x270 fs/open.c:819
       __do_sys_chown fs/open.c:839 [inline]
       __se_sys_chown fs/open.c:837 [inline]
       __x64_sys_chown+0x82/0xa0 fs/open.c:837
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
       wait_transaction_locked+0x1b6/0x270 fs/jbd2/transaction.c:151
       add_transaction_credits fs/jbd2/transaction.c:222 [inline]
       start_this_handle+0x77d/0x21c0 fs/jbd2/transaction.c:403
       jbd2__journal_start+0x2c1/0x5b0 fs/jbd2/transaction.c:501
       __ext4_journal_start_sb+0x203/0x580 fs/ext4/ext4_jbd2.c:114
       __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
       ext4_do_writepages+0xf3e/0x4500 fs/ext4/inode.c:2914
       ext4_writepages+0x203/0x350 fs/ext4/inode.c:3026
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
       writeback_sb_inodes+0x93a/0x1870 fs/fs-writeback.c:2030
       __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2107
       wb_writeback+0x43f/0xaa0 fs/fs-writeback.c:2218
       wb_check_old_data_flush fs/fs-writeback.c:2322 [inline]
       wb_do_writeback fs/fs-writeback.c:2375 [inline]
       wb_workfn+0xad2/0xed0 fs/fs-writeback.c:2403
       process_one_work kernel/workqueue.c:3257 [inline]
       process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> &ei->xattr_sem --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(jbd2_handle);

 *** DEADLOCK ***

4 locks held by kworker/u8:4/64:
 #0: ffff88801def2948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88801def2948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc9000213fbc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc9000213fbc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffff8880336760e0 (&type->s_umount_key#31){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:563
 #3: ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #3: ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
 #3: ffff888033758b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025

stack backtrace:
CPU: 1 UID: 0 PID: 64 Comm: kworker/u8:4 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 wait_transaction_locked+0x1b6/0x270 fs/jbd2/transaction.c:151
 add_transaction_credits fs/jbd2/transaction.c:222 [inline]
 start_this_handle+0x77d/0x21c0 fs/jbd2/transaction.c:403
 jbd2__journal_start+0x2c1/0x5b0 fs/jbd2/transaction.c:501
 __ext4_journal_start_sb+0x203/0x580 fs/ext4/ext4_jbd2.c:114
 __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
 ext4_do_writepages+0xf3e/0x4500 fs/ext4/inode.c:2914
 ext4_writepages+0x203/0x350 fs/ext4/inode.c:3026
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
 writeback_sb_inodes+0x93a/0x1870 fs/fs-writeback.c:2030
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2107
 wb_writeback+0x43f/0xaa0 fs/fs-writeback.c:2218
 wb_check_old_data_flush fs/fs-writeback.c:2322 [inline]
 wb_do_writeback fs/fs-writeback.c:2375 [inline]
 wb_workfn+0xad2/0xed0 fs/fs-writeback.c:2403
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

