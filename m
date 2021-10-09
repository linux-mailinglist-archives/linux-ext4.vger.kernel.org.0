Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD842755B
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Oct 2021 03:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhJIBR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Oct 2021 21:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhJIBR6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Oct 2021 21:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DA9EE60F94
        for <linux-ext4@vger.kernel.org>; Sat,  9 Oct 2021 01:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633742162;
        bh=GcM2nZY5rHO9ZqSN7et48eCP6mmBNBdU2pEiuTxc3dg=;
        h=From:To:Subject:Date:From;
        b=N3bJdk8Q55dcwP4Rq8f1VqrlatLgClfqBLsPcDo0eJUyElKY7CNesw7jVoMlpwVJW
         qe6PxGHI2L4ROinOTOzbZ0cin0O+T/kR/9hy2KOxidBogisLfOu2UASOVhbz30Bnnt
         9hYrZ1/x1YPD3XjJ98m3s7ThV+ZrzjT91bEnzSPjVG6u3iE5j85O83OA/zGjaxiD7m
         mJspMB3+5T766V6h3uvtX6/0pJpJWKUdfNHkSOc8DaaOtekgZ8UVfh+a2OUgOCv1id
         I/qxwOZYaq4F4/Vv3whSE28yG/gLxxcvCu3MwvQOoyk0eENY2E7OBlSAFheZyhMopW
         MGWxCEFmQi+EA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D757060FA0; Sat,  9 Oct 2021 01:16:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214655] New: BUG: unable to handle kernel paging request in
 __dquot_free_space
Date:   Sat, 09 Oct 2021 01:16:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 6201613047@stu.jiangnan.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214655-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214655

            Bug ID: 214655
           Summary: BUG: unable to handle kernel paging request in
                    __dquot_free_space
           Product: File System
           Version: 2.5
    Kernel Version: 5.15-rc-ksmbd-part2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: 6201613047@stu.jiangnan.edu.cn
        Regression: No

Created attachment 299143
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299143&action=3Dedit
poc

Find it by something like Syzkaller and I think this is a BUG.
And POC is attached here.
Looking forward to your reply.

-----------------------------------
EXT4-fs error (device loop0): ext4_empty_dir:3011: inode #12: block 80: comm
syz-executor.0: bad entry in directory: rec_len is smaller than minimal -
offset=3D0, inode=3D0, rec_len=3D0, size=3D4096 fake=3D0
EXT4-fs warning (device loop0): ext4_empty_dir:3013: inode #12: comm
syz-executor.0: directory missing '.'
BUG: unable to handle page fault for address: fffffbfff6b3012c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9fffeb067 P4D 9fffeb067 PUD 9ffe0f067 PMD 0=20
Oops: 0000 [#1] SMP KASAN PTI
CPU: 3 PID: 26685 Comm: syz-executor.0 Not tainted 5.14.0+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x13d/0x200 mm/kasan/generic.c:189
Code: 83 c0 01 48 89 d8 49 39 d8 74 0f 41 80 38 00 74 ee 4b 8d 04 0c 4d 85 =
c0
75 4b 48 89 eb 48 29 c3 e9 42 ff ff ff 48 85 db 74 2e <41> 80 39 00 75 32 4=
8 b8
01 00 00 00 00 fc ff df 49 01 d9 49 01 c0
RSP: 0018:ffff88812dd8f4c8 EFLAGS: 00010202
RAX: fffffbfff6b3012c RBX: 0000000000000002 RCX: ffffffffb2e0a1f6
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffb5980967
RBP: fffffbfff6b3012e R08: 1ffffffff6b3012c R09: fffffbfff6b3012c
R10: ffffffffb598096a R11: fffffbfff6b3012d R12: ffff88812dd8f5d8
R13: ffff8881ac734b28 R14: 0000000000010000 R15: ffffffffb5980907
FS:  00007f0f2b188700(0000) GS:ffff8889d7380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff6b3012c CR3: 0000000156d9a001 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:511
[inline]
 queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
 do_raw_spin_lock include/linux/spinlock.h:187 [inline]
 __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_lock+0x66/0xd0 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:363 [inline]
 __dquot_free_space+0x211/0x7c0 fs/quota/dquot.c:1874
 dquot_free_space_nodirty include/linux/quotaops.h:376 [inline]
 dquot_free_space include/linux/quotaops.h:381 [inline]
 dquot_free_block include/linux/quotaops.h:392 [inline]
 ext4_free_blocks+0x1430/0x1940 fs/ext4/mballoc.c:6084
 ext4_remove_blocks fs/ext4/extents.c:2488 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2672 [inline]
 ext4_ext_remove_space+0x299c/0x3590 fs/ext4/extents.c:2920
 ext4_ext_truncate+0x195/0x200 fs/ext4/extents.c:4382
 ext4_truncate+0xa2b/0xe80 fs/ext4/inode.c:4268
 ext4_evict_inode+0x8af/0x13c0 fs/ext4/inode.c:287
 evict+0x2d3/0x5b0 fs/inode.c:586
 iput_final fs/inode.c:1662 [inline]
 iput fs/inode.c:1688 [inline]
 iput+0x4ba/0x710 fs/inode.c:1674
 dentry_unlink_inode+0x314/0x4d0 fs/dcache.c:376
 d_delete fs/dcache.c:2505 [inline]
 d_delete+0x152/0x1a0 fs/dcache.c:2494
 vfs_rmdir fs/namei.c:3984 [inline]
 vfs_rmdir+0x438/0x570 fs/namei.c:3948
 do_rmdir+0x1c2/0x3a0 fs/namei.c:4032
 __do_sys_unlinkat fs/namei.c:4211 [inline]
 __se_sys_unlinkat fs/namei.c:4205 [inline]
 __x64_sys_unlinkat+0xcc/0x100 fs/namei.c:4205
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4698d9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 7=
3 01
c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f2b187c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004698d9
RDX: 0000000000000200 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00000000004d26c2 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077bf80
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffdbd022e40
Modules linked in:
CR2: fffffbfff6b3012c
---[ end trace 337a23afd90599f5 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x13d/0x200 mm/kasan/generic.c:189
Code: 83 c0 01 48 89 d8 49 39 d8 74 0f 41 80 38 00 74 ee 4b 8d 04 0c 4d 85 =
c0
75 4b 48 89 eb 48 29 c3 e9 42 ff ff ff 48 85 db 74 2e <41> 80 39 00 75 32 4=
8 b8
01 00 00 00 00 fc ff df 49 01 d9 49 01 c0
RSP: 0018:ffff88812dd8f4c8 EFLAGS: 00010202
RAX: fffffbfff6b3012c RBX: 0000000000000002 RCX: ffffffffb2e0a1f6
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffb5980967
RBP: fffffbfff6b3012e R08: 1ffffffff6b3012c R09: fffffbfff6b3012c
R10: ffffffffb598096a R11: fffffbfff6b3012d R12: ffff88812dd8f5d8
R13: ffff8881ac734b28 R14: 0000000000010000 R15: ffffffffb5980907
FS:  00007f0f2b188700(0000) GS:ffff8889d7380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff6b3012c CR3: 0000000156d9a001 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
netlink: 72 bytes leftover after parsing attributes in process
`syz-executor.7'.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in owner_on_cpu kernel/locking/rwsem.c:605 [inli=
ne]
BUG: KASAN: use-after-free in rwsem_can_spin_on_owner
kernel/locking/rwsem.c:626 [inline]
BUG: KASAN: use-after-free in rwsem_down_write_slowpath+0xade/0xfe0
kernel/locking/rwsem.c:1026
Read of size 4 at addr ffff88812eaf4534 by task syz-executor.0/26792

CPU: 3 PID: 26792 Comm: syz-executor.0 Tainted: G      D           5.14.0+ =
#3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x4c/0x64 lib/dump_stack.c:106
 print_address_description.constprop.9+0x21/0x150 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold.14+0x7f/0x11b mm/kasan/report.c:459
 owner_on_cpu kernel/locking/rwsem.c:605 [inline]
 rwsem_can_spin_on_owner kernel/locking/rwsem.c:626 [inline]
 rwsem_down_write_slowpath+0xade/0xfe0 kernel/locking/rwsem.c:1026
 __down_write_common kernel/locking/rwsem.c:1262 [inline]
 __down_write_common kernel/locking/rwsem.c:1259 [inline]
 __down_write kernel/locking/rwsem.c:1271 [inline]
 down_write+0xd2/0x120 kernel/locking/rwsem.c:1516
 inode_lock include/linux/fs.h:786 [inline]
 chown_common+0x1ea/0x400 fs/open.c:675
 do_fchownat+0xef/0x180 fs/open.c:709
 __do_sys_lchown fs/open.c:734 [inline]
 __se_sys_lchown fs/open.c:732 [inline]
 __x64_sys_lchown+0x7a/0xc0 fs/open.c:732
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4698d9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 7=
3 01
c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f2b166c48 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 000000000077c038 RCX: 00000000004698d9
RDX: 0000000000000000 RSI: 000000000000ee00 RDI: 00000000200002c0
RBP: 00000000004d26c2 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077c038
R13: 0000000000000000 R14: 000000000077c038 R15: 00007ffdbd022e40
netlink: 72 bytes leftover after parsing attributes in process
`syz-executor.7'.

Allocated by task 26666:
 kasan_save_stack+0x19/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x68/0x80 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 kmem_cache_alloc_node+0xd2/0x200 mm/slub.c:3242
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct kernel/fork.c:883 [inline]
 copy_process+0x1717/0x67c0 kernel/fork.c:2026
 kernel_clone+0xbd/0x970 kernel/fork.c:2584
 __do_sys_clone+0xde/0x120 kernel/fork.c:2701
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 26778:
 kasan_save_stack+0x19/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xe2/0x110 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook mm/slub.c:1725 [inline]
 slab_free mm/slub.c:3483 [inline]
 kmem_cache_free+0x74/0x280 mm/slub.c:3499
 __put_task_struct+0x22a/0x4f0 kernel/fork.c:760
 put_task_struct include/linux/sched/task.h:113 [inline]
 delayed_put_task_struct+0x11d/0x160 kernel/exit.c:173
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x555/0x14b0 kernel/rcu/tree.c:2743
 __do_softirq+0x17f/0x53f kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x19/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa3/0xb0 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0x77/0x8f0 kernel/rcu/tree.c:3067
 put_task_struct_rcu_user+0x61/0x90 kernel/exit.c:179
 finish_task_switch+0x48e/0x670 kernel/sched/core.c:4854
 schedule_tail+0x7/0xa0 kernel/sched/core.c:4876
 ret_from_fork+0x8/0x30 arch/x86/entry/entry_64.S:280

Second to last potentially related work creation:
 kasan_save_stack+0x19/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa3/0xb0 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0x77/0x8f0 kernel/rcu/tree.c:3067
 put_task_struct_rcu_user+0x61/0x90 kernel/exit.c:179
 finish_task_switch+0x48e/0x670 kernel/sched/core.c:4854
 context_switch kernel/sched/core.c:4943 [inline]
 __schedule+0x882/0x1710 kernel/sched/core.c:6287
 schedule+0xbd/0x250 kernel/sched/core.c:6366
 freezable_schedule include/linux/freezer.h:172 [inline]
 futex_wait_queue_me+0x24b/0x430 kernel/futex.c:2821
 futex_wait+0x1cb/0x620 kernel/futex.c:2922
 do_futex+0x337/0x17e0 kernel/futex.c:3932
 __do_sys_futex kernel/futex.c:4009 [inline]
 __se_sys_futex kernel/futex.c:3990 [inline]
 __x64_sys_futex+0x189/0x400 kernel/futex.c:3990
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88812eaf4500
 which belongs to the cache task_struct of size 5576
The buggy address is located 52 bytes inside of
 5576-byte region [ffff88812eaf4500, ffff88812eaf5ac8)
The buggy address belongs to the page:
page:0000000082bf4bc1 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0
pfn:0x12eaf0
head:0000000082bf4bc1 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=3D0|zone=3D2)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff888100178b40
raw: 0000000000000000 0000000000050005 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88812eaf4400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812eaf4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88812eaf4500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88812eaf4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88812eaf4600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
----------------
Code disassembly (best guess):
   0:   83 c0 01                add    $0x1,%eax
   3:   48 89 d8                mov    %rbx,%rax
   6:   49 39 d8                cmp    %rbx,%r8
   9:   74 0f                   je     0x1a
   b:   41 80 38 00             cmpb   $0x0,(%r8)
   f:   74 ee                   je     0xffffffff
  11:   4b 8d 04 0c             lea    (%r12,%r9,1),%rax
  15:   4d 85 c0                test   %r8,%r8
  18:   75 4b                   jne    0x65
  1a:   48 89 eb                mov    %rbp,%rbx
  1d:   48 29 c3                sub    %rax,%rbx
  20:   e9 42 ff ff ff          jmpq   0xffffff67
  25:   48 85 db                test   %rbx,%rbx
  28:   74 2e                   je     0x58
* 2a:   41 80 39 00             cmpb   $0x0,(%r9) <-- trapping instruction
  2e:   75 32                   jne    0x62
  30:   48 b8 01 00 00 00 00    movabs $0xdffffc0000000001,%rax
  37:   fc ff df
  3a:   49 01 d9                add    %rbx,%r9
  3d:   49 01 c0                add    %rax,%r8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
