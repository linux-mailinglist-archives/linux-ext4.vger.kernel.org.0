Return-Path: <linux-ext4+bounces-5509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE889E7E6B
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Dec 2024 06:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092DC16D153
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Dec 2024 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9370807;
	Sat,  7 Dec 2024 05:42:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E625757
	for <linux-ext4@vger.kernel.org>; Sat,  7 Dec 2024 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733550146; cv=none; b=EpBOAp88UPyu8CQKfxp7udMJMcgaVa7F9tTde8t/oEJYI1e0zkjfTt6Sq1Dp4Icy/RjY9ok77HbGpkAX3rpmUrVq5e1xLxL6CHOYlI/EmJ3YzMICp4aeYtkw5iGwITOjeUur9awXDy4tUA6zeoQ+xWYXLi2WpIKN+ScNBxv8UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733550146; c=relaxed/simple;
	bh=agSj5euGE96AgpEZgZmN4F+E90mddVoSdkT8caGO/jk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SChb2apYpMmVAzbRq3VmUjt/GJZeKlOSypHegJtN2ix3zwhbkn0yTTsjPsgQZZFUsL2p5xSbTrerc/9eVxmKGSdUWJ+GY76ZMscouofRK7mN1tivoIlrmhpHSKPEBOUXHQkElrceJCfD0fBtH588gGW70kZseEi6iF+zy2gSGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so13000125ab.1
        for <linux-ext4@vger.kernel.org>; Fri, 06 Dec 2024 21:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733550144; x=1734154944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IICsInOSRxyf9z7lbabD6oZlJPSVLwlFpLnVa4jq608=;
        b=QxnDDQpJrjydUgZNNDJM+P+R7SAotRAQxGcDxiiTpgHCMv/jRZTc8lqrkp9N2nJIZq
         joZ9NNxITV3QmNlRC0WGrkqR1NIQKa3Dd30sWzBqom8w7+z+7S5l3PmrhYXCsWq9Ml38
         diyexUwM2c1X+LiWlbz/c5HKkUc3MP58TRCJf/HmVR/4eJwn2hAPs4q7zhL3rDAoY6hg
         k31MJh+6hXTMvHlHJ40NdTaP8P7rRAqDpZqU+QmUEqmAQnn9btyVDvsASBRedw8Vtd2D
         LZ1se6iUdD5RAqoDZrXFUB46fiVLRub/bIab5B1KOV11hv28RPH9zTW3PrxV2FXsSfCm
         w6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWJPMThcVLXd00i8Z02jdShGwA9q+c/YfoGMOr71W+0b1gHe2ZYmsyUNzsFKWw0/pHvEfBGgGJtPElC@vger.kernel.org
X-Gm-Message-State: AOJu0YxuceOPQZVawfbGGHYuuLtMWnRUykRJ4/ka3jdtPeozcwSoHhjB
	IxY84kJu01X6tY8K5ZEHZOw78XiBNXfeULQJly7JwLyZA4/DkxFOFl+PS7NXvo8lidy1sQgie0r
	fDcTQxoE5J3Z/SxpH0xS6MEd3fP6EIvHitSogMnLpTht10PDSYDwzHRQ=
X-Google-Smtp-Source: AGHT+IHWUMnZg/aZcoh1CvBWoWaI4sIDEvADi5vfoQtAOmuPIsfHdyKYgPlNuzp5LXY0IREEQBXcliT5p5ooOTYkl7XblHaqOggn
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:b0:3a7:e069:95e0 with SMTP id
 e9e14a558f8ab-3a811c7a00amr62160975ab.1.1733550144022; Fri, 06 Dec 2024
 21:42:24 -0800 (PST)
Date: Fri, 06 Dec 2024 21:42:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6753e03f.050a0220.a30f1.0152.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_truncate
From: syzbot <syzbot+449c80b8f4946f26184b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15898330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=449c80b8f4946f26184b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/658bd206f462/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12cb86080d87/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5181aac6587a/bzImage-cdd30ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+449c80b8f4946f26184b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0 Not tainted
------------------------------------------------------
syz-executor/11503 is trying to acquire lock:
ffff88807abcdbb0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4212

but task is already holding lock:
ffff888034d3a610 (sb_internal){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
ffff888034d3a610 (sb_internal){++++}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1908 [inline]
ffff888034d3a610 (sb_internal){++++}-{0:0}, at: ext4_evict_inode+0x2f4/0xf50 fs/ext4/inode.c:217

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sb_internal){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       percpu_down_write+0x54/0x310 kernel/locking/percpu-rwsem.c:229
       sb_wait_write fs/super.c:1910 [inline]
       freeze_super+0x7cc/0xee0 fs/super.c:2118
       fs_bdev_freeze+0x1ac/0x320 fs/super.c:1484
       bdev_freeze+0xd8/0x220 block/bdev.c:257
       ext4_force_shutdown+0x319/0x550 fs/ext4/ioctl.c:822
       ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1580 [inline]
       ext4_ioctl+0x2145/0x58d0 fs/ext4/ioctl.c:1619
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sb_pagefaults){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_pagefault include/linux/fs.h:1890 [inline]
       ext4_page_mkwrite+0x1ef/0xdf0 fs/ext4/inode.c:6158
       do_page_mkwrite+0x19a/0x480 mm/memory.c:3176
       do_shared_fault mm/memory.c:5398 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x1235/0x68a0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
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
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:651
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

-> #1 (&q->q_usage_counter(io)#26){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       ext4_read_block_bitmap_nowait+0x7c5/0xa80 fs/ext4/balloc.c:551
       ext4_mb_init_cache+0x484/0x1670 fs/ext4/mballoc.c:1337
       ext4_mb_init_group+0x324/0x6f0 fs/ext4/mballoc.c:1543
       ext4_mb_load_buddy_gfp+0xd83/0x1490 fs/ext4/mballoc.c:1613
       ext4_mb_clear_bb fs/ext4/mballoc.c:6451 [inline]
       ext4_free_blocks+0xc9c/0x2240 fs/ext4/mballoc.c:6652
       ext4_remove_blocks fs/ext4/extents.c:2547 [inline]
       ext4_ext_rm_leaf fs/ext4/extents.c:2712 [inline]
       ext4_ext_remove_space+0x240f/0x4e00 fs/ext4/extents.c:2961
       ext4_ext_truncate+0x159/0x2b0 fs/ext4/extents.c:4466
       ext4_truncate+0xa1b/0x11c0 fs/ext4/inode.c:4217
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
       ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4212
       ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
       evict+0x4ea/0x9a0 fs/inode.c:796
       __dentry_kill+0x20d/0x630 fs/dcache.c:625
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1070
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1097
       shrink_dcache_parent+0xcb/0x3b0
       do_one_tree+0x23/0xe0 fs/dcache.c:1560
       shrink_dcache_for_umount+0xb4/0x180 fs/dcache.c:1577
       generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
       kill_block_super+0x44/0x90 fs/super.c:1710
       ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7379
       deactivate_locked_super+0xc6/0x130 fs/super.c:473
       cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
       task_work_run+0x251/0x310 kernel/task_work.c:239
       exit_task_work include/linux/task_work.h:43 [inline]
       do_exit+0xa2f/0x28e0 kernel/exit.c:938
       do_group_exit+0x207/0x2c0 kernel/exit.c:1087
       __do_sys_exit_group kernel/exit.c:1098 [inline]
       __se_sys_exit_group kernel/exit.c:1096 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
       x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem --> sb_pagefaults --> sb_internal

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal);
                               lock(sb_pagefaults);
                               lock(sb_internal);
  lock(&ei->i_data_sem);

 *** DEADLOCK ***

2 locks held by syz-executor/11503:
 #0: ffff888034d3a0e0 (&type->s_umount_key#31){++++}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888034d3a0e0 (&type->s_umount_key#31){++++}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888034d3a0e0 (&type->s_umount_key#31){++++}-{4:4}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
 #1: ffff888034d3a610 (sb_internal){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
 #1: ffff888034d3a610 (sb_internal){++++}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1908 [inline]
 #1: ffff888034d3a610 (sb_internal){++++}-{0:0}, at: ext4_evict_inode+0x2f4/0xf50 fs/ext4/inode.c:217

stack backtrace:
CPU: 1 UID: 0 PID: 11503 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
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
 ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4212
 ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
 evict+0x4ea/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:625
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1070
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1097
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1560
 shrink_dcache_for_umount+0xb4/0x180 fs/dcache.c:1577
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_block_super+0x44/0x90 fs/super.c:1710
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7379
 deactivate_locked_super+0xc6/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x251/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f491ef7ff19
Code: Unable to access opcode bytes at 0x7f491ef7feef.
RSP: 002b:00007ffe9eda7068 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f491eff38a8 RCX: 00007f491ef7ff19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000027 R08: 00007ffe9eda4e06 R09: 00007ffe9eda8320
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe9eda8320
R13: 00007f491eff3824 R14: 0000555583b794a8 R15: 00007ffe9edaa4d0
 </TASK>
EXT4-fs (loop2): unmounting filesystem 00000000-0000-0000-0000-000000000000.


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

