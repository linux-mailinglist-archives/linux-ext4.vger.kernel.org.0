Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D9483FEE
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiADKbA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 05:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiADKa7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 05:30:59 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ACFC061761;
        Tue,  4 Jan 2022 02:30:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m19so89194705ybf.9;
        Tue, 04 Jan 2022 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xuJX/jBMhr8YvrxaBiqWXFWn5HXvt5pCMape+CywA3E=;
        b=SMtJ5xgUnkHqeye2PuFg3S48LRk/Iwx/IWKjOvK7TT5pXDRBfyj2qC5zAo8jPRj+p8
         iXVWNWfdvvOBPoVQLOpEVIVPBkwnlcVN5NUGvEKPtz7JL3CsRePKPiAphljjgcfQlz1j
         YbMM5yFSepUHfg2Xq/LE4d+2ObYOmv0MsU2SLSWFN3lFoEShOOTUP0/vtDodIsDvKRZe
         QHa1oKRAtHWYFdb3SZ13PfIg1+SG9rniUzEwwDoWtwjj7evKFLypByTWwgxd5q8IH9gg
         mFlx5OAs8eDZalPn6TBbJhUZGfHP4R1VF/5b6ZgCKXPtcYKzeQ9hO+6d1sEK9mHGUllq
         BKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xuJX/jBMhr8YvrxaBiqWXFWn5HXvt5pCMape+CywA3E=;
        b=cWmc4h/PNeI48Nv3eMqod3mIu4X2IjLBHUXJqfpAyTErDIjZiqnZor3diS3RJ5JMD2
         IIVpO3z5PQj7ZiZFKkfUDfnFV1eTLgost21yd3kNFI1scXJk8uQn5wlPhFs5pNgGVrVJ
         1asbKeETtMtT+n56fI9R5S34PQTW0FDBBGYG+rzRCSQI/lITy4iAIMx8QWb6z2o+shOD
         hr+eaJBfBoMadSNHSyLMVb/4ykZXKY8USn8bUGy0sCb2V8YdXv/SyPl55XCB2apzJSf+
         sxV2fQK2RQSP9cX/D5Z6N+NtbYgOIEDjYO6x98MKajfGZkINU4EarEu3/OpkpnhSYqzO
         RS8Q==
X-Gm-Message-State: AOAM531rpx7bCG38aCXNDQIB0dyPzogGj4a7s/cqS3QvKcXRZRr1G8Yh
        Mo6sK7o9wXfqrz+ukTcHuZv8/6ABJK8zjvOs5iw=
X-Google-Smtp-Source: ABdhPJy30nbPxxwOCP78uSUNRhrLn+JI4nbdUUmuUBtQaVK7+SeSX2vd/KW+dpVQx7KZkPsWOjPqZ4M9jURrtpMkaMs=
X-Received: by 2002:a25:3006:: with SMTP id w6mr65637975ybw.691.1641292258520;
 Tue, 04 Jan 2022 02:30:58 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 18:30:47 +0800
Message-ID: <CAFkrUshr_89Kdax0bJb6BHAZhLgzkkJOxY45Cci7UwzQ6TmiRw@mail.gmail.com>
Subject: INFO: task hung in add_transaction_credits
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/N2WMbfsc5s/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task kworker/u9:5:656 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:5    state:D stack:23480 pid:  656 ppid:     2 flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 wait_transaction_locked+0x1c8/0x250 fs/jbd2/transaction.c:183
 add_transaction_credits+0x10f/0xb00 fs/jbd2/transaction.c:246
 start_this_handle+0x39e/0x1360 fs/jbd2/transaction.c:427
 jbd2__journal_start fs/jbd2/transaction.c:525 [inline]
 jbd2__journal_start+0x399/0x920 fs/jbd2/transaction.c:490
 __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_writepages+0xb40/0x3180 fs/ext4/inode.c:2778
 do_writepages+0x19b/0x610 mm/page-writeback.c:2364
 __writeback_single_inode+0x12b/0x1040 fs/fs-writeback.c:1616
 writeback_sb_inodes+0x548/0xe30 fs/fs-writeback.c:1881
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1951
 wb_writeback+0x7f8/0xc30 fs/fs-writeback.c:2056
 wb_check_start_all fs/fs-writeback.c:2178 [inline]
 wb_do_writeback fs/fs-writeback.c:2204 [inline]
 wb_workfn+0xa85/0x11a0 fs/fs-writeback.c:2238
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task jbd2/sda-8:3028 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda-8      state:D stack:24624 pid: 3028 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 jbd2_journal_commit_transaction+0x8a1/0x6c90 fs/jbd2/commit.c:496
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task syz-executor.5:20604 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:23280 pid:20604 ppid:     1 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 wait_transaction_locked+0x1c8/0x250 fs/jbd2/transaction.c:183
 add_transaction_credits+0x10f/0xb00 fs/jbd2/transaction.c:246
 start_this_handle+0x39e/0x1360 fs/jbd2/transaction.c:427
 jbd2__journal_start fs/jbd2/transaction.c:525 [inline]
 jbd2__journal_start+0x399/0x920 fs/jbd2/transaction.c:490
 __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5916
 __mark_inode_dirty+0x53d/0xfe0 fs/fs-writeback.c:2399
 generic_update_time+0x21d/0x350 fs/inode.c:1782
 inode_update_time+0x92/0xc0 fs/inode.c:1795
 touch_atime+0x3c4/0x5b0 fs/inode.c:1867
 file_accessed include/linux/fs.h:2505 [inline]
 iterate_dir+0x465/0x700 fs/readdir.c:70
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x14b/0x2e0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc71cf69a2b
RSP: 002b:00007ffe1e4129d8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000555555bfdd80 RCX: 00007fc71cf69a2b
RDX: 0000000000008000 RSI: 0000555555bfdd80 RDI: 0000000000000003
RBP: ffffffffffffffbc R08: 0000000000000030 R09: 000000000000007c
R10: 00007fc71d034520 R11: 0000000000000293 R12: 0000555555bfdd54
R13: 0000000000000016 R14: 0000555555bfdd50 R15: 00007ffe1e413bb0
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/10:
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900006d7dc8 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8bb89e70 (rcu_state.barrier_mutex){+.+.}-{3:3}, at:
rcu_barrier+0x44/0x430 kernel/rcu/tree.c:3985
1 lock held by ksoftirqd/0/15:
1 lock held by ksoftirqd/3/32:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
2 locks held by kswapd0/122:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
try_to_freeze_unsafe include/linux/freezer.h:58 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze
include/linux/freezer.h:67 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xc63/0x1190 mm/vmscan.c:4227
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
4 locks held by kworker/u9:5/656:
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888100de8138 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc90003bbfdc8
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff88810c7ec0e0 (&type->s_umount_key#36){++++}-{3:3}, at:
trylock_super+0x1d/0x100 fs/super.c:418
 #3: ffff88810c7eebd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at:
do_writepages+0x19b/0x610 mm/page-writeback.c:2364
3 locks held by kworker/0:2/2961:
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c66138
((wq_completion)events_freezable_power_){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc90010fa7dc8
((work_completion)(&(&ev->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #2: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by systemd-journal/3050:
 #0: ffff888019a99980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888019a99980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by systemd-udevd/3064:
 #0: ffff888021950f88 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888021950f88 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by systemd-timesyn/3126:
 #0: ffff888019a99980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888019a99980 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by in:imklog/6750:
 #0: ffff888021a6d550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888021a6d550 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
3 locks held by rs:main Q:Reg/6751:
 #0: ffff888017695770 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff88802cc217e0 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff88802cc217e0 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at:
ext4_buffered_write_iter+0xb8/0x360 fs/ext4/file.c:263
2 locks held by cron/6316:
 #0: ffff888025c42d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888025c42d70 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
3 locks held by syz-fuzzer/6694:
 #0: ffff888108450370 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff88802cd283f0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
iterate_dir+0xcd/0x700 fs/readdir.c:55
 #2: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed
include/linux/fs.h:2505 [inline]
 #2: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
iterate_dir+0x465/0x700 fs/readdir.c:70
2 locks held by syz-fuzzer/6695:
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by syz-fuzzer/6698:
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by syz-fuzzer/6709:
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888028c13768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by syz-executor.4/6798:
 #0: ffff8880277683f0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
iterate_dir+0xcd/0x700 fs/readdir.c:55
 #1: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed
include/linux/fs.h:2505 [inline]
 #1: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
iterate_dir+0x465/0x700 fs/readdir.c:70
3 locks held by kworker/1:4/10632:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000131fdc8 (fqdir_free_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8bb89e70 (rcu_state.barrier_mutex){+.+.}-{3:3}, at:
rcu_barrier+0x44/0x430 kernel/rcu/tree.c:3985
2 locks held by syz-executor.5/20604:
 #0: ffff88808342dda8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
iterate_dir+0xcd/0x700 fs/readdir.c:55
 #1: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed
include/linux/fs.h:2505 [inline]
 #1: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
iterate_dir+0x465/0x700 fs/readdir.c:70
4 locks held by syz-executor.1/20606:
 #0: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
filename_create+0xf3/0x490 fs/namei.c:3649
 #1: ffff888028ff7198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff888028ff7198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
filename_create+0x158/0x490 fs/namei.c:3654
 #2: ffff88810c7f8990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
1 lock held by syz-executor.7/25384:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.7/25519:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.7/25654:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/28530:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.2/28576:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.2/28604:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/28686:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.2/28706:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.2/28785:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.0/28815:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.7/29576:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.7/29628:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
1 lock held by syz-executor.7/29687:
 #0: ffff88810c7ec650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
4 locks held by syz-executor.4/30247:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88805beba428 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88805beba428 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88805beba428 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880305e0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880305e0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880305e0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.4/30248:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30249:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88805beb9628 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88805beb9628 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88805beb9628 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880ba8cea28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880ba8cea28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880ba8cea28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.4/30250:
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30251:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30252:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88812ed97128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88812ed97128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88812ed97128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888096256a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888096256a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888096256a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
4 locks held by syz-executor.4/30253:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88805bebc028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88805bebc028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88805bebc028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880badb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880badb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880badb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
1 lock held by syz-executor.4/30254:
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30256:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30257:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88812ed94e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88812ed94e28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88812ed94e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808fb6e328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808fb6e328 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808fb6e328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
4 locks held by syz-executor.4/30258:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88805e9d8f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88805e9d8f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88805e9d8f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880807d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880807d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880807d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #3: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
anon_vma_clone+0x143/0x480 mm/rmap.c:292
1 lock held by syz-executor.4/30259:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.4/30260:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804e73ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804e73ab28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804e73ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808a8e3928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808a8e3928 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808a8e3928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #3: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
anon_vma_clone+0x143/0x480 mm/rmap.c:292
1 lock held by syz-executor.4/30261:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.4/30263:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88812ed91628 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88812ed91628 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88812ed91628 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808a992428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808a992428 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808a992428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #3: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
anon_vma_clone+0x143/0x480 mm/rmap.c:292
4 locks held by syz-executor.4/30262:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801fb48828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801fb48828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801fb48828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888099df2428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888099df2428 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888099df2428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.4/30264:
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30265:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30266:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30267:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801fb48128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801fb48128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801fb48128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a0e03928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a0e03928 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a0e03928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #3: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
anon_vma_clone+0x143/0x480 mm/rmap.c:292
1 lock held by syz-executor.4/30268:
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88801816b578 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
4 locks held by syz-executor.4/30269:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804e38ea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804e38ea28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804e38ea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880badb3228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880badb3228 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880badb3228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
1 lock held by syz-executor.4/30270:
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30271:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30272:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88812ed94728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88812ed94728 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88812ed94728 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880ac828128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880ac828128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880ac828128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.4/30273:
 #0: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30274:
 #0: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880151a1cf8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
4 locks held by syz-executor.4/30275:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804e388828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804e388828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804e388828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88802685f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88802685f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88802685f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
4 locks held by syz-executor.4/30276:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888063f39a98 (&rq->__lock){-.-.}-{2:2}, at:
raw_spin_rq_lock_nested+0x1e/0x30 kernel/sched/core.c:478
 #2: ffff888063f279c8 (&per_cpu_ptr(group->pcpu,
cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3b4/0x4a0
kernel/sched/psi.c:880
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock
include/linux/spinlock.h:349 [inline]
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at:
copy_pte_range mm/memory.c:1024 [inline]
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at:
copy_pmd_range mm/memory.c:1159 [inline]
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at:
copy_pud_range mm/memory.c:1196 [inline]
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at:
copy_p4d_range mm/memory.c:1220 [inline]
 #3: ffff888029a10918 (ptlock_ptr(page)#2){+.+.}-{2:2}, at:
copy_page_range+0xb4f/0x45d0 mm/memory.c:1293
1 lock held by syz-executor.4/30277:
 #0: ffff88804f208b78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208b78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30278:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30279:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30280:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30281:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30282:
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
4 locks held by syz-executor.4/30283:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888061240f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888061240f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888061240f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888085d64028 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888085d64028 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888085d64028 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mmap kernel/fork.c:576 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
dup_mm+0x761/0x13d0 kernel/fork.c:1450
1 lock held by syz-executor.4/30284:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30285:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30286:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30288:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30289:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30290:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30291:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30292:
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30295:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30298:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30299:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30300:
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff88804f208c78 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30302:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169
1 lock held by syz-executor.4/30303:
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
lock_anon_vma_root mm/rmap.c:246 [inline]
 #0: ffff8880181b0878 (&anon_vma->rwsem){++++}-{3:3}, at:
unlink_anon_vmas+0x1fb/0x850 mm/rmap.c:402
1 lock held by syz-executor.4/30304:
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_write include/linux/fs.h:498 [inline]
 #0: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
unlink_file_vma+0x7d/0x110 mm/mmap.c:169




Best Regards,
Yiru
