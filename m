Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1813AEC22
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jun 2021 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFUPSt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Jun 2021 11:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhFUPSs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 21 Jun 2021 11:18:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 891B46113E
        for <linux-ext4@vger.kernel.org>; Mon, 21 Jun 2021 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624288594;
        bh=rHz8hGGIJnQjRXpETrLi0dQp4giwPrpvglSwymRoMLg=;
        h=From:To:Subject:Date:From;
        b=ZVJE1El2t2uMgxQjTJBiIQDTqixfTCSRTk2oVKJEJetEIcGGFdAquC7DM8b0RhC34
         jcmdVbD+npC1q9uE4fVJidX1PuEFYRAuyW/niTCGGu9ZKDVy1dWAypfd9QlAjw/dlC
         pzPwOpq8O/WZLYG6zh4IRrK+h5PAeIadLvs50zCkwhJFQ+LQCDyCS7G1o697BbMPq3
         +9U6zBOPLeQnRxPhwz2/utLLmqzJz0UsT12l5pXETuh9dRccD1KaTP9S944wT+bSWH
         X7aWjZLLtY4kj1b/htGJVzSy3OU21Kwi7kFsiFSF7NJ+IyC/ZyLUNFts9d/HyStaNE
         ljP3SfXah+TAQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7DF7161264; Mon, 21 Jun 2021 15:16:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213539] New: KASAN: use-after-free Write in ext4_put_super
Date:   Mon, 21 Jun 2021 15:16:34 +0000
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
Message-ID: <bug-213539-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213539

            Bug ID: 213539
           Summary: KASAN: use-after-free Write in ext4_put_super
           Product: File System
           Version: 2.5
    Kernel Version: 5.13-rc4
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: 6201613047@stu.jiangnan.edu.cn
        Regression: No

Created attachment 297549
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297549&action=3Dedit
log0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in kthread_stop+0x33/0x370
Write of size 4 at addr ffff8880308eade8 by task syz-executor.3/402

EXT4-fs (loop7): mount failed
CPU: 0 PID: 402 Comm: syz-executor.3 Not tainted 5.13.0-rc3+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
Call Trace:
 dump_stack+0xaf/0xf2
 print_address_description.constprop.8+0x1a/0x150
 kasan_report.cold.13+0x7f/0x111
 kasan_check_range+0x198/0x200
 kthread_stop+0x33/0x370
 ext4_put_super+0x7a4/0xce0
 generic_shutdown_super+0x14a/0x370
 kill_block_super+0x94/0xe0
 deactivate_locked_super+0x7f/0xe0
 deactivate_super+0xb2/0xc0
 cleanup_mnt+0x2ec/0x450
 task_work_run+0x101/0x1a0
 exit_to_user_mode_prepare+0x132/0x140
 syscall_exit_to_user_mode+0x12/0x20
 do_syscall_64+0x48/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46b1b7
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8 64 89 =
01
48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 7=
3 01
c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5db62af8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046b1b7
RDX: 0000000000404502 RSI: 0000000000000002 RDI: 00007ffd5db62bc0
RBP: 00007ffd5db62bc0 R08: 00000000032b0083 R09: 000000000000000b
R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004d17aa
R13: 00007ffd5db63c70 R14: 0000000000000004 R15: 0000000000000032

Allocated by task 2:
 kasan_save_stack+0x19/0x40
 __kasan_slab_alloc+0x68/0x80
 kmem_cache_alloc_node+0xd3/0x200
 copy_process+0x174e/0x66e0
 kernel_clone+0xbd/0x950
 kernel_thread+0xa7/0xe0
 kthreadd+0x3c8/0x520
 ret_from_fork+0x22/0x30

Freed by task 12813:
 kasan_save_stack+0x19/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0xe2/0x110
 kmem_cache_free+0x77/0x280
 __put_task_struct+0x22a/0x4f0
 delayed_put_task_struct+0x120/0x160
 rcu_core+0x555/0x14e0
 __do_softirq+0x17f/0x578

Last potentially related work creation:
 kasan_save_stack+0x19/0x40
 kasan_record_aux_stack+0xa3/0xb0
 call_rcu+0x76/0xac0
 put_task_struct_rcu_user+0x61/0x90
 finish_task_switch+0x48a/0x670
 __schedule+0x873/0x18f0
 preempt_schedule_common+0x16/0x50
 __cond_resched+0x18/0x20
 write_mmp_block+0x308/0x580
 kmmpd+0x3e5/0x990
 kthread+0x32a/0x3f0
 ret_from_fork+0x22/0x30

Second to last potentially related work creation:
 kasan_save_stack+0x19/0x40
 kasan_record_aux_stack+0xa3/0xb0
 call_rcu+0x76/0xac0
 put_task_struct_rcu_user+0x61/0x90
 finish_task_switch+0x48a/0x670
 __schedule+0x873/0x18f0
 schedule+0xb8/0x250
 exit_to_user_mode_prepare+0x97/0x140
 irqentry_exit_to_user_mode+0x5/0x20
 asm_sysvec_apic_timer_interrupt+0x12/0x20

The buggy address belongs to the object at ffff8880308eadc0
 which belongs to the cache task_struct of size 3776
The buggy address is located 40 bytes inside of
 3776-byte region [ffff8880308eadc0, ffff8880308ebc80)
The buggy address belongs to the page:
page:00000000af281d24 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff8880308e8f40 pfn:0x308e8
head:00000000af281d24 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
raw: 0100000000010200 0000000000000000 0000000100000001 ffff88800112cdc0
raw: ffff8880308e8f40 0000000080080006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880308eac80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880308ead00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880308ead80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff8880308eae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880308eae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 402 at lib/refcount.c:25
refcount_warn_saturate+0x130/0x1a0
Modules linked in:
CPU: 0 PID: 402 Comm: syz-executor.3 Tainted: G    B             5.13.0-rc3=
+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
RIP: 0010:refcount_warn_saturate+0x130/0x1a0
Code: e8 35 1e 66 ff 80 3d b9 2e de 02 00 0f 85 59 ff ff ff e8 23 1e 66 ff =
48
c7 c7 40 41 36 ba c6 05 a0 2e de 02 01 e8 e9 5b 98 01 <0f> 0b e9 3a ff ff f=
f e8
04 1e 66 ff 80 3d 8a 2e de 02 00 0f 85 28
RSP: 0018:ffff88802ea0fd70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffffb784f048
RDX: ffff888003215b80 RSI: 0000000000000000 RDI: ffff88806d22622c
RBP: ffff8880308eade8 R08: ffffed100da45cbb R09: ffffed100da45cbb
R10: ffff88806d22e5d7 R11: ffffed100da45cba R12: ffff8880308eade8
R13: 0000000000000000 R14: ffff888001c7e270 R15: dffffc0000000000
FS:  00000000032ae940(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000032b0000 CR3: 000000002e9f6001 CR4: 0000000000370ef0
Call Trace:
 kthread_stop+0x320/0x370
 ext4_put_super+0x7a4/0xce0
 generic_shutdown_super+0x14a/0x370
 kill_block_super+0x94/0xe0
 deactivate_locked_super+0x7f/0xe0
 deactivate_super+0xb2/0xc0
 cleanup_mnt+0x2ec/0x450
 task_work_run+0x101/0x1a0
 exit_to_user_mode_prepare+0x132/0x140
 syscall_exit_to_user_mode+0x12/0x20
 do_syscall_64+0x48/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46b1b7
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8 64 89 =
01
48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 7=
3 01
c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5db62af8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046b1b7
RDX: 0000000000404502 RSI: 0000000000000002 RDI: 00007ffd5db62bc0
RBP: 00007ffd5db62bc0 R08: 00000000032b0083 R09: 000000000000000b
R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004d17aa
R13: 00007ffd5db63c70 R14: 0000000000000004 R15: 0000000000000032
---[ end trace 852a0a8b5201e68c ]---
loop2: detected capacity change from 0 to 4096
Quota error (device loop2): v2_read_file_info: Free block number too big (0=
 >=3D
0).
EXT4-fs warning (device loop2): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-117). Please run e2fsck to fix.
EXT4-fs (loop2): mount failed
loop6: detected capacity change from 0 to 545
loop4: detected capacity change from 0 to 544
EXT4-fs error (device loop4): ext4_quota_enable:6432: comm syz-executor.4: =
Bad
quota inode # 3
EXT4-fs warning (device loop4): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-116). Please run e2fsck to fix.
EXT4-fs (loop4): mount failed
loop1: detected capacity change from 0 to 544
ext4 filesystem being mounted at
/syzkaller-testdir919013516/syzkaller.s42ayS/269/file0 supports timestamps
until 2038 (0x7fffffff)
EXT4-fs (loop6): re-mounted. Opts: (null). Quota mode: writeback.
loop6: detected capacity change from 0 to 545
loop7: detected capacity change from 0 to 544
EXT4-fs error (device loop7): ext4_quota_enable:6432: comm syz-executor.7: =
Bad
quota inode # 3
EXT4-fs warning (device loop7): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-116). Please run e2fsck to fix.
loop2: detected capacity change from 0 to 4096
EXT4-fs error (device loop1): ext4_quota_enable:6432: comm syz-executor.1: =
Bad
quota inode # 3
EXT4-fs warning (device loop1): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-116). Please run e2fsck to fix.
loop4: detected capacity change from 0 to 544
EXT4-fs (loop1): mount failed
EXT4-fs (loop7): mount failed
ext4 filesystem being mounted at
/syzkaller-testdir919013516/syzkaller.s42ayS/270/file0 supports timestamps
until 2038 (0x7fffffff)
EXT4-fs (loop6): re-mounted. Opts: (null). Quota mode: writeback.
Quota error (device loop2): v2_read_file_info: Free block number too big (0=
 >=3D
0).
EXT4-fs error (device loop4): ext4_quota_enable:6432: comm syz-executor.4: =
Bad
quota inode # 3
EXT4-fs warning (device loop4): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-116). Please run e2fsck to fix.
EXT4-fs warning (device loop2): ext4_enable_quotas:6472: Failed to enable q=
uota
tracking (type=3D0, err=3D-117). Please run e2fsck to fix.
EXT4-fs (loop4): mount failed
EXT4-fs (loop2): mount failed
general protection fault, probably for non-canonical address 0xc823ddfe2200=
08:
0000 [#1] SMP KASAN PTI
CPU: 0 PID: 12905 Comm: systemd-udevd Tainted: G    B   W         5.13.0-rc=
3+
#2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
RIP: 0010:qlist_free_all+0x8d/0xd0
Code: 85 db 75 cf b8 00 00 00 80 48 01 f0 72 53 4c 89 fa 48 2b 15 3d c2 c2 =
02
48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 1b c2 c2 02 <48> 8b 50 08 48 8d 4=
a ff
83 e2 01 48 0f 45 c1 48 8b 78 18 eb 94 49
RSP: 0018:ffff888003cbf700 EFLAGS: 00010207
RAX: 00c823ddfe220000 RBX: 0000000000000000 RCX: 0000000000080006
RDX: 0000777f80000000 RSI: 320dffff888004dc RDI: 0000000000000000
RBP: 320dffff888004dc R08: 0000000000000000 R09: ffffffffb7be1f00
R10: ffff8880308eadc2 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffffffb7be1f36 R14: ffff888003cbf738 R15: ffffffff80000000
FS:  00007f3e9659c8c0(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4c53aea7 CR3: 0000000008c8a006 CR4: 0000000000370ef0
Call Trace:
 kasan_quarantine_reduce+0x117/0x140
 __kasan_slab_alloc+0x7a/0x80
 kmem_cache_alloc_node+0xd3/0x200
 __alloc_skb+0x201/0x320
 alloc_skb_with_frags+0x87/0x4b0
 sock_alloc_send_pskb+0x68b/0x7f0
 unix_dgram_sendmsg+0x38d/0x12c0
 sock_sendmsg+0x132/0x170
 sock_write_iter+0x241/0x390
 new_sync_write+0x418/0x5c0
 vfs_write+0x445/0x730
 ksys_write+0x1ac/0x1f0
 do_syscall_64+0x3c/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3e956e31b0
Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84 00 00 =
00
00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 7=
3 31
c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24
RSP: 002b:00007ffc4c53d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005569587229f0 RCX: 00007f3e956e31b0
RDX: 0000000000000000 RSI: 00007ffc4c53d0f0 RDI: 0000000000000008
RBP: 00007ffc4c53d1b0 R08: 00005569587210a4 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 00007ffc4c53d100
R13: 000055695871d7e0 R14: 0000000000000003 R15: 000000000000000e
Modules linked in:
---[ end trace 852a0a8b5201e68d ]---
RIP: 0010:qlist_free_all+0x8d/0xd0
Code: 85 db 75 cf b8 00 00 00 80 48 01 f0 72 53 4c 89 fa 48 2b 15 3d c2 c2 =
02
48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 1b c2 c2 02 <48> 8b 50 08 48 8d 4=
a ff
83 e2 01 48 0f 45 c1 48 8b 78 18 eb 94 49
RSP: 0018:ffff888003cbf700 EFLAGS: 00010207
RAX: 00c823ddfe220000 RBX: 0000000000000000 RCX: 0000000000080006
RDX: 0000777f80000000 RSI: 320dffff888004dc RDI: 0000000000000000
RBP: 320dffff888004dc R08: 0000000000000000 R09: ffffffffb7be1f00
R10: ffff8880308eadc2 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffffffb7be1f36 R14: ffff888003cbf738 R15: ffffffff80000000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
