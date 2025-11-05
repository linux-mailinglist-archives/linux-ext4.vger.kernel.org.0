Return-Path: <linux-ext4+bounces-11504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A32C3824A
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652734E5D03
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0E2EF667;
	Wed,  5 Nov 2025 22:08:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C9287505
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380506; cv=none; b=mNM3NuQmj6KxqEyIxwwpqRtTBi1L/DNUr1+4+SVlt+uC5PLXtLvPCt2pGLzley5gNE+tSGPaJYFC0l6DX1MTBjh66XCZfP7l8J5cvk3iqZbMJ5ixl7nulEiWpm9XStFss5Wwq271M1JXF/rMi2S6YC1IiGVrIroUN9al4bBRKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380506; c=relaxed/simple;
	bh=jO5A6/0emAC0ankZQl2hqCF6Fyqyn2kff+AFOGzMyds=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nrifhJ7r01Moy+9r8PtKoA8M6IVF9HDVzC6wC/Qo88+rAWecogq4SsjWhmPcO1AB+QxyRVXULXN7pQrWw81eTv8oSyX02uqDEPmtANspadyK9FN0H5+NjEty593cJXGpMdconOD9qbNJzt+EUbjVi76umEOpY75WwXRQiHmKnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-433312ee468so4180685ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 14:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380503; x=1762985303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqMwYr3BjHdzinG8ZFoCorMwCsBmiueglpCVzEdIyys=;
        b=jiWjWiTFwnalYcb7SORWavECaIMVFpj9zbgbQAEbDb+kvCMiOib5xC6shVaHSjwA61
         tbgqxFSXsEEyKiYQziFzZcHb1Z+Ys3bjgNg+T2Gr/jjiwW2nY0yDI6oTzJEkMvp6Jf5s
         CowOifgJqlgH3/bwmCRU4ple32T3yGSOW6I2FNJaBYV81dAiuF+Spguv871FYlzWE5o7
         +7x2HiqHOCySNHuvFmuStuJ3QPfYpGQd2ag8pjhm6FBo929wgRbwDKhkV26CRaJibg7B
         Ad/zaxbqP2mqpMstrHIDRODGwl0yAlmmN1xtdyCrE1UC9R6g/Epk7r3XSmxBRQp1a3BN
         Cw5A==
X-Forwarded-Encrypted: i=1; AJvYcCXmz4433mIr6IOIYXMNY27UwxetDvUJUH67d3feuGdTiNElR6pwPl9W6HXbBJ5i5ihiBn4RYsPaa7Z5@vger.kernel.org
X-Gm-Message-State: AOJu0YzeB9MBy8eBz3pdgdyQmf/pCppeQU3oEaWdEYEevgacpZC8hEAq
	cc+u7e+46ah81lVjYCCToNYS3PS45DSwf8aDXBGbq/bNGffaInpPqJc4ujDOvHWJ7bsZ/thxeFV
	eF/v5nxA8e/ORACcBydBgoTFVejNYzH3TN8ofUm36fimqVgx/TIg/sU8FETo=
X-Google-Smtp-Source: AGHT+IFxZr/UvsGMSHTbKllzwqi/KTdS3u96fHeL+YXXSHHMTOgS48FzCeJ/mj1UNbG1bd9iomrxlgngiWKK6yE/RxDFQWPYbgyY
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:433:2dd5:f573 with SMTP id
 e9e14a558f8ab-4334ee28845mr20651065ab.3.1762380503691; Wed, 05 Nov 2025
 14:08:23 -0800 (PST)
Date: Wed, 05 Nov 2025 14:08:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bcad7.050a0220.baf87.0076.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data (2)
From: syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c353dc8d962 Merge tag 'media/v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f3a17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=bb2455d02bda0b5701e3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f64756196024/disk-1c353dc8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1384c2077fb/vmlinux-1c353dc8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfa64f995332/bzImage-1c353dc8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:8/30962 is trying to acquire lock:
ffff88807e672708 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff88807e672708 (&ei->xattr_sem){++++}-{4:4}, at: ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1787

but task is already holding lock:
ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
       ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
       do_writepages+0x32e/0x550 mm/page-writeback.c:2604
       __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
       writeback_single_inode+0x1f9/0x6a0 fs/fs-writeback.c:1840
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2903
       iput_final fs/inode.c:1901 [inline]
       iput+0x830/0xc50 fs/inode.c:1966
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2199
       ext4_xattr_move_to_block fs/ext4/xattr.c:2664 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2739 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2827
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6364
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6407 [inline]
       __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6485
       ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
       evict+0x504/0x9c0 fs/inode.c:810
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
       __ext4_fill_super fs/ext4/super.c:5617 [inline]
       ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5736
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2b0 fs/super.c:1751
       fc_mount fs/namespace.c:1208 [inline]
       do_new_mount_fc fs/namespace.c:3651 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3727
       do_mount fs/namespace.c:4050 [inline]
       __do_sys_mount fs/namespace.c:4238 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4215
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1787
       ext4_do_writepages+0x526/0x4610 fs/ext4/inode.c:2810
       ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32e/0x550 mm/page-writeback.c:2604
       __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
       writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
       wb_writeback+0x43b/0xaf0 fs/fs-writeback.c:2195
       wb_do_writeback fs/fs-writeback.c:2342 [inline]
       wb_workfn+0x409/0xef0 fs/fs-writeback.c:2382
       process_one_work kernel/workqueue.c:3263 [inline]
       process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by kworker/u8:8/30962:
 #0: ffff88801c69b948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88801c69b948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc9000b36fba0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc9000b36fba0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #2: ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
 #2: ffff8880277c4b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024

stack backtrace:
CPU: 0 UID: 0 PID: 30962 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: writeback wb_workfn (flush-7:4)
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1787
 ext4_do_writepages+0x526/0x4610 fs/ext4/inode.c:2810
 ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
 do_writepages+0x32e/0x550 mm/page-writeback.c:2604
 __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
 writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
 wb_writeback+0x43b/0xaf0 fs/fs-writeback.c:2195
 wb_do_writeback fs/fs-writeback.c:2342 [inline]
 wb_workfn+0x409/0xef0 fs/fs-writeback.c:2382
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
EXT4-fs error (device loop4): ext4_mb_generate_buddy:1289: group 0, block bitmap and bg descriptor inconsistent: 25 vs 4128793 free clusters
EXT4-fs (loop4): Delayed block allocation failed for inode 15 at logical offset 0 with max blocks 1 with error 28
EXT4-fs (loop4): This should not happen!! Data will be lost

EXT4-fs (loop4): Total free blocks count 0
EXT4-fs (loop4): Free/Dirty block details
EXT4-fs (loop4): free_blocks=66060288
EXT4-fs (loop4): dirty_blocks=64
EXT4-fs (loop4): Block reservation details
EXT4-fs (loop4): i_reserved_data_blocks=4
EXT4-fs (loop4): Delayed block allocation failed for inode 15 at logical offset 65537 with max blocks 44 with error 28


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

