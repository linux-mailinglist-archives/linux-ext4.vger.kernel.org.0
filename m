Return-Path: <linux-ext4+bounces-6047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71938A0ACB5
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BB1626FF
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2025 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E51C3306;
	Sun, 12 Jan 2025 23:44:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67514A614
	for <linux-ext4@vger.kernel.org>; Sun, 12 Jan 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736725461; cv=none; b=e2w5KQNANrDH3Cyx6WuYxgcL+hYojO7UkMIXqx4hdTEM5wkIVwpwnxrGrTitVN+4mAU/A4EYRLAS9mRXPQkMhcxKNXPRxTvZWuh11kTmQSowst2lTAZbhgGrHD5LLPrxvnml26VChau34+GzKsT1oKFKaQ/kye9VM+D5pONexDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736725461; c=relaxed/simple;
	bh=yWg/sMALD14XDEeWQQc8BNQm5FbSMrQpNx9LOoDbctI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bbf3Tm+nzU6Mu267rt5vx7g9/SsFzOPcM4In36hbiA54SasVjhVxYWun+0OeE/uCOjKM4NqlvbAx66Zkn4kG7pMN7s4z42gZjRpo97sU3dFCFQVXIXFGhwmdtugeP/5gvaNXUhXnHnFDSwZmXtWQqXd94C7HdQuTvlML7uiOsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so34468135ab.1
        for <linux-ext4@vger.kernel.org>; Sun, 12 Jan 2025 15:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736725459; x=1737330259;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Etkj0m1DR+Kn3sOd56Qqb351ClCiSDfJlFXDnLFyvP0=;
        b=n+KZAeSkgeONJ+SVp/Ps+GDNdIQPxK1S1Xm+cwt/68RDqqU6EeVt/CM0NmRZCprv4L
         /WvNLVyACn1I+zPF950kCKNDL7sXU268Ro32zUyWfy2c+3wx95clrziMa/RxGbPlz//O
         dc1aDi7JSthItiYHzOZsecVOWb608SafvPEli3GmxZbCUXV6zAxbeU8CIcFwP+noz55Z
         LVmcK1MLYuZhu//YVZnL6RtLJFs9KUznleOgKhovSl03zKdWolLEHMqzbkuiHqOD4cJA
         XSDh4G4MGwn59vJfSOnxs3Hw6DnxPD/wJrMuWOXd3w4alq+lYRabdHs1ORTy9zz6okrJ
         ONbw==
X-Forwarded-Encrypted: i=1; AJvYcCXLlPlfyUTyCh9LT1CkQW5RDWS5P9CtS3f6WFDtOkm0DneH+p7XsB7t1eZbC/4CmJZJ4562mN0ldMTU@vger.kernel.org
X-Gm-Message-State: AOJu0YxgI6uL2EL8S8PbF2/Qr0sx8mLA37BhQ+8+TdD4K0Xfaqh3gX60
	W3kIn5IiicT3GZ5sicaGBed4uTe1viNXzT//09lWKbaEQzLxGWAY90F9TMlMv6UoCSOvf0YYaPC
	uMARUIpu+T0W/HSU0zVZDFOj2TywG0t1nayJx5n+ROIaEoFzfEW8wE2M=
X-Google-Smtp-Source: AGHT+IF5k/liwThViz9a4+sPDT5j/49RGJEsmPQO7jypqLIxbuEyt28zrYM8JrvFB81zgx85G0tcrYoelsn0jD4xkLpT2DBJ3ZEQ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c4:b0:3cb:f2e6:55a4 with SMTP id
 e9e14a558f8ab-3ce3a893777mr130467765ab.0.1736725458921; Sun, 12 Jan 2025
 15:44:18 -0800 (PST)
Date: Sun, 12 Jan 2025 15:44:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678453d2.050a0220.216c54.0039.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in wait_transaction_locked (2)
From: syzbot <syzbot+28bf83dcc731112be68b@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b7958fa05d5 Merge tag 'for-6.13/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b2cdc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=28bf83dcc731112be68b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab12e2350931/disk-0b7958fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d437236967f3/vmlinux-0b7958fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ddc72b2a293/bzImage-0b7958fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28bf83dcc731112be68b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00046-g0b7958fa05d5 #0 Not tainted
------------------------------------------------------
syz.1.479/7411 is trying to acquire lock:
ffff88814e862958 (jbd2_handle){++++}-{0:0}, at: wait_transaction_locked+0x1f3/0x2c0 fs/jbd2/transaction.c:155

but task is already holding lock:
ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1890 [inline]
ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x1fc/0x1100 fs/ext4/inode.c:6158

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sb_pagefaults){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_pagefault include/linux/fs.h:1890 [inline]
       ext4_page_mkwrite+0x1fc/0x1100 fs/ext4/inode.c:6158
       do_page_mkwrite+0x15e/0x350 mm/memory.c:3176
       do_shared_fault mm/memory.c:5398 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x10c6/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #6 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_setup+0xd2/0x1e0 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0xa46/0x2e80 drivers/scsi/sg.c:1156
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&q->debugfs_mutex){+.+.}-{4:4}:
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

-> #4 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
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

-> #3 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:947 [inline]
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

-> #2 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       ocfs2_read_blocks+0x8d9/0x1600 fs/ocfs2/buffer_head_io.c:330
       ocfs2_read_inode_block_full fs/ocfs2/inode.c:1593 [inline]
       ocfs2_read_inode_block+0x106/0x1e0 fs/ocfs2/inode.c:1605
       ocfs2_get_clusters+0x3d2/0xbd0 fs/ocfs2/extent_map.c:615
       ocfs2_extent_map_get_blocks+0x24c/0x7d0 fs/ocfs2/extent_map.c:668
       ocfs2_read_virt_blocks+0x313/0xb10 fs/ocfs2/extent_map.c:983
       ocfs2_read_dir_block fs/ocfs2/dir.c:508 [inline]
       ocfs2_find_entry_el fs/ocfs2/dir.c:715 [inline]
       ocfs2_find_entry+0x43b/0x2730 fs/ocfs2/dir.c:1080
       ocfs2_find_files_on_disk+0xff/0x360 fs/ocfs2/dir.c:1981
       ocfs2_lookup_ino_from_name+0xb1/0x1e0 fs/ocfs2/dir.c:2003
       _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
       ocfs2_get_system_file_inode+0x305/0x7b0 fs/ocfs2/sysfile.c:112
       ocfs2_init_global_system_inodes+0x32c/0x730 fs/ocfs2/super.c:457
       ocfs2_initialize_super fs/ocfs2/super.c:2248 [inline]
       ocfs2_fill_super+0x2f5b/0x5760 fs/ocfs2/super.c:994
       mount_bdev+0x20c/0x2d0 fs/super.c:1693
       legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3513
       do_mount fs/namespace.c:3853 [inline]
       __do_sys_mount fs/namespace.c:4063 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4040
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&oi->ip_io_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       ocfs2_read_blocks+0x23e/0x1600 fs/ocfs2/buffer_head_io.c:233
       ocfs2_read_block fs/ocfs2/buffer_head_io.h:52 [inline]
       ocfs2_read_group_descriptor fs/ocfs2/suballoc.c:303 [inline]
       ocfs2_search_chain+0x2d3/0x26c0 fs/ocfs2/suballoc.c:1810
       ocfs2_claim_suballoc_bits+0x11ef/0x2560 fs/ocfs2/suballoc.c:1985
       ocfs2_claim_new_inode+0x338/0x870 fs/ocfs2/suballoc.c:2267
       ocfs2_mknod_locked+0x17a/0x3b0 fs/ocfs2/namei.c:635
       ocfs2_mknod+0x17d4/0x2b30 fs/ocfs2/namei.c:381
       ocfs2_create+0x1ab/0x470 fs/ocfs2/namei.c:674
       lookup_open fs/namei.c:3649 [inline]
       open_last_lookups fs/namei.c:3748 [inline]
       path_openat+0x1c05/0x3590 fs/namei.c:3984
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_open fs/open.c:1425 [inline]
       __se_sys_open fs/open.c:1421 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1421
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       wait_transaction_locked+0x20b/0x2c0 fs/jbd2/transaction.c:155
       start_this_handle+0x7e5/0x2110 fs/jbd2/transaction.c:407
       jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
       __ext4_journal_start_sb+0x239/0x600 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:6038
       __mark_inode_dirty+0x2f0/0xe90 fs/fs-writeback.c:2515
       generic_update_time fs/inode.c:2112 [inline]
       inode_update_time fs/inode.c:2125 [inline]
       __file_update_time fs/inode.c:2353 [inline]
       file_update_time+0x3d2/0x450 fs/inode.c:2383
       ext4_page_mkwrite+0x213/0x1100 fs/ext4/inode.c:6159
       do_page_mkwrite+0x15e/0x350 mm/memory.c:3176
       do_shared_fault mm/memory.c:5398 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x10c6/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> &mm->mmap_lock --> sb_pagefaults

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_pagefaults);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults);
  lock(jbd2_handle);

 *** DEADLOCK ***

2 locks held by syz.1.479/7411:
 #0: ffff888062189d18 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_read include/linux/mm.h:717 [inline]
 #0: ffff888062189d18 (&vma->vm_lock->lock){++++}-{4:4}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6278
 #1: ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
 #1: ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1890 [inline]
 #1: ffff88814e85e518 (sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x1fc/0x1100 fs/ext4/inode.c:6158

stack backtrace:
CPU: 1 UID: 0 PID: 7411 Comm: syz.1.479 Not tainted 6.13.0-rc6-syzkaller-00046-g0b7958fa05d5 #0
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
 wait_transaction_locked+0x20b/0x2c0 fs/jbd2/transaction.c:155
 start_this_handle+0x7e5/0x2110 fs/jbd2/transaction.c:407
 jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
 __ext4_journal_start_sb+0x239/0x600 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:6038
 __mark_inode_dirty+0x2f0/0xe90 fs/fs-writeback.c:2515
 generic_update_time fs/inode.c:2112 [inline]
 inode_update_time fs/inode.c:2125 [inline]
 __file_update_time fs/inode.c:2353 [inline]
 file_update_time+0x3d2/0x450 fs/inode.c:2383
 ext4_page_mkwrite+0x213/0x1100 fs/ext4/inode.c:6159
 do_page_mkwrite+0x15e/0x350 mm/memory.c:3176
 do_shared_fault mm/memory.c:5398 [inline]
 do_fault mm/memory.c:5460 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault+0x10c6/0x5ed0 mm/memory.c:5801
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f3079a6609a
Code: 01 4c 89 44 24 10 4c 89 54 24 08 e8 a0 9a fe ff 48 8b 43 38 4c 8b 44 24 10 83 43 28 08 4c 8b 54 24 08 48 8d 48 f8 48 89 4b 38 <48> 89 68 f8 45 3b 78 04 0f 82 5e fe ff ff e9 ed fe ff ff 0f 1f 00
RSP: 002b:00007fffd52191a0 EFLAGS: 00010202
RAX: 0000001b30220000 RBX: 00007f307a8a5720 RCX: 0000001b3021fff8
RDX: 00000000005ffde8 RSI: 00000000005ffde8 RDI: 00007f307a8a5700
RBP: ffffffff82217a5a R08: 00007f3079d76038 R09: 00007f3079d62000
R10: 00007f30791ff008 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffffff82217330 R15: 0000000000000001
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

