Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271F7C9821
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Oct 2023 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJOGS1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Oct 2023 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOGS1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Oct 2023 02:18:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF6C5
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 23:18:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A43C433C9
        for <linux-ext4@vger.kernel.org>; Sun, 15 Oct 2023 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697350704;
        bh=rfeO9+Q/Y0iAnZolqJd0D2DXQ3BQ3W2FWSY15CMhc5k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q1itgAKYnW3JJyd4wBNMgQuzJC7p48mq+PEeb9k0JgLJ3B4IVfXwBsyv951+cidqa
         Is8xzXLccfy7StDTDpqB61fRbuwlUbFuZ4O41VGuRqX3vux70netzmwBIM1VWH6xdW
         8T3IrnBaRHgSWW/flCGIomR80MoaipIi8rMdby+ovoH0fMAkP4+ZJZ4hOvqOgBQyot
         6sMB587t9dj2uYE6jck61j0o1Zv8Kv+UCaecOlpxN4rLS9u2kCw7h9m5sBRJLgW5oK
         hFe/tFZ72jteWip47rBKP3zoNihssD68290mphIKW1i0T+0DOyJ8bqM94SzxSx4bSq
         dPZFuzHCVWD1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EC221C4332E; Sun, 15 Oct 2023 06:18:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sun, 15 Oct 2023 06:18:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaak+bugzilla.kernel.org@ristioja.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218011-13602-fnSBwM4UWQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

--- Comment #4 from jaak+bugzilla.kernel.org@ristioja.ee ---
However, the issue seems to occur on the newly-created root as well:

[21381.865721] INFO: task CPU 0/KVM:7834 blocked for more than 122 seconds.
[21381.865739]       Tainted: G                T  6.5.7-custom #14
[21381.865744] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21381.865748] task:CPU 0/KVM       state:D stack:0     pid:7834  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21381.865761] Call Trace:
[21381.865767]  <TASK>
[21381.865770]  __schedule+0x280/0xff0
[21381.865790]  schedule+0x52/0xa0
[21381.865800]  jbd2_log_wait_commit+0xd7/0x150
[21381.865809]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.865822]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21381.865834]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21381.865843]  add_transaction_credits+0x2e6/0x2f0
[21381.865851]  start_this_handle+0xfc/0x5b0
[21381.865858]  ? kmem_cache_alloc+0x15d/0x2a0
[21381.865867]  jbd2__journal_start+0x125/0x1b0
[21381.865874]  ext4_page_mkwrite+0x346/0x550
[21381.865883]  do_page_mkwrite+0x52/0xe0
[21381.865895]  do_wp_page+0xf3/0xcc0
[21381.865907]  ? vmx_vcpu_load+0x1c/0x50
[21381.865917]  ? kvm_arch_vcpu_load+0x65/0x210
[21381.865928]  __handle_mm_fault+0x2e1/0x2f0
[21381.865938]  handle_mm_fault+0x106/0x300
[21381.865948]  __get_user_pages+0x1f5/0x360
[21381.865957]  get_user_pages_unlocked+0xcd/0x280
[21381.865966]  hva_to_pfn+0xe9/0x420
[21381.865973]  kvm_faultin_pfn+0xa5/0x3d0
[21381.865984]  kvm_tdp_page_fault+0x127/0x180
[21381.865991]  kvm_mmu_page_fault+0x295/0x760
[21381.865999]  ? sysvec_call_function+0xe/0x90
[21381.866011]  ? vmx_vmexit+0x7d/0xd0
[21381.866018]  ? vmx_vmexit+0x77/0xd0
[21381.866025]  ? vmx_vmexit+0x9e/0xd0
[21381.866031]  vmx_handle_exit+0x12b/0x770
[21381.866040]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21381.866050]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21381.866061]  __x64_sys_ioctl+0x530/0xa70
[21381.866069]  do_syscall_64+0x60/0x90
[21381.866077]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21381.866091] RIP: 0033:0x7f4b9c513f9f
[21381.866098] RSP: 002b:00007f4b9a25d8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21381.866106] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21381.866111] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000018
[21381.866115] RBP: 000055764903b770 R08: 000055764716dea0 R09:
0000000000000640
[21381.866119] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[21381.866123] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[21381.866127]  </TASK>
[21381.866130] INFO: task CPU 1/KVM:7835 blocked for more than 122 seconds.
[21381.866135]       Tainted: G                T  6.5.7-custom #14
[21381.866139] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21381.866141] task:CPU 1/KVM       state:D stack:0     pid:7835  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21381.866149] Call Trace:
[21381.866152]  <TASK>
[21381.866154]  __schedule+0x280/0xff0
[21381.866164]  schedule+0x52/0xa0
[21381.866172]  jbd2_log_wait_commit+0xd7/0x150
[21381.866178]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866189]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21381.866198]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21381.866208]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866217]  add_transaction_credits+0x2e6/0x2f0
[21381.866224]  ? ext4_mark_iloc_dirty+0x202/0x5d0
[21381.866230]  start_this_handle+0xfc/0x5b0
[21381.866237]  ? kmem_cache_alloc+0x15d/0x2a0
[21381.866244]  jbd2__journal_start+0x125/0x1b0
[21381.866251]  ext4_dirty_inode+0x36/0x90
[21381.866258]  __mark_inode_dirty+0x4e/0x220
[21381.866269]  generic_update_time+0x80/0xd0
[21381.866279]  file_update_time+0xc7/0xe0
[21381.866288]  ext4_page_mkwrite+0x93/0x550
[21381.866295]  do_page_mkwrite+0x52/0xe0
[21381.866303]  do_wp_page+0xf3/0xcc0
[21381.866312]  __handle_mm_fault+0x2e1/0x2f0
[21381.866322]  handle_mm_fault+0x106/0x300
[21381.866333]  __get_user_pages+0x1f5/0x360
[21381.866340]  get_user_pages_unlocked+0xcd/0x280
[21381.866348]  hva_to_pfn+0xe9/0x420
[21381.866354]  kvm_faultin_pfn+0xa5/0x3d0
[21381.866362]  kvm_tdp_page_fault+0x127/0x180
[21381.866369]  kvm_mmu_page_fault+0x295/0x760
[21381.866375]  ? __check_object_size+0x53/0x2d0
[21381.866385]  vmx_handle_exit+0x12b/0x770
[21381.866394]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21381.866402]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21381.866411]  __x64_sys_ioctl+0x530/0xa70
[21381.866417]  do_syscall_64+0x60/0x90
[21381.866425]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21381.866434] RIP: 0033:0x7f4b9c513f9f
[21381.866439] RSP: 002b:00007f4b99a5c8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21381.866444] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21381.866448] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000019
[21381.866452] RBP: 000055764906ce40 R08: 000055764716dea0 R09:
00007f4a88003010
[21381.866455] R10: 0000000000000100 R11: 0000000000000246 R12:
0000000000000000
[21381.866459] R13: 0000000000000000 R14: 00007ffcce9ee160 R15:
00007f4b9925d000
[21381.866463]  </TASK>
[21381.866465] INFO: task CPU 2/KVM:7836 blocked for more than 122 seconds.
[21381.866469]       Tainted: G                T  6.5.7-custom #14
[21381.866472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21381.866475] task:CPU 2/KVM       state:D stack:0     pid:7836  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21381.866481] Call Trace:
[21381.866484]  <TASK>
[21381.866486]  __schedule+0x280/0xff0
[21381.866495]  schedule+0x52/0xa0
[21381.866503]  jbd2_log_wait_commit+0xd7/0x150
[21381.866509]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866518]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21381.866527]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21381.866536]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866546]  add_transaction_credits+0x2e6/0x2f0
[21381.866552]  ? ext4_mark_iloc_dirty+0x202/0x5d0
[21381.866558]  start_this_handle+0xfc/0x5b0
[21381.866564]  ? kmem_cache_alloc+0x15d/0x2a0
[21381.866587]  jbd2__journal_start+0x125/0x1b0
[21381.866594]  ext4_dirty_inode+0x36/0x90
[21381.866600]  __mark_inode_dirty+0x4e/0x220
[21381.866609]  generic_update_time+0x80/0xd0
[21381.866617]  file_update_time+0xc7/0xe0
[21381.866626]  ext4_page_mkwrite+0x93/0x550
[21381.866632]  do_page_mkwrite+0x52/0xe0
[21381.866641]  do_wp_page+0xf3/0xcc0
[21381.866650]  __handle_mm_fault+0x2e1/0x2f0
[21381.866660]  handle_mm_fault+0x106/0x300
[21381.866670]  __get_user_pages+0x1f5/0x360
[21381.866678]  get_user_pages_unlocked+0xcd/0x280
[21381.866686]  hva_to_pfn+0xe9/0x420
[21381.866692]  kvm_faultin_pfn+0xa5/0x3d0
[21381.866700]  ? fast_page_fault+0xa8/0x510
[21381.866710]  kvm_tdp_page_fault+0x127/0x180
[21381.866715]  kvm_mmu_page_fault+0x295/0x760
[21381.866722]  ? __check_object_size+0x53/0x2d0
[21381.866731]  vmx_handle_exit+0x12b/0x770
[21381.866740]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21381.866748]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21381.866757]  __x64_sys_ioctl+0x530/0xa70
[21381.866764]  do_syscall_64+0x60/0x90
[21381.866771]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21381.866781] RIP: 0033:0x7f4b9c513f9f
[21381.866785] RSP: 002b:00007f4b9925b8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21381.866790] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21381.866794] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
000000000000001a
[21381.866797] RBP: 0000557649074f50 R08: 000055764716dea0 R09:
00000000000000ff
[21381.866801] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[21381.866804] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[21381.866808]  </TASK>
[21381.866811] INFO: task CPU 3/KVM:7837 blocked for more than 122 seconds.
[21381.866814]       Tainted: G                T  6.5.7-custom #14
[21381.866817] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21381.866820] task:CPU 3/KVM       state:D stack:0     pid:7837  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21381.866826] Call Trace:
[21381.866829]  <TASK>
[21381.866831]  __schedule+0x280/0xff0
[21381.866840]  schedule+0x52/0xa0
[21381.866848]  jbd2_log_wait_commit+0xd7/0x150
[21381.866854]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866863]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21381.866873]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21381.866881]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.866891]  add_transaction_credits+0x2e6/0x2f0
[21381.866897]  ? __wake_up_common_lock+0x8a/0xd0
[21381.866906]  start_this_handle+0xfc/0x5b0
[21381.866913]  ? kmem_cache_alloc+0x15d/0x2a0
[21381.866919]  jbd2__journal_start+0x125/0x1b0
[21381.866926]  ext4_page_mkwrite+0x346/0x550
[21381.866932]  do_page_mkwrite+0x52/0xe0
[21381.866941]  do_wp_page+0xf3/0xcc0
[21381.866950]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[21381.866961]  __handle_mm_fault+0x2e1/0x2f0
[21381.866971]  handle_mm_fault+0x106/0x300
[21381.866981]  __get_user_pages+0x1f5/0x360
[21381.866988]  get_user_pages_unlocked+0xcd/0x280
[21381.866996]  hva_to_pfn+0xe9/0x420
[21381.867001]  kvm_faultin_pfn+0xa5/0x3d0
[21381.867010]  ? psi_group_change+0x171/0x3c0
[21381.867020]  kvm_tdp_page_fault+0x127/0x180
[21381.867026]  kvm_mmu_page_fault+0x295/0x760
[21381.867033]  ? __check_object_size+0x53/0x2d0
[21381.867041]  vmx_handle_exit+0x12b/0x770
[21381.867049]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21381.867057]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21381.867066]  __x64_sys_ioctl+0x530/0xa70
[21381.867073]  do_syscall_64+0x60/0x90
[21381.867080]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21381.867089] RIP: 0033:0x7f4b9c513f9f
[21381.867093] RSP: 002b:00007f4b98a578e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21381.867098] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21381.867101] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
000000000000001b
[21381.867104] RBP: 000055764907cee0 R08: 000055764716dea0 R09:
0000000000000000
[21381.867108] R10: 0000000000000006 R11: 0000000000000246 R12:
0000000000000000
[21381.867111] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[21381.867115]  </TASK>
[21381.867121] INFO: task kworker/u8:1:8446 blocked for more than 122 secon=
ds.
[21381.867124]       Tainted: G                T  6.5.7-custom #14
[21381.867127] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21381.867129] task:kworker/u8:1    state:D stack:0     pid:8446  ppid:2=20=
=20=20=20=20
flags:0x00004000
[21381.867137] Workqueue: writeback wb_workfn (flush-259:0)
[21381.867150] Call Trace:
[21381.867153]  <TASK>
[21381.867155]  __schedule+0x280/0xff0
[21381.867172]  schedule+0x52/0xa0
[21381.867175]  jbd2_log_wait_commit+0xd7/0x150
[21381.867176]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.867179]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21381.867182]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21381.867185]  ? __pfx_autoremove_wake_function+0x10/0x10
[21381.867188]  add_transaction_credits+0x2e6/0x2f0
[21381.867190]  ? __wake_up_common_lock+0x8a/0xd0
[21381.867193]  start_this_handle+0xfc/0x5b0
[21381.867195]  ? stop_this_handle+0xf6/0x110
[21381.867197]  mpage_prepare_extent_to_map+0x2da/0x4e0
[21381.867201]  ext4_do_writepages+0x251/0xb40
[21381.867203]  ? update_sd_lb_stats.constprop.0+0x622/0x8c0
[21381.867206]  ext4_writepages+0x9e/0x160
[21381.867208]  do_writepages+0xc2/0x1e0
[21381.867211]  ? enqueue_entity+0x131/0x390
[21381.867215]  __writeback_single_inode+0x31/0x1a0
[21381.867218]  writeback_sb_inodes+0x1ee/0x450
[21381.867221]  __writeback_inodes_wb+0x47/0xf0
[21381.867224]  wb_writeback.isra.0+0x17c/0x1d0
[21381.867227]  wb_workfn+0x276/0x3c0
[21381.867229]  ? __schedule+0x288/0xff0
[21381.867232]  process_one_work+0x20a/0x3a0
[21381.867235]  worker_thread+0x4d/0x3d0
[21381.867237]  ? __pfx_worker_thread+0x10/0x10
[21381.867239]  kthread+0xce/0x100
[21381.867242]  ? __pfx_kthread+0x10/0x10
[21381.867244]  ret_from_fork+0x2f/0x50
[21381.867247]  ? __pfx_kthread+0x10/0x10
[21381.867249]  ret_from_fork_asm+0x1b/0x30
[21381.867251]  </TASK>
[21504.744333] INFO: task jbd2/nvme0n1p2-:483 blocked for more than 122
seconds.
[21504.744348]       Tainted: G                T  6.5.7-custom #14
[21504.744354] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21504.744357] task:jbd2/nvme0n1p2- state:D stack:0     pid:483   ppid:2=20=
=20=20=20=20
flags:0x00004000
[21504.744370] Call Trace:
[21504.744375]  <TASK>
[21504.744380]  __schedule+0x280/0xff0
[21504.744401]  ? page_mkclean_one+0x90/0xd0
[21504.744414]  schedule+0x52/0xa0
[21504.744469]  io_schedule+0x3e/0x70
[21504.744480]  folio_wait_bit_common+0x13f/0x310
[21504.744493]  ? __pfx_wake_page_function+0x10/0x10
[21504.744504]  write_cache_pages+0x12b/0x370
[21504.744513]  ? __pfx_ext4_journalled_writepage_callback+0x10/0x10
[21504.744526]  ext4_journalled_submit_inode_data_buffers+0x73/0xa0
[21504.744537]  jbd2_journal_commit_transaction+0x428/0x16e0
[21504.744549]  ? lock_timer_base+0x5c/0x80
[21504.744560]  kjournald2+0xa7/0x270
[21504.744570]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.744582]  ? __pfx_kjournald2+0x10/0x10
[21504.744592]  kthread+0xce/0x100
[21504.744601]  ? __pfx_kthread+0x10/0x10
[21504.744608]  ret_from_fork+0x2f/0x50
[21504.744616]  ? __pfx_kthread+0x10/0x10
[21504.744623]  ret_from_fork_asm+0x1b/0x30
[21504.744631]  </TASK>
[21504.744653] INFO: task uptimed:3408 blocked for more than 122 seconds.
[21504.744659]       Tainted: G                T  6.5.7-custom #14
[21504.744662] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21504.744664] task:uptimed         state:D stack:0     pid:3408  ppid:1=20=
=20=20=20=20
flags:0x00000000
[21504.744674] Call Trace:
[21504.744676]  <TASK>
[21504.744679]  __schedule+0x280/0xff0
[21504.744688]  schedule+0x52/0xa0
[21504.744696]  jbd2_log_wait_commit+0xd7/0x150
[21504.744703]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.744713]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21504.744723]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21504.744732]  add_transaction_credits+0x2e6/0x2f0
[21504.744739]  start_this_handle+0xfc/0x5b0
[21504.744746]  ? kmem_cache_alloc+0x15d/0x2a0
[21504.744755]  jbd2__journal_start+0x125/0x1b0
[21504.744762]  __ext4_new_inode+0x75c/0x1540
[21504.744770]  ext4_create+0xf6/0x1d0
[21504.744778]  path_openat+0x60f/0x10a0
[21504.744788]  do_filp_open+0xaf/0x180
[21504.744798]  do_sys_openat2+0xac/0xe0
[21504.744804]  __x64_sys_openat+0x54/0xa0
[21504.744810]  do_syscall_64+0x60/0x90
[21504.744820]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21504.744832] RIP: 0033:0x7f49289cb1b2
[21504.744839] RSP: 002b:00007fff5f465a20 EFLAGS: 00000202 ORIG_RAX:
0000000000000101
[21504.744847] RAX: ffffffffffffffda RBX: 0000000000000241 RCX:
00007f49289cb1b2
[21504.744852] RDX: 0000000000000241 RSI: 00007f4928ab11b0 RDI:
00000000ffffff9c
[21504.744856] RBP: 00007f4928ab11b0 R08: 0000000000000004 R09:
0000000000000001
[21504.744860] R10: 00000000000001b6 R11: 0000000000000202 R12:
00007f4928ab132a
[21504.744863] R13: 00007f4928ab132a R14: 0000000000000001 R15:
0000000000000000
[21504.744867]  </TASK>
[21504.744875] INFO: task vhost-7818:7832 blocked for more than 122 seconds.
[21504.744879]       Tainted: G                T  6.5.7-custom #14
[21504.744882] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21504.744884] task:vhost-7818      state:D stack:0     pid:7832  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21504.744891] Call Trace:
[21504.744893]  <TASK>
[21504.744896]  __schedule+0x280/0xff0
[21504.744905]  schedule+0x52/0xa0
[21504.744914]  jbd2_log_wait_commit+0xd7/0x150
[21504.744919]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.744929]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21504.744938]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21504.744948]  add_transaction_credits+0x2e6/0x2f0
[21504.744955]  start_this_handle+0xfc/0x5b0
[21504.744961]  ? kmem_cache_alloc+0x15d/0x2a0
[21504.744968]  jbd2__journal_start+0x125/0x1b0
[21504.744975]  ext4_dirty_inode+0x36/0x90
[21504.744983]  __mark_inode_dirty+0x4e/0x220
[21504.744994]  generic_update_time+0x80/0xd0
[21504.745003]  file_update_time+0xc7/0xe0
[21504.745012]  ext4_page_mkwrite+0x93/0x550
[21504.745019]  do_page_mkwrite+0x52/0xe0
[21504.745029]  do_wp_page+0xf3/0xcc0
[21504.745039]  ? balance_dirty_pages_ratelimited_flags+0x46/0x340
[21504.745047]  __handle_mm_fault+0x2e1/0x2f0
[21504.745057]  handle_mm_fault+0x106/0x300
[21504.745067]  exc_page_fault+0x1f4/0x560
[21504.745079]  asm_exc_page_fault+0x26/0x30
[21504.745089] RIP: 0010:rep_movs_alternative+0x33/0x70
[21504.745100] Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 =
ff
c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 8=
9 07
48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
[21504.745106] RSP: 0018:ffffa5e840567be8 EFLAGS: 00010202
[21504.745112] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
000000000000000a
[21504.745116] RDX: 0000000000000000 RSI: ffffa5e840567c98 RDI:
00007f4b30d62600
[21504.745120] RBP: 000000000000000a R08: 0000000000000000 R09:
0000000000000001
[21504.745123] R10: ffff9c4bc0640000 R11: 0000000000000000 R12:
ffffa5e840567e08
[21504.745127] R13: 0000000000000000 R14: ffffa5e840567c98 R15:
ffff9c4bc0640218
[21504.745132]  copyout+0x20/0x40
[21504.745143]  _copy_to_iter+0xdc/0x430
[21504.745153]  ? translate_desc+0x74/0x160
[21504.745164]  tun_do_read+0x282/0x750
[21504.745175]  tun_recvmsg+0x6d/0x170
[21504.745183]  handle_rx+0x5eb/0xa60
[21504.745192]  vhost_worker+0x44/0x70
[21504.745200]  vhost_task_fn+0x53/0xc0
[21504.745212]  ? __pfx_vhost_task_fn+0x10/0x10
[21504.745235]  ret_from_fork+0x2f/0x50
[21504.745242]  ? __pfx_vhost_task_fn+0x10/0x10
[21504.745251]  ret_from_fork_asm+0x1b/0x30
[21504.745258]  </TASK>
[21504.745260] INFO: task CPU 0/KVM:7834 blocked for more than 245 seconds.
[21504.745264]       Tainted: G                T  6.5.7-custom #14
[21504.745267] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21504.745269] task:CPU 0/KVM       state:D stack:0     pid:7834  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21504.745276] Call Trace:
[21504.745278]  <TASK>
[21504.745280]  __schedule+0x280/0xff0
[21504.745289]  schedule+0x52/0xa0
[21504.745298]  jbd2_log_wait_commit+0xd7/0x150
[21504.745303]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.745313]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21504.745322]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21504.745331]  add_transaction_credits+0x2e6/0x2f0
[21504.745338]  start_this_handle+0xfc/0x5b0
[21504.745344]  ? kmem_cache_alloc+0x15d/0x2a0
[21504.745352]  jbd2__journal_start+0x125/0x1b0
[21504.745358]  ext4_page_mkwrite+0x346/0x550
[21504.745365]  do_page_mkwrite+0x52/0xe0
[21504.745374]  do_wp_page+0xf3/0xcc0
[21504.745383]  ? vmx_vcpu_load+0x1c/0x50
[21504.745391]  ? kvm_arch_vcpu_load+0x65/0x210
[21504.745401]  __handle_mm_fault+0x2e1/0x2f0
[21504.745411]  handle_mm_fault+0x106/0x300
[21504.745421]  __get_user_pages+0x1f5/0x360
[21504.745429]  get_user_pages_unlocked+0xcd/0x280
[21504.745437]  hva_to_pfn+0xe9/0x420
[21504.745444]  kvm_faultin_pfn+0xa5/0x3d0
[21504.745454]  kvm_tdp_page_fault+0x127/0x180
[21504.745461]  kvm_mmu_page_fault+0x295/0x760
[21504.745469]  ? sysvec_call_function+0xe/0x90
[21504.745479]  ? vmx_vmexit+0x7d/0xd0
[21504.745486]  ? vmx_vmexit+0x77/0xd0
[21504.745493]  ? vmx_vmexit+0x9e/0xd0
[21504.745500]  vmx_handle_exit+0x12b/0x770
[21504.745509]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21504.745518]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21504.745528]  __x64_sys_ioctl+0x530/0xa70
[21504.745536]  do_syscall_64+0x60/0x90
[21504.745544]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21504.745554] RIP: 0033:0x7f4b9c513f9f
[21504.745558] RSP: 002b:00007f4b9a25d8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21504.745564] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21504.745568] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000018
[21504.745572] RBP: 000055764903b770 R08: 000055764716dea0 R09:
0000000000000640
[21504.745576] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[21504.745579] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[21504.745583]  </TASK>
[21504.745585] INFO: task CPU 1/KVM:7835 blocked for more than 245 seconds.
[21504.745589]       Tainted: G                T  6.5.7-custom #14
[21504.745591] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[21504.745594] task:CPU 1/KVM       state:D stack:0     pid:7835  ppid:1=20=
=20=20=20=20
flags:0x00004000
[21504.745600] Call Trace:
[21504.745602]  <TASK>
[21504.745604]  __schedule+0x280/0xff0
[21504.745613]  schedule+0x52/0xa0
[21504.745621]  jbd2_log_wait_commit+0xd7/0x150
[21504.745627]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.745636]  jbd2_log_do_checkpoint+0x22f/0x2b0
[21504.745646]  __jbd2_log_wait_for_space+0x4e/0x1f0
[21504.745655]  ? __pfx_autoremove_wake_function+0x10/0x10
[21504.745664]  add_transaction_credits+0x2e6/0x2f0
[21504.745671]  ? ext4_mark_iloc_dirty+0x202/0x5d0
[21504.745677]  start_this_handle+0xfc/0x5b0
[21504.745683]  ? kmem_cache_alloc+0x15d/0x2a0
[21504.745690]  jbd2__journal_start+0x125/0x1b0
[21504.745696]  ext4_dirty_inode+0x36/0x90
[21504.745703]  __mark_inode_dirty+0x4e/0x220
[21504.745712]  generic_update_time+0x80/0xd0
[21504.745720]  file_update_time+0xc7/0xe0
[21504.745728]  ext4_page_mkwrite+0x93/0x550
[21504.745734]  do_page_mkwrite+0x52/0xe0
[21504.745743]  do_wp_page+0xf3/0xcc0
[21504.745752]  __handle_mm_fault+0x2e1/0x2f0
[21504.745762]  handle_mm_fault+0x106/0x300
[21504.745772]  __get_user_pages+0x1f5/0x360
[21504.745779]  get_user_pages_unlocked+0xcd/0x280
[21504.745787]  hva_to_pfn+0xe9/0x420
[21504.745793]  kvm_faultin_pfn+0xa5/0x3d0
[21504.745801]  kvm_tdp_page_fault+0x127/0x180
[21504.745807]  kvm_mmu_page_fault+0x295/0x760
[21504.745815]  ? __check_object_size+0x53/0x2d0
[21504.745825]  vmx_handle_exit+0x12b/0x770
[21504.745833]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[21504.745841]  kvm_vcpu_ioctl+0x1a3/0x6d0
[21504.745850]  __x64_sys_ioctl+0x530/0xa70
[21504.745856]  do_syscall_64+0x60/0x90
[21504.745863]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[21504.745872] RIP: 0033:0x7f4b9c513f9f
[21504.745876] RSP: 002b:00007f4b99a5c8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21504.745881] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4b9c513f9f
[21504.745885] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000019
[21504.745888] RBP: 000055764906ce40 R08: 000055764716dea0 R09:
00007f4a88003010
[21504.745892] R10: 0000000000000100 R11: 0000000000000246 R12:
0000000000000000
[21504.745895] R13: 0000000000000000 R14: 00007ffcce9ee160 R15:
00007f4b9925d000
[21504.745899]  </TASK>
[21504.745901] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
