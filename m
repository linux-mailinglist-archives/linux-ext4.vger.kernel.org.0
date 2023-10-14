Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432BC7C960E
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJNTeA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Oct 2023 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNTd7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Oct 2023 15:33:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F78FBF
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 12:33:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFBE7C433C9
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697312037;
        bh=xnInYT6cyi8iue+qdQ6vZ+MleInuzUhK6ZSi+yEwcfc=;
        h=From:To:Subject:Date:From;
        b=VzNIgTBwfc3oigqgF+stDj4eH5ErRBNjmWHhRvhbrNAGz4TmVFAYm04zTZXDhiuJT
         uFLkHGcVXrIOC6OcnIz+5GGocbOqgSQsz0AoSxJgN9QkOECzMLtpLZ1Fo6T5NTQVrt
         oW+RzqoGa/G2dqbaSepLaGIah8AitiNEu8i9PlsphISm9oUPPBO+kY8sV3i/zV9e77
         4EkCj9Xy+3Zm2J33Y9xPlTQdzWnV2wJdbpTpwP7VguG+g9HzhwPMQsNUsMQRppQ1hk
         R1Vzo6SyB5/ZmAnfTsQbZDoiC7zIQdmhyPgiVhuVK7hq0r4hg7p7Hak0Lw1Ioq3AdY
         v4SkwAGRcj7Vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D1459C53BD5; Sat, 14 Oct 2023 19:33:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] New: ext4 root filesystem related hangs on 6.5 kernels
Date:   Sat, 14 Oct 2023 19:33:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218011-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 218011
           Summary: ext4 root filesystem related hangs on 6.5 kernels
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: jaak+bugzilla.kernel.org@ristioja.ee
        Regression: No

Starting from some 6.5 kernels, a server started to experience problems with
the root ext4 filesystem with processes accessing it ending up hanging. Here
are relevant messages from dmesg:

[242602.644812] INFO: task jbd2/nvme0n1p2-:127 blocked for more than 122
seconds.
[242602.644817]       Tainted: G                T  6.5.7-custom #1
[242602.644818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.644819] task:jbd2/nvme0n1p2- state:D stack:0     pid:127   ppid:2=
=20=20=20=20=20
flags:0x00004000
[242602.644822] Call Trace:
[242602.644824]  <TASK>
[242602.644825]  __schedule+0x280/0xff0
[242602.644831]  ? page_mkclean_one+0x90/0xd0
[242602.644834]  schedule+0x52/0xa0
[242602.644836]  io_schedule+0x3e/0x70
[242602.644838]  folio_wait_bit_common+0x13f/0x310
[242602.644842]  ? __pfx_wake_page_function+0x10/0x10
[242602.644844]  write_cache_pages+0x12b/0x370
[242602.644847]  ? __pfx_ext4_journalled_writepage_callback+0x10/0x10
[242602.644850]  ext4_journalled_submit_inode_data_buffers+0x73/0xa0
[242602.644853]  jbd2_journal_commit_transaction+0x428/0x16e0
[242602.644856]  ? update_load_avg+0x71/0x680
[242602.644859]  ? lock_timer_base+0x5c/0x80
[242602.644862]  kjournald2+0xa7/0x270
[242602.644865]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.644868]  ? __pfx_kjournald2+0x10/0x10
[242602.644870]  kthread+0xce/0x100
[242602.644873]  ? __pfx_kthread+0x10/0x10
[242602.644875]  ret_from_fork+0x2f/0x50
[242602.644877]  ? __pfx_kthread+0x10/0x10
[242602.644879]  ret_from_fork_asm+0x1b/0x30
[242602.644881]  </TASK>
[242602.644901] INFO: task vhost-3838:3850 blocked for more than 122 second=
s.
[242602.644902]       Tainted: G                T  6.5.7-custom #1
[242602.644903] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.644903] task:vhost-3838      state:D stack:0     pid:3850  ppid:1=
=20=20=20=20=20
flags:0x00004000
[242602.644905] Call Trace:
[242602.644906]  <TASK>
[242602.644906]  __schedule+0x280/0xff0
[242602.644908]  schedule+0x52/0xa0
[242602.644910]  jbd2_log_wait_commit+0xd7/0x150
[242602.644912]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.644914]  jbd2_log_do_checkpoint+0x22f/0x2b0
[242602.644916]  __jbd2_log_wait_for_space+0x4e/0x1f0
[242602.644918]  add_transaction_credits+0x2e6/0x2f0
[242602.644920]  start_this_handle+0xfc/0x5b0
[242602.644922]  ? kmem_cache_alloc+0x15d/0x2a0
[242602.644924]  jbd2__journal_start+0x125/0x1b0
[242602.644926]  ext4_dirty_inode+0x36/0x90
[242602.644928]  __mark_inode_dirty+0x4e/0x220
[242602.644931]  generic_update_time+0x80/0xd0
[242602.644934]  file_update_time+0xc7/0xe0
[242602.644937]  ext4_page_mkwrite+0x93/0x550
[242602.644938]  do_page_mkwrite+0x52/0xe0
[242602.644941]  do_wp_page+0xf3/0xcc0
[242602.644944]  ? balance_dirty_pages_ratelimited_flags+0x46/0x340
[242602.644948]  __handle_mm_fault+0x2e1/0x2f0
[242602.644951]  handle_mm_fault+0x106/0x300
[242602.644953]  exc_page_fault+0x1f4/0x560
[242602.644956]  asm_exc_page_fault+0x26/0x30
[242602.644960] RIP: 0010:rep_movs_alternative+0x33/0x70
[242602.644964] Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48=
 ff
c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 8=
9 07
48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
[242602.644965] RSP: 0018:ffffb850805abbe8 EFLAGS: 00010202
[242602.644967] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
000000000000000a
[242602.644968] RDX: 0000000000000000 RSI: ffffb850805abc98 RDI:
00007f16b2de4a00
[242602.644969] RBP: 000000000000000a R08: 0000000000000000 R09:
0000000000000001
[242602.644969] R10: ffff961e8dcb0000 R11: 0000000000000000 R12:
ffffb850805abe08
[242602.644970] R13: 0000000000000000 R14: ffffb850805abc98 R15:
ffff961e8dcb0218
[242602.644971]  copyout+0x20/0x40
[242602.644975]  _copy_to_iter+0xdc/0x430
[242602.644977]  ? translate_desc+0x74/0x160
[242602.644980]  tun_do_read+0x282/0x750
[242602.644983]  tun_recvmsg+0x6d/0x170
[242602.644985]  handle_rx+0x5eb/0xa60
[242602.644987]  vhost_worker+0x44/0x70
[242602.644989]  vhost_task_fn+0x53/0xc0
[242602.645001]  ? __pfx_vhost_task_fn+0x10/0x10
[242602.645003]  ret_from_fork+0x2f/0x50
[242602.645005]  ? __pfx_vhost_task_fn+0x10/0x10
[242602.645007]  ret_from_fork_asm+0x1b/0x30
[242602.645008]  </TASK>
[242602.645009] INFO: task CPU 0/KVM:3852 blocked for more than 122 seconds.
[242602.645010]       Tainted: G                T  6.5.7-custom #1
[242602.645010] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645011] task:CPU 0/KVM       state:D stack:0     pid:3852  ppid:1=
=20=20=20=20=20
flags:0x00000000
[242602.645013] Call Trace:
[242602.645014]  <TASK>
[242602.645014]  __schedule+0x280/0xff0
[242602.645016]  schedule+0x52/0xa0
[242602.645018]  jbd2_log_wait_commit+0xd7/0x150
[242602.645019]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645021]  jbd2_log_do_checkpoint+0x22f/0x2b0
[242602.645023]  __jbd2_log_wait_for_space+0x4e/0x1f0
[242602.645025]  add_transaction_credits+0x2e6/0x2f0
[242602.645026]  start_this_handle+0xfc/0x5b0
[242602.645028]  ? kmem_cache_alloc+0x15d/0x2a0
[242602.645029]  jbd2__journal_start+0x125/0x1b0
[242602.645031]  ext4_dirty_inode+0x36/0x90
[242602.645032]  __mark_inode_dirty+0x4e/0x220
[242602.645034]  generic_update_time+0x80/0xd0
[242602.645036]  file_update_time+0xc7/0xe0
[242602.645038]  ext4_page_mkwrite+0x93/0x550
[242602.645039]  do_page_mkwrite+0x52/0xe0
[242602.645041]  do_wp_page+0xf3/0xcc0
[242602.645043]  __handle_mm_fault+0x2e1/0x2f0
[242602.645045]  handle_mm_fault+0x106/0x300
[242602.645047]  __get_user_pages+0x1f5/0x360
[242602.645049]  get_user_pages_unlocked+0xcd/0x280
[242602.645051]  hva_to_pfn+0xe9/0x420
[242602.645053]  kvm_faultin_pfn+0xa5/0x3d0
[242602.645056]  ? vmx_vcpu_load+0x1c/0x50
[242602.645058]  ? kvm_arch_vcpu_load+0x65/0x210
[242602.645061]  kvm_tdp_page_fault+0x127/0x180
[242602.645063]  kvm_mmu_page_fault+0x295/0x760
[242602.645064]  ? __pfx_emulator_write_gpr+0x10/0x10
[242602.645067]  ? kvm_cpu_has_interrupt+0x5f/0x80
[242602.645070]  ? __check_object_size+0x53/0x2d0
[242602.645072]  vmx_handle_exit+0x12b/0x770
[242602.645074]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[242602.645076]  kvm_vcpu_ioctl+0x1a3/0x6d0
[242602.645079]  __x64_sys_ioctl+0x530/0xa70
[242602.645082]  do_syscall_64+0x60/0x90
[242602.645083]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645086] RIP: 0033:0x7f172e60df9f
[242602.645087] RSP: 002b:00007f1627ffd8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[242602.645089] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f172e60df9f
[242602.645090] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000018
[242602.645090] RBP: 000055ef39425770 R08: 000055ef38594ea0 R09:
00007f16183be330
[242602.645091] R10: 072d79a2806b9d79 R11: 0000000000000246 R12:
0000000000000000
[242602.645092] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[242602.645093]  </TASK>
[242602.645093] INFO: task CPU 1/KVM:3853 blocked for more than 122 seconds.
[242602.645094]       Tainted: G                T  6.5.7-custom #1
[242602.645095] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645095] task:CPU 1/KVM       state:D stack:0     pid:3853  ppid:1=
=20=20=20=20=20
flags:0x00004000
[242602.645097] Call Trace:
[242602.645098]  <TASK>
[242602.645098]  __schedule+0x280/0xff0
[242602.645100]  schedule+0x52/0xa0
[242602.645102]  jbd2_log_wait_commit+0xd7/0x150
[242602.645103]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645105]  jbd2_log_do_checkpoint+0x22f/0x2b0
[242602.645107]  __jbd2_log_wait_for_space+0x4e/0x1f0
[242602.645109]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645111]  add_transaction_credits+0x2e6/0x2f0
[242602.645112]  ? __wake_up_common_lock+0x8a/0xd0
[242602.645114]  start_this_handle+0xfc/0x5b0
[242602.645116]  ? kmem_cache_alloc+0x15d/0x2a0
[242602.645117]  jbd2__journal_start+0x125/0x1b0
[242602.645119]  ext4_page_mkwrite+0x346/0x550
[242602.645120]  do_page_mkwrite+0x52/0xe0
[242602.645122]  do_wp_page+0xf3/0xcc0
[242602.645124]  __handle_mm_fault+0x2e1/0x2f0
[242602.645126]  handle_mm_fault+0x106/0x300
[242602.645128]  __get_user_pages+0x1f5/0x360
[242602.645130]  get_user_pages_unlocked+0xcd/0x280
[242602.645131]  hva_to_pfn+0xe9/0x420
[242602.645132]  kvm_faultin_pfn+0xa5/0x3d0
[242602.645134]  kvm_tdp_page_fault+0x127/0x180
[242602.645135]  kvm_mmu_page_fault+0x295/0x760
[242602.645137]  ? vmx_vmexit+0x7d/0xd0
[242602.645138]  ? vmx_vmexit+0x77/0xd0
[242602.645140]  ? vmx_vmexit+0x9e/0xd0
[242602.645141]  vmx_handle_exit+0x12b/0x770
[242602.645143]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[242602.645144]  kvm_vcpu_ioctl+0x1a3/0x6d0
[242602.645146]  __x64_sys_ioctl+0x530/0xa70
[242602.645148]  do_syscall_64+0x60/0x90
[242602.645149]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645151] RIP: 0033:0x7f172e60df9f
[242602.645152] RSP: 002b:00007f16277fc8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[242602.645153] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f172e60df9f
[242602.645154] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000019
[242602.645154] RBP: 000055ef39456e40 R08: 000055ef38594ea0 R09:
0000000000000000
[242602.645155] R10: 000000000000000a R11: 0000000000000246 R12:
0000000000000000
[242602.645156] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[242602.645156]  </TASK>
[242602.645157] INFO: task CPU 2/KVM:3854 blocked for more than 122 seconds.
[242602.645158]       Tainted: G                T  6.5.7-custom #1
[242602.645158] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645159] task:CPU 2/KVM       state:D stack:0     pid:3854  ppid:1=
=20=20=20=20=20
flags:0x00004000
[242602.645160] Call Trace:
[242602.645161]  <TASK>
[242602.645161]  __schedule+0x280/0xff0
[242602.645163]  schedule+0x52/0xa0
[242602.645164]  jbd2_log_wait_commit+0xd7/0x150
[242602.645166]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645168]  jbd2_log_do_checkpoint+0x22f/0x2b0
[242602.645170]  __jbd2_log_wait_for_space+0x4e/0x1f0
[242602.645171]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645173]  add_transaction_credits+0x2e6/0x2f0
[242602.645175]  ? __jbd2_journal_file_buffer+0x6c/0x1f0
[242602.645176]  start_this_handle+0xfc/0x5b0
[242602.645178]  ? kmem_cache_alloc+0x15d/0x2a0
[242602.645179]  jbd2__journal_start+0x125/0x1b0
[242602.645181]  ext4_page_mkwrite+0x346/0x550
[242602.645182]  do_page_mkwrite+0x52/0xe0
[242602.645184]  do_wp_page+0xf3/0xcc0
[242602.645186]  ? asm_sysvec_call_function_single+0x1a/0x20
[242602.645188]  __handle_mm_fault+0x2e1/0x2f0
[242602.645190]  handle_mm_fault+0x106/0x300
[242602.645192]  __get_user_pages+0x1f5/0x360
[242602.645194]  get_user_pages_unlocked+0xcd/0x280
[242602.645195]  hva_to_pfn+0xe9/0x420
[242602.645196]  kvm_faultin_pfn+0xa5/0x3d0
[242602.645198]  kvm_tdp_page_fault+0x127/0x180
[242602.645199]  kvm_mmu_page_fault+0x295/0x760
[242602.645201]  ? sysvec_call_function_single+0xe/0x90
[242602.645203]  ? vmx_vmexit+0x7d/0xd0
[242602.645204]  ? vmx_vmexit+0x77/0xd0
[242602.645206]  ? vmx_vmexit+0x9e/0xd0
[242602.645207]  vmx_handle_exit+0x12b/0x770
[242602.645209]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[242602.645210]  kvm_vcpu_ioctl+0x1a3/0x6d0
[242602.645212]  __x64_sys_ioctl+0x530/0xa70
[242602.645214]  do_syscall_64+0x60/0x90
[242602.645215]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645217] RIP: 0033:0x7f172e60df9f
[242602.645218] RSP: 002b:00007f1626ffb8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[242602.645219] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f172e60df9f
[242602.645219] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
000000000000001a
[242602.645220] RBP: 000055ef3945ef50 R08: 000055ef38594ea0 R09:
00000000000000ff
[242602.645221] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[242602.645221] R13: 0000000000000000 R14: 0000000000000000 R15:
00007f16267fc000
[242602.645222]  </TASK>
[242602.645223] INFO: task CPU 3/KVM:3855 blocked for more than 122 seconds.
[242602.645223]       Tainted: G                T  6.5.7-custom #1
[242602.645224] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645225] task:CPU 3/KVM       state:D stack:0     pid:3855  ppid:1=
=20=20=20=20=20
flags:0x00004000
[242602.645226] Call Trace:
[242602.645226]  <TASK>
[242602.645227]  __schedule+0x280/0xff0
[242602.645228]  schedule+0x52/0xa0
[242602.645230]  jbd2_log_wait_commit+0xd7/0x150
[242602.645231]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645233]  jbd2_log_do_checkpoint+0x22f/0x2b0
[242602.645235]  __jbd2_log_wait_for_space+0x4e/0x1f0
[242602.645237]  ? __pfx_autoremove_wake_function+0x10/0x10
[242602.645239]  add_transaction_credits+0x2e6/0x2f0
[242602.645240]  start_this_handle+0xfc/0x5b0
[242602.645242]  ? kmem_cache_alloc+0x15d/0x2a0
[242602.645243]  jbd2__journal_start+0x125/0x1b0
[242602.645244]  ext4_dirty_inode+0x36/0x90
[242602.645246]  __mark_inode_dirty+0x4e/0x220
[242602.645247]  generic_update_time+0x80/0xd0
[242602.645249]  file_update_time+0xc7/0xe0
[242602.645251]  ext4_page_mkwrite+0x93/0x550
[242602.645252]  do_page_mkwrite+0x52/0xe0
[242602.645254]  do_wp_page+0xf3/0xcc0
[242602.645256]  __handle_mm_fault+0x2e1/0x2f0
[242602.645258]  handle_mm_fault+0x106/0x300
[242602.645260]  __get_user_pages+0x1f5/0x360
[242602.645261]  get_user_pages_unlocked+0xcd/0x280
[242602.645263]  hva_to_pfn+0xe9/0x420
[242602.645264]  kvm_faultin_pfn+0xa5/0x3d0
[242602.645266]  ? vmx_vcpu_load+0x1c/0x50
[242602.645267]  ? kvm_arch_vcpu_load+0x65/0x210
[242602.645269]  kvm_tdp_page_fault+0x127/0x180
[242602.645270]  kvm_mmu_page_fault+0x295/0x760
[242602.645271]  ? __pfx_emulator_write_gpr+0x10/0x10
[242602.645273]  ? kvm_cpu_has_interrupt+0x5f/0x80
[242602.645275]  ? __check_object_size+0x53/0x2d0
[242602.645277]  vmx_handle_exit+0x12b/0x770
[242602.645279]  kvm_arch_vcpu_ioctl_run+0x81b/0x1ed0
[242602.645280]  kvm_vcpu_ioctl+0x1a3/0x6d0
[242602.645282]  __x64_sys_ioctl+0x530/0xa70
[242602.645284]  do_syscall_64+0x60/0x90
[242602.645285]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645287] RIP: 0033:0x7f172e60df9f
[242602.645288] RSP: 002b:00007f16267fa8e0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[242602.645289] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f172e60df9f
[242602.645289] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
000000000000001b
[242602.645290] RBP: 000055ef39466ee0 R08: 000055ef38594ea0 R09:
00000000ffffffff
[242602.645291] R10: 0000000000000028 R11: 0000000000000246 R12:
0000000000000000
[242602.645292] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[242602.645292]  </TASK>
[242602.645293] INFO: task worker:67152 blocked for more than 122 seconds.
[242602.645294]       Tainted: G                T  6.5.7-custom #1
[242602.645295] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645295] task:worker          state:D stack:0     pid:67152 ppid:1=
=20=20=20=20=20
flags:0x00000000
[242602.645297] Call Trace:
[242602.645297]  <TASK>
[242602.645298]  __schedule+0x280/0xff0
[242602.645299]  schedule+0x52/0xa0
[242602.645301]  schedule_preempt_disabled+0x9/0x10
[242602.645303]  rwsem_down_read_slowpath+0x1f2/0x390
[242602.645305]  down_read+0x30/0xa0
[242602.645306]  do_madvise+0xe2/0x300
[242602.645308]  __x64_sys_madvise+0x27/0x40
[242602.645309]  do_syscall_64+0x60/0x90
[242602.645311]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645313] RIP: 0033:0x7f172e611d7b
[242602.645313] RSP: 002b:00007f16016f1b18 EFLAGS: 00000206 ORIG_RAX:
000000000000001c
[242602.645314] RAX: ffffffffffffffda RBX: 00007f16016f2cdc RCX:
00007f172e611d7b
[242602.645315] RDX: 0000000000000004 RSI: 00000000007fb000 RDI:
00007f1600ef2000
[242602.645316] RBP: 00007f1600ef2000 R08: 00007f16016f26c0 R09:
0000000000000081
[242602.645317] R10: 0000000000000008 R11: 0000000000000206 R12:
0000000000801000
[242602.645317] R13: 0000000000000000 R14: 00007f1600ef06b0 R15:
00007f1600ef2000
[242602.645318]  </TASK>
[242602.645319] INFO: task worker:67153 blocked for more than 122 seconds.
[242602.645319]       Tainted: G                T  6.5.7-custom #1
[242602.645320] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645320] task:worker          state:D stack:0     pid:67153 ppid:1=
=20=20=20=20=20
flags:0x00000000
[242602.645322] Call Trace:
[242602.645322]  <TASK>
[242602.645323]  __schedule+0x280/0xff0
[242602.645324]  schedule+0x52/0xa0
[242602.645326]  schedule_preempt_disabled+0x9/0x10
[242602.645328]  rwsem_down_read_slowpath+0x1f2/0x390
[242602.645329]  down_read+0x30/0xa0
[242602.645330]  do_madvise+0xe2/0x300
[242602.645331]  __x64_sys_madvise+0x27/0x40
[242602.645332]  do_syscall_64+0x60/0x90
[242602.645334]  ? __x64_sys_rt_sigprocmask+0x7e/0xe0
[242602.645336]  ? syscall_exit_to_user_mode+0x21/0x50
[242602.645337]  ? do_syscall_64+0x6c/0x90
[242602.645339]  ? do_syscall_64+0x6c/0x90
[242602.645340]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645342] RIP: 0033:0x7f172e611d7b
[242602.645342] RSP: 002b:00007f1603cfbb18 EFLAGS: 00000206 ORIG_RAX:
000000000000001c
[242602.645343] RAX: ffffffffffffffda RBX: 00007f1603cfccdc RCX:
00007f172e611d7b
[242602.645344] RDX: 0000000000000004 RSI: 00000000007fb000 RDI:
00007f16034fc000
[242602.645345] RBP: 00007f16034fc000 R08: 00007f1603cfc6c0 R09:
0000000000000081
[242602.645345] R10: 0000000000000008 R11: 0000000000000206 R12:
0000000000801000
[242602.645346] R13: 0000000000000000 R14: 00007f16016f16b0 R15:
00007f16034fc000
[242602.645347]  </TASK>
[242602.645348] INFO: task worker:67157 blocked for more than 122 seconds.
[242602.645348]       Tainted: G                T  6.5.7-custom #1
[242602.645349] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645349] task:worker          state:D stack:0     pid:67157 ppid:1=
=20=20=20=20=20
flags:0x00000000
[242602.645351] Call Trace:
[242602.645351]  <TASK>
[242602.645351]  __schedule+0x280/0xff0
[242602.645353]  schedule+0x52/0xa0
[242602.645355]  schedule_preempt_disabled+0x9/0x10
[242602.645357]  rwsem_down_read_slowpath+0x1f2/0x390
[242602.645358]  down_read+0x30/0xa0
[242602.645359]  do_madvise+0xe2/0x300
[242602.645360]  __x64_sys_madvise+0x27/0x40
[242602.645361]  do_syscall_64+0x60/0x90
[242602.645363]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645364] RIP: 0033:0x7f172e611d7b
[242602.645365] RSP: 002b:00007f15ebffeb18 EFLAGS: 00000206 ORIG_RAX:
000000000000001c
[242602.645366] RAX: ffffffffffffffda RBX: 00007f15ebfffcdc RCX:
00007f172e611d7b
[242602.645367] RDX: 0000000000000004 RSI: 00000000007fb000 RDI:
00007f15eb7ff000
[242602.645367] RBP: 00007f15eb7ff000 R08: 00007f15ebfff6c0 R09:
0000000000000081
[242602.645368] R10: 0000000000000008 R11: 0000000000000206 R12:
0000000000801000
[242602.645369] R13: 0000000000000000 R14: 00007f16020f46b0 R15:
00007f15eb7ff000
[242602.645369]  </TASK>
[242602.645370] INFO: task worker:67160 blocked for more than 122 seconds.
[242602.645371]       Tainted: G                T  6.5.7-custom #1
[242602.645371] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[242602.645372] task:worker          state:D stack:0     pid:67160 ppid:1=
=20=20=20=20=20
flags:0x00000000
[242602.645373] Call Trace:
[242602.645374]  <TASK>
[242602.645374]  __schedule+0x280/0xff0
[242602.645376]  ? _raw_spin_unlock_irqrestore+0x12/0x20
[242602.645378]  ? try_to_wake_up+0x1f2/0x3f0
[242602.645380]  schedule+0x52/0xa0
[242602.645382]  schedule_preempt_disabled+0x9/0x10
[242602.645384]  rwsem_down_read_slowpath+0x1f2/0x390
[242602.645385]  down_read+0x30/0xa0
[242602.645386]  do_madvise+0xe2/0x300
[242602.645387]  __x64_sys_madvise+0x27/0x40
[242602.645388]  do_syscall_64+0x60/0x90
[242602.645389]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[242602.645391] RIP: 0033:0x7f172e611d7b
[242602.645392] RSP: 002b:00007f15eaffcb18 EFLAGS: 00000206 ORIG_RAX:
000000000000001c
[242602.645393] RAX: ffffffffffffffda RBX: 00007f15eaffdcdc RCX:
00007f172e611d7b
[242602.645394] RDX: 0000000000000004 RSI: 00000000007fb000 RDI:
00007f15ea7fd000
[242602.645394] RBP: 00007f15ea7fd000 R08: 00007f15eaffd6c0 R09:
0000000000000081
[242602.645395] R10: 0000000000000008 R11: 0000000000000206 R12:
0000000000801000
[242602.645395] R13: 0000000000000000 R14: 00007f15eb7fd6b0 R15:
00007f15ea7fd000
[242602.645396]  </TASK>
[242602.645397] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

I've not seen this issue with 6.4 kernels. I started to use the 6.5 series =
from
version 6.5.3 onwards, but I think I first saw this error with 6.5.5 or 6.5=
.6.

# mount | head -1
/dev/nvme0n1p2 on / type ext4
(rw,noatime,nodiratime,nodioread_nolock,discard,nodelalloc)
# zgrep -i ext4 /proc/config.gz=20
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
