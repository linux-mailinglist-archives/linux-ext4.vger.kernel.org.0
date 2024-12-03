Return-Path: <linux-ext4+bounces-5474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227579E2912
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2024 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD5CB365B2
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66D1F8AD2;
	Tue,  3 Dec 2024 16:29:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2718BC1D
	for <linux-ext4@vger.kernel.org>; Tue,  3 Dec 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243375; cv=none; b=Q4xS/dHWZY53oxY76mOV1vsuUTucCt8tOmXjAbHnWh9v520nQwayNMOp6k7DuEib8yDzVaZxmx7NgUm0YVo0wYGzjIkvdeOy1ANAlCUeQNVGHxSNc2zYtLh/BShZW1bmSHRAfsuBxEFxzIfNQFr7Sv4YX8PWZPH2t+4IuUw8rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243375; c=relaxed/simple;
	bh=aqpEsbIo0rtx5QAb5eOycGypuf9+vNjdd5oeRV0EtMs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o/SIm9H8vBqGKAQF4E6Ex8Xy5b2UiYTnWIshPPYkMOQBZWjHeK6d+o5jLGksVNGPtVz2DymeWCiENtuPJXyJoCihnYjFQhAZQaROlwnhcEV9qDPGQqoxKiDdgYaXryjmbgm1Q+xfZAjZIuIX+5Wy+5f/e5fHFH5rULUFTvPL1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso506280639f.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Dec 2024 08:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243372; x=1733848172;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9cxxLT1b5n4AT9vFKdOSi982tMwZ4scg59Pv/cXQQ8=;
        b=glLULKxz27xOhjSwHfP+1J0g7+YdTJj+872GxySpdHInPxBUG1K03SVK5QURanYmHq
         uvxJ/ChFz3930hHbuSeP0ToJoIHl8dxyQ5UYKKKJNHIHIDVg5Q3eePzHrasX1XBW3vkN
         xEJXpfjRm00F7fUZufe0eR8QDBV5X1le1vYhPOMoQsjcAMkWc5+9FUW0ASnsJ4A2eVbi
         I3HCMCAb5cHSi4iwPqhypCAca1Gz4QBR/xqxWHhrVh8Se/zG4li1munadkjfUIbWVFkr
         0JS5O+DG6z0G9XKz4IsJdUjY7l+zDV/90gHc33E4Z07g1QG92ftG1yuGQEuyuqsMekJT
         ILwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ8sQIlEIzEp3TZriFAkfKR/JbXlrqBk3cXCDZdnOeSBUL1R/B85946GhbcTgiHbc/WH4YG0L4SIA@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPwucSj/tOL9lSkNFq1WM1b2OoblW+on87HYZl2QGfYKeA8IM
	9NiN8MXWK66bIW8ReV3dXoKrwCIJPXEs9fUDUdp9eWOfJKn6gMeePgr/Sl7Wf2mUtx9P7oAkFOg
	UwS4bTJecE8diXdsyVvItOZXdaApZ+pP6x0al2z8ktyu4vj8qwFsvzkw=
X-Google-Smtp-Source: AGHT+IHMu3HBghlPBmWf0RV50i6N9z/+jTwIhAgrzlXfIvbQOlK/YKxUVW8Gq3BxOto0dmBVMqE9vMb+NmBHjDtgOEyVGU0G1qHo
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:3a7:e8df:3fcb with SMTP id
 e9e14a558f8ab-3a7f9d6dc27mr24948675ab.7.1733243372343; Tue, 03 Dec 2024
 08:29:32 -0800 (PST)
Date: Tue, 03 Dec 2024 08:29:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f31ec.050a0220.48a03.003e.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_map_blocks (2)
From: syzbot <syzbot+c39928fd177c28b5fa1f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e287d31b62b Merge tag 'rtc-6.13' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179f05e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7903df3280dd39ea
dashboard link: https://syzkaller.appspot.com/bug?extid=c39928fd177c28b5fa1f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/555649be4570/disk-0e287d31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/612b3b44653e/vmlinux-0e287d31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cdc015d8348/bzImage-0e287d31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c39928fd177c28b5fa1f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-11930-g0e287d31b62b #0 Not tainted
------------------------------------------------------
kworker/0:4/5894 is trying to acquire lock:
ffff888048f4dbb0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_map_blocks+0x3be/0x1990 fs/ext4/inode.c:665

but task is already holding lock:
ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x6e8/0x1950 mm/filemap.c:3332
       __do_fault+0x137/0x460 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x335a/0x68a0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
       populate_vma_page_range+0x264/0x330 mm/gup.c:1923
       __mm_populate+0x27a/0x460 mm/gup.c:2026
       mm_populate include/linux/mm.h:3386 [inline]
       __do_sys_mlockall mm/mlock.c:769 [inline]
       __se_sys_mlockall+0x3e3/0x4d0 mm/mlock.c:745
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&mm->mmap_lock){++++}-{4:4}:
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
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       loop_reconfigure_limits+0x283/0x9e0 drivers/block/loop.c:1003
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
       ext4_read_block_bitmap_nowait+0x7c5/0xa80 fs/ext4/balloc.c:551
       ext4_mb_prefetch+0x240/0x380 fs/ext4/mballoc.c:2749
       ext4_mb_regular_allocator+0xb44/0x3bb0 fs/ext4/mballoc.c:2898
       ext4_mb_new_blocks+0x10a8/0x4e00 fs/ext4/mballoc.c:6217
       ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
       ext4_ind_map_blocks+0x108c/0x29e0 fs/ext4/indirect.c:635
       ext4_map_create_blocks fs/ext4/inode.c:518 [inline]
       ext4_map_blocks+0x85d/0x1990 fs/ext4/inode.c:702
       ext4_getblk+0x1fa/0x880 fs/ext4/inode.c:849
       ext4_bread+0x2e/0x180 fs/ext4/inode.c:912
       ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
       ext4_add_entry+0xa03/0xfa0 fs/ext4/namei.c:2469
       ext4_mkdir+0x554/0xcf0 fs/ext4/namei.c:3039
       vfs_mkdir+0x2fb/0x4f0 fs/namei.c:4311
       do_mkdirat+0x264/0x3a0 fs/namei.c:4334
       __do_sys_mkdirat fs/namei.c:4349 [inline]
       __se_sys_mkdirat fs/namei.c:4347 [inline]
       __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4347
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
       ext4_map_blocks+0x3be/0x1990 fs/ext4/inode.c:665
       ext4_mpage_readpages+0xad1/0x1ea0 fs/ext4/readpage.c:289
       read_pages+0x178/0x830 mm/readahead.c:160
       page_cache_ra_unbounded+0x797/0x8c0 mm/readahead.c:295
       page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
       filemap_get_pages+0x621/0x2540 mm/filemap.c:2546
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
       do_file_open_root+0x3a7/0x720 fs/namei.c:4039
       file_open_root+0x247/0x2a0 fs/open.c:1382
       kernel_read_file_from_path_initns+0x146/0x220 fs/kernel_read_file.c:163
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x975/0x13b0 drivers/base/firmware_loader/main.c:916
       request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1194
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem --> &mm->mmap_lock --> mapping.invalidate_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock);
  rlock(&ei->i_data_sem);

 *** DEADLOCK ***

4 locks held by kworker/0:4/5894:
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900044c7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900044c7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88802fd759f8 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7a6/0x1fb0 security/integrity/ima/ima_main.c:269
 #3: ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
 #3: ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226

stack backtrace:
CPU: 0 UID: 0 PID: 5894 Comm: kworker/0:4 Not tainted 6.12.0-syzkaller-11930-g0e287d31b62b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events request_firmware_work_func
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
 ext4_map_blocks+0x3be/0x1990 fs/ext4/inode.c:665
 ext4_mpage_readpages+0xad1/0x1ea0 fs/ext4/readpage.c:289
 read_pages+0x178/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x797/0x8c0 mm/readahead.c:295
 page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
 filemap_get_pages+0x621/0x2540 mm/filemap.c:2546
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
 do_file_open_root+0x3a7/0x720 fs/namei.c:4039
 file_open_root+0x247/0x2a0 fs/open.c:1382
 kernel_read_file_from_path_initns+0x146/0x220 fs/kernel_read_file.c:163
 fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
 _request_firmware+0x975/0x13b0 drivers/base/firmware_loader/main.c:916
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1194
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
usb 3-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008


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

