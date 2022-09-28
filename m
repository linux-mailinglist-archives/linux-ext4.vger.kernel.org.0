Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4255ED657
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Sep 2022 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiI1HiQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Sep 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiI1Hhl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Sep 2022 03:37:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE33210BB35
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 00:36:24 -0700 (PDT)
Received: from [10.254.254.111] (ip5b402ecc.dynamic.kabel-deutschland.de [91.64.46.204])
        by linux.microsoft.com (Postfix) with ESMTPSA id 328F820DEC6B;
        Wed, 28 Sep 2022 00:30:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 328F820DEC6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664350229;
        bh=OLeBehzIL5Xy6VHlv4orIXdwTymHG1h6IA/EzpMrhg4=;
        h=Date:In-Reply-To:To:Cc:From:Subject:From;
        b=k4uizrRj9shASUuDY0wpQTOoF5j4jWFSor/Cit2L3OzL/Y6vJuWg+ofqSqEW/VmGg
         izK6J83NgsW0cqWMr4MXHSRgTQ7HMBMo51c3X/lUepgBC5vwM7jNe+jjAOKASFDuEB
         jvLUola5A+OwYg4YyXEHIzwksvANAyz3QCWKtq9k=
Message-ID: <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
Date:   Wed, 28 Sep 2022 09:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
In-Reply-To: <20220824100652.227m7eq4zqq7luir@quack3>
To:     jack@suse.com
Cc:     tytso@mit.edu, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org
From:   Thilo Fromm <t-lo@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

 > So this seems like a real issue. Essentially, the problem is that
 > ext4_bmap() acquires inode->i_rwsem while its caller
 > jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
 > looks like a real deadlock possibility.

Flatcar Container Linux users have reported a kernel issue which might 
be caused by commit 51ae846cff5. The issue is triggered under I/O load 
in certain conditions and leads to a complete system hang. I've pasted a 
typical kernel log below; please refer to 
https://github.com/flatcar/Flatcar/issues/847 for more details.

The issue can be triggered on Flatcar release 3227.2.2 / kernel version 
5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 
5.15.58. 51ae846cff5 was introduced to 5.15 in 5.15.61.

 > Thinking about it some more, it does not seem locking i_rwsem in
 > ext4_bmap() is really workable and as I've noted in one of my replies
 > to this patch [1] it is not a complete solution to the problem anyway.
 > So I would be for reverting 51ae846cff5 and thinking more about how we
 > can make inline data locking suck less...

Any thoughts on the revert? After a cursory glance at 51ae846cff5 this 
commit merely seems to address a warning...

Best regards,
Thilo

( Kernel log of a crash follows; more info here: 
https://github.com/flatcar/Flatcar/issues/847 )

[1282119.153912] INFO: task jbd2/sda9-8:544 blocked for more than 122 
seconds.
[1282119.157088]       Not tainted 5.15.63-flatcar #1
[1282119.159281] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.162723] task:jbd2/sda9-8     state:D stack:    0 pid:  544 
ppid:     2 flags:0x00004000
[1282119.166441] Call Trace:
[1282119.167640]  <TASK>
[1282119.168675]  __schedule+0x2eb/0x8d0
[1282119.170341]  schedule+0x5b/0xd0
[1282119.171806]  jbd2_journal_commit_transaction+0x301/0x2850 [jbd2]
[1282119.175448]  ? wait_woken+0x70/0x70
[1282119.177174]  ? lock_timer_base+0x61/0x80
[1282119.179015]  jbd2_journal_check_available_features+0x1ab/0x3f0 [jbd2]
[1282119.181922]  ? wait_woken+0x70/0x70
[1282119.183533]  ? jbd2_journal_check_available_features+0x100/0x3f0 [jbd2]
[1282119.186566]  kthread+0x127/0x150
[1282119.188087]  ? set_kthread_struct+0x50/0x50
[1282119.190346]  ret_from_fork+0x22/0x30
[1282119.192027]  </TASK>
[1282119.193081] INFO: task systemd-journal:748 blocked for more than 
122 seconds.
[1282119.196255]       Not tainted 5.15.63-flatcar #1
[1282119.198321] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.201776] task:systemd-journal state:D stack:    0 pid:  748 
ppid:     1 flags:0x00000004
[1282119.205604] Call Trace:
[1282119.206773]  <TASK>
[1282119.207794]  __schedule+0x2eb/0x8d0
[1282119.209410]  schedule+0x5b/0xd0
[1282119.210887]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.213342]  ? wait_woken+0x70/0x70
[1282119.214946]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.217482]  ? call_rcu+0xa2/0x330
[1282119.219070]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.221672]  ? step_into+0x47c/0x7b0
[1282119.223372]  ? __cond_resched+0x16/0x50
[1282119.225175]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.227342]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.229688]  ext4_dirty_inode+0x35/0x80 [ext4]
[1282119.231735]  __mark_inode_dirty+0x147/0x320
[1282119.233712]  touch_atime+0x13c/0x150
[1282119.235429]  filemap_read+0x308/0x320
[1282119.238370]  ? may_delete+0x2a0/0x2f0
[1282119.240286]  ? do_filp_open+0xa9/0x150
[1282119.242071]  new_sync_read+0x119/0x1b0
[1282119.244052]  ? 0xffffffffad000000
[1282119.245736]  vfs_read+0xf6/0x190
[1282119.247362]  __x64_sys_pread64+0x91/0xc0
[1282119.249365]  do_syscall_64+0x3b/0x90
[1282119.251173]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[1282119.253772] RIP: 0033:0x7f59ebb32b17
[1282119.255634] RSP: 002b:00007ffefe2b6520 EFLAGS: 00000293 ORIG_RAX: 
0000000000000011
[1282119.259426] RAX: ffffffffffffffda RBX: 00007ffefe2b65d0 RCX: 
00007f59ebb32b17
[1282119.262876] RDX: 0000000000000040 RSI: 00007ffefe2b6550 RDI: 
0000000000000020
[1282119.266269] RBP: 000000000210fdb0 R08: 0000000000000000 R09: 
00007ffefe2b6760
[1282119.270866] R10: 000000000210fdb0 R11: 0000000000000293 R12: 
000055705e025030
[1282119.274357] R13: 0000000000000000 R14: 00007ffefe2b6550 R15: 
000055705e025030
[1282119.277808]  </TASK>
[1282119.279102] INFO: task python:1117 blocked for more than 123 seconds.
[1282119.282317]       Not tainted 5.15.63-flatcar #1
[1282119.284531] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.288819] task:python          state:D stack:    0 pid: 1117 
ppid:  1010 flags:0x00000000
[1282119.292823] Call Trace:
[1282119.294282]  <TASK>
[1282119.295429]  __schedule+0x2eb/0x8d0
[1282119.297126]  schedule+0x5b/0xd0
[1282119.298734]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.301713]  ? wait_woken+0x70/0x70
[1282119.303438]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.306313]  ? hrtimer_try_to_cancel.part.0+0x50/0xd0
[1282119.308836]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.311496]  ? mlx5e_select_queue+0x3c/0x2d0 [mlx5_core]
[1282119.314170]  ? __cond_resched+0x16/0x50
[1282119.315956]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.318816]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.321540]  ext4_setattr+0x3a8/0x9a0 [ext4]
[1282119.323842]  notify_change+0x3c4/0x540
[1282119.325750]  ? ext4_es_delayed_clu+0x170/0x430 [ext4]
[1282119.328375]  ? ext4_es_delayed_clu+0x1ef/0x430 [ext4]
[1282119.330894]  ? do_truncate+0x7d/0xd0
[1282119.332698]  do_truncate+0x7d/0xd0
[1282119.334571]  path_openat+0x24d/0x1280
[1282119.336461]  do_filp_open+0xa9/0x150
[1282119.338190]  ? __check_object_size+0x146/0x160
[1282119.340409]  do_sys_openat2+0x9b/0x160
[1282119.342289]  __x64_sys_openat+0x54/0xa0
[1282119.344180]  do_syscall_64+0x3b/0x90
[1282119.346050]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[1282119.348496] RIP: 0033:0x7f47adf699e4
[1282119.352234] RSP: 002b:00007ffd95f911e0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000101
[1282119.357348] RAX: ffffffffffffffda RBX: 00007f47ac34a558 RCX: 
00007f47adf699e4
[1282119.360865] RDX: 0000000000080241 RSI: 00007f47acb90b48 RDI: 
00000000ffffff9c
[1282119.364381] RBP: 00007f47acb90b48 R08: 0000000000000000 R09: 
0000561f71986760
[1282119.369496] R10: 00000000000001b6 R11: 0000000000000293 R12: 
0000000000080241
[1282119.374035] R13: 00007f47acce1a80 R14: 00007f47adc43248 R15: 
0000000000000000
[1282119.377852]  </TASK>
[1282119.379101] INFO: task VM Periodic Tas:11249 blocked for more than 
123 seconds.
[1282119.383214]       Not tainted 5.15.63-flatcar #1
[1282119.385459] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.389306] task:VM Periodic Tas state:D stack:    0 pid:11249 
ppid:  8007 flags:0x00000000
[1282119.393418] Call Trace:
[1282119.394722]  <TASK>
[1282119.395852]  __schedule+0x2eb/0x8d0
[1282119.397882]  schedule+0x5b/0xd0
[1282119.399608]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.402324]  ? wait_woken+0x70/0x70
[1282119.404155]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.406854]  ? update_load_avg+0x7a/0x5e0
[1282119.408822]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.411679]  ? psi_task_switch+0x1e0/0x200
[1282119.414387]  ? __cond_resched+0x16/0x50
[1282119.416760]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.419236]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.421878]  ext4_dirty_inode+0x35/0x80 [ext4]
[1282119.424391]  __mark_inode_dirty+0x147/0x320
[1282119.426430]  generic_update_time+0x6c/0xd0
[1282119.428570]  file_update_time+0x127/0x140
[1282119.430744]  ext4_page_mkwrite+0x86/0xc50 [ext4]
[1282119.433058]  do_page_mkwrite+0x55/0xc0
[1282119.434861]  do_wp_page+0x20a/0x300
[1282119.436643]  ? task_tick_fair+0x7c/0x370
[1282119.438526]  __handle_mm_fault+0xb7a/0x1470
[1282119.440623]  handle_mm_fault+0xcf/0x2b0
[1282119.442491]  do_user_addr_fault+0x1be/0x670
[1282119.444588]  exc_page_fault+0x68/0x140
[1282119.446694]  asm_exc_page_fault+0x21/0x30
[1282119.448720] RIP: 0033:0x7f08a7c0b29e
[1282119.450453] RSP: 002b:00007f0879ffed30 EFLAGS: 00010206
[1282119.453058] RAX: 00048c1340635bb2 RBX: 00007f08a66851b8 RCX: 
0000000000000018
[1282119.456630] RDX: 0000000000000000 RSI: 0000000000138faa RDI: 
0000000000000001
[1282119.460183] RBP: 00007f0879ffed40 R08: 0000000000000000 R09: 
0000000000000032
[1282119.467273] R10: 00007ffe86f54080 R11: 00007ffe86f54090 R12: 
0000000000000008
[1282119.470823] R13: 00007f08a0303b40 R14: 0000000000000002 R15: 
0000000000000001
[1282119.474328]  </TASK>
[1282119.475620] INFO: task jenkins.util.Ti:11283 blocked for more than 
123 seconds.
[1282119.479241]       Not tainted 5.15.63-flatcar #1
[1282119.481472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.485306] task:jenkins.util.Ti state:D stack:    0 pid:11283 
ppid:  8007 flags:0x00000000
[1282119.489061] Call Trace:
[1282119.490271]  <TASK>
[1282119.491341]  __schedule+0x2eb/0x8d0
[1282119.492969]  schedule+0x5b/0xd0
[1282119.494583]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.497032]  ? wait_woken+0x70/0x70
[1282119.498657]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.501246]  ? pagecache_get_page+0x28b/0x470
[1282119.503242]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.505761]  ? __cond_resched+0x16/0x50
[1282119.507555]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.509870]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.512310]  __ext4_new_inode+0x73f/0x1710 [ext4]
[1282119.514499]  ext4_insert_dentry+0x1c75/0x1d30 [ext4]
[1282119.517080]  path_openat+0xf4b/0x1280
[1282119.518780]  do_filp_open+0xa9/0x150
[1282119.520453]  ? vfs_statx+0x74/0x130
[1282119.522096]  ? __check_object_size+0x146/0x160
[1282119.524139]  do_sys_openat2+0x9b/0x160
[1282119.525976]  __x64_sys_openat+0x54/0xa0
[1282119.527774]  do_syscall_64+0x3b/0x90
[1282119.529493]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[1282119.531871] RIP: 0033:0x7f08a89067e4
[1282119.533542] RSP: 002b:00007f08079fa410 EFLAGS: 00000293 ORIG_RAX: 
0000000000000101
[1282119.536954] RAX: ffffffffffffffda RBX: 00007f08079fa588 RCX: 
00007f08a89067e4
[1282119.540170] RDX: 00000000000000c2 RSI: 00007f084c02c500 RDI: 
00000000ffffff9c
[1282119.543579] RBP: 00007f084c02c500 R08: 0000000000000000 R09: 
00000007acb8f77e
[1282119.546883] R10: 00000000000001b6 R11: 0000000000000293 R12: 
00000000000000c2
[1282119.550079] R13: 00000000000000c2 R14: 00007f084c02c500 R15: 
00007f08240f4000
[1282119.553255]  </TASK>
[1282119.554327] INFO: task SCM polling for:13607 blocked for more than 
123 seconds.
[1282119.557600]       Not tainted 5.15.63-flatcar #1
[1282119.559902] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.563425] task:SCM polling for state:D stack:    0 pid:13607 
ppid:  8007 flags:0x00000000
[1282119.567152] Call Trace:
[1282119.568335]  <TASK>
[1282119.569377]  __schedule+0x2eb/0x8d0
[1282119.571001]  ? recalibrate_cpu_khz+0x10/0x10
[1282119.572959]  schedule+0x5b/0xd0
[1282119.575701]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.578165]  ? wait_woken+0x70/0x70
[1282119.579791]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.582297]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.584770]  ? __update_load_avg_cfs_rq+0x28c/0x310
[1282119.587014]  ? __cond_resched+0x16/0x50
[1282119.588776]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.591102]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.593532]  ext4_setattr+0x3a8/0x9a0 [ext4]
[1282119.595540]  notify_change+0x3c4/0x540
[1282119.597319]  ? ext4_es_delayed_clu+0x170/0x430 [ext4]
[1282119.599641]  ? ext4_es_delayed_clu+0x1ef/0x430 [ext4]
[1282119.601964]  ? do_truncate+0x7d/0xd0
[1282119.603622]  do_truncate+0x7d/0xd0
[1282119.605236]  path_openat+0x24d/0x1280
[1282119.606999]  do_filp_open+0xa9/0x150
[1282119.608658]  ? __fput+0xff/0x250
[1282119.610171]  ? __check_object_size+0x146/0x160
[1282119.612351]  do_sys_openat2+0x9b/0x160
[1282119.614152]  __x64_sys_openat+0x54/0xa0
[1282119.615983]  do_syscall_64+0x3b/0x90
[1282119.617649]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[1282119.619993] RIP: 0033:0x7f08a89067e4
[1282119.621775] RSP: 002b:00007f07f7faa2e0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000101
[1282119.625933] RAX: ffffffffffffffda RBX: 000000071bca3a90 RCX: 
00007f08a89067e4
[1282119.629183] RDX: 0000000000000241 RSI: 00007f0840094c40 RDI: 
00000000ffffff9c
[1282119.632397] RBP: 00007f0840094c40 R08: 0000000000000000 R09: 
0000000000000051
[1282119.635645] R10: 00000000000001b6 R11: 0000000000000293 R12: 
0000000000000241
[1282119.638964] R13: 0000000000000241 R14: 00007f0840094c40 R15: 
00007f081402cb48
[1282119.642228]  </TASK>
[1282119.643335] INFO: task Handling GET /l:830503 blocked for more than 
123 seconds.
[1282119.646702]       Not tainted 5.15.63-flatcar #1
[1282119.648846] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.652383] task:Handling GET /l state:D stack:    0 pid:830503 
ppid:  8007 flags:0x00000000
[1282119.656380] Call Trace:
[1282119.657559]  <TASK>
[1282119.658594]  __schedule+0x2eb/0x8d0
[1282119.660229]  ? trigger_load_balance+0x60/0x300
[1282119.662271]  schedule+0x5b/0xd0
[1282119.663751]  rwsem_down_read_slowpath+0x32c/0x380
[1282119.665950]  ? hw_breakpoint_exceptions_notify+0x30/0xf0
[1282119.668366]  ? ktime_get+0x38/0xa0
[1282119.670018]  do_user_addr_fault+0x42f/0x670
[1282119.672059]  ? read_hv_sched_clock_tsc+0x5/0x40
[1282119.674158]  exc_page_fault+0x68/0x140
[1282119.675939]  asm_exc_page_fault+0x21/0x30
[1282119.677791] RIP: 0033:0x7f08a77a4d3c
[1282119.679642] RSP: 002b:00007f07f521bff0 EFLAGS: 00010202
[1282119.682089] RAX: 00007f08a6683d28 RBX: 00007f08a00402d0 RCX: 
000000009c700000
[1282119.685259] RDX: 000000007ce00000 RSI: 000000007ce00000 RDI: 
00007f08a0195bb0
[1282119.691672] RBP: 00007f07f521bff0 R08: 00007f08a850987c R09: 
00007f0835091f20
[1282119.694867] R10: ffffffffffffffff R11: 0000000000000000 R12: 
00007f083c9b61d0
[1282119.698137] R13: 0000000000000000 R14: 00007f08a76e57b0 R15: 
0000000000000800
[1282119.701408]  </TASK>
[1282119.702576] INFO: task org.jenkinsci.p:875804 blocked for more than 
123 seconds.
[1282119.705988]       Not tainted 5.15.63-flatcar #1
[1282119.708152] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.711696] task:org.jenkinsci.p state:D stack:    0 pid:875804 
ppid:  8007 flags:0x00000000
[1282119.715495] Call Trace:
[1282119.716676]  <TASK>
[1282119.717757]  __schedule+0x2eb/0x8d0
[1282119.719495]  ? update_load_avg+0x7a/0x5e0
[1282119.721348]  schedule+0x5b/0xd0
[1282119.722885]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.725377]  ? wait_woken+0x70/0x70
[1282119.727048]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.729522]  ? timerqueue_del+0x2a/0x50
[1282119.731304]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.733797]  ? hrtimer_cancel+0x1d/0x40
[1282119.735798]  ? futex_wait+0x21a/0x240
[1282119.737584]  ? __cond_resched+0x16/0x50
[1282119.739363]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.741573]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.743920]  ext4_dirty_inode+0x35/0x80 [ext4]
[1282119.745987]  __mark_inode_dirty+0x147/0x320
[1282119.748024]  generic_update_time+0x6c/0xd0
[1282119.749950]  file_update_time+0x127/0x140
[1282119.751906]  ? generic_write_checks+0x61/0xc0
[1282119.753905]  ext4_llseek+0x3fa/0x1cb0 [ext4]
[1282119.755906]  new_sync_write+0x11c/0x1b0
[1282119.757693]  ? intel_get_event_constraints+0x300/0x390
[1282119.760046]  vfs_write+0x1de/0x270
[1282119.761659]  ksys_write+0x5f/0xe0
[1282119.763218]  do_syscall_64+0x3b/0x90
[1282119.764911]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[1282119.767352] RIP: 0033:0x7f08a8905fef
[1282119.769060] RSP: 002b:00007f07f1ade4c0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[1282119.772473] RAX: ffffffffffffffda RBX: 00007f0814407348 RCX: 
00007f08a8905fef
[1282119.775715] RDX: 000000000000005e RSI: 00007f07f1ade540 RDI: 
0000000000000338
[1282119.779100] RBP: 00007f07f1ade510 R08: 0000000000000000 R09: 
000000076ae08648
[1282119.782445] R10: 0000000000178e34 R11: 0000000000000293 R12: 
000000000000005e
[1282119.785816] R13: 00007f07f1ade540 R14: 0000000000000338 R15: 
000000000000005e
[1282119.789069]  </TASK>
[1282119.790140] INFO: task kworker/u8:2:874634 blocked for more than 
123 seconds.
[1282119.793381]       Not tainted 5.15.63-flatcar #1
[1282119.795512] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[1282119.800485] task:kworker/u8:2    state:D stack:    0 pid:874634 
ppid:     2 flags:0x00004000
[1282119.804354] Workqueue: writeback wb_workfn (flush-8:0)
[1282119.806726] Call Trace:
[1282119.807936]  <TASK>
[1282119.809026]  __schedule+0x2eb/0x8d0
[1282119.810692]  schedule+0x5b/0xd0
[1282119.812181]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
[1282119.814641]  ? wait_woken+0x70/0x70
[1282119.816909]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
[1282119.819409]  ? find_get_pages_range+0x197/0x200
[1282119.821507]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
[1282119.823988]  ? ext4_convert_inline_data+0xb07/0x2020 [ext4]
[1282119.826555]  ? __cond_resched+0x16/0x50
[1282119.828352]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[1282119.830542]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[1282119.833049]  __ext4_mark_inode_dirty+0x502/0x1880 [ext4]
[1282119.835474]  ? __cond_resched+0x16/0x50
[1282119.837281]  ? __getblk_gfp+0x27/0x60
[1282119.838986]  ? __ext4_handle_dirty_metadata+0x56/0x19b0 [ext4]
[1282119.841629]  ? ext4_mark_iloc_dirty+0x56a/0xaf0 [ext4]
[1282119.843979]  do_writepages+0xd1/0x200
[1282119.845682]  __writeback_single_inode+0x39/0x290
[1282119.847884]  writeback_sb_inodes+0x20d/0x490
[1282119.849861]  __writeback_inodes_wb+0x4c/0xe0
[1282119.851844]  wb_writeback+0x1c0/0x280
[1282119.853561]  wb_workfn+0x29f/0x4d0
[1282119.855195]  ? psi_task_switch+0x1e0/0x200
[1282119.857128]  process_one_work+0x226/0x3c0
[1282119.859031]  worker_thread+0x50/0x410
[1282119.860747]  ? process_one_work+0x3c0/0x3c0
[1282119.862674]  kthread+0x127/0x150
[1282119.864307]  ? set_kthread_struct+0x50/0x50
[1282119.867863]  ret_from_fork+0x22/0x30
[1282119.869538]  </TASK>
