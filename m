Return-Path: <linux-ext4+bounces-5638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B69F19BB
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2024 00:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE893164E13
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF61E25FE;
	Fri, 13 Dec 2024 23:14:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003F1ADFF7
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131661; cv=none; b=SYTybuUArrn9jo9wWnD+vm7AKjoQg+5CB73Blq+nTvjk3o/QGjhpcjUkexT8cUjVtl9t3dbFmEs6PFl/ImYnGCKN6zPHWDBMGgLtrVqpk6HSpISg2C5F0dd2ctUt39CU6Kcx3y3MaLh1+75CTnosR+e9ISklJLO7Zljlv9tgrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131661; c=relaxed/simple;
	bh=jaxFh8Nn8ohlj6gkUZGm9jynC5BerdJjKoc17c54Oxc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KOHCaFaOj1CGkO3IW1bOhSR2kB5vXv+VXkOQnrhhK1PfxGZisoPale/vImaat4sfKHPTUt/GUD0NdwFrm3KR0UHTUy2TTIN8g7ReVVpBAqOfYPFbiYUKYxXi+uE2rbFkVW1qnq1+fQ6Pjs9PxZnqM7XNC19JTBtE3gyREQ7kUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so20594455ab.0
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 15:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131659; x=1734736459;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wPCOYhj2vuriXvPK+6LmgQ2FXcbqD4anxq+uHwli1I=;
        b=QukATZvSiNhBkBmViyqMJ75aUZE2L5zpplkuJG341t5cXoVBksOL0gs73N8BxhfTbV
         fdmCmFYj1edkWawjYqg5lbK9kwuzL2MUjaX2zGeKZ2oDlbW8yDYWWuoEcvRN+ZZ2wKc7
         NlJc6CV01BBdkGpK4jsQfuVm9U08OmEVFOmc5XHKxIU4QQFNoOyL13XCbVPeSfI1UN82
         nvPejKW37J3wW9OCbx6YSiIhNzBRHLSEh72wFXh0eDfEKIVt8x5aI7r9U+rQ7FYid2RW
         T/Smid15LvJn46MajIJrjWN91lbOHLpJlHtrWd6rftiGYT5hXZJ5IrSB1+xrWTHJbMM6
         gagg==
X-Forwarded-Encrypted: i=1; AJvYcCVZABFaxE4VJjkSEQle1snT2vpL+tFSnlT206D04HN+k9KWUd4MyJ92jJx4UguP+GvuldyqBTSYOAmD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4UKxUIVoUzNf0qYiEsE34brgfAXuH9+6c5yQUd0wurqCKYub
	DSmjz5Il1yizFSVb2/sw5KRuhHZbljydCFJxp9Xi1vtB7ye1KcvvY9OsklxjoMYAN0PNJV0cfdn
	rZzITqWezg+cQl07mGuUXEQjNnX+Hf3r+Yupu92rIFewD/3TLfTyClb0=
X-Google-Smtp-Source: AGHT+IF1vXs3h44b1xA95pwXtDb3NQg/8PFPDiKIZySGHxxesOjastDLOcv4lS/UobriZiWgSxDv6P/YZU2DWm59EKj/+ZcBhtXR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3a7:e732:4713 with SMTP id
 e9e14a558f8ab-3affab6228amr45296445ab.15.1734131658854; Fri, 13 Dec 2024
 15:14:18 -0800 (PST)
Date: Fri, 13 Dec 2024 15:14:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675cbfca.050a0220.37aaf.00b7.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_setattr (3)
From: syzbot <syzbot+5854ffe0f8a3c5de4d2d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b493e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=5854ffe0f8a3c5de4d2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2eacff0ec321/disk-7cb1b466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/281b74c06488/vmlinux-7cb1b466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cbe1843a221e/bzImage-7cb1b466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5854ffe0f8a3c5de4d2d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0 Not tainted
------------------------------------------------------
syz.4.5825/19470 is trying to acquire lock:
ffff88805c2e9658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_setattr+0x16e1/0x1da0 fs/ext4/inode.c:5504

but task is already holding lock:
ffff88805c2e9968 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock include/linux/fs.h:863 [inline]
ffff88805c2e9968 (mapping.invalidate_lock){++++}-{4:4}, at: ext4_setattr+0xf94/0x1da0 fs/ext4/inode.c:5452

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x142/0x720 mm/readahead.c:226
       do_async_mmap_readahead mm/filemap.c:3231 [inline]
       filemap_fault+0x818/0x1490 mm/filemap.c:3330
       __do_fault+0x137/0x390 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x39eb/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1494
       __get_user_pages_locked mm/gup.c:1760 [inline]
       get_dump_page+0x155/0x2f0 mm/gup.c:2278
       dump_user_range+0x14d/0x970 fs/coredump.c:943
       elf_core_dump+0x3e9f/0x4790 fs/binfmt_elf.c:2129
       do_coredump+0x229d/0x3100 fs/coredump.c:758
       get_signal+0x140b/0x1750 kernel/signal.c:3002
       arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
       exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1542
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1013/0xbce0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:949 [inline]
       loop_reconfigure_limits+0x43f/0x900 drivers/block/loop.c:998
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
       blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       __ext4_read_bh fs/ext4/super.c:181 [inline]
       ext4_read_bh+0x1d7/0x290 fs/ext4/super.c:206
       ext4_get_branch+0x37f/0x790 fs/ext4/indirect.c:173
       ext4_ind_map_blocks+0x31d/0x29e0 fs/ext4/indirect.c:554
       ext4_map_query_blocks+0x80/0x2c0 fs/ext4/inode.c:470
       ext4_map_blocks+0x3d0/0x1990 fs/ext4/inode.c:666
       _ext4_get_block+0x239/0x6b0 fs/ext4/inode.c:781
       ext4_get_block fs/ext4/inode.c:798 [inline]
       __ext4_block_zero_page_range fs/ext4/inode.c:3718 [inline]
       ext4_block_zero_page_range+0x353/0xaf0 fs/ext4/inode.c:3798
       ext4_block_truncate_page fs/ext4/inode.c:3822 [inline]
       ext4_truncate+0x95f/0x11c0 fs/ext4/inode.c:4197
       ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
       ext4_orphan_cleanup+0xb77/0x13d0 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5610 [inline]
       ext4_fill_super+0x64dc/0x6e60 fs/ext4/super.c:5733
       get_tree_bdev_flags+0x48e/0x5c0 fs/super.c:1636
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->i_data_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ext4_setattr+0x16e1/0x1da0 fs/ext4/inode.c:5504
       notify_change+0xbcc/0xe90 fs/attr.c:552
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3449 [inline]
       do_open fs/namei.c:3832 [inline]
       path_openat+0x2e1e/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_creat fs/open.c:1495 [inline]
       __se_sys_creat fs/open.c:1489 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1489
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem --> &mm->mmap_lock --> mapping.invalidate_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock);
  lock(&ei->i_data_sem);

 *** DEADLOCK ***

3 locks held by syz.4.5825/19470:
 #0: ffff88805b162420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88805c2e97c8 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #1: ffff88805c2e97c8 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: do_truncate+0x20c/0x310 fs/open.c:63
 #2: ffff88805c2e9968 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock include/linux/fs.h:863 [inline]
 #2: ffff88805c2e9968 (mapping.invalidate_lock){++++}-{4:4}, at: ext4_setattr+0xf94/0x1da0 fs/ext4/inode.c:5452

stack backtrace:
CPU: 1 UID: 0 PID: 19470 Comm: syz.4.5825 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 ext4_setattr+0x16e1/0x1da0 fs/ext4/inode.c:5504
 notify_change+0xbcc/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3449 [inline]
 do_open fs/namei.c:3832 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc608b7fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc609a11058 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fc608d45fa0 RCX: 00007fc608b7fed9
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000020000000
RBP: 00007fc608bf3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc608d45fa0 R15: 00007ffddebaed38
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

