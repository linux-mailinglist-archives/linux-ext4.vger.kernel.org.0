Return-Path: <linux-ext4+bounces-9891-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EAB509F9
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 02:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5D81C63878
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D61C3306;
	Wed, 10 Sep 2025 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uI2uPQAR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3233D8
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465375; cv=none; b=T+Whxb58AUtGLVrNzCI+SIqb6o4+PU6kFk/3BfrJBPPmOFoYrBv5Yf5hf0SXqxKjGP7MirOk6Srv2ZgIbv/cJ2dc4DrhWJg7nY4YSfjfK04BxHG054VGod6iRci0tBsRm1hoqSfV2Y2ndP44RpwLjKaoXXnel+nyefwDr8AMddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465375; c=relaxed/simple;
	bh=5SL40KduHAJpf9Tjv3qu4l8+8RlFpeMswOkp8GoUbEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG4A7NKOPO1/kQRGvfz6sOR1lVqSLQNv0/VLeMrjdSrIjsCSLYcrAi3iJG5p1f3nj/MDjAcdHRyRlWyorAM11tkpuy7Jm+G+i+IenDdsfzVyQ98fJefcF72akWpmXk3ykarH0GIFBWchDemOH33mzMV5kqMwdKA3RSq/ok3QRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uI2uPQAR; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757465370;
	bh=w4rqxKQL3OZE/dMDIbMLaOX0nbryhWYmf1E2kBnLbFc=;
	h=From:Subject:Date:Message-ID;
	b=uI2uPQAR3fb7cBtYOCASc1oq3r0+GpZK2qf+AtJ37dhvhIyTWSbY3ujMdyTHtT2IW
	 TRzjrP7nudthD0yPuKQhsB4deo1upRVGbyTALF7w6FYsG9M0tXos+3BQ/bdW5ouyW0
	 aKixE/3OyG+RP1bGTsReAY+1TpNYnNtw/3THVe54=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68C0CA86000072E4; Wed, 10 Sep 2025 08:47:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6979146291953
X-SMAIL-UIID: 3EDCEFE7D47643C5AF7FBFB4B7338F64-20250910-084703-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_writepages (2)
Date: Wed, 10 Sep 2025 08:46:53 +0800
Message-ID: <20250910004654.6703-1-hdanton@sina.com>
In-Reply-To: <68c0b81e.050a0220.3c6139.0015.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Tue, 09 Sep 2025 16:28:30 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f94b12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e4d62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160f6d62580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/63dc392685dc/disk-9dd1835e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3dfcfb97806e/vmlinux-9dd1835e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ddb10128aeb8/bzImage-9dd1835e.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/0b26d5f09478/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14aab562580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 512
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.0.17/6097 is trying to acquire lock:
> ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
> ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
> ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
> 
> but task is already holding lock:
> ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
> ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
> ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x3eb/0x700 fs/ext4/inode.c:6506
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&ei->xattr_sem){++++}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
>        ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
>        ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2362
>        ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
>        security_inode_init_security+0x29d/0x3f0 security/security.c:1852
>        __ext4_new_inode+0x3314/0x3cb0 fs/ext4/ialloc.c:1325

If new inode can not be orphan, this report is false positive.

>        ext4_create+0x22d/0x460 fs/ext4/namei.c:2822
>        lookup_open fs/namei.c:3708 [inline]
>        open_last_lookups fs/namei.c:3807 [inline]
>        path_openat+0x14fd/0x3840 fs/namei.c:4043
>        do_filp_open+0x1fa/0x410 fs/namei.c:4073
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (jbd2_handle){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        start_this_handle+0x1fa7/0x21c0 fs/jbd2/transaction.c:444
>        jbd2__journal_start+0x2c1/0x5b0 fs/jbd2/transaction.c:501
>        __ext4_journal_start_sb+0x227/0x5c0 fs/ext4/ext4_jbd2.c:115
>        __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
>        ext4_do_writepages+0xf6f/0x4600 fs/ext4/inode.c:2913
>        ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
>        do_writepages+0x32b/0x550 mm/page-writeback.c:2634
>        __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
>        writeback_sb_inodes+0x6b7/0xf60 fs/fs-writeback.c:1976
>        __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
>        wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
>        wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
>        wb_do_writeback fs/fs-writeback.c:2315 [inline]
>        wb_workfn+0xaf4/0xf00 fs/fs-writeback.c:2343
>        process_one_work kernel/workqueue.c:3236 [inline]
>        process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
>        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>        kthread+0x70e/0x8a0 kernel/kthread.c:463
>        ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
>        percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
>        ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
>        ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
>        do_writepages+0x32b/0x550 mm/page-writeback.c:2634
>        __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
>        writeback_single_inode+0x1d5/0x640 fs/fs-writeback.c:1801
>        write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2864
>        iput_final fs/inode.c:1884 [inline]
>        iput+0x5b9/0x9d0 fs/inode.c:1923
>        ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2194
>        ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
>        ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
>        ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
>        __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
>        ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
>        __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
>        ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
>        evict+0x504/0x9c0 fs/inode.c:810
>        ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
>        __ext4_fill_super fs/ext4/super.c:5609 [inline]
>        ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
>        get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>        vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
>        do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
>        do_mount fs/namespace.c:4136 [inline]
>        __do_sys_mount fs/namespace.c:4347 [inline]
>        __se_sys_mount+0x317/0x410 fs/namespace.c:4324
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &sbi->s_writepages_rwsem --> jbd2_handle --> &ei->xattr_sem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&ei->xattr_sem);
>                                lock(jbd2_handle);
>                                lock(&ei->xattr_sem);
>   rlock(&sbi->s_writepages_rwsem);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz.0.17/6097:
>  #0: ffff88803dfbc0d0 (&type->s_umount_key#26/1){+.+.}-{4:4}, at: alloc_super+0x204/0x990 fs/super.c:345
>  #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
>  #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1799 [inline]
>  #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1982 [inline]
>  #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215
>  #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
>  #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
>  #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x3eb/0x700 fs/ext4/inode.c:6506
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
>  percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
>  ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
>  ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
>  do_writepages+0x32b/0x550 mm/page-writeback.c:2634
>  __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
>  writeback_single_inode+0x1d5/0x640 fs/fs-writeback.c:1801
>  write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2864
>  iput_final fs/inode.c:1884 [inline]
>  iput+0x5b9/0x9d0 fs/inode.c:1923
>  ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2194
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
>  ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
>  __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
>  __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
>  ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
>  evict+0x504/0x9c0 fs/inode.c:810
>  ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5609 [inline]
>  ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4324
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fefaad0038a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdb287c378 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffdb287c400 RCX: 00007fefaad0038a
> RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffdb287c3c0
> RBP: 0000200000000180 R08: 00007ffdb287c400 R09: 0000000000800700
> R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
> R13: 00007ffdb287c3c0 R14: 0000000000000473 R15: 0000200000000680
>  </TASK>
> ------------[ cut here ]------------
> EA inode 11 i_nlink=2
> WARNING: CPU: 1 PID: 6097 at fs/ext4/xattr.c:1053 ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
> Modules linked in:
> CPU: 1 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
> Code: 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84 c0 0f 85 86 00 00 00 41 8b 14 24 48 c7 c7 60 6d 1f 8b 4c 89 fe e8 1d 9a 07 ff 90 <0f> 0b 90 90 48 bb 00 00 00 00 00 fc ff df e9 bb fd ff ff e8 a4 2b
> RSP: 0018:ffffc900041bf1a0 EFLAGS: 00010246
> RAX: 3b7a600244a15000 RBX: dffffc0000000000 RCX: ffff88803cfa3b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc900041bf298 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed1017124863 R12: ffff888049711b30
> R13: 1ffff110092e2366 R14: 00000000ffffffff R15: 000000000000000b
> FS:  000055556e3f9500(0000) GS:ffff8881269bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f24cdec2e9c CR3: 000000002c16a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
>  ext4_xattr_set_entry+0xabb/0x1e20 fs/ext4/xattr.c:1714
>  ext4_xattr_ibody_set+0x254/0x6a0 fs/ext4/xattr.c:2263
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2666 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
>  ext4_expand_extra_isize_ea+0x13a8/0x1ea0 fs/ext4/xattr.c:2822
>  __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
>  __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
>  ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
>  evict+0x504/0x9c0 fs/inode.c:810
>  ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5609 [inline]
>  ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4324
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fefaad0038a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdb287c378 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffdb287c400 RCX: 00007fefaad0038a
> RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffdb287c3c0
> RBP: 0000200000000180 R08: 00007ffdb287c400 R09: 0000000000800700
> R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
> R13: 00007ffdb287c3c0 R14: 0000000000000473 R15: 0000200000000680
>  </TASK>

