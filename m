Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF83B4492
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jun 2021 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFYNge (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Jun 2021 09:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhFYNgd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Jun 2021 09:36:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F295660FE9
        for <linux-ext4@vger.kernel.org>; Fri, 25 Jun 2021 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624628053;
        bh=iqSOk0+2Gh+3NCv9fSTjUuQ6RfQqDTyGuufTARIXhP4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AGr5j1KA+snSeWId/SnKayNCGKz7gbyCxZK+44ooI/MfGUOcV0x2FWYTgb0ikbCsO
         /QNlCTjLNV9OjH1snLuBfa4jNOwZsqzrtTgAWd1TDvQFH4IM3ezhqPqvSX0DWZF7BU
         iUsPoA21jk3YulGeI68EWPYhRt+jZ/0nzzH6vnntK23AvgLBrYNCo1AV1Pd2bcCKM8
         oZ+qRJHEUMBJM5NzR63WlZL9laCXoMfZeYQW/fzTCFFNTxXk3l7D1dRK+x+z9gfGYZ
         +ZhGeBtJje8s/zUZxFyzAsHGi7nOb2BXa63j81sgxau7wGDVx0eruY2yjizgGp2492
         k1zrUgfi0vFWg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E2E186113C; Fri, 25 Jun 2021 13:34:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213539] KASAN: use-after-free Write in ext4_put_super
Date:   Fri, 25 Jun 2021 13:34:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213539-13602-SUPh6Yx5YU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213539-13602@https.bugzilla.kernel.org/>
References: <bug-213539-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213539

--- Comment #4 from 6201613047@stu.jiangnan.edu.cn ---
And the poc also can cause another BUG sometimes: BUG: KASAN: double-free or
invalid-free in __put_task_struct+0x22a/0x4f0. The log is as follow.



[   25.942673]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   25.944029] BUG: KASAN: double-free or invalid-free in
__put_task_struct+0x22a/0x4f0
[   25.945550]=20
[   25.945872] CPU: 0 PID: 336 Comm: poc Tainted: G    B D W=20=20=20=20=20=
=20=20=20
5.13.0-rc3+ #2
[   25.947304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[   25.948439] ext4 filesystem being mounted at /root/syzkaller.OKJyCQ/24/f=
ile0
supports timestamps until 2038 (0x7fffffff)
[   25.949472] Call Trace:
[   25.949476]  dump_stack+0xaf/0xf2
[   25.949483]  print_address_description.constprop.8+0x1a/0x150
[   25.949490]  ? __put_task_struct+0x22a/0x4f0
[   25.949495]  kasan_report_invalid_free+0x50/0x80
[   25.949500]  ? __put_task_struct+0x22a/0x4f0
[   25.949505]  __kasan_slab_free+0xfe/0x110
[   25.949528]  ? __put_task_struct+0x22a/0x4f0
[   25.949532]  kmem_cache_free+0x77/0x280
[   25.958044] EXT4-fs (loop4): re-mounted. Opts: (null). Quota mode:
writeback.
[   25.959010]  __put_task_struct+0x22a/0x4f0
[   25.959031]  kthread_stop+0x2cf/0x370
[   25.959036]  destroy_workqueue+0xff/0x700
[   25.959041]  ? ext4_quota_write+0x600/0x600
[   25.959046]  ext4_put_super+0xdb/0xce0
[   25.959050]  ? ext4_quota_write+0x600/0x600
[   25.959054]  generic_shutdown_super+0x14a/0x370
[   25.959059]  kill_block_super+0x94/0xe0
[   25.959064]  deactivate_locked_super+0x7f/0xe0
[   25.959069]  deactivate_super+0xb2/0xc0
[   25.970853]  cleanup_mnt+0x2ec/0x450
[   25.971622]  task_work_run+0x101/0x1a0
[   25.972437]  exit_to_user_mode_prepare+0x132/0x140
[   25.973434]  syscall_exit_to_user_mode+0x12/0x20
[   25.974330]  do_syscall_64+0x48/0x80
[   25.975106]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   25.976128] RIP: 0033:0x7f1c1389fd77
[   25.976898] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[   25.980943] RSP: 002b:00007fffa72c1428 EFLAGS: 00000206 ORIG_RAX:
00000000000000a6
[   25.982628] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00007f1c1389fd77
[   25.984122] RDX: 00007fffa72c150a RSI: 0000000000000002 RDI:
00007fffa72c1500
[   25.985529] RBP: 00007fffa72c2510 R08: 000055b1e31fd083 R09:
000000000000000a
[   25.987042] R10: 0000000000000073 R11: 0000000000000206 R12:
000055b1e1c010b0
[   25.988471] R13: 00007fffa72c2660 R14: 0000000000000000 R15:
0000000000000000
[   25.989922]=20
[   25.990300] Allocated by task 131072:
[   25.991327] ------------[ cut here ]------------
[   25.992295] slab index 131072 out of bounds (119) for stack id 00020000
[   25.993720] WARNING: CPU: 0 PID: 336 at lib/stackdepot.c:237
stack_depot_fetch+0x5d/0x70
[   25.995543] Modules linked in:
[   25.996309] CPU: 0 PID: 336 Comm: poc Tainted: G    B D W=20=20=20=20=20=
=20=20=20
5.13.0-rc3+ #2
[   25.997974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[   26.000094] RIP: 0010:stack_depot_fetch+0x5d/0x70
[   26.001017] Code: 74 2d 48 c1 e0 04 25 f0 3f 00 00 48 01 d0 48 8d 50 18 =
48
89 16 8b 40 0c c3 89 f9 44 89 c6 48 c7 c7 d0 47 fb 87 e8 1c b6 8e 01 <0f> 0=
b 31
c0 c3 31 c0 c3 90 66 2e 0f 1f 84 00 00 00 00 00 48 63 15
[   26.004698] RSP: 0018:ffff8880088bfc50 EFLAGS: 00010086
[   26.005798] RAX: 0000000000000000 RBX: ffff8880075d8e02 RCX:
ffffffff8504f048
[   26.007441] RDX: ffff888001868000 RSI: 0000000000000000 RDI:
ffff888068c1f598
[   26.009075] RBP: ffffea00001d7600 R08: ffffed100d183eb4 R09:
ffffed100d183eb4
[   26.010611] R10: ffff888068c1f59b R11: ffffed100d183eb3 R12:
ffff88800112cdc0
[   26.012196] R13: ffff8880075d8e00 R14: ffff8880075d9b80 R15:
0000000000000000
[   26.013861] FS:  00007f1c13d74480(0000) GS:ffff888068c00000(0000)
knlGS:0000000000000000
[   26.015540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.016872] CR2: 00007ffc569bbcd7 CR3: 0000000008810000 CR4:
00000000000006f0
[   26.018480] Call Trace:
[   26.019002]  print_stack+0x9/0x18
[   26.019737]  print_address_description.constprop.8.cold.12+0x185/0x18a
[   26.021019]  ? __put_task_struct+0x22a/0x4f0
[   26.021976]  kasan_report_invalid_free+0x50/0x80
[   26.022911]  ? __put_task_struct+0x22a/0x4f0
[   26.023805]  __kasan_slab_free+0xfe/0x110
[   26.024598]  ? __put_task_struct+0x22a/0x4f0
[   26.025502]  kmem_cache_free+0x77/0x280
[   26.026293]  __put_task_struct+0x22a/0x4f0
[   26.027094]  kthread_stop+0x2cf/0x370
[   26.027827]  destroy_workqueue+0xff/0x700
[   26.028729]  ? ext4_quota_write+0x600/0x600
[   26.029851]  ext4_put_super+0xdb/0xce0
[   26.030690]  ? ext4_quota_write+0x600/0x600
[   26.031724]  generic_shutdown_super+0x14a/0x370
[   26.032753]  kill_block_super+0x94/0xe0
[   26.033593]  deactivate_locked_super+0x7f/0xe0
[   26.034426]  deactivate_super+0xb2/0xc0
[   26.035226]  cleanup_mnt+0x2ec/0x450
[   26.035964]  task_work_run+0x101/0x1a0
[   26.036711]  exit_to_user_mode_prepare+0x132/0x140
[   26.037644]  syscall_exit_to_user_mode+0x12/0x20
[   26.038541]  do_syscall_64+0x48/0x80
[   26.039299]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.040245] RIP: 0033:0x7f1c1389fd77
[   26.040952] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[   26.044786] RSP: 002b:00007fffa72c1428 EFLAGS: 00000206 ORIG_RAX:
00000000000000a6
[   26.046353] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00007f1c1389fd77
[   26.047859] RDX: 00007fffa72c150a RSI: 0000000000000002 RDI:
00007fffa72c1500
[   26.049397] RBP: 00007fffa72c2510 R08: 000055b1e31fd083 R09:
000000000000000a
[   26.051028] R10: 0000000000000073 R11: 0000000000000206 R12:
000055b1e1c010b0
[   26.052424] R13: 00007fffa72c2660 R14: 0000000000000000 R15:
0000000000000000
[   26.053764] ---[ end trace d8fc4879a76a1704 ]---
[   26.054669] ------------[ cut here ]------------
[   26.055673] WARNING: CPU: 0 PID: 336 at kernel/stacktrace.c:28
stack_trace_print+0x16/0x20
[   26.057321] Modules linked in:
[   26.057960] CPU: 0 PID: 336 Comm: poc Tainted: G    B D W=20=20=20=20=20=
=20=20=20
5.13.0-rc3+ #2
[   26.059328] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[   26.061085] RIP: 0010:stack_trace_print+0x16/0x20
[   26.061987] Code: 00 00 75 06 48 83 c4 60 5b c3 e8 e5 50 4b 02 0f 1f 44 =
00
00 41 55 41 54 55 53 48 85 ff 74 0b 85 f6 75 0b 5b 5d 41 5c 41 5d c3 <0f> 0=
b eb
f5 e9 37 44 40 02 90 41 57 41 56 41 55 41 54 55 53 48 83
[   26.065636] RSP: 0018:ffff8880088bfc30 EFLAGS: 00010046
[   26.066639] RAX: 0000000000000000 RBX: ffff8880075d8e02 RCX:
ffffffff8504f048
[   26.068078] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[   26.069440] RBP: ffffea00001d7600 R08: ffffed100d183eb4 R09:
ffffed100d183eb4
[   26.071029] R10: ffff888068c1f59b R11: ffffed100d183eb3 R12:
ffff88800112cdc0
[   26.072404] R13: ffff8880075d8e00 R14: ffff8880075d9b80 R15:
0000000000000000
[   26.074029] FS:  00007f1c13d74480(0000) GS:ffff888068c00000(0000)
knlGS:0000000000000000
[   26.075887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.077192] CR2: 00007ffc569bbcd7 CR3: 0000000008810000 CR4:
00000000000006f0
[   26.078700] Call Trace:
[   26.079225]  print_stack+0x16/0x18
[   26.079906]  print_address_description.constprop.8.cold.12+0x185/0x18a
[   26.081193]  ? __put_task_struct+0x22a/0x4f0
[   26.082049]  kasan_report_invalid_free+0x50/0x80
[   26.082957]  ? __put_task_struct+0x22a/0x4f0
[   26.083799]  __kasan_slab_free+0xfe/0x110
[   26.084603]  ? __put_task_struct+0x22a/0x4f0
[   26.085479]  kmem_cache_free+0x77/0x280
[   26.086284]  __put_task_struct+0x22a/0x4f0
[   26.087056]  kthread_stop+0x2cf/0x370
[   26.087806]  destroy_workqueue+0xff/0x700
[   26.088556]  ? ext4_quota_write+0x600/0x600
[   26.089397]  ext4_put_super+0xdb/0xce0
[   26.090374]  ? ext4_quota_write+0x600/0x600
[   26.091299]  generic_shutdown_super+0x14a/0x370
[   26.092227]  kill_block_super+0x94/0xe0
[   26.092945]  deactivate_locked_super+0x7f/0xe0
[   26.093835]  deactivate_super+0xb2/0xc0
[   26.094663]  cleanup_mnt+0x2ec/0x450
[   26.095389]  task_work_run+0x101/0x1a0
[   26.096137]  exit_to_user_mode_prepare+0x132/0x140
[   26.097104]  syscall_exit_to_user_mode+0x12/0x20
[   26.098144]  do_syscall_64+0x48/0x80
[   26.098849]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.099909] RIP: 0033:0x7f1c1389fd77
[   26.100749] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[   26.104349] RSP: 002b:00007fffa72c1428 EFLAGS: 00000206 ORIG_RAX:
00000000000000a6
[   26.105947] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00007f1c1389fd77
[   26.107476] RDX: 00007fffa72c150a RSI: 0000000000000002 RDI:
00007fffa72c1500
[   26.108963] RBP: 00007fffa72c2510 R08: 000055b1e31fd083 R09:
000000000000000a
[   26.110389] R10: 0000000000000073 R11: 0000000000000206 R12:
000055b1e1c010b0
[   26.111832] R13: 00007fffa72c2660 R14: 0000000000000000 R15:
0000000000000000
[   26.113173] ---[ end trace d8fc4879a76a1705 ]---
[   26.114104]=20
[   26.114411] Last potentially related work creation:
[   26.115400]  kasan_save_stack+0x19/0x40
[   26.116078]  kasan_record_aux_stack+0xa3/0xb0
[   26.116964]  call_rcu+0x76/0xac0
[   26.117646]  put_task_struct_rcu_user+0x61/0x90
[   26.118554]  finish_task_switch+0x48a/0x670
[   26.119366]  __schedule+0x873/0x18f0
[   26.120116]  preempt_schedule_common+0x16/0x50
[   26.121022]  __cond_resched+0x18/0x20
[   26.121867]  wait_for_completion+0x69/0x260
[   26.122774]  kthread_stop+0xf1/0x370
[   26.123470]  destroy_workqueue+0xff/0x700
[   26.124307]  ext4_put_super+0xdb/0xce0
[   26.125078]  generic_shutdown_super+0x14a/0x370
[   26.125959]  kill_block_super+0x94/0xe0
[   26.126758]  deactivate_locked_super+0x7f/0xe0
[   26.127618]  deactivate_super+0xb2/0xc0
[   26.128299]  cleanup_mnt+0x2ec/0x450
[   26.128958]  task_work_run+0x101/0x1a0
[   26.129690]  exit_to_user_mode_prepare+0x132/0x140
[   26.130709]  syscall_exit_to_user_mode+0x12/0x20
[   26.131670]  do_syscall_64+0x48/0x80
[   26.132349]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.133458]=20
[   26.133856] Second to last potentially related work creation:
[   26.135165] ------------[ cut here ]------------
[   26.136254] slab index 41440 out of bounds (119) for stack id e2a0a1e0
[   26.137534] WARNING: CPU: 0 PID: 336 at lib/stackdepot.c:237
stack_depot_fetch+0x5d/0x70
[   26.139039] Modules linked in:
[   26.139778] CPU: 0 PID: 336 Comm: poc Tainted: G    B D W=20=20=20=20=20=
=20=20=20
5.13.0-rc3+ #2
[   26.141483] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[   26.143417] RIP: 0010:stack_depot_fetch+0x5d/0x70
[   26.144331] Code: 74 2d 48 c1 e0 04 25 f0 3f 00 00 48 01 d0 48 8d 50 18 =
48
89 16 8b 40 0c c3 89 f9 44 89 c6 48 c7 c7 d0 47 fb 87 e8 1c b6 8e 01 <0f> 0=
b 31
c0 c3 31 c0 c3 90 66 2e 0f 1f 84 00 00 00 00 00 48 63 15
[   26.147905] RSP: 0018:ffff8880088bfc50 EFLAGS: 00010086
[   26.148949] RAX: 0000000000000000 RBX: ffff8880075d8e02 RCX:
ffffffff8504f048
[   26.150298] RDX: ffff888001868000 RSI: 0000000000000000 RDI:
ffff888068c1f598
[   26.151800] RBP: ffffea00001d7600 R08: ffffed100d183eb4 R09:
ffffed100d183eb4
[   26.153203] R10: ffff888068c1f59b R11: ffffed100d183eb3 R12:
ffff88800112cdc0
[   26.154663] R13: ffff8880075d8e00 R14: ffff8880075d9b80 R15:
0000000000000000
[   26.156163] FS:  00007f1c13d74480(0000) GS:ffff888068c00000(0000)
knlGS:0000000000000000
[   26.157652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.158793] CR2: 00007ffc569bbcd7 CR3: 0000000008810000 CR4:
00000000000006f0
[   26.160229] Call Trace:
[   26.160772]  print_stack+0x9/0x18
[   26.161550]  print_address_description.constprop.8.cold.12+0x12b/0x18a
[   26.162872]  ? __put_task_struct+0x22a/0x4f0
[   26.163770]  kasan_report_invalid_free+0x50/0x80
[   26.164760]  ? __put_task_struct+0x22a/0x4f0
[   26.165614]  __kasan_slab_free+0xfe/0x110
[   26.166382]  ? __put_task_struct+0x22a/0x4f0
[   26.167213]  kmem_cache_free+0x77/0x280
[   26.167915]  __put_task_struct+0x22a/0x4f0
[   26.168732]  kthread_stop+0x2cf/0x370
[   26.169485]  destroy_workqueue+0xff/0x700
[   26.170300]  ? ext4_quota_write+0x600/0x600
[   26.171151]  ext4_put_super+0xdb/0xce0
[   26.171893]  ? ext4_quota_write+0x600/0x600
[   26.172721]  generic_shutdown_super+0x14a/0x370
[   26.173628]  kill_block_super+0x94/0xe0
[   26.174366]  deactivate_locked_super+0x7f/0xe0
[   26.175283]  deactivate_super+0xb2/0xc0
[   26.176021]  cleanup_mnt+0x2ec/0x450
[   26.176698]  task_work_run+0x101/0x1a0
[   26.177432]  exit_to_user_mode_prepare+0x132/0x140
[   26.178462]  syscall_exit_to_user_mode+0x12/0x20
[   26.179371]  do_syscall_64+0x48/0x80
[   26.180145]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.181364] RIP: 0033:0x7f1c1389fd77
[   26.182104] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[   26.185719] RSP: 002b:00007fffa72c1428 EFLAGS: 00000206 ORIG_RAX:
00000000000000a6
[   26.187183] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00007f1c1389fd77
[   26.188577] RDX: 00007fffa72c150a RSI: 0000000000000002 RDI:
00007fffa72c1500
[   26.190070] RBP: 00007fffa72c2510 R08: 000055b1e31fd083 R09:
000000000000000a
[   26.191547] R10: 0000000000000073 R11: 0000000000000206 R12:
000055b1e1c010b0
[   26.193007] R13: 00007fffa72c2660 R14: 0000000000000000 R15:
0000000000000000
[   26.194514] ---[ end trace d8fc4879a76a1706 ]---
[   26.195530] ------------[ cut here ]------------
[   26.196570] WARNING: CPU: 0 PID: 336 at kernel/stacktrace.c:28
stack_trace_print+0x16/0x20
[   26.198604] Modules linked in:
[   26.199275] CPU: 0 PID: 336 Comm: poc Tainted: G    B D W=20=20=20=20=20=
=20=20=20
5.13.0-rc3+ #2
[   26.200824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[   26.202582] RIP: 0010:stack_trace_print+0x16/0x20
[   26.203443] Code: 00 00 75 06 48 83 c4 60 5b c3 e8 e5 50 4b 02 0f 1f 44 =
00
00 41 55 41 54 55 53 48 85 ff 74 0b 85 f6 75 0b 5b 5d 41 5c 41 5d c3 <0f> 0=
b eb
f5 e9 37 44 40 02 90 41 57 41 56 41 55 41 54 55 53 48 83
[   26.207062] RSP: 0018:ffff8880088bfc30 EFLAGS: 00010046
[   26.208146] RAX: 0000000000000000 RBX: ffff8880075d8e02 RCX:
ffffffff8504f048
[   26.209688] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[   26.211005] RBP: ffffea00001d7600 R08: ffffed100d183eb4 R09:
ffffed100d183eb4
[   26.212375] R10: ffff888068c1f59b R11: ffffed100d183eb3 R12:
ffff88800112cdc0
[   26.214077] R13: ffff8880075d8e00 R14: ffff8880075d9b80 R15:
0000000000000000
[   26.215431] FS:  00007f1c13d74480(0000) GS:ffff888068c00000(0000)
knlGS:0000000000000000
[   26.216898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.217980] CR2: 00007ffc569bbcd7 CR3: 0000000008810000 CR4:
00000000000006f0
[   26.219375] Call Trace:
[   26.219931]  print_stack+0x16/0x18
[   26.220621]  print_address_description.constprop.8.cold.12+0x12b/0x18a
[   26.222082]  ? __put_task_struct+0x22a/0x4f0
[   26.223018]  kasan_report_invalid_free+0x50/0x80
[   26.223902]  ? __put_task_struct+0x22a/0x4f0
[   26.224850]  __kasan_slab_free+0xfe/0x110
[   26.225682]  ? __put_task_struct+0x22a/0x4f0
[   26.226662]  kmem_cache_free+0x77/0x280
[   26.227496]  __put_task_struct+0x22a/0x4f0
[   26.228348]  kthread_stop+0x2cf/0x370
[   26.229216]  destroy_workqueue+0xff/0x700
[   26.230125]  ? ext4_quota_write+0x600/0x600
[   26.231218]  ext4_put_super+0xdb/0xce0
[   26.232073]  ? ext4_quota_write+0x600/0x600
[   26.233026]  generic_shutdown_super+0x14a/0x370
[   26.233985]  kill_block_super+0x94/0xe0
[   26.234790]  deactivate_locked_super+0x7f/0xe0
[   26.235624]  deactivate_super+0xb2/0xc0
[   26.236420]  cleanup_mnt+0x2ec/0x450
[   26.237129]  task_work_run+0x101/0x1a0
[   26.237977]  exit_to_user_mode_prepare+0x132/0x140
[   26.238961]  syscall_exit_to_user_mode+0x12/0x20
[   26.239822]  do_syscall_64+0x48/0x80
[   26.240574]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.241829] RIP: 0033:0x7f1c1389fd77
[   26.242562] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[   26.246192] RSP: 002b:00007fffa72c1428 EFLAGS: 00000206 ORIG_RAX:
00000000000000a6
[   26.247587] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00007f1c1389fd77
[   26.248997] RDX: 00007fffa72c150a RSI: 0000000000000002 RDI:
00007fffa72c1500
[   26.250314] RBP: 00007fffa72c2510 R08: 000055b1e31fd083 R09:
000000000000000a
[   26.251786] R10: 0000000000000073 R11: 0000000000000206 R12:
000055b1e1c010b0
[   26.253364] R13: 00007fffa72c2660 R14: 0000000000000000 R15:
0000000000000000
[   26.254782] ---[ end trace d8fc4879a76a1707 ]---
[   26.255930]=20
[   26.256317] The buggy address belongs to the object at ffff8880075d8e00
[   26.256317]  which belongs to the cache task_struct of size 3456
[   26.259145] The buggy address is located 2 bytes inside of
[   26.259145]  3456-byte region [ffff8880075d8e00, ffff8880075d9b80)
[   26.261404] The buggy address belongs to the page:
[   26.262356] page:0000000055a51e09 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff8880075df000 pfn:0x75d8
[   26.264348] head:0000000055a51e09 order:3 compound_mapcount:0
compound_pincount:0
[   26.265713] flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
[   26.266858] raw: 0100000000010200 ffffea0000257600 0000000200000002
ffff88800112cdc0
[   26.268227] raw: ffff8880075df000 0000000080090006 00000001ffffffff
0000000000000000
[   26.269902] page dumped because: kasan: bad access detected
[   26.270960]=20
[   26.271272] Memory state around the buggy address:
[   26.272370]  ffff8880075d8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[   26.273911]  ffff8880075d8d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[   26.275314] >ffff8880075d8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[   26.276673]                    ^
[   26.277327]  ffff8880075d8e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[   26.278712]  ffff8880075d8f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[   26.280176]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
