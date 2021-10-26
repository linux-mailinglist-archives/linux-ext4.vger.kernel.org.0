Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CB43AA61
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhJZCmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 22:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234249AbhJZCmD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Oct 2021 22:42:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 251E260249
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 02:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635215980;
        bh=usqBB3cO0r1slPSx0aJpuRa1K1MYWX0Iavv6szoGou4=;
        h=From:To:Subject:Date:From;
        b=SW12ECw2ELPq7KP3wbCDDlSENfuFlbqWFHNkNEcaM1FeHLLQomU9pI7K1NdPzmOzq
         njlZoItgLjFx0teyIwPqRCs+nLkVWRh2v+3dWZYSC3oubD2LvzsYakDtTUYRoX6QWW
         ck5M0Mjn0CQpJuEB5+HWgTJG4Bml+yuW4XiiO1TZDE4Mn3Z/nYwS2gIXivAeRF4sx2
         NPic0/l1mqhBkir6VelRkAnhG9cqT0Lw4yIa74wkGLfm78BaXmDnhiyxp/RSqg4qhI
         Ambb0C0FrG6oHYDIOxPsP86OYdcL+zSUWTxn0MipfeQWBpI0AfBIT0QmB4tGsjOj3E
         mGkmmknOSM/6Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1940360ED3; Tue, 26 Oct 2021 02:39:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214819] New: BUG() triggered in ext4_inode_journal_mode on
 mounting crafted image
Date:   Tue, 26 Oct 2021 02:39:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wenqingliu0120@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214819-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214819

            Bug ID: 214819
           Summary: BUG() triggered in ext4_inode_journal_mode on mounting
                    crafted image
           Product: File System
           Version: 2.5
    Kernel Version: 4.19.x/5.X
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: wenqingliu0120@gmail.com
        Regression: No

Created attachment 299315
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299315&action=3Dedit
crafted image that triggered the BUG()

- Overview=20
A BUG() triggered in ext4_inode_journal_mode when a crafted image is mounte=
d.=20

- Reproduce=20
Tested on kernel 4.19.198, 4.19.212 and 5.14.0-rc3, 5.10.53

use-after-free in __rwsem_down_write_failed_common only triggered in 4.19.X
with the second mount of the crafted image

$ mkdir mnt
$ sudo mount -t ext4 tmp20.img mnt
$ sudo mount -t ext4 tmp20.img mnt

https://elixir.bootlin.com/linux/v4.19.212/source/fs/ext4/ext4_jbd2.h#L422

- Kernel dump
[18030.735239] EXT4-fs (loop0): Failed to set 64-bit journal feature
[18030.735722] ------------[ cut here ]------------
[18030.735725] kernel BUG at fs/ext4/ext4_jbd2.h:422!
[18030.735923] invalid opcode: 0000 [#1] SMP KASAN NOPTI
[18030.736078] CPU: 3 PID: 954 Comm: mount Not tainted 4.19.212 #1
[18030.736240] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[18030.736490] RIP: 0010:ext4_inode_journal_mode.part.13+0x0/0xe
[18030.736667] Code: 48 33 0c 25 28 00 00 00 74 05 e8 60 4f ac fd 48 83 c4 =
60
5b 5d 41 5c 41 5d 41 5e c3 0f 0b 48 c7 c7 a0 1f 3c a4 e8 d5 e1 fa fe <0f> 0=
b 48
c7 c7 e0 61 3c a4 e8 c7 e1 fa fe 0f 1f 44 00 00 55 48 b8
[18030.737109] RSP: 0018:ffff888282a2eee8 EFLAGS: 00010246
[18030.737257] RAX: 0000000000080000 RBX: 1ffff11050545de5 RCX:
0000000000000001
[18030.737425] RDX: 1ffff1104dbd5559 RSI: 000000000000008e RDI:
ffff8882942bb378
[18030.737631] RBP: ffff888282a2ef48 R08: ffffed104dbd557e R09:
ffffed104dbd557e
[18030.737796] R10: 0000000000000001 R11: ffffed104dbd557d R12:
ffff88826deaaac8
[18030.737969] R13: ffff8882942b8880 R14: 0000000000000000 R15:
ffff88826deaab60
[18030.738156] FS:  00007fe1c68f5080(0000) GS:ffff888296780000(0000)
knlGS:0000000000000000
[18030.738331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18030.738528] CR2: 000055ded1484b08 CR3: 000000027fe70002 CR4:
0000000000360ee0
[18030.738705] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[18030.738871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[18030.739037] Call Trace:
[18030.739277]  ext4_evict_inode+0x681/0x1480
[18030.739415]  ? ext4_da_write_begin+0xd30/0xd30
[18030.739551]  ? __inode_wait_for_writeback+0x1f0/0x320
[18030.739656]  ? inode_switch_wbs_rcu_fn+0x1c0/0x1c0
[18030.739767]  ? __kasan_slab_free+0x130/0x180
[18030.739868]  ? init_wait_var_entry+0x1a0/0x1a0
[18030.739965]  ? ksys_mount+0x80/0xd0
[18030.740054]  ? __x64_sys_mount+0xba/0x150
[18030.740159]  ? do_syscall_64+0x146/0x450
[18030.740286]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[18030.740444]  evict+0x420/0x860
[18030.740533]  ? writeback_single_inode+0x262/0x470
[18030.740638]  ? destroy_inode+0x1d0/0x1d0
[18030.740729]  ? wb_writeback+0x940/0x940
[18030.740822]  ? __switch_to_asm+0x41/0x70
[18030.740914]  ? write_inode_now+0x289/0x3a0
[18030.741011]  ? writeback_single_inode+0x470/0x470
[18030.741114]  ? remove_proc_entry+0x29a/0x420
[18030.741206]  ? kmem_cache_free+0x78/0x1d0
[18030.741298]  iput+0x3ec/0x770
[18030.741432]  ? jbd2_mark_journal_empty+0x2c9/0x360
[18030.741569]  ? inode_add_lru+0x230/0x230
[18030.741704]  ? mutex_lock+0xaf/0x140
[18030.741830]  ? __brelse+0x11f/0x150
[18030.741969]  ? invalidate_inode_buffers+0x290/0x290
[18030.743985]  jbd2_journal_destroy+0x4c7/0x850
[18030.746272]  ? jbd2_mark_journal_empty+0x360/0x360
[18030.748209]  ? __ext4_msg+0x193/0x1c0
[18030.749541]  ? ext4_decode_error+0x160/0x160
[18030.750606]  ? jbd2_journal_set_features+0x7a/0x920
[18030.751632]  ? jbd2_journal_check_used_features+0x1b0/0x1b0
[18030.752791]  ext4_fill_super+0x6e05/0xbb40
[18030.753786]  ? ext4_calculate_overhead+0x1470/0x1470
[18030.754781]  ? radix_tree_delete+0x10/0x10
[18030.755725]  ? _cond_resched+0x17/0x60
[18030.756675]  ? mutex_lock+0xaf/0x140
[18030.757520]  ? idr_replace+0x1c5/0x250
[18030.758556]  ? idr_find+0x50/0x50
[18030.759693]  ? _cond_resched+0x17/0x60
[18030.760582]  ? down_write+0x64/0x100
[18030.761382]  ? down_write_trylock+0x120/0x120
[18030.762176]  ? string+0x158/0x210
[18030.762966]  ? free_prealloced_shrinker+0xe0/0xe0
[18030.763732]  ? bdev_name.isra.6+0x5c/0x230
[18030.764558]  ? pointer+0x56c/0x760
[18030.765303]  ? netdev_bits+0xb0/0xb0
[18030.766057]  ? ns_test_super+0x50/0x50
[18030.766791]  ? vsnprintf+0xe25/0x12b0
[18030.767524]  ? blkdev_get+0x732/0x9f0
[18030.768252]  ? pointer+0x760/0x760
[18030.769011]  ? rcu_sched_qs.part.48+0x90/0x90
[18030.769734]  ? __blkdev_get+0xfc0/0xfc0
[18030.770454]  ? ext4_calculate_overhead+0x1470/0x1470
[18030.771182]  ? snprintf+0x8f/0xc0
[18030.771905]  ? vsprintf+0x10/0x10
[18030.772669]  ? ns_capable_common+0x55/0xe0
[18030.773389]  ? ext4_calculate_overhead+0x1470/0x1470
[18030.774112]  mount_bdev+0x251/0x300
[18030.774826]  mount_fs+0x55/0x2d0
[18030.775539]  ? digsig_verify+0x11b0/0x11b0
[18030.776247]  vfs_kern_mount.part.5+0xab/0x3e0
[18030.777006]  ? may_umount+0x70/0x70
[18030.777718]  ? __get_fs_type+0x7e/0xc0
[18030.778430]  do_mount+0xc01/0x27e0
[18030.779138]  ? __fput+0x422/0x970
[18030.779838]  ? copy_mount_string+0x20/0x20
[18030.780586]  ? fput+0xa5/0x120
[18030.781337]  ? rcu_sched_qs.part.48+0x90/0x90
[18030.782052]  ? __ia32_sys_fchdir+0x170/0x170
[18030.782751]  ? __check_object_size+0x28b/0x4e0
[18030.783454]  ? usercopy_abort+0x90/0x90
[18030.784159]  ? memcg_kmem_get_cache+0xc00/0xc00
[18030.784922]  ? kasan_unpoison_shadow+0x30/0x40
[18030.785622]  ? kasan_kmalloc+0xa0/0xd0
[18030.786312]  ? __kmalloc_track_caller+0x183/0x210
[18030.787011]  ? _copy_from_user+0x70/0xa0
[18030.787704]  ? memdup_user+0x4b/0x70
[18030.788449]  ksys_mount+0x80/0xd0
[18030.789164]  __x64_sys_mount+0xba/0x150
[18030.789839]  do_syscall_64+0x146/0x450
[18030.790507]  ? syscall_return_slowpath+0x2e0/0x2e0
[18030.791185]  ? do_page_fault+0x90/0x360
[18030.791859]  ? __do_page_fault+0xad0/0xad0
[18030.792638]  ? prepare_exit_to_usermode+0x210/0x210
[18030.793324]  ? recalc_sigpending+0xb2/0x1a0
[18030.794014]  ? perf_trace_sys_enter+0x1050/0x1050
[18030.794712]  ? __put_user_4+0x1c/0x30
[18030.795408]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[18030.796127] RIP: 0033:0x7fe1c61b625a
[18030.796899] Code: 48 8b 0d 31 8c 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d fe 8b 2c 00 f7 d8 64 89 01 48
[18030.798453] RSP: 002b:00007ffd19d831c8 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[18030.799262] RAX: ffffffffffffffda RBX: 000055ded1477a40 RCX:
00007fe1c61b625a
[18030.800083] RDX: 000055ded1477c20 RSI: 000055ded1479940 RDI:
000055ded1480860
[18030.800959] RBP: 0000000000000000 R08: 0000000000000000 R09:
000055ded1477c40
[18030.801792] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
000055ded1480860
[18030.802624] R13: 000055ded1477c20 R14: 0000000000000000 R15:
00007fe1c66d78a4
[18030.803463] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0
multipath linear hid_generic usbhid hid qxl drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops ttm drm crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel pcbc aesni_intel psmouse aes_x86_64 crypto_simd cryptd
glue_helper
[18030.807383] ---[ end trace 75ff1873916c7210 ]---
[18030.808648] RIP: 0010:ext4_inode_journal_mode.part.13+0x0/0xe
[18030.810054] Code: 48 33 0c 25 28 00 00 00 74 05 e8 60 4f ac fd 48 83 c4 =
60
5b 5d 41 5c 41 5d 41 5e c3 0f 0b 48 c7 c7 a0 1f 3c a4 e8 d5 e1 fa fe <0f> 0=
b 48
c7 c7 e0 61 3c a4 e8 c7 e1 fa fe 0f 1f 44 00 00 55 48 b8
[18030.812514] RSP: 0018:ffff888282a2eee8 EFLAGS: 00010246
[18030.813772] RAX: 0000000000080000 RBX: 1ffff11050545de5 RCX:
0000000000000001
[18030.814936] RDX: 1ffff1104dbd5559 RSI: 000000000000008e RDI:
ffff8882942bb378
[18030.816086] RBP: ffff888282a2ef48 R08: ffffed104dbd557e R09:
ffffed104dbd557e
[18030.817279] R10: 0000000000000001 R11: ffffed104dbd557d R12:
ffff88826deaaac8
[18030.818405] R13: ffff8882942b8880 R14: 0000000000000000 R15:
ffff88826deaab60
[18030.819586] FS:  00007fe1c68f5080(0000) GS:ffff888296780000(0000)
knlGS:0000000000000000
[18030.820844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18030.822014] CR2: 000055ded1484b08 CR3: 000000027fe70002 CR4:
0000000000360ee0
[18030.823263] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[18030.824514] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[18491.257861]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[18491.259530] BUG: KASAN: use-after-free in
__rwsem_down_write_failed_common+0x1489/0x1490
[18491.261268] Read of size 4 at addr ffff88826db38038 by task mount/970

[18491.263985] CPU: 3 PID: 970 Comm: mount Tainted: G      D           4.19=
.212
#1
[18491.265313] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[18491.266656] Call Trace:
[18491.267945]  dump_stack+0x11d/0x1a9
[18491.269350]  ? switchdev_obj_size.part.3+0x13/0x13
[18491.270681]  ? __save_stack_trace+0x61/0x100
[18491.272005]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.273353]  ? printk+0x9c/0xc3
[18491.275080]  ? pm_qos_get_value.part.4+0xe/0xe
[18491.276568]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.278235]  print_address_description+0x70/0x360
[18491.279620]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.280985]  kasan_report+0x18e/0x2e0
[18491.282319]  ? __rwsem_down_write_failed_common+0x1489/0x1490
[18491.283613]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.285020]  __rwsem_down_write_failed_common+0x1489/0x1490
[18491.286381]  ? get_reg+0x2b0/0x2b0
[18491.287646]  ? d_alloc_cursor+0xd0/0xd0
[18491.288947]  ? rwsem_spin_on_owner+0x5e0/0x5e0
[18491.290274]  ? unwind_next_frame+0xbb5/0x2330
[18491.291657]  ? __save_stack_trace+0x61/0x100
[18491.292920]  ? get_reg+0x1ea/0x2b0
[18491.294170]  ? __read_once_size_nocheck.constprop.4+0x10/0x10
[18491.295385]  ? deref_stack_reg+0xb4/0x120
[18491.296598]  ? unwind_next_frame+0x14d1/0x2330
[18491.297897]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[18491.299055]  ? module_kallsyms_on_each_symbol+0x240/0x240
[18491.300175]  ? __bpf_trace_xdp_cpumap_enqueue+0x10/0x10
[18491.301322]  ? walk_component+0xe2/0x1400
[18491.302445]  ? __bpf_trace_xdp_cpumap_enqueue+0x10/0x10
[18491.303519]  ? get_stack_info+0x3f/0x2a0
[18491.304558]  ? __save_stack_trace+0x61/0x100
[18491.305663]  ? __free_insn_slot+0x7b0/0x7b0
[18491.306709]  ? rcu_is_watching+0x7a/0x120
[18491.307686]  ? rcu_barrier_callback+0x60/0x60
[18491.308655]  ? is_bpf_text_address+0xa/0x20
[18491.309677]  ? kernel_text_address+0x111/0x120
[18491.310682]  ? __kernel_text_address+0xe/0x30
[18491.311627]  ? __save_stack_trace+0xa1/0x100
[18491.312554]  ? save_stack+0x89/0xb0
[18491.313555]  ? __kasan_slab_free+0x130/0x180
[18491.314525]  ? kmem_cache_free+0x78/0x1d0
[18491.315421]  ? filename_lookup+0x2d3/0x5c0
[18491.316322]  ? lookup_bdev+0xd9/0x1e0
[18491.317262]  ? blkdev_get_by_path+0x13/0x70
[18491.318178]  ? mount_bdev+0x40/0x300
[18491.319016]  ? mount_fs+0x55/0x2d0
[18491.319839]  ? vfs_kern_mount.part.5+0xab/0x3e0
[18491.320768]  ? do_mount+0xc01/0x27e0
[18491.321661]  ? ksys_mount+0x80/0xd0
[18491.322660]  ? __x64_sys_mount+0xba/0x150
[18491.323793]  ? do_syscall_64+0x146/0x450
[18491.324562]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.325413]  ? call_rwsem_down_write_failed+0x13/0x20
[18491.326242]  call_rwsem_down_write_failed+0x13/0x20
[18491.327018]  ? _raw_spin_lock+0x13/0x40
[18491.327791]  down_write+0x7f/0x100
[18491.328558]  ? down_read+0x180/0x180
[18491.329379]  ? rcu_sched_qs.part.48+0x90/0x90
[18491.330222]  ? rcu_sched_qs.part.48+0x90/0x90
[18491.331002]  ? _cond_resched+0x17/0x60
[18491.331772]  grab_super+0xcc/0x370
[18491.332529]  ? cpumask_local_spread+0x530/0x530
[18491.333333]  ? freeze_super+0x3c0/0x3c0
[18491.334083]  ? mutex_lock_killable+0xaf/0x150
[18491.334837]  ? __mutex_lock_killable_slowpath+0x10/0x10
[18491.335608]  ? security_capable+0x58/0x90
[18491.336370]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.337184]  sget_userns+0x1bc/0xdd0
[18491.337951]  ? set_bdev_super+0x130/0x130
[18491.338713]  ? inode_add_lru+0x230/0x230
[18491.339489]  ? ns_test_super+0x50/0x50
[18491.340239]  ? destroy_unused_super.part.7+0xe0/0xe0
[18491.341040]  ? blkdev_get+0x732/0x9f0
[18491.341788]  ? rcu_sched_qs.part.48+0x90/0x90
[18491.342533]  ? __blkdev_get+0xfc0/0xfc0
[18491.343273]  ? security_capable+0x58/0x90
[18491.344006]  ? set_bdev_super+0x130/0x130
[18491.344734]  ? ns_capable_common+0x55/0xe0
[18491.345459]  ? sget+0x9c/0x110
[18491.346180]  ? ext4_calculate_overhead+0x1470/0x1470
[18491.346914]  mount_bdev+0xdd/0x300
[18491.347647]  mount_fs+0x55/0x2d0
[18491.348372]  ? digsig_verify+0x11b0/0x11b0
[18491.349113]  vfs_kern_mount.part.5+0xab/0x3e0
[18491.349851]  ? may_umount+0x70/0x70
[18491.350587]  ? __get_fs_type+0x7e/0xc0
[18491.351321]  do_mount+0xc01/0x27e0
[18491.352052]  ? __fput+0x422/0x970
[18491.352799]  ? copy_mount_string+0x20/0x20
[18491.353544]  ? fput+0xa5/0x120
[18491.354304]  ? rcu_sched_qs.part.48+0x90/0x90
[18491.355035]  ? __ia32_sys_fchdir+0x170/0x170
[18491.355767]  ? __check_object_size+0x28b/0x4e0
[18491.356506]  ? usercopy_abort+0x90/0x90
[18491.357244]  ? memcg_kmem_get_cache+0xc00/0xc00
[18491.357981]  ? kasan_unpoison_shadow+0x30/0x40
[18491.358720]  ? kasan_kmalloc+0xa0/0xd0
[18491.359457]  ? __kmalloc_track_caller+0x183/0x210
[18491.360202]  ? _copy_from_user+0x70/0xa0
[18491.360945]  ? memdup_user+0x4b/0x70
[18491.361678]  ksys_mount+0x80/0xd0
[18491.362402]  __x64_sys_mount+0xba/0x150
[18491.363124]  do_syscall_64+0x146/0x450
[18491.363845]  ? syscall_return_slowpath+0x2e0/0x2e0
[18491.364577]  ? do_page_fault+0x90/0x360
[18491.365309]  ? __do_page_fault+0xad0/0xad0
[18491.366051]  ? prepare_exit_to_usermode+0x210/0x210
[18491.366800]  ? recalc_sigpending+0xb2/0x1a0
[18491.367552]  ? perf_trace_sys_enter+0x1050/0x1050
[18491.368321]  ? __put_user_4+0x1c/0x30
[18491.369076]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[18491.369838] RIP: 0033:0x7ff27aea025a
[18491.370594] Code: 48 8b 0d 31 8c 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d fe 8b 2c 00 f7 d8 64 89 01 48
[18491.372236] RSP: 002b:00007ffe961cce18 EFLAGS: 00000206 ORIG_RAX:
00000000000000a5
[18491.373085] RAX: ffffffffffffffda RBX: 000055dcbc090a40 RCX:
00007ff27aea025a
[18491.373942] RDX: 000055dcbc090c20 RSI: 000055dcbc092940 RDI:
000055dcbc099610
[18491.374803] RBP: 0000000000000000 R08: 0000000000000000 R09:
000055dcbc090c40
[18491.375668] R10: 00000000c0ed0000 R11: 0000000000000206 R12:
000055dcbc099610
[18491.376525] R13: 000055dcbc090c20 R14: 0000000000000000 R15:
00007ff27b3c18a4

[18491.378223] Allocated by task 953:
[18491.379073]  kasan_kmalloc+0xa0/0xd0
[18491.379920]  kmem_cache_alloc_node+0xcd/0x200
[18491.380777]  copy_process+0x1cf3/0x7b20
[18491.381630]  _do_fork+0x114/0x950
[18491.382480]  do_syscall_64+0x146/0x450
[18491.383337]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[18491.385081] Freed by task 17:
[18491.385968]  __kasan_slab_free+0x130/0x180
[18491.386821]  kmem_cache_free+0x78/0x1d0
[18491.387671]  free_task+0x140/0x1a0
[18491.388518]  __put_task_struct+0x23d/0x570
[18491.389376]  delayed_put_task_struct+0x96/0x1e0
[18491.390240]  rcu_process_callbacks+0x73b/0xfb0
[18491.391107]  __do_softirq+0x222/0x817

[18491.392829] The buggy address belongs to the object at ffff88826db38000
                which belongs to the cache task_struct(179:user.slice) of s=
ize
5888
[18491.394623] The buggy address is located 56 bytes inside of
                5888-byte region [ffff88826db38000, ffff88826db39700)
[18491.396458] The buggy address belongs to the page:
[18491.397399] page:ffffea0009b6ce00 count:1 mapcount:0
mapping:ffff888282e85880 index:0x0 compound_mapcount: 0
[18491.398386] flags: 0x17ffffc0008100(slab|head)
[18491.399373] raw: 0017ffffc0008100 ffffea000a406400 0000000200000002
ffff888282e85880
[18491.400389] raw: 0000000000000000 0000000080050005 00000001ffffffff
ffff88828eac8000
[18491.401414] page dumped because: kasan: bad access detected
[18491.402446] page->mem_cgroup:ffff88828eac8000

[18491.404498] Memory state around the buggy address:
[18491.405540]  ffff88826db37f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[18491.406601]  ffff88826db37f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[18491.407651] >ffff88826db38000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[18491.408696]                                         ^
[18491.409742]  ffff88826db38080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[18491.410806]  ffff88826db38100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
fb
[18491.411856]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
