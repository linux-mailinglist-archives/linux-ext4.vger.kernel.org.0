Return-Path: <linux-ext4+bounces-5768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF489F7AFD
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B66A1890256
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299B223C7F;
	Thu, 19 Dec 2024 12:14:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F4222562
	for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610465; cv=none; b=kVvPkTjHow9eMsE90HY1ffGjCMCp/9KDSsKqORGSaSKPnlLePSCqrTqGuBGRUxhn/B1nhqzTSZR3jSNbJWe6yuH1soiynBacL2GNmMnZ7s9DMrg6m9Fn76SfA0pfuJx6i8o6QLegSAwfx6e2i5mqrjorcak5eVDrumBwUUF5yjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610465; c=relaxed/simple;
	bh=PqQMQ2PUwmYJguPRkLZVwQubHg7v9o5cQBl1uJyhv1k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LNLW90AzXQXT1AzUn0+Nj7eIxHSWM/vSGJQE+lMnaj1JXgFAPzdr8nc4b0VG4O2T6IXslT22IKRb6BNFVM9pCTivKDv2QEkDWqLS6Tx2SKkrY/R+dD4mAzcb0mvYnqtKtCKGvDYJ47ha/DqU7Js4rk9E2+UfTy0R1j3HvbWiXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so5252985ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 04:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734610463; x=1735215263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khbVRpKCQppFvqBYoGlzkD975wLh3TxtCYqXgvfCpQY=;
        b=a1eYAxhCj+DMOQZHEftpTZFz8RUcSQzs96uk3aKRQvdkw8bmeX18B0E83shJ9gnrfD
         b/ymoqiQ4IOcvLOWMFW1LKu1ht/tltsaK4DuL6gX3mrrDVy8BbY5LXoSHgzrvPdQ3Aaz
         sPaHMvmlE2HmxsmWrhzQhUgy+IKUs31NPtR4CHT/Rt0cB0ZBjAIurOiloWDei+RkL7QI
         HCJ6SBNWA3H5ovcJZhiY2GTO2X5Bu39mbt4/aULtEaa5F0lCT8m4iGPiinENslvkWYcU
         LMmrYxYwVEEPyP2dO3mzlio/Mudl+JitU53AB/wFWuiLaeVK4FxW6m1cxIh6jMX4pTJ9
         VrPA==
X-Forwarded-Encrypted: i=1; AJvYcCW3dyxxZaQvZ+O/+yI6dJW3tBnMYhRbpsB6DQbTgf3pj9M+Ok+ZUj42h41+IlAHSKFPBT2wY9nuJ+Cl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIWz3sThh5JK4do76J5bA+2AKEj30lUpI2w3tnNy901KQzgv3
	If3fa60CyE3/Qca9S37oldZFkUSLpffMhEn9J5sGPIGFA13qvF9a2ORy/Peakgw1/2YXqkntU4+
	UqfMcPOQ/QKYJ3HoY2ZYcDJ0JUGYHbm1etIfx/teVbLtRkdFifk6W7nY=
X-Google-Smtp-Source: AGHT+IGnB3Wh2SWmxs7CiTG44xZ98QAOzJD9iIINRAsJ1MjDSmsbFn7MvCzhWCXSFFc+/qBVSi3RjusYiwX+Qmav7I+9ufT3i9DZ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3c0145b1445mr28120425ab.19.1734610462916; Thu, 19 Dec 2024
 04:14:22 -0800 (PST)
Date: Thu, 19 Dec 2024 04:14:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67640e1e.050a0220.3157ee.0017.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
From: syzbot <syzbot+3fe0e9275e5db10c12e6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d8308bf5b67 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da07e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=3fe0e9275e5db10c12e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c676aa31c177/disk-2d8308bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5df0fd760e5/vmlinux-2d8308bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be262bc10591/bzImage-2d8308bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3fe0e9275e5db10c12e6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0 Not tainted
------------------------------------------------------
syz.3.7098/25712 is trying to acquire lock:
ffff88805aa000c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
ffff88805aa000c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1877

but task is already holding lock:
ffff888047c08b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1776 [inline]
ffff888047c08b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2823

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       ext4_writepages_down_read fs/ext4/ext4.h:1776 [inline]
       ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2823
       do_writepages+0x361/0x880 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       __filemap_fdatawrite_range mm/filemap.c:430 [inline]
       filemap_write_and_wait_range+0x283/0x3a0 mm/filemap.c:684
       ext4_collapse_range fs/ext4/extents.c:5400 [inline]
       ext4_fallocate+0xd77/0x1ea0 fs/ext4/extents.c:4777
       vfs_fallocate+0x56b/0x6e0 fs/open.c:327
       ksys_fallocate fs/open.c:351 [inline]
       __do_sys_fallocate fs/open.c:356 [inline]
       __se_sys_fallocate fs/open.c:354 [inline]
       __x64_sys_fallocate+0xbc/0x110 fs/open.c:354
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x615/0x1490 mm/filemap.c:3332
       __do_fault+0x137/0x390 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x39eb/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x111/0x2d0
       fault_in_iov_iter_readable+0x155/0x280 lib/iov_iter.c:108
       generic_perform_write+0x260/0x990 mm/filemap.c:4045
       ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x892/0x1c50
       do_iter_readv_writev+0x602/0x880
       vfs_writev+0x376/0xba0 fs/read_write.c:1050
       do_pwritev fs/read_write.c:1146 [inline]
       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&mm->mmap_lock){++++}-{4:4}:
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

-> #2 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
       __ext4_handle_dirty_metadata+0x2a6/0x820 fs/ext4/ext4_jbd2.c:386
       ext4_ext_grow_indepth fs/ext4/extents.c:1366 [inline]
       ext4_ext_create_new_leaf fs/ext4/extents.c:1433 [inline]
       ext4_ext_insert_extent+0x12ee/0x4bd0 fs/ext4/extents.c:2115
       ext4_ext_map_blocks+0x1e42/0x7d30 fs/ext4/extents.c:4400
       ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
       ext4_map_blocks+0x8bf/0x1990 fs/ext4/inode.c:702
       _ext4_get_block+0x239/0x6b0 fs/ext4/inode.c:781
       ext4_get_block_unwritten+0x2f/0x100 fs/ext4/inode.c:814
       ext4_block_write_begin+0x4d8/0x1510 fs/ext4/inode.c:1063
       ext4_write_begin+0x6c8/0x1280
       ext4_da_write_begin+0x300/0xa60 fs/ext4/inode.c:2925
       generic_perform_write+0x348/0x990 mm/filemap.c:4055
       ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x892/0x1c50
       do_iter_readv_writev+0x602/0x880
       vfs_writev+0x376/0xba0 fs/read_write.c:1050
       do_pwritev fs/read_write.c:1146 [inline]
       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ei->i_data_sem){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       ext4_da_map_blocks fs/ext4/inode.c:1799 [inline]
       ext4_da_get_block_prep+0x428/0x1900 fs/ext4/inode.c:1873
       ext4_block_write_begin+0x4d8/0x1510 fs/ext4/inode.c:1063
       ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:860 [inline]
       ext4_da_write_inline_data_begin+0x4da/0xd60 fs/ext4/inline.c:921
       ext4_da_write_begin+0x4fe/0xa60 fs/ext4/inode.c:2932
       generic_perform_write+0x348/0x990 mm/filemap.c:4055
       ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x892/0x1c50
       do_iter_readv_writev+0x602/0x880
       vfs_writev+0x376/0xba0 fs/read_write.c:1050
       do_pwritev fs/read_write.c:1146 [inline]
       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
       ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1877
       ext4_do_writepages+0x51e/0x3df0 fs/ext4/inode.c:2621
       ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2824
       do_writepages+0x361/0x880 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       __filemap_fdatawrite_range mm/filemap.c:430 [inline]
       file_write_and_wait_range+0x2a3/0x3c0 mm/filemap.c:787
       generic_buffers_fsync_noflush+0x71/0x180 fs/buffer.c:600
       ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
       ext4_sync_file+0x40a/0xb90 fs/ext4/fsync.c:151
       generic_write_sync include/linux/fs.h:2904 [inline]
       ext4_buffered_write_iter+0x284/0x350 fs/ext4/file.c:305
       ext4_file_write_iter+0x892/0x1c50
       do_iter_readv_writev+0x602/0x880
       vfs_writev+0x376/0xba0 fs/read_write.c:1050
       do_writev+0x1b6/0x360 fs/read_write.c:1096
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> mapping.invalidate_lock --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(mapping.invalidate_lock);
                               lock(&sbi->s_writepages_rwsem);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.3.7098/25712:
 #0: ffff88805c948ef8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1191
 #1: ffff888047c0c420 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #1: ffff888047c0c420 (sb_writers#4){.+.+}-{0:0}, at: vfs_writev+0x2d1/0xba0 fs/read_write.c:1048
 #2: ffff888047c08b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1776 [inline]
 #2: ffff888047c08b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2823

stack backtrace:
CPU: 1 UID: 0 PID: 25712 Comm: syz.3.7098 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
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
 ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1877
 ext4_do_writepages+0x51e/0x3df0 fs/ext4/inode.c:2621
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2824
 do_writepages+0x361/0x880 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x2a3/0x3c0 mm/filemap.c:787
 generic_buffers_fsync_noflush+0x71/0x180 fs/buffer.c:600
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x40a/0xb90 fs/ext4/fsync.c:151
 generic_write_sync include/linux/fs.h:2904 [inline]
 ext4_buffered_write_iter+0x284/0x350 fs/ext4/file.c:305
 ext4_file_write_iter+0x892/0x1c50
 do_iter_readv_writev+0x602/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1050
 do_writev+0x1b6/0x360 fs/read_write.c:1096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9277985d19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f927879d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f9277b75fa0 RCX: 00007f9277985d19
RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00007f9277a01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9277b75fa0 R15: 00007fffef6444c8
 </TASK>
EXT4-fs error (device loop3): ext4_mb_generate_buddy:1220: group 0, block bitmap and bg descriptor inconsistent: 25 vs 4128793 free clusters
EXT4-fs (loop3): Delayed block allocation failed for inode 15 at logical offset 0 with max blocks 192 with error 28
EXT4-fs (loop3): This should not happen!! Data will be lost

EXT4-fs (loop3): Total free blocks count 0
EXT4-fs (loop3): Free/Dirty block details
EXT4-fs (loop3): free_blocks=66060288
EXT4-fs (loop3): dirty_blocks=240
EXT4-fs (loop3): Block reservation details
EXT4-fs (loop3): i_reserved_data_blocks=15


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

