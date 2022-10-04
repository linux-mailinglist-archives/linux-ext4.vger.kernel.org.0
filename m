Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D25F4556
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJDOVb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJDOV3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 10:21:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB765071A
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 07:21:18 -0700 (PDT)
Received: from [10.254.254.111] (ip5b408877.dynamic.kabel-deutschland.de [91.64.136.119])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0CF1920E6F3B;
        Tue,  4 Oct 2022 07:21:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CF1920E6F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664893277;
        bh=Bnii3SUJRTi52x2jdTDyJL7q1PwHTDTnVeQdjfabBlw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=jnTIz1gat5gGHt9+QkaHGXDG0diPXCF5kI5ax5m7Ce46QWVgwiXSQn6DN6Jw10oH6
         W5R6SCuiRm2+lHTBJIaO6+4DeB3RwvZBQE/hTdKnndjOQ7MNLcqegWvkA9M1xu/mG8
         J/LKU3q03HBMQSGGv3nbakQweRDv8Zdp0ptGxXyw=
Message-ID: <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
Date:   Tue, 4 Oct 2022 16:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, tytso@mit.edu, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
Content-Language: en-US
From:   Thilo Fromm <t-lo@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
In-Reply-To: <20221004091035.idjgo2xyscf6ovnv@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Honza,

On 04/10/2022 11:10, Jan Kara wrote:
> Hello!
> 
> On Mon 03-10-22 23:38:07, Jeremi Piotrowski wrote:
>> On Thu, Sep 29, 2022 at 03:18:21PM +0200, Thilo Fromm wrote:
>>> Thank you very much for your thorough feedback. We were unaware of
>>> the backtrace issue and will have a look at once.
>>>
>>>>>> So this seems like a real issue. Essentially, the problem is that
>>>>>> ext4_bmap() acquires inode->i_rwsem while its caller
>>>>>> jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
>>>>>> looks like a real deadlock possibility.
>>>>>
[...]
>>>>> The issue can be triggered on Flatcar release 3227.2.2 / kernel version
>>>>> 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
>>>>> 51ae846cff5 was introduced to 5.15 in 5.15.61.
>>>>
>>>> Well, so far your stacktraces do not really show anything pointing to that
>>>> particular commit. So we need to understand that hang some more.
>>>
>>> This makes sense and I agree. Sorry for the garbled stack traces.
>>>
>>> In other news, one of our users - who can reliably trigger the issue
>>> in their set-up - ran tests with kernel 5.15.63 with and without
>>> commit 51ae846cff5. Without the commit, the kernel hang did not
>>> occur (see https://github.com/flatcar/Flatcar/issues/847#issuecomment-1261967920).
>>>
[...]
>> So our stacktraces were mangled because historically our kernel build used
>> INSTALL_MOD_STRIP=--strip-unneeded, we've now switched it back to --strip-debug
>> which is the default. We're still using CONFIG_UNWINDER_ORC=y.
>>
>> Here's the hung task output after the change to stripping:
> 
> Yeah, the stacktraces now look as what I'd expect. Thanks for fixing that!
> Sadly they don't point to the culprit of the problem. They show jbd2/sda9-8
> is waiting for someone to drop its transaction handle. Other processes are
> waiting for jbd2/sda9-8 to commit a transaction. And then a few processes
> are waiting for locks held by these waiting processes. But I don't see
> anywhere the process holding the transaction handle. Can you please
> reproduce the problem once more and when the system hangs run:
> 
> echo w >/proc/sysrq-trigger
> 
> Unlike softlockup detector, this will dump all blocked task so hopefully
> we'll see the offending task there. Thanks!

Thank you for the feedback! We forwarded your request to our user with 
the reliable repro case, at 
https://github.com/flatcar/Flatcar/issues/847; please find their blocked 
tasks output below.

Hope this helps & best regards,
Thilo


Blocked tasks output:

[ 3451.530765] sysrq: Show Blocked State
[ 3451.534632] task:jbd2/sda9-8     state:D stack:    0 pid:  704 ppid: 
    2 flags:0x00004000
[ 3451.543107] Call Trace:
[ 3451.545671]  <TASK>
[ 3451.547888]  __schedule+0x2eb/0x8d0
[ 3451.551491]  schedule+0x5b/0xd0
[ 3451.554749]  jbd2_journal_commit_transaction+0x301/0x18e0 [jbd2]
[ 3451.560881]  ? wait_woken+0x70/0x70
[ 3451.564485]  ? lock_timer_base+0x61/0x80
[ 3451.568524]  kjournald2+0xab/0x270 [jbd2]
[ 3451.572657]  ? wait_woken+0x70/0x70
[ 3451.576258]  ? load_superblock.part.0+0xb0/0xb0 [jbd2]
[ 3451.581526]  kthread+0x124/0x150
[ 3451.584874]  ? set_kthread_struct+0x50/0x50
[ 3451.589177]  ret_from_fork+0x1f/0x30
[ 3451.592887]  </TASK>
[ 3451.595193] task:systemd-journal state:D stack:    0 pid: 1103 ppid: 
    1 flags:0x00000224
[ 3451.603656] Call Trace:
[ 3451.606217]  <TASK>
[ 3451.608427]  __schedule+0x2eb/0x8d0
[ 3451.612033]  schedule+0x5b/0xd0
[ 3451.615282]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3451.620452]  ? wait_woken+0x70/0x70
[ 3451.624053]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3451.629310]  ? call_rcu+0xa2/0x330
[ 3451.632829]  start_this_handle+0xfb/0x520 [jbd2]
[ 3451.637576]  ? step_into+0x47c/0x7b0
[ 3451.641268]  ? __cond_resched+0x16/0x50
[ 3451.645218]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3451.650127]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3451.655412]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3451.660013]  __mark_inode_dirty+0x144/0x320
[ 3451.664311]  touch_atime+0x13c/0x150
[ 3451.668004]  filemap_read+0x308/0x320
[ 3451.671781]  ? may_delete+0x2a0/0x2f0
[ 3451.675555]  ? avc_has_perm+0x81/0x1a0
[ 3451.679429]  ? do_filp_open+0xa9/0x150
[ 3451.683295]  new_sync_read+0x116/0x1b0
[ 3451.687158]  ? 0xffffffff93000000
[ 3451.690585]  vfs_read+0xf6/0x190
[ 3451.693926]  __x64_sys_pread64+0x91/0xc0
[ 3451.697967]  do_syscall_64+0x38/0x90
[ 3451.701666]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3451.706835] RIP: 0033:0x7f1bfdbcfb17
[ 3451.710542] RSP: 002b:00007ffe16b30730 EFLAGS: 00000293 ORIG_RAX: 
0000000000000011
[ 3451.718230] RAX: ffffffffffffffda RBX: 00007ffe16b307e0 RCX: 
00007f1bfdbcfb17
[ 3451.725489] RDX: 0000000000000040 RSI: 00007ffe16b30760 RDI: 
0000000000000015
[ 3451.732740] RBP: 0000000002454978 R08: 0000000000000000 R09: 
00007ffe16b30970
[ 3451.739984] R10: 0000000002454978 R11: 0000000000000293 R12: 
0000559666f59f40
[ 3451.747232] R13: 0000000000000000 R14: 00007ffe16b30760 R15: 
0000559666f59f40
[ 3451.754486]  </TASK>
[ 3451.756821] task:systemd-timesyn state:D stack:    0 pid: 1282 ppid: 
    1 flags:0x00000220
[ 3451.765286] Call Trace:
[ 3451.767841]  <TASK>
[ 3451.770052]  __schedule+0x2eb/0x8d0
[ 3451.773653]  schedule+0x5b/0xd0
[ 3451.776908]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3451.782098]  ? wait_woken+0x70/0x70
[ 3451.785706]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3451.790983]  ? __fget_files+0x79/0xb0
[ 3451.794761]  start_this_handle+0xfb/0x520 [jbd2]
[ 3451.799500]  ? nd_jump_link+0x4d/0xc0
[ 3451.803275]  ? __cond_resched+0x16/0x50
[ 3451.807226]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3451.812135]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3451.817414]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3451.821995]  __mark_inode_dirty+0x144/0x320
[ 3451.826297]  ext4_setattr+0x1fb/0x9a0 [ext4]
[ 3451.830700]  notify_change+0x3c1/0x540
[ 3451.834565]  ? vfs_utimes+0x139/0x220
[ 3451.838341]  vfs_utimes+0x139/0x220
[ 3451.841948]  do_utimes+0xb4/0x120
[ 3451.845449]  __x64_sys_utimensat+0x70/0xb0
[ 3451.849663]  ? syscall_trace_enter.constprop.0+0x143/0x1c0
[ 3451.855280]  do_syscall_64+0x38/0x90
[ 3451.858978]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3451.864150] RIP: 0033:0x7fab251a101f
[ 3451.867844] RSP: 002b:00007ffff55ad4c8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000118
[ 3451.875527] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fab251a101f
[ 3451.882786] RDX: 0000000000000000 RSI: 00007ffff55ad4d0 RDI: 
00000000ffffff9c
[ 3451.890041] RBP: 00007ffff55ad4d0 R08: 0000000000000000 R09: 
00007ffff55ad360
[ 3451.897289] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[ 3451.904546] R13: 00000000ffffffff R14: ffffffffffffffff R15: 
00000000ffffffff
[ 3451.911916]  </TASK>
[ 3451.914289] task:k3s-server      state:D stack:    0 pid:70907 ppid: 
    1 flags:0x00000000
[ 3451.922760] Call Trace:
[ 3451.925313]  <TASK>
[ 3451.927518]  __schedule+0x2eb/0x8d0
[ 3451.931118]  schedule+0x5b/0xd0
[ 3451.934366]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3451.939265]  chown_common+0x152/0x250
[ 3451.943039]  ? __do_sys_newfstat+0x57/0x60
[ 3451.947239]  ? __fget_files+0x79/0xb0
[ 3451.951026]  ksys_fchown+0x74/0xb0
[ 3451.954542]  __x64_sys_fchown+0x16/0x20
[ 3451.958497]  do_syscall_64+0x38/0x90
[ 3451.962189]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3451.967357] RIP: 0033:0x444aeb8
[ 3451.970625] RSP: 002b:00007efda626b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3451.978317] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3451.985572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c5
[ 3451.992838] RBP: 00007efda4ddcf48 R08: 00000000000001c5 R09: 
0000000005bf68db
[ 3452.000097] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c5
[ 3452.007346] R13: 00007efda2f98b2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.014601]  </TASK>
[ 3452.016907] task:k3s-server      state:D stack:    0 pid:70909 ppid: 
    1 flags:0x00000000
[ 3452.025376] Call Trace:
[ 3452.027938]  <TASK>
[ 3452.030150]  __schedule+0x2eb/0x8d0
[ 3452.033758]  schedule+0x5b/0xd0
[ 3452.037014]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.041922]  chown_common+0x152/0x250
[ 3452.045704]  ? __do_sys_newfstat+0x57/0x60
[ 3452.049917]  ? __fget_files+0x79/0xb0
[ 3452.053697]  ksys_fchown+0x74/0xb0
[ 3452.057223]  __x64_sys_fchown+0x16/0x20
[ 3452.061175]  do_syscall_64+0x38/0x90
[ 3452.064863]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.070030] RIP: 0033:0x444aeb8
[ 3452.073290] RSP: 002b:00007efda61e56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.080974] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.088221] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000230
[ 3452.095466] RBP: 00007efda441aa88 R08: 0000000000000230 R09: 
0000000005bf68db
[ 3452.102725] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000230
[ 3452.109985] R13: 00007efda29179bd R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.117235]  </TASK>
[ 3452.119556] task:k3s-server      state:D stack:    0 pid:70911 ppid: 
    1 flags:0x00000000
[ 3452.128031] Call Trace:
[ 3452.130587]  <TASK>
[ 3452.132793]  __schedule+0x2eb/0x8d0
[ 3452.136393]  schedule+0x5b/0xd0
[ 3452.139644]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.144552]  chown_common+0x152/0x250
[ 3452.148327]  ? __do_sys_newfstat+0x57/0x60
[ 3452.152532]  ? __fget_files+0x79/0xb0
[ 3452.156303]  ksys_fchown+0x74/0xb0
[ 3452.159814]  __x64_sys_fchown+0x16/0x20
[ 3452.163768]  do_syscall_64+0x38/0x90
[ 3452.167462]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.172626] RIP: 0033:0x444aeb8
[ 3452.175880] RSP: 002b:00007efda5fbf6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.183560] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.190804] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000244
[ 3452.198050] RBP: 00007efda4311f08 R08: 0000000000000244 R09: 
0000000005bf68db
[ 3452.205289] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000244
[ 3452.212534] R13: 00007efda42da36d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.219779]  </TASK>
[ 3452.222075] task:k3s-server      state:D stack:    0 pid:70912 ppid: 
    1 flags:0x00000000
[ 3452.230535] Call Trace:
[ 3452.233089]  <TASK>
[ 3452.235294]  __schedule+0x2eb/0x8d0
[ 3452.238894]  schedule+0x5b/0xd0
[ 3452.242145]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.247054]  chown_common+0x152/0x250
[ 3452.250832]  ? __do_sys_newfstat+0x57/0x60
[ 3452.255048]  ? __fget_files+0x79/0xb0
[ 3452.258821]  ksys_fchown+0x74/0xb0
[ 3452.262333]  __x64_sys_fchown+0x16/0x20
[ 3452.266280]  do_syscall_64+0x38/0x90
[ 3452.269974]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.275137] RIP: 0033:0x444aeb8
[ 3452.278389] RSP: 002b:00007efda5f8c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.286065] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.293307] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e0
[ 3452.300552] RBP: 00007efda45099c8 R08: 00000000000001e0 R09: 
0000000005bf68db
[ 3452.307795] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e0
[ 3452.315041] R13: 00007efda42f22ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.322289]  </TASK>
[ 3452.324588] task:k3s-server      state:D stack:    0 pid:70914 ppid: 
    1 flags:0x00000000
[ 3452.333052] Call Trace:
[ 3452.335615]  <TASK>
[ 3452.337834]  __schedule+0x2eb/0x8d0
[ 3452.341443]  schedule+0x5b/0xd0
[ 3452.344696]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.349601]  chown_common+0x152/0x250
[ 3452.353377]  ? __do_sys_newfstat+0x57/0x60
[ 3452.357582]  ? __fget_files+0x79/0xb0
[ 3452.361356]  ksys_fchown+0x74/0xb0
[ 3452.364868]  __x64_sys_fchown+0x16/0x20
[ 3452.368811]  do_syscall_64+0x38/0x90
[ 3452.372495]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.377659] RIP: 0033:0x444aeb8
[ 3452.380909] RSP: 002b:00007efda5f066b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.388594] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.395836] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000024c
[ 3452.403079] RBP: 00007efda4068608 R08: 000000000000024c R09: 
0000000005bf68db
[ 3452.410321] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000024c
[ 3452.417569] R13: 00007efda362926d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.424820]  </TASK>
[ 3452.427121] task:k3s-server      state:D stack:    0 pid:70915 ppid: 
    1 flags:0x00000000
[ 3452.435586] Call Trace:
[ 3452.438143]  <TASK>
[ 3452.440356]  __schedule+0x2eb/0x8d0
[ 3452.443963]  schedule+0x5b/0xd0
[ 3452.447215]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.452119]  chown_common+0x152/0x250
[ 3452.455891]  ? __do_sys_newfstat+0x57/0x60
[ 3452.460095]  ? __fget_files+0x79/0xb0
[ 3452.463865]  ksys_fchown+0x74/0xb0
[ 3452.467375]  __x64_sys_fchown+0x16/0x20
[ 3452.471319]  do_syscall_64+0x38/0x90
[ 3452.475005]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.480167] RIP: 0033:0x444aeb8
[ 3452.483417] RSP: 002b:00007efda5ee36b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.491097] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.498341] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000231
[ 3452.505584] RBP: 00007efda441acc8 R08: 0000000000000231 R09: 
0000000005bf68db
[ 3452.512826] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000231
[ 3452.520077] R13: 00007efda587d75d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.527329]  </TASK>
[ 3452.529630] task:k3s-server      state:D stack:    0 pid:70916 ppid: 
    1 flags:0x00000000
[ 3452.538087] Call Trace:
[ 3452.540643]  <TASK>
[ 3452.542854]  __schedule+0x2eb/0x8d0
[ 3452.546460]  schedule+0x5b/0xd0
[ 3452.549714]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.554622]  chown_common+0x152/0x250
[ 3452.558397]  ? __do_sys_newfstat+0x57/0x60
[ 3452.562605]  ? __fget_files+0x79/0xb0
[ 3452.566388]  ksys_fchown+0x74/0xb0
[ 3452.569900]  __x64_sys_fchown+0x16/0x20
[ 3452.573847]  do_syscall_64+0x38/0x90
[ 3452.577548]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.582727] RIP: 0033:0x444aeb8
[ 3452.585981] RSP: 002b:00007efda5dc06b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.593665] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.600909] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000239
[ 3452.608155] RBP: 00007efda4067888 R08: 0000000000000239 R09: 
0000000005bf68db
[ 3452.615407] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000239
[ 3452.622653] R13: 00007efda4c5f36d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.629899]  </TASK>
[ 3452.632200] task:k3s-server      state:D stack:    0 pid:70917 ppid: 
    1 flags:0x00000000
[ 3452.640667] Call Trace:
[ 3452.643228]  <TASK>
[ 3452.645437]  __schedule+0x2eb/0x8d0
[ 3452.649048]  schedule+0x5b/0xd0
[ 3452.652303]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.657211]  chown_common+0x152/0x250
[ 3452.660995]  ? __do_sys_newfstat+0x57/0x60
[ 3452.665208]  ? __fget_files+0x79/0xb0
[ 3452.668988]  ksys_fchown+0x74/0xb0
[ 3452.672505]  __x64_sys_fchown+0x16/0x20
[ 3452.676454]  do_syscall_64+0x38/0x90
[ 3452.680144]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.685322] RIP: 0033:0x444aeb8
[ 3452.688574] RSP: 002b:00007efda5d9d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.696257] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.703505] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d5
[ 3452.710753] RBP: 00007efda45be3d8 R08: 00000000000001d5 R09: 
0000000005bf68db
[ 3452.718004] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d5
[ 3452.725250] R13: 00007efda22dea3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.732505]  </TASK>
[ 3452.734808] task:k3s-server      state:D stack:    0 pid:70918 ppid: 
    1 flags:0x00000000
[ 3452.743273] Call Trace:
[ 3452.745832]  <TASK>
[ 3452.748047]  __schedule+0x2eb/0x8d0
[ 3452.751654]  schedule+0x5b/0xd0
[ 3452.754910]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.759822]  chown_common+0x152/0x250
[ 3452.763599]  ? __do_sys_newfstat+0x57/0x60
[ 3452.767813]  ? __fget_files+0x79/0xb0
[ 3452.771592]  ksys_fchown+0x74/0xb0
[ 3452.775108]  __x64_sys_fchown+0x16/0x20
[ 3452.779058]  do_syscall_64+0x38/0x90
[ 3452.782751]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.787916] RIP: 0033:0x444aeb8
[ 3452.791170] RSP: 002b:00007efda5d2a6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.798849] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.806097] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000189
[ 3452.813352] RBP: 00007efda4067648 R08: 0000000000000189 R09: 
0000000005bf68db
[ 3452.820599] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000189
[ 3452.827846] R13: 00007efda3e7a2ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.835096]  </TASK>
[ 3452.837399] task:k3s-server      state:D stack:    0 pid:70919 ppid: 
    1 flags:0x00000000
[ 3452.845869] Call Trace:
[ 3452.848429]  <TASK>
[ 3452.850639]  __schedule+0x2eb/0x8d0
[ 3452.854248]  schedule+0x5b/0xd0
[ 3452.857504]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.862412]  chown_common+0x152/0x250
[ 3452.866205]  ? __do_sys_newfstat+0x57/0x60
[ 3452.870422]  ? __fget_files+0x79/0xb0
[ 3452.874199]  ksys_fchown+0x74/0xb0
[ 3452.877716]  __x64_sys_fchown+0x16/0x20
[ 3452.881663]  do_syscall_64+0x38/0x90
[ 3452.885355]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.890521] RIP: 0033:0x444aeb8
[ 3452.893789] RSP: 002b:00007efda5d076b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3452.901482] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3452.908732] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000021f
[ 3452.915986] RBP: 00007efda48caac8 R08: 000000000000021f R09: 
0000000005bf68db
[ 3452.923236] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000021f
[ 3452.930493] R13: 00007efda44f11ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3452.937741]  </TASK>
[ 3452.940044] task:k3s-server      state:D stack:    0 pid:70920 ppid: 
    1 flags:0x00000000
[ 3452.948519] Call Trace:
[ 3452.951080]  <TASK>
[ 3452.953291]  __schedule+0x2eb/0x8d0
[ 3452.956908]  schedule+0x5b/0xd0
[ 3452.960165]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3452.965072]  chown_common+0x152/0x250
[ 3452.968850]  ? __do_sys_newfstat+0x57/0x60
[ 3452.973065]  ? __fget_files+0x79/0xb0
[ 3452.976841]  ksys_fchown+0x74/0xb0
[ 3452.980359]  __x64_sys_fchown+0x16/0x20
[ 3452.984307]  do_syscall_64+0x38/0x90
[ 3452.987996]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3452.993166] RIP: 0033:0x444aeb8
[ 3452.996448] RSP: 002b:00007efda5c646b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.004133] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.011384] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f3
[ 3453.018635] RBP: 00007efda3805158 R08: 00000000000001f3 R09: 
0000000005bf68db
[ 3453.025882] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f3
[ 3453.033146] R13: 00007efda3e73a3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.040405]  </TASK>
[ 3453.042706] task:k3s-server      state:D stack:    0 pid:70921 ppid: 
    1 flags:0x00000000
[ 3453.051173] Call Trace:
[ 3453.053734]  <TASK>
[ 3453.055946]  __schedule+0x2eb/0x8d0
[ 3453.059609]  schedule+0x5b/0xd0
[ 3453.062873]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.067784]  chown_common+0x152/0x250
[ 3453.071571]  ? __do_sys_newfstat+0x57/0x60
[ 3453.075783]  ? __fget_files+0x79/0xb0
[ 3453.079570]  ksys_fchown+0x74/0xb0
[ 3453.083097]  __x64_sys_fchown+0x16/0x20
[ 3453.087047]  do_syscall_64+0x38/0x90
[ 3453.090737]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.095908] RIP: 0033:0x444aeb8
[ 3453.099163] RSP: 002b:00007efda5c416b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.106852] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.114102] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000241
[ 3453.121350] RBP: 00007efda4311848 R08: 0000000000000241 R09: 
0000000005bf68db
[ 3453.128601] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000241
[ 3453.135849] R13: 00007efda29e774d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.143099]  </TASK>
[ 3453.145398] task:k3s-server      state:D stack:    0 pid:70922 ppid: 
    1 flags:0x00000000
[ 3453.153864] Call Trace:
[ 3453.156425]  <TASK>
[ 3453.158636]  __schedule+0x2eb/0x8d0
[ 3453.162244]  schedule+0x5b/0xd0
[ 3453.165502]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.170414]  chown_common+0x152/0x250
[ 3453.174195]  ? __do_sys_newfstat+0x57/0x60
[ 3453.178407]  ? __fget_files+0x79/0xb0
[ 3453.182195]  ksys_fchown+0x74/0xb0
[ 3453.185711]  __x64_sys_fchown+0x16/0x20
[ 3453.189660]  do_syscall_64+0x38/0x90
[ 3453.193350]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.198518] RIP: 0033:0x444aeb8
[ 3453.201775] RSP: 002b:00007efda5b9e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.209457] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.216702] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000259
[ 3453.223949] RBP: 00007efda3756888 R08: 0000000000000259 R09: 
0000000005bf68db
[ 3453.231195] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000259
[ 3453.238443] R13: 00007efda3662f3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.245692]  </TASK>
[ 3453.247994] task:k3s-server      state:D stack:    0 pid:70923 ppid: 
    1 flags:0x00000000
[ 3453.256460] Call Trace:
[ 3453.259021]  <TASK>
[ 3453.261234]  __schedule+0x2eb/0x8d0
[ 3453.264841]  schedule+0x5b/0xd0
[ 3453.268093]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.273006]  chown_common+0x152/0x250
[ 3453.276784]  ? __do_sys_newfstat+0x57/0x60
[ 3453.280997]  ? __fget_files+0x79/0xb0
[ 3453.284773]  ksys_fchown+0x74/0xb0
[ 3453.288286]  __x64_sys_fchown+0x16/0x20
[ 3453.292231]  do_syscall_64+0x38/0x90
[ 3453.295920]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.301086] RIP: 0033:0x444aeb8
[ 3453.304340] RSP: 002b:00007efda5b7b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.312023] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.319270] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f1
[ 3453.326523] RBP: 00007efda37ff578 R08: 00000000000001f1 R09: 
0000000005bf68db
[ 3453.333770] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f1
[ 3453.341019] R13: 00007efda3e6ff8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.348269]  </TASK>
[ 3453.350569] task:k3s-server      state:D stack:    0 pid:70924 ppid: 
    1 flags:0x00000000
[ 3453.359037] Call Trace:
[ 3453.361599]  <TASK>
[ 3453.363814]  __schedule+0x2eb/0x8d0
[ 3453.367421]  schedule+0x5b/0xd0
[ 3453.370676]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.375585]  chown_common+0x152/0x250
[ 3453.379369]  ? __do_sys_newfstat+0x57/0x60
[ 3453.383582]  ? __fget_files+0x79/0xb0
[ 3453.387367]  ksys_fchown+0x74/0xb0
[ 3453.390876]  __x64_sys_fchown+0x16/0x20
[ 3453.394819]  do_syscall_64+0x38/0x90
[ 3453.398503]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.403686] RIP: 0033:0x444aeb8
[ 3453.406953] RSP: 002b:00007efda5b586b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.414640] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.421890] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c8
[ 3453.429140] RBP: 00007efda4ddd188 R08: 00000000000001c8 R09: 
0000000005bf68db
[ 3453.436388] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c8
[ 3453.443635] R13: 00007efda2f9a6cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.450894]  </TASK>
[ 3453.453222] task:k3s-server      state:D stack:    0 pid:70926 ppid: 
    1 flags:0x00000000
[ 3453.461689] Call Trace:
[ 3453.464251]  <TASK>
[ 3453.466459]  __schedule+0x2eb/0x8d0
[ 3453.470065]  schedule+0x5b/0xd0
[ 3453.473313]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.478214]  chown_common+0x152/0x250
[ 3453.481992]  ? __do_sys_newfstat+0x57/0x60
[ 3453.486199]  ? __fget_files+0x79/0xb0
[ 3453.489978]  ksys_fchown+0x74/0xb0
[ 3453.493490]  __x64_sys_fchown+0x16/0x20
[ 3453.497439]  do_syscall_64+0x38/0x90
[ 3453.501126]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.506289] RIP: 0033:0x444aeb8
[ 3453.509537] RSP: 002b:00007efda55cb6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.517228] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.524478] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000020c
[ 3453.531727] RBP: 00007efda4ddc648 R08: 000000000000020c R09: 
0000000005bf68db
[ 3453.538973] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000020c
[ 3453.546217] R13: 00007efda3627f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.553463]  </TASK>
[ 3453.555761] task:k3s-server      state:D stack:    0 pid:70927 ppid: 
    1 flags:0x00000000
[ 3453.564222] Call Trace:
[ 3453.566778]  <TASK>
[ 3453.568991]  __schedule+0x2eb/0x8d0
[ 3453.572606]  schedule+0x5b/0xd0
[ 3453.575864]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.580774]  chown_common+0x152/0x250
[ 3453.584556]  ? __do_sys_newfstat+0x57/0x60
[ 3453.588771]  ? __fget_files+0x79/0xb0
[ 3453.592549]  ksys_fchown+0x74/0xb0
[ 3453.596068]  __x64_sys_fchown+0x16/0x20
[ 3453.600017]  do_syscall_64+0x38/0x90
[ 3453.603704]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.608870] RIP: 0033:0x444aeb8
[ 3453.612120] RSP: 002b:00007efda4e746b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.619804] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.627047] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000122
[ 3453.634299] RBP: 00007efda5776ac8 R08: 0000000000000122 R09: 
0000000005bf68db
[ 3453.641546] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000122
[ 3453.648790] R13: 00007efda45db37d R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.656038]  </TASK>
[ 3453.658339] task:k3s-server      state:D stack:    0 pid:70928 ppid: 
    1 flags:0x00000000
[ 3453.666800] Call Trace:
[ 3453.669355]  <TASK>
[ 3453.671561]  __schedule+0x2eb/0x8d0
[ 3453.675168]  schedule+0x5b/0xd0
[ 3453.678425]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.683331]  chown_common+0x152/0x250
[ 3453.687116]  ? __do_sys_newfstat+0x57/0x60
[ 3453.691320]  ? __fget_files+0x79/0xb0
[ 3453.695094]  ksys_fchown+0x74/0xb0
[ 3453.698605]  __x64_sys_fchown+0x16/0x20
[ 3453.702553]  do_syscall_64+0x38/0x90
[ 3453.706246]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.711413] RIP: 0033:0x444aeb8
[ 3453.714662] RSP: 002b:00007efda4d4f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.722340] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.729581] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000245
[ 3453.736832] RBP: 00007efda40671c8 R08: 0000000000000245 R09: 
0000000005bf68db
[ 3453.744079] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000245
[ 3453.751331] R13: 00007efda20e56cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.758585]  </TASK>
[ 3453.760887] task:k3s-server      state:D stack:    0 pid:70929 ppid: 
    1 flags:0x00000000
[ 3453.769358] Call Trace:
[ 3453.771924]  <TASK>
[ 3453.774134]  __schedule+0x2eb/0x8d0
[ 3453.777743]  schedule+0x5b/0xd0
[ 3453.780999]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.785912]  chown_common+0x152/0x250
[ 3453.789692]  ? __do_sys_newfstat+0x57/0x60
[ 3453.793906]  ? __fget_files+0x79/0xb0
[ 3453.797690]  ksys_fchown+0x74/0xb0
[ 3453.801224]  __x64_sys_fchown+0x16/0x20
[ 3453.805192]  do_syscall_64+0x38/0x90
[ 3453.808883]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.814052] RIP: 0033:0x444aeb8
[ 3453.817305] RSP: 002b:00007efda4a286b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.824985] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.832232] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000025d
[ 3453.839476] RBP: 00007efda3756ac8 R08: 000000000000025d R09: 
0000000005bf68db
[ 3453.846716] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000025d
[ 3453.853958] R13: 00007efda36646ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.861202]  </TASK>
[ 3453.863499] task:k3s-server      state:D stack:    0 pid:70930 ppid: 
    1 flags:0x00000000
[ 3453.871979] Call Trace:
[ 3453.874548]  <TASK>
[ 3453.876767]  __schedule+0x2eb/0x8d0
[ 3453.880369]  schedule+0x5b/0xd0
[ 3453.883619]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.888526]  chown_common+0x152/0x250
[ 3453.892312]  ? __do_sys_newfstat+0x57/0x60
[ 3453.896523]  ? __fget_files+0x79/0xb0
[ 3453.900298]  ksys_fchown+0x74/0xb0
[ 3453.903810]  __x64_sys_fchown+0x16/0x20
[ 3453.907765]  do_syscall_64+0x38/0x90
[ 3453.911457]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3453.916629] RIP: 0033:0x444aeb8
[ 3453.919886] RSP: 002b:00007efda4a056b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3453.927570] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3453.934814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000226
[ 3453.942067] RBP: 00007efda48cba88 R08: 0000000000000226 R09: 
0000000005bf68db
[ 3453.949315] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000226
[ 3453.956562] R13: 00007efda4dfc6cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3453.963809]  </TASK>
[ 3453.966112] task:k3s-server      state:D stack:    0 pid:70931 ppid: 
    1 flags:0x00000000
[ 3453.974580] Call Trace:
[ 3453.977138]  <TASK>
[ 3453.979350]  __schedule+0x2eb/0x8d0
[ 3453.982954]  schedule+0x5b/0xd0
[ 3453.986208]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3453.991114]  chown_common+0x152/0x250
[ 3453.994898]  ? __do_sys_newfstat+0x57/0x60
[ 3453.999112]  ? __fget_files+0x79/0xb0
[ 3454.002895]  ksys_fchown+0x74/0xb0
[ 3454.006411]  __x64_sys_fchown+0x16/0x20
[ 3454.010356]  do_syscall_64+0x38/0x90
[ 3454.014041]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.019211] RIP: 0033:0x444aeb8
[ 3454.022478] RSP: 002b:00007efda49e26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.030174] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.037435] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022b
[ 3454.044696] RBP: 00007efda4419f48 R08: 000000000000022b R09: 
0000000005bf68db
[ 3454.051951] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022b
[ 3454.059203] R13: 00007efda4ecde0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.066454]  </TASK>
[ 3454.068759] task:k3s-server      state:D stack:    0 pid:70932 ppid: 
    1 flags:0x00000000
[ 3454.077228] Call Trace:
[ 3454.079788]  <TASK>
[ 3454.082006]  __schedule+0x2eb/0x8d0
[ 3454.085620]  schedule+0x5b/0xd0
[ 3454.088882]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.093794]  chown_common+0x152/0x250
[ 3454.097576]  ? __do_sys_newfstat+0x57/0x60
[ 3454.101793]  ? __fget_files+0x79/0xb0
[ 3454.105575]  ksys_fchown+0x74/0xb0
[ 3454.109091]  __x64_sys_fchown+0x16/0x20
[ 3454.113040]  do_syscall_64+0x38/0x90
[ 3454.116731]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.121901] RIP: 0033:0x444aeb8
[ 3454.125160] RSP: 002b:00007efda49bf6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.132846] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.140093] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000221
[ 3454.147338] RBP: 00007efda48caf48 R08: 0000000000000221 R09: 
0000000005bf68db
[ 3454.154585] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000221
[ 3454.161833] R13: 00007efda4c60f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.169083]  </TASK>
[ 3454.171380] task:k3s-server      state:D stack:    0 pid:70933 ppid: 
    1 flags:0x00000000
[ 3454.179841] Call Trace:
[ 3454.182398]  <TASK>
[ 3454.184606]  __schedule+0x2eb/0x8d0
[ 3454.188207]  schedule+0x5b/0xd0
[ 3454.191467]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.196375]  chown_common+0x152/0x250
[ 3454.200159]  ? __do_sys_newfstat+0x57/0x60
[ 3454.204373]  ? __fget_files+0x79/0xb0
[ 3454.208153]  ksys_fchown+0x74/0xb0
[ 3454.211670]  __x64_sys_fchown+0x16/0x20
[ 3454.215627]  do_syscall_64+0x38/0x90
[ 3454.219316]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.224481] RIP: 0033:0x444aeb8
[ 3454.227738] RSP: 002b:00007efda499c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.235442] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.242691] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000201
[ 3454.249938] RBP: 00007efda4ed4888 R08: 0000000000000201 R09: 
0000000005bf68db
[ 3454.257201] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000201
[ 3454.264468] R13: 00007efda3be61ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.271731]  </TASK>
[ 3454.274037] task:k3s-server      state:D stack:    0 pid:70934 ppid: 
    1 flags:0x00000000
[ 3454.282501] Call Trace:
[ 3454.285059]  <TASK>
[ 3454.287269]  __schedule+0x2eb/0x8d0
[ 3454.290875]  schedule+0x5b/0xd0
[ 3454.294131]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.299045]  chown_common+0x152/0x250
[ 3454.302825]  ? __do_sys_newfstat+0x57/0x60
[ 3454.307038]  ? __fget_files+0x79/0xb0
[ 3454.310816]  ksys_fchown+0x74/0xb0
[ 3454.314330]  __x64_sys_fchown+0x16/0x20
[ 3454.318279]  do_syscall_64+0x38/0x90
[ 3454.321969]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.327140] RIP: 0033:0x444aeb8
[ 3454.330398] RSP: 002b:00007efda49796b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.338080] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.345327] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001fe
[ 3454.352574] RBP: 00007efda4ed41c8 R08: 00000000000001fe R09: 
0000000005bf68db
[ 3454.359831] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001fe
[ 3454.367076] R13: 00007efda3be1b2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.374323]  </TASK>
[ 3454.376624] task:k3s-server      state:D stack:    0 pid:70935 ppid: 
    1 flags:0x00000000
[ 3454.385095] Call Trace:
[ 3454.387653]  <TASK>
[ 3454.389867]  __schedule+0x2eb/0x8d0
[ 3454.393471]  schedule+0x5b/0xd0
[ 3454.396728]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.401638]  chown_common+0x152/0x250
[ 3454.405416]  ? __do_sys_newfstat+0x57/0x60
[ 3454.409629]  ? __fget_files+0x79/0xb0
[ 3454.413405]  ksys_fchown+0x74/0xb0
[ 3454.416918]  __x64_sys_fchown+0x16/0x20
[ 3454.420868]  do_syscall_64+0x38/0x90
[ 3454.424559]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.429724] RIP: 0033:0x444aeb8
[ 3454.432978] RSP: 002b:00007efda49566b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.440666] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.447912] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000246
[ 3454.455155] RBP: 00007efda4067408 R08: 0000000000000246 R09: 
0000000005bf68db
[ 3454.462401] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000246
[ 3454.469651] R13: 00007efda362ae0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.476913]  </TASK>
[ 3454.479215] task:k3s-server      state:D stack:    0 pid:70936 ppid: 
    1 flags:0x00000000
[ 3454.487680] Call Trace:
[ 3454.490240]  <TASK>
[ 3454.492452]  __schedule+0x2eb/0x8d0
[ 3454.496060]  schedule+0x5b/0xd0
[ 3454.499317]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.504224]  chown_common+0x152/0x250
[ 3454.508001]  ? __do_sys_newfstat+0x57/0x60
[ 3454.512212]  ? __fget_files+0x79/0xb0
[ 3454.515988]  ksys_fchown+0x74/0xb0
[ 3454.519505]  __x64_sys_fchown+0x16/0x20
[ 3454.523457]  do_syscall_64+0x38/0x90
[ 3454.527147]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.532315] RIP: 0033:0x444aeb8
[ 3454.535570] RSP: 002b:00007efda49336b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.543249] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.550493] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001db
[ 3454.557740] RBP: 00007efda4ddd608 R08: 00000000000001db R09: 
0000000005bf68db
[ 3454.564988] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001db
[ 3454.572246] R13: 00007efda2f9d5cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.579504]  </TASK>
[ 3454.581813] task:k3s-server      state:D stack:    0 pid:70937 ppid: 
    1 flags:0x00000000
[ 3454.590280] Call Trace:
[ 3454.592839]  <TASK>
[ 3454.595049]  __schedule+0x2eb/0x8d0
[ 3454.598660]  schedule+0x5b/0xd0
[ 3454.601918]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.606829]  chown_common+0x152/0x250
[ 3454.610604]  ? __do_sys_newfstat+0x57/0x60
[ 3454.614812]  ? __fget_files+0x79/0xb0
[ 3454.618588]  ksys_fchown+0x74/0xb0
[ 3454.622102]  __x64_sys_fchown+0x16/0x20
[ 3454.626045]  do_syscall_64+0x38/0x90
[ 3454.629732]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.634895] RIP: 0033:0x444aeb8
[ 3454.638151] RSP: 002b:00007efda49106b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.645835] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.653079] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000216
[ 3454.660327] RBP: 00007efda4dddcc8 R08: 0000000000000216 R09: 
0000000005bf68db
[ 3454.667572] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000216
[ 3454.674831] R13: 00007efda3e7aaad R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.682073]  </TASK>
[ 3454.684369] task:k3s-server      state:D stack:    0 pid:70938 ppid: 
    1 flags:0x00000000
[ 3454.692827] Call Trace:
[ 3454.695381]  <TASK>
[ 3454.697586]  __schedule+0x2eb/0x8d0
[ 3454.701184]  schedule+0x5b/0xd0
[ 3454.704434]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.709344]  chown_common+0x152/0x250
[ 3454.713118]  ? __do_sys_newfstat+0x57/0x60
[ 3454.717324]  ? __fget_files+0x79/0xb0
[ 3454.721095]  ksys_fchown+0x74/0xb0
[ 3454.724604]  __x64_sys_fchown+0x16/0x20
[ 3454.728547]  do_syscall_64+0x38/0x90
[ 3454.732236]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.737399] RIP: 0033:0x444aeb8
[ 3454.740652] RSP: 002b:00007efda48ed6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.748335] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.755575] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022e
[ 3454.762817] RBP: 00007efda441a608 R08: 000000000000022e R09: 
0000000005bf68db
[ 3454.770065] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022e
[ 3454.777308] R13: 00007efda29146cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.784558]  </TASK>
[ 3454.786858] task:k3s-server      state:D stack:    0 pid:70939 ppid: 
    1 flags:0x00000000
[ 3454.795324] Call Trace:
[ 3454.797884]  <TASK>
[ 3454.800093]  __schedule+0x2eb/0x8d0
[ 3454.803697]  schedule+0x5b/0xd0
[ 3454.806953]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.811854]  chown_common+0x152/0x250
[ 3454.815633]  ? __do_sys_newfstat+0x57/0x60
[ 3454.819864]  ? __fget_files+0x79/0xb0
[ 3454.823641]  ksys_fchown+0x74/0xb0
[ 3454.827150]  __x64_sys_fchown+0x16/0x20
[ 3454.831098]  do_syscall_64+0x38/0x90
[ 3454.834784]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.839950] RIP: 0033:0x444aeb8
[ 3454.843201] RSP: 002b:00007efda48c26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.850888] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.858131] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001cb
[ 3454.865378] RBP: 00007efda48ca888 R08: 00000000000001cb R09: 
0000000005bf68db
[ 3454.872619] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001cb
[ 3454.879863] R13: 00007efda44ef26d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.887105]  </TASK>
[ 3454.889401] task:k3s-server      state:D stack:    0 pid:70940 ppid: 
    1 flags:0x00000000
[ 3454.897861] Call Trace:
[ 3454.900418]  <TASK>
[ 3454.902630]  __schedule+0x2eb/0x8d0
[ 3454.906232]  schedule+0x5b/0xd0
[ 3454.909486]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3454.914397]  chown_common+0x152/0x250
[ 3454.918170]  ? __do_sys_newfstat+0x57/0x60
[ 3454.922375]  ? __fget_files+0x79/0xb0
[ 3454.926147]  ksys_fchown+0x74/0xb0
[ 3454.929654]  __x64_sys_fchown+0x16/0x20
[ 3454.933602]  do_syscall_64+0x38/0x90
[ 3454.937293]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3454.942460] RIP: 0033:0x444aeb8
[ 3454.945713] RSP: 002b:00007efda48386b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3454.953394] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3454.960641] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000238
[ 3454.967884] RBP: 00007efda4310408 R08: 0000000000000238 R09: 
0000000005bf68db
[ 3454.975126] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000238
[ 3454.982374] R13: 00007efda236f64d R14: 0000000000080006 R15: 
00000000000001a4
[ 3454.989621]  </TASK>
[ 3454.991921] task:k3s-server      state:D stack:    0 pid:70941 ppid: 
    1 flags:0x00000000
[ 3455.000384] Call Trace:
[ 3455.002938]  <TASK>
[ 3455.005144]  __schedule+0x2eb/0x8d0
[ 3455.008747]  schedule+0x5b/0xd0
[ 3455.011996]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.016902]  chown_common+0x152/0x250
[ 3455.020679]  ? __do_sys_newfstat+0x57/0x60
[ 3455.024893]  ? __fget_files+0x79/0xb0
[ 3455.028670]  ksys_fchown+0x74/0xb0
[ 3455.032190]  __x64_sys_fchown+0x16/0x20
[ 3455.036139]  do_syscall_64+0x38/0x90
[ 3455.039828]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.044996] RIP: 0033:0x444aeb8
[ 3455.048252] RSP: 002b:00007efda48156b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.055939] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.063185] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000203
[ 3455.070432] RBP: 00007efda4df81c8 R08: 0000000000000203 R09: 
0000000005bf68db
[ 3455.077682] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000203
[ 3455.084929] R13: 00007efda42dda3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.092174]  </TASK>
[ 3455.094474] task:k3s-server      state:D stack:    0 pid:70942 ppid: 
    1 flags:0x00000000
[ 3455.102939] Call Trace:
[ 3455.105510]  <TASK>
[ 3455.107728]  __schedule+0x2eb/0x8d0
[ 3455.111334]  schedule+0x5b/0xd0
[ 3455.114592]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.119498]  chown_common+0x152/0x250
[ 3455.123280]  ? __do_sys_newfstat+0x57/0x60
[ 3455.127490]  ? __fget_files+0x79/0xb0
[ 3455.131266]  ksys_fchown+0x74/0xb0
[ 3455.134782]  __x64_sys_fchown+0x16/0x20
[ 3455.138733]  do_syscall_64+0x38/0x90
[ 3455.142424]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.147589] RIP: 0033:0x444aeb8
[ 3455.150842] RSP: 002b:00007efda47f26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.158526] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.165777] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000214
[ 3455.173028] RBP: 00007efda48cbf08 R08: 0000000000000214 R09: 
0000000005bf68db
[ 3455.180276] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000214
[ 3455.187522] R13: 00007efda28a56cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.194773]  </TASK>
[ 3455.197073] task:k3s-server      state:D stack:    0 pid:70943 ppid: 
    1 flags:0x00000000
[ 3455.205536] Call Trace:
[ 3455.208100]  <TASK>
[ 3455.210311]  __schedule+0x2eb/0x8d0
[ 3455.213917]  schedule+0x5b/0xd0
[ 3455.217170]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.222079]  chown_common+0x152/0x250
[ 3455.225861]  ? __do_sys_newfstat+0x57/0x60
[ 3455.230072]  ? __fget_files+0x79/0xb0
[ 3455.233852]  ksys_fchown+0x74/0xb0
[ 3455.237368]  __x64_sys_fchown+0x16/0x20
[ 3455.241318]  do_syscall_64+0x38/0x90
[ 3455.245011]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.250181] RIP: 0033:0x444aeb8
[ 3455.253434] RSP: 002b:00007efda47cf6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.261120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.268367] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001ee
[ 3455.275611] RBP: 00007efda5535888 R08: 00000000000001ee R09: 
0000000005bf68db
[ 3455.282857] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001ee
[ 3455.290105] R13: 00007efda32bdabd R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.297354]  </TASK>
[ 3455.299654] task:k3s-server      state:D stack:    0 pid:70944 ppid: 
    1 flags:0x00000000
[ 3455.308122] Call Trace:
[ 3455.310682]  <TASK>
[ 3455.312893]  __schedule+0x2eb/0x8d0
[ 3455.316497]  schedule+0x5b/0xd0
[ 3455.319756]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.324665]  chown_common+0x152/0x250
[ 3455.328444]  ? __do_sys_newfstat+0x57/0x60
[ 3455.332655]  ? __fget_files+0x79/0xb0
[ 3455.336435]  ksys_fchown+0x74/0xb0
[ 3455.339951]  __x64_sys_fchown+0x16/0x20
[ 3455.343902]  do_syscall_64+0x38/0x90
[ 3455.347592]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.352758] RIP: 0033:0x444aeb8
[ 3455.356016] RSP: 002b:00007efda47756b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.363698] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.370947] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001eb
[ 3455.378193] RBP: 00007efda37ff0f8 R08: 00000000000001eb R09: 
0000000005bf68db
[ 3455.385437] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001eb
[ 3455.392684] R13: 00007efda547b36d R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.399929]  </TASK>
[ 3455.402230] task:k3s-server      state:D stack:    0 pid:70945 ppid: 
    1 flags:0x00000000
[ 3455.410693] Call Trace:
[ 3455.413251]  <TASK>
[ 3455.415463]  __schedule+0x2eb/0x8d0
[ 3455.419066]  schedule+0x5b/0xd0
[ 3455.422322]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.427230]  chown_common+0x152/0x250
[ 3455.431007]  ? __do_sys_newfstat+0x57/0x60
[ 3455.435218]  ? __fget_files+0x79/0xb0
[ 3455.439000]  ksys_fchown+0x74/0xb0
[ 3455.442512]  __x64_sys_fchown+0x16/0x20
[ 3455.446459]  do_syscall_64+0x38/0x90
[ 3455.450148]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.455313] RIP: 0033:0x444aeb8
[ 3455.458568] RSP: 002b:00007efda46716b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.466250] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.473498] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000249
[ 3455.480742] RBP: 00007efda4067f48 R08: 0000000000000249 R09: 
0000000005bf68db
[ 3455.487985] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000249
[ 3455.495239] R13: 00007efda2915a3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.502486]  </TASK>
[ 3455.504789] task:k3s-server      state:D stack:    0 pid:70947 ppid: 
    1 flags:0x00000000
[ 3455.513254] Call Trace:
[ 3455.515813]  <TASK>
[ 3455.518024]  __schedule+0x2eb/0x8d0
[ 3455.521627]  schedule+0x5b/0xd0
[ 3455.524882]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.529787]  chown_common+0x152/0x250
[ 3455.533568]  ? __do_sys_newfstat+0x57/0x60
[ 3455.537781]  ? __fget_files+0x79/0xb0
[ 3455.541560]  ksys_fchown+0x74/0xb0
[ 3455.545075]  __x64_sys_fchown+0x16/0x20
[ 3455.549025]  do_syscall_64+0x38/0x90
[ 3455.552717]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.557885] RIP: 0033:0x444aeb8
[ 3455.561139] RSP: 002b:00007efda46236b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.568823] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.576072] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000240
[ 3455.583314] RBP: 00007efda4311608 R08: 0000000000000240 R09: 
0000000005bf68db
[ 3455.590556] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000240
[ 3455.597801] R13: 00007efda547ab3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.605048]  </TASK>
[ 3455.607352] task:k3s-server      state:D stack:    0 pid:70948 ppid: 
    1 flags:0x00000000
[ 3455.615815] Call Trace:
[ 3455.618370]  <TASK>
[ 3455.620578]  __schedule+0x2eb/0x8d0
[ 3455.624175]  schedule+0x5b/0xd0
[ 3455.627423]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.632326]  chown_common+0x152/0x250
[ 3455.636099]  ? __do_sys_newfstat+0x57/0x60
[ 3455.640306]  ? __fget_files+0x79/0xb0
[ 3455.644080]  ksys_fchown+0x74/0xb0
[ 3455.647588]  __x64_sys_fchown+0x16/0x20
[ 3455.651535]  do_syscall_64+0x38/0x90
[ 3455.655219]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.660380] RIP: 0033:0x444aeb8
[ 3455.663630] RSP: 002b:00007efda43ff6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.671307] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.678552] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000209
[ 3455.685802] RBP: 00007efda4df8f48 R08: 0000000000000209 R09: 
0000000005bf68db
[ 3455.693043] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000209
[ 3455.700283] R13: 00007efda20e95cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.707528]  </TASK>
[ 3455.709826] task:k3s-server      state:D stack:    0 pid:70949 ppid: 
    1 flags:0x00000000
[ 3455.718282] Call Trace:
[ 3455.720834]  <TASK>
[ 3455.723039]  __schedule+0x2eb/0x8d0
[ 3455.726634]  schedule+0x5b/0xd0
[ 3455.729880]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.734784]  chown_common+0x152/0x250
[ 3455.738560]  ? __do_sys_newfstat+0x57/0x60
[ 3455.742768]  ? __fget_files+0x79/0xb0
[ 3455.746540]  ksys_fchown+0x74/0xb0
[ 3455.750058]  __x64_sys_fchown+0x16/0x20
[ 3455.754002]  do_syscall_64+0x38/0x90
[ 3455.757685]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.762844] RIP: 0033:0x444aeb8
[ 3455.766095] RSP: 002b:00007efda43c36b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.773774] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.781015] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001fa
[ 3455.788257] RBP: 00007efda5535d08 R08: 00000000000001fa R09: 
0000000005bf68db
[ 3455.795498] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001fa
[ 3455.802744] R13: 00007efda32c0e0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.809985]  </TASK>
[ 3455.812284] task:k3s-server      state:D stack:    0 pid:70950 ppid: 
    1 flags:0x00000000
[ 3455.820743] Call Trace:
[ 3455.823296]  <TASK>
[ 3455.825503]  __schedule+0x2eb/0x8d0
[ 3455.829123]  schedule+0x5b/0xd0
[ 3455.832434]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.837345]  chown_common+0x152/0x250
[ 3455.841125]  ? __do_sys_newfstat+0x57/0x60
[ 3455.845339]  ? __fget_files+0x79/0xb0
[ 3455.849114]  ksys_fchown+0x74/0xb0
[ 3455.852626]  __x64_sys_fchown+0x16/0x20
[ 3455.856568]  do_syscall_64+0x38/0x90
[ 3455.860255]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.865420] RIP: 0033:0x444aeb8
[ 3455.868668] RSP: 002b:00007efda40626b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.876343] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.883605] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000242
[ 3455.890847] RBP: 00007efda4311a88 R08: 0000000000000242 R09: 
0000000005bf68db
[ 3455.898092] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000242
[ 3455.905337] R13: 00007efda45dcabd R14: 0000000000080006 R15: 
00000000000001a4
[ 3455.912579]  </TASK>
[ 3455.914875] task:k3s-server      state:D stack:    0 pid:70951 ppid: 
    1 flags:0x00000000
[ 3455.923332] Call Trace:
[ 3455.925885]  <TASK>
[ 3455.928093]  __schedule+0x2eb/0x8d0
[ 3455.931696]  schedule+0x5b/0xd0
[ 3455.934947]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3455.939876]  chown_common+0x152/0x250
[ 3455.943651]  ? __do_sys_newfstat+0x57/0x60
[ 3455.947865]  ? __fget_files+0x79/0xb0
[ 3455.951641]  ksys_fchown+0x74/0xb0
[ 3455.955152]  __x64_sys_fchown+0x16/0x20
[ 3455.959096]  do_syscall_64+0x38/0x90
[ 3455.962787]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3455.967958] RIP: 0033:0x444aeb8
[ 3455.971211] RSP: 002b:00007efda403f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3455.978892] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3455.986134] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000202
[ 3455.993374] RBP: 00007efda4ed4ac8 R08: 0000000000000202 R09: 
0000000005bf68db
[ 3456.000613] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000202
[ 3456.007863] R13: 00007efda3be79ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.015110]  </TASK>
[ 3456.017416] task:k3s-server      state:D stack:    0 pid:70953 ppid: 
    1 flags:0x00000000
[ 3456.025885] Call Trace:
[ 3456.028444]  <TASK>
[ 3456.030659]  __schedule+0x2eb/0x8d0
[ 3456.034266]  schedule+0x5b/0xd0
[ 3456.037522]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.042434]  chown_common+0x152/0x250
[ 3456.046217]  ? __do_sys_newfstat+0x57/0x60
[ 3456.050430]  ? __fget_files+0x79/0xb0
[ 3456.054206]  ksys_fchown+0x74/0xb0
[ 3456.057720]  __x64_sys_fchown+0x16/0x20
[ 3456.061669]  do_syscall_64+0x38/0x90
[ 3456.065362]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.070528] RIP: 0033:0x444aeb8
[ 3456.073784] RSP: 002b:00007efda3ff96b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.081470] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.088719] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001b2
[ 3456.095970] RBP: 00007efda4ddcd08 R08: 00000000000001b2 R09: 
0000000005bf68db
[ 3456.103220] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001b2
[ 3456.110473] R13: 00007efda362cd8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.117727]  </TASK>
[ 3456.120028] task:k3s-server      state:D stack:    0 pid:70954 ppid: 
    1 flags:0x00000000
[ 3456.128492] Call Trace:
[ 3456.131057]  <TASK>
[ 3456.133270]  __schedule+0x2eb/0x8d0
[ 3456.136874]  schedule+0x5b/0xd0
[ 3456.140133]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.145053]  chown_common+0x152/0x250
[ 3456.148838]  ? __do_sys_newfstat+0x57/0x60
[ 3456.153051]  ? __fget_files+0x79/0xb0
[ 3456.156829]  ksys_fchown+0x74/0xb0
[ 3456.160347]  __x64_sys_fchown+0x16/0x20
[ 3456.164295]  do_syscall_64+0x38/0x90
[ 3456.167987]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.173156] RIP: 0033:0x444aeb8
[ 3456.176413] RSP: 002b:00007efda3fb66b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.184114] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.191374] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000228
[ 3456.198619] RBP: 00007efda4419ac8 R08: 0000000000000228 R09: 
0000000005bf68db
[ 3456.205864] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000228
[ 3456.213109] R13: 00007efda4ecaf0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.220360]  </TASK>
[ 3456.222663] task:k3s-server      state:D stack:    0 pid:70955 ppid: 
    1 flags:0x00000000
[ 3456.231129] Call Trace:
[ 3456.233687]  <TASK>
[ 3456.235920]  __schedule+0x2eb/0x8d0
[ 3456.239532]  schedule+0x5b/0xd0
[ 3456.242789]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.247702]  chown_common+0x152/0x250
[ 3456.251484]  ? __do_sys_newfstat+0x57/0x60
[ 3456.255699]  ? __fget_files+0x79/0xb0
[ 3456.259477]  ksys_fchown+0x74/0xb0
[ 3456.262993]  __x64_sys_fchown+0x16/0x20
[ 3456.266945]  do_syscall_64+0x38/0x90
[ 3456.270634]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.275804] RIP: 0033:0x444aeb8
[ 3456.279060] RSP: 002b:00007efda3f726b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.286745] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.294013] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d8
[ 3456.301260] RBP: 00007efda5789768 R08: 00000000000001d8 R09: 
0000000005bf68db
[ 3456.308513] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d8
[ 3456.315760] R13: 00007efda4dfeb3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.323008]  </TASK>
[ 3456.325307] task:k3s-server      state:D stack:    0 pid:70956 ppid: 
    1 flags:0x00000000
[ 3456.333778] Call Trace:
[ 3456.336340]  <TASK>
[ 3456.338555]  __schedule+0x2eb/0x8d0
[ 3456.342163]  schedule+0x5b/0xd0
[ 3456.345422]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.350332]  chown_common+0x152/0x250
[ 3456.354112]  ? __do_sys_newfstat+0x57/0x60
[ 3456.358322]  ? __fget_files+0x79/0xb0
[ 3456.362103]  ksys_fchown+0x74/0xb0
[ 3456.365620]  __x64_sys_fchown+0x16/0x20
[ 3456.369573]  do_syscall_64+0x38/0x90
[ 3456.373263]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.378432] RIP: 0033:0x444aeb8
[ 3456.381688] RSP: 002b:00007efda3f4f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.389372] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.396620] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001da
[ 3456.403871] RBP: 00007efda45c1018 R08: 00000000000001da R09: 
0000000005bf68db
[ 3456.411120] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001da
[ 3456.418369] R13: 00007efda462636d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.425622]  </TASK>
[ 3456.427932] task:k3s-server      state:D stack:    0 pid:70963 ppid: 
    1 flags:0x00000000
[ 3456.436406] Call Trace:
[ 3456.438970]  <TASK>
[ 3456.441194]  __schedule+0x2eb/0x8d0
[ 3456.444800]  schedule+0x5b/0xd0
[ 3456.448059]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.452967]  chown_common+0x152/0x250
[ 3456.456750]  ? __do_sys_newfstat+0x57/0x60
[ 3456.460963]  ? __fget_files+0x79/0xb0
[ 3456.464744]  ksys_fchown+0x74/0xb0
[ 3456.468264]  __x64_sys_fchown+0x16/0x20
[ 3456.472214]  do_syscall_64+0x38/0x90
[ 3456.475913]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.481078] RIP: 0033:0x444aeb8
[ 3456.484330] RSP: 002b:00007efda37526b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.492013] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.499261] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000233
[ 3456.506512] RBP: 00007efda3756d08 R08: 0000000000000233 R09: 
0000000005bf68db
[ 3456.513760] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000233
[ 3456.521007] R13: 00007efda3665aad R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.528257]  </TASK>
[ 3456.530560] task:k3s-server      state:D stack:    0 pid:70964 ppid: 
    1 flags:0x00000000
[ 3456.539029] Call Trace:
[ 3456.541588]  <TASK>
[ 3456.543801]  __schedule+0x2eb/0x8d0
[ 3456.547411]  schedule+0x5b/0xd0
[ 3456.550665]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.555574]  chown_common+0x152/0x250
[ 3456.559355]  ? __do_sys_newfstat+0x57/0x60
[ 3456.563574]  ? __fget_files+0x79/0xb0
[ 3456.567353]  ksys_fchown+0x74/0xb0
[ 3456.570871]  __x64_sys_fchown+0x16/0x20
[ 3456.574824]  do_syscall_64+0x38/0x90
[ 3456.578514]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.583687] RIP: 0033:0x444aeb8
[ 3456.586952] RSP: 002b:00007efda361d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.594636] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.601887] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022f
[ 3456.609139] RBP: 00007efda441a848 R08: 000000000000022f R09: 
0000000005bf68db
[ 3456.616389] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022f
[ 3456.623634] R13: 00007efda2915e8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.630891]  </TASK>
[ 3456.633197] task:k3s-server      state:D stack:    0 pid:70965 ppid: 
    1 flags:0x00000000
[ 3456.641664] Call Trace:
[ 3456.644224]  <TASK>
[ 3456.646438]  __schedule+0x2eb/0x8d0
[ 3456.650043]  schedule+0x5b/0xd0
[ 3456.653299]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.658212]  chown_common+0x152/0x250
[ 3456.661991]  ? __do_sys_newfstat+0x57/0x60
[ 3456.666203]  ? __fget_files+0x79/0xb0
[ 3456.669981]  ksys_fchown+0x74/0xb0
[ 3456.673499]  __x64_sys_fchown+0x16/0x20
[ 3456.677451]  do_syscall_64+0x38/0x90
[ 3456.681143]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.686312] RIP: 0033:0x444aeb8
[ 3456.689566] RSP: 002b:00007efda35fa6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.697249] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.704491] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000019b
[ 3456.711738] RBP: 00007efda48ca408 R08: 000000000000019b R09: 
0000000005bf68db
[ 3456.718983] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000019b
[ 3456.726230] R13: 00007efda44eb36d R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.733475]  </TASK>
[ 3456.735775] task:k3s-server      state:D stack:    0 pid:70966 ppid: 
    1 flags:0x00000000
[ 3456.744237] Call Trace:
[ 3456.746806]  <TASK>
[ 3456.749018]  __schedule+0x2eb/0x8d0
[ 3456.752625]  schedule+0x5b/0xd0
[ 3456.755878]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3456.761058]  ? wait_woken+0x70/0x70
[ 3456.764657]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3456.769905]  ? update_load_avg+0x7a/0x5e0
[ 3456.774026]  start_this_handle+0xfb/0x520 [jbd2]
[ 3456.778754]  ? __cond_resched+0x16/0x50
[ 3456.782700]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3456.787603]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3456.792877]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3456.797448]  __mark_inode_dirty+0x144/0x320
[ 3456.801743]  generic_update_time+0x6c/0xd0
[ 3456.805948]  file_update_time+0x127/0x140
[ 3456.810081]  ? generic_write_checks+0x61/0xc0
[ 3456.814551]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3456.819901]  new_sync_write+0x119/0x1b0
[ 3456.823848]  ? intel_get_event_constraints+0x300/0x390
[ 3456.829105]  vfs_write+0x1de/0x270
[ 3456.832620]  ksys_write+0x5f/0xe0
[ 3456.836045]  do_syscall_64+0x38/0x90
[ 3456.839730]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.844895] RIP: 0033:0x490f5b
[ 3456.848059] RSP: 002b:000000c005e36c88 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3456.855738] RAX: ffffffffffffffda RBX: 000000c000092000 RCX: 
0000000000490f5b
[ 3456.862994] RDX: 00000000000000b9 RSI: 000000c0026ae000 RDI: 
0000000000000070
[ 3456.870238] RBP: 000000c005e36cd8 R08: 00000000000000b9 R09: 
0000000000000004
[ 3456.877483] R10: 0000000000008000 R11: 0000000000000212 R12: 
00007efda35b7c68
[ 3456.884726] R13: 000000000000aa5e R14: 0000000000000001 R15: 
0000000000000000
[ 3456.891971]  </TASK>
[ 3456.894271] task:k3s-server      state:D stack:    0 pid:70967 ppid: 
    1 flags:0x00000000
[ 3456.902742] Call Trace:
[ 3456.905296]  <TASK>
[ 3456.907519]  __schedule+0x2eb/0x8d0
[ 3456.911118]  schedule+0x5b/0xd0
[ 3456.914367]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3456.919274]  chown_common+0x152/0x250
[ 3456.923048]  ? __do_sys_newfstat+0x57/0x60
[ 3456.927254]  ? __fget_files+0x79/0xb0
[ 3456.931027]  ksys_fchown+0x74/0xb0
[ 3456.934544]  __x64_sys_fchown+0x16/0x20
[ 3456.938491]  do_syscall_64+0x38/0x90
[ 3456.942179]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3456.947342] RIP: 0033:0x444aeb8
[ 3456.950594] RSP: 002b:00007efda35936b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3456.958274] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3456.965533] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001fd
[ 3456.972782] RBP: 00007efda5535f48 R08: 00000000000001fd R09: 
0000000005bf68db
[ 3456.980035] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001fd
[ 3456.987287] R13: 00007efda32c29ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3456.994539]  </TASK>
[ 3456.996842] task:k3s-server      state:D stack:    0 pid:70968 ppid: 
    1 flags:0x00000000
[ 3457.005314] Call Trace:
[ 3457.007875]  <TASK>
[ 3457.010088]  __schedule+0x2eb/0x8d0
[ 3457.013693]  schedule+0x5b/0xd0
[ 3457.016954]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.021861]  chown_common+0x152/0x250
[ 3457.025651]  ? __do_sys_newfstat+0x57/0x60
[ 3457.029867]  ? __fget_files+0x79/0xb0
[ 3457.033646]  ksys_fchown+0x74/0xb0
[ 3457.037164]  __x64_sys_fchown+0x16/0x20
[ 3457.041119]  do_syscall_64+0x38/0x90
[ 3457.044809]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.049979] RIP: 0033:0x444aeb8
[ 3457.053233] RSP: 002b:00007efda35706b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.060916] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.068163] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c9
[ 3457.075412] RBP: 00007efda5776f48 R08: 00000000000001c9 R09: 
0000000005bf68db
[ 3457.082680] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c9
[ 3457.089925] R13: 00007efda45de65d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.097188]  </TASK>
[ 3457.099497] task:k3s-server      state:D stack:    0 pid:70969 ppid: 
    1 flags:0x00000000
[ 3457.107966] Call Trace:
[ 3457.110529]  <TASK>
[ 3457.112746]  __schedule+0x2eb/0x8d0
[ 3457.116354]  schedule+0x5b/0xd0
[ 3457.119608]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.124516]  chown_common+0x152/0x250
[ 3457.128299]  ? __do_sys_newfstat+0x57/0x60
[ 3457.132513]  ? __fget_files+0x79/0xb0
[ 3457.136293]  ksys_fchown+0x74/0xb0
[ 3457.139809]  __x64_sys_fchown+0x16/0x20
[ 3457.143757]  do_syscall_64+0x38/0x90
[ 3457.147447]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.152615] RIP: 0033:0x444aeb8
[ 3457.155865] RSP: 002b:00007efda354d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.163547] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.170796] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000208
[ 3457.178046] RBP: 00007efda4df8d08 R08: 0000000000000208 R09: 
0000000005bf68db
[ 3457.185296] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000208
[ 3457.192544] R13: 00007efda20e726d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.199794]  </TASK>
[ 3457.202095] task:k3s-server      state:D stack:    0 pid:70970 ppid: 
    1 flags:0x00000000
[ 3457.210562] Call Trace:
[ 3457.213131]  <TASK>
[ 3457.215343]  __schedule+0x2eb/0x8d0
[ 3457.218955]  schedule+0x5b/0xd0
[ 3457.222217]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.227128]  chown_common+0x152/0x250
[ 3457.230905]  ? __do_sys_newfstat+0x57/0x60
[ 3457.235117]  ? __fget_files+0x79/0xb0
[ 3457.238899]  ksys_fchown+0x74/0xb0
[ 3457.242417]  __x64_sys_fchown+0x16/0x20
[ 3457.246367]  do_syscall_64+0x38/0x90
[ 3457.250057]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.255225] RIP: 0033:0x444aeb8
[ 3457.258486] RSP: 002b:00007efda352a6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.266171] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.273418] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d4
[ 3457.280671] RBP: 00007efda5789d08 R08: 00000000000001d4 R09: 
0000000005bf68db
[ 3457.287926] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d4
[ 3457.295171] R13: 00007efda22de64d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.302424]  </TASK>
[ 3457.304725] task:k3s-server      state:D stack:    0 pid:70971 ppid: 
    1 flags:0x00000000
[ 3457.313190] Call Trace:
[ 3457.315748]  <TASK>
[ 3457.317954]  __schedule+0x2eb/0x8d0
[ 3457.321557]  schedule+0x5b/0xd0
[ 3457.324810]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.329718]  chown_common+0x152/0x250
[ 3457.333497]  ? __do_sys_newfstat+0x57/0x60
[ 3457.337710]  ? __fget_files+0x79/0xb0
[ 3457.341486]  ksys_fchown+0x74/0xb0
[ 3457.345003]  __x64_sys_fchown+0x16/0x20
[ 3457.348951]  do_syscall_64+0x38/0x90
[ 3457.352641]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.357807] RIP: 0033:0x444aeb8
[ 3457.361061] RSP: 002b:00007efda38f56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.368744] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.375992] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000243
[ 3457.383245] RBP: 00007efda4311cc8 R08: 0000000000000243 R09: 
0000000005bf68db
[ 3457.390489] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000243
[ 3457.397737] R13: 00007efda32c0a2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.404981]  </TASK>
[ 3457.407284] task:k3s-server      state:D stack:    0 pid:70972 ppid: 
    1 flags:0x00000000
[ 3457.415747] Call Trace:
[ 3457.418303]  <TASK>
[ 3457.420512]  __schedule+0x2eb/0x8d0
[ 3457.424116]  schedule+0x5b/0xd0
[ 3457.427373]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.432282]  chown_common+0x152/0x250
[ 3457.436061]  ? __do_sys_newfstat+0x57/0x60
[ 3457.440283]  ? __fget_files+0x79/0xb0
[ 3457.444062]  ksys_fchown+0x74/0xb0
[ 3457.447577]  __x64_sys_fchown+0x16/0x20
[ 3457.451526]  do_syscall_64+0x38/0x90
[ 3457.455220]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.460386] RIP: 0033:0x444aeb8
[ 3457.463640] RSP: 002b:00007efda38b26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.471321] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.478568] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000236
[ 3457.485816] RBP: 00007efda441af08 R08: 0000000000000236 R09: 
0000000005bf68db
[ 3457.493060] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000236
[ 3457.500307] R13: 00007efda236cb2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.507557]  </TASK>
[ 3457.509860] task:k3s-server      state:D stack:    0 pid:70973 ppid: 
    1 flags:0x00000000
[ 3457.518330] Call Trace:
[ 3457.520890]  <TASK>
[ 3457.523113]  __schedule+0x2eb/0x8d0
[ 3457.526715]  schedule+0x5b/0xd0
[ 3457.529976]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.534884]  chown_common+0x152/0x250
[ 3457.538663]  ? __do_sys_newfstat+0x57/0x60
[ 3457.542877]  ? __fget_files+0x79/0xb0
[ 3457.546658]  ksys_fchown+0x74/0xb0
[ 3457.550174]  __x64_sys_fchown+0x16/0x20
[ 3457.554122]  do_syscall_64+0x38/0x90
[ 3457.557815]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.562983] RIP: 0033:0x444aeb8
[ 3457.566241] RSP: 002b:00007efda388f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.573927] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.581176] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001ed
[ 3457.588422] RBP: 00007efda5535648 R08: 00000000000001ed R09: 
0000000005bf68db
[ 3457.595669] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001ed
[ 3457.602915] R13: 00007efda32bbf8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.610161]  </TASK>
[ 3457.612463] task:k3s-server      state:D stack:    0 pid:70974 ppid: 
    1 flags:0x00000000
[ 3457.620945] Call Trace:
[ 3457.623502]  <TASK>
[ 3457.625715]  __schedule+0x2eb/0x8d0
[ 3457.629332]  schedule+0x5b/0xd0
[ 3457.632596]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.637506]  chown_common+0x152/0x250
[ 3457.641283]  ? __do_sys_newfstat+0x57/0x60
[ 3457.645496]  ? __fget_files+0x79/0xb0
[ 3457.649273]  ksys_fchown+0x74/0xb0
[ 3457.652789]  __x64_sys_fchown+0x16/0x20
[ 3457.656740]  do_syscall_64+0x38/0x90
[ 3457.660429]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.665597] RIP: 0033:0x444aeb8
[ 3457.668848] RSP: 002b:00007efda386c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.676534] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.683778] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000220
[ 3457.691029] RBP: 00007efda48cad08 R08: 0000000000000220 R09: 
0000000005bf68db
[ 3457.698276] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000220
[ 3457.705524] R13: 00007efda4c5f74d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.712772]  </TASK>
[ 3457.715080] task:k3s-server      state:D stack:    0 pid:70975 ppid: 
    1 flags:0x00000000
[ 3457.723543] Call Trace:
[ 3457.726103]  <TASK>
[ 3457.728315]  __schedule+0x2eb/0x8d0
[ 3457.731926]  schedule+0x5b/0xd0
[ 3457.735182]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.740090]  chown_common+0x152/0x250
[ 3457.743869]  ? __do_sys_newfstat+0x57/0x60
[ 3457.748079]  ? __fget_files+0x79/0xb0
[ 3457.751860]  ksys_fchown+0x74/0xb0
[ 3457.755374]  __x64_sys_fchown+0x16/0x20
[ 3457.759323]  do_syscall_64+0x38/0x90
[ 3457.763013]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.768178] RIP: 0033:0x444aeb8
[ 3457.771432] RSP: 002b:00007efda38496b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.779117] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.786364] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000263
[ 3457.793610] RBP: 00007efda3757188 R08: 0000000000000263 R09: 
0000000005bf68db
[ 3457.800858] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000263
[ 3457.808120] R13: 00007efda366725d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.815369]  </TASK>
[ 3457.817678] task:k3s-server      state:D stack:    0 pid:70980 ppid: 
    1 flags:0x00000000
[ 3457.826139] Call Trace:
[ 3457.828703]  <TASK>
[ 3457.830911]  __schedule+0x2eb/0x8d0
[ 3457.834516]  schedule+0x5b/0xd0
[ 3457.837771]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.842682]  chown_common+0x152/0x250
[ 3457.846458]  ? __do_sys_newfstat+0x57/0x60
[ 3457.850668]  ? __fget_files+0x79/0xb0
[ 3457.854447]  ksys_fchown+0x74/0xb0
[ 3457.857961]  __x64_sys_fchown+0x16/0x20
[ 3457.861911]  do_syscall_64+0x38/0x90
[ 3457.865601]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.870785] RIP: 0033:0x444aeb8
[ 3457.874038] RSP: 002b:00007efda32b16b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.881722] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.888968] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c4
[ 3457.896213] RBP: 00007efda48ca648 R08: 00000000000001c4 R09: 
0000000005bf68db
[ 3457.903461] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c4
[ 3457.910706] R13: 00007efda44ecb2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3457.917952]  </TASK>
[ 3457.920253] task:k3s-server      state:D stack:    0 pid:70981 ppid: 
    1 flags:0x00000000
[ 3457.928719] Call Trace:
[ 3457.931286]  <TASK>
[ 3457.933498]  __schedule+0x2eb/0x8d0
[ 3457.937102]  schedule+0x5b/0xd0
[ 3457.940359]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3457.945266]  chown_common+0x152/0x250
[ 3457.949054]  ? __do_sys_newfstat+0x57/0x60
[ 3457.953265]  ? __fget_files+0x79/0xb0
[ 3457.957044]  ksys_fchown+0x74/0xb0
[ 3457.960562]  __x64_sys_fchown+0x16/0x20
[ 3457.964509]  do_syscall_64+0x38/0x90
[ 3457.968201]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3457.973366] RIP: 0033:0x444aeb8
[ 3457.976623] RSP: 002b:00007efda328e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3457.984309] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3457.991569] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e4
[ 3457.998820] RBP: 00007efda5535408 R08: 00000000000001e4 R09: 
0000000005bf68db
[ 3458.006070] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e4
[ 3458.013319] R13: 00007efda45e15dd R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.020572]  </TASK>
[ 3458.022884] task:k3s-server      state:D stack:    0 pid:70982 ppid: 
    1 flags:0x00000000
[ 3458.031373] Call Trace:
[ 3458.033931]  <TASK>
[ 3458.036142]  __schedule+0x2eb/0x8d0
[ 3458.039747]  schedule+0x5b/0xd0
[ 3458.043003]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.047911]  chown_common+0x152/0x250
[ 3458.051691]  ? __do_sys_newfstat+0x57/0x60
[ 3458.055902]  ? __fget_files+0x79/0xb0
[ 3458.059683]  ksys_fchown+0x74/0xb0
[ 3458.063197]  __x64_sys_fchown+0x16/0x20
[ 3458.067147]  do_syscall_64+0x38/0x90
[ 3458.070841]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.076010] RIP: 0033:0x444aeb8
[ 3458.079277] RSP: 002b:00007efda324b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.086960] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.094208] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f5
[ 3458.101455] RBP: 00007efda38055d8 R08: 00000000000001f5 R09: 
0000000005bf68db
[ 3458.108702] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f5
[ 3458.115957] R13: 00007efda29e674d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.123217]  </TASK>
[ 3458.125533] task:k3s-server      state:D stack:    0 pid:70983 ppid: 
    1 flags:0x00000000
[ 3458.134000] Call Trace:
[ 3458.136566]  <TASK>
[ 3458.138777]  __schedule+0x2eb/0x8d0
[ 3458.142388]  schedule+0x5b/0xd0
[ 3458.145645]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.150559]  chown_common+0x152/0x250
[ 3458.154338]  ? __do_sys_newfstat+0x57/0x60
[ 3458.158554]  ? __fget_files+0x79/0xb0
[ 3458.162325]  ksys_fchown+0x74/0xb0
[ 3458.165836]  __x64_sys_fchown+0x16/0x20
[ 3458.169782]  do_syscall_64+0x38/0x90
[ 3458.173476]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.178642] RIP: 0033:0x444aeb8
[ 3458.181899] RSP: 002b:00007efda32086b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.189582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.196845] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000205
[ 3458.204093] RBP: 00007efda4df8648 R08: 0000000000000205 R09: 
0000000005bf68db
[ 3458.211339] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000205
[ 3458.218586] R13: 00007efda42e09ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.225834]  </TASK>
[ 3458.228136] task:k3s-server      state:D stack:    0 pid:70984 ppid: 
    1 flags:0x00000000
[ 3458.236629] Call Trace:
[ 3458.239190]  <TASK>
[ 3458.241400]  __schedule+0x2eb/0x8d0
[ 3458.245001]  schedule+0x5b/0xd0
[ 3458.248257]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.253164]  chown_common+0x152/0x250
[ 3458.256943]  ? __do_sys_newfstat+0x57/0x60
[ 3458.261154]  ? __fget_files+0x79/0xb0
[ 3458.264932]  ksys_fchown+0x74/0xb0
[ 3458.268446]  __x64_sys_fchown+0x16/0x20
[ 3458.272402]  do_syscall_64+0x38/0x90
[ 3458.276092]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.281264] RIP: 0033:0x444aeb8
[ 3458.284517] RSP: 002b:00007efda31a56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.292210] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.299459] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f0
[ 3458.306718] RBP: 00007efda37ff338 R08: 00000000000001f0 R09: 
0000000005bf68db
[ 3458.313964] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f0
[ 3458.321210] R13: 00007efda547cabd R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.328459]  </TASK>
[ 3458.330764] task:k3s-server      state:D stack:    0 pid:70985 ppid: 
    1 flags:0x00000000
[ 3458.339229] Call Trace:
[ 3458.341793]  <TASK>
[ 3458.344011]  __schedule+0x2eb/0x8d0
[ 3458.347617]  schedule+0x5b/0xd0
[ 3458.350787] systemd[1]: systemd-timesyncd.service: Watchdog timeout 
(limit 3min)!
[ 3458.350877]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.358656] systemd[1]: systemd-timesyncd.service: Killing process 
1282 (systemd-timesyn) with signal SIGABRT.
[ 3458.363385]  chown_common+0x152/0x250
[ 3458.377277]  ? __do_sys_newfstat+0x57/0x60
[ 3458.381492]  ? __fget_files+0x79/0xb0
[ 3458.385268]  ksys_fchown+0x74/0xb0
[ 3458.388792]  __x64_sys_fchown+0x16/0x20
[ 3458.392743]  do_syscall_64+0x38/0x90
[ 3458.396434]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.401602] RIP: 0033:0x444aeb8
[ 3458.404858] RSP: 002b:00007efda31826b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.412538] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.419787] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023b
[ 3458.427037] RBP: 00007efda4310ac8 R08: 000000000000023b R09: 
0000000005bf68db
[ 3458.434285] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023b
[ 3458.441529] R13: 00007efda22db74d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.448778]  </TASK>
[ 3458.451078] task:k3s-server      state:D stack:    0 pid:70986 ppid: 
    1 flags:0x00000000
[ 3458.459540] Call Trace:
[ 3458.462099]  <TASK>
[ 3458.464309]  __schedule+0x2eb/0x8d0
[ 3458.467911]  schedule+0x5b/0xd0
[ 3458.471164]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.476071]  chown_common+0x152/0x250
[ 3458.479853]  ? __do_sys_newfstat+0x57/0x60
[ 3458.484068]  ? __fget_files+0x79/0xb0
[ 3458.487846]  ksys_fchown+0x74/0xb0
[ 3458.491360]  __x64_sys_fchown+0x16/0x20
[ 3458.495310]  do_syscall_64+0x38/0x90
[ 3458.499002]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.504168] RIP: 0033:0x444aeb8
[ 3458.507426] RSP: 002b:00007efda315f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.515106] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.522373] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023c
[ 3458.529622] RBP: 00007efda4310d08 R08: 000000000000023c R09: 
0000000005bf68db
[ 3458.536871] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023c
[ 3458.544116] R13: 00007efda22dd6cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.551362]  </TASK>
[ 3458.553665] task:k3s-server      state:D stack:    0 pid:70987 ppid: 
    1 flags:0x00000000
[ 3458.562130] Call Trace:
[ 3458.564689]  <TASK>
[ 3458.566904]  __schedule+0x2eb/0x8d0
[ 3458.570509]  schedule+0x5b/0xd0
[ 3458.573762]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.578676]  chown_common+0x152/0x250
[ 3458.582453]  ? __do_sys_newfstat+0x57/0x60
[ 3458.586665]  ? __fget_files+0x79/0xb0
[ 3458.590441]  ksys_fchown+0x74/0xb0
[ 3458.593955]  __x64_sys_fchown+0x16/0x20
[ 3458.597902]  do_syscall_64+0x38/0x90
[ 3458.601598]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.606769] RIP: 0033:0x444aeb8
[ 3458.610030] RSP: 002b:00007efda30fa6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.617716] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.624967] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001df
[ 3458.632215] RBP: 00007efda45c16d8 R08: 00000000000001df R09: 
0000000005bf68db
[ 3458.639463] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001df
[ 3458.646712] R13: 00007efda55fab2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.653965]  </TASK>
[ 3458.656264] task:k3s-server      state:D stack:    0 pid:70988 ppid: 
    1 flags:0x00000000
[ 3458.664729] Call Trace:
[ 3458.667288]  <TASK>
[ 3458.669501]  __schedule+0x2eb/0x8d0
[ 3458.673106]  schedule+0x5b/0xd0
[ 3458.676362]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.681272]  chown_common+0x152/0x250
[ 3458.685051]  ? __do_sys_newfstat+0x57/0x60
[ 3458.689260]  ? __fget_files+0x79/0xb0
[ 3458.693041]  ksys_fchown+0x74/0xb0
[ 3458.696556]  __x64_sys_fchown+0x16/0x20
[ 3458.700507]  do_syscall_64+0x38/0x90
[ 3458.704198]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.709365] RIP: 0033:0x444aeb8
[ 3458.712621] RSP: 002b:00007efda30976b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.720302] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.727550] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001bc
[ 3458.734813] RBP: 00007efda4ed4d08 R08: 00000000000001bc R09: 
0000000005bf68db
[ 3458.742067] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001bc
[ 3458.749310] R13: 00007efda42dab2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.756563]  </TASK>
[ 3458.758865] task:k3s-server      state:D stack:    0 pid:70989 ppid: 
    1 flags:0x00000000
[ 3458.767331] Call Trace:
[ 3458.769888]  <TASK>
[ 3458.772100]  __schedule+0x2eb/0x8d0
[ 3458.775714]  schedule+0x5b/0xd0
[ 3458.778988]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.783896]  chown_common+0x152/0x250
[ 3458.787674]  ? __do_sys_newfstat+0x57/0x60
[ 3458.791885]  ? __fget_files+0x79/0xb0
[ 3458.795663]  ksys_fchown+0x74/0xb0
[ 3458.799181]  __x64_sys_fchown+0x16/0x20
[ 3458.803129]  do_syscall_64+0x38/0x90
[ 3458.806818]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.811998] RIP: 0033:0x444aeb8
[ 3458.815247] RSP: 002b:00007efda30746b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.822931] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.830176] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e6
[ 3458.837424] RBP: 00007efda4509d28 R08: 00000000000001e6 R09: 
0000000005bf68db
[ 3458.844670] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e6
[ 3458.851917] R13: 00007efda42f4e0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.859166]  </TASK>
[ 3458.861468] task:k3s-server      state:D stack:    0 pid:70990 ppid: 
    1 flags:0x00000000
[ 3458.869935] Call Trace:
[ 3458.872497]  <TASK>
[ 3458.874709]  __schedule+0x2eb/0x8d0
[ 3458.878330]  schedule+0x5b/0xd0
[ 3458.881607]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.886514]  chown_common+0x152/0x250
[ 3458.890294]  ? __do_sys_newfstat+0x57/0x60
[ 3458.894507]  ? __fget_files+0x79/0xb0
[ 3458.898284]  ksys_fchown+0x74/0xb0
[ 3458.901800]  __x64_sys_fchown+0x16/0x20
[ 3458.905751]  do_syscall_64+0x38/0x90
[ 3458.909443]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3458.914611] RIP: 0033:0x444aeb8
[ 3458.917863] RSP: 002b:00007efda365f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3458.925543] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3458.932790] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f2
[ 3458.940037] RBP: 00007efda3804f18 R08: 00000000000001f2 R09: 
0000000005bf68db
[ 3458.947283] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f2
[ 3458.954535] R13: 00007efda3e71f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3458.961783]  </TASK>
[ 3458.964084] task:k3s-server      state:D stack:    0 pid:70991 ppid: 
    1 flags:0x00000000
[ 3458.972566] Call Trace:
[ 3458.975124]  <TASK>
[ 3458.977335]  __schedule+0x2eb/0x8d0
[ 3458.980937]  schedule+0x5b/0xd0
[ 3458.984192]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3458.989100]  chown_common+0x152/0x250
[ 3458.992880]  ? __do_sys_newfstat+0x57/0x60
[ 3458.997089]  ? __fget_files+0x79/0xb0
[ 3459.000870]  ksys_fchown+0x74/0xb0
[ 3459.004388]  __x64_sys_fchown+0x16/0x20
[ 3459.008335]  do_syscall_64+0x38/0x90
[ 3459.012024]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.017190] RIP: 0033:0x444aeb8
[ 3459.020445] RSP: 002b:00007efda2f6f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.028125] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.035372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000207
[ 3459.042619] RBP: 00007efda4df8ac8 R08: 0000000000000207 R09: 
0000000005bf68db
[ 3459.049867] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000207
[ 3459.057111] R13: 00007efda20e5abd R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.064357]  </TASK>
[ 3459.066661] task:k3s-server      state:D stack:    0 pid:70993 ppid: 
    1 flags:0x00000000
[ 3459.075124] Call Trace:
[ 3459.077682]  <TASK>
[ 3459.079893]  __schedule+0x2eb/0x8d0
[ 3459.083500]  schedule+0x5b/0xd0
[ 3459.086760]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.091664]  chown_common+0x152/0x250
[ 3459.095444]  ? __do_sys_newfstat+0x57/0x60
[ 3459.099656]  ? __fget_files+0x79/0xb0
[ 3459.103436]  ksys_fchown+0x74/0xb0
[ 3459.106944]  __x64_sys_fchown+0x16/0x20
[ 3459.110887]  do_syscall_64+0x38/0x90
[ 3459.114574]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.119741] RIP: 0033:0x444aeb8
[ 3459.122993] RSP: 002b:00007efda2f296b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.130694] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.137943] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f8
[ 3459.145188] RBP: 00007efda5535ac8 R08: 00000000000001f8 R09: 
0000000005bf68db
[ 3459.152439] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f8
[ 3459.159683] R13: 00007efda32bf26d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.166932]  </TASK>
[ 3459.169230] task:k3s-server      state:D stack:    0 pid:70994 ppid: 
    1 flags:0x00000000
[ 3459.177702] Call Trace:
[ 3459.180262]  <TASK>
[ 3459.182479]  __schedule+0x2eb/0x8d0
[ 3459.186090]  schedule+0x5b/0xd0
[ 3459.189345]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.194255]  chown_common+0x152/0x250
[ 3459.198031]  ? __do_sys_newfstat+0x57/0x60
[ 3459.202241]  ? __fget_files+0x79/0xb0
[ 3459.206017]  ksys_fchown+0x74/0xb0
[ 3459.209530]  __x64_sys_fchown+0x16/0x20
[ 3459.213480]  do_syscall_64+0x38/0x90
[ 3459.217175]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.222342] RIP: 0033:0x444aeb8
[ 3459.225599] RSP: 002b:00007efda2f066b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.233280] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.240530] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001ca
[ 3459.247772] RBP: 00007efda4ddd3c8 R08: 00000000000001ca R09: 
0000000005bf68db
[ 3459.255018] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001ca
[ 3459.262281] R13: 00007efda2f9be8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.269528]  </TASK>
[ 3459.271834] task:k3s-server      state:D stack:    0 pid:70995 ppid: 
    1 flags:0x00000000
[ 3459.280307] Call Trace:
[ 3459.282864]  <TASK>
[ 3459.285075]  __schedule+0x2eb/0x8d0
[ 3459.288678]  schedule+0x5b/0xd0
[ 3459.291932]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.296839]  chown_common+0x152/0x250
[ 3459.300618]  ? __do_sys_newfstat+0x57/0x60
[ 3459.304828]  ? __fget_files+0x79/0xb0
[ 3459.308607]  ksys_fchown+0x74/0xb0
[ 3459.312125]  __x64_sys_fchown+0x16/0x20
[ 3459.316073]  do_syscall_64+0x38/0x90
[ 3459.319763]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.324938] RIP: 0033:0x444aeb8
[ 3459.328200] RSP: 002b:00007efda2ec36b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.335880] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.343125] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000021c
[ 3459.350373] RBP: 00007efda44191c8 R08: 000000000000021c R09: 
0000000005bf68db
[ 3459.357618] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000021c
[ 3459.364864] R13: 00007efda28a726d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.372110]  </TASK>
[ 3459.374429] task:k3s-server      state:D stack:    0 pid:70996 ppid: 
    1 flags:0x00000000
[ 3459.382900] Call Trace:
[ 3459.385466]  <TASK>
[ 3459.387676]  __schedule+0x2eb/0x8d0
[ 3459.391280]  schedule+0x5b/0xd0
[ 3459.394537]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.399445]  chown_common+0x152/0x250
[ 3459.403239]  ? __do_sys_newfstat+0x57/0x60
[ 3459.407453]  ? __fget_files+0x79/0xb0
[ 3459.411230]  ksys_fchown+0x74/0xb0
[ 3459.414749]  __x64_sys_fchown+0x16/0x20
[ 3459.418699]  do_syscall_64+0x38/0x90
[ 3459.422393]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.427560] RIP: 0033:0x444aeb8
[ 3459.430816] RSP: 002b:00007efda2ea06b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.438498] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.445746] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023e
[ 3459.452999] RBP: 00007efda4311188 R08: 000000000000023e R09: 
0000000005bf68db
[ 3459.460248] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023e
[ 3459.467493] R13: 00007efda55f9b3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.474740]  </TASK>
[ 3459.477041] task:k3s-server      state:D stack:    0 pid:70997 ppid: 
    1 flags:0x00000000
[ 3459.485508] Call Trace:
[ 3459.488063]  <TASK>
[ 3459.490276]  __schedule+0x2eb/0x8d0
[ 3459.493880]  schedule+0x5b/0xd0
[ 3459.497134]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.502044]  chown_common+0x152/0x250
[ 3459.505821]  ? __do_sys_newfstat+0x57/0x60
[ 3459.510033]  ? __fget_files+0x79/0xb0
[ 3459.513811]  ksys_fchown+0x74/0xb0
[ 3459.517326]  __x64_sys_fchown+0x16/0x20
[ 3459.521274]  do_syscall_64+0x38/0x90
[ 3459.524965]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.530133] RIP: 0033:0x444aeb8
[ 3459.533389] RSP: 002b:00007efda2e5d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.541070] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.548315] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001bd
[ 3459.555562] RBP: 00007efda4ed4f48 R08: 00000000000001bd R09: 
0000000005bf68db
[ 3459.562812] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001bd
[ 3459.570060] R13: 00007efda42dc6cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.577308]  </TASK>
[ 3459.579612] task:k3s-server      state:D stack:    0 pid:70998 ppid: 
    1 flags:0x00000000
[ 3459.588077] Call Trace:
[ 3459.590636]  <TASK>
[ 3459.592846]  __schedule+0x2eb/0x8d0
[ 3459.596452]  schedule+0x5b/0xd0
[ 3459.599704]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.604632]  chown_common+0x152/0x250
[ 3459.608409]  ? __do_sys_newfstat+0x57/0x60
[ 3459.612621]  ? __fget_files+0x79/0xb0
[ 3459.616398]  ksys_fchown+0x74/0xb0
[ 3459.619916]  __x64_sys_fchown+0x16/0x20
[ 3459.623872]  do_syscall_64+0x38/0x90
[ 3459.627563]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.632731] RIP: 0033:0x444aeb8
[ 3459.635985] RSP: 002b:00007efda2e3a6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.643665] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.650914] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000222
[ 3459.658161] RBP: 00007efda48cb188 R08: 0000000000000222 R09: 
0000000005bf68db
[ 3459.665415] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000222
[ 3459.672679] R13: 00007efda4c62aad R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.679927]  </TASK>
[ 3459.682229] task:k3s-server      state:D stack:    0 pid:70999 ppid: 
    1 flags:0x00000000
[ 3459.690696] Call Trace:
[ 3459.693254]  <TASK>
[ 3459.695463]  __schedule+0x2eb/0x8d0
[ 3459.699071]  schedule+0x5b/0xd0
[ 3459.702322]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.707229]  chown_common+0x152/0x250
[ 3459.711010]  ? __do_sys_newfstat+0x57/0x60
[ 3459.715224]  ? __fget_files+0x79/0xb0
[ 3459.719003]  ksys_fchown+0x74/0xb0
[ 3459.722515]  __x64_sys_fchown+0x16/0x20
[ 3459.726463]  do_syscall_64+0x38/0x90
[ 3459.730151]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.735318] RIP: 0033:0x444aeb8
[ 3459.738572] RSP: 002b:00007efda2e176b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.746257] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.753501] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000200
[ 3459.760751] RBP: 00007efda4ed4648 R08: 0000000000000200 R09: 
0000000005bf68db
[ 3459.767998] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000200
[ 3459.775246] R13: 00007efda3be4a3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.782496]  </TASK>
[ 3459.784794] task:k3s-server      state:D stack:    0 pid:71000 ppid: 
    1 flags:0x00000000
[ 3459.793258] Call Trace:
[ 3459.795816]  <TASK>
[ 3459.798027]  __schedule+0x2eb/0x8d0
[ 3459.801632]  schedule+0x5b/0xd0
[ 3459.804887]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.809796]  chown_common+0x152/0x250
[ 3459.813580]  ? __do_sys_newfstat+0x57/0x60
[ 3459.817791]  ? __fget_files+0x79/0xb0
[ 3459.821569]  ksys_fchown+0x74/0xb0
[ 3459.825087]  __x64_sys_fchown+0x16/0x20
[ 3459.829035]  do_syscall_64+0x38/0x90
[ 3459.832724]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.837892] RIP: 0033:0x444aeb8
[ 3459.841147] RSP: 002b:00007efda2d936b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.848836] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.856085] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000218
[ 3459.863327] RBP: 00007efda4dddf08 R08: 0000000000000218 R09: 
0000000005bf68db
[ 3459.870573] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000218
[ 3459.877819] R13: 00007efda3e7be8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.885066]  </TASK>
[ 3459.887366] task:k3s-server      state:D stack:    0 pid:71001 ppid: 
    1 flags:0x00000000
[ 3459.895831] Call Trace:
[ 3459.898386]  <TASK>
[ 3459.900597]  __schedule+0x2eb/0x8d0
[ 3459.904203]  schedule+0x5b/0xd0
[ 3459.907462]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3459.912370]  chown_common+0x152/0x250
[ 3459.916174]  ? __do_sys_newfstat+0x57/0x60
[ 3459.920399]  ? __fget_files+0x79/0xb0
[ 3459.924170]  ksys_fchown+0x74/0xb0
[ 3459.927685]  __x64_sys_fchown+0x16/0x20
[ 3459.931634]  do_syscall_64+0x38/0x90
[ 3459.935325]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3459.940493] RIP: 0033:0x444aeb8
[ 3459.943761] RSP: 002b:00007efda2d706b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3459.951468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3459.958724] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001dd
[ 3459.965971] RBP: 00007efda45c1258 R08: 00000000000001dd R09: 
0000000005bf68db
[ 3459.973216] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001dd
[ 3459.980462] R13: 00007efda46276cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3459.987710]  </TASK>
[ 3459.990013] task:k3s-server      state:D stack:    0 pid:71002 ppid: 
    1 flags:0x00000000
[ 3459.998478] Call Trace:
[ 3460.001036]  <TASK>
[ 3460.003248]  __schedule+0x2eb/0x8d0
[ 3460.006854]  schedule+0x5b/0xd0
[ 3460.010106]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.015015]  chown_common+0x152/0x250
[ 3460.018788]  ? __do_sys_newfstat+0x57/0x60
[ 3460.022994]  ? __fget_files+0x79/0xb0
[ 3460.026765]  ksys_fchown+0x74/0xb0
[ 3460.030272]  __x64_sys_fchown+0x16/0x20
[ 3460.034213]  do_syscall_64+0x38/0x90
[ 3460.037906]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.043077] RIP: 0033:0x444aeb8
[ 3460.046334] RSP: 002b:00007efda2d4d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.054017] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.061288] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023d
[ 3460.068536] RBP: 00007efda4310f48 R08: 000000000000023d R09: 
0000000005bf68db
[ 3460.075783] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023d
[ 3460.083032] R13: 00007efda462be0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.090282]  </TASK>
[ 3460.092583] task:k3s-server      state:D stack:    0 pid:71003 ppid: 
    1 flags:0x00000000
[ 3460.101049] Call Trace:
[ 3460.103608]  <TASK>
[ 3460.105822]  __schedule+0x2eb/0x8d0
[ 3460.109448]  schedule+0x5b/0xd0
[ 3460.112703]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.117610]  chown_common+0x152/0x250
[ 3460.121389]  ? __do_sys_newfstat+0x57/0x60
[ 3460.125602]  ? __fget_files+0x79/0xb0
[ 3460.129382]  ksys_fchown+0x74/0xb0
[ 3460.132897]  __x64_sys_fchown+0x16/0x20
[ 3460.136846]  do_syscall_64+0x38/0x90
[ 3460.140537]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.145706] RIP: 0033:0x444aeb8
[ 3460.148962] RSP: 002b:00007efda2d2a6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.156644] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.163890] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e8
[ 3460.171136] RBP: 00007efda450d948 R08: 00000000000001e8 R09: 
0000000005bf68db
[ 3460.178385] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e8
[ 3460.185632] R13: 00007efda4706f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.192880]  </TASK>
[ 3460.195183] task:k3s-server      state:D stack:    0 pid:71004 ppid: 
    1 flags:0x00000000
[ 3460.203647] Call Trace:
[ 3460.206206]  <TASK>
[ 3460.208417]  __schedule+0x2eb/0x8d0
[ 3460.212016]  schedule+0x5b/0xd0
[ 3460.215270]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.220181]  chown_common+0x152/0x250
[ 3460.223959]  ? __do_sys_newfstat+0x57/0x60
[ 3460.228170]  ? __fget_files+0x79/0xb0
[ 3460.231950]  ksys_fchown+0x74/0xb0
[ 3460.235465]  __x64_sys_fchown+0x16/0x20
[ 3460.239412]  do_syscall_64+0x38/0x90
[ 3460.243100]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.248264] RIP: 0033:0x444aeb8
[ 3460.251519] RSP: 002b:00007efda2ce76b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.259201] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.266450] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000019c
[ 3460.273699] RBP: 00007efda4ddc888 R08: 000000000000019c R09: 
0000000005bf68db
[ 3460.280946] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000019c
[ 3460.288192] R13: 00007efda362964d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.295439]  </TASK>
[ 3460.297749] task:k3s-server      state:D stack:    0 pid:71005 ppid: 
    1 flags:0x00000000
[ 3460.306212] Call Trace:
[ 3460.308769]  <TASK>
[ 3460.310980]  __schedule+0x2eb/0x8d0
[ 3460.314583]  schedule+0x5b/0xd0
[ 3460.317835]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.322744]  chown_common+0x152/0x250
[ 3460.326523]  ? __do_sys_newfstat+0x57/0x60
[ 3460.330733]  ? __fget_files+0x79/0xb0
[ 3460.334514]  ksys_fchown+0x74/0xb0
[ 3460.338028]  __x64_sys_fchown+0x16/0x20
[ 3460.341977]  do_syscall_64+0x38/0x90
[ 3460.345666]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.350835] RIP: 0033:0x444aeb8
[ 3460.354090] RSP: 002b:00007efda2cc46b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.361774] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.369020] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000206
[ 3460.376266] RBP: 00007efda4df8888 R08: 0000000000000206 R09: 
0000000005bf68db
[ 3460.383512] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000206
[ 3460.390757] R13: 00007efda20e436d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.398010]  </TASK>
[ 3460.400307] task:k3s-server      state:D stack:    0 pid:71006 ppid: 
    1 flags:0x00000000
[ 3460.408772] Call Trace:
[ 3460.411333]  <TASK>
[ 3460.413548]  __schedule+0x2eb/0x8d0
[ 3460.417155]  schedule+0x5b/0xd0
[ 3460.420409]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.425315]  chown_common+0x152/0x250
[ 3460.429093]  ? __do_sys_newfstat+0x57/0x60
[ 3460.433302]  ? __fget_files+0x79/0xb0
[ 3460.437078]  ksys_fchown+0x74/0xb0
[ 3460.440593]  __x64_sys_fchown+0x16/0x20
[ 3460.444542]  do_syscall_64+0x38/0x90
[ 3460.448231]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.453398] RIP: 0033:0x444aeb8
[ 3460.456651] RSP: 002b:00007efda2ca16b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.464329] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.471574] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e5
[ 3460.478820] RBP: 00007efda4509ae8 R08: 00000000000001e5 R09: 
0000000005bf68db
[ 3460.486063] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e5
[ 3460.493303] R13: 00007efda42f26cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.500550]  </TASK>
[ 3460.502849] task:k3s-server      state:D stack:    0 pid:71007 ppid: 
    1 flags:0x00000000
[ 3460.511310] Call Trace:
[ 3460.513871]  <TASK>
[ 3460.516081]  __schedule+0x2eb/0x8d0
[ 3460.519685]  schedule+0x5b/0xd0
[ 3460.522940]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.527855]  chown_common+0x152/0x250
[ 3460.531633]  ? __do_sys_newfstat+0x57/0x60
[ 3460.535844]  ? __fget_files+0x79/0xb0
[ 3460.539621]  ksys_fchown+0x74/0xb0
[ 3460.543134]  __x64_sys_fchown+0x16/0x20
[ 3460.547083]  do_syscall_64+0x38/0x90
[ 3460.550771]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.555935] RIP: 0033:0x444aeb8
[ 3460.559189] RSP: 002b:00007efda2c7e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.566871] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.574118] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f6
[ 3460.581368] RBP: 00007efda5776648 R08: 00000000000001f6 R09: 
0000000005bf68db
[ 3460.588615] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f6
[ 3460.595865] R13: 00007efda29ebe0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.603111]  </TASK>
[ 3460.605415] task:k3s-server      state:D stack:    0 pid:71008 ppid: 
    1 flags:0x00000000
[ 3460.613897] Call Trace:
[ 3460.616456]  <TASK>
[ 3460.618665]  __schedule+0x2eb/0x8d0
[ 3460.622270]  schedule+0x5b/0xd0
[ 3460.625523]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.630433]  chown_common+0x152/0x250
[ 3460.634211]  ? __do_sys_newfstat+0x57/0x60
[ 3460.638419]  ? __fget_files+0x79/0xb0
[ 3460.642201]  ksys_fchown+0x74/0xb0
[ 3460.645715]  __x64_sys_fchown+0x16/0x20
[ 3460.649684]  do_syscall_64+0x38/0x90
[ 3460.653373]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.658538] RIP: 0033:0x444aeb8
[ 3460.661791] RSP: 002b:00007efda2c5b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.669470] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.676716] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000225
[ 3460.683962] RBP: 00007efda48cb848 R08: 0000000000000225 R09: 
0000000005bf68db
[ 3460.691207] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000225
[ 3460.698453] R13: 00007efda4dfab3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.705700]  </TASK>
[ 3460.708001] task:k3s-server      state:D stack:    0 pid:71009 ppid: 
    1 flags:0x00000000
[ 3460.716464] Call Trace:
[ 3460.719031]  <TASK>
[ 3460.721240]  __schedule+0x2eb/0x8d0
[ 3460.724845]  schedule+0x5b/0xd0
[ 3460.728099]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.733009]  chown_common+0x152/0x250
[ 3460.736801]  ? __do_sys_newfstat+0x57/0x60
[ 3460.741011]  ? __fget_files+0x79/0xb0
[ 3460.744788]  ksys_fchown+0x74/0xb0
[ 3460.748301]  __x64_sys_fchown+0x16/0x20
[ 3460.752251]  do_syscall_64+0x38/0x90
[ 3460.755939]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.761103] RIP: 0033:0x444aeb8
[ 3460.764359] RSP: 002b:00007efda2c386b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.772041] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.779303] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000020a
[ 3460.786548] RBP: 00007efda4ddc1c8 R08: 000000000000020a R09: 
0000000005bf68db
[ 3460.793794] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000020a
[ 3460.801043] R13: 00007efda20ead8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.808291]  </TASK>
[ 3460.810589] task:k3s-server      state:D stack:    0 pid:71010 ppid: 
    1 flags:0x00000000
[ 3460.819056] Call Trace:
[ 3460.821615]  <TASK>
[ 3460.823823]  __schedule+0x2eb/0x8d0
[ 3460.827431]  schedule+0x5b/0xd0
[ 3460.830687]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.835601]  chown_common+0x152/0x250
[ 3460.839377]  ? __do_sys_newfstat+0x57/0x60
[ 3460.843590]  ? __fget_files+0x79/0xb0
[ 3460.847367]  ksys_fchown+0x74/0xb0
[ 3460.850879]  __x64_sys_fchown+0x16/0x20
[ 3460.854829]  do_syscall_64+0x38/0x90
[ 3460.858521]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.863687] RIP: 0033:0x444aeb8
[ 3460.866946] RSP: 002b:00007efda2c156b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.874630] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.881876] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000021d
[ 3460.889122] RBP: 00007efda4419408 R08: 000000000000021d R09: 
0000000005bf68db
[ 3460.896368] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000021d
[ 3460.903612] R13: 00007efda28a95cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3460.910862]  </TASK>
[ 3460.913166] task:k3s-server      state:D stack:    0 pid:71011 ppid: 
    1 flags:0x00000000
[ 3460.921630] Call Trace:
[ 3460.924186]  <TASK>
[ 3460.926398]  __schedule+0x2eb/0x8d0
[ 3460.930007]  schedule+0x5b/0xd0
[ 3460.933258]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3460.938164]  chown_common+0x152/0x250
[ 3460.941943]  ? __do_sys_newfstat+0x57/0x60
[ 3460.946158]  ? __fget_files+0x79/0xb0
[ 3460.949938]  ksys_fchown+0x74/0xb0
[ 3460.953453]  __x64_sys_fchown+0x16/0x20
[ 3460.957402]  do_syscall_64+0x38/0x90
[ 3460.961094]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3460.966316] RIP: 0033:0x444aeb8
[ 3460.969571] RSP: 002b:00007efda2bd26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3460.977256] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3460.984502] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001bb
[ 3460.991746] RBP: 00007efda5776408 R08: 00000000000001bb R09: 
0000000005bf68db
[ 3460.998998] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001bb
[ 3461.006245] R13: 00007efda29ea26d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.013514]  </TASK>
[ 3461.015816] task:k3s-server      state:D stack:    0 pid:71012 ppid: 
    1 flags:0x00000000
[ 3461.024282] Call Trace:
[ 3461.026842]  <TASK>
[ 3461.029055]  __schedule+0x2eb/0x8d0
[ 3461.032665]  schedule+0x5b/0xd0
[ 3461.035924]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.040835]  chown_common+0x152/0x250
[ 3461.044614]  ? __do_sys_newfstat+0x57/0x60
[ 3461.048822]  ? __fget_files+0x79/0xb0
[ 3461.052600]  ksys_fchown+0x74/0xb0
[ 3461.056113]  __x64_sys_fchown+0x16/0x20
[ 3461.060187]  do_syscall_64+0x38/0x90
[ 3461.063882]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.069049] RIP: 0033:0x444aeb8
[ 3461.072305] RSP: 002b:00007efda2baf6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.079992] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.087241] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000229
[ 3461.094486] RBP: 00007efda48cbcc8 R08: 0000000000000229 R09: 
0000000005bf68db
[ 3461.101733] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000229
[ 3461.108979] R13: 00007efda4dfde8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.116225]  </TASK>
[ 3461.118521] task:k3s-server      state:D stack:    0 pid:71013 ppid: 
    1 flags:0x00000000
[ 3461.126984] Call Trace:
[ 3461.129553]  <TASK>
[ 3461.131763]  __schedule+0x2eb/0x8d0
[ 3461.135369]  schedule+0x5b/0xd0
[ 3461.138625]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.143532]  chown_common+0x152/0x250
[ 3461.147312]  ? __do_sys_newfstat+0x57/0x60
[ 3461.151523]  ? __fget_files+0x79/0xb0
[ 3461.155299]  ksys_fchown+0x74/0xb0
[ 3461.158815]  __x64_sys_fchown+0x16/0x20
[ 3461.162764]  do_syscall_64+0x38/0x90
[ 3461.166452]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.171624] RIP: 0033:0x444aeb8
[ 3461.174895] RSP: 002b:00007efda2b8c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.182580] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.189828] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022a
[ 3461.197080] RBP: 00007efda4419d08 R08: 000000000000022a R09: 
0000000005bf68db
[ 3461.204327] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022a
[ 3461.211575] R13: 00007efda4ecc26d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.218823]  </TASK>
[ 3461.221121] task:k3s-server      state:D stack:    0 pid:71014 ppid: 
    1 flags:0x00000000
[ 3461.229584] Call Trace:
[ 3461.232142]  <TASK>
[ 3461.234353]  __schedule+0x2eb/0x8d0
[ 3461.237956]  schedule+0x5b/0xd0
[ 3461.241210]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.246121]  chown_common+0x152/0x250
[ 3461.249900]  ? __do_sys_newfstat+0x57/0x60
[ 3461.254110]  ? __fget_files+0x79/0xb0
[ 3461.257906]  ksys_fchown+0x74/0xb0
[ 3461.261420]  __x64_sys_fchown+0x16/0x20
[ 3461.265366]  do_syscall_64+0x38/0x90
[ 3461.269055]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.274223] RIP: 0033:0x444aeb8
[ 3461.277473] RSP: 002b:00007efda2b286b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.285166] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.292405] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001de
[ 3461.299648] RBP: 00007efda45c1498 R08: 00000000000001de R09: 
0000000005bf68db
[ 3461.306892] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001de
[ 3461.314141] R13: 00007efda4629e8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.321384]  </TASK>
[ 3461.323680] task:k3s-server      state:D stack:    0 pid:71015 ppid: 
    1 flags:0x00000000
[ 3461.332142] Call Trace:
[ 3461.334695]  <TASK>
[ 3461.336901]  __schedule+0x2eb/0x8d0
[ 3461.340499]  schedule+0x5b/0xd0
[ 3461.343747]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.348647]  chown_common+0x152/0x250
[ 3461.352422]  ? __do_sys_newfstat+0x57/0x60
[ 3461.356625]  ? __fget_files+0x79/0xb0
[ 3461.360397]  ksys_fchown+0x74/0xb0
[ 3461.363907]  __x64_sys_fchown+0x16/0x20
[ 3461.367847]  do_syscall_64+0x38/0x90
[ 3461.371528]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.376687] RIP: 0033:0x444aeb8
[ 3461.379934] RSP: 002b:00007efda2fc06b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.387610] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.394863] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000204
[ 3461.402105] RBP: 00007efda4df8408 R08: 0000000000000204 R09: 
0000000005bf68db
[ 3461.409346] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000204
[ 3461.416593] R13: 00007efda42df1ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.423841]  </TASK>
[ 3461.426141] task:k3s-server      state:D stack:    0 pid:71016 ppid: 
    1 flags:0x00000000
[ 3461.434604] Call Trace:
[ 3461.437161]  <TASK>
[ 3461.439371]  __schedule+0x2eb/0x8d0
[ 3461.442976]  schedule+0x5b/0xd0
[ 3461.446230]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.451136]  chown_common+0x152/0x250
[ 3461.454914]  ? __do_sys_newfstat+0x57/0x60
[ 3461.459125]  ? __fget_files+0x79/0xb0
[ 3461.462902]  ksys_fchown+0x74/0xb0
[ 3461.466416]  __x64_sys_fchown+0x16/0x20
[ 3461.470364]  do_syscall_64+0x38/0x90
[ 3461.474053]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.479222] RIP: 0033:0x444aeb8
[ 3461.482477] RSP: 002b:00007efda280e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.490161] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.497409] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000021e
[ 3461.504652] RBP: 00007efda4419648 R08: 000000000000021e R09: 
0000000005bf68db
[ 3461.511918] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000021e
[ 3461.519162] R13: 00007efda28aad8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.526408]  </TASK>
[ 3461.528707] task:k3s-server      state:D stack:    0 pid:71017 ppid: 
    1 flags:0x00000000
[ 3461.537169] Call Trace:
[ 3461.539726]  <TASK>
[ 3461.541934]  __schedule+0x2eb/0x8d0
[ 3461.545542]  schedule+0x5b/0xd0
[ 3461.548797]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.553708]  chown_common+0x152/0x250
[ 3461.557487]  ? __do_sys_newfstat+0x57/0x60
[ 3461.561698]  ? __fget_files+0x79/0xb0
[ 3461.565474]  ksys_fchown+0x74/0xb0
[ 3461.568988]  __x64_sys_fchown+0x16/0x20
[ 3461.572937]  do_syscall_64+0x38/0x90
[ 3461.576624]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.581795] RIP: 0033:0x444aeb8
[ 3461.585053] RSP: 002b:00007efda27cb6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.592739] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.599986] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000224
[ 3461.607236] RBP: 00007efda48cb608 R08: 0000000000000224 R09: 
0000000005bf68db
[ 3461.614583] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000224
[ 3461.621830] R13: 00007efda4c661ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.629075]  </TASK>
[ 3461.631374] task:k3s-server      state:D stack:    0 pid:71020 ppid: 
    1 flags:0x00000000
[ 3461.639836] Call Trace:
[ 3461.642396]  <TASK>
[ 3461.644610]  __schedule+0x2eb/0x8d0
[ 3461.648214]  schedule+0x5b/0xd0
[ 3461.651472]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3461.656645]  ? wait_woken+0x70/0x70
[ 3461.660254]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3461.665508]  ? __mod_lruvec_page_state+0x60/0xa0
[ 3461.670244]  ? select_task_rq_fair+0x130/0xf90
[ 3461.674805]  start_this_handle+0xfb/0x520 [jbd2]
[ 3461.679541]  ? __cond_resched+0x16/0x50
[ 3461.683488]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3461.688399]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3461.693680]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3461.698257]  __mark_inode_dirty+0x144/0x320
[ 3461.702556]  generic_update_time+0x6c/0xd0
[ 3461.706767]  file_update_time+0x127/0x140
[ 3461.710894]  ? generic_write_checks+0x61/0xc0
[ 3461.715362]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3461.720719]  new_sync_write+0x119/0x1b0
[ 3461.724664]  ? intel_get_event_constraints+0x300/0x390
[ 3461.729920]  vfs_write+0x1de/0x270
[ 3461.733436]  ksys_write+0x5f/0xe0
[ 3461.736865]  do_syscall_64+0x38/0x90
[ 3461.740557]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.745724] RIP: 0033:0x444938a
[ 3461.748977] RSP: 002b:00007efda2a637b8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[ 3461.756659] RAX: ffffffffffffffda RBX: 00000000000001ac RCX: 
000000000444938a
[ 3461.763906] RDX: 0000000000000018 RSI: 00007efda2a63850 RDI: 
00000000000001ac
[ 3461.771156] RBP: 00007efda5789668 R08: 0000000000000000 R09: 
0000000000000000
[ 3461.778401] R10: 0000000000000000 R11: 0000000000000246 R12: 
00000000003b3870
[ 3461.785649] R13: 00007efda2a63850 R14: 0000000000000018 R15: 
00007efda40cc260
[ 3461.792897]  </TASK>
[ 3461.795200] task:k3s-server      state:D stack:    0 pid:71021 ppid: 
    1 flags:0x00000000
[ 3461.803662] Call Trace:
[ 3461.806222]  <TASK>
[ 3461.808435]  __schedule+0x2eb/0x8d0
[ 3461.812043]  schedule+0x5b/0xd0
[ 3461.815302]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3461.820211]  chown_common+0x152/0x250
[ 3461.823990]  ? __do_sys_newfstat+0x57/0x60
[ 3461.828213]  ? __fget_files+0x79/0xb0
[ 3461.831996]  ksys_fchown+0x74/0xb0
[ 3461.835520]  __x64_sys_fchown+0x16/0x20
[ 3461.839471]  do_syscall_64+0x38/0x90
[ 3461.843158]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.848327] RIP: 0033:0x444aeb8
[ 3461.851583] RSP: 002b:00007efda2a3f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3461.859266] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3461.866511] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000020b
[ 3461.873760] RBP: 00007efda4ddc408 R08: 000000000000020b R09: 
0000000005bf68db
[ 3461.881006] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000020b
[ 3461.888259] R13: 00007efda362674d R14: 0000000000080006 R15: 
00000000000001a4
[ 3461.895521]  </TASK>
[ 3461.897826] task:k3s-server      state:D stack:    0 pid:71022 ppid: 
    1 flags:0x00000000
[ 3461.906299] Call Trace:
[ 3461.908859]  <TASK>
[ 3461.911079]  __schedule+0x2eb/0x8d0
[ 3461.914715]  ? __kmalloc+0x159/0x410
[ 3461.918406]  schedule+0x5b/0xd0
[ 3461.921663]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3461.926839]  ? wait_woken+0x70/0x70
[ 3461.930459]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3461.935719]  start_this_handle+0xfb/0x520 [jbd2]
[ 3461.940452]  ? __cond_resched+0x16/0x50
[ 3461.944403]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3461.949313]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3461.954599]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3461.959186]  __mark_inode_dirty+0x144/0x320
[ 3461.963490]  touch_atime+0x13c/0x150
[ 3461.967197]  iterate_dir+0x101/0x1c0
[ 3461.970891]  __x64_sys_getdents64+0x78/0x110
[ 3461.975273]  ? __ia32_sys_getdents64+0x110/0x110
[ 3461.980004]  do_syscall_64+0x38/0x90
[ 3461.983699]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3461.988866] RIP: 0033:0x490f5b
[ 3461.992032] RSP: 002b:000000c00e5f5620 EFLAGS: 00000206 ORIG_RAX: 
00000000000000d9
[ 3461.999721] RAX: ffffffffffffffda RBX: 000000c000083000 RCX: 
0000000000490f5b
[ 3462.006972] RDX: 0000000000002000 RSI: 000000c016e3a000 RDI: 
0000000000000217
[ 3462.014241] RBP: 000000c00e5f5670 R08: 0000000000000000 R09: 
0000000000000000
[ 3462.021499] R10: 0000000000000000 R11: 0000000000000206 R12: 
0000000000000000
[ 3462.028756] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000001
[ 3462.036004]  </TASK>
[ 3462.038304] task:k3s-server      state:D stack:    0 pid:71023 ppid: 
    1 flags:0x00000000
[ 3462.046769] Call Trace:
[ 3462.049330]  <TASK>
[ 3462.051546]  __schedule+0x2eb/0x8d0
[ 3462.055151]  schedule+0x5b/0xd0
[ 3462.058405]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.063311]  chown_common+0x152/0x250
[ 3462.067094]  ? __do_sys_newfstat+0x57/0x60
[ 3462.071306]  ? __fget_files+0x79/0xb0
[ 3462.075083]  ksys_fchown+0x74/0xb0
[ 3462.078599]  __x64_sys_fchown+0x16/0x20
[ 3462.082556]  do_syscall_64+0x38/0x90
[ 3462.086252]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.091420] RIP: 0033:0x444aeb8
[ 3462.094669] RSP: 002b:00007efda218c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.102351] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.109596] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001a9
[ 3462.116841] RBP: 00007efda4ddcac8 R08: 00000000000001a9 R09: 
0000000005bf68db
[ 3462.124087] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001a9
[ 3462.131330] R13: 00007efda362b1ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.138593]  </TASK>
[ 3462.140891] task:k3s-server      state:D stack:    0 pid:71024 ppid: 
    1 flags:0x00000000
[ 3462.149374] Call Trace:
[ 3462.151933]  <TASK>
[ 3462.154143]  __schedule+0x2eb/0x8d0
[ 3462.157745]  schedule+0x5b/0xd0
[ 3462.161001]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.165911]  chown_common+0x152/0x250
[ 3462.169689]  ? __do_sys_newfstat+0x57/0x60
[ 3462.173897]  ? __fget_files+0x79/0xb0
[ 3462.177671]  ksys_fchown+0x74/0xb0
[ 3462.181184]  __x64_sys_fchown+0x16/0x20
[ 3462.185127]  do_syscall_64+0x38/0x90
[ 3462.188816]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.193987] RIP: 0033:0x444aeb8
[ 3462.197241] RSP: 002b:00007efda290f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.204931] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.212177] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e3
[ 3462.219420] RBP: 00007efda55351c8 R08: 00000000000001e3 R09: 
0000000005bf68db
[ 3462.226661] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e3
[ 3462.233910] R13: 00007efda45dfe0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.241159]  </TASK>
[ 3462.243460] task:k3s-server      state:D stack:    0 pid:71025 ppid: 
    1 flags:0x00000000
[ 3462.251929] Call Trace:
[ 3462.254489]  <TASK>
[ 3462.256696]  __schedule+0x2eb/0x8d0
[ 3462.260298]  schedule+0x5b/0xd0
[ 3462.263550]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.268450]  chown_common+0x152/0x250
[ 3462.272227]  ? __do_sys_newfstat+0x57/0x60
[ 3462.276440]  ? __fget_files+0x79/0xb0
[ 3462.280217]  ksys_fchown+0x74/0xb0
[ 3462.283753]  __x64_sys_fchown+0x16/0x20
[ 3462.287699]  do_syscall_64+0x38/0x90
[ 3462.291387]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.296552] RIP: 0033:0x444aeb8
[ 3462.299802] RSP: 002b:00007efda28ec6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.307482] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.314723] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000223
[ 3462.321965] RBP: 00007efda48cb3c8 R08: 0000000000000223 R09: 
0000000005bf68db
[ 3462.329206] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000223
[ 3462.336446] R13: 00007efda4c64a2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.343689]  </TASK>
[ 3462.345984] task:k3s-server      state:D stack:    0 pid:71026 ppid: 
    1 flags:0x00000000
[ 3462.354441] Call Trace:
[ 3462.356996]  <TASK>
[ 3462.359207]  __schedule+0x2eb/0x8d0
[ 3462.362804]  schedule+0x5b/0xd0
[ 3462.366055]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.370958]  chown_common+0x152/0x250
[ 3462.374734]  ? __do_sys_newfstat+0x57/0x60
[ 3462.378940]  ? __fget_files+0x79/0xb0
[ 3462.382719]  ksys_fchown+0x74/0xb0
[ 3462.386232]  __x64_sys_fchown+0x16/0x20
[ 3462.390182]  do_syscall_64+0x38/0x90
[ 3462.393865]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.399027] RIP: 0033:0x444aeb8
[ 3462.402274] RSP: 002b:00007efda1fe86b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.409962] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.417236] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001ea
[ 3462.424476] RBP: 00007efda450ddc8 R08: 00000000000001ea R09: 
0000000005bf68db
[ 3462.431714] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001ea
[ 3462.438956] R13: 00007efda470a5cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.446202]  </TASK>
[ 3462.448500] task:k3s-server      state:D stack:    0 pid:71027 ppid: 
    1 flags:0x00000000
[ 3462.456960] Call Trace:
[ 3462.459519]  <TASK>
[ 3462.461726]  __schedule+0x2eb/0x8d0
[ 3462.465331]  schedule+0x5b/0xd0
[ 3462.468582]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.473489]  chown_common+0x152/0x250
[ 3462.477263]  ? __do_sys_newfstat+0x57/0x60
[ 3462.481471]  ? __fget_files+0x79/0xb0
[ 3462.485257]  ksys_fchown+0x74/0xb0
[ 3462.488774]  __x64_sys_fchown+0x16/0x20
[ 3462.492727]  do_syscall_64+0x38/0x90
[ 3462.496417]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.501582] RIP: 0033:0x444aeb8
[ 3462.504839] RSP: 002b:00007efda1fc56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.512551] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.519802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d7
[ 3462.527050] RBP: 00007efda57892e8 R08: 00000000000001d7 R09: 
0000000005bf68db
[ 3462.534308] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d7
[ 3462.541554] R13: 00007efda22e09bd R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.548801]  </TASK>
[ 3462.551103] task:k3s-server      state:D stack:    0 pid:71028 ppid: 
    1 flags:0x00000000
[ 3462.559570] Call Trace:
[ 3462.562132]  <TASK>
[ 3462.564340]  __schedule+0x2eb/0x8d0
[ 3462.567945]  schedule+0x5b/0xd0
[ 3462.571201]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.576113]  chown_common+0x152/0x250
[ 3462.579893]  ? __do_sys_newfstat+0x57/0x60
[ 3462.584103]  ? __fget_files+0x79/0xb0
[ 3462.587884]  ksys_fchown+0x74/0xb0
[ 3462.591399]  __x64_sys_fchown+0x16/0x20
[ 3462.595351]  do_syscall_64+0x38/0x90
[ 3462.599064]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.604239] RIP: 0033:0x444aeb8
[ 3462.607492] RSP: 002b:00007efda1fa26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.615175] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.622421] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f4
[ 3462.629668] RBP: 00007efda3805398 R08: 00000000000001f4 R09: 
0000000005bf68db
[ 3462.636914] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f4
[ 3462.644160] R13: 00007efda3e759bd R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.651409]  </TASK>
[ 3462.653714] task:k3s-server      state:D stack:    0 pid:71029 ppid: 
    1 flags:0x00000000
[ 3462.662174] Call Trace:
[ 3462.664738]  <TASK>
[ 3462.666967]  __schedule+0x2eb/0x8d0
[ 3462.670568]  schedule+0x5b/0xd0
[ 3462.673821]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.678732]  chown_common+0x152/0x250
[ 3462.682513]  ? __do_sys_newfstat+0x57/0x60
[ 3462.686724]  ? __fget_files+0x79/0xb0
[ 3462.690498]  ksys_fchown+0x74/0xb0
[ 3462.694011]  __x64_sys_fchown+0x16/0x20
[ 3462.697960]  do_syscall_64+0x38/0x90
[ 3462.701649]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.706814] RIP: 0033:0x444aeb8
[ 3462.710071] RSP: 002b:00007efda1f5f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.717752] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.725015] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022c
[ 3462.732262] RBP: 00007efda441a188 R08: 000000000000022c R09: 
0000000005bf68db
[ 3462.739507] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022c
[ 3462.746750] R13: 00007efda4ecf9ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.754000]  </TASK>
[ 3462.756302] task:k3s-server      state:D stack:    0 pid:71030 ppid: 
    1 flags:0x00000000
[ 3462.764767] Call Trace:
[ 3462.767334]  <TASK>
[ 3462.769548]  __schedule+0x2eb/0x8d0
[ 3462.773160]  schedule+0x5b/0xd0
[ 3462.776417]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.781325]  chown_common+0x152/0x250
[ 3462.785105]  ? __do_sys_newfstat+0x57/0x60
[ 3462.789316]  ? __fget_files+0x79/0xb0
[ 3462.793096]  ksys_fchown+0x74/0xb0
[ 3462.796614]  __x64_sys_fchown+0x16/0x20
[ 3462.800572]  do_syscall_64+0x38/0x90
[ 3462.804265]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.809432] RIP: 0033:0x444aeb8
[ 3462.812685] RSP: 002b:00007efda1f3c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.820382] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.827628] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e7
[ 3462.834877] RBP: 00007efda450d708 R08: 00000000000001e7 R09: 
0000000005bf68db
[ 3462.842122] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e7
[ 3462.849369] R13: 00007efda470536d R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.856621]  </TASK>
[ 3462.858930] task:k3s-server      state:D stack:    0 pid:71031 ppid: 
    1 flags:0x00000000
[ 3462.867395] Call Trace:
[ 3462.869952]  <TASK>
[ 3462.872164]  __schedule+0x2eb/0x8d0
[ 3462.875788]  schedule+0x5b/0xd0
[ 3462.879041]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.883952]  chown_common+0x152/0x250
[ 3462.887734]  ? __do_sys_newfstat+0x57/0x60
[ 3462.891944]  ? __fget_files+0x79/0xb0
[ 3462.895722]  ksys_fchown+0x74/0xb0
[ 3462.899236]  __x64_sys_fchown+0x16/0x20
[ 3462.903182]  do_syscall_64+0x38/0x90
[ 3462.906870]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3462.912035] RIP: 0033:0x444aeb8
[ 3462.915299] RSP: 002b:00007efda1ef96b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3462.922999] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3462.930245] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000022d
[ 3462.937492] RBP: 00007efda441a3c8 R08: 000000000000022d R09: 
0000000005bf68db
[ 3462.944742] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000022d
[ 3462.951990] R13: 00007efda291274d R14: 0000000000080006 R15: 
00000000000001a4
[ 3462.959325]  </TASK>
[ 3462.961627] task:k3s-server      state:D stack:    0 pid:71032 ppid: 
    1 flags:0x00000000
[ 3462.970089] Call Trace:
[ 3462.972649]  <TASK>
[ 3462.974862]  __schedule+0x2eb/0x8d0
[ 3462.978476]  schedule+0x5b/0xd0
[ 3462.981737]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3462.986647]  chown_common+0x152/0x250
[ 3462.990428]  ? __do_sys_newfstat+0x57/0x60
[ 3462.994641]  ? __fget_files+0x79/0xb0
[ 3462.998419]  ksys_fchown+0x74/0xb0
[ 3463.001933]  __x64_sys_fchown+0x16/0x20
[ 3463.005884]  do_syscall_64+0x38/0x90
[ 3463.009576]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.014744] RIP: 0033:0x444aeb8
[ 3463.018001] RSP: 002b:00007efda1ed66b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.025687] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.032937] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000219
[ 3463.040188] RBP: 00007efda48ca1c8 R08: 0000000000000219 R09: 
0000000005bf68db
[ 3463.047436] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000219
[ 3463.054677] R13: 00007efda3e7d9bd R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.061924]  </TASK>
[ 3463.064219] task:k3s-server      state:D stack:    0 pid:71033 ppid: 
    1 flags:0x00000000
[ 3463.072683] Call Trace:
[ 3463.075236]  <TASK>
[ 3463.077443]  __schedule+0x2eb/0x8d0
[ 3463.081043]  schedule+0x5b/0xd0
[ 3463.084305]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.089219]  chown_common+0x152/0x250
[ 3463.092997]  ? __do_sys_newfstat+0x57/0x60
[ 3463.097205]  ? __fget_files+0x79/0xb0
[ 3463.100983]  ksys_fchown+0x74/0xb0
[ 3463.104529]  __x64_sys_fchown+0x16/0x20
[ 3463.108482]  do_syscall_64+0x38/0x90
[ 3463.112173]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.117340] RIP: 0033:0x444aeb8
[ 3463.120596] RSP: 002b:00007efda1eb36b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.128283] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.135541] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000215
[ 3463.142792] RBP: 00007efda4ddda88 R08: 0000000000000215 R09: 
0000000005bf68db
[ 3463.150034] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000215
[ 3463.157281] R13: 00007efda3e78b2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.164531]  </TASK>
[ 3463.166827] task:k3s-server      state:D stack:    0 pid:71034 ppid: 
    1 flags:0x00000000
[ 3463.175289] Call Trace:
[ 3463.177841]  <TASK>
[ 3463.180051]  __schedule+0x2eb/0x8d0
[ 3463.183665]  schedule+0x5b/0xd0
[ 3463.186923]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.191833]  chown_common+0x152/0x250
[ 3463.195615]  ? __do_sys_newfstat+0x57/0x60
[ 3463.199826]  ? __fget_files+0x79/0xb0
[ 3463.203604]  ksys_fchown+0x74/0xb0
[ 3463.207121]  __x64_sys_fchown+0x16/0x20
[ 3463.211070]  do_syscall_64+0x38/0x90
[ 3463.214759]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.219923] RIP: 0033:0x444aeb8
[ 3463.223179] RSP: 002b:00007efda1e906b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.230863] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.238109] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000020e
[ 3463.245356] RBP: 00007efda4ddd848 R08: 000000000000020e R09: 
0000000005bf68db
[ 3463.252605] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000020e
[ 3463.259853] R13: 00007efda3e7736d R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.267102]  </TASK>
[ 3463.269402] task:k3s-server      state:D stack:    0 pid:71035 ppid: 
    1 flags:0x00000000
[ 3463.277869] Call Trace:
[ 3463.280429]  <TASK>
[ 3463.282639]  __schedule+0x2eb/0x8d0
[ 3463.286245]  schedule+0x5b/0xd0
[ 3463.289500]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.294408]  chown_common+0x152/0x250
[ 3463.298187]  ? __do_sys_newfstat+0x57/0x60
[ 3463.302401]  ? __fget_files+0x79/0xb0
[ 3463.306207]  ksys_fchown+0x74/0xb0
[ 3463.309719]  __x64_sys_fchown+0x16/0x20
[ 3463.313668]  do_syscall_64+0x38/0x90
[ 3463.317360]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.322522] RIP: 0033:0x444aeb8
[ 3463.325783] RSP: 002b:00007efda1e6d6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.333466] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.340719] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000210
[ 3463.347969] RBP: 00007efda4067d08 R08: 0000000000000210 R09: 
0000000005bf68db
[ 3463.355220] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000210
[ 3463.362468] R13: 00007efda4ec8f8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.369713]  </TASK>
[ 3463.372011] task:k3s-server      state:D stack:    0 pid:71036 ppid: 
    1 flags:0x00000000
[ 3463.380478] Call Trace:
[ 3463.383036]  <TASK>
[ 3463.385244]  __schedule+0x2eb/0x8d0
[ 3463.388850]  schedule+0x5b/0xd0
[ 3463.392106]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.397015]  chown_common+0x152/0x250
[ 3463.400796]  ? __do_sys_newfstat+0x57/0x60
[ 3463.405006]  ? __fget_files+0x79/0xb0
[ 3463.408791]  ksys_fchown+0x74/0xb0
[ 3463.412306]  __x64_sys_fchown+0x16/0x20
[ 3463.416253]  do_syscall_64+0x38/0x90
[ 3463.419944]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.425117] RIP: 0033:0x444aeb8
[ 3463.428379] RSP: 002b:00007efda1e4a6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.436058] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.443306] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001e9
[ 3463.450550] RBP: 00007efda450db88 R08: 00000000000001e9 R09: 
0000000005bf68db
[ 3463.457827] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001e9
[ 3463.465075] R13: 00007efda4708a3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.472321]  </TASK>
[ 3463.474622] task:k3s-server      state:D stack:    0 pid:71037 ppid: 
    1 flags:0x00000000
[ 3463.483085] Call Trace:
[ 3463.485646]  <TASK>
[ 3463.487858]  __schedule+0x2eb/0x8d0
[ 3463.491467]  schedule+0x5b/0xd0
[ 3463.494723]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.499631]  chown_common+0x152/0x250
[ 3463.503408]  ? __do_sys_newfstat+0x57/0x60
[ 3463.507623]  ? __fget_files+0x79/0xb0
[ 3463.511400]  ksys_fchown+0x74/0xb0
[ 3463.514919]  __x64_sys_fchown+0x16/0x20
[ 3463.518868]  do_syscall_64+0x38/0x90
[ 3463.522559]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.527725] RIP: 0033:0x444aeb8
[ 3463.530983] RSP: 002b:00007efda1e076b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.538675] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.545924] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000212
[ 3463.553178] RBP: 00007efda4310648 R08: 0000000000000212 R09: 
0000000005bf68db
[ 3463.560430] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000212
[ 3463.567680] R13: 00007efda23711ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.574929]  </TASK>
[ 3463.577231] task:k3s-server      state:D stack:    0 pid:71038 ppid: 
    1 flags:0x00000000
[ 3463.585695] Call Trace:
[ 3463.588254]  <TASK>
[ 3463.590467]  __schedule+0x2eb/0x8d0
[ 3463.594071]  schedule+0x5b/0xd0
[ 3463.597324]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.602232]  chown_common+0x152/0x250
[ 3463.606012]  ? __do_sys_newfstat+0x57/0x60
[ 3463.610227]  ? __fget_files+0x79/0xb0
[ 3463.614010]  ksys_fchown+0x74/0xb0
[ 3463.617524]  __x64_sys_fchown+0x16/0x20
[ 3463.621475]  do_syscall_64+0x38/0x90
[ 3463.625170]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.630336] RIP: 0033:0x444aeb8
[ 3463.633596] RSP: 002b:00007efda1de46b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.641278] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.648527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001f7
[ 3463.655774] RBP: 00007efda5776888 R08: 00000000000001f7 R09: 
0000000005bf68db
[ 3463.663019] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001f7
[ 3463.670263] R13: 00007efda29ed9ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.677512]  </TASK>
[ 3463.679814] task:k3s-server      state:D stack:    0 pid:71039 ppid: 
    1 flags:0x00000000
[ 3463.688280] Call Trace:
[ 3463.690842]  <TASK>
[ 3463.693056]  __schedule+0x2eb/0x8d0
[ 3463.696660]  schedule+0x5b/0xd0
[ 3463.699920]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.704832]  chown_common+0x152/0x250
[ 3463.708613]  ? __do_sys_newfstat+0x57/0x60
[ 3463.712825]  ? __fget_files+0x79/0xb0
[ 3463.716608]  ksys_fchown+0x74/0xb0
[ 3463.720123]  __x64_sys_fchown+0x16/0x20
[ 3463.724072]  do_syscall_64+0x38/0x90
[ 3463.727762]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.732930] RIP: 0033:0x444aeb8
[ 3463.736186] RSP: 002b:00007efda1da16b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.743867] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.751117] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000237
[ 3463.758363] RBP: 00007efda43101c8 R08: 0000000000000237 R09: 
0000000005bf68db
[ 3463.765609] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000237
[ 3463.772856] R13: 00007efda236e2ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.780102]  </TASK>
[ 3463.782411] task:k3s-server      state:D stack:    0 pid:71040 ppid: 
    1 flags:0x00000000
[ 3463.790876] Call Trace:
[ 3463.793437]  <TASK>
[ 3463.795650]  __schedule+0x2eb/0x8d0
[ 3463.799257]  schedule+0x5b/0xd0
[ 3463.802514]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.807424]  chown_common+0x152/0x250
[ 3463.811207]  ? __do_sys_newfstat+0x57/0x60
[ 3463.815418]  ? __fget_files+0x79/0xb0
[ 3463.819193]  ksys_fchown+0x74/0xb0
[ 3463.822707]  __x64_sys_fchown+0x16/0x20
[ 3463.826656]  do_syscall_64+0x38/0x90
[ 3463.830344]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.835510] RIP: 0033:0x444aeb8
[ 3463.838767] RSP: 002b:00007efda1d3e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.846451] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.853699] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000163
[ 3463.860948] RBP: 00007efda5776d08 R08: 0000000000000163 R09: 
0000000005bf68db
[ 3463.868195] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000163
[ 3463.875449] R13: 00007efda45dcebd R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.882703]  </TASK>
[ 3463.885002] task:k3s-server      state:D stack:    0 pid:71041 ppid: 
    1 flags:0x00000000
[ 3463.893470] Call Trace:
[ 3463.896027]  <TASK>
[ 3463.898244]  __schedule+0x2eb/0x8d0
[ 3463.901852]  schedule+0x5b/0xd0
[ 3463.905115]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3463.910025]  chown_common+0x152/0x250
[ 3463.913805]  ? __do_sys_newfstat+0x57/0x60
[ 3463.918020]  ? __fget_files+0x79/0xb0
[ 3463.921801]  ksys_fchown+0x74/0xb0
[ 3463.925315]  __x64_sys_fchown+0x16/0x20
[ 3463.929265]  do_syscall_64+0x38/0x90
[ 3463.932955]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3463.938121] RIP: 0033:0x444aeb8
[ 3463.941380] RSP: 002b:00007efda1b156b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3463.949063] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3463.956309] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001a7
[ 3463.963558] RBP: 00007efda57761c8 R08: 00000000000001a7 R09: 
0000000005bf68db
[ 3463.970806] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001a7
[ 3463.978049] R13: 00007efda29e82ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3463.985298]  </TASK>
[ 3463.987599] task:k3s-server      state:D stack:    0 pid:71042 ppid: 
    1 flags:0x00000000
[ 3463.996063] Call Trace:
[ 3463.998622]  <TASK>
[ 3464.000835]  __schedule+0x2eb/0x8d0
[ 3464.004447]  schedule+0x5b/0xd0
[ 3464.007707]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.012615]  chown_common+0x152/0x250
[ 3464.016395]  ? __do_sys_newfstat+0x57/0x60
[ 3464.020627]  ? __fget_files+0x79/0xb0
[ 3464.024403]  ksys_fchown+0x74/0xb0
[ 3464.027925]  __x64_sys_fchown+0x16/0x20
[ 3464.031871]  do_syscall_64+0x38/0x90
[ 3464.035562]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.040732] RIP: 0033:0x444aeb8
[ 3464.043986] RSP: 002b:00007efda1cea6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.051673] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.058917] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000227
[ 3464.066167] RBP: 00007efda4419888 R08: 0000000000000227 R09: 
0000000005bf68db
[ 3464.073419] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000227
[ 3464.080671] R13: 00007efda4ec974d R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.087923]  </TASK>
[ 3464.090225] task:k3s-server      state:D stack:    0 pid:71043 ppid: 
    1 flags:0x00000000
[ 3464.098699] Call Trace:
[ 3464.101257]  <TASK>
[ 3464.103469]  __schedule+0x2eb/0x8d0
[ 3464.107076]  schedule+0x5b/0xd0
[ 3464.110333]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3464.115507]  ? wait_woken+0x70/0x70
[ 3464.119113]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3464.124375]  start_this_handle+0xfb/0x520 [jbd2]
[ 3464.129109]  ? __cond_resched+0x16/0x50
[ 3464.133059]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3464.137975]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3464.143256]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3464.147843]  __mark_inode_dirty+0x144/0x320
[ 3464.152144]  touch_atime+0x13c/0x150
[ 3464.155836]  filemap_read+0x308/0x320
[ 3464.159617]  ? do_huge_pmd_wp_page+0x130/0x330
[ 3464.164175]  ? page_add_new_anon_rmap+0x4e/0xf0
[ 3464.168818]  ? queued_spin_unlock+0x5/0x10
[ 3464.173029]  ? __handle_mm_fault+0x1040/0x1470
[ 3464.177586]  new_sync_read+0x116/0x1b0
[ 3464.181449]  ? 0xffffffff93000000
[ 3464.184881]  vfs_read+0xf6/0x190
[ 3464.188221]  ksys_read+0x5f/0xe0
[ 3464.191558]  do_syscall_64+0x38/0x90
[ 3464.195250]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.200418] RIP: 0033:0x444938a
[ 3464.203669] RSP: 002b:00007efda1c48938 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[ 3464.211352] RAX: ffffffffffffffda RBX: 00007efda4689b78 RCX: 
000000000444938a
[ 3464.218600] RDX: 0000000000001000 RSI: 00007efda4689b78 RDI: 
00000000000001d1
[ 3464.225853] RBP: 0000000000001000 R08: 0000000000000000 R09: 
0000000000000000
[ 3464.233100] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000354fb8
[ 3464.240344] R13: 0000000000000000 R14: 00007efda5789f48 R15: 
00007efda4689b78
[ 3464.247592]  </TASK>
[ 3464.249893] task:k3s-server      state:D stack:    0 pid:71044 ppid: 
    1 flags:0x00000000
[ 3464.258359] Call Trace:
[ 3464.260921]  <TASK>
[ 3464.263131]  __schedule+0x2eb/0x8d0
[ 3464.266735]  schedule+0x5b/0xd0
[ 3464.269996]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.274901]  chown_common+0x152/0x250
[ 3464.278681]  ? __do_sys_newfstat+0x57/0x60
[ 3464.282894]  ? __fget_files+0x79/0xb0
[ 3464.286673]  ksys_fchown+0x74/0xb0
[ 3464.290188]  __x64_sys_fchown+0x16/0x20
[ 3464.294138]  do_syscall_64+0x38/0x90
[ 3464.297828]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.302995] RIP: 0033:0x444aeb8
[ 3464.306247] RSP: 002b:00007efda1c246b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.313930] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.321182] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d6
[ 3464.328433] RBP: 00007efda57890a8 R08: 00000000000001d6 R09: 
0000000005bf68db
[ 3464.335677] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d6
[ 3464.342929] R13: 00007efda22df26d R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.350177]  </TASK>
[ 3464.352477] task:k3s-server      state:D stack:    0 pid:71045 ppid: 
    1 flags:0x00000000
[ 3464.360943] Call Trace:
[ 3464.363504]  <TASK>
[ 3464.365716]  __schedule+0x2eb/0x8d0
[ 3464.369322]  ? kvm_sched_clock_read+0xd/0x20
[ 3464.373707]  schedule+0x5b/0xd0
[ 3464.376963]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3464.382135]  ? wait_woken+0x70/0x70
[ 3464.385740]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3464.390994]  ? ep_autoremove_wake_function+0xe/0x30
[ 3464.395990]  start_this_handle+0xfb/0x520 [jbd2]
[ 3464.400722]  ? _raw_spin_unlock_irqrestore+0xa/0x30
[ 3464.405716]  ? try_to_wake_up+0x35b/0x4d0
[ 3464.409841]  ? __cond_resched+0x16/0x50
[ 3464.413793]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3464.418704]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3464.423981]  ext4_setattr+0x3a8/0x9a0 [ext4]
[ 3464.428382]  notify_change+0x3c1/0x540
[ 3464.432251]  ? ext4_dio_write_end_io+0x60/0x60 [ext4]
[ 3464.437432]  ? ext4_file_open+0x7f/0x2c0 [ext4]
[ 3464.442095]  ? do_truncate+0x7d/0xd0
[ 3464.445789]  do_truncate+0x7d/0xd0
[ 3464.449307]  path_openat+0x24d/0x1280
[ 3464.453088]  do_filp_open+0xa9/0x150
[ 3464.456777]  ? new_sync_write+0x19e/0x1b0
[ 3464.460902]  ? __check_object_size+0x146/0x160
[ 3464.465461]  do_sys_openat2+0x9b/0x160
[ 3464.469322]  __x64_sys_openat+0x54/0xa0
[ 3464.473268]  do_syscall_64+0x38/0x90
[ 3464.476959]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.482126] RIP: 0033:0x490fca
[ 3464.485295] RSP: 002b:000000c028a8bac8 EFLAGS: 00000216 ORIG_RAX: 
0000000000000101
[ 3464.492979] RAX: ffffffffffffffda RBX: 000000c00008d000 RCX: 
0000000000490fca
[ 3464.500226] RDX: 0000000000080241 RSI: 000000c0218e2230 RDI: 
ffffffffffffff9c
[ 3464.507474] RBP: 000000c028a8bb48 R08: 0000000000000000 R09: 
0000000000000000
[ 3464.514720] R10: 00000000000001a4 R11: 0000000000000216 R12: 
0000000000000000
[ 3464.521965] R13: 0000000000000001 R14: 0000000000000008 R15: 
ffffffffffffffff
[ 3464.529218]  </TASK>
[ 3464.531520] task:k3s-server      state:D stack:    0 pid:71046 ppid: 
    1 flags:0x00000000
[ 3464.539983] Call Trace:
[ 3464.542555]  <TASK>
[ 3464.544773]  __schedule+0x2eb/0x8d0
[ 3464.548378]  schedule+0x5b/0xd0
[ 3464.551633]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.556545]  chown_common+0x152/0x250
[ 3464.560326]  ? __do_sys_newfstat+0x57/0x60
[ 3464.564539]  ? __fget_files+0x79/0xb0
[ 3464.568317]  ksys_fchown+0x74/0xb0
[ 3464.571832]  __x64_sys_fchown+0x16/0x20
[ 3464.575783]  do_syscall_64+0x38/0x90
[ 3464.579471]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.584639] RIP: 0033:0x444aeb8
[ 3464.587894] RSP: 002b:00007efda206c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.595579] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.602825] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001d9
[ 3464.610070] RBP: 00007efda57899a8 R08: 00000000000001d9 R09: 
0000000005bf68db
[ 3464.617316] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001d9
[ 3464.624562] R13: 00007efda4e00f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.631811]  </TASK>
[ 3464.634112] task:k3s-server      state:D stack:    0 pid:71047 ppid: 
    1 flags:0x00000000
[ 3464.642578] Call Trace:
[ 3464.645138]  <TASK>
[ 3464.647352]  __schedule+0x2eb/0x8d0
[ 3464.650956]  schedule+0x5b/0xd0
[ 3464.654214]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.659124]  chown_common+0x152/0x250
[ 3464.662901]  ? __do_sys_newfstat+0x57/0x60
[ 3464.667116]  ? __fget_files+0x79/0xb0
[ 3464.670893]  ksys_fchown+0x74/0xb0
[ 3464.674406]  __x64_sys_fchown+0x16/0x20
[ 3464.678355]  do_syscall_64+0x38/0x90
[ 3464.682045]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.687212] RIP: 0033:0x444aeb8
[ 3464.690464] RSP: 002b:00007efda20496b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.698146] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.705392] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001ff
[ 3464.712639] RBP: 00007efda4ed4408 R08: 00000000000001ff R09: 
0000000005bf68db
[ 3464.719887] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001ff
[ 3464.727135] R13: 00007efda3be32ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.734382]  </TASK>
[ 3464.736682] task:k3s-server      state:D stack:    0 pid:71048 ppid: 
    1 flags:0x00000000
[ 3464.745146] Call Trace:
[ 3464.747706]  <TASK>
[ 3464.749918]  __schedule+0x2eb/0x8d0
[ 3464.753518]  schedule+0x5b/0xd0
[ 3464.756774]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.761681]  chown_common+0x152/0x250
[ 3464.765456]  ? __do_sys_newfstat+0x57/0x60
[ 3464.769687]  ? __fget_files+0x79/0xb0
[ 3464.773464]  ksys_fchown+0x74/0xb0
[ 3464.776979]  __x64_sys_fchown+0x16/0x20
[ 3464.780928]  do_syscall_64+0x38/0x90
[ 3464.784616]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.789780] RIP: 0033:0x444aeb8
[ 3464.793029] RSP: 002b:00007efda24156b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.800712] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.807959] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023f
[ 3464.815204] RBP: 00007efda43113c8 R08: 000000000000023f R09: 
0000000005bf68db
[ 3464.822449] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023f
[ 3464.829695] R13: 00007efda42f61ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.836944]  </TASK>
[ 3464.839248] task:k3s-server      state:D stack:    0 pid:71049 ppid: 
    1 flags:0x00000000
[ 3464.847715] Call Trace:
[ 3464.850273]  <TASK>
[ 3464.852485]  __schedule+0x2eb/0x8d0
[ 3464.856089]  schedule+0x5b/0xd0
[ 3464.859344]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.864254]  chown_common+0x152/0x250
[ 3464.868033]  ? __do_sys_newfstat+0x57/0x60
[ 3464.872242]  ? __fget_files+0x79/0xb0
[ 3464.876020]  ksys_fchown+0x74/0xb0
[ 3464.879537]  __x64_sys_fchown+0x16/0x20
[ 3464.883484]  do_syscall_64+0x38/0x90
[ 3464.887176]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.892343] RIP: 0033:0x444aeb8
[ 3464.895595] RSP: 002b:00007efda23f26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3464.903281] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3464.910527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000262
[ 3464.917773] RBP: 00007efda3757068 R08: 0000000000000262 R09: 
0000000005bf68db
[ 3464.925042] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000262
[ 3464.932302] R13: 00007efda3666e8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3464.939552]  </TASK>
[ 3464.941852] task:k3s-server      state:D stack:    0 pid:71050 ppid: 
    1 flags:0x00000000
[ 3464.950320] Call Trace:
[ 3464.952875]  <TASK>
[ 3464.955086]  __schedule+0x2eb/0x8d0
[ 3464.958690]  schedule+0x5b/0xd0
[ 3464.961946]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3464.966855]  chown_common+0x152/0x250
[ 3464.970634]  ? __do_sys_newfstat+0x57/0x60
[ 3464.974844]  ? __fget_files+0x79/0xb0
[ 3464.978621]  ksys_fchown+0x74/0xb0
[ 3464.982139]  __x64_sys_fchown+0x16/0x20
[ 3464.986089]  do_syscall_64+0x38/0x90
[ 3464.989778]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3464.994948] RIP: 0033:0x444aeb8
[ 3464.998198] RSP: 002b:00007efda23c76b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.005878] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.013126] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000024a
[ 3465.020372] RBP: 00007efda4068188 R08: 000000000000024a R09: 
0000000005bf68db
[ 3465.027626] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000024a
[ 3465.034871] R13: 00007efda2370e0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.042120]  </TASK>
[ 3465.044414] task:k3s-server      state:D stack:    0 pid:71051 ppid: 
    1 flags:0x00000000
[ 3465.052876] Call Trace:
[ 3465.055436]  <TASK>
[ 3465.057649]  __schedule+0x2eb/0x8d0
[ 3465.061258]  schedule+0x5b/0xd0
[ 3465.064511]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.069424]  chown_common+0x152/0x250
[ 3465.073203]  ? __do_sys_newfstat+0x57/0x60
[ 3465.077417]  ? __fget_files+0x79/0xb0
[ 3465.081197]  ksys_fchown+0x74/0xb0
[ 3465.084714]  __x64_sys_fchown+0x16/0x20
[ 3465.088734]  do_syscall_64+0x38/0x90
[ 3465.092429]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.097597] RIP: 0033:0x444aeb8
[ 3465.100851] RSP: 002b:00007efda23a46b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.108553] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.115799] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000023a
[ 3465.123050] RBP: 00007efda4310888 R08: 000000000000023a R09: 
0000000005bf68db
[ 3465.130297] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000023a
[ 3465.137542] R13: 00007efda2372d8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.144794]  </TASK>
[ 3465.147098] task:k3s-server      state:D stack:    0 pid:94011 ppid: 
    1 flags:0x00000000
[ 3465.155566] Call Trace:
[ 3465.158133]  <TASK>
[ 3465.160345]  __schedule+0x2eb/0x8d0
[ 3465.163959]  schedule+0x5b/0xd0
[ 3465.167217]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.172125]  chown_common+0x152/0x250
[ 3465.175914]  ? __do_sys_newfstat+0x57/0x60
[ 3465.180131]  ? __fget_files+0x79/0xb0
[ 3465.183916]  ksys_fchown+0x74/0xb0
[ 3465.187433]  __x64_sys_fchown+0x16/0x20
[ 3465.191384]  do_syscall_64+0x38/0x90
[ 3465.195073]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.200242] RIP: 0033:0x444aeb8
[ 3465.203522] RSP: 002b:00007efda2df46b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.211208] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.218454] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000273
[ 3465.225701] RBP: 00007efda32c3ac8 R08: 0000000000000273 R09: 
0000000005bf68db
[ 3465.232946] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000273
[ 3465.240196] R13: 00007efda2aaa31d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.247449]  </TASK>
[ 3465.249760] task:k3s-server      state:D stack:    0 pid:94012 ppid: 
    1 flags:0x00000000
[ 3465.258229] Call Trace:
[ 3465.260792]  <TASK>
[ 3465.263003]  __schedule+0x2eb/0x8d0
[ 3465.266607]  schedule+0x5b/0xd0
[ 3465.269858]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.274776]  chown_common+0x152/0x250
[ 3465.278561]  ? __do_sys_newfstat+0x57/0x60
[ 3465.282772]  ? __fget_files+0x79/0xb0
[ 3465.286562]  ksys_fchown+0x74/0xb0
[ 3465.290081]  __x64_sys_fchown+0x16/0x20
[ 3465.294033]  do_syscall_64+0x38/0x90
[ 3465.297724]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.302892] RIP: 0033:0x444aeb8
[ 3465.306149] RSP: 002b:00007efda2dd16b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.313831] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.321095] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000247
[ 3465.328348] RBP: 00007efda4067ac8 R08: 0000000000000247 R09: 
0000000005bf68db
[ 3465.335596] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000247
[ 3465.342847] R13: 00007efda44f0e0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.350094]  </TASK>
[ 3465.352408] task:k3s-server      state:D stack:    0 pid:94013 ppid: 
    1 flags:0x00000000
[ 3465.360876] Call Trace:
[ 3465.363436]  <TASK>
[ 3465.365647]  __schedule+0x2eb/0x8d0
[ 3465.369255]  schedule+0x5b/0xd0
[ 3465.372510]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.377417]  chown_common+0x152/0x250
[ 3465.381204]  ? __do_sys_newfstat+0x57/0x60
[ 3465.385416]  ? __fget_files+0x79/0xb0
[ 3465.389196]  ksys_fchown+0x74/0xb0
[ 3465.392710]  __x64_sys_fchown+0x16/0x20
[ 3465.396658]  do_syscall_64+0x38/0x90
[ 3465.400350]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.405521] RIP: 0033:0x444aeb8
[ 3465.408777] RSP: 002b:00007efda2b696b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.416464] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.423710] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000024d
[ 3465.430956] RBP: 00007efda4068848 R08: 000000000000024d R09: 
0000000005bf68db
[ 3465.438204] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000024d
[ 3465.445453] R13: 00007efda291236d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.452703]  </TASK>
[ 3465.455005] task:k3s-server      state:D stack:    0 pid:94014 ppid: 
    1 flags:0x00000000
[ 3465.463470] Call Trace:
[ 3465.466036]  <TASK>
[ 3465.468247]  __schedule+0x2eb/0x8d0
[ 3465.471851]  schedule+0x5b/0xd0
[ 3465.475125]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.480036]  chown_common+0x152/0x250
[ 3465.483814]  ? __do_sys_newfstat+0x57/0x60
[ 3465.488027]  ? __fget_files+0x79/0xb0
[ 3465.491804]  ksys_fchown+0x74/0xb0
[ 3465.495318]  __x64_sys_fchown+0x16/0x20
[ 3465.499269]  do_syscall_64+0x38/0x90
[ 3465.502960]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.508130] RIP: 0033:0x444aeb8
[ 3465.511384] RSP: 002b:00007efda2b056b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.519065] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.526311] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000253
[ 3465.533558] RBP: 00007efda4068f08 R08: 0000000000000253 R09: 
0000000005bf68db
[ 3465.540814] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000253
[ 3465.548066] R13: 00007efda36d46cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.555324]  </TASK>
[ 3465.557626] task:k3s-server      state:D stack:    0 pid:94015 ppid: 
    1 flags:0x00000000
[ 3465.566138] Call Trace:
[ 3465.568699]  <TASK>
[ 3465.570910]  __schedule+0x2eb/0x8d0
[ 3465.574516]  schedule+0x5b/0xd0
[ 3465.577768]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.582672]  chown_common+0x152/0x250
[ 3465.586446]  ? __do_sys_newfstat+0x57/0x60
[ 3465.590661]  ? __fget_files+0x79/0xb0
[ 3465.594437]  ksys_fchown+0x74/0xb0
[ 3465.597946]  __x64_sys_fchown+0x16/0x20
[ 3465.601905]  do_syscall_64+0x38/0x90
[ 3465.605592]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.610757] RIP: 0033:0x444aeb8
[ 3465.614018] RSP: 002b:00007efda2ae26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.621724] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.628986] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000024b
[ 3465.636234] RBP: 00007efda40683c8 R08: 000000000000024b R09: 
0000000005bf68db
[ 3465.643483] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000024b
[ 3465.650732] R13: 00007efda42f12ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.658013]  </TASK>
[ 3465.660325] task:k3s-server      state:D stack:    0 pid:94035 ppid: 
    1 flags:0x00000000
[ 3465.668789] Call Trace:
[ 3465.671345]  <TASK>
[ 3465.673552]  __schedule+0x2eb/0x8d0
[ 3465.677176]  schedule+0x5b/0xd0
[ 3465.680433]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.685337]  chown_common+0x152/0x250
[ 3465.689128]  ? __do_sys_newfstat+0x57/0x60
[ 3465.693336]  ? __fget_files+0x79/0xb0
[ 3465.697112]  ksys_fchown+0x74/0xb0
[ 3465.700633]  __x64_sys_fchown+0x16/0x20
[ 3465.704589]  do_syscall_64+0x38/0x90
[ 3465.708282]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.713444] RIP: 0033:0x444aeb8
[ 3465.716697] RSP: 002b:00007efda2a1c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.724381] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.731627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000255
[ 3465.738895] RBP: 00007efda37561c8 R08: 0000000000000255 R09: 
0000000005bf68db
[ 3465.746136] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000255
[ 3465.753379] R13: 00007efda36d5e7d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.760623]  </TASK>
[ 3465.762923] task:k3s-server      state:D stack:    0 pid:94036 ppid: 
    1 flags:0x00000000
[ 3465.771410] Call Trace:
[ 3465.773964]  <TASK>
[ 3465.776170]  __schedule+0x2eb/0x8d0
[ 3465.779771]  schedule+0x5b/0xd0
[ 3465.783022]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.787940]  chown_common+0x152/0x250
[ 3465.791716]  ? __do_sys_newfstat+0x57/0x60
[ 3465.795927]  ? __fget_files+0x79/0xb0
[ 3465.799705]  ksys_fchown+0x74/0xb0
[ 3465.803213]  __x64_sys_fchown+0x16/0x20
[ 3465.807154]  do_syscall_64+0x38/0x90
[ 3465.810840]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.816015] RIP: 0033:0x444aeb8
[ 3465.819269] RSP: 002b:00007efda29646b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.826948] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.834188] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000025f
[ 3465.841428] RBP: 00007efda37573c8 R08: 000000000000025f R09: 
0000000005bf68db
[ 3465.848667] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000025f
[ 3465.855907] R13: 00007efda36699ad R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.863156]  </TASK>
[ 3465.865454] task:k3s-server      state:D stack:    0 pid:94037 ppid: 
    1 flags:0x00000000
[ 3465.873918] Call Trace:
[ 3465.876469]  <TASK>
[ 3465.878673]  __schedule+0x2eb/0x8d0
[ 3465.882278]  schedule+0x5b/0xd0
[ 3465.885530]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.890433]  chown_common+0x152/0x250
[ 3465.894206]  ? __do_sys_newfstat+0x57/0x60
[ 3465.898412]  ? __fget_files+0x79/0xb0
[ 3465.902186]  ksys_fchown+0x74/0xb0
[ 3465.905695]  __x64_sys_fchown+0x16/0x20
[ 3465.909641]  do_syscall_64+0x38/0x90
[ 3465.913326]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3465.918494] RIP: 0033:0x444aeb8
[ 3465.921749] RSP: 002b:00007efda29416b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3465.929425] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3465.936685] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000027f
[ 3465.943931] RBP: 00007efda361ff48 R08: 000000000000027f R09: 
0000000005bf68db
[ 3465.951175] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000027f
[ 3465.958416] R13: 00007efda2be4b7d R14: 0000000000080006 R15: 
00000000000001a4
[ 3465.965681]  </TASK>
[ 3465.967978] task:k3s-server      state:D stack:    0 pid:94038 ppid: 
    1 flags:0x00000000
[ 3465.976438] Call Trace:
[ 3465.978992]  <TASK>
[ 3465.981196]  __schedule+0x2eb/0x8d0
[ 3465.984795]  schedule+0x5b/0xd0
[ 3465.988079]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3465.992993]  chown_common+0x152/0x250
[ 3465.996776]  ? __do_sys_newfstat+0x57/0x60
[ 3466.000989]  ? __fget_files+0x79/0xb0
[ 3466.004762]  ksys_fchown+0x74/0xb0
[ 3466.008274]  __x64_sys_fchown+0x16/0x20
[ 3466.012215]  do_syscall_64+0x38/0x90
[ 3466.015906]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.021073] RIP: 0033:0x444aeb8
[ 3466.024324] RSP: 002b:00007efda23696b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.032016] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.039259] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000279
[ 3466.046504] RBP: 00007efda361f888 R08: 0000000000000279 R09: 
0000000005bf68db
[ 3466.053761] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000279
[ 3466.061013] R13: 00007efda2d9c66d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.068264]  </TASK>
[ 3466.070567] task:k3s-server      state:D stack:    0 pid:94039 ppid: 
    1 flags:0x00000000
[ 3466.079038] Call Trace:
[ 3466.081601]  <TASK>
[ 3466.083812]  __schedule+0x2eb/0x8d0
[ 3466.087418]  schedule+0x5b/0xd0
[ 3466.090671]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.095577]  chown_common+0x152/0x250
[ 3466.099355]  ? __do_sys_newfstat+0x57/0x60
[ 3466.103562]  ? __fget_files+0x79/0xb0
[ 3466.107339]  ksys_fchown+0x74/0xb0
[ 3466.110855]  __x64_sys_fchown+0x16/0x20
[ 3466.114815]  do_syscall_64+0x38/0x90
[ 3466.118510]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.123679] RIP: 0033:0x444aeb8
[ 3466.126933] RSP: 002b:00007efda23466b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.134617] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.141867] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000234
[ 3466.149115] RBP: 00007efda4068a88 R08: 0000000000000234 R09: 
0000000005bf68db
[ 3466.156362] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000234
[ 3466.163607] R13: 00007efda36d1b7d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.170850]  </TASK>
[ 3466.173147] task:k3s-server      state:D stack:    0 pid:94040 ppid: 
    1 flags:0x00000000
[ 3466.181611] Call Trace:
[ 3466.184171]  <TASK>
[ 3466.186384]  __schedule+0x2eb/0x8d0
[ 3466.189989]  schedule+0x5b/0xd0
[ 3466.193270]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.198175]  chown_common+0x152/0x250
[ 3466.201950]  ? __do_sys_newfstat+0x57/0x60
[ 3466.206162]  ? __fget_files+0x79/0xb0
[ 3466.209941]  ksys_fchown+0x74/0xb0
[ 3466.213458]  __x64_sys_fchown+0x16/0x20
[ 3466.217405]  do_syscall_64+0x38/0x90
[ 3466.221096]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.226268] RIP: 0033:0x444aeb8
[ 3466.229526] RSP: 002b:00007efda23236b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.237210] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.244460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000257
[ 3466.251714] RBP: 00007efda3756648 R08: 0000000000000257 R09: 
0000000005bf68db
[ 3466.258964] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000257
[ 3466.266214] R13: 00007efda36d897d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.273464]  </TASK>
[ 3466.275767] task:k3s-server      state:D stack:    0 pid:94041 ppid: 
    1 flags:0x00000000
[ 3466.284235] Call Trace:
[ 3466.286797]  <TASK>
[ 3466.289010]  __schedule+0x2eb/0x8d0
[ 3466.292613]  schedule+0x5b/0xd0
[ 3466.295866]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.300774]  chown_common+0x152/0x250
[ 3466.304556]  ? __do_sys_newfstat+0x57/0x60
[ 3466.308766]  ? __fget_files+0x79/0xb0
[ 3466.312543]  ksys_fchown+0x74/0xb0
[ 3466.316058]  __x64_sys_fchown+0x16/0x20
[ 3466.320005]  do_syscall_64+0x38/0x90
[ 3466.323696]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.328863] RIP: 0033:0x444aeb8
[ 3466.332119] RSP: 002b:00007efda21696b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.339803] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.347049] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000251
[ 3466.354295] RBP: 00007efda4068cc8 R08: 0000000000000251 R09: 
0000000005bf68db
[ 3466.361542] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000251
[ 3466.368789] R13: 00007efda36d2f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.376037]  </TASK>
[ 3466.378337] task:k3s-server      state:D stack:    0 pid:94043 ppid: 
    1 flags:0x00000000
[ 3466.386805] Call Trace:
[ 3466.389362]  <TASK>
[ 3466.391578]  __schedule+0x2eb/0x8d0
[ 3466.395181]  schedule+0x5b/0xd0
[ 3466.398434]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.403352]  chown_common+0x152/0x250
[ 3466.407130]  ? __do_sys_newfstat+0x57/0x60
[ 3466.411341]  ? __fget_files+0x79/0xb0
[ 3466.415116]  ksys_fchown+0x74/0xb0
[ 3466.418631]  __x64_sys_fchown+0x16/0x20
[ 3466.422582]  do_syscall_64+0x38/0x90
[ 3466.426272]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.431448] RIP: 0033:0x444aeb8
[ 3466.434714] RSP: 002b:00007efda21236b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.442397] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.449646] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000248
[ 3466.456892] RBP: 00007efda3756408 R08: 0000000000000248 R09: 
0000000005bf68db
[ 3466.464139] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000248
[ 3466.471385] R13: 00007efda36d723d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.478637]  </TASK>
[ 3466.480939] task:k3s-server      state:D stack:    0 pid:94055 ppid: 
    1 flags:0x00000000
[ 3466.489405] Call Trace:
[ 3466.491965]  <TASK>
[ 3466.494178]  __schedule+0x2eb/0x8d0
[ 3466.497783]  schedule+0x5b/0xd0
[ 3466.501038]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.505948]  chown_common+0x152/0x250
[ 3466.509730]  ? __do_sys_newfstat+0x57/0x60
[ 3466.513944]  ? __fget_files+0x79/0xb0
[ 3466.517720]  ksys_fchown+0x74/0xb0
[ 3466.521236]  __x64_sys_fchown+0x16/0x20
[ 3466.525187]  do_syscall_64+0x38/0x90
[ 3466.528883]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.534050] RIP: 0033:0x444aeb8
[ 3466.537305] RSP: 002b:00007efda20ac6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.544990] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.552240] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000277
[ 3466.559489] RBP: 00007efda361f648 R08: 0000000000000277 R09: 
0000000005bf68db
[ 3466.566736] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000277
[ 3466.573985] R13: 00007efda2d9aebd R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.581237]  </TASK>
[ 3466.583537] task:k3s-server      state:D stack:    0 pid:94056 ppid: 
    1 flags:0x00000000
[ 3466.592010] Call Trace:
[ 3466.594566]  <TASK>
[ 3466.596776]  __schedule+0x2eb/0x8d0
[ 3466.600381]  schedule+0x5b/0xd0
[ 3466.603631]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.608540]  chown_common+0x152/0x250
[ 3466.612317]  ? __do_sys_newfstat+0x57/0x60
[ 3466.616529]  ? __fget_files+0x79/0xb0
[ 3466.620308]  ksys_fchown+0x74/0xb0
[ 3466.623821]  __x64_sys_fchown+0x16/0x20
[ 3466.627786]  do_syscall_64+0x38/0x90
[ 3466.634000]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.639188] RIP: 0033:0x444aeb8
[ 3466.642443] RSP: 002b:00007efda20266b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.650131] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.657377] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000283
[ 3466.664622] RBP: 00007efda36203c8 R08: 0000000000000283 R09: 
0000000005bf68db
[ 3466.671873] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000283
[ 3466.679120] R13: 00007efda2be72ed R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.686367]  </TASK>
[ 3466.688667] task:k3s-server      state:D stack:    0 pid:94059 ppid: 
    1 flags:0x00000000
[ 3466.697130] Call Trace:
[ 3466.699688]  <TASK>
[ 3466.701898]  __schedule+0x2eb/0x8d0
[ 3466.705508]  schedule+0x5b/0xd0
[ 3466.708768]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.713676]  chown_common+0x152/0x250
[ 3466.717458]  ? __do_sys_newfstat+0x57/0x60
[ 3466.721673]  ? __fget_files+0x79/0xb0
[ 3466.725469]  ksys_fchown+0x74/0xb0
[ 3466.728992]  __x64_sys_fchown+0x16/0x20
[ 3466.732941]  do_syscall_64+0x38/0x90
[ 3466.736630]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.741795] RIP: 0033:0x444aeb8
[ 3466.745049] RSP: 002b:00007efda1d7e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.752731] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.759978] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000265
[ 3466.767227] RBP: 00007efda3757608 R08: 0000000000000265 R09: 
0000000005bf68db
[ 3466.774491] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000265
[ 3466.781739] R13: 00007efda32b476d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.788986]  </TASK>
[ 3466.791291] task:k3s-server      state:D stack:    0 pid:94060 ppid: 
    1 flags:0x00000000
[ 3466.799755] Call Trace:
[ 3466.802319]  <TASK>
[ 3466.804532]  __schedule+0x2eb/0x8d0
[ 3466.808135]  schedule+0x5b/0xd0
[ 3466.811390]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.816297]  chown_common+0x152/0x250
[ 3466.820085]  ? __do_sys_newfstat+0x57/0x60
[ 3466.824306]  ? __fget_files+0x79/0xb0
[ 3466.828085]  ksys_fchown+0x74/0xb0
[ 3466.831600]  __x64_sys_fchown+0x16/0x20
[ 3466.835562]  do_syscall_64+0x38/0x90
[ 3466.839253]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.844424] RIP: 0033:0x444aeb8
[ 3466.847689] RSP: 002b:00007efda1d1b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.855373] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.862644] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000281
[ 3466.869892] RBP: 00007efda3620188 R08: 0000000000000281 R09: 
0000000005bf68db
[ 3466.877140] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000281
[ 3466.884390] R13: 00007efda2be574d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.891638]  </TASK>
[ 3466.893940] task:k3s-server      state:D stack:    0 pid:94061 ppid: 
    1 flags:0x00000000
[ 3466.902405] Call Trace:
[ 3466.904965]  <TASK>
[ 3466.907172]  __schedule+0x2eb/0x8d0
[ 3466.910777]  schedule+0x5b/0xd0
[ 3466.914032]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3466.918942]  chown_common+0x152/0x250
[ 3466.922723]  ? __do_sys_newfstat+0x57/0x60
[ 3466.926939]  ? __fget_files+0x79/0xb0
[ 3466.930721]  ksys_fchown+0x74/0xb0
[ 3466.934236]  __x64_sys_fchown+0x16/0x20
[ 3466.938183]  do_syscall_64+0x38/0x90
[ 3466.941873]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3466.947043] RIP: 0033:0x444aeb8
[ 3466.950295] RSP: 002b:00007efda1cc76b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3466.957979] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3466.965227] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000026f
[ 3466.972485] RBP: 00007efda361f1c8 R08: 000000000000026f R09: 
0000000005bf68db
[ 3466.979740] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000026f
[ 3466.986990] R13: 00007efda32bad8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3466.994241]  </TASK>
[ 3466.996545] task:k3s-server      state:D stack:    0 pid:94062 ppid: 
    1 flags:0x00000000
[ 3467.005012] Call Trace:
[ 3467.007570]  <TASK>
[ 3467.009800]  __schedule+0x2eb/0x8d0
[ 3467.013408]  schedule+0x5b/0xd0
[ 3467.016666]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.021576]  chown_common+0x152/0x250
[ 3467.025357]  ? __do_sys_newfstat+0x57/0x60
[ 3467.029568]  ? __fget_files+0x79/0xb0
[ 3467.033346]  ksys_fchown+0x74/0xb0
[ 3467.036860]  __x64_sys_fchown+0x16/0x20
[ 3467.040809]  do_syscall_64+0x38/0x90
[ 3467.044503]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.049684] RIP: 0033:0x444aeb8
[ 3467.052942] RSP: 002b:00007efda1ca46b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.060626] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.067874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000267
[ 3467.075220] RBP: 00007efda361fd08 R08: 0000000000000267 R09: 
0000000005bf68db
[ 3467.082477] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000267
[ 3467.089726] R13: 00007efda2d9ee0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.096980]  </TASK>
[ 3467.099282] task:k3s-server      state:D stack:    0 pid:94063 ppid: 
    1 flags:0x00000000
[ 3467.107746] Call Trace:
[ 3467.110305]  <TASK>
[ 3467.112519]  __schedule+0x2eb/0x8d0
[ 3467.116126]  schedule+0x5b/0xd0
[ 3467.119381]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.124281]  chown_common+0x152/0x250
[ 3467.128065]  ? __do_sys_newfstat+0x57/0x60
[ 3467.132290]  ? __fget_files+0x79/0xb0
[ 3467.136069]  ksys_fchown+0x74/0xb0
[ 3467.139586]  __x64_sys_fchown+0x16/0x20
[ 3467.143537]  do_syscall_64+0x38/0x90
[ 3467.147227]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.152393] RIP: 0033:0x444aeb8
[ 3467.155646] RSP: 002b:00007efda1c816b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.163330] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.170582] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000025b
[ 3467.177834] RBP: 00007efda3757848 R08: 000000000000025b R09: 
0000000005bf68db
[ 3467.185083] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000025b
[ 3467.192329] R13: 00007efda32b5ead R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.199576]  </TASK>
[ 3467.201877] task:k3s-server      state:D stack:    0 pid:94064 ppid: 
    1 flags:0x00000000
[ 3467.210349] Call Trace:
[ 3467.212909]  <TASK>
[ 3467.215121]  __schedule+0x2eb/0x8d0
[ 3467.218724]  schedule+0x5b/0xd0
[ 3467.221982]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.226896]  chown_common+0x152/0x250
[ 3467.230679]  ? __do_sys_newfstat+0x57/0x60
[ 3467.234891]  ? __fget_files+0x79/0xb0
[ 3467.238671]  ksys_fchown+0x74/0xb0
[ 3467.242185]  __x64_sys_fchown+0x16/0x20
[ 3467.246132]  do_syscall_64+0x38/0x90
[ 3467.249828]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.254998] RIP: 0033:0x444aeb8
[ 3467.258253] RSP: 002b:00007efda1c016b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.265934] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.273179] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000026d
[ 3467.280426] RBP: 00007efda3757f08 R08: 000000000000026d R09: 
0000000005bf68db
[ 3467.287675] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000026d
[ 3467.294922] R13: 00007efda32b99cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.302170]  </TASK>
[ 3467.304471] task:k3s-server      state:D stack:    0 pid:94078 ppid: 
    1 flags:0x00000000
[ 3467.312935] Call Trace:
[ 3467.315495]  <TASK>
[ 3467.317705]  __schedule+0x2eb/0x8d0
[ 3467.321308]  schedule+0x5b/0xd0
[ 3467.324564]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.329472]  chown_common+0x152/0x250
[ 3467.333251]  ? __do_sys_newfstat+0x57/0x60
[ 3467.337462]  ? __fget_files+0x79/0xb0
[ 3467.341241]  ksys_fchown+0x74/0xb0
[ 3467.344758]  __x64_sys_fchown+0x16/0x20
[ 3467.348705]  do_syscall_64+0x38/0x90
[ 3467.352396]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.357560] RIP: 0033:0x444aeb8
[ 3467.360816] RSP: 002b:00007efda1bde6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.368500] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.375748] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000269
[ 3467.382993] RBP: 00007efda3757a88 R08: 0000000000000269 R09: 
0000000005bf68db
[ 3467.390238] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000269
[ 3467.397482] R13: 00007efda32b6aad R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.404731]  </TASK>
[ 3467.407040] task:k3s-server      state:D stack:    0 pid:94079 ppid: 
    1 flags:0x00000000
[ 3467.415504] Call Trace:
[ 3467.418061]  <TASK>
[ 3467.420267]  __schedule+0x2eb/0x8d0
[ 3467.423871]  schedule+0x5b/0xd0
[ 3467.427125]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.432031]  chown_common+0x152/0x250
[ 3467.435813]  ? __do_sys_newfstat+0x57/0x60
[ 3467.440022]  ? __fget_files+0x79/0xb0
[ 3467.443798]  ksys_fchown+0x74/0xb0
[ 3467.447315]  __x64_sys_fchown+0x16/0x20
[ 3467.451263]  do_syscall_64+0x38/0x90
[ 3467.454952]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.460117] RIP: 0033:0x444aeb8
[ 3467.463370] RSP: 002b:00007efda1bbb6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.471052] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.478298] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000271
[ 3467.485546] RBP: 00007efda361f408 R08: 0000000000000271 R09: 
0000000005bf68db
[ 3467.492792] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000271
[ 3467.500043] R13: 00007efda2d99b4d R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.507292]  </TASK>
[ 3467.509592] task:k3s-server      state:D stack:    0 pid:94080 ppid: 
    1 flags:0x00000000
[ 3467.518056] Call Trace:
[ 3467.520614]  <TASK>
[ 3467.522824]  __schedule+0x2eb/0x8d0
[ 3467.526427]  schedule+0x5b/0xd0
[ 3467.529682]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.534589]  chown_common+0x152/0x250
[ 3467.538365]  ? __do_sys_newfstat+0x57/0x60
[ 3467.542576]  ? __fget_files+0x79/0xb0
[ 3467.546353]  ksys_fchown+0x74/0xb0
[ 3467.549869]  __x64_sys_fchown+0x16/0x20
[ 3467.553821]  do_syscall_64+0x38/0x90
[ 3467.557512]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.562678] RIP: 0033:0x444aeb8
[ 3467.565933] RSP: 002b:00007efda1b986b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.573613] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.580862] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000027b
[ 3467.588114] RBP: 00007efda361fac8 R08: 000000000000027b R09: 
0000000005bf68db
[ 3467.595360] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000027b
[ 3467.602605] R13: 00007efda2d9de0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.609854]  </TASK>
[ 3467.612153] task:k3s-server      state:D stack:    0 pid:94082 ppid: 
    1 flags:0x00000000
[ 3467.620618] Call Trace:
[ 3467.623178]  <TASK>
[ 3467.625391]  __schedule+0x2eb/0x8d0
[ 3467.629001]  schedule+0x5b/0xd0
[ 3467.632255]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.637163]  chown_common+0x152/0x250
[ 3467.640942]  ? __do_sys_newfstat+0x57/0x60
[ 3467.645152]  ? __fget_files+0x79/0xb0
[ 3467.648932]  ksys_fchown+0x74/0xb0
[ 3467.652447]  __x64_sys_fchown+0x16/0x20
[ 3467.656392]  do_syscall_64+0x38/0x90
[ 3467.660080]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.665246] RIP: 0033:0x444aeb8
[ 3467.668503] RSP: 002b:00007efda1b526b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.676185] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.683452] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000026b
[ 3467.690699] RBP: 00007efda3757cc8 R08: 000000000000026b R09: 
0000000005bf68db
[ 3467.697946] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000026b
[ 3467.705191] R13: 00007efda32b89fd R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.712444]  </TASK>
[ 3467.714744] task:k3s-server      state:D stack:    0 pid:94117 ppid: 
    1 flags:0x00000000
[ 3467.723209] Call Trace:
[ 3467.725768]  <TASK>
[ 3467.727978]  __schedule+0x2eb/0x8d0
[ 3467.731582]  schedule+0x5b/0xd0
[ 3467.734836]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.739742]  chown_common+0x152/0x250
[ 3467.743522]  ? __do_sys_newfstat+0x57/0x60
[ 3467.747734]  ? __fget_files+0x79/0xb0
[ 3467.751509]  ksys_fchown+0x74/0xb0
[ 3467.755024]  __x64_sys_fchown+0x16/0x20
[ 3467.758969]  do_syscall_64+0x38/0x90
[ 3467.762657]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.767825] RIP: 0033:0x444aeb8
[ 3467.771081] RSP: 002b:00007efda17e16b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.778770] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.786029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000289
[ 3467.793284] RBP: 00007efda3620cc8 R08: 0000000000000289 R09: 
0000000005bf68db
[ 3467.800533] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000289
[ 3467.807780] R13: 00007efda2b40b3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.815032]  </TASK>
[ 3467.817351] task:k3s-server      state:D stack:    0 pid:94118 ppid: 
    1 flags:0x00000000
[ 3467.825817] Call Trace:
[ 3467.828393]  <TASK>
[ 3467.830602]  __schedule+0x2eb/0x8d0
[ 3467.834212]  schedule+0x5b/0xd0
[ 3467.837468]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.842388]  chown_common+0x152/0x250
[ 3467.846178]  ? __do_sys_newfstat+0x57/0x60
[ 3467.850392]  ? __fget_files+0x79/0xb0
[ 3467.854176]  ksys_fchown+0x74/0xb0
[ 3467.857690]  __x64_sys_fchown+0x16/0x20
[ 3467.861642]  do_syscall_64+0x38/0x90
[ 3467.865335]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.870510] RIP: 0033:0x444aeb8
[ 3467.873766] RSP: 002b:00007efda159c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.881458] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.888707] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000028d
[ 3467.895979] RBP: 00007efda32c42a8 R08: 000000000000028d R09: 
0000000005bf68db
[ 3467.903225] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000028d
[ 3467.910488] R13: 00007efda2aaea2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3467.917744]  </TASK>
[ 3467.920045] task:k3s-server      state:D stack:    0 pid:94119 ppid: 
    1 flags:0x00000000
[ 3467.928511] Call Trace:
[ 3467.931072]  <TASK>
[ 3467.933285]  __schedule+0x2eb/0x8d0
[ 3467.936896]  schedule+0x5b/0xd0
[ 3467.940154]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3467.945062]  chown_common+0x152/0x250
[ 3467.948841]  ? __do_sys_newfstat+0x57/0x60
[ 3467.953062]  ? __fget_files+0x79/0xb0
[ 3467.956841]  ksys_fchown+0x74/0xb0
[ 3467.960363]  __x64_sys_fchown+0x16/0x20
[ 3467.964311]  do_syscall_64+0x38/0x90
[ 3467.968005]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3467.973181] RIP: 0033:0x444aeb8
[ 3467.976440] RSP: 002b:00007efda15796b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3467.984143] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3467.991392] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000291
[ 3467.998643] RBP: 00007efda32c3408 R08: 0000000000000291 R09: 
0000000005bf68db
[ 3468.005894] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000291
[ 3468.013142] R13: 00007efda2b44e8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.020393]  </TASK>
[ 3468.022705] task:k3s-server      state:D stack:    0 pid:94120 ppid: 
    1 flags:0x00000000
[ 3468.031170] Call Trace:
[ 3468.033732]  <TASK>
[ 3468.035946]  __schedule+0x2eb/0x8d0
[ 3468.039555]  schedule+0x5b/0xd0
[ 3468.042810]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.047719]  chown_common+0x152/0x250
[ 3468.051500]  ? __do_sys_newfstat+0x57/0x60
[ 3468.055713]  ? __fget_files+0x79/0xb0
[ 3468.059493]  ksys_fchown+0x74/0xb0
[ 3468.063008]  __x64_sys_fchown+0x16/0x20
[ 3468.066958]  do_syscall_64+0x38/0x90
[ 3468.070649]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.075818] RIP: 0033:0x444aeb8
[ 3468.079073] RSP: 002b:00007efda15566b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.086756] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.094002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000020f
[ 3468.101251] RBP: 00007efda3620608 R08: 000000000000020f R09: 
0000000005bf68db
[ 3468.108498] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000020f
[ 3468.115743] R13: 00007efda2be8a9d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.122992]  </TASK>
[ 3468.125295] task:k3s-server      state:D stack:    0 pid:94139 ppid: 
    1 flags:0x00000000
[ 3468.133758] Call Trace:
[ 3468.136318]  <TASK>
[ 3468.138528]  __schedule+0x2eb/0x8d0
[ 3468.142142]  schedule+0x5b/0xd0
[ 3468.145397]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.150305]  chown_common+0x152/0x250
[ 3468.154082]  ? __do_sys_newfstat+0x57/0x60
[ 3468.158298]  ? __fget_files+0x79/0xb0
[ 3468.162075]  ksys_fchown+0x74/0xb0
[ 3468.165595]  __x64_sys_fchown+0x16/0x20
[ 3468.169544]  do_syscall_64+0x38/0x90
[ 3468.173232]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.178402] RIP: 0033:0x444aeb8
[ 3468.181658] RSP: 002b:00007efda15336b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.189340] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.196585] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000029a
[ 3468.203832] RBP: 00007efda32c43c8 R08: 000000000000029a R09: 
0000000005bf68db
[ 3468.211083] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000029a
[ 3468.218332] R13: 00007efda2aae63d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.225582]  </TASK>
[ 3468.227884] task:k3s-server      state:D stack:    0 pid:94140 ppid: 
    1 flags:0x00000000
[ 3468.236348] Call Trace:
[ 3468.238908]  <TASK>
[ 3468.241125]  __schedule+0x2eb/0x8d0
[ 3468.244731]  schedule+0x5b/0xd0
[ 3468.247987]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.252897]  chown_common+0x152/0x250
[ 3468.256677]  ? __fget_files+0x79/0xb0
[ 3468.260458]  ksys_fchown+0x74/0xb0
[ 3468.263976]  __x64_sys_fchown+0x16/0x20
[ 3468.267927]  do_syscall_64+0x38/0x90
[ 3468.271615]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.276782] RIP: 0033:0x444aeb8
[ 3468.280037] RSP: 002b:00007efda15106b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.287719] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.294985] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001a3
[ 3468.302232] RBP: 00007efda2b2e888 R08: 00000000000001a3 R09: 
0000000005bf68db
[ 3468.309479] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001a3
[ 3468.316725] R13: 00007efda28b5f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.323974]  </TASK>
[ 3468.326273] task:k3s-server      state:D stack:    0 pid:94141 ppid: 
    1 flags:0x00000000
[ 3468.334741] Call Trace:
[ 3468.337299]  <TASK>
[ 3468.339511]  __schedule+0x2eb/0x8d0
[ 3468.343116]  schedule+0x5b/0xd0
[ 3468.346368]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.351278]  chown_common+0x152/0x250
[ 3468.355056]  ? __do_sys_newfstat+0x57/0x60
[ 3468.359269]  ? __fget_files+0x79/0xb0
[ 3468.363044]  ksys_fchown+0x74/0xb0
[ 3468.366564]  __x64_sys_fchown+0x16/0x20
[ 3468.370512]  do_syscall_64+0x38/0x90
[ 3468.374203]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.379376] RIP: 0033:0x444aeb8
[ 3468.382630] RSP: 002b:00007efda12da6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.390312] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.397559] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000293
[ 3468.404805] RBP: 00007efda32c3648 R08: 0000000000000293 R09: 
0000000005bf68db
[ 3468.412073] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000293
[ 3468.419319] R13: 00007efda2b4662d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.426565]  </TASK>
[ 3468.428865] task:k3s-server      state:D stack:    0 pid:94142 ppid: 
    1 flags:0x00000000
[ 3468.437331] Call Trace:
[ 3468.439892]  <TASK>
[ 3468.442107]  __schedule+0x2eb/0x8d0
[ 3468.445714]  schedule+0x5b/0xd0
[ 3468.448966]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.453876]  chown_common+0x152/0x250
[ 3468.457665]  ? __do_sys_newfstat+0x57/0x60
[ 3468.461876]  ? __fget_files+0x79/0xb0
[ 3468.465652]  ksys_fchown+0x74/0xb0
[ 3468.469170]  __x64_sys_fchown+0x16/0x20
[ 3468.473116]  do_syscall_64+0x38/0x90
[ 3468.476808]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.481974] RIP: 0033:0x444aeb8
[ 3468.485227] RSP: 002b:00007efda12b76b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.492907] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.500154] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000296
[ 3468.507400] RBP: 00007efda32c3d08 R08: 0000000000000296 R09: 
0000000005bf68db
[ 3468.514647] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000296
[ 3468.521896] R13: 00007efda2aab6cd R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.529144]  </TASK>
[ 3468.531444] task:k3s-server      state:D stack:    0 pid:94143 ppid: 
    1 flags:0x00000000
[ 3468.539910] Call Trace:
[ 3468.542470]  <TASK>
[ 3468.544681]  __schedule+0x2eb/0x8d0
[ 3468.548290]  schedule+0x5b/0xd0
[ 3468.551546]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.556455]  chown_common+0x152/0x250
[ 3468.560237]  ? __do_sys_newfstat+0x57/0x60
[ 3468.564447]  ? __fget_files+0x79/0xb0
[ 3468.568222]  ksys_fchown+0x74/0xb0
[ 3468.571737]  __x64_sys_fchown+0x16/0x20
[ 3468.575684]  do_syscall_64+0x38/0x90
[ 3468.579375]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.584544] RIP: 0033:0x444aeb8
[ 3468.587796] RSP: 002b:00007efda12946b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.595475] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.602723] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a0
[ 3468.609975] RBP: 00007efda32c4848 R08: 00000000000002a0 R09: 
0000000005bf68db
[ 3468.617224] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a0
[ 3468.624472] R13: 00007efda29f476d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.631722]  </TASK>
[ 3468.634026] task:k3s-server      state:D stack:    0 pid:94144 ppid: 
    1 flags:0x00000000
[ 3468.642491] Call Trace:
[ 3468.645052]  <TASK>
[ 3468.647269]  __schedule+0x2eb/0x8d0
[ 3468.650877]  schedule+0x5b/0xd0
[ 3468.654132]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.659040]  chown_common+0x152/0x250
[ 3468.662822]  ? __do_sys_newfstat+0x57/0x60
[ 3468.667034]  ? __fget_files+0x79/0xb0
[ 3468.670818]  ksys_fchown+0x74/0xb0
[ 3468.676167]  __x64_sys_fchown+0x16/0x20
[ 3468.680115]  do_syscall_64+0x38/0x90
[ 3468.683807]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.688977] RIP: 0033:0x444aeb8
[ 3468.692230] RSP: 002b:00007efda12716b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.699913] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.707161] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000287
[ 3468.714408] RBP: 00007efda3620a88 R08: 0000000000000287 R09: 
0000000005bf68db
[ 3468.721654] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000287
[ 3468.728902] R13: 00007efda2beb58d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.736151]  </TASK>
[ 3468.738452] task:k3s-server      state:D stack:    0 pid:94145 ppid: 
    1 flags:0x00000000
[ 3468.746915] Call Trace:
[ 3468.749471]  <TASK>
[ 3468.751679]  __schedule+0x2eb/0x8d0
[ 3468.755281]  schedule+0x5b/0xd0
[ 3468.758536]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.763448]  chown_common+0x152/0x250
[ 3468.767234]  ? __do_sys_newfstat+0x57/0x60
[ 3468.771447]  ? __fget_files+0x79/0xb0
[ 3468.775222]  ksys_fchown+0x74/0xb0
[ 3468.778737]  __x64_sys_fchown+0x16/0x20
[ 3468.782685]  do_syscall_64+0x38/0x90
[ 3468.786377]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.791544] RIP: 0033:0x444aeb8
[ 3468.794806] RSP: 002b:00007efda124e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.802490] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.809742] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000027d
[ 3468.816990] RBP: 00007efda3620848 R08: 000000000000027d R09: 
0000000005bf68db
[ 3468.824237] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000027d
[ 3468.831482] R13: 00007efda2be9ded R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.838735]  </TASK>
[ 3468.841035] task:k3s-server      state:D stack:    0 pid:94146 ppid: 
    1 flags:0x00000000
[ 3468.849507] Call Trace:
[ 3468.852065]  <TASK>
[ 3468.854274]  __schedule+0x2eb/0x8d0
[ 3468.857878]  schedule+0x5b/0xd0
[ 3468.861132]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.866053]  chown_common+0x152/0x250
[ 3468.869835]  ? __do_sys_newfstat+0x57/0x60
[ 3468.874046]  ? __fget_files+0x79/0xb0
[ 3468.877829]  ksys_fchown+0x74/0xb0
[ 3468.881345]  __x64_sys_fchown+0x16/0x20
[ 3468.885293]  do_syscall_64+0x38/0x90
[ 3468.888984]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.894155] RIP: 0033:0x444aeb8
[ 3468.897411] RSP: 002b:00007efda122b6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3468.905092] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3468.912340] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000299
[ 3468.919588] RBP: 00007efda32c3f48 R08: 0000000000000299 R09: 
0000000005bf68db
[ 3468.926848] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000299
[ 3468.934096] R13: 00007efda2aace7d R14: 0000000000080006 R15: 
00000000000001a4
[ 3468.941345]  </TASK>
[ 3468.943647] task:k3s-server      state:D stack:    0 pid:94147 ppid: 
    1 flags:0x00000000
[ 3468.952125] Call Trace:
[ 3468.954689]  <TASK>
[ 3468.956903]  __schedule+0x2eb/0x8d0
[ 3468.960516]  schedule+0x5b/0xd0
[ 3468.963776]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3468.968686]  chown_common+0x152/0x250
[ 3468.972485]  ? __do_sys_newfstat+0x57/0x60
[ 3468.976702]  ? __fget_files+0x79/0xb0
[ 3468.980484]  ksys_fchown+0x74/0xb0
[ 3468.984001]  __x64_sys_fchown+0x16/0x20
[ 3468.987952]  do_syscall_64+0x38/0x90
[ 3468.991643]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3468.996817] RIP: 0033:0x444aeb8
[ 3469.000075] RSP: 002b:00007efda12086b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.007759] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.015008] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002ae
[ 3469.022260] RBP: 00007efda2b2e648 R08: 00000000000002ae R09: 
0000000005bf68db
[ 3469.029510] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002ae
[ 3469.036758] R13: 00007efda28b4b4d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.044007]  </TASK>
[ 3469.046310] task:k3s-server      state:D stack:    0 pid:94166 ppid: 
    1 flags:0x00000000
[ 3469.054781] Call Trace:
[ 3469.057346]  <TASK>
[ 3469.059560]  __schedule+0x2eb/0x8d0
[ 3469.063168]  schedule+0x5b/0xd0
[ 3469.066423]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.071331]  chown_common+0x152/0x250
[ 3469.075111]  ? __do_sys_newfstat+0x57/0x60
[ 3469.079324]  ? __fget_files+0x79/0xb0
[ 3469.083103]  ksys_fchown+0x74/0xb0
[ 3469.086617]  __x64_sys_fchown+0x16/0x20
[ 3469.090580]  do_syscall_64+0x38/0x90
[ 3469.094271]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.099436] RIP: 0033:0x444aeb8
[ 3469.102689] RSP: 002b:00007efda11e56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.110372] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.117619] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c7
[ 3469.124867] RBP: 00007efda32c31c8 R08: 00000000000001c7 R09: 
0000000005bf68db
[ 3469.132115] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c7
[ 3469.139361] R13: 00007efda2b43a8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.146611]  </TASK>
[ 3469.148913] task:k3s-server      state:D stack:    0 pid:94167 ppid: 
    1 flags:0x00000000
[ 3469.157376] Call Trace:
[ 3469.159938]  <TASK>
[ 3469.162147]  __schedule+0x2eb/0x8d0
[ 3469.165761]  schedule+0x5b/0xd0
[ 3469.169018]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.173929]  chown_common+0x152/0x250
[ 3469.177714]  ? __do_sys_newfstat+0x57/0x60
[ 3469.181926]  ? __fget_files+0x79/0xb0
[ 3469.185704]  ksys_fchown+0x74/0xb0
[ 3469.189217]  __x64_sys_fchown+0x16/0x20
[ 3469.193164]  do_syscall_64+0x38/0x90
[ 3469.196856]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.202023] RIP: 0033:0x444aeb8
[ 3469.205277] RSP: 002b:00007efda119f6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.212958] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.220203] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001b8
[ 3469.227452] RBP: 00007efda3620f08 R08: 00000000000001b8 R09: 
0000000005bf68db
[ 3469.234698] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001b8
[ 3469.241944] R13: 00007efda2b41f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.249193]  </TASK>
[ 3469.251492] task:k3s-server      state:D stack:    0 pid:94168 ppid: 
    1 flags:0x00000000
[ 3469.259956] Call Trace:
[ 3469.262513]  <TASK>
[ 3469.264735]  __schedule+0x2eb/0x8d0
[ 3469.268337]  schedule+0x5b/0xd0
[ 3469.271595]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.276505]  chown_common+0x152/0x250
[ 3469.280283]  ? __do_sys_newfstat+0x57/0x60
[ 3469.284495]  ? __fget_files+0x79/0xb0
[ 3469.288276]  ksys_fchown+0x74/0xb0
[ 3469.291792]  __x64_sys_fchown+0x16/0x20
[ 3469.295738]  do_syscall_64+0x38/0x90
[ 3469.299427]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.304595] RIP: 0033:0x444aeb8
[ 3469.307850] RSP: 002b:00007efda117c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.315535] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.322781] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002b3
[ 3469.330045] RBP: 00007efda2b2ed08 R08: 00000000000002b3 R09: 
0000000005bf68db
[ 3469.337293] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002b3
[ 3469.344538] R13: 00007efda28b8ded R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.351788]  </TASK>
[ 3469.354090] task:k3s-server      state:D stack:    0 pid:94169 ppid: 
    1 flags:0x00000000
[ 3469.362567] Call Trace:
[ 3469.365128]  <TASK>
[ 3469.367345]  __schedule+0x2eb/0x8d0
[ 3469.370952]  schedule+0x5b/0xd0
[ 3469.374206]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.379115]  chown_common+0x152/0x250
[ 3469.382894]  ? __do_sys_newfstat+0x57/0x60
[ 3469.387107]  ? __fget_files+0x79/0xb0
[ 3469.390889]  ksys_fchown+0x74/0xb0
[ 3469.394404]  __x64_sys_fchown+0x16/0x20
[ 3469.398353]  do_syscall_64+0x38/0x90
[ 3469.402044]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.407210] RIP: 0033:0x444aeb8
[ 3469.410462] RSP: 002b:00007efda11c26b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.418145] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.425394] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000295
[ 3469.432642] RBP: 00007efda32c3888 R08: 0000000000000295 R09: 
0000000005bf68db
[ 3469.439908] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000295
[ 3469.447160] R13: 00007efda2b47dcd R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.454416]  </TASK>
[ 3469.456722] task:k3s-server      state:D stack:    0 pid:94182 ppid: 
    1 flags:0x00000000
[ 3469.465193] Call Trace:
[ 3469.467752]  <TASK>
[ 3469.469962]  __schedule+0x2eb/0x8d0
[ 3469.473571]  schedule+0x5b/0xd0
[ 3469.476829]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.481737]  chown_common+0x152/0x250
[ 3469.485517]  ? __do_sys_newfstat+0x57/0x60
[ 3469.489730]  ? __fget_files+0x79/0xb0
[ 3469.493510]  ksys_fchown+0x74/0xb0
[ 3469.497025]  __x64_sys_fchown+0x16/0x20
[ 3469.500972]  do_syscall_64+0x38/0x90
[ 3469.504666]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.509831] RIP: 0033:0x444aeb8
[ 3469.513088] RSP: 002b:00007efda11596b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.520780] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.528028] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a1
[ 3469.535275] RBP: 00007efda32c4a88 R08: 00000000000002a1 R09: 
0000000005bf68db
[ 3469.542522] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a1
[ 3469.549767] R13: 00007efda29f5f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.557015]  </TASK>
[ 3469.559315] task:k3s-server      state:D stack:    0 pid:94183 ppid: 
    1 flags:0x00000000
[ 3469.567784] Call Trace:
[ 3469.570344]  <TASK>
[ 3469.572553]  __schedule+0x2eb/0x8d0
[ 3469.576155]  schedule+0x5b/0xd0
[ 3469.579410]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.584315]  chown_common+0x152/0x250
[ 3469.588093]  ? __do_sys_newfstat+0x57/0x60
[ 3469.592302]  ? __fget_files+0x79/0xb0
[ 3469.596081]  ksys_fchown+0x74/0xb0
[ 3469.599598]  __x64_sys_fchown+0x16/0x20
[ 3469.603545]  do_syscall_64+0x38/0x90
[ 3469.607235]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.612404] RIP: 0033:0x444aeb8
[ 3469.615660] RSP: 002b:00007efda11366b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.623345] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.630595] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002b8
[ 3469.637845] RBP: 00007efda2b2f608 R08: 00000000000002b8 R09: 
0000000005bf68db
[ 3469.645092] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002b8
[ 3469.652338] R13: 00007efda27e8aad R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.659586]  </TASK>
[ 3469.661889] task:k3s-server      state:D stack:    0 pid:94186 ppid: 
    1 flags:0x00000000
[ 3469.670354] Call Trace:
[ 3469.672914]  <TASK>
[ 3469.675127]  __schedule+0x2eb/0x8d0
[ 3469.678732]  schedule+0x5b/0xd0
[ 3469.681989]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.686897]  chown_common+0x152/0x250
[ 3469.690676]  ? __do_sys_newfstat+0x57/0x60
[ 3469.694888]  ? __fget_files+0x79/0xb0
[ 3469.698665]  ksys_fchown+0x74/0xb0
[ 3469.702177]  __x64_sys_fchown+0x16/0x20
[ 3469.706124]  do_syscall_64+0x38/0x90
[ 3469.709816]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.714983] RIP: 0033:0x444aeb8
[ 3469.718235] RSP: 002b:00007efda10f06b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.725918] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.733174] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a5
[ 3469.740425] RBP: 00007efda32c4cc8 R08: 00000000000002a5 R09: 
0000000005bf68db
[ 3469.747670] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a5
[ 3469.754933] R13: 00007efda29f764d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.762180]  </TASK>
[ 3469.764482] task:k3s-server      state:D stack:    0 pid:94187 ppid: 
    1 flags:0x00000000
[ 3469.772953] Call Trace:
[ 3469.775519]  <TASK>
[ 3469.777732]  __schedule+0x2eb/0x8d0
[ 3469.781338]  schedule+0x5b/0xd0
[ 3469.784591]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.789507]  chown_common+0x152/0x250
[ 3469.793288]  ? __do_sys_newfstat+0x57/0x60
[ 3469.797500]  ? __fget_files+0x79/0xb0
[ 3469.801279]  ksys_fchown+0x74/0xb0
[ 3469.804798]  __x64_sys_fchown+0x16/0x20
[ 3469.808752]  do_syscall_64+0x38/0x90
[ 3469.812442]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.817608] RIP: 0033:0x444aeb8
[ 3469.820856] RSP: 002b:00007efda10aa6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.828532] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.835776] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000000000029d
[ 3469.843024] RBP: 00007efda32c4608 R08: 000000000000029d R09: 
0000000005bf68db
[ 3469.850270] R10: 0000000000000000 R11: 0000000000000202 R12: 
000000000000029d
[ 3469.857529] R13: 00007efda2ab0d8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.864776]  </TASK>
[ 3469.867083] task:k3s-server      state:D stack:    0 pid:94188 ppid: 
    1 flags:0x00000000
[ 3469.875549] Call Trace:
[ 3469.878103]  <TASK>
[ 3469.880308]  __schedule+0x2eb/0x8d0
[ 3469.883907]  schedule+0x5b/0xd0
[ 3469.887154]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.892055]  chown_common+0x152/0x250
[ 3469.895828]  ? __do_sys_newfstat+0x57/0x60
[ 3469.900040]  ? __fget_files+0x79/0xb0
[ 3469.903815]  ksys_fchown+0x74/0xb0
[ 3469.907332]  __x64_sys_fchown+0x16/0x20
[ 3469.911284]  do_syscall_64+0x38/0x90
[ 3469.914976]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3469.920144] RIP: 0033:0x444aeb8
[ 3469.923408] RSP: 002b:00007efda10cd6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3469.931091] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3469.938340] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001c1
[ 3469.945587] RBP: 00007efda2b2eac8 R08: 00000000000001c1 R09: 
0000000005bf68db
[ 3469.952840] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001c1
[ 3469.960095] R13: 00007efda28b7a3d R14: 0000000000080006 R15: 
00000000000001a4
[ 3469.967345]  </TASK>
[ 3469.969648] task:k3s-server      state:D stack:    0 pid:94202 ppid: 
    1 flags:0x00000000
[ 3469.978114] Call Trace:
[ 3469.980698]  <TASK>
[ 3469.982912]  __schedule+0x2eb/0x8d0
[ 3469.986517]  schedule+0x5b/0xd0
[ 3469.989766]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3469.994674]  chown_common+0x152/0x250
[ 3469.998459]  ? __do_sys_newfstat+0x57/0x60
[ 3470.002694]  ? __fget_files+0x79/0xb0
[ 3470.006472]  ksys_fchown+0x74/0xb0
[ 3470.009986]  __x64_sys_fchown+0x16/0x20
[ 3470.013936]  do_syscall_64+0x38/0x90
[ 3470.017650]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.022825] RIP: 0033:0x444aeb8
[ 3470.026086] RSP: 002b:00007efda10876b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.033782] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.041035] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a9
[ 3470.048287] RBP: 00007efda32c4f08 R08: 00000000000002a9 R09: 
0000000005bf68db
[ 3470.055538] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a9
[ 3470.062788] R13: 00007efda29f89fd R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.070042]  </TASK>
[ 3470.072344] task:k3s-server      state:D stack:    0 pid:94203 ppid: 
    1 flags:0x00000000
[ 3470.080814] Call Trace:
[ 3470.083552]  <TASK>
[ 3470.085768]  __schedule+0x2eb/0x8d0
[ 3470.089379]  schedule+0x5b/0xd0
[ 3470.092644]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.097556]  chown_common+0x152/0x250
[ 3470.101337]  ? __do_sys_newfstat+0x57/0x60
[ 3470.105559]  ? __fget_files+0x79/0xb0
[ 3470.109345]  ksys_fchown+0x74/0xb0
[ 3470.112865]  __x64_sys_fchown+0x16/0x20
[ 3470.116815]  do_syscall_64+0x38/0x90
[ 3470.120508]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.125681] RIP: 0033:0x444aeb8
[ 3470.128938] RSP: 002b:00007efda10646b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.136625] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.143874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002b0
[ 3470.151122] RBP: 00007efda2b2f3c8 R08: 00000000000002b0 R09: 
0000000005bf68db
[ 3470.158369] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002b0
[ 3470.165614] R13: 00007efda27e6f0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.172863]  </TASK>
[ 3470.175163] task:k3s-server      state:D stack:    0 pid:94238 ppid: 
    1 flags:0x00000000
[ 3470.183628] Call Trace:
[ 3470.186189]  <TASK>
[ 3470.188397]  __schedule+0x2eb/0x8d0
[ 3470.192004]  schedule+0x5b/0xd0
[ 3470.195259]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.200168]  chown_common+0x152/0x250
[ 3470.203946]  ? __do_sys_newfstat+0x57/0x60
[ 3470.208157]  ? __fget_files+0x79/0xb0
[ 3470.211937]  ksys_fchown+0x74/0xb0
[ 3470.215449]  __x64_sys_fchown+0x16/0x20
[ 3470.219399]  do_syscall_64+0x38/0x90
[ 3470.223096]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.228264] RIP: 0033:0x444aeb8
[ 3470.231520] RSP: 002b:00007efda10416b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.239230] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.246480] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002bc
[ 3470.253729] RBP: 00007efda2b2f848 R08: 00000000000002bc R09: 
0000000005bf68db
[ 3470.260996] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002bc
[ 3470.268252] R13: 00007efda27e964d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.275501]  </TASK>
[ 3470.277801] task:k3s-server      state:D stack:    0 pid:94239 ppid: 
    1 flags:0x00000000
[ 3470.286265] Call Trace:
[ 3470.288827]  <TASK>
[ 3470.291037]  __schedule+0x2eb/0x8d0
[ 3470.294641]  schedule+0x5b/0xd0
[ 3470.297897]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.302806]  chown_common+0x152/0x250
[ 3470.306585]  ? __do_sys_newfstat+0x57/0x60
[ 3470.310799]  ? __fget_files+0x79/0xb0
[ 3470.314576]  ksys_fchown+0x74/0xb0
[ 3470.318093]  __x64_sys_fchown+0x16/0x20
[ 3470.322043]  do_syscall_64+0x38/0x90
[ 3470.325749]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.330924] RIP: 0033:0x444aeb8
[ 3470.334181] RSP: 002b:00007efda101e6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.341869] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.349119] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a2
[ 3470.356367] RBP: 00007efda2b2e408 R08: 00000000000002a2 R09: 
0000000005bf68db
[ 3470.363614] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a2
[ 3470.370860] R13: 00007efda28b337d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.378110]  </TASK>
[ 3470.380413] task:k3s-server      state:D stack:    0 pid:94240 ppid: 
    1 flags:0x00000000
[ 3470.388876] Call Trace:
[ 3470.391435]  <TASK>
[ 3470.393647]  __schedule+0x2eb/0x8d0
[ 3470.397250]  schedule+0x5b/0xd0
[ 3470.400504]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.405412]  chown_common+0x152/0x250
[ 3470.409192]  ? __do_sys_newfstat+0x57/0x60
[ 3470.413404]  ? __fget_files+0x79/0xb0
[ 3470.417186]  ksys_fchown+0x74/0xb0
[ 3470.420699]  __x64_sys_fchown+0x16/0x20
[ 3470.424649]  do_syscall_64+0x38/0x90
[ 3470.428341]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.433507] RIP: 0033:0x444aeb8
[ 3470.436759] RSP: 002b:00007efda0ffb6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.444441] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.451691] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002ab
[ 3470.458940] RBP: 00007efda2b2e1c8 R08: 00000000000002ab R09: 
0000000005bf68db
[ 3470.466188] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002ab
[ 3470.473436] R13: 00007efda29f99bd R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.480705]  </TASK>
[ 3470.483007] task:k3s-server      state:D stack:    0 pid:94256 ppid: 
    1 flags:0x00000000
[ 3470.491473] Call Trace:
[ 3470.494032]  <TASK>
[ 3470.496247]  __schedule+0x2eb/0x8d0
[ 3470.499858]  schedule+0x5b/0xd0
[ 3470.503114]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.508024]  chown_common+0x152/0x250
[ 3470.511805]  ? __do_sys_newfstat+0x57/0x60
[ 3470.516017]  ? __fget_files+0x79/0xb0
[ 3470.519796]  ksys_fchown+0x74/0xb0
[ 3470.523310]  __x64_sys_fchown+0x16/0x20
[ 3470.527262]  do_syscall_64+0x38/0x90
[ 3470.530950]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.536118] RIP: 0033:0x444aeb8
[ 3470.539373] RSP: 002b:00007efda0fd86b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.547054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.554303] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002c6
[ 3470.561548] RBP: 00007efda291e888 R08: 00000000000002c6 R09: 
0000000005bf68db
[ 3470.568793] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002c6
[ 3470.576041] R13: 00007efda27d3a0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.583291]  </TASK>
[ 3470.585592] task:k3s-server      state:D stack:    0 pid:94257 ppid: 
    1 flags:0x00000000
[ 3470.594060] Call Trace:
[ 3470.596622]  <TASK>
[ 3470.598832]  __schedule+0x2eb/0x8d0
[ 3470.602439]  schedule+0x5b/0xd0
[ 3470.605693]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.610602]  chown_common+0x152/0x250
[ 3470.614378]  ? __do_sys_newfstat+0x57/0x60
[ 3470.618587]  ? __fget_files+0x79/0xb0
[ 3470.622366]  ksys_fchown+0x74/0xb0
[ 3470.625880]  __x64_sys_fchown+0x16/0x20
[ 3470.629830]  do_syscall_64+0x38/0x90
[ 3470.633520]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.638698] RIP: 0033:0x444aeb8
[ 3470.641954] RSP: 002b:00007efda0e596b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.649634] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.656882] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a6
[ 3470.664131] RBP: 00007efda2b2f188 R08: 00000000000002a6 R09: 
0000000005bf68db
[ 3470.671377] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a6
[ 3470.678623] R13: 00007efda27e574d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.685872]  </TASK>
[ 3470.688179] task:k3s-server      state:D stack:    0 pid:94259 ppid: 
    1 flags:0x00000000
[ 3470.696641] Call Trace:
[ 3470.699198]  <TASK>
[ 3470.701408]  __schedule+0x2eb/0x8d0
[ 3470.705013]  schedule+0x5b/0xd0
[ 3470.708267]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.713175]  chown_common+0x152/0x250
[ 3470.717046]  ? __do_sys_newfstat+0x57/0x60
[ 3470.721257]  ? __fget_files+0x79/0xb0
[ 3470.725033]  ksys_fchown+0x74/0xb0
[ 3470.728547]  __x64_sys_fchown+0x16/0x20
[ 3470.732496]  do_syscall_64+0x38/0x90
[ 3470.736188]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.741352] RIP: 0033:0x444aeb8
[ 3470.744615] RSP: 002b:00007efda0e136b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.752297] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.759543] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002b4
[ 3470.766788] RBP: 00007efda2b2ef48 R08: 00000000000002b4 R09: 
0000000005bf68db
[ 3470.774039] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002b4
[ 3470.781286] R13: 00007efda28b8a2d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.788534]  </TASK>
[ 3470.790835] task:k3s-server      state:D stack:    0 pid:94260 ppid: 
    1 flags:0x00000000
[ 3470.799306] Call Trace:
[ 3470.801866]  <TASK>
[ 3470.804096]  __schedule+0x2eb/0x8d0
[ 3470.807703]  schedule+0x5b/0xd0
[ 3470.810957]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.815867]  chown_common+0x152/0x250
[ 3470.819654]  ? __do_sys_newfstat+0x57/0x60
[ 3470.823865]  ? __fget_files+0x79/0xb0
[ 3470.827658]  ksys_fchown+0x74/0xb0
[ 3470.831175]  __x64_sys_fchown+0x16/0x20
[ 3470.835120]  do_syscall_64+0x38/0x90
[ 3470.838810]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.843977] RIP: 0033:0x444aeb8
[ 3470.847232] RSP: 002b:00007efda0df06b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.854914] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.862160] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001cd
[ 3470.869408] RBP: 00007efda291ed08 R08: 00000000000001cd R09: 
0000000005bf68db
[ 3470.876653] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001cd
[ 3470.883898] R13: 00007efda23ca31d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.891147]  </TASK>
[ 3470.893446] task:k3s-server      state:D stack:    0 pid:94261 ppid: 
    1 flags:0x00000000
[ 3470.901911] Call Trace:
[ 3470.904465]  <TASK>
[ 3470.906677]  __schedule+0x2eb/0x8d0
[ 3470.910280]  schedule+0x5b/0xd0
[ 3470.913534]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3470.918442]  chown_common+0x152/0x250
[ 3470.922220]  ? __do_sys_newfstat+0x57/0x60
[ 3470.926435]  ? __fget_files+0x79/0xb0
[ 3470.930213]  ksys_fchown+0x74/0xb0
[ 3470.933727]  __x64_sys_fchown+0x16/0x20
[ 3470.937678]  do_syscall_64+0x38/0x90
[ 3470.941371]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3470.946541] RIP: 0033:0x444aeb8
[ 3470.949790] RSP: 002b:00007efda0dcd6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3470.957470] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3470.964713] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002c4
[ 3470.971952] RBP: 00007efda291e648 R08: 00000000000002c4 R09: 
0000000005bf68db
[ 3470.979199] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002c4
[ 3470.986447] R13: 00007efda27d1e8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3470.993697]  </TASK>
[ 3470.995992] task:k3s-server      state:D stack:    0 pid:94278 ppid: 
    1 flags:0x00000000
[ 3471.004456] Call Trace:
[ 3471.007012]  <TASK>
[ 3471.009217]  __schedule+0x2eb/0x8d0
[ 3471.012816]  schedule+0x5b/0xd0
[ 3471.016067]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.020973]  chown_common+0x152/0x250
[ 3471.024751]  ? __do_sys_newfstat+0x57/0x60
[ 3471.028955]  ? __fget_files+0x79/0xb0
[ 3471.032727]  ksys_fchown+0x74/0xb0
[ 3471.036235]  __x64_sys_fchown+0x16/0x20
[ 3471.040181]  do_syscall_64+0x38/0x90
[ 3471.043868]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.049029] RIP: 0033:0x444aeb8
[ 3471.052282] RSP: 002b:00007efda0d876b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.059970] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.067219] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001b9
[ 3471.074465] RBP: 00007efda2b2fcc8 R08: 00000000000001b9 R09: 
0000000005bf68db
[ 3471.081714] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001b9
[ 3471.088959] R13: 00007efda27ec9dd R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.096210]  </TASK>
[ 3471.098510] task:k3s-server      state:D stack:    0 pid:94279 ppid: 
    1 flags:0x00000000
[ 3471.106983] Call Trace:
[ 3471.109544]  <TASK>
[ 3471.111757]  __schedule+0x2eb/0x8d0
[ 3471.115367]  schedule+0x5b/0xd0
[ 3471.118628]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.123538]  chown_common+0x152/0x250
[ 3471.127318]  ? __do_sys_newfstat+0x57/0x60
[ 3471.131529]  ? __fget_files+0x79/0xb0
[ 3471.135306]  ksys_fchown+0x74/0xb0
[ 3471.138816]  __x64_sys_fchown+0x16/0x20
[ 3471.142761]  do_syscall_64+0x38/0x90
[ 3471.146458]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.151626] RIP: 0033:0x444aeb8
[ 3471.154881] RSP: 002b:00007efda0d646b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.162583] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.169831] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002c2
[ 3471.177079] RBP: 00007efda291e1c8 R08: 00000000000002c2 R09: 
0000000005bf68db
[ 3471.184333] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002c2
[ 3471.191580] R13: 00007efda27ce33d R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.198836]  </TASK>
[ 3471.201137] task:k3s-server      state:D stack:    0 pid:94281 ppid: 
    1 flags:0x00000000
[ 3471.209602] Call Trace:
[ 3471.212161]  <TASK>
[ 3471.214374]  __schedule+0x2eb/0x8d0
[ 3471.217975]  schedule+0x5b/0xd0
[ 3471.221230]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.226135]  chown_common+0x152/0x250
[ 3471.229912]  ? __do_sys_newfstat+0x57/0x60
[ 3471.234124]  ? __fget_files+0x79/0xb0
[ 3471.237903]  ksys_fchown+0x74/0xb0
[ 3471.241427]  __x64_sys_fchown+0x16/0x20
[ 3471.245377]  do_syscall_64+0x38/0x90
[ 3471.249065]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.254230] RIP: 0033:0x444aeb8
[ 3471.257487] RSP: 002b:00007efda0d416b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.265171] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.272436] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002be
[ 3471.279697] RBP: 00007efda2b2fa88 R08: 00000000000002be R09: 
0000000005bf68db
[ 3471.286940] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002be
[ 3471.294183] R13: 00007efda27eae0d R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.301438]  </TASK>
[ 3471.303741] task:k3s-server      state:D stack:    0 pid:94298 ppid: 
    1 flags:0x00000000
[ 3471.312208] Call Trace:
[ 3471.314762]  <TASK>
[ 3471.316967]  __schedule+0x2eb/0x8d0
[ 3471.320567]  schedule+0x5b/0xd0
[ 3471.323821]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.328726]  chown_common+0x152/0x250
[ 3471.332501]  ? __do_sys_newfstat+0x57/0x60
[ 3471.336713]  ? __fget_files+0x79/0xb0
[ 3471.340485]  ksys_fchown+0x74/0xb0
[ 3471.343999]  __x64_sys_fchown+0x16/0x20
[ 3471.347948]  do_syscall_64+0x38/0x90
[ 3471.351641]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.356811] RIP: 0033:0x444aeb8
[ 3471.360065] RSP: 002b:00007efda0cb56b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.367748] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.374994] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002c1
[ 3471.382238] RBP: 00007efda2b2ff08 R08: 00000000000002c1 R09: 
0000000005bf68db
[ 3471.389487] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002c1
[ 3471.396739] R13: 00007efda27cdf4d R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.403984]  </TASK>
[ 3471.406281] task:k3s-server      state:D stack:    0 pid:94315 ppid: 
    1 flags:0x00000000
[ 3471.414744] Call Trace:
[ 3471.417304]  <TASK>
[ 3471.419508]  __schedule+0x2eb/0x8d0
[ 3471.423112]  schedule+0x5b/0xd0
[ 3471.426366]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.431278]  chown_common+0x152/0x250
[ 3471.435053]  ? __do_sys_newfstat+0x57/0x60
[ 3471.439271]  ? __fget_files+0x79/0xb0
[ 3471.443045]  ksys_fchown+0x74/0xb0
[ 3471.446560]  __x64_sys_fchown+0x16/0x20
[ 3471.450504]  do_syscall_64+0x38/0x90
[ 3471.454196]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.459367] RIP: 0033:0x444aeb8
[ 3471.462618] RSP: 002b:00007efda0b4c6b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.470301] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.477543] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002a3
[ 3471.484783] RBP: 00007efda291e408 R08: 00000000000002a3 R09: 
0000000005bf68db
[ 3471.492028] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002a3
[ 3471.499275] R13: 00007efda27d0aad R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.506522]  </TASK>
[ 3471.508819] task:k3s-server      state:D stack:    0 pid:94316 ppid: 
    1 flags:0x00000000
[ 3471.517279] Call Trace:
[ 3471.519831]  <TASK>
[ 3471.522039]  __schedule+0x2eb/0x8d0
[ 3471.525639]  schedule+0x5b/0xd0
[ 3471.528889]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.533795]  chown_common+0x152/0x250
[ 3471.537570]  ? __do_sys_newfstat+0x57/0x60
[ 3471.541779]  ? __fget_files+0x79/0xb0
[ 3471.545553]  ksys_fchown+0x74/0xb0
[ 3471.549068]  __x64_sys_fchown+0x16/0x20
[ 3471.553017]  do_syscall_64+0x38/0x90
[ 3471.556699]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.561874] RIP: 0033:0x444aeb8
[ 3471.565120] RSP: 002b:00007efda0b066b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.572805] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.580048] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000001fc
[ 3471.587289] RBP: 00007efda291ef48 R08: 00000000000001fc R09: 
0000000005bf68db
[ 3471.594528] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000001fc
[ 3471.601772] R13: 00007efda23cbead R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.609025]  </TASK>
[ 3471.611326] task:k3s-server      state:D stack:    0 pid:94318 ppid: 
    1 flags:0x00000000
[ 3471.619886] Call Trace:
[ 3471.622444]  <TASK>
[ 3471.624648]  __schedule+0x2eb/0x8d0
[ 3471.628253]  schedule+0x5b/0xd0
[ 3471.631503]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3471.636405]  chown_common+0x152/0x250
[ 3471.640179]  ? __do_sys_newfstat+0x57/0x60
[ 3471.644393]  ? __fget_files+0x79/0xb0
[ 3471.648164]  ksys_fchown+0x74/0xb0
[ 3471.651675]  __x64_sys_fchown+0x16/0x20
[ 3471.655617]  do_syscall_64+0x38/0x90
[ 3471.659299]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.664458] RIP: 0033:0x444aeb8
[ 3471.667707] RSP: 002b:00007efda0b296b0 EFLAGS: 00000202 ORIG_RAX: 
000000000000005d
[ 3471.675382] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
000000000444aeb8
[ 3471.682628] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
00000000000002c8
[ 3471.689872] RBP: 00007efda291eac8 R08: 00000000000002c8 R09: 
0000000005bf68db
[ 3471.697113] R10: 0000000000000000 R11: 0000000000000202 R12: 
00000000000002c8
[ 3471.704355] R13: 00007efda27d4d8d R14: 0000000000080006 R15: 
00000000000001a4
[ 3471.711596]  </TASK>
[ 3471.713898] task:containerd      state:D stack:    0 pid:71058 ppid: 
70946 flags:0x00004000
[ 3471.722358] Call Trace:
[ 3471.724915]  <TASK>
[ 3471.727120]  __schedule+0x2eb/0x8d0
[ 3471.730731]  ? __es_remove_extent+0x6d/0x670 [ext4]
[ 3471.735740]  schedule+0x5b/0xd0
[ 3471.738992]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3471.744156]  ? wait_woken+0x70/0x70
[ 3471.747771]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3471.753026]  start_this_handle+0xfb/0x520 [jbd2]
[ 3471.757754]  ? alloc_page_buffers+0x9a/0x180
[ 3471.762132]  ? __cond_resched+0x16/0x50
[ 3471.766089]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3471.770991]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3471.776257]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3471.780838]  __mark_inode_dirty+0x144/0x320
[ 3471.785133]  generic_write_end+0xa9/0x140
[ 3471.789252]  generic_perform_write+0x104/0x1f0
[ 3471.793804]  ext4_buffered_write_iter+0xa7/0x180 [ext4]
[ 3471.799177]  new_sync_write+0x119/0x1b0
[ 3471.803123]  ? intel_get_event_constraints+0x300/0x390
[ 3471.808375]  vfs_write+0x1de/0x270
[ 3471.811913]  ksys_write+0x5f/0xe0
[ 3471.815338]  do_syscall_64+0x38/0x90
[ 3471.819028]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.824189] RIP: 0033:0x490f5b
[ 3471.827349] RSP: 002b:000000c003f7a0f0 EFLAGS: 00000206 ORIG_RAX: 
0000000000000001
[ 3471.835031] RAX: ffffffffffffffda RBX: 000000c000091000 RCX: 
0000000000490f5b
[ 3471.842275] RDX: 0000000000006693 RSI: 000000c042a80000 RDI: 
000000000000000c
[ 3471.849516] RBP: 000000c003f7a140 R08: 0000000000006693 R09: 
0000000000000004
[ 3471.856759] R10: 0000000000008000 R11: 0000000000000206 R12: 
0000000084180800
[ 3471.863999] R13: 0000000071fe4635 R14: 000000008781c39e R15: 
000000005596a4d4
[ 3471.871241]  </TASK>
[ 3471.873549] task:containerd      state:D stack:    0 pid:73222 ppid: 
70946 flags:0x00000000
[ 3471.882010] Call Trace:
[ 3471.884563]  <TASK>
[ 3471.886769]  __schedule+0x2eb/0x8d0
[ 3471.890378]  schedule+0x5b/0xd0
[ 3471.893636]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3471.898800]  ? wait_woken+0x70/0x70
[ 3471.902401]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3471.907648]  ? select_task_rq_fair+0x130/0xf90
[ 3471.912214]  start_this_handle+0xfb/0x520 [jbd2]
[ 3471.916940]  ? ttwu_queue_wakelist+0xf2/0x110
[ 3471.921406]  ? __cond_resched+0x16/0x50
[ 3471.925351]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3471.930255]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3471.935525]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3471.940096]  __mark_inode_dirty+0x144/0x320
[ 3471.944401]  generic_update_time+0x6c/0xd0
[ 3471.948618]  file_update_time+0x127/0x140
[ 3471.952743]  ? generic_write_checks+0x61/0xc0
[ 3471.957213]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3471.962575]  new_sync_write+0x119/0x1b0
[ 3471.966525]  ? intel_get_event_constraints+0x300/0x390
[ 3471.971777]  vfs_write+0x1de/0x270
[ 3471.975309]  ksys_write+0x5f/0xe0
[ 3471.978735]  do_syscall_64+0x38/0x90
[ 3471.982425]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3471.987589] RIP: 0033:0x490f5b
[ 3471.990751] RSP: 002b:000000c001ba1878 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3471.998429] RAX: ffffffffffffffda RBX: 000000c000082000 RCX: 
0000000000490f5b
[ 3472.005679] RDX: 0000000000000076 RSI: 000000c004c1c000 RDI: 
000000000000005a
[ 3472.012925] RBP: 000000c001ba18c8 R08: 0000000000000076 R09: 
0000000000000004
[ 3472.020279] R10: 00000000000000cd R11: 0000000000000212 R12: 
0000000000000115
[ 3472.027526] R13: 0000000000000031 R14: 0000000000000000 R15: 
0000000000000023
[ 3472.034770]  </TASK>
[ 3472.037065] task:containerd      state:D stack:    0 pid:73382 ppid: 
70946 flags:0x00000000
[ 3472.045546] Call Trace:
[ 3472.048102]  <TASK>
[ 3472.050309]  __schedule+0x2eb/0x8d0
[ 3472.053929]  schedule+0x5b/0xd0
[ 3472.057180]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.062368]  ? wait_woken+0x70/0x70
[ 3472.065971]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.071224]  ? __bpf_trace_tick_stop+0x10/0x10
[ 3472.075779]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.080507]  ? __cond_resched+0x16/0x50
[ 3472.084454]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.089365]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.094637]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.099216]  __mark_inode_dirty+0x144/0x320
[ 3472.103518]  ext4_setattr+0x1fb/0x9a0 [ext4]
[ 3472.107924]  notify_change+0x3c1/0x540
[ 3472.111804]  ? chown_common+0x168/0x250
[ 3472.115764]  chown_common+0x168/0x250
[ 3472.119541]  do_fchownat+0x8d/0xf0
[ 3472.123054]  __x64_sys_fchownat+0x21/0x30
[ 3472.127174]  do_syscall_64+0x38/0x90
[ 3472.130861]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.136027] RIP: 0033:0x490fca
[ 3472.139195] RSP: 002b:000000c0041f4240 EFLAGS: 00000202 ORIG_RAX: 
0000000000000104
[ 3472.146880] RAX: ffffffffffffffda RBX: 000000c000093800 RCX: 
0000000000490fca
[ 3472.154126] RDX: 0000000000000000 RSI: 000000c01cb26b40 RDI: 
ffffffffffffff9c
[ 3472.161367] RBP: 000000c0041f42b8 R08: 0000000000000100 R09: 
0000000000000000
[ 3472.168611] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[ 3472.175857] R13: 0000000000000040 R14: 0000000000000040 R15: 
00000000be13d948
[ 3472.183101]  </TASK>
[ 3472.185400] task:containerd      state:D stack:    0 pid:74254 ppid: 
70946 flags:0x00000000
[ 3472.193881] Call Trace:
[ 3472.196434]  <TASK>
[ 3472.198646]  __schedule+0x2eb/0x8d0
[ 3472.202247]  schedule+0x5b/0xd0
[ 3472.205499]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.210664]  ? wait_woken+0x70/0x70
[ 3472.214262]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.219515]  ? __bpf_trace_tick_stop+0x10/0x10
[ 3472.224067]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.228793]  ? __cond_resched+0x16/0x50
[ 3472.232738]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.237641]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.242912]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.247485]  __mark_inode_dirty+0x144/0x320
[ 3472.251780]  ext4_setattr+0x1fb/0x9a0 [ext4]
[ 3472.256181]  notify_change+0x3c1/0x540
[ 3472.260040]  ? chown_common+0x168/0x250
[ 3472.263992]  chown_common+0x168/0x250
[ 3472.267764]  do_fchownat+0x8d/0xf0
[ 3472.271275]  __x64_sys_fchownat+0x21/0x30
[ 3472.275406]  do_syscall_64+0x38/0x90
[ 3472.279100]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.284270] RIP: 0033:0x490fca
[ 3472.287445] RSP: 002b:000000c00211e240 EFLAGS: 00000202 ORIG_RAX: 
0000000000000104
[ 3472.295125] RAX: ffffffffffffffda RBX: 000000c000093800 RCX: 
0000000000490fca
[ 3472.302375] RDX: 0000000000000000 RSI: 000000c01ef34fc0 RDI: 
ffffffffffffff9c
[ 3472.309617] RBP: 000000c00211e2b8 R08: 0000000000000100 R09: 
0000000000000000
[ 3472.316862] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[ 3472.324108] R13: 0000000000000040 R14: 0000000000000040 R15: 
00000000d79f9d0d
[ 3472.331358]  </TASK>
[ 3472.333662] task:containerd      state:D stack:    0 pid:74961 ppid: 
70946 flags:0x00004000
[ 3472.342123] Call Trace:
[ 3472.344684]  <TASK>
[ 3472.346895]  __schedule+0x2eb/0x8d0
[ 3472.350500]  ? __es_remove_extent+0x6d/0x670 [ext4]
[ 3472.355522]  schedule+0x5b/0xd0
[ 3472.358782]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.363955]  ? wait_woken+0x70/0x70
[ 3472.367558]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.372815]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.377550]  ? alloc_page_buffers+0x9a/0x180
[ 3472.381937]  ? __cond_resched+0x16/0x50
[ 3472.385887]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.390795]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.396073]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.400650]  __mark_inode_dirty+0x144/0x320
[ 3472.404947]  generic_write_end+0xa9/0x140
[ 3472.409075]  generic_perform_write+0x104/0x1f0
[ 3472.413637]  ext4_buffered_write_iter+0xa7/0x180 [ext4]
[ 3472.418993]  new_sync_write+0x119/0x1b0
[ 3472.422951]  ? intel_get_event_constraints+0x300/0x390
[ 3472.428206]  vfs_write+0x1de/0x270
[ 3472.431722]  ksys_write+0x5f/0xe0
[ 3472.435152]  do_syscall_64+0x38/0x90
[ 3472.438842]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.444031] RIP: 0033:0x490f5b
[ 3472.447195] RSP: 002b:000000c0046380f0 EFLAGS: 00000206 ORIG_RAX: 
0000000000000001
[ 3472.454877] RAX: ffffffffffffffda RBX: 000000c000093800 RCX: 
0000000000490f5b
[ 3472.462124] RDX: 0000000000008000 RSI: 000000c01c50e000 RDI: 
00000000000001e0
[ 3472.469374] RBP: 000000c004638140 R08: 0000000000008000 R09: 
0000000000000004
[ 3472.476621] R10: 0000000000008000 R11: 0000000000000206 R12: 
0000000010800216
[ 3472.483869] R13: 0000000052d19bc9 R14: 000000001590d5cc R15: 
0000000080e26190
[ 3472.491115]  </TASK>
[ 3472.493436] task:containerd      state:D stack:    0 pid:78078 ppid: 
70946 flags:0x00000000
[ 3472.501905] Call Trace:
[ 3472.504466]  <TASK>
[ 3472.506686]  __schedule+0x2eb/0x8d0
[ 3472.510295]  ? __kmalloc+0x159/0x410
[ 3472.513988]  schedule+0x5b/0xd0
[ 3472.517244]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.522417]  ? wait_woken+0x70/0x70
[ 3472.526022]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.531285]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.536020]  ? __cond_resched+0x16/0x50
[ 3472.539988]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.544900]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.550180]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.554760]  __mark_inode_dirty+0x144/0x320
[ 3472.559058]  touch_atime+0x13c/0x150
[ 3472.562742]  iterate_dir+0x101/0x1c0
[ 3472.566430]  __x64_sys_getdents64+0x78/0x110
[ 3472.570814]  ? __ia32_sys_getdents64+0x110/0x110
[ 3472.575550]  do_syscall_64+0x38/0x90
[ 3472.579242]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.584410] RIP: 0033:0x490f5b
[ 3472.587578] RSP: 002b:000000c001a06d00 EFLAGS: 00000202 ORIG_RAX: 
00000000000000d9
[ 3472.595260] RAX: ffffffffffffffda RBX: 000000c00008e800 RCX: 
0000000000490f5b
[ 3472.602509] RDX: 0000000000002000 RSI: 000000c0427fa000 RDI: 
000000000000019d
[ 3472.609758] RBP: 000000c001a06d50 R08: 0000000000000000 R09: 
0000000000000000
[ 3472.617006] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[ 3472.624260] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000001
[ 3472.631522]  </TASK>
[ 3472.633824] task:containerd      state:D stack:    0 pid:78082 ppid: 
70946 flags:0x00000000
[ 3472.642287] Call Trace:
[ 3472.644847]  <TASK>
[ 3472.647061]  __schedule+0x2eb/0x8d0
[ 3472.650669]  schedule+0x5b/0xd0
[ 3472.653923]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.659094]  ? wait_woken+0x70/0x70
[ 3472.662699]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.667954]  ? cpumask_next+0x1e/0x30
[ 3472.671751]  ? select_task_rq_fair+0x130/0xf90
[ 3472.676317]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.681051]  ? ttwu_queue_wakelist+0xf2/0x110
[ 3472.685521]  ? __cond_resched+0x16/0x50
[ 3472.689480]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.694391]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.699676]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.704252]  __mark_inode_dirty+0x144/0x320
[ 3472.708558]  generic_update_time+0x6c/0xd0
[ 3472.712768]  file_update_time+0x127/0x140
[ 3472.716899]  ? generic_write_checks+0x61/0xc0
[ 3472.721370]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3472.726735]  new_sync_write+0x119/0x1b0
[ 3472.730686]  ? intel_get_event_constraints+0x300/0x390
[ 3472.735942]  vfs_write+0x1de/0x270
[ 3472.739459]  ksys_write+0x5f/0xe0
[ 3472.742887]  do_syscall_64+0x38/0x90
[ 3472.746577]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.751745] RIP: 0033:0x490f5b
[ 3472.754913] RSP: 002b:000000c004072878 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3472.762595] RAX: ffffffffffffffda RBX: 000000c000084800 RCX: 
0000000000490f5b
[ 3472.769843] RDX: 0000000000000035 RSI: 000000c00ffa2000 RDI: 
00000000000001dc
[ 3472.777096] RBP: 000000c0040728c8 R08: 0000000000000035 R09: 
0000000000000004
[ 3472.784346] R10: 00000000000000ac R11: 0000000000000212 R12: 
0000000000000115
[ 3472.791597] R13: 0000000000000030 R14: 000000000000002c R15: 
0000000000000023
[ 3472.798847]  </TASK>
[ 3472.801148] task:containerd      state:D stack:    0 pid:78083 ppid: 
70946 flags:0x00004000
[ 3472.809614] Call Trace:
[ 3472.812172]  <TASK>
[ 3472.814378]  __schedule+0x2eb/0x8d0
[ 3472.817985]  ? __es_remove_extent+0x6d/0x670 [ext4]
[ 3472.823005]  schedule+0x5b/0xd0
[ 3472.826263]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.831434]  ? wait_woken+0x70/0x70
[ 3472.835048]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3472.840313]  start_this_handle+0xfb/0x520 [jbd2]
[ 3472.845049]  ? alloc_page_buffers+0x9a/0x180
[ 3472.849438]  ? __cond_resched+0x16/0x50
[ 3472.853389]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3472.858302]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3472.863583]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3472.868169]  __mark_inode_dirty+0x144/0x320
[ 3472.872469]  generic_write_end+0xa9/0x140
[ 3472.876594]  generic_perform_write+0x104/0x1f0
[ 3472.881153]  ext4_buffered_write_iter+0xa7/0x180 [ext4]
[ 3472.886517]  new_sync_write+0x119/0x1b0
[ 3472.890468]  ? intel_get_event_constraints+0x300/0x390
[ 3472.895725]  vfs_write+0x1de/0x270
[ 3472.899244]  ksys_write+0x5f/0xe0
[ 3472.902673]  do_syscall_64+0x38/0x90
[ 3472.906366]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3472.911534] RIP: 0033:0x490f5b
[ 3472.914700] RSP: 002b:000000c003f7e0f0 EFLAGS: 00000206 ORIG_RAX: 
0000000000000001
[ 3472.922384] RAX: ffffffffffffffda RBX: 000000c000091000 RCX: 
0000000000490f5b
[ 3472.929633] RDX: 0000000000008000 RSI: 000000c040f66000 RDI: 
00000000000001c1
[ 3472.936879] RBP: 000000c003f7e140 R08: 0000000000008000 R09: 
0000000000000004
[ 3472.944127] R10: 0000000000008000 R11: 0000000000000206 R12: 
000000008c4a6711
[ 3472.951375] R13: 000000007d483761 R14: 00000000202377cc R15: 
00000000e5178dff
[ 3472.958619]  </TASK>
[ 3472.960924] task:containerd      state:D stack:    0 pid:78177 ppid: 
70946 flags:0x00004000
[ 3472.969393] Call Trace:
[ 3472.971948]  <TASK>
[ 3472.974152]  __schedule+0x2eb/0x8d0
[ 3472.977750]  ? __es_remove_extent+0x6d/0x670 [ext4]
[ 3472.982773]  schedule+0x5b/0xd0
[ 3472.986041]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3472.991216]  ? wait_woken+0x70/0x70
[ 3472.994821]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.000076]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.004808]  ? alloc_page_buffers+0x9a/0x180
[ 3473.009195]  ? __cond_resched+0x16/0x50
[ 3473.013149]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.018057]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.023332]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3473.027913]  __mark_inode_dirty+0x144/0x320
[ 3473.032215]  generic_write_end+0xa9/0x140
[ 3473.036340]  generic_perform_write+0x104/0x1f0
[ 3473.040901]  ext4_buffered_write_iter+0xa7/0x180 [ext4]
[ 3473.046272]  new_sync_write+0x119/0x1b0
[ 3473.050223]  ? intel_get_event_constraints+0x300/0x390
[ 3473.055479]  vfs_write+0x1de/0x270
[ 3473.058992]  ksys_write+0x5f/0xe0
[ 3473.062423]  do_syscall_64+0x38/0x90
[ 3473.066113]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.071283] RIP: 0033:0x490f5b
[ 3473.074450] RSP: 002b:000000c000fae0f0 EFLAGS: 00000206 ORIG_RAX: 
0000000000000001
[ 3473.082134] RAX: ffffffffffffffda RBX: 000000c0000a7800 RCX: 
0000000000490f5b
[ 3473.089385] RDX: 0000000000004c08 RSI: 000000c03ddda000 RDI: 
00000000000001aa
[ 3473.096633] RBP: 000000c000fae140 R08: 0000000000004c08 R09: 
0000000000000004
[ 3473.103873] R10: 0000000000008000 R11: 0000000000000206 R12: 
0000000000971042
[ 3473.111115] R13: 000000004ef32609 R14: 000000006575a95a R15: 
0000000030137d7a
[ 3473.118358]  </TASK>
[ 3473.120657] task:containerd      state:D stack:    0 pid:78180 ppid: 
70946 flags:0x00000000
[ 3473.129121] Call Trace:
[ 3473.131679]  <TASK>
[ 3473.133884]  __schedule+0x2eb/0x8d0
[ 3473.137486]  schedule+0x5b/0xd0
[ 3473.140751]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3473.145923]  ? wait_woken+0x70/0x70
[ 3473.149537]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.154806]  ? __bpf_trace_tick_stop+0x10/0x10
[ 3473.159361]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.164102]  ? __cond_resched+0x16/0x50
[ 3473.168049]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.172953]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.178220]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3473.182797]  __mark_inode_dirty+0x144/0x320
[ 3473.187109]  ext4_setattr+0x1fb/0x9a0 [ext4]
[ 3473.191524]  notify_change+0x3c1/0x540
[ 3473.195391]  ? chown_common+0x168/0x250
[ 3473.199345]  chown_common+0x168/0x250
[ 3473.203121]  do_fchownat+0x8d/0xf0
[ 3473.206638]  __x64_sys_fchownat+0x21/0x30
[ 3473.210761]  do_syscall_64+0x38/0x90
[ 3473.214458]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.219626] RIP: 0033:0x490fca
[ 3473.222795] RSP: 002b:000000c005010240 EFLAGS: 00000202 ORIG_RAX: 
0000000000000104
[ 3473.230476] RAX: ffffffffffffffda RBX: 000000c0000a0000 RCX: 
0000000000490fca
[ 3473.237730] RDX: 0000000000000000 RSI: 000000c040322540 RDI: 
ffffffffffffff9c
[ 3473.244977] RBP: 000000c0050102b8 R08: 0000000000000100 R09: 
0000000000000000
[ 3473.252234] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[ 3473.259485] R13: 0000000000000001 R14: 0000000000000008 R15: 
ffffffffffffffff
[ 3473.266756]  </TASK>
[ 3473.269056] task:containerd      state:D stack:    0 pid:78360 ppid: 
70946 flags:0x00000000
[ 3473.277518] Call Trace:
[ 3473.280075]  <TASK>
[ 3473.282289]  __schedule+0x2eb/0x8d0
[ 3473.285917]  schedule+0x5b/0xd0
[ 3473.289172]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3473.294344]  ? wait_woken+0x70/0x70
[ 3473.297949]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.303208]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.307941]  ? __cond_resched+0x16/0x50
[ 3473.311891]  ? __cond_resched+0x16/0x50
[ 3473.315844]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.320754]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.326035]  __ext4_new_inode+0x73f/0x1710 [ext4]
[ 3473.330878]  ext4_create+0x115/0x1d0 [ext4]
[ 3473.335204]  path_openat+0xf48/0x1280
[ 3473.338985]  do_filp_open+0xa9/0x150
[ 3473.342674]  ? vfs_statx+0x74/0x130
[ 3473.346289]  ? __check_object_size+0x146/0x160
[ 3473.351284]  do_sys_openat2+0x9b/0x160
[ 3473.355148]  __x64_sys_openat+0x54/0xa0
[ 3473.359101]  do_syscall_64+0x38/0x90
[ 3473.362793]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.367964] RIP: 0033:0x490fca
[ 3473.371152] RSP: 002b:000000c003b2c190 EFLAGS: 00000206 ORIG_RAX: 
0000000000000101
[ 3473.378832] RAX: ffffffffffffffda RBX: 000000c0000a0000 RCX: 
0000000000490fca
[ 3473.386077] RDX: 0000000000080241 RSI: 000000c00ba72c60 RDI: 
ffffffffffffff9c
[ 3473.393325] RBP: 000000c003b2c210 R08: 0000000000000000 R09: 
0000000000000000
[ 3473.400584] R10: 00000000000001a4 R11: 0000000000000206 R12: 
0000000000000000
[ 3473.407834] R13: 0000000000000001 R14: 0000000000000013 R15: 
ffffffffffffffff
[ 3473.415084]  </TASK>
[ 3473.417413] task:containerd      state:D stack:    0 pid:92579 ppid: 
70946 flags:0x00000000
[ 3473.425880] Call Trace:
[ 3473.428438]  <TASK>
[ 3473.430654]  __schedule+0x2eb/0x8d0
[ 3473.434262]  schedule+0x5b/0xd0
[ 3473.437523]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3473.442697]  ? wait_woken+0x70/0x70
[ 3473.446301]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.451558]  ? select_task_rq_fair+0x130/0xf90
[ 3473.456118]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.460853]  ? ttwu_queue_wakelist+0xf2/0x110
[ 3473.465325]  ? __cond_resched+0x16/0x50
[ 3473.469285]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.474199]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.479478]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3473.484061]  __mark_inode_dirty+0x144/0x320
[ 3473.488361]  generic_update_time+0x6c/0xd0
[ 3473.492571]  file_update_time+0x127/0x140
[ 3473.496706]  ? generic_write_checks+0x61/0xc0
[ 3473.501178]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3473.506545]  new_sync_write+0x119/0x1b0
[ 3473.510502]  ? intel_get_event_constraints+0x300/0x390
[ 3473.515757]  vfs_write+0x1de/0x270
[ 3473.519274]  ksys_write+0x5f/0xe0
[ 3473.522704]  do_syscall_64+0x38/0x90
[ 3473.526394]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.531566] RIP: 0033:0x490f5b
[ 3473.534732] RSP: 002b:000000c002785878 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3473.542416] RAX: ffffffffffffffda RBX: 000000c000084800 RCX: 
0000000000490f5b
[ 3473.549663] RDX: 000000000000007f RSI: 000000c000468000 RDI: 
00000000000000bb
[ 3473.556911] RBP: 000000c0027858c8 R08: 000000000000007f R09: 
0000000000000004
[ 3473.564160] R10: 0000000000000370 R11: 0000000000000212 R12: 
0000000000000115
[ 3473.571415] R13: 0000000000000032 R14: 0000000000000000 R15: 
0000000000000023
[ 3473.578664]  </TASK>
[ 3473.580964] task:containerd      state:D stack:    0 pid:92591 ppid: 
70946 flags:0x00004000
[ 3473.589432] Call Trace:
[ 3473.591997]  <TASK>
[ 3473.594209]  ? ext4_mark_iloc_dirty+0x56a/0xaf0 [ext4]
[ 3473.599518]  ? __schedule+0x2eb/0x8d0
[ 3473.603301]  ? _raw_spin_lock_irqsave+0x36/0x50
[ 3473.607947]  ? __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.613393]  ? __wait_on_bit_lock+0x40/0xb0
[ 3473.617689]  ? out_of_line_wait_on_bit_lock+0x92/0xb0
[ 3473.622854]  ? var_wake_function+0x30/0x30
[ 3473.627062]  ? ext4_xattr_block_set+0x865/0xf00 [ext4]
[ 3473.632346]  ? ext4_xattr_set_handle+0x48e/0x630 [ext4]
[ 3473.637718]  ? ext4_initxattrs+0x43/0x60 [ext4]
[ 3473.642389]  ? security_inode_init_security+0xab/0x140
[ 3473.647640]  ? ext4_init_acl+0x170/0x170 [ext4]
[ 3473.652315]  ? __ext4_new_inode+0x11f7/0x1710 [ext4]
[ 3473.657430]  ? ext4_create+0x115/0x1d0 [ext4]
[ 3473.661935]  ? path_openat+0xf48/0x1280
[ 3473.665888]  ? do_filp_open+0xa9/0x150
[ 3473.669751]  ? vfs_statx+0x74/0x130
[ 3473.673359]  ? __check_object_size+0x146/0x160
[ 3473.677917]  ? do_sys_openat2+0x9b/0x160
[ 3473.681953]  ? __x64_sys_openat+0x54/0xa0
[ 3473.686076]  ? do_syscall_64+0x38/0x90
[ 3473.689942]  ? entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.695281]  </TASK>
[ 3473.697584] task:containerd      state:D stack:    0 pid:92602 ppid: 
70946 flags:0x00000000
[ 3473.706053] Call Trace:
[ 3473.708612]  <TASK>
[ 3473.710819]  __schedule+0x2eb/0x8d0
[ 3473.714424]  schedule+0x5b/0xd0
[ 3473.717684]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3473.722857]  ? wait_woken+0x70/0x70
[ 3473.726461]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.731716]  ? finish_task_switch.isra.0+0x87/0x290
[ 3473.736714]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.741451]  ? __cond_resched+0x16/0x50
[ 3473.745400]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.750309]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.755589]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3473.760169]  __mark_inode_dirty+0x144/0x320
[ 3473.764470]  generic_write_end+0xa9/0x140
[ 3473.768595]  generic_perform_write+0x104/0x1f0
[ 3473.773153]  ext4_buffered_write_iter+0xa7/0x180 [ext4]
[ 3473.778519]  new_sync_write+0x119/0x1b0
[ 3473.782469]  ? intel_get_event_constraints+0x300/0x390
[ 3473.787725]  vfs_write+0x1de/0x270
[ 3473.791244]  ksys_write+0x5f/0xe0
[ 3473.794675]  do_syscall_64+0x38/0x90
[ 3473.798364]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.803533] RIP: 0033:0x490f5b
[ 3473.806701] RSP: 002b:000000c002c160f0 EFLAGS: 00000206 ORIG_RAX: 
0000000000000001
[ 3473.814385] RAX: ffffffffffffffda RBX: 000000c000087000 RCX: 
0000000000490f5b
[ 3473.821632] RDX: 0000000000008000 RSI: 000000c04298a000 RDI: 
00000000000000a7
[ 3473.828881] RBP: 000000c002c16140 R08: 0000000000008000 R09: 
0000000000000004
[ 3473.836128] R10: 0000000000008000 R11: 0000000000000206 R12: 
0000000011414000
[ 3473.843374] R13: 000000006574befc R14: 00000000a9cc4cd5 R15: 
0000000028a3f1f3
[ 3473.850622]  </TASK>
[ 3473.852927] task:containerd      state:D stack:    0 pid:92618 ppid: 
70946 flags:0x00000000
[ 3473.861404] Call Trace:
[ 3473.863967]  <TASK>
[ 3473.866183]  __schedule+0x2eb/0x8d0
[ 3473.869792]  ? newidle_balance+0x12a/0x400
[ 3473.874005]  schedule+0x5b/0xd0
[ 3473.877262]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3473.882436]  ? wait_woken+0x70/0x70
[ 3473.886040]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3473.891300]  ? cpumask_next+0x1e/0x30
[ 3473.895079]  ? select_task_rq_fair+0x130/0xf90
[ 3473.899645]  start_this_handle+0xfb/0x520 [jbd2]
[ 3473.904394]  ? ttwu_queue_wakelist+0xf2/0x110
[ 3473.908870]  ? __cond_resched+0x16/0x50
[ 3473.912826]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3473.917739]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3473.923022]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3473.927606]  __mark_inode_dirty+0x144/0x320
[ 3473.931911]  generic_update_time+0x6c/0xd0
[ 3473.936127]  file_update_time+0x127/0x140
[ 3473.940252]  ? generic_write_checks+0x61/0xc0
[ 3473.944724]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3473.950088]  new_sync_write+0x119/0x1b0
[ 3473.954039]  ? intel_get_event_constraints+0x300/0x390
[ 3473.959296]  vfs_write+0x1de/0x270
[ 3473.962814]  ksys_write+0x5f/0xe0
[ 3473.966242]  do_syscall_64+0x38/0x90
[ 3473.969935]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3473.975105] RIP: 0033:0x490f5b
[ 3473.978272] RSP: 002b:000000c005302878 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3473.985963] RAX: ffffffffffffffda RBX: 000000c000093800 RCX: 
0000000000490f5b
[ 3473.993212] RDX: 0000000000000098 RSI: 000000c00421a500 RDI: 
00000000000001b0
[ 3474.000461] RBP: 000000c0053028c8 R08: 0000000000000098 R09: 
0000000000000004
[ 3474.007713] R10: 0000000000000259 R11: 0000000000000212 R12: 
0000000000000115
[ 3474.014962] R13: 0000000000000030 R14: 0000000000000029 R15: 
0000000000000023
[ 3474.022212]  </TASK>
[ 3474.024517] task:containerd      state:D stack:    0 pid:93290 ppid: 
70946 flags:0x00000000
[ 3474.032981] Call Trace:
[ 3474.035540]  <TASK>
[ 3474.037753]  __schedule+0x2eb/0x8d0
[ 3474.041358]  schedule+0x5b/0xd0
[ 3474.044615]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3474.049787]  ? wait_woken+0x70/0x70
[ 3474.053401]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3474.058659]  ? select_task_rq_fair+0x130/0xf90
[ 3474.063224]  start_this_handle+0xfb/0x520 [jbd2]
[ 3474.067959]  ? ttwu_queue_wakelist+0xf2/0x110
[ 3474.072434]  ? __cond_resched+0x16/0x50
[ 3474.076388]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3474.081298]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3474.086582]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3474.091165]  __mark_inode_dirty+0x144/0x320
[ 3474.095466]  generic_update_time+0x6c/0xd0
[ 3474.099679]  file_update_time+0x127/0x140
[ 3474.103804]  ? generic_write_checks+0x61/0xc0
[ 3474.108274]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3474.113644]  new_sync_write+0x119/0x1b0
[ 3474.117594]  ? intel_get_event_constraints+0x300/0x390
[ 3474.122849]  vfs_write+0x1de/0x270
[ 3474.126366]  ksys_write+0x5f/0xe0
[ 3474.129792]  do_syscall_64+0x38/0x90
[ 3474.133483]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3474.138652] RIP: 0033:0x490f5b
[ 3474.141828] RSP: 002b:000000c002d3b878 EFLAGS: 00000212 ORIG_RAX: 
0000000000000001
[ 3474.149512] RAX: ffffffffffffffda RBX: 000000c000087000 RCX: 
0000000000490f5b
[ 3474.156757] RDX: 0000000000000034 RSI: 000000c037af9840 RDI: 
00000000000001a6
[ 3474.164005] RBP: 000000c002d3b8c8 R08: 0000000000000034 R09: 
0000000000000004
[ 3474.171252] R10: 0000000000000040 R11: 0000000000000212 R12: 
0000000000000115
[ 3474.178498] R13: 0000000000000030 R14: 0000000000000031 R15: 
0000000000000023
[ 3474.185764]  </TASK>
[ 3474.188172] task:kworker/u32:5   state:D stack:    0 pid:85579 ppid: 
    2 flags:0x00004000
[ 3474.196641] Workqueue: writeback wb_workfn (flush-8:0)
[ 3474.201913] Call Trace:
[ 3474.204475]  <TASK>
[ 3474.206690]  __schedule+0x2eb/0x8d0
[ 3474.210296]  ? finish_task_switch.isra.0+0x87/0x290
[ 3474.215290]  schedule+0x5b/0xd0
[ 3474.218546]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3474.223719]  ? wait_woken+0x70/0x70
[ 3474.227327]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3474.232581]  ? wait_woken+0x70/0x70
[ 3474.236186]  start_this_handle+0xfb/0x520 [jbd2]
[ 3474.240919]  ? mpage_release_unused_pages+0x1c7/0x1e0 [ext4]
[ 3474.246722]  ? __cond_resched+0x16/0x50
[ 3474.250678]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3474.255593]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3474.260864]  ext4_writepages+0x302/0xfd0 [ext4]
[ 3474.265531]  ? mod_delayed_work_on+0x57/0xa0
[ 3474.269916]  ? sysvec_apic_timer_interrupt+0x8/0x90
[ 3474.274912]  do_writepages+0xce/0x200
[ 3474.278694]  ? sysvec_apic_timer_interrupt+0xb/0x90
[ 3474.283685]  ? asm_sysvec_apic_timer_interrupt+0x15/0x20
[ 3474.289112]  __writeback_single_inode+0x39/0x290
[ 3474.293843]  writeback_sb_inodes+0x20d/0x490
[ 3474.298226]  wb_writeback+0xae/0x280
[ 3474.301917]  wb_workfn+0xc2/0x4d0
[ 3474.305345]  ? psi_task_switch+0x1e0/0x200
[ 3474.309558]  process_one_work+0x223/0x3c0
[ 3474.313683]  worker_thread+0x50/0x410
[ 3474.317460]  ? process_one_work+0x3c0/0x3c0
[ 3474.321756]  kthread+0x124/0x150
[ 3474.325098]  ? set_kthread_struct+0x50/0x50
[ 3474.329395]  ret_from_fork+0x1f/0x30
[ 3474.333090]  </TASK>
[ 3474.335403] task:kworker/11:8    state:D stack:    0 pid:87476 ppid: 
    2 flags:0x00004000
[ 3474.343867] Workqueue: events nf_tables_trans_destroy_work [nf_tables]
[ 3474.350535] Call Trace:
[ 3474.353094]  <TASK>
[ 3474.355305]  ? usleep_range_state+0x90/0x90
[ 3474.359608]  __schedule+0x2eb/0x8d0
[ 3474.363210]  ? raw_spin_rq_unlock+0xa/0x20
[ 3474.367423]  ? usleep_range_state+0x90/0x90
[ 3474.371719]  schedule+0x5b/0xd0
[ 3474.374971]  schedule_timeout+0x104/0x140
[ 3474.379099]  __wait_for_common+0xac/0x160
[ 3474.383223]  __wait_rcu_gp+0x116/0x120
[ 3474.387088]  synchronize_rcu+0x67/0x90
[ 3474.390950]  ? invoke_rcu_core+0xa0/0xa0
[ 3474.394985]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[ 3474.400236]  nf_tables_trans_destroy_work+0xa7/0x2f0 [nf_tables]
[ 3474.406380]  process_one_work+0x223/0x3c0
[ 3474.410511]  worker_thread+0x50/0x410
[ 3474.414287]  ? process_one_work+0x3c0/0x3c0
[ 3474.418586]  kthread+0x124/0x150
[ 3474.421929]  ? set_kthread_struct+0x50/0x50
[ 3474.426227]  ret_from_fork+0x1f/0x30
[ 3474.429920]  </TASK>
[ 3474.432456] task:containerd-shim state:D stack:    0 pid:90568 ppid: 
    1 flags:0x00004000
[ 3474.440923] Call Trace:
[ 3474.443482]  <TASK>
[ 3474.445695]  __schedule+0x2eb/0x8d0
[ 3474.449298]  schedule+0x5b/0xd0
[ 3474.452560]  rwsem_down_write_slowpath+0x220/0x4f0
[ 3474.457466]  sync_inodes_sb+0xba/0x2a0
[ 3474.461332]  sync_filesystem.part.0+0x4c/0x80
[ 3474.465814]  ovl_sync_fs+0x59/0x90 [overlay]
[ 3474.470211]  sync_filesystem.part.0+0x63/0x80
[ 3474.474680]  generic_shutdown_super+0x22/0x110
[ 3474.479237]  kill_anon_super+0x14/0x30
[ 3474.483099]  deactivate_locked_super+0x33/0xa0
[ 3474.487655]  cleanup_mnt+0x131/0x190
[ 3474.491343]  task_work_run+0x62/0xa0
[ 3474.495033]  exit_to_user_mode_prepare+0x15d/0x160
[ 3474.499938]  syscall_exit_to_user_mode+0x23/0x50
[ 3474.504669]  do_syscall_64+0x48/0x90
[ 3474.508358]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3474.513528] RIP: 0033:0x48451b
[ 3474.516696] RSP: 002b:000000c00028f7e8 EFLAGS: 00000212 ORIG_RAX: 
00000000000000a6
[ 3474.524378] RAX: 0000000000000000 RBX: 000000c000032000 RCX: 
000000000048451b
[ 3474.531625] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000c0002e21b0
[ 3474.538873] RBP: 000000c00028f840 R08: 0000000000000000 R09: 
0000000000000000
[ 3474.546122] R10: 0000000000000000 R11: 0000000000000212 R12: 
0000000000000000
[ 3474.553368] R13: 0000000000000001 R14: 0000000000000004 R15: 
ffffffffffffffff
[ 3474.560615]  </TASK>
[ 3474.563018] task:containerd-shim state:D stack:    0 pid:90854 ppid: 
    1 flags:0x00004000
[ 3474.571486] Call Trace:
[ 3474.574043]  <TASK>
[ 3474.576256]  __schedule+0x2eb/0x8d0
[ 3474.579858]  schedule+0x5b/0xd0
[ 3474.583109]  wb_wait_for_completion+0x56/0x80
[ 3474.587582]  ? wait_woken+0x70/0x70
[ 3474.591185]  sync_inodes_sb+0xd3/0x2a0
[ 3474.595051]  sync_filesystem.part.0+0x4c/0x80
[ 3474.599523]  ovl_sync_fs+0x59/0x90 [overlay]
[ 3474.603914]  sync_filesystem.part.0+0x63/0x80
[ 3474.608383]  generic_shutdown_super+0x22/0x110
[ 3474.612940]  kill_anon_super+0x14/0x30
[ 3474.616801]  deactivate_locked_super+0x33/0xa0
[ 3474.621361]  cleanup_mnt+0x131/0x190
[ 3474.625052]  task_work_run+0x62/0xa0
[ 3474.628740]  exit_to_user_mode_prepare+0x15d/0x160
[ 3474.633647]  syscall_exit_to_user_mode+0x23/0x50
[ 3474.638382]  do_syscall_64+0x48/0x90
[ 3474.642075]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3474.647245] RIP: 0033:0x48451b
[ 3474.650413] RSP: 002b:000000c0000f17e8 EFLAGS: 00000212 ORIG_RAX: 
00000000000000a6
[ 3474.658101] RAX: 0000000000000000 RBX: 000000c000039800 RCX: 
000000000048451b
[ 3474.665349] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
000000c0000f8120
[ 3474.672596] RBP: 000000c0000f1840 R08: 0000000000000000 R09: 
0000000000000000
[ 3474.679841] R10: 0000000000000000 R11: 0000000000000212 R12: 
0000000000000000
[ 3474.687089] R13: 0000000000000001 R14: 0000000000000003 R15: 
ffffffffffffffff
[ 3474.694340]  </TASK>
[ 3474.696722] task:MVStore backgro state:D stack:    0 pid:93585 ppid: 
90297 flags:0x00000000
[ 3474.705188] Call Trace:
[ 3474.707749]  <TASK>
[ 3474.709959]  __schedule+0x2eb/0x8d0
[ 3474.713565]  schedule+0x5b/0xd0
[ 3474.716822]  wait_transaction_locked+0x8a/0xd0 [jbd2]
[ 3474.721995]  ? wait_woken+0x70/0x70
[ 3474.725599]  add_transaction_credits+0xd9/0x2b0 [jbd2]
[ 3474.730863]  start_this_handle+0xfb/0x520 [jbd2]
[ 3474.735600]  ? __cond_resched+0x16/0x50
[ 3474.739551]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
[ 3474.744460]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
[ 3474.749738]  ext4_dirty_inode+0x35/0x80 [ext4]
[ 3474.754318]  __mark_inode_dirty+0x144/0x320
[ 3474.758626]  generic_update_time+0x6c/0xd0
[ 3474.762838]  file_update_time+0x127/0x140
[ 3474.766960]  ? generic_write_checks+0x61/0xc0
[ 3474.771429]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
[ 3474.776799]  do_iter_readv_writev+0x14f/0x1b0
[ 3474.781271]  do_iter_write+0x80/0x1c0
[ 3474.785048]  ovl_write_iter+0x2d3/0x450 [overlay]
[ 3474.789871]  new_sync_write+0x119/0x1b0
[ 3474.793819]  ? intel_get_event_constraints+0x300/0x390
[ 3474.799077]  vfs_write+0x1de/0x270
[ 3474.802593]  __x64_sys_pwrite64+0x91/0xc0
[ 3474.806721]  do_syscall_64+0x38/0x90
[ 3474.810410]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3474.815583] RIP: 0033:0x7fc27926a4a3
[ 3474.819278] RSP: 002b:00007fc2531aaa78 EFLAGS: 00000246 ORIG_RAX: 
0000000000000012
[ 3474.826971] RAX: ffffffffffffffda RBX: 00007fc2531abb38 RCX: 
00007fc27926a4a3
[ 3474.834220] RDX: 0000000000001000 RSI: 00007fc252ab25f0 RDI: 
0000000000000014
[ 3474.841465] RBP: 00007fc2531aaaf0 R08: 0000000000000000 R09: 
0000000000000000
[ 3474.848713] R10: 0000000000003000 R11: 0000000000000246 R12: 
0000000000000012
[ 3474.855983] R13: 00007fc252ab25f0 R14: 0000000000003000 R15: 
00007fc25589d800
[ 3474.863250]  </TASK>
