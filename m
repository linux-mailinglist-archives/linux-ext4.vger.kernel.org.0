Return-Path: <linux-ext4+bounces-7588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C4AA57E6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 00:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6B1BA835B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF32248A0;
	Wed, 30 Apr 2025 22:14:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53D224236
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051285; cv=none; b=FT1S6xayKLItuDx/DTPbBqZTkZAIlvaa8zrm6DmKyTZAsfjRTVLgTugzFZAqEN2cPOZJC5QPZ0FkFQe9Ijm4PXKeAzmjLMdjZ8Woz0bvvjY3PZzQosIWJzEtj/KYHmsH352onyqxIvffOiytac5xwURNtP6+7uiRzI4BDBKCVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051285; c=relaxed/simple;
	bh=0h1NYLHKKQO8xNOFU3JaptHF9JQiumD8c9vIKxJ7uuM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kZCF3Go10YsdL1+SCIxuyFL362A+d6R6ppRH2b8yq9E3ufhfLgus2qdRh1tbA1sAvaAAjSkhI4EyiEThFp7XSOtRDqWNdDFuaDoCm3aMKk4Zua2w6vT4t7Km3ywtDp/4DttuCInKPo7sAhsk98sqNt2o9DN1Ki1zKNlq55pah+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b418faf73so62617039f.1
        for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 15:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746051283; x=1746656083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qulvkSDgTUE3F613OTvj6ZmGvYb59XUlgi8UTJ5lJa4=;
        b=ntHBHdwaabXYqwTBOgNBrUKFe3KWjjSdGs9oB9H/3OlfWv2nKudka/Ho7nsHLNrVqf
         gca07TtyIjm2waNV35X5oqki+lB8gCG2ZQgorq+D+FWfBqd7K8XtgmB0j7peqQFj8zPy
         vYrhgdhIBt1ys2tBpmb7oywQkj5uNqFQ81GmTyDFcJ45OINVLCnaq2zcP6OgpE7Z39IU
         jFB34ZeZHPDWCK84FRLc6ueTJdGWVM5mo4/Zh/9QbToToD49y2eyEjrl2IsD9Zotq8lt
         k9ZSU92uAox5vULXdwDmQ/1+jlA8W+6FWp3Js/5SH+doJAAkbj5Ip55YjuzOmQ/ghB1M
         bRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUREOdmyYxlW1N4dzODE9SpsB57o4UkM90A1zMIdlV5EU2FOVY5XUrnQL5ODHjpn2srmIez+2no61eK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wv9CX7jtG/I8g7Gc5Znn36CN5IEDtu9hYIBuHo1wiuNkxXI5
	PoMr/Ha9q2U8JGKBZGasypXVgmyCd09nNWbmmhDXAxiWYavHUJkw08xXzrDqkPt7BwgURz0eHan
	TpngkQ+KZwQRh0n16Zee0w68rqPckn9DAA9cJqaMvmbiHkVX2ISYP4Mc=
X-Google-Smtp-Source: AGHT+IEL4/kydLnlQJEm1L8aGvsPLjowqPqGWo86AOHjwDCtB3yx3JpxGrgTPHHhHX5xcfypTQCo/dC1/pwUKSrlKvFSrkruQ/AS
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a08:b0:861:628f:2d2b with SMTP id
 ca18e2360f4ac-864a33889d1mr50004339f.1.1746051283029; Wed, 30 Apr 2025
 15:14:43 -0700 (PDT)
Date: Wed, 30 Apr 2025 15:14:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6812a0d3.050a0220.3a872c.000a.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in freeze_super (3)
From: syzbot <syzbot+ddfdaf196c473805d049@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148950d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2f0ed2ec54b450e
dashboard link: https://syzkaller.appspot.com/bug?extid=ddfdaf196c473805d049
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e26a32e8357/disk-5bc10186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/43df25d1ae8f/vmlinux-5bc10186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af408167a8d1/bzImage-5bc10186.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddfdaf196c473805d049@syzkaller.appspotmail.com

EXT4-fs (loop1): shut down requested (0)
======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 Not tainted
------------------------------------------------------
syz.1.1609/17619 is trying to acquire lock:
ffff888068790610 (sb_internal){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
ffff888068790610 (sb_internal){++++}-{0:0}, at: freeze_super+0x7aa/0xeb0 fs/super.c:2063

but task is already holding lock:
ffff888068790518 (sb_pagefaults){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
ffff888068790518 (sb_pagefaults){++++}-{0:0}, at: freeze_super+0x4f1/0xeb0 fs/super.c:2049

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_pagefaults){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:52
       __sb_start_write include/linux/fs.h:1783 [inline]
       sb_start_pagefault include/linux/fs.h:1948 [inline]
       ext4_page_mkwrite+0x1de/0x1110 fs/ext4/inode.c:6220
       do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
       do_shared_fault mm/memory.c:5594 [inline]
       do_fault mm/memory.c:5656 [inline]
       do_pte_missing mm/memory.c:4160 [inline]
       handle_pte_fault mm/memory.c:5997 [inline]
       __handle_mm_fault+0x18d2/0x5380 mm/memory.c:6140
       handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
       do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1388
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       __might_fault+0xcc/0x130 mm/memory.c:7151
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
       ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1638/0x1eb0 fs/ioctl.c:840
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:1232
       ocfs2_acquire_dquot+0x80f/0xb30 fs/ocfs2/quota_global.c:883
       dqget+0x7ae/0xf10 fs/quota/dquot.c:977
       dquot_get_dqblk+0x22/0x60 fs/quota/dquot.c:2684
       quota_getquota+0x287/0x4f0 fs/quota/quota.c:214
       __do_sys_quotactl fs/quota/quota.c:961 [inline]
       __se_sys_quotactl+0x279/0x950 fs/quota/quota.c:917
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       dquot_release+0x66/0x600 fs/quota/dquot.c:531
       ext4_release_dquot+0x3ee/0x6c0 fs/ext4/ext4_jbd2.h:-1
       quota_release_workfn+0x35c/0x610 fs/quota/dquot.c:840
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
       kthread+0x70e/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (sb_internal){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
       __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       percpu_down_write+0x54/0x330 kernel/locking/percpu-rwsem.c:229
       sb_wait_write fs/super.c:1855 [inline]
       freeze_super+0x7aa/0xeb0 fs/super.c:2063
       fs_bdev_freeze+0x19f/0x310 fs/super.c:1484
       bdev_freeze+0xd5/0x220 block/bdev.c:298
       ext4_force_shutdown+0x322/0x560 fs/ext4/ioctl.c:822
       ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1581 [inline]
       ext4_ioctl+0x1d1d/0x34f0 fs/ext4/ioctl.c:1620
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_internal --> &mm->mmap_lock --> sb_pagefaults

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_pagefaults);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults);
  lock(sb_internal);

 *** DEADLOCK ***

4 locks held by syz.1.1609/17619:
 #0: ffff88802294c6b0 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff888068790420 (sb_writers#4){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff888068790420 (sb_writers#4){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
 #2: ffff8880687900e0 (&type->s_umount_key#30){++++}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #2: ffff8880687900e0 (&type->s_umount_key#30){++++}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #2: ffff8880687900e0 (&type->s_umount_key#30){++++}-{4:4}, at: freeze_super+0x4ca/0xeb0 fs/super.c:2045
 #3: ffff888068790518 (sb_pagefaults){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #3: ffff888068790518 (sb_pagefaults){++++}-{0:0}, at: freeze_super+0x4f1/0xeb0 fs/super.c:2049

stack backtrace:
CPU: 0 UID: 0 PID: 17619 Comm: syz.1.1609 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2079
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
 __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 percpu_down_write+0x54/0x330 kernel/locking/percpu-rwsem.c:229
 sb_wait_write fs/super.c:1855 [inline]
 freeze_super+0x7aa/0xeb0 fs/super.c:2063
 fs_bdev_freeze+0x19f/0x310 fs/super.c:1484
 bdev_freeze+0xd5/0x220 block/bdev.c:298
 ext4_force_shutdown+0x322/0x560 fs/ext4/ioctl.c:822
 ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1581 [inline]
 ext4_ioctl+0x1d1d/0x34f0 fs/ext4/ioctl.c:1620
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f10c5d8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f10c6c05038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f10c5fb5fa0 RCX: 00007f10c5d8e969
RDX: 00002000000003c0 RSI: 000000008004587d RDI: 0000000000000004
RBP: 00007f10c5e10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f10c5fb5fa0 R15: 00007ffe2f425698
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

