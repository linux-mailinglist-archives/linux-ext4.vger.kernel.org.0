Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD47B4E94
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjJBJDr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjJBJDq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 05:03:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD53C33
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 01:57:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD6BEC433CC
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696237022;
        bh=bTpUg5K3BPgpjIafldl5kSg8/B1dXqMgh0RTvDSGqoI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RI3uQdv8FoQX9DpZBReRn60fPbPhhTB8Rq4X6XmNZ/8LOCFLSYP0YUoz8D7URpfIx
         FGWMK/pGwNGxOZJuYbJ5IpeXkXNl/bCEGa8YGozR3meQ6G8UYgMUjyReF8VFOhc2AI
         q07zuKUuyvwJxXOBMFa1Ashx82dT4udkinggKwfsm1cckeYAopk0cSygX3HI6lq/4L
         fZZBQkg0mVAKv+XwD3iWJwMtGrPgaonEf9ZlImgpQqFdiILTryfX1WhDfJzwzsJqpY
         vn9p3i6ddlTYLoOmD4ky6CpQCTw/PrAX7aYH/CetOTAbMCIgw1beEz7SW5d1N/2SH0
         +r99ifuuIxNww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id ACC20C53BCD; Mon,  2 Oct 2023 08:57:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 08:57:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-F9UfMfcFVY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #2 from Ivan Ivanich (iivanich@gmail.com) ---
Backtrace echo l > /proc/sysrq-trigger:


[ 3128.330756] CPU: 2 PID: 311853 Comm: patch Tainted: P           O=20=20=
=20=20=20=20
6.6.0-rc4-x86_64 #1
[ 3128.330758] Hardware name: ASUS All Series/Z97-K, BIOS 2902 03/31/2016
[ 3128.330759] RIP: 0010:mb_find_order_for_block+0x68/0xa0
[ 3128.330762] Code: d0 02 00 00 42 0f b7 04 00 48 01 f0 48 89 c6 41 89 f9 =
c1
e0 03 83 e0 38 41 d3 f9 48 83 e6 f8 44 01 c8 48 98 48 0f a3 06 73 27 <0f> b=
7 42
30 83 c1 01 83 c0 01 39 c1 7f 17 48 8b 42 18 48 8b 72 08
[ 3128.330763] RSP: 0018:ffffc9000e363630 EFLAGS: 00000207
[ 3128.330765] RAX: 0000000000000036 RBX: ffffc9000e363698 RCX:
000000000000000c
[ 3128.330766] RDX: ffffc9000e363738 RSI: ffff88810a7e2ff8 RDI:
0000000000006000
[ 3128.330767] RBP: 0000000000007ff0 R08: 0000000000000018 R09:
0000000000000006
[ 3128.330767] R10: 0000000000000001 R11: 0000000000000000 R12:
0000000000006000
[ 3128.330768] R13: 0000000000006000 R14: 000000000000000d R15:
ffffc9000e363738
[ 3128.330769] FS:  00007f237c609740(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 3128.330771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3128.330772] CR2: 00005576c2964000 CR3: 0000000261c76004 CR4:
00000000001706e0
[ 3128.330773] Call Trace:
[ 3128.330774]  <NMI>
[ 3128.330774]  ? nmi_cpu_backtrace+0x88/0xf0
[ 3128.330776]  ? nmi_cpu_backtrace_handler+0xc/0x20
[ 3128.330778]  ? nmi_handle+0x53/0xf0
[ 3128.330780]  ? default_do_nmi+0x40/0x220
[ 3128.330782]  ? exc_nmi+0xf3/0x120
[ 3128.330784]  ? end_repeat_nmi+0x16/0x67
[ 3128.330787]  ? mb_find_order_for_block+0x68/0xa0
[ 3128.330788]  ? mb_find_order_for_block+0x68/0xa0
[ 3128.330790]  ? mb_find_order_for_block+0x68/0xa0
[ 3128.330792]  </NMI>
[ 3128.330792]  <TASK>
[ 3128.330793]  mb_find_extent+0x149/0x200
[ 3128.330795]  ext4_mb_scan_aligned+0xd3/0x140
[ 3128.330798]  ext4_mb_regular_allocator+0xcca/0xe50
[ 3128.330800]  ext4_mb_new_blocks+0x8c6/0xe80
[ 3128.330802]  ? ext4_find_extent+0x3c1/0x410
[ 3128.330803]  ? release_pages+0x13a/0x400
[ 3128.330805]  ext4_ext_map_blocks+0x626/0x15c0
[ 3128.330807]  ? filemap_get_folios_tag+0x1c6/0x1f0
[ 3128.330809]  ? mpage_prepare_extent_to_map+0x462/0x4a0
[ 3128.330811]  ext4_map_blocks+0x18b/0x5f0
[ 3128.330813]  ? kmem_cache_alloc+0x278/0x410
[ 3128.330814]  ? ext4_alloc_io_end_vec+0x19/0x50
[ 3128.330816]  ext4_do_writepages+0x619/0xa90
[ 3128.330818]  ext4_writepages+0xa8/0x180
[ 3128.330819]  do_writepages+0xc6/0x190
[ 3128.330821]  ? __find_get_block+0x1b2/0x2a0
[ 3128.330824]  filemap_fdatawrite_wbc+0x5e/0x80
[ 3128.330827]  __filemap_fdatawrite_range+0x57/0x80
[ 3128.330829]  ext4_rename+0x753/0xbf0
[ 3128.330831]  vfs_rename+0xa7e/0xbe0
[ 3128.330834]  ? do_renameat2+0x4be/0x660
[ 3128.330836]  do_renameat2+0x4be/0x660
[ 3128.330838]  __x64_sys_renameat+0x44/0x60
[ 3128.330839]  do_syscall_64+0x3f/0x90
[ 3128.330841]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 3128.330843] RIP: 0033:0x7f237c66160a
[ 3128.330844] Code: 48 8b 15 21 e8 15 00 f7 d8 64 89 02 b8 ff ff ff ff c3 =
66
2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 08 01 00 00 0f 05 <48> 3=
d 00
f0 ff ff 77 06 c3 0f 1f 44 00 00 48 8b 15 e9 e7 15 00 f7
[ 3128.330845] RSP: 002b:00007ffcf85ca528 EFLAGS: 00000202 ORIG_RAX:
0000000000000108
[ 3128.330847] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f237c66160a
[ 3128.330848] RDX: 0000000000000004 RSI: 00005576c295a091 RDI:
0000000000000004
[ 3128.330848] RBP: 0000000000000004 R08: 00000000000081a4 R09:
0000000000000000
[ 3128.330849] R10: 00005576c2959ad1 R11: 0000000000000202 R12:
00005576c2959ad1
[ 3128.330850] R13: 00005576c295a091 R14: 00007ffcf85ca630 R15:
0000000000000000
[ 3128.330851]  </TASK>
[ 3128.330852] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.228980] sysrq: Show backtrace of all active CPUs
[ 4648.228983] NMI backtrace for cpu 1
[ 4648.228985] CPU: 1 PID: 526431 Comm: bash Tainted: P           O=20=20=
=20=20=20=20
6.6.0-rc4-x86_64 #1
[ 4648.228987] Hardware name: ASUS All Series/Z97-K, BIOS 2902 03/31/2016
[ 4648.228987] Call Trace:
[ 4648.228989]  <TASK>
[ 4648.228991]  dump_stack_lvl+0x36/0x50
[ 4648.228995]  nmi_cpu_backtrace+0xc0/0xf0
[ 4648.228997]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[ 4648.228999]  nmi_trigger_cpumask_backtrace+0xc8/0xf0
[ 4648.229000]  __handle_sysrq+0xd2/0x190
[ 4648.229002]  write_sysrq_trigger+0x23/0x40
[ 4648.229004]  proc_reg_write+0x57/0xa0
[ 4648.229006]  vfs_write+0xcb/0x410
[ 4648.229008]  ? filp_flush+0x4d/0x80
[ 4648.229010]  ksys_write+0x62/0xe0
[ 4648.229011]  do_syscall_64+0x3f/0x90
[ 4648.229013]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4648.229016] RIP: 0033:0x7f3d2d70e640
[ 4648.229017] Code: 87 0c 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e =
0f
1f 84 00 00 00 00 00 80 3d 29 0d 0d 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3=
d 00
f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[ 4648.229019] RSP: 002b:00007ffd39f5e4a8 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 4648.229021] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
00007f3d2d70e640
[ 4648.229022] RDX: 0000000000000002 RSI: 000055fbbed84ba0 RDI:
0000000000000001
[ 4648.229023] RBP: 00007f3d2d7d85c0 R08: 0000000000000030 R09:
00007f3d2d7d7b00
[ 4648.229024] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000002
[ 4648.229025] R13: 000055fbbed84ba0 R14: 0000000000000002 R15:
00007f3d2d7d5f40
[ 4648.229026]  </TASK>
[ 4648.229027] Sending NMI from CPU 1 to CPUs 0,2-7:
[ 4648.229030] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.229033] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.229036] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.229039] NMI backtrace for cpu 2
[ 4648.229041] CPU: 2 PID: 71621 Comm: kworker/u16:1 Tainted: P           O=
=20=20=20=20
  6.6.0-rc4-x86_64 #1
[ 4648.229042] Hardware name: ASUS All Series/Z97-K, BIOS 2902 03/31/2016
[ 4648.229043] Workqueue: writeback wb_workfn (flush-8:16)
[ 4648.229047] RIP: 0010:mb_find_order_for_block+0x66/0xa0
[ 4648.229050] Code: 8b 80 d0 02 00 00 42 0f b7 04 00 48 01 f0 48 89 c6 41 =
89
f9 c1 e0 03 83 e0 38 41 d3 f9 48 83 e6 f8 44 01 c8 48 98 48 0f a3 06 <73> 2=
7 0f
b7 42 30 83 c1 01 83 c0 01 39 c1 7f 17 48 8b 42 18 48 8b
[ 4648.229052] RSP: 0018:ffffc90001f076c8 EFLAGS: 00000203
[ 4648.229053] RAX: 0000000000000138 RBX: ffffc90001f07730 RCX:
0000000000000006
[ 4648.229054] RDX: ffffc90001f077d0 RSI: ffff88810a7e2f80 RDI:
0000000000004e30
[ 4648.229055] RBP: 0000000000007ff0 R08: 000000000000000c R09:
0000000000000138
[ 4648.229056] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8881049f7800
[ 4648.229056] R13: 0000000000000001 R14: 0000000000007ff0 R15:
ffffc90001f077d0
[ 4648.229057] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 4648.229059] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4648.229060] CR2: 00007f23b3ffc3a0 CR3: 000000023ba2a001 CR4:
00000000001706e0
[ 4648.229060] Call Trace:
[ 4648.229061]  <NMI>
[ 4648.229062]  ? nmi_cpu_backtrace+0x88/0xf0
[ 4648.229064]  ? nmi_cpu_backtrace_handler+0xc/0x20
[ 4648.229065]  ? nmi_handle+0x53/0xf0
[ 4648.229068]  ? default_do_nmi+0x40/0x220
[ 4648.229070]  ? exc_nmi+0xf3/0x120
[ 4648.229072]  ? end_repeat_nmi+0x16/0x67
[ 4648.229075]  ? mb_find_order_for_block+0x66/0xa0
[ 4648.229077]  ? mb_find_order_for_block+0x66/0xa0
[ 4648.229079]  ? mb_find_order_for_block+0x66/0xa0
[ 4648.229081]  </NMI>
[ 4648.229081]  <TASK>
[ 4648.229081]  mb_find_extent+0xd7/0x200
[ 4648.229084]  ext4_mb_scan_aligned+0xd3/0x140
[ 4648.229086]  ? ext4_get_group_info+0x4b/0x60
[ 4648.229088]  ext4_mb_regular_allocator+0xcca/0xe50
[ 4648.229090]  ? mempool_alloc+0x58/0x180
[ 4648.229093]  ext4_mb_new_blocks+0x8c6/0xe80
[ 4648.229094]  ? ext4_find_extent+0x3c1/0x410
[ 4648.229096]  ext4_ext_map_blocks+0x626/0x15c0
[ 4648.229099]  ? filemap_get_folios_tag+0x1c6/0x1f0
[ 4648.229100]  ? mpage_prepare_extent_to_map+0x462/0x4a0
[ 4648.229102]  ext4_map_blocks+0x18b/0x5f0
[ 4648.229104]  ? kmem_cache_alloc+0x278/0x410
[ 4648.229106]  ? ext4_alloc_io_end_vec+0x19/0x50
[ 4648.229109]  ext4_do_writepages+0x619/0xa90
[ 4648.229111]  ext4_writepages+0xa8/0x180
[ 4648.229113]  do_writepages+0xc6/0x190
[ 4648.229115]  __writeback_single_inode+0x2c/0x1a0
[ 4648.229117]  writeback_sb_inodes+0x1e8/0x450
[ 4648.229119]  __writeback_inodes_wb+0x47/0xe0
[ 4648.229121]  wb_writeback.isra.0+0x159/0x1b0
[ 4648.229123]  wb_workfn+0x269/0x380
[ 4648.229125]  ? __schedule+0x2ca/0x1110
[ 4648.229127]  ? __mod_timer+0x116/0x370
[ 4648.229130]  process_one_work+0x12f/0x240
[ 4648.229132]  worker_thread+0x2f0/0x410
[ 4648.229134]  ? __pfx_worker_thread+0x10/0x10
[ 4648.229136]  kthread+0xe3/0x110
[ 4648.229138]  ? __pfx_kthread+0x10/0x10
[ 4648.229139]  ret_from_fork+0x2f/0x50
[ 4648.229141]  ? __pfx_kthread+0x10/0x10
[ 4648.229142]  ret_from_fork_asm+0x1b/0x30
[ 4648.229145]  </TASK>
[ 4648.229145] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.229149] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x62/0=
xb0
[ 4648.229151] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x62/0=
xb0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
