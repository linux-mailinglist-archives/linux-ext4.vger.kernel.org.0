Return-Path: <linux-ext4+bounces-5779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DC9F82E9
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6C21885244
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770519DF60;
	Thu, 19 Dec 2024 18:05:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B19994F
	for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631527; cv=none; b=gWd9UBSAiw/emr2DuU+u+E4lsaM006MXfQkLVCJYQRI8H5xLCeG7xcJIwhXTXSQwwgdPuFokNZ3JETUfxhsg8OlM3NVh7/jXUriZ4d3i2tsmBWmxM8Xhf1J5nzFBQxSOo2qbZx9UYH38o+iYOv7dmQZIz0N2XWUCU1mMBX8eFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631527; c=relaxed/simple;
	bh=rOQrsVIs7bzWB1Kbe2nbeW9Np8iWoHiC2/yw7KOi/98=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dq9CgO9PByO0Zc+NffKm8hQMHr8mC9Mzi2+ZnIFcKyep7VRraV46C91pdLrfi2/bYIZXL04grKD1dF+JciTeQmjaaIRwwTsCMHjgYjd52CnUt6394TePG2RPNg4OX5Ar5OWfTjATUtY1ROHd3IGsyHFplttHhqmk5k3JclrTWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso9172445ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 10:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734631524; x=1735236324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1ZZOPdjgeCo3+HFenWXhbdrCubexzBHtjxsRPd2fCI=;
        b=rdQQEt9YkcSvJ3VKaVtKYnDZEvHrCvBbkkhEcHnr9PDYAj4mQ3MUJqGF8TZ3AnmiFa
         ytnj3D7cboTnvERgKqRLLfRCJBYD15FN2OACM7ED8KUGJmWC+os+BbNum6a09p1rZY7U
         GKkA5wPHbQMkGuung7HNwTfVtLFjKPc7/wLpAJQ90Gc/iZKPxZePgS2bJrDpnK/EMoOP
         Ssa1w3Ca0FSwbuphnTElF61eV18RUQq0d1jfWuzhZG1I6DMGc7Kgnh6EwBlGyz8jMuCS
         zjOWagBMQkRotiJBqyjW4vL0j2Vtfr1GPsEPbqfuwoNRT2F9ZFhb5DaCiPiALGwsEHUi
         VoCw==
X-Forwarded-Encrypted: i=1; AJvYcCVBcxdd9EUyejubzDf3DHbRIkxklsjgPFYQOd0s5lthDovtQZKZGxplWezkwVxGDAyFjDI9Af0Wkwif@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZAPvbrSgy7EfC3fdUU3O+xz50KvpXl+7EgFyfztEOxQtBUH7
	cGYYbUeb0VJvq6dFZ+2p5xoUeywyMGdxf8OgvPiV5cRT5fAZtfE4//U89bPwoHQQmzV3CCv5S4E
	dSp8bHGyfGdXZkg96VmSSoxkoFhqUiqG1ZfYijUJuxRLpJzMxFug9VmE=
X-Google-Smtp-Source: AGHT+IGej11QJvqbe8YyrXFibR1yOoDgAlnKqVbc2MBS00xMxzLPsCiMJXNoXHmcIXN9OOOSi36kwiHpBmfZJCS975o4oIKkg5k0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b87:b0:3a7:e86a:e812 with SMTP id
 e9e14a558f8ab-3c2d48a2f66mr335545ab.17.1734631524692; Thu, 19 Dec 2024
 10:05:24 -0800 (PST)
Date: Thu, 19 Dec 2024 10:05:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67646064.050a0220.1dcc64.0017.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in start_this_handle (5)
From: syzbot <syzbot+5fdca1875eb24c8485d8@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78d4f34e2115 Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152c47e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9e03cf060a5aba
dashboard link: https://syzkaller.appspot.com/bug?extid=5fdca1875eb24c8485d8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6ae77211647/disk-78d4f34e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a12b2eaf1132/vmlinux-78d4f34e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4ae77fafd81/bzImage-78d4f34e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fdca1875eb24c8485d8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:37/9221 is trying to acquire lock:
ffff88814e748958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448

but task is already holding lock:
ffff88803298eb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1b6/0x820 mm/page-writeback.c:2702

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1776 [inline]
       ext4_writepages+0x1ad/0x730 fs/ext4/inode.c:2823
       do_writepages+0x1b6/0x820 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       filemap_fdatawrite_wbc+0x104/0x160 mm/filemap.c:387
       __filemap_fdatawrite_range+0xb3/0xf0 mm/filemap.c:430
       filemap_write_and_wait_range mm/filemap.c:684 [inline]
       filemap_write_and_wait_range+0xa3/0x130 mm/filemap.c:675
       ext4_insert_range fs/ext4/extents.c:5540 [inline]
       ext4_fallocate+0x24fc/0x3950 fs/ext4/extents.c:4782
       vfs_fallocate+0x45c/0xf90 fs/open.c:327
       ksys_fallocate fs/open.c:351 [inline]
       __do_sys_fallocate fs/open.c:356 [inline]
       __se_sys_fallocate fs/open.c:354 [inline]
       __x64_sys_fallocate+0xd5/0x150 fs/open.c:354
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (mapping.invalidate_lock){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x173/0x750 mm/readahead.c:226
       do_page_cache_ra mm/readahead.c:325 [inline]
       page_cache_ra_order+0x8f2/0xc80 mm/readahead.c:524
       do_sync_mmap_readahead mm/filemap.c:3203 [inline]
       filemap_fault+0x14a5/0x2820 mm/filemap.c:3344
       __do_fault+0x10d/0x490 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing+0xebd/0x3e00 mm/memory.c:3979
       handle_pte_fault mm/memory.c:5801 [inline]
       __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x8d9/0x3b50 mm/gup.c:1494
       __get_user_pages_locked mm/gup.c:1760 [inline]
       get_dump_page+0xff/0x230 mm/gup.c:2278
       dump_user_range+0x135/0x8c0 fs/coredump.c:943
       elf_core_dump+0x287c/0x3a50 fs/binfmt_elf.c:2129
       do_coredump+0x3ada/0x49e0 fs/coredump.c:758
       get_signal+0x230b/0x26c0 kernel/signal.c:3002
       arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #6 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x109/0x6d0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x42b/0x640 block/blk-mq-sched.c:473
       elevator_init_mq+0x2cd/0x420 block/elevator.c:610
       add_disk_fwnode+0x113/0x1300 block/genhd.c:413
       sd_probe+0xa86/0x1000 drivers/scsi/sd.c:4024
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       blk_queue_enter+0x50f/0x640 block/blk-core.c:328
       blk_mq_alloc_request+0x59b/0x950 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x1eb/0xf40 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x213/0xe10 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk.isra.0+0x1a06/0xa8d0 drivers/scsi/sd.c:3734
       sd_probe+0x904/0x1000 drivers/scsi/sd.c:4010
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:947 [inline]
       loop_reconfigure_limits+0x407/0x8c0 drivers/block/loop.c:998
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x901/0x18b0 drivers/block/loop.c:1559
       blkdev_ioctl+0x279/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3090
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       ocfs2_read_blocks+0x59c/0x1530 fs/ocfs2/buffer_head_io.c:330
       ocfs2_read_inode_block_full fs/ocfs2/inode.c:1593 [inline]
       ocfs2_read_inode_block+0xc6/0x170 fs/ocfs2/inode.c:1605
       ocfs2_get_clusters+0x22b/0xc40 fs/ocfs2/extent_map.c:615
       ocfs2_extent_map_get_blocks+0x1ac/0x640 fs/ocfs2/extent_map.c:668
       ocfs2_read_virt_blocks+0x284/0x9c0 fs/ocfs2/extent_map.c:983
       ocfs2_read_dir_block+0xb6/0x520 fs/ocfs2/dir.c:508
       ocfs2_find_entry_el fs/ocfs2/dir.c:715 [inline]
       ocfs2_find_entry+0xc3a/0x17b0 fs/ocfs2/dir.c:1080
       ocfs2_find_files_on_disk fs/ocfs2/dir.c:1981 [inline]
       ocfs2_lookup_ino_from_name+0xd5/0x1e0 fs/ocfs2/dir.c:2003
       _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
       ocfs2_get_system_file_inode+0x443/0x940 fs/ocfs2/sysfile.c:112
       ocfs2_init_global_system_inodes fs/ocfs2/super.c:457 [inline]
       ocfs2_initialize_super.isra.0+0x1f3a/0x32e0 fs/ocfs2/super.c:2248
       ocfs2_fill_super+0xb10/0x41d0 fs/ocfs2/super.c:994
       mount_bdev+0x1e6/0x2d0 fs/super.c:1693
       legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
       vfs_get_tree+0x92/0x380 fs/super.c:1814
       do_new_mount fs/namespace.c:3507 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&oi->ip_io_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       ocfs2_read_blocks+0x226/0x1530 fs/ocfs2/buffer_head_io.c:233
       ocfs2_read_block fs/ocfs2/buffer_head_io.h:52 [inline]
       ocfs2_read_group_descriptor+0xad/0x500 fs/ocfs2/suballoc.c:303
       ocfs2_search_chain+0x24e/0x24a0 fs/ocfs2/suballoc.c:1810
       ocfs2_claim_suballoc_bits+0x800/0x2010 fs/ocfs2/suballoc.c:1985
       ocfs2_claim_new_inode+0x325/0x8e0 fs/ocfs2/suballoc.c:2267
       ocfs2_mknod_locked.constprop.0+0xf7/0x290 fs/ocfs2/namei.c:635
       ocfs2_mknod+0xc55/0x2440 fs/ocfs2/namei.c:381
       ocfs2_create+0x185/0x450 fs/ocfs2/namei.c:674
       lookup_open.isra.0+0x1177/0x14c0 fs/namei.c:3649
       open_last_lookups fs/namei.c:3748 [inline]
       path_openat+0x904/0x2d60 fs/namei.c:3984
       do_filp_open+0x20c/0x470 fs/namei.c:4014
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_open fs/open.c:1425 [inline]
       __se_sys_open fs/open.c:1421 [inline]
       __x64_sys_open+0x154/0x1e0 fs/open.c:1421
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       start_this_handle+0xf92/0x1430 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:505
       __ext4_journal_start_sb+0x19f/0x660 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_do_writepages+0xc04/0x32d0 fs/ext4/inode.c:2718
       ext4_writepages+0x303/0x730 fs/ext4/inode.c:2824
       do_writepages+0x1b6/0x820 mm/page-writeback.c:2702
       __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1680
       writeback_sb_inodes+0x606/0xfa0 fs/fs-writeback.c:1976
       wb_writeback+0x422/0xb80 fs/fs-writeback.c:2156
       wb_do_writeback fs/fs-writeback.c:2303 [inline]
       wb_workfn+0x151/0xbc0 fs/fs-writeback.c:2343
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> mapping.invalidate_lock --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(mapping.invalidate_lock);
                               lock(&sbi->s_writepages_rwsem);
  rlock(jbd2_handle);

 *** DEADLOCK ***

3 locks held by kworker/u8:37/9221:
 #0: ffff88801daef948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900149c7d80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88803298eb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1b6/0x820 mm/page-writeback.c:2702

stack backtrace:
CPU: 1 UID: 0 PID: 9221 Comm: kworker/u8:37 Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 start_this_handle+0xf92/0x1430 fs/jbd2/transaction.c:448
 jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:505
 __ext4_journal_start_sb+0x19f/0x660 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_do_writepages+0xc04/0x32d0 fs/ext4/inode.c:2718
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2824
 do_writepages+0x1b6/0x820 mm/page-writeback.c:2702
 __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x606/0xfa0 fs/fs-writeback.c:1976
 wb_writeback+0x422/0xb80 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x151/0xbc0 fs/fs-writeback.c:2343
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50


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

