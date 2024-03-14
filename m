Return-Path: <linux-ext4+bounces-1649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5B87BF3E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355D81C21491
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3670CDB;
	Thu, 14 Mar 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chbdKjSP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D870CCC
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427594; cv=none; b=CUF9Hs/+75tb3YeAtl6uUB7ZdvyrHT0k3ZvlADEWjECa6bOndcPe4SO90pnix0DOyDxX6eyQZv5TIl0auNU7ZUNArFktA9QwpkfUQkHNoDJhCkK3C4Sp0j7oTc6ZsJLfrkw3DagGO+WUUpr4MYAIlcyn6Kpk4lqL7BCCnEA3DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427594; c=relaxed/simple;
	bh=GW48w3HOfAeh9EcH5HxWw7mw0O77wMzmrUXOS982YyY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eHWLG2iFkSF0cNqKPnVBNj91BgFcNFKXX1lhGcTuT7qrEZ4kQUG9jHD+KFbqbTKSeOWov3GHFw0+QbobaeD4ZHs2r1m1uCdx0/PfalenY5byAICzv/474VaEZMzQ2jGnRGj+4bgNcjaCJEYJo/DKPPAg86RSqEEO86UIFaKWQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chbdKjSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AE56C433F1
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427594;
	bh=GW48w3HOfAeh9EcH5HxWw7mw0O77wMzmrUXOS982YyY=;
	h=From:To:Subject:Date:From;
	b=chbdKjSP0/JIK2hCLbaBIrPGuXMb4cw7uOfucZD3+KYIthVfJ5o4p9vfBx58iT2As
	 BLrvuV5NGJfZ8GV7x9WuLAG7FyEsUQD4GQmct+BFysRWB5hDR+8yKM0Remp8FcLyBd
	 I31kJCzkKxAcOCt9Ocle+FS4FmosRdu3IkmsMI0P84C3UO0n6pSqmWxMYZFOBCGF2h
	 tVkWx9TMDRojV1lnuA0xxav+4Wkf6Vfk0zXm2WTY/FeNhLzDVebuKWiOIvnlAoiVcZ
	 eFOSs/PSdNAw7Ft3vnPuEvIVyO8jdIxG678SiAoUSG9gYMn+Z17VSZIV54FhFR6013
	 2O0lb/5E9/58Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5186CC53BD0; Thu, 14 Mar 2024 14:46:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218596] New: kernel BUG at fs/ext4/extents_status.c:884
Date: Thu, 14 Mar 2024 14:46:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218596-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218596

            Bug ID: 218596
           Summary: kernel BUG at fs/ext4/extents_status.c:884
           Product: File System
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: antony.ambrose@in.bosch.com
        Regression: No

Working with a 5.4.233 on aarch64 (Qualcomm/Android) platform we get the sa=
me
error as https://bugzilla.kernel.org/show_bug.cgi?id=3D205197 . I am able to
reliably reproduce this problem even after applying the patch #1 mentioned =
in
205197.Could you please let me know what additional information required ?
As the partition is FBE encrypted , I am not able to look at the hex dump to
check the nature corruption.I tried to use the same bug 205197 to get some
clarification as the status of the bug is still open. Seems, it is not gett=
ing
noticed and I am trying to file bug newly.


[   23.857143] kernel BUG at fs/ext4/extents_status.c:884!
[   23.861696] [drm-dp] dp_power_clk_enable: core:on link:on strm0:off
strm1:off
[   23.862512] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   23.872824] [drm-dp] Req (VxPx): 0001 0000 0000 0000
[   23.875458] Modules linked in: pci_msm_drv machine_dlkm hdmi_dlkm stub_d=
lkm
native_dlkm platform_dlkm q6_dlkm adsp_loader_dlkm apr_dlkm q6_notifier_dlkm
snd_event_dlkm
[   23.875469] CPU: 7 PID: 821 Comm: Binder:700_3 Tainted: G S=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.875471] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   23.875479] pc : ext4_es_cache_extent+0x1c0/0x1ec
[   23.875485] lr : __read_extent_tree_block+0x1d8/0x304
[   23.881544] [drm-dp] Req (VxPx): 0002 0000 0000 0000
[   23.905806] sp : ffffffc0182f3600
[   23.905807] x29: ffffffc0182f3640 x28: ffffffea4bdd8c40=20
[   23.905808] x27: 0000000000a1940a x26: 0000000000a1940a=20
[   23.905809] x25: 0000000000000001 x24: ffffffb041d3302c=20
[   23.905810] x23: 00000000000091e6 x22: 00000000dde7b5ea=20
[   23.905811] x21: 00000000dde7b5eb x20: 00000000e77d84a7=20
[   23.905811] x19: ffffffb043ba2fe0 x18: ffffffc0159450a8=20
[   23.905812] x17: 0000000005f5e100 x16: 0000000000b6b803=20
[   23.905813] x15: ffffffffff6a9d3b x14: 0000000000f42400=20
[   23.905814] x13: ffffffae98738800 x12: ffffffc629fea000=20
[   23.905815] x11: ffffffea4dc12b60 x10: 0000000000000001=20
[   23.905816] x9 : 00000000ffffa0a4 x8 : 00000000dde7b5eb=20
[   23.905817] x7 : 0000000000000000 x6 : ffffffc01742d01a=20
[   23.905818] x5 : 0000000000000002 x4 : 0000000000000008=20
[   23.905818] x3 : 47ffffffffffffff x2 : 00000000f66a3144=20
[   23.905819] x1 : 00000000e77d84a7 x0 : ffffffb043ba2fe0=20
[   23.905821] Call trace:
[   23.905822]  ext4_es_cache_extent+0x1c0/0x1ec
[   23.905823]  __read_extent_tree_block+0x1d8/0x304
[   23.905825]  ext4_find_extent+0x278/0x3c4
[   23.905827]  ext4_ext_map_blocks+0x88/0xd7c
[   23.916597] [drm-dp] dp_ctrl_link_train: DP0 link training #1 failed
[   23.920913]  ext4_map_blocks+0xec/0x600
[   23.920915]  _ext4_get_block.llvm.15760302090761801784+0x6c/0x194
[   23.920916]  ext4_get_block+0x18/0x24
[   23.920918]  generic_block_bmap+0x74/0xcc
[   23.920920]  ext4_bmap+0xc8/0xf8
[   23.920922]  bmap+0x44/0x94
[   23.920925]  jbd2_journal_init_inode+0x1c/0xec
[   23.920926]  ext4_fill_super+0x1904/0x2f68
[   23.920927]  mount_bdev+0x178/0x1d8
[   23.920928]  ext4_mount+0x18/0x24
[   23.920930]  legacy_get_tree+0x4c/0xac
[   23.920931]  vfs_get_tree+0x4c/0x118
[   23.920932]  do_mount+0x6c0/0xcdc
[   23.920934]  ksys_mount+0x98/0xdc
[   23.926536] [drm-dp] dp_power_clk_enable: core:on link:off strm0:off
strm1:off
[   23.940491]  __arm64_sys_mount+0x20/0x30
[   23.940494]  el0_svc_common+0xc4/0x1ac
[   23.940495]  el0_svc_handler+0x24/0x84
[   23.940498]  el0_svc+0x8/0x300
[   23.940500] Code: f2f3a6c0 aa1503e1 97f9d5e0 17fffff3 (d4210000)=20
[   23.940501] ---[ end trace ecc3d66169b078eb ]---
[   23.947204] Kernel panic - not syncing: Fatal exception
[   23.977716] [drm-dp] dp_power_clk_enable: core:on link:on strm0:off
strm1:off
[   23.991257] SMP: stopping secondary CPUs
[   23.991262] CPU4: stopping
[   23.991266] CPU: 4 PID: 273 Comm: kworker/u16:12 Tainted: G S    D=20=20=
=20=20=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991272] Workqueue: memlat_wq 0xffffffea4b8a9da8
[   23.991274] pstate: 20c00005 (nzCv daif +PAN +UAO)
[   23.991281] pc : smp_call_function_single+0xf4/0x1c0
[   23.991282] lr : smp_call_function_single+0xc8/0x1c0
[   23.991283] sp : ffffffc017713ba0
[   23.991283] x29: ffffffc017713bf0 x28: 0000000000000070=20
[   23.991285] x27: 0000000000000064 x26: ffffffb0559aec80=20
[   23.991287] x25: 0000000000000001 x24: ffffffaecc2af410=20
[   23.991288] x23: 0000000000000000 x22: ffffffaecc2af400=20
[   23.991289] x21: ffffffc017713d10 x20: ffffffb052943f00=20
[   23.991290] x19: 0000000000000000 x18: ffffffc01767b040=20
[   23.991291] x17: 0000000005f5e100 x16: 00000000000023db=20
[   23.991293] x15: ffffffffffff5ee5 x14: 0000000000f42400=20
[   23.991294] x13: 00000002c03bfad4 x12: 0000000000000000=20
[   23.991295] x11: 0000000000000001 x10: 0000000000000000=20
[   23.991297] x9 : 0000000000000003 x8 : ffffffc017713bb8=20
[   23.991298] x7 : 0000000000000000 x6 : 00000000ffffffff=20
[   23.991299] x5 : 0000000000000002 x4 : 0000000000000080=20
[   23.991300] x3 : ffffffc017713c10 x2 : 0000000000000008=20
[   23.991301] x1 : 0000000000000020 x0 : 0000000000000000=20
[   23.991303] CPU: 4 PID: 273 Comm: kworker/u16:12 Tainted: G S    D=20=20=
=20=20=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991305] Workqueue: memlat_wq 0xffffffea4b8a9da8
[   23.991307] Call trace:
[   23.991307]  0xffffffea4b886ea8
[   23.991313]  show_stack+0x18/0x24
[   23.991315]  dump_stack+0xc8/0x104
[   23.991317]  local_cpu_stop+0xac/0xb8
[   23.991319]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991323]  gic_handle_irq+0xc8/0x148
[   23.991324]  el1_irq+0x104/0x200
[   23.991326]  smp_call_function_single+0xf4/0x1c0
[   23.991329]  perf_event_read+0x1f4/0x258
[   23.991331]  __perf_event_read_value+0x44/0x10c
[   23.991332]  perf_event_read_value+0x38/0x64
[   23.991334]  memlat_monitor_work+0x268/0x5d0
[   23.991336]  process_one_work+0x204/0x540
[   23.991338]  worker_thread+0x290/0x4fc
[   23.991340]  kthread+0x150/0x188
[   23.991342]  ret_from_fork+0x10/0x18
[   23.991343] CPU5: stopping
[   23.991346] CPU: 5 PID: 461 Comm: init.ccs20.net. Tainted: G S    D=20=
=20=20=20=20=20=20=20=20
 5.4.233-qgki-g9f4640c93f61 #1

[   23.991348] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   23.991353] pc : __vma_link_rb+0xe0/0x180
[   23.991354] lr : __vma_link_rb+0xc4/0x180
[   23.991355] sp : ffffffc01d12bbe0
[   23.991355] x29: ffffffc01d12bbe0 x28: ffffffb04fad3a40=20
[   23.991357] x27: 0000000000000021 x26: ffffffb040d3d3b0=20
[   23.991358] x25: ffffffb040d3db50 x24: ffffffea4dfd0000=20
[   23.991359] x23: ffffffb040d3db50 x22: ffffffb04f28d298=20
[   23.991360] x21: ffffffb040d3db58 x20: ffffffb04f28d280=20
[   23.991362] x19: ffffffb040d3d3d0 x18: ffffffc01d12d040=20
[   23.991363] x17: ffffffea4e10a2f0 x16: 0000000000000000=20
[   23.991364] x15: 0000000000000005 x14: 0000000000000000=20
[   23.991365] x13: 0000007fb33fd000 x12: 0000000000000008=20
[   23.991367] x11: ffffffb040d2b971 x10: 0000007fb34c5000=20
[   23.991368] x9 : ffffffb040d2b970 x8 : 0000000000100000=20
[   23.991369] x7 : 0000000000000000 x6 : ffffffb040d3d4a0=20
[   23.991370] x5 : 0000000000000040 x4 : 0000000000000000=20
[   23.991371] x3 : ffffffb040d3db50 x2 : 00000000000000ff=20
[   23.991372] x1 : 0000000000000000 x0 : 0000000000000000=20
[   23.991375] CPU: 5 PID: 461 Comm: init.ccs20.net. Tainted: G S    D=20=
=20=20=20=20=20=20=20=20
 5.4.233-qgki-g9f4640c93f61 #1


[   23.991402]  el0_svc+0x8/0x300
[   23.991405] CPU1: stopping
[   23.991410] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991415] pstate: a0c00005 (NzCv daif +PAN +UAO)
[   23.991422] pc : lpm_cpuidle_enter+0x334/0x504
[   23.991425] lr : lpm_cpuidle_enter+0x2ac/0x504
[   23.991426] sp : ffffffc01020be20
[   23.991428] x29: ffffffc01020be30 x28: ffffffb0559ab4b8=20
[   23.991432] x27: ffffffea4dee0710 x26: 00000003726d5218=20
[   23.991434] x25: 0000000000000001 x24: 0000000000000000=20
[   23.991437] x23: ffffffea4d7f8130 x22: ffffffb055942880=20
[   23.991440] x21: ffffffb055942f40 x20: ffffffb0559ab480=20
[   23.991443] x19: 0000000000000000 x18: ffffffc0100cd038=20
[   23.991445] x17: 0000000005f5e100 x16: 0000000000000001=20
[   23.991448] x15: 0000000000000916 x14: 00000000003d16d6=20
[   23.991451] x13: 0000000000001660 x12: 0000000034155555=20
[   23.991453] x11: 002fec10fa5a4c00 x10: 0000000000000018=20
[   23.991456] x9 : 0000000100000001 x8 : 00000000000000e0=20
[   23.991458] x7 : 0000000000000000 x6 : 0000000000000000=20
[   23.991461] x5 : 0000000000000001 x4 : 00000003726d5218=20
[   23.991463] x3 : 0000000000000001 x2 : 0000000000000001=20
[   23.991466] x1 : 0000000000000080 x0 : fffffffc8d92a86a=20
[   23.991470] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991473] Call trace:
[   23.991475]  0xffffffea4b886ea8
[   23.991478]  show_stack+0x18/0x24
[   23.991481]  dump_stack+0xc8/0x104
[   23.991483]  local_cpu_stop+0xac/0xb8
[   23.991486]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991490]  gic_handle_irq+0xc8/0x148
[   23.991492]  el1_irq+0x104/0x200
[   23.991495]  lpm_cpuidle_enter+0x334/0x504
[   23.991501]  cpuidle_enter_state+0x11c/0x2e0
[   23.991504]  cpuidle_enter+0x38/0x50
[   23.991509]  cpuidle_idle_call+0x198/0x29c
[   23.991511]  do_idle.llvm.119348122938150798+0xc0/0x120
[   23.991514]  cpu_startup_entry+0x24/0x28
[   23.991516]  secondary_start_kernel+0x170/0x1b4
[   23.991519] CPU6: stopping
[   23.991521] CPU: 6 PID: 239 Comm: kworker/u16:2 Tainted: G S    D=20=20=
=20=20=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991526] Workqueue: drm_dp 0xffffffea4b8aa0b0
[   23.991528] pstate: 40400005 (nZcv daif +PAN -UAO)
[   23.991531] pc : __do_softirq+0xbc/0x474
[   23.991533] lr : __do_softirq+0x78/0x474
[   23.991533] sp : ffffffc010033f00
[   23.991534] x29: ffffffc010033f20 x28: 0000000000000082=20
[   23.991535] x27: 0000000000000000 x26: ffffffea4b88f2f4=20
[   23.991537] x25: ffffffea4ded60c0 x24: 0000000000000000=20
[   23.991538] x23: 0000000000000000 x22: ffffffea4dc098c0=20
[   23.991539] x21: ffffffea4dbf6c60 x20: 0000000000000000=20
[   23.991541] x19: ffffffb055463f00 x18: ffffffc010035020=20
[   23.991542] x17: 00002212de872990 x16: 0000000000000001=20
[   23.991543] x15: 0000000000000010 x14: 0000000000000010=20
[   23.991544] x13: 0000000000000004 x12: 0000000010f0fc67=20
[   23.991545] x11: 0000000000000001 x10: 0000000000000001=20
[   23.991546] x9 : 000000000000000a x8 : 00000000000000e0=20
[   23.991547] x7 : 646c68735e676271 x6 : 0080000000000000=20
[   23.991548] x5 : 0000000000010001 x4 : 0000000000000080=20
[   23.991549] x3 : 0000000000000010 x2 : 000000000000009d=20
[   23.991550] x1 : ffffffb055463f00 x0 : 00000003726d73a9=20
[   23.991552] CPU: 6 PID: 239 Comm: kworker/u16:2 Tainted: G S    D=20=20=
=20=20=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991555] Workqueue: drm_dp 0xffffffea4b8aa0b0
[   23.991556] Call trace:
[   23.991557]  0xffffffea4b886ea8
[   23.991559]  show_stack+0x18/0x24
[   23.991560]  dump_stack+0xc8/0x104
[   23.991562]  local_cpu_stop+0xac/0xb8
[   23.991563]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991565]  gic_handle_irq+0xc8/0x148
[   23.991567]  el1_irq+0x104/0x200
[   23.991568]  __do_softirq+0xbc/0x474
[   23.991571]  irq_exit+0xc8/0xcc
[   23.991573]  __handle_domain_irq+0xa8/0x100
[   23.991575]  gic_handle_irq+0x5c/0x148
[   23.991577]  el1_irq+0x104/0x200
[   23.991578]  vprintk_emit+0x180/0x308
[   23.991579]  vprintk_default+0x48/0x70
[   23.991581]  vprintk_func+0x1bc/0x1f8
[   23.991583]  printk+0x74/0xa0
[   23.991586]  dp_power_clk_enable+0x290/0x2e0
[   23.991588]  dp_ctrl_on+0x248/0x64c
[   23.991590]  dp_display_process_hpd_high+0x188/0x298
[   23.991592]  dp_display_connect_work+0x154/0x2d0
[   23.991594]  process_one_work+0x204/0x540
[   23.991595]  worker_thread+0x290/0x4fc
[   23.991597]  kthread+0x150/0x188
[   23.991598]  ret_from_fork+0x10/0x18
[   23.991601] CPU3: stopping
[   23.991606] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991610] pstate: a0c00005 (NzCv daif +PAN +UAO)
[   23.991615] pc : lpm_cpuidle_enter+0x334/0x504
[   23.991619] lr : lpm_cpuidle_enter+0x2ac/0x504
[   23.991620] sp : ffffffc01021be20
[   23.991621] x29: ffffffc01021be30 x28: ffffffb0559ab4b8=20
[   23.991625] x27: ffffffea4dee0710 x26: 00000003726d55c2=20
[   23.991628] x25: 0000000000000001 x24: 0000000000000000=20
[   23.991630] x23: ffffffea4d7f8140 x22: ffffffb055942880=20
[   23.991633] x21: ffffffb055942f40 x20: ffffffb0559ab480=20
[   23.991636] x19: 0000000000000000 x18: ffffffc0100dd038=20
[   23.991639] x17: 0000000005f5e100 x16: 0000000000000001=20
[   23.991641] x15: 0000000000000a81 x14: 00000000003d25b0=20
[   23.991644] x13: 0000000000001660 x12: 0000000034155555=20
[   23.991646] x11: 002fec10fa5a4c00 x10: 0000000000000018=20
[   23.991649] x9 : 0000000100000001 x8 : 00000000000000e0=20
[   23.991651] x7 : 0000000000000000 x6 : 0000000000000000=20
[   23.991654] x5 : 0000000000000001 x4 : 00000003726d55c2=20
[   23.991656] x3 : 0000000000000001 x2 : 0000000000000001=20
[   23.991659] x1 : 0000000000000080 x0 : fffffffc8d92a528=20
[   23.991663] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991666] Call trace:
[   23.991668]  0xffffffea4b886ea8
[   23.991671]  show_stack+0x18/0x24
[   23.991674]  dump_stack+0xc8/0x104
[   23.991677]  local_cpu_stop+0xac/0xb8
[   23.991680]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991683]  gic_handle_irq+0xc8/0x148
[   23.991686]  el1_irq+0x104/0x200
[   23.991689]  lpm_cpuidle_enter+0x334/0x504
[   23.991692]  cpuidle_enter_state+0x11c/0x2e0
[   23.991695]  cpuidle_enter+0x38/0x50
[   23.991698]  cpuidle_idle_call+0x198/0x29c
[   23.991701]  do_idle.llvm.119348122938150798+0xc0/0x120
[   23.991703]  cpu_startup_entry+0x24/0x28
[   23.991706]  secondary_start_kernel+0x170/0x1b4
[   23.991710] CPU2: stopping
[   23.991715] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991720] pstate: a0c00005 (NzCv daif +PAN +UAO)
[   23.991724] pc : lpm_cpuidle_enter+0x334/0x504
[   23.991727] lr : lpm_cpuidle_enter+0x2ac/0x504
[   23.991729] sp : ffffffc010213e20
[   23.991730] x29: ffffffc010213e30 x28: ffffffb0559ab4b8=20
[   23.991734] x27: ffffffea4dee0710 x26: 00000003726d54bd=20
[   23.991737] x25: 0000000000000001 x24: 0000000000000000=20
[   23.991740] x23: ffffffea4d7f8138 x22: ffffffb055942880=20
[   23.991743] x21: ffffffb055942f40 x20: ffffffb0559ab480=20
[   23.991746] x19: 0000000000000000 x18: ffffffc0100d5038=20
[   23.991749] x17: 0000000005f5e100 x16: 0000000000000002=20
[   23.991751] x15: 0000000000000921 x14: 00000000003d0c75=20
[   23.991754] x13: 0000000000001660 x12: 0000000034155555=20
[   23.991756] x11: 002fec10fa5a4c00 x10: 0000000000000018=20
[   23.991759] x9 : 0000000100000001 x8 : 00000000000000e0=20
[   23.991761] x7 : 0000000000000000 x6 : 0000000000000000=20
[   23.991764] x5 : 0000000000000001 x4 : 00000003726d54bd=20
[   23.991766] x3 : 0000000000000001 x2 : 0000000000000001=20
[   23.991769] x1 : 0000000000000080 x0 : fffffffc8d92a21b=20
[   23.991773] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991776] Call trace:
[   23.991778]  0xffffffea4b886ea8
[   23.991781]  show_stack+0x18/0x24
[   23.991784]  dump_stack+0xc8/0x104
[   23.991786]  local_cpu_stop+0xac/0xb8
[   23.991789]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991793]  gic_handle_irq+0xc8/0x148
[   23.991795]  el1_irq+0x104/0x200
[   23.991798]  lpm_cpuidle_enter+0x334/0x504
[   23.991801]  cpuidle_enter_state+0x11c/0x2e0
[   23.991804]  cpuidle_enter+0x38/0x50
[   23.991806]  cpuidle_idle_call+0x198/0x29c
[   23.991809]  do_idle.llvm.119348122938150798+0xc0/0x120
[   23.991811]  cpu_startup_entry+0x24/0x28
[   23.991814]  secondary_start_kernel+0x170/0x1b4
[   23.991818] CPU0: stopping
[   23.991823] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991828] pstate: a0c00005 (NzCv daif +PAN +UAO)
[   23.991833] pc : lpm_cpuidle_enter+0x334/0x504
[   23.991836] lr : lpm_cpuidle_enter+0x2ac/0x504
[   23.991837] sp : ffffffc0100f3e20
[   23.991839] x29: ffffffc0100f3e30 x28: ffffffb0559ab4b8=20
[   23.991842] x27: ffffffea4dee0710 x26: 00000003726d6538=20
[   23.991846] x25: 0000000000000000 x24: 00000000fffffff0=20
[   23.991849] x23: ffffffea4d7f8128 x22: ffffffb055942880=20
[   23.991851] x21: ffffffb055942f40 x20: ffffffb0559ab480=20
[   23.991854] x19: 0000000000000000 x18: ffffffc0100c5038=20
[   23.991857] x17: 0000000005f5e100 x16: 0000000000000000=20
[   23.991859] x15: 0000000000001c54 x14: 00000000003d18df=20
[   23.991862] x13: 0000000000001660 x12: 0000000034155555=20
[   23.991864] x11: 002fec10fa5a4c00 x10: 0000000000000018=20
[   23.991867] x9 : 0000000100000001 x8 : 00000000000000e0=20
[   23.991870] x7 : 0000000000000000 x6 : ffffffc014f3bb50=20
[   23.991872] x5 : 0000000000000000 x4 : 00000003726d6538=20
[   23.991875] x3 : 0000000000000001 x2 : 0000000000000001=20
[   23.991877] x1 : 0000000000000080 x0 : fffffffc8d9297ef=20
[   23.991881] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S    D=20=20=20=20=
=20=20=20=20=20=20
5.4.233-qgki-g9f4640c93f61 #1

[   23.991885] Call trace:
[   23.991886]  0xffffffea4b886ea8
[   23.991890]  show_stack+0x18/0x24
[   23.991892]  dump_stack+0xc8/0x104
[   23.991895]  local_cpu_stop+0xac/0xb8
[   23.991898]  trace_ipi_entry_rcuidle+0x0/0x13c
[   23.991901]  gic_handle_irq+0xc8/0x148
[   23.991904]  el1_irq+0x104/0x200
[   23.991907]  lpm_cpuidle_enter+0x334/0x504
[   23.991910]  cpuidle_enter_state+0x11c/0x2e0
[   23.991913]  cpuidle_enter+0x38/0x50
[   23.991915]  cpuidle_idle_call+0x198/0x29c
[   23.991918]  do_idle.llvm.119348122938150798+0xc0/0x120
[   23.991920]  cpu_startup_entry+0x24/0x28
[   23.991923]  secondary_start_kernel+0x170/0x1b4
[   23.991932] kgsl kgsl-3d0: snapshot: device is powered off
[   24.592004] Kernel Offset: 0x2a3b800000 from 0xffffffc010000000
[   24.592005] PHYS_OFFSET: 0xffffffd200000000
[   24.592006] CPU features: 0x00010002,6b02a238
[   24.592007] Memory Limit: none
[   24.592010] qcom-ethqos: ethqos 0x00000000ea115430
[   24.592011] qcom-ethqos: stmmac_priv 0x0000000021c5b0a7
[   24.592012] qcom-ethqos: emac iommu domain 0x000000003234c89c
[   24.592013] qcom-ethqos: emac register mem 0x0000000059fc7e2e
[   24.592561] qcom-ethqos: rgmii register mem 0x00000000f8848266
[   26.232388] Triggering late bite
[   26.235708] msm_watchdog 17c10000.qcom,wdt: Causing a QCOM Apps Watchdog
bite!
[   26.243124] msm_watchdog 17c10000.qcom,wdt: Wdog - STS: 0x24038, CTL: 0x=
3,
BARK TIME: 0x47fe5, BITE TIME: 0x47fe5

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

