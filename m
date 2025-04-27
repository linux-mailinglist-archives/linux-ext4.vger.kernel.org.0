Return-Path: <linux-ext4+bounces-7515-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD51A9E52C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Apr 2025 01:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11ED13B9AB8
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Apr 2025 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBA209F45;
	Sun, 27 Apr 2025 23:54:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263A1D5145
	for <linux-ext4@vger.kernel.org>; Sun, 27 Apr 2025 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745798081; cv=none; b=r10+XzZ0rGhYltvNF9LlJPEPiGh3BPSu4xiZgfOGxikfCG4+3D5MAGJzxvK+i2XXi8eyYswNlLcEVgwmBz5xuauo3wz/g9RB5OVV573AZed/+Hjhg02AexroYHYKWSaF60vEtJbw4WZQjvkEblZJqWB5HoXTjZHFpGl1ZFC7jPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745798081; c=relaxed/simple;
	bh=rMqEFN1egf2aHHHGN86WmYhnXn6rhA9ofpxVJe8Unww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dl+dm7nESSPoT7j2y+WKsLhuCcrRSy2zh/tq0HGp0mRPleeUzkN9J+T7RUU9oeHMYhG6004fZ8+M6gZmBQc0QEWtoBzeRqr/5ztkQz78BWf/vmldvLJaRUKd5NNAx4NCE0MFjiOfYBeq4yIr5qljI0tJFyQPKAB8FvkV4JNJc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e15e32379so366850139f.3
        for <linux-ext4@vger.kernel.org>; Sun, 27 Apr 2025 16:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745798079; x=1746402879;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdmGM5pWs5G6H2D1CDDqIcJYwh0/Bf03m5zyyYzYats=;
        b=G7LzHT+TyV2BZFaUmK3sUoFpc1Etb7LWO8kGxKQxqX6f4q5VzmZCxkWLQ86qOrnGgO
         1Rhr3T8O92enipbhq4j7+74keAPWs5rv7Um6prOu9MAunbZA3NGzbejuoBdhGY80nvfM
         drZv9tw7XnRHJeBq7SqLiwEmaqk836oixptASJ1BPSnVrLhGyppkwRe7k42je0DBV+4E
         CIeEPMtyaKiytSTZskLFoQkS7bf+VqwFH4HQ6SCXPaspJTVwDaN42E+h+qnUeEOKikuX
         9XQd6rIZglc465l9iKJ7oCvnVRy2gj08I4ZpoPZ9QPEBEMA1f6lOuP+BuNiY8eMo7jAO
         2VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiB8oY6zJ4mjsyckYM8VSxgVWHLnIOExpqGxIMoUCNymsPWGMyluygXNh1NyZMFYttVJ73KR8zvjiC@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNZgndvnci6kpYqafsIXCVXAz8890I9yAEVTSGsSA+eps3ZpI
	mODDmDpEgei70qbYVrno8LK4F0LGOrUxkVKH+H1RgJfQnZv/wHhTQJsYeRYmaUDRmaexXFp6QWM
	Xq8M74R4YwmoiN38DpHiTo32jgDDQnHouSexmwugmeIxO2fgig+WErRk=
X-Google-Smtp-Source: AGHT+IF21i7cMaHKvHR2Ka0IgfFN496dChE2mLe1VDTOpyxC3IeQImsSoGjo967S4eG4O0czViNvBb7jePahPCSEGhWJ+I8+840B
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1583:b0:864:4a24:3e90 with SMTP id
 ca18e2360f4ac-86467faf5abmr605579639f.10.1745798078775; Sun, 27 Apr 2025
 16:54:38 -0700 (PDT)
Date: Sun, 27 Apr 2025 16:54:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680ec3be.a70a0220.23e4d2.0029.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_convert_inline_data
From: syzbot <syzbot+3a250b71df6ff0bb5f9e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a79be02bba5c Fix mis-uses of 'cc-option' for warning disab..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6e574580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45c3bf6fd4cb6a10
dashboard link: https://syzkaller.appspot.com/bug?extid=3a250b71df6ff0bb5f9e
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1908a8496ce/disk-a79be02b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f87bf4ee84e/vmlinux-a79be02b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62c73ed1bb67/bzImage-a79be02b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a250b71df6ff0bb5f9e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc3-syzkaller-00032-ga79be02bba5c #0 Not tainted
------------------------------------------------------
syz.5.2525/14970 is trying to acquire lock:
ffff8880569e59f0 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff8880569e59f0 (&ei->xattr_sem){++++}-{4:4}, at: ext4_convert_inline_data+0x3be/0x630 fs/ext4/inline.c:1994

but task is already holding lock:
ffff8880569e5f00 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
ffff8880569e5f00 (mapping.invalidate_lock){++++}-{4:4}, at: ext4_page_mkwrite+0x224/0x1130 fs/ext4/inode.c:6223

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       down_read+0xb3/0xa50 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
       page_cache_ra_unbounded+0x156/0x820 mm/readahead.c:228
       do_async_mmap_readahead mm/filemap.c:3290 [inline]
       filemap_fault+0x6ce/0x13d0 mm/filemap.c:3389
       __do_fault+0x137/0x390 mm/memory.c:5098
       do_read_fault mm/memory.c:5518 [inline]
       do_fault mm/memory.c:5652 [inline]
       do_pte_missing mm/memory.c:4160 [inline]
       handle_pte_fault+0x3f0c/0x61c0 mm/memory.c:5997
       __handle_mm_fault mm/memory.c:6140 [inline]
       handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
       faultin_page mm/gup.c:1193 [inline]
       __get_user_pages+0x1adc/0x4180 mm/gup.c:1491
       __get_user_pages_locked mm/gup.c:1757 [inline]
       get_dump_page+0x1e1/0x460 mm/gup.c:2275
       dump_user_range+0x22c/0xef0 fs/coredump.c:953
       elf_core_dump+0x4098/0x4af0 fs/binfmt_elf.c:2128
       do_coredump+0x22c5/0x3260 fs/coredump.c:759
       get_signal+0x13ed/0x1730 kernel/signal.c:3019
       arch_do_signal_or_restart+0x98/0x810 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
       exc_page_fault+0x5f8/0x920 arch/x86/mm/fault.c:1541
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __might_fault+0xc6/0x120 mm/memory.c:7151
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x237/0x420 fs/ioctl.c:145
       ocfs2_fiemap+0xa07/0x1020 fs/ocfs2/extent_map.c:806
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1977/0x2750 fs/ioctl.c:840
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl+0x80/0x160 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       down_write+0x9c/0x220 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x1e5/0x1dd0 fs/ocfs2/quota_local.c:1232
       ocfs2_acquire_dquot+0x843/0xb80 fs/ocfs2/quota_global.c:883
       dqget+0x772/0xeb0 fs/quota/dquot.c:977
       __dquot_initialize+0x335/0xfc0 fs/quota/dquot.c:1505
       ocfs2_get_init_inode+0x15a/0x1d0 fs/ocfs2/namei.c:202
       ocfs2_mknod+0xcfe/0x2b30 fs/ocfs2/namei.c:310
       ocfs2_mkdir+0x19c/0x470 fs/ocfs2/namei.c:656
       vfs_mkdir+0x2fb/0x500 fs/namei.c:4359
       do_mkdirat+0x273/0x3f0 fs/namei.c:4392
       __do_sys_mkdirat fs/namei.c:4409 [inline]
       __se_sys_mkdirat fs/namei.c:4407 [inline]
       __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4407
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       wait_on_dquot fs/quota/dquot.c:354 [inline]
       dqget+0x6e6/0xeb0 fs/quota/dquot.c:972
       dquot_transfer+0x4a8/0x6f0 fs/quota/dquot.c:2154
       ext4_setattr+0xb2e/0x1c60 fs/ext4/inode.c:5460
       notify_change+0xbcc/0xe90 fs/attr.c:552
       chown_common+0x503/0x850 fs/open.c:782
       vfs_fchown fs/open.c:850 [inline]
       ksys_fchown+0xe2/0x150 fs/open.c:862
       __do_sys_fchown fs/open.c:867 [inline]
       __se_sys_fchown fs/open.c:865 [inline]
       __x64_sys_fchown+0x7a/0x90 fs/open.c:865
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       down_write+0x9c/0x220 kernel/locking/rwsem.c:1577
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_convert_inline_data+0x3be/0x630 fs/ext4/inline.c:1994
       ext4_page_mkwrite+0x231/0x1130 fs/ext4/inode.c:6225
       do_page_mkwrite+0x15b/0x340 mm/memory.c:3287
       wp_page_shared mm/memory.c:3688 [inline]
       do_wp_page+0x2b7e/0x5dc0 mm/memory.c:3907
       handle_pte_fault+0xfaf/0x61c0 mm/memory.c:6013
       __handle_mm_fault mm/memory.c:6140 [inline]
       handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
       do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x45b/0x920 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> &mm->mmap_lock --> mapping.invalidate_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.5.2525/14970:
 #0: ffff888032d201c8 (vm_lock){++++}-{0:0}, at: do_user_addr_fault arch/x86/mm/fault.c:1328 [inline]
 #0: ffff888032d201c8 (vm_lock){++++}-{0:0}, at: handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 #0: ffff888032d201c8 (vm_lock){++++}-{0:0}, at: exc_page_fault+0x17d/0x920 arch/x86/mm/fault.c:1538
 #1: ffff888057f00518 (sb_pagefaults){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1783 [inline]
 #1: ffff888057f00518 (sb_pagefaults){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1948 [inline]
 #1: ffff888057f00518 (sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x1fa/0x1130 fs/ext4/inode.c:6220
 #2: ffff8880569e5f00 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
 #2: ffff8880569e5f00 (mapping.invalidate_lock){++++}-{4:4}, at: ext4_page_mkwrite+0x224/0x1130 fs/ext4/inode.c:6223

stack backtrace:
CPU: 0 UID: 0 PID: 14970 Comm: syz.5.2525 Not tainted 6.15.0-rc3-syzkaller-00032-ga79be02bba5c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2079
 check_noncircular+0x142/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
 __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
 lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
 down_write+0x9c/0x220 kernel/locking/rwsem.c:1577
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_convert_inline_data+0x3be/0x630 fs/ext4/inline.c:1994
 ext4_page_mkwrite+0x231/0x1130 fs/ext4/inode.c:6225
 do_page_mkwrite+0x15b/0x340 mm/memory.c:3287
 wp_page_shared mm/memory.c:3688 [inline]
 do_wp_page+0x2b7e/0x5dc0 mm/memory.c:3907
 handle_pte_fault+0xfaf/0x61c0 mm/memory.c:6013
 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x45b/0x920 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fcf3d254f23
Code: 8b 44 24 08 48 85 c0 74 17 48 8b 54 24 18 48 0f ca 48 89 54 24 18 48 83 f8 01 0f 85 7a 02 00 00 48 8b 44 24 10 48 8b 54 24 18 <48> 89 10 e9 d2 fd ff ff 48 8b 44 24 10 0f b7 10 48 8b 44 24 08 48
RSP: 002b:00007fffdaeef8b0 EFLAGS: 00010246
RAX: 0000200000000500 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 000000000000000a RSI: 0000000000000000 RDI: 00005555682533c8
RBP: 00007fffdaeef9b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007fcf3d5b5fac
R13: 00007fcf3d5b5fa0 R14: fffffffffffffffe R15: 00007fffdaeefa00
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

