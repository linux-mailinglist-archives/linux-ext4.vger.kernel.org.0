Return-Path: <linux-ext4+bounces-8824-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53CAF9A17
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC66C540FAD
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336572D8391;
	Fri,  4 Jul 2025 17:49:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E061288CB7
	for <linux-ext4@vger.kernel.org>; Fri,  4 Jul 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651380; cv=none; b=CmHDI5FNWUU6q+UU8w0pb4xuAFziAuFDO6PWKHgcIkzhaHpvVuyk0jFFsXMkcWfDAeRUEVw5T63ewBiYS3878Dwg5mogrBd8qB85/X75hc9/nPI7Rnmty76I1119dFqIlebBNtsK+HTdPZOIH3aFbWEiKLxWBmksovmuksrReGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651380; c=relaxed/simple;
	bh=ZgWsBjiqaFMnkWClqoFaOFZLBqkDK/Qn3l6Erel+LrY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AoMsKTYH53GmdXr3QmOpGlishzeCKwYJjNl386xbduQ26Dk0BX5/uUh/6UBofH49AUy5TX4NU8kyZCAgApBovyWNLmkc043Bva53V3CeFJqVtQlZmTPKDJpH9ss7nwldQ+dlwcuQ1hvZGwPT0OoeZM6BY4WH/VUeP/DeVM3iOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e134cebaf0so17712495ab.0
        for <linux-ext4@vger.kernel.org>; Fri, 04 Jul 2025 10:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651377; x=1752256177;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llWB+IJjRB0JOSdo0HfUMwesyKrrtPpo1Ohoj0C5zv8=;
        b=dZfQdgprdpVU12BR1i2FDtU96YGMNUk67sZoTy/0YdP52e9qa7sXIg8RL84a09ykYJ
         k9AUY49ZaK4QZLb4zTaUvqX7mwGmKXrlQ5lfbhphMYYNGR2+uG/G67hI0GdW5ImEHPLd
         w+1yUK5ZlNftS03owPr6Y+3/WYgFIpisJUp/aDAaX1cZHrv8lojC4jeCjbnsh/BAEgYW
         zMJDc7/LNgBeWdcWSa1Kna7wEF2bvRkv1i0OZ7W/HR026O0YDDDiiv6iLL+Sy2J2e5+M
         Uyuh24cRNVANUHp10JuDHpJhaHpIgkFcJnWicwMRC1viUtuTi6yN3ydqQ61WDIBayBkq
         BMjw==
X-Forwarded-Encrypted: i=1; AJvYcCV4xDTZEYfl0aBGCMi5yP6ONO/PccxUdroNTarplA20acCactLXNxYYylhtqSgfAxKYH74HYg9C0O76@vger.kernel.org
X-Gm-Message-State: AOJu0YyWedIDDxZJxBl2dgNoVahtEIpTgbx1ekgn7mvIvw8itw1Ue3lw
	MOm3fNFpe7NWmvSPlY3iT5byVITYMV4TZK3BiVMolcbM7rPwdtc6CzsNU3B6jnvXgAaO/JxKvCD
	ednxzvMU4heV57K59lXPFhFIhwDtNxSSgPQeTBfsXUp4Cro74M+le+Bnm46k=
X-Google-Smtp-Source: AGHT+IFHTdPT9vMugDijNQjk2RE5H+N/0cPy61jWHPHDt604F3ncno1pH8yHt2O7qMH70rk+6pLN1BvUGgAuYTzsDO2ON5XZElGB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:a:b0:3dd:b7ea:c3d9 with SMTP id
 e9e14a558f8ab-3e1354ba150mr37475635ab.7.1751651377184; Fri, 04 Jul 2025
 10:49:37 -0700 (PDT)
Date: Fri, 04 Jul 2025 10:49:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68681431.a00a0220.c7b3.0021.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_page_mkwrite
From: syzbot <syzbot+9200a5f34919fd7fd788@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0b3b7b22dfa Linux 6.16-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d41982580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e29b8115bf337f53
dashboard link: https://syzkaller.appspot.com/bug?extid=9200a5f34919fd7fd788
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afd8a00e0f2e/disk-d0b3b7b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a71883723588/vmlinux-d0b3b7b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5dd703d981fd/bzImage-d0b3b7b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9200a5f34919fd7fd788@syzkaller.appspotmail.com

loop9: detected capacity change from 0 to 2048
EXT4-fs (loop9): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz.9.925/12720 is trying to acquire lock:
ffff888045180520 (sb_pagefaults){++++}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
ffff888045180520 (sb_pagefaults){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1795 [inline]
ffff888045180520 (sb_pagefaults){++++}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1960 [inline]
ffff888045180520 (sb_pagefaults){++++}-{0:0}, at: ext4_page_mkwrite+0x1e3/0x1110 fs/ext4/inode.c:6576

but task is already holding lock:
ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:431 [inline]
ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:188 [inline]
ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x300 mm/mmap_lock.c:248

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __might_fault+0xcc/0x130 mm/memory.c:6971
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
       ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x16d3/0x1990 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:1227
       ocfs2_acquire_dquot+0x80f/0xb30 fs/ocfs2/quota_global.c:883
       dqget+0x7b1/0xf10 fs/quota/dquot.c:977
       __dquot_initialize+0x3b3/0xcb0 fs/quota/dquot.c:1505
       ocfs2_get_init_inode+0x13b/0x1b0 fs/ocfs2/namei.c:202
       ocfs2_mknod+0x863/0x2050 fs/ocfs2/namei.c:310
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f4/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       dquot_release+0x66/0x600 fs/quota/dquot.c:531
       ext4_release_dquot+0x3ee/0x6c0 fs/ext4/ext4_jbd2.h:-1
       quota_release_workfn+0x35f/0x610 fs/quota/dquot.c:840
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (sb_internal){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_write+0x54/0x330 kernel/locking/percpu-rwsem.c:232
       sb_wait_write fs/super.c:1900 [inline]
       freeze_super+0x8b7/0x1130 fs/super.c:2183
       fs_bdev_freeze+0x1a3/0x310 fs/super.c:1529
       bdev_freeze+0xd8/0x220 block/bdev.c:298
       ext4_force_shutdown+0x322/0x560 fs/ext4/ioctl.c:822
       ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1587 [inline]
       ext4_ioctl+0x1d39/0x3510 fs/ext4/ioctl.c:1626
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_pagefaults){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1795 [inline]
       sb_start_pagefault include/linux/fs.h:1960 [inline]
       ext4_page_mkwrite+0x1e3/0x1110 fs/ext4/inode.c:6576
       do_page_mkwrite+0x14a/0x310 mm/memory.c:3378
       do_shared_fault mm/memory.c:5666 [inline]
       do_fault mm/memory.c:5728 [inline]
       do_pte_missing mm/memory.c:4251 [inline]
       handle_pte_fault mm/memory.c:6069 [inline]
       __handle_mm_fault+0x1a60/0x5620 mm/memory.c:6212
       handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
       do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:68
       copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
       copy_to_user_iter lib/iov_iter.c:25 [inline]
       iterate_ubuf include/linux/iov_iter.h:30 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
       iterate_and_advance include/linux/iov_iter.h:328 [inline]
       _copy_to_iter+0x24c/0x16f0 lib/iov_iter.c:185
       copy_to_iter include/linux/uio.h:220 [inline]
       seq_read_iter+0xbeb/0xe10 fs/seq_file.c:281
       new_sync_read fs/read_write.c:491 [inline]
       vfs_read+0x4cd/0x980 fs/read_write.c:572
       ksys_read+0x145/0x250 fs/read_write.c:715
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_pagefaults --> &ocfs2_quota_ip_alloc_sem_key --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mm->mmap_lock);
                               lock(&ocfs2_quota_ip_alloc_sem_key);
                               lock(&mm->mmap_lock);
  rlock(sb_pagefaults);

 *** DEADLOCK ***

3 locks held by syz.9.925/12720:
 #0: ffff8880318307f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1217
 #1: ffff8880383a29e0 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xb7/0xe10 fs/seq_file.c:182
 #2: ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:431 [inline]
 #2: ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:188 [inline]
 #2: ffff88807a2fcb60 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x300 mm/mmap_lock.c:248

stack backtrace:
CPU: 1 UID: 0 PID: 12720 Comm: syz.9.925 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1795 [inline]
 sb_start_pagefault include/linux/fs.h:1960 [inline]
 ext4_page_mkwrite+0x1e3/0x1110 fs/ext4/inode.c:6576
 do_page_mkwrite+0x14a/0x310 mm/memory.c:3378
 do_shared_fault mm/memory.c:5666 [inline]
 do_fault mm/memory.c:5728 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x1a60/0x5620 mm/memory.c:6212
 handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:74
Code: 00 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 e9 0f 00 04 00 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc90003c8fa58 EFLAGS: 00050202
RAX: ffffffff84b83201 RBX: ffff88807c14c000 RCX: 00000000000004a1
RDX: 0000000000000000 RSI: ffff88807c14c000 RDI: 00002000000061c0
RBP: ffffc90003c8fbb0 R08: ffff88807c14c4a0 R09: 1ffff1100f829894
R10: dffffc0000000000 R11: ffffed100f829895 R12: 1ffff92000791faf
R13: 00002000000061c0 R14: ffffc90003c8fd88 R15: 00000000000004a1
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
 copy_to_user_iter lib/iov_iter.c:25 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x24c/0x16f0 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:220 [inline]
 seq_read_iter+0xbeb/0xe10 fs/seq_file.c:281
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x4cd/0x980 fs/read_write.c:572
 ksys_read+0x145/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bba18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bbb0c4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f3bba3b5fa0 RCX: 00007f3bba18e929
RDX: 0000000000002020 RSI: 00002000000061c0 RDI: 0000000000000005
RBP: 00007f3bba210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3bba3b5fa0 R15: 00007ffe94043458
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 04 00             	add    %al,(%rax,%rax,1)
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00
   d:	0f 1f 00             	nopl   (%rax)
  10:	48 8b 06             	mov    (%rsi),%rax
  13:	48 89 07             	mov    %rax,(%rdi)
  16:	48 83 c6 08          	add    $0x8,%rsi
  1a:	48 83 c7 08          	add    $0x8,%rdi
  1e:	83 e9 08             	sub    $0x8,%ecx
  21:	74 db                	je     0xfffffffe
  23:	83 f9 08             	cmp    $0x8,%ecx
  26:	73 e8                	jae    0x10
  28:	eb c5                	jmp    0xffffffef
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	e9 0f 00 04 00       	jmp    0x40040
  31:	48 8b 06             	mov    (%rsi),%rax
  34:	48 89 07             	mov    %rax,(%rdi)
  37:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3b:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3f:	48                   	rex.W


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

