Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7C484078
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiADLGK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 06:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiADLGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 06:06:10 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E389C061761;
        Tue,  4 Jan 2022 03:06:10 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 139so75441131ybd.3;
        Tue, 04 Jan 2022 03:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KozbebP/32TN4Gps4Oh4o45q8IhE6wKdHWvJL9OAaRs=;
        b=Jp+cONZgtBq40rr0BM1wQxhETB7qlq0fS0y21goDlyPeWVa4ObXFU1k6/r3xyb91O/
         QVKDMXoabo8LY9069VB6HTjsYd/LtM0ttjEUrwkHKKjttHYIWSc3srWsQ7p6vRNpiM6U
         MlnxxcJ0HHAa0yYwBdjT9iWX1L2ImC7SmlxCGgqr7DMqd8n2IM/+0+RbXAv9l6T1xWkM
         19CgQojOyk3fFwpj/j1Ip7U0Yt+NTbHcjixW+E4RYEWuIXt9KAl9wL4TIAHxJrQCDaWi
         an2n4jHjOmJ9rEZDM+W9mEMCkcdOFreRO+hwFKkpfG1pF9lwFNBUGzwA04f6iLO/uVOW
         r6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KozbebP/32TN4Gps4Oh4o45q8IhE6wKdHWvJL9OAaRs=;
        b=lPglOrjWvUA1kZfEk+xQSjjTXdPQ53vE1Q5iPaB+NRE9xsOa4GgzUpNwgFttAKp1Gk
         ToFLhzobxxaA81p4IZkqlllXOIasDH2H2j9VQuZLVoDaXslCrTx8qd/ko78R9DNuVf/H
         iiS+8uqmyQY1xwYkTg9K+9o5QC0WWvOr63lvg61PYY6ye9CkuD/Ia7hFJ6IVJEGheOFW
         naMrxSjz6AmCIUL08YNrG5dJOE1lZ4xddJyf1WAmsiQ/cElgXYh8V8o9PbghjuCMs2xa
         G9Hq5blSyeikA2gvrrLo706rZOmNUJetJRTz/inRG6L0PVWTl0IKOiOPG1VTXvlCrBgN
         tiIw==
X-Gm-Message-State: AOAM532IuEyLJKbSsN4lUZ8VBwhLwyX7KfzAmV+j8nvAlYPJAehS7Gxt
        QwiR36caFMlSFuGKwj1lYQea51fxs75AOMoQyXwCkS/vBpyxxS5u
X-Google-Smtp-Source: ABdhPJyBBZVku6YJ3bHewhn90KfqUYc1rYq+Fzo4PP4jGidyRBc5AYSPK0PDgGTUzxeXjZskNIV0qIc5144fxgX59ro=
X-Received: by 2002:a25:aa63:: with SMTP id s90mr44810922ybi.54.1641294369022;
 Tue, 04 Jan 2022 03:06:09 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:05:57 +0800
Message-ID: <CAFkrUsgXvWGHXr7umCA4Y9+jcdtLF4s=svvDnXcmHs4TNWpLWw@mail.gmail.com>
Subject: INFO: task hung in ext4_orphan_add
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
console output: https://paste.ubuntu.com/p/gZnFsyxgvf/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: task syz-executor.6:943 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.6  state:D stack:23248 pid:  943 ppid:   759 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 ext4_orphan_add+0x897/0x13d0 fs/ext4/orphan.c:148
 __ext4_unlink+0x661/0x920 fs/ext4/namei.c:3195
 ext4_unlink+0x346/0x9e0 fs/ext4/namei.c:3231
 vfs_unlink+0x33a/0x770 fs/namei.c:4100
 do_unlinkat+0x3d2/0x660 fs/namei.c:4167
 __do_sys_unlink fs/namei.c:4215 [inline]
 __se_sys_unlink fs/namei.c:4213 [inline]
 __x64_sys_unlink+0x3e/0x50 fs/namei.c:4213
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fca6fc5718b
RSP: 002b:00007ffe82bb2c28 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fca6fc5718b
RDX: 00007ffe82bb2c60 RSI: 00007ffe82bb2c60 RDI: 00007ffe82bb2cf0
RBP: 00007ffe82bb2cf0 R08: 0000000000000001 R09: 00007ffe82bb2ab0
R10: 00000000fffffff6 R11: 0000000000000206 R12: 00007fca6fcc30b1
R13: 00007ffe82bb3d90 R14: 0000555555764d50 R15: 00007ffe82bb3dd0
 </TASK>

Showing all locks held in the system:
2 locks held by systemd/1:
 #0: ffff888018dfe940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888018dfe940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by oom_reaper/40:
1 lock held by systemd-journal/3049:
2 locks held by systemd-udevd/3063:
 #0: ffff88810d811980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810d811980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by systemd-timesyn/3127:
 #0: ffff888018da1980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888018da1980 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by cron/6310:
 #0: ffff888018dfe940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888018dfe940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by in:imklog/6796:
 #0:
ffff88801742b7f0
 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffffffff8bca5140 (
fs_reclaim
){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x760/0x21b0
mm/page_alloc.c:5007
4 locks held by rs:main Q:Reg/6797:
 #0:
ffff888017428370
 (
&f->f_pos_lock){+.+.}-{3:3}
, at: __fdget_pos+0xe9/0x100 fs/file.c:1034
 #1: ffff88801f98a460
 (
sb_writers#5
){.+.+}-{0:0}
, at: ksys_write+0x12d/0x250 fs/read_write.c:643
 #2: ffff888028c75da8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff888028c75da8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
ext4_buffered_write_iter+0xb8/0x360 fs/ext4/file.c:263
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6732:
 #0: ffff888111dfd550
 (mapping.invalidate_lock
){++++}-{3:3}
, at: filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
, at: filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1:
ffffffff8bca5140
 (
fs_reclaim
){+.+.}-{0:0}
, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
, at: __alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6749:
 #0: ffff888111dfd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888111dfd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6813:
 #0: ffff888111dfd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888111dfd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
3 locks held by kworker/u8:5/11394:
2 locks held by kworker/u9:17/13528:
4 locks held by syz-executor.5/30456:
 #0: ffff88801f98a460
 (sb_writers
#5
){.+.+}-{0:0}, at: do_unlinkat+0x17f/0x660 fs/namei.c:4146
 #1: ffff88801f98a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x5a0
fs/inode.c:590
 #2: ffff88801f98e990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #3: ffff88801f98c3f0 (&sbi->s_orphan_lock){+.+.}-{3:3}, at:
ext4_orphan_del+0x20e/0xfc0 fs/ext4/orphan.c:253
2 locks held by syz-executor.4/30457:
 #0: ffff88808e054028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff88808e054028 (&mm->mmap_lock#2){++++}-{3:3}, at:
do_user_addr_fault+0x285/0x11c0 arch/x86/mm/fault.c:1338
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-executor.1/30459:
4 locks held by syz-executor.0/30460:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888045428f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888045428f28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888045428f28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888050b57128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888050b57128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888050b57128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.3/30461:
 #0: ffff888113215da8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
iterate_dir+0xcd/0x700 fs/readdir.c:55
2 locks held by syz-executor.2/30462:
 #0: ffff88804542c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff88804542c728 (&mm->mmap_lock#2){++++}-{3:3}, at:
do_user_addr_fault+0x285/0x11c0 arch/x86/mm/fault.c:1338
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
5 locks held by syz-executor.6/943:
 #0: ffff88801f98a460 (sb_writers#5){.+.+}-{0:0}, at:
do_unlinkat+0x17f/0x660 fs/namei.c:4146
 #1: ffff88804a5697e0 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88804a5697e0 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
do_unlinkat+0x269/0x660 fs/namei.c:4150
 #2: ffff888113210de8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff888113210de8 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at:
vfs_unlink+0xd0/0x770 fs/namei.c:4089
 #3: ffff88801f98e990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #4: ffff88801f98c3f0 (&sbi->s_orphan_lock){+.+.}-{3:3}, at:
ext4_orphan_add+0x897/0x13d0 fs/ext4/orphan.c:148
4 locks held by syz-executor.7/2091:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88808e053928 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88808e053928 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88808e053928 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880506e1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880506e1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880506e1628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by kworker/3:38/2163:
4 locks held by syz-executor.5/23888:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88803a964e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88803a964e28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88803a964e28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b67f9628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b67f9628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b67f9628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140
 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim
mm/page_alloc.c:4609 [inline]
 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23890:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cb8828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cb8828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cb8828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b68e4728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b68e4728 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b68e4728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23891:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88803a961d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88803a961d28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88803a961d28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888089f72b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888089f72b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888089f72b28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23900:
4 locks held by syz-executor.5/23901:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbce28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbce28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbce28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888050659628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888050659628 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888050659628 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23902:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88803a964728 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88803a964728 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88803a964728 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888047b76a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888047b76a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888047b76a28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23903:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880494a2b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880494a2b28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880494a2b28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880af838f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880af838f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880af838f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23904:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbe328 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbe328 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbe328 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880999d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880999d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880999d5c28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23906:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880494a7828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880494a7828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880494a7828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b9a08128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b9a08128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b9a08128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23907:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff8880494a4028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880494a4028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff8880494a4028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880412a6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880412a6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880412a6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23908:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88803a966328 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88803a966328 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88803a966328 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b50c6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b50c6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b50c6328 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23909:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbdc28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbdc28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbdc28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b727c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b727c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b727c728 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23910:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888133e3b228 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888133e3b228 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888133e3b228 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888089ab7828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888089ab7828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888089ab7828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23911:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbf828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbf828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbf828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880af4d8128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880af4d8128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880af4d8128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3:
ffffffff8bca5140
 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim
mm/page_alloc.c:4609 [inline]
 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23912:
4 locks held by syz-executor.5/23913:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbea28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbea28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2:
ffff888044b1f128 (
&mm->mmap_lock
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
4 locks held by syz-executor.5/23914:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888133e3c028 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888133e3c028 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888133e3c028 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff88808d7d8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88808d7d8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff88808d7d8f28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23917:
4 locks held by syz-executor.5/23918:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888133e3b928 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888133e3b928 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888133e3b928 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b7248828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b7248828 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b7248828 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23919:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888133e3ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888133e3ab28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888133e3ab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880b1c3ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880b1c3ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880b1c3ce28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23920:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cba428 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cba428 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cba428 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880877ea428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880877ea428 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880877ea428 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23921:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff888013cbab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888013cbab28 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff888013cbab28 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff8880add5f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880add5f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff8880add5f128 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23922:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450
 #1: ffff88803a960828 (&mm->mmap_lock#2){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff88803a960828 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap
kernel/fork.c:498 [inline]
 #1: ffff88803a960828 (&mm->mmap_lock#2){++++}-{3:3}, at:
dup_mm+0x12e/0x13d0 kernel/fork.c:1450
 #2: ffff888040cece28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff888040cece28 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
kernel/fork.c:507 [inline]
 #2: ffff888040cece28 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
dup_mm+0x18a/0x13d0 kernel/fork.c:1450
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #3: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/23923:
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
kernel/fork.c:497 [inline]
 #0: ffffffff8bc53fd0 (dup_mmap_sem){.+.+}-{0:0}, at:
dup_mm+0x108/0x13d0 kernel/fork.c:1450



Best Regards,
Yiru
