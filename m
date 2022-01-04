Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877CC4840FC
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiADLhU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiADLhU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 06:37:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA838C061761;
        Tue,  4 Jan 2022 03:37:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w184so87395867ybg.5;
        Tue, 04 Jan 2022 03:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RW0bUCTC3I0sTNzO29MIxFNJQvewFLmW/uoLATwKLuk=;
        b=myvI0yC+qIabyQx1wCzOUwMPvXTc1icfvLHFkwVS+2rWi2hWoBa8XZE2WQmiv6NJ36
         aiREFOVCBK7KtwAOZkMEqXaRiKv0lC4YY2MKJslzu34zSJSBdjY4PSxSZ3fPxvRnzuvS
         Vp6cntTrOGXK8v6KDeX3LskVyKepU4SU2TxEou2iZoFfcEQ0BH+pIgSOpvsWVmceL8c5
         Chq31JuyLzMt2bC+G82cdycZGQEVUGVYiUFrmOsWHIbhZsrMdZ+xi8gp01NUETopdNFB
         bEXiheTmCLL59E88J4nOyfW2EK/JntgvIbxwDnAa8MIePegFa99oYQMhAlMupqGRwM/b
         /XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RW0bUCTC3I0sTNzO29MIxFNJQvewFLmW/uoLATwKLuk=;
        b=7cLTsTOQYETKgZNDgnZgvOofmAk8Wh0JCGzlK2nh/uvnabdRzDnn0GMNkqWfFa0JVl
         TUgJCoFJmdZBl2VE3vQ7QJdSYV0PYlMaExPogCeyEy9dDOqUFz1gLyjaDVX5GOCUxjzh
         LwTsVZNgaTbxNOhan6Gdt+5EgStvJVqpOVbx9pQYO3j+xvfBkiIM4OmzGqzOOFRIrDng
         /UgXXinIEvZ4el5VzNIYgHLBRIcxcHVU1VVw/HfvhC/DknmT1m//uCDejYSZv7Z8dOAG
         4Pg9U+JDn0wBzuWGDTBFODPk8Iz2c6bxVRI82hdvaEYZjrI/6zS4xWExgnCZ99JmCyUB
         h/aw==
X-Gm-Message-State: AOAM530I8uNw4QZXAUDgXnL9vvfnOu4uCx27NpaMj5SLDQSeGcE0VCkR
        bLJNxWRQaYSyQOhm1GJ78yWJ3WjYORr3wWHWKA4=
X-Google-Smtp-Source: ABdhPJyJimHQHm+UJBx5dgi7egTRNzcZFieDlbpLElSvf2Sb9dExNmQI/+Z8d1/DwG5mZO91Rj1LQZYI2JNLkvubncs=
X-Received: by 2002:a25:305:: with SMTP id 5mr55765718ybd.439.1641296238265;
 Tue, 04 Jan 2022 03:37:18 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:37:07 +0800
Message-ID: <CAFkrUsgP4RNw=RU=bpZYjRdP43F8Dx0PU6h1-rEuHsxmTiBtQw@mail.gmail.com>
Subject: INFO: task hung in ext4_da_write_end
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
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
console output: https://paste.ubuntu.com/p/bVTKZ7mFh3/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task rs:main Q:Reg:6764 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rs:main Q:Reg   state:D stack:24568 pid: 6764 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 ext4_update_i_disksize fs/ext4/ext4.h:3410 [inline]
 ext4_da_write_end+0x7af/0x9d0 fs/ext4/inode.c:3057
 generic_perform_write+0x2c4/0x510 mm/filemap.c:3765
 ext4_buffered_write_iter+0x170/0x360 fs/ext4/file.c:269
 ext4_file_write_iter+0x42e/0x14a0 fs/ext4/file.c:681
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x432/0x660 fs/read_write.c:503
 vfs_write+0x678/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f17e63c11cd
RSP: 002b:00007f17e397c590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f17d80254c0 RCX: 00007f17e63c11cd
RDX: 000000000000005a RSI: 00007f17d80254c0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 0000000000000000 R09: 312d382062737520
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f17d8025240
R13: 00007f17e397c5b0 R14: 00005649f0b9d440 R15: 000000000000005a
 </TASK>

Showing all locks held in the system:
2 locks held by systemd/1:
 #0: ffff88801b17e940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801b17e940 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
 #1: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by oom_reaper/40:
2 locks held by kswapd0/122:
2 locks held by kswapd1/123:
1 lock held by jbd2/sda-8/3027:
1 lock held by systemd-journal/3051:
2 locks held by systemd-udevd/3062:
 #0: ffff88802302f198 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:793 [inline]
 #0: ffff88802302f198 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
lookup_slow fs/namei.c:1673 [inline]
 #0: ffff88802302f198 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
walk_component+0x400/0x6a0 fs/namei.c:1970
 #1: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #1: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by systemd-timesyn/3125:
 #0: ffff88801b171980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801b171980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by cron/6290:
2 locks held by rsyslogd/6324:
2 locks held by in:imklog/6763:
 #0: ffff888019864728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff888019864728 (&mm->mmap_lock#2){++++}-{3:3}, at:
do_user_addr_fault+0x285/0x11c0 arch/x86/mm/fault.c:1338
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by rs:main Q:Reg/6764:
 #0: ffff888018c3adf0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff88810c05e460 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff88802b0521d8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff88802b0521d8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
ext4_buffered_write_iter+0xb8/0x360 fs/ext4/file.c:263
 #3: ffff88802b052060 (&ei->i_data_sem){++++}-{3:3}, at:
ext4_update_i_disksize fs/ext4/ext4.h:3410 [inline]
 #3: ffff88802b052060 (&ei->i_data_sem){++++}-{3:3}, at:
ext4_da_write_end+0x7af/0x9d0 fs/ext4/inode.c:3057
1 lock held by syz-fuzzer/6688:
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by syz-fuzzer/6691:
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6693:
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6694:
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6708:
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888027673768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by kworker/u8:2/7532:
5 locks held by kworker/u8:3/7980:
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at: atomic_long_set
include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at: set_work_data
kernel/workqueue.c:635 [inline]
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8881052eb938
((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000e607dc8
((work_completion)(&ei->i_rsv_conversion_work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff88810c062990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #3:
ffff88802b052060 (
&ei->i_data_sem
){++++}-{3:3}
, at: ext4_map_blocks+0x5e1/0x17d0 fs/ext4/inode.c:630
 #4:
ffff888110054218
 (&mapping->i_mmap_rwsem
){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:513 [inline]
){++++}-{3:3}, at: rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
4 locks held by kworker/u8:6/9833:
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
 #1:
ffffc900184ffdc8
 (
net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8f7/0x16d0
kernel/workqueue.c:2273
 #2: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x9b/0xa90 net/core/net_namespace.c:555
 #3: ffffffff8bb89f68 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
 #3: ffffffff8bb89f68 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x2f2/0x650 kernel/rcu/tree_exp.h:836
2 locks held by syz-executor.5/9869:
 #0: ffff888105234d88 (&xt[i].mutex){+.+.}-{3:3}, at:
xt_find_table_lock+0x147/0x690 net/netfilter/x_tables.c:1242
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
3 locks held by kworker/1:23/21685:
 #0: ffff888010c66138
 ((wq_completion)events_freezable_power_){+.+.}-{0:0}
, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
, at: set_work_data kernel/workqueue.c:635 [inline]
, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
, at: process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1:
ffffc900150cfdc8
 (
(work_completion)(&(&ev->dwork)->work)
){+.+.}-{0:0}, at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff888110054218 (
&mapping->i_mmap_rwsem){++++}-{3:3}
, at: i_mmap_lock_read include/linux/fs.h:513 [inline]
, at: rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
3 locks held by kworker/2:16/531:
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88810a60d138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900040afdc8 ((addr_chk_work).work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
addrconf_verify_work+0xa/0x20 net/ipv6/addrconf.c:4595
4 locks held by syz-executor.4/20628:
 #0: ffff88810c05e460 (sb_writers#5){.+.+}-{0:0}, at:
do_rmdir+0x1d0/0x390 fs/namei.c:4013
 #1: ffff88803ab553b0 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88803ab553b0 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
do_rmdir+0x21b/0x390 fs/namei.c:4017
 #2: ffff88802772bfc0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff88802772bfc0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir fs/namei.c:3958 [inline]
 #2: ffff88802772bfc0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir+0xe3/0x570 fs/namei.c:3946
 #3: ffff88810c062990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
4 locks held by syz-executor.6/8933:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804fc46328 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804fc46328 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804fc46328 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888040a68128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888040a68128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888040a68128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
5 locks held by syz-executor.7/8934:
 #0: ffff88810c05e460 (sb_writers#5){.+.+}-{0:0}, at:
do_rmdir+0x1d0/0x390 fs/namei.c:4013
 #1: ffff88801b175da8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88801b175da8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
do_rmdir+0x21b/0x390 fs/namei.c:4017
 #2: ffff88801b1ae7a0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff88801b1ae7a0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir fs/namei.c:3958 [inline]
 #2: ffff88801b1ae7a0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir+0xe3/0x570 fs/namei.c:3946
 #3: ffff88810c062990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #4: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #4: ffff888110054218 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
2 locks held by syz-executor.1/8935:
 #0: ffff888085faab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff888085faab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
do_user_addr_fault+0x285/0x11c0 arch/x86/mm/fault.c:1338
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.2/10735:
 #0: ffff8880518a21d8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
iterate_dir+0xcd/0x700 fs/readdir.c:55
 #1: ffff88810c05e460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed
include/linux/fs.h:2505 [inline]
 #1: ffff88810c05e460 (sb_writers#5){.+.+}-{0:0}, at:
iterate_dir+0x465/0x700 fs/readdir.c:70
 #2: ffff88810c062990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #3:
ffff888110054218
 (&mapping->i_mmap_rwsem
){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:513 [inline]
){++++}-{3:3}, at: rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345
1 lock held by syz-executor.3/25493:
 #0: ffff888110313210 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #0: ffff888110313210 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at:
__sock_release+0x86/0x280 net/socket.c:648
1 lock held by syz-executor.3/25654:
 #0: ffff8880233e0e10 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #0: ffff8880233e0e10 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at:
__sock_release+0x86/0x280 net/socket.c:648
2 locks held by kworker/2:5/29839:
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000facfdc8 ((work_completion)(&rew.rew_work)){+.+.}-{0:0},
at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
1 lock held by systemd-udevd/32061:
 #0: ffff88801b17e940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801b17e940 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by systemd-udevd/32069:
 #0: ffff888015bcb768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888015bcb768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32087:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888040a6c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888040a6c728 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888040a6c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888090c34028 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888090c34028 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888090c34028 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32088:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888040a6ea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888040a6ea28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888040a6ea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809caf5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809caf5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809caf5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32097:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880223af828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880223af828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880223af828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b471f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b471f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b471f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32098:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880223a8f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880223a8f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880223a8f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880aaa8c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880aaa8c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880aaa8c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32099:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880223a8128 (&mm->mmap_lock#2){++++}-{3:3}
, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
, at: dup_mmap kernel/fork.c:498 [inline]
, at: dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a4cc8128 (
&mm->mmap_lock/1){+.+.}-{3:3}
, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
, at: dup_mmap kernel/fork.c:507 [inline]
, at: dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3:
ffffffff8bca5140 (fs_reclaim
){+.+.}-{0:0}
, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
, at: __alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32100:
 #0: ffffffff8bc53fd0
 (dup_mmap_sem
){.+.+}-{0:0}
, at: dup_mmap kernel/fork.c:497 [inline]
, at: dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1:
ffff8880223ac728 (
&mm->mmap_lock#2){++++}-{3:3}
, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
, at: dup_mmap kernel/fork.c:498 [inline]
, at: dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88801a21dc28
 (&mm->mmap_lock
/1){+.+.}-{3:3}, at: mmap_write_lock_nested
include/linux/mmap_lock.h:78 [inline]
/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:507 [inline]
/1){+.+.}-{3:3}, at: dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32101:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880223ad528
 (&mm->mmap_lock
#2
){++++}-{3:3}
, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
, at: dup_mmap kernel/fork.c:498 [inline]
, at: dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a2e78f28
 (
&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested
include/linux/mmap_lock.h:78 [inline]
&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:507 [inline]
&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32102:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801a5ff828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801a5ff828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801a5ff828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888091a20128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888091a20128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888091a20128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32103:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e03928 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e03928 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e03928 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809ef59d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809ef59d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809ef59d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32104:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888020f4b228 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888020f4b228 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888020f4b228 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888089af0f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888089af0f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888089af0f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32105:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f674e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f674e28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f674e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b4718f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b4718f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b4718f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32106:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f670128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f670128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f670128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880877bdc28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880877bdc28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880877bdc28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32107:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f670f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f670f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f670f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b41cb228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b41cb228 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b41cb228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32108:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e04e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e04e28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e04e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b529ab28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b529ab28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b529ab28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32109:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f677128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f677128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f677128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b4719628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b4719628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b4719628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32110:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124b928 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124b928 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124b928 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888085e0f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888085e0f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888085e0f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32112:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32113:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e00f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e00f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e00f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808786f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808786f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808786f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32114:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e04028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e04028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e04028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809f7b5528 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809f7b5528 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809f7b5528 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32115:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f672b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f672b28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f672b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88805d31f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88805d31f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88805d31f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32116:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124a428 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124a428 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124a428 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a2e7ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a2e7ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a2e7ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32117:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32118:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124c728 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888083016a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888083016a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888083016a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32120:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f671d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f671d28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f671d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808ed36a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808ed36a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808ed36a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32121:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e07128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e07128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e07128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809f7b7128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809f7b7128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809f7b7128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32122:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32123:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e06328 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e06328 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e06328 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88802340b228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88802340b228 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88802340b228 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32124:
4 locks held by syz-executor.5/32127:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f674728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f674728 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f674728 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880ad8dd528 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880ad8dd528 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880ad8dd528 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32128:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124f128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124f128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124f128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809805b928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809805b928 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809805b928 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32129:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888021b02b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888021b02b28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888021b02b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88804cdb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88804cdb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88804cdb0128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32130:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888020314028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888020314028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888020314028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b4cff828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b4cff828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b4cff828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32131:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1:
ffff88801f676a28
 (&mm->mmap_lock
#2
){++++}-{3:3}
, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
, at: dup_mmap kernel/fork.c:498 [inline]
, at: dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888083017828 (
&mm->mmap_lock/1
){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:507 [inline]
){+.+.}-{3:3}, at: dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32132:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124dc28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124dc28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124dc28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888089af1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888089af1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888089af1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32133:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32134:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32135:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888017e05528 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888017e05528 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888017e05528 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888094d5f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888094d5f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888094d5f828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32136:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f671628 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f671628 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f671628 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808f2d3228 (&mm->mmap_lock
/1){+.+.}-{3:3}, at: mmap_write_lock_nested
include/linux/mmap_lock.h:78 [inline]
/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:507 [inline]
/1){+.+.}-{3:3}, at: dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32137:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880223ace28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880223ace28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880223ace28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a6658f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a6658f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a6658f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32138:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88801f673928 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88801f673928 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88801f673928 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b4719d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b4719d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b4719d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32139:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888021b01628 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888021b01628 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888021b01628 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88809858a428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88809858a428 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88809858a428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32140:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124e328 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124e328 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124e328 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880885a8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880885a8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880885a8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32141:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888021248128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888021248128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888021248128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888094dd1d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888094dd1d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888094dd1d28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32142:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124ab28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888083016328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888083016328 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888083016328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32154:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1:
ffff888021b06a28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff888021b06a28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
ffff888021b06a28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2:
ffff88809289c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
ffff88809289c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
ffff88809289c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32155:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802f949628 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802f949628 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802f949628 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b6514e28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b6514e28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b6514e28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32156:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802124c028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802124c028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802124c028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808048ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808048ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808048ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32157:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802f94f128 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802f94f128 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802f94f128 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a7184728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a7184728 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a7184728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140
 (
fs_reclaim){+.+.}-{0:0}
, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
, at: __alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32158:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802f94f828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802f94f828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802f94f828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88800efff128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88800efff128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88800efff128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim
){+.+.}-{0:0}
, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
, at: __alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32159:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32160:
 #0:
ffffffff8bc53fd0
 (
dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap kernel/fork.c:497 [inline]
dup_mmap_sem){.+.+}-{0:0}, at: dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804fc47828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804fc47828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804fc47828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a6c01628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a6c01628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a6c01628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32161:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32162:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88802f949d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88802f949d28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88802f949d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880a9de8828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880a9de8828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880a9de8828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32163:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804fc41d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804fc41d28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804fc41d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b5f52b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b5f52b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b5f52b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32164:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88804fc44e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88804fc44e28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88804fc44e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808065f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808065f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808065f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/32165:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/32167:




Best Regards,
Yiru
