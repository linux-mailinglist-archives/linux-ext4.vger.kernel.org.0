Return-Path: <linux-ext4+bounces-5565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E053B9ED68A
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 20:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73114164F0F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519371C5F0E;
	Wed, 11 Dec 2024 19:32:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FA1C461F
	for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945547; cv=none; b=Th911JTijUt5xQzOJIUzZ0yFCX5SiyKUeD6j06yD02ztA5RiWocUAnte7yy95VewYuapsWSVA0yr/caZLKx4mDo6eh9Iy1bjeY3CpHPQGrt/UA7tthLBoOF+Alo1GvBEUmg2Egit7uRF9+RU9y9PCChYIYgHqTvvRT00iFmI+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945547; c=relaxed/simple;
	bh=MLOpFEkMqJPTMdPwgkXHfNs4scYOke/34vAeQSpYcnU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NTuFAlOkl+C6BFqMYdrfe0ngV0VQLiS5of+8TNfMiDS+afkM4hd/49a+cE0VL0SCbq9w/K7KM1ihqSiXR4nPyq1hr1YtHs6Xw1SqfhmIDahnNiUsC6GUahlKrtQLY/LTHd2BXz790elb5XADAueYBtdKggY4YWXgK7yLLTOcpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so87925125ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 11:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733945544; x=1734550344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kw/EOlaA93fNaAcnO0z8scl2FgQLUBYpUGoEP7c+QLI=;
        b=sCu3wCzkq3TbZiNyd0BEfh7dpAeUNe/HpojqA4xCvbb4NsWnOArBVvA0RDf8OPRfZE
         /NMKBHT/RjJWWQh8oBJo8DEK/oo7kRamDx3yWkvuXgztdR3EIqVdr2z4oeN7aybp7j4C
         qwy/ZufdY1midfIbUUb/8qMpZe1RlhkXR7QXE+7Tto6AGiPnVd0Igd+eE23B4uEoUjX0
         Ov1KSdIvwSu2aFHISVa9YYao02fIci5gyJt+zn19n5aMaE+O3kfBPICf4lUei6aPdhVx
         8p2Q7p98GH9j4GtngU6UOY7N9FH2B5gl9Sk7rQfdDxCEkEjvGY/u+o7/nvi4NFQMzRtG
         ulxg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsRHVu9h5ACIhiJqOQIfp2HLp2rjpdlZXkHHYiO8G0JLO0rQsKIxY8Rjq3xRNMzEFfbg8hqtSfcet@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL+mNEwAeED8jQ689yWboDzSKxrXUg7R//01ALxSpBjWZPEfE
	rk/hhmysfjvDGDu49naqTbaUb4BO4zOJ0pnCbnuF1mVT+JzOl0OS3Z7YORkwNCnOqbyg45fa/Ls
	MSkmxga2uY4AV2nou65uVYDj4J7uMk9xIbDsXardtkSecgRhR/cRo3R0=
X-Google-Smtp-Source: AGHT+IE8m2cdqZO51l0fg6B13AWIQTdewGOedhy+jOnUFW+PaGfR/fUUYQHsHp67Bd82zwpyKf1U0fNIwIn2vKBYW81pg0TvQpxp
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:dfe4:bd33 with SMTP id
 e9e14a558f8ab-3ac4830790dmr8657945ab.6.1733945543513; Wed, 11 Dec 2024
 11:32:23 -0800 (PST)
Date: Wed, 11 Dec 2024 11:32:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759e8c7.050a0220.17f54a.0042.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_da_get_block_prep (2)
From: syzbot <syzbot+cbcad0f3b7646f8653ee@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164170f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=cbcad0f3b7646f8653ee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4000132d9d47/disk-b5f21708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85cadac2b6fb/vmlinux-b5f21708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0321667f4cf4/bzImage-b5f21708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbcad0f3b7646f8653ee@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 2048
EXT4-fs (loop4): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0 Not tainted
------------------------------------------------------
syz.4.1456/13188 is trying to acquire lock:
ffff888040d89658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_da_map_blocks fs/ext4/inode.c:1799 [inline]
ffff888040d89658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_da_get_block_prep+0x428/0x1900 fs/ext4/inode.c:1873

but task is already holding lock:
ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:846 [inline]
ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_write_inline_data_begin+0x2d3/0x1090 fs/ext4/inline.c:921

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&ei->xattr_sem){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       ext4_readpage_inline+0x36/0x6b0 fs/ext4/inline.c:518
       ext4_read_folio+0x174/0x340 fs/ext4/inode.c:3185
       filemap_read_folio+0x14d/0x630 mm/filemap.c:2366
       filemap_create_folio mm/filemap.c:2497 [inline]
       filemap_get_pages+0x100a/0x2540 mm/filemap.c:2555
       filemap_read+0x45c/0xf50 mm/filemap.c:2646
       __kernel_read+0x515/0x9d0 fs/read_write.c:523
       integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:293
       process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:372
       ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
       security_file_post_open+0xb9/0x280 security/security.c:3121
       do_open fs/namei.c:3830 [inline]
       path_openat+0x2ccd/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226
       do_async_mmap_readahead mm/filemap.c:3231 [inline]
       filemap_fault+0x82a/0x1950 mm/filemap.c:3330
       __do_fault+0x137/0x460 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x335a/0x68a0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
       __get_user_pages_locked mm/gup.c:1751 [inline]
       get_dump_page+0x155/0x2f0 mm/gup.c:2269
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

-> #1 (&q->q_usage_counter(io)#24){++++}-{0:0}:
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
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       ext4_da_map_blocks fs/ext4/inode.c:1799 [inline]
       ext4_da_get_block_prep+0x428/0x1900 fs/ext4/inode.c:1873
       ext4_block_write_begin+0x55c/0x1980 fs/ext4/inode.c:1063
       ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:860 [inline]
       ext4_da_write_inline_data_begin+0x545/0x1090 fs/ext4/inline.c:921
       ext4_da_write_begin+0x4fe/0xa60 fs/ext4/inode.c:2932
       generic_perform_write+0x346/0x6d0 mm/filemap.c:4055
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

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem --> mapping.invalidate_lock --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&ei->xattr_sem);
                               lock(mapping.invalidate_lock);
                               lock(&ei->xattr_sem);
  rlock(&ei->i_data_sem);

 *** DEADLOCK ***

3 locks held by syz.4.1456/13188:
 #0: ffff888024e38420 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff888024e38420 (sb_writers#4){.+.+}-{0:0}, at: vfs_writev+0x2d1/0xba0 fs/read_write.c:1048
 #1: ffff888040d897c8 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #1: ffff888040d897c8 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: ext4_buffered_write_iter+0x96/0x350 fs/ext4/file.c:294
 #2: ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:846 [inline]
 #2: ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_write_inline_data_begin+0x2d3/0x1090 fs/ext4/inline.c:921

stack backtrace:
CPU: 0 UID: 0 PID: 13188 Comm: syz.4.1456 Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
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
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 ext4_da_map_blocks fs/ext4/inode.c:1799 [inline]
 ext4_da_get_block_prep+0x428/0x1900 fs/ext4/inode.c:1873
 ext4_block_write_begin+0x55c/0x1980 fs/ext4/inode.c:1063
 ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:860 [inline]
 ext4_da_write_inline_data_begin+0x545/0x1090 fs/ext4/inline.c:921
 ext4_da_write_begin+0x4fe/0xa60 fs/ext4/inode.c:2932
 generic_perform_write+0x346/0x6d0 mm/filemap.c:4055
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
RIP: 0033:0x7f71caf7fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f71cbdcb058 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f71cb145fa0 RCX: 00007f71caf7fed9
RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000009
RBP: 00007f71caff3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f71cb145fa0 R15: 00007ffee86e1f88
 </TASK>
EXT4-fs (loop4): Delayed block allocation failed for inode 15 at logical offset 10 with max blocks 23 with error 28
EXT4-fs (loop4): This should not happen!! Data will be lost

EXT4-fs (loop4): Total free blocks count 0
EXT4-fs (loop4): Free/Dirty block details
EXT4-fs (loop4): free_blocks=66060288
EXT4-fs (loop4): dirty_blocks=48
EXT4-fs (loop4): Block reservation details
EXT4-fs (loop4): i_reserved_data_blocks=3


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

