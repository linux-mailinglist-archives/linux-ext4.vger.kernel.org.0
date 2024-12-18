Return-Path: <linux-ext4+bounces-5733-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD029F608B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 09:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C1B16B837
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B91917E9;
	Wed, 18 Dec 2024 08:58:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FA18CC0B
	for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512307; cv=none; b=dbNG1MLwgR/qWC+mNoFnL2gLhZXL6IUP54u5u5+N3PqJMu4BJZlW+eXFMVSFqPb99dSvjnVCxcLugKxsIQM6spdrw/tv/y3uktUzVyiKiQecrl0kP17r1qZLxGnhuvXkroJauP2KYs+wEDHR1Nb45opXqHlLA3uI8D1jhSHhabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512307; c=relaxed/simple;
	bh=vbj6BjDPl6Um8gg8mxlhygmTX0MrWz3J7b+IN+xvK4U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GjrLqrzrdh3ZdgSmN3lkyIH6tUa0/vCtumyVFVvf94JK554mFEEHpIXsK/EC8iqPNO9peIAsynXrBh/RzIesoOzzU9REJiVywiPp2V0YOCrEIBZi2BvBs7ma02iF4ETL0pVuU2oTXW4PV6xpZPz1M8X5YKr1uF9GXHiXk6cKbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso4929765ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2024 00:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512304; x=1735117104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kqGlvGFDXj4wBxraatuECEjE0ggiMLjuUHeuDj+t00=;
        b=j3ZrpqKdJGhatHTUnwyueCLbUrj0cMXSYce6ZOpjiMgWwxHgCBs32+A3x8ntVFVYSh
         ytFLNRrz0QwLWEUTBjzpB1gblSrg1EnKuYR1BYq24cxdinBIsbxps85927MaAMYHUrZh
         23OHYR0qop98Dj76PjqAE8BphEz+hHfMp8uuEq+Ao/d7FWE6lRnxvS6/ILTtFgYyrCQx
         dKcnDQaZHpuGYYLPqRHxiShvirt64Y69u1MDwG7+kltzafR7EiCDMU6UqwNH11tQfy3T
         oJAAqMJmnEzK6IRuVHRgY02tgOsp0rBXtt8o+GRqsg/z5PMZmtCgm9KI2iJIVuMUb6fh
         +xIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCLCnRwFq3VxBLXilt+B/l8ufVPQHhI/nQcRakkuNAKqvZbE+ZX2q2i5V0zvLiXWQl1rvdjEKotHVb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/S9QPZFNvwXaiw3fQNE25/Wx/zX/g8z6RR6FOdBYuI3WMA02P
	oplqC5rlzZaIs4mdsEh42QNktuPDOlFsrZemmBJuQkCPhY6Gu4X+WxtkOAP/MbJ0TMlPwVaAC8W
	ORQ8PQMkpATz2TPSNcWGZpDH3Rdf7k/LWEub+oVp7TOLustkJdBHxC40=
X-Google-Smtp-Source: AGHT+IEfUgYu20cvIRo2cFbfsqAi2Zaoxv0GcPmi1ofS0XgLvh50gPo4p88r7KIkcfTF9w5dK39CnBbLkkkzqXaICioOpsLJg1iA
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3a7:e069:95e0 with SMTP id
 e9e14a558f8ab-3bde09ff678mr16116325ab.1.1734512304571; Wed, 18 Dec 2024
 00:58:24 -0800 (PST)
Date: Wed, 18 Dec 2024 00:58:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67628eb0.050a0220.29fcd0.0089.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_inline_data_truncate (3)
From: syzbot <syzbot+0faf395d223af4bf2df7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0e3919a2df2 Merge tag 'usb-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1250fbe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=0faf395d223af4bf2df7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35650546bc2a/disk-a0e3919a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7c56d2f4249/vmlinux-a0e3919a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c654d1575148/bzImage-a0e3919a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0faf395d223af4bf2df7@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 512
EXT4-fs (loop2): encrypted files will use data=ordered instead of data journaling mode
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0 Not tainted
------------------------------------------------------
syz.2.5629/21390 is trying to acquire lock:
ffff888050c68288 (&ei->i_data_sem){++++}-{4:4}, at: ext4_inline_data_truncate+0x4ce/0xc70 fs/ext4/inline.c:1950

but task is already holding lock:
ffff888050c680c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
ffff888050c680c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_inline_data_truncate+0x1af/0xc70 fs/ext4/inline.c:1936

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&ei->xattr_sem){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       ext4_readpage_inline+0x33/0x610 fs/ext4/inline.c:518
       ext4_read_folio+0x192/0x380 fs/ext4/inode.c:3185
       filemap_read_folio+0xc9/0x2a0 mm/filemap.c:2366
       filemap_create_folio mm/filemap.c:2497 [inline]
       filemap_get_pages+0x100b/0x1be0 mm/filemap.c:2555
       filemap_read+0x3ca/0xd70 mm/filemap.c:2646
       generic_file_read_iter+0x344/0x450 mm/filemap.c:2834
       ext4_file_read_iter+0x1d6/0x6a0 fs/ext4/file.c:147
       __kernel_read+0x3f4/0xb50 fs/read_write.c:523
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
       process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
       ima_file_check+0xc6/0x110 security/integrity/ima/ima_main.c:572
       security_file_post_open+0x8e/0x210 security/security.c:3121
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1419/0x2d60 fs/namei.c:3987
       do_filp_open+0x20c/0x470 fs/namei.c:4014
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (mapping.invalidate_lock){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x173/0x750 mm/readahead.c:226
       do_page_cache_ra mm/readahead.c:325 [inline]
       page_cache_ra_order+0x8f2/0xc80 mm/readahead.c:524
       page_cache_async_ra+0x5cb/0x820 mm/readahead.c:674
       do_async_mmap_readahead mm/filemap.c:3231 [inline]
       filemap_fault+0xd69/0x2820 mm/filemap.c:3330
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

-> #5 (&mm->mmap_lock){++++}-{4:4}:
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

-> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
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

-> #3 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
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

-> #2 (&q->limits_lock){+.+.}-{4:4}:
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

-> #1 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3090
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       __ext4_read_bh fs/ext4/super.c:181 [inline]
       ext4_read_bh_nowait+0x199/0x250 fs/ext4/super.c:193
       ext4_read_block_bitmap_nowait+0xeac/0x1810 fs/ext4/balloc.c:551
       ext4_mb_init_cache+0x290/0x15c0 fs/ext4/mballoc.c:1337
       ext4_mb_init_group+0x331/0x840 fs/ext4/mballoc.c:1543
       ext4_mb_load_buddy_gfp+0xc23/0x10c0 fs/ext4/mballoc.c:1613
       ext4_mb_clear_bb fs/ext4/mballoc.c:6451 [inline]
       ext4_free_blocks+0x832/0x1c80 fs/ext4/mballoc.c:6652
       ext4_remove_blocks fs/ext4/extents.c:2547 [inline]
       ext4_ext_rm_leaf fs/ext4/extents.c:2712 [inline]
       ext4_ext_remove_space+0x2d7a/0x43a0 fs/ext4/extents.c:2961
       ext4_ext_truncate+0x240/0x2f0 fs/ext4/extents.c:4466
       ext4_truncate+0xe37/0x1270 fs/ext4/inode.c:4217
       ext4_process_orphan+0x154/0x410 fs/ext4/orphan.c:339
       ext4_orphan_cleanup+0x742/0x1210 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5610 [inline]
       ext4_fill_super+0x9631/0xaab0 fs/ext4/super.c:5733
       get_tree_bdev_flags+0x38e/0x620 fs/super.c:1636
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

-> #0 (&ei->i_data_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       ext4_inline_data_truncate+0x4ce/0xc70 fs/ext4/inline.c:1950
       ext4_truncate+0x9ab/0x1270 fs/ext4/inode.c:4173
       ext4_evict_inode+0x7af/0x18c0 fs/ext4/inode.c:263
       evict+0x40c/0x960 fs/inode.c:796
       iput_final fs/inode.c:1946 [inline]
       iput fs/inode.c:1972 [inline]
       iput+0x52a/0x890 fs/inode.c:1958
       ext4_orphan_cleanup+0x742/0x1210 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5610 [inline]
       ext4_fill_super+0x9631/0xaab0 fs/ext4/super.c:5733
       get_tree_bdev_flags+0x38e/0x620 fs/super.c:1636
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

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem --> mapping.invalidate_lock --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(mapping.invalidate_lock);
                               lock(&ei->xattr_sem);
  lock(&ei->i_data_sem);

 *** DEADLOCK ***

3 locks held by syz.2.5629/21390:
 #0: ffff88804d1700e0 (&type->s_umount_key#27/1){+.+.}-{4:4}, at: alloc_super+0x23d/0xbd0 fs/super.c:344
 #1: ffff88804d170610 (sb_internal){.+.+}-{0:0}, at: evict+0x40c/0x960 fs/inode.c:796
 #2: ffff888050c680c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 #2: ffff888050c680c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_inline_data_truncate+0x1af/0xc70 fs/ext4/inline.c:1936

stack backtrace:
CPU: 1 UID: 0 PID: 21390 Comm: syz.2.5629 Not tainted 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
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
 down_write+0x93/0x200 kernel/locking/rwsem.c:1577
 ext4_inline_data_truncate+0x4ce/0xc70 fs/ext4/inline.c:1950
 ext4_truncate+0x9ab/0x1270 fs/ext4/inode.c:4173
 ext4_evict_inode+0x7af/0x18c0 fs/ext4/inode.c:263
 evict+0x40c/0x960 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x52a/0x890 fs/inode.c:1958
 ext4_orphan_cleanup+0x742/0x1210 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5610 [inline]
 ext4_fill_super+0x9631/0xaab0 fs/ext4/super.c:5733
 get_tree_bdev_flags+0x38e/0x620 fs/super.c:1636
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
RIP: 0033:0x7f7bf2b874ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bf3a91e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7bf3a91ef0 RCX: 00007f7bf2b874ba
RDX: 0000000020000040 RSI: 00000000200000c0 RDI: 00007f7bf3a91eb0
RBP: 0000000020000040 R08: 00007f7bf3a91ef0 R09: 000000000100010e
R10: 000000000100010e R11: 0000000000000246 R12: 00000000200000c0
R13: 00007f7bf3a91eb0 R14: 0000000000000444 R15: 000000000000002c
 </TASK>
EXT4-fs (loop2): 1 orphan inode deleted
EXT4-fs (loop2): 1 truncate cleaned up
EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.


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

