Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9A5FE908
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Oct 2022 08:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJNGnG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Oct 2022 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJNGnE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Oct 2022 02:43:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD001B2BAE
        for <linux-ext4@vger.kernel.org>; Thu, 13 Oct 2022 23:43:01 -0700 (PDT)
Received: from [10.254.254.111] (ip5b408877.dynamic.kabel-deutschland.de [91.64.136.119])
        by linux.microsoft.com (Postfix) with ESMTPSA id E761C20FB18E;
        Thu, 13 Oct 2022 23:42:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E761C20FB18E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665729781;
        bh=WHiFSdzXyBHbElO4L7fP/xZtQx63dmlgppe6tKbEBig=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Z962JaOGZ2XNB/oTTnFw4oQiGByiqY7dqwVAlvPJl1BX+xe66D8Gr/lfvL2MbipcK
         QzQEOLoqW0ISbOvbU5nPSEujMhK1WYTY3WMUOAW0fVkbaadnOhYLhgCuoGeyCayMeJ
         CquY4meiLmET0E9Fgc+OfkQcU1btBDmtmyCUTNP0=
Message-ID: <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
Date:   Fri, 14 Oct 2022 08:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Thilo Fromm <t-lo@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
In-Reply-To: <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Honza, hello Ye,

Just want to make sure this does not get lost - as mentioned earlier, 
reverting 51ae846cff5 leads to a kernel build that does not have this issue.

>>>>>>>>> So this seems like a real issue. Essentially, the problem is that
>>>>>>>>> ext4_bmap() acquires inode->i_rwsem while its caller
>>>>>>>>> jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
>>>>>>>>> looks like a real deadlock possibility.
>>>>>>>>
>>> [...]
>>>>>>>> The issue can be triggered on Flatcar release 3227.2.2 / kernel version
>>>>>>>> 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
>>>>>>>> 51ae846cff5 was introduced to 5.15 in 5.15.61.
>>>>>>>
>>>>>>> Well, so far your stacktraces do not really show anything pointing to that
>>>>>>> particular commit. So we need to understand that hang some more.
>>>>>>
>>> [...]
>>>>> So our stacktraces were mangled because historically our kernel build used
>>>>> INSTALL_MOD_STRIP=--strip-unneeded, we've now switched it back to --strip-debug
>>>>> which is the default. We're still using CONFIG_UNWINDER_ORC=y.
>>>>>
>>>>> Here's the hung task output after the change to stripping:
>>>>
>>>> Yeah, the stacktraces now look as what I'd expect. Thanks for fixing that!
>>>> Sadly they don't point to the culprit of the problem. They show jbd2/sda9-8
>>>> is waiting for someone to drop its transaction handle. Other processes are
>>>> waiting for jbd2/sda9-8 to commit a transaction. And then a few processes
>>>> are waiting for locks held by these waiting processes. But I don't see
>>>> anywhere the process holding the transaction handle. Can you please
>>>> reproduce the problem once more and when the system hangs run:
>>>>
>>>> echo w >/proc/sysrq-trigger
>>>>
>>>> Unlike softlockup detector, this will dump all blocked task so hopefully
>>>> we'll see the offending task there. Thanks!
>>
>>> [ 3451.530765] sysrq: Show Blocked State
>>> [ 3451.534632] task:jbd2/sda9-8     state:D stack:    0 pid:  704 ppid:    2
>>> flags:0x00004000
>>> [ 3451.543107] Call Trace:
>>> [ 3451.545671]  <TASK>
>>> [ 3451.547888]  __schedule+0x2eb/0x8d0
>>> [ 3451.551491]  schedule+0x5b/0xd0
>>> [ 3451.554749]  jbd2_journal_commit_transaction+0x301/0x18e0 [jbd2]
>>> [ 3451.560881]  ? wait_woken+0x70/0x70
>>> [ 3451.564485]  ? lock_timer_base+0x61/0x80
>>> [ 3451.568524]  kjournald2+0xab/0x270 [jbd2]
>>> [ 3451.572657]  ? wait_woken+0x70/0x70
>>> [ 3451.576258]  ? load_superblock.part.0+0xb0/0xb0 [jbd2]
>>> [ 3451.581526]  kthread+0x124/0x150
>>> [ 3451.584874]  ? set_kthread_struct+0x50/0x50
>>> [ 3451.589177]  ret_from_fork+0x1f/0x30
>>> [ 3451.592887]  </TASK>
>>
>> So again jdb2 waiting for the transaction handle to be dropped. The task
>> having the handle open is:
>>
>>> [ 3473.580964] task:containerd      state:D stack:    0 pid:92591 ppid:
>>> 70946 flags:0x00004000
>>> [ 3473.589432] Call Trace:
>>> [ 3473.591997]  <TASK>
>>> [ 3473.594209]  ? ext4_mark_iloc_dirty+0x56a/0xaf0 [ext4]
>>> [ 3473.599518]  ? __schedule+0x2eb/0x8d0
>>> [ 3473.603301]  ? _raw_spin_lock_irqsave+0x36/0x50
>>> [ 3473.607947]  ? __ext4_journal_start_sb+0xf8/0x110 [ext4]
>>> [ 3473.613393]  ? __wait_on_bit_lock+0x40/0xb0
>>> [ 3473.617689]  ? out_of_line_wait_on_bit_lock+0x92/0xb0
>>> [ 3473.622854]  ? var_wake_function+0x30/0x30
>>> [ 3473.627062]  ? ext4_xattr_block_set+0x865/0xf00 [ext4]
>>> [ 3473.632346]  ? ext4_xattr_set_handle+0x48e/0x630 [ext4]
>>> [ 3473.637718]  ? ext4_initxattrs+0x43/0x60 [ext4]
>>> [ 3473.642389]  ? security_inode_init_security+0xab/0x140
>>> [ 3473.647640]  ? ext4_init_acl+0x170/0x170 [ext4]
>>> [ 3473.652315]  ? __ext4_new_inode+0x11f7/0x1710 [ext4]
>>> [ 3473.657430]  ? ext4_create+0x115/0x1d0 [ext4]
>>> [ 3473.661935]  ? path_openat+0xf48/0x1280
>>> [ 3473.665888]  ? do_filp_open+0xa9/0x150
>>> [ 3473.669751]  ? vfs_statx+0x74/0x130
>>> [ 3473.673359]  ? __check_object_size+0x146/0x160
>>> [ 3473.677917]  ? do_sys_openat2+0x9b/0x160
>>> [ 3473.681953]  ? __x64_sys_openat+0x54/0xa0
>>> [ 3473.686076]  ? do_syscall_64+0x38/0x90
>>> [ 3473.689942]  ? entry_SYSCALL_64_after_hwframe+0x61/0xcb
>>> [ 3473.695281]  </TASK>
>>
>> Which seems to be waiting on something in ext4_xattr_block_set(). This
>> "something" is not quite clear because the stacktrace looks a bit
>> unreliable at the top - either it is a buffer lock or we are waiting for
>> xattr block reference usecount to decrease (which would kind of make sense
>> because there were changes to ext4 xattr block handling in the time window
>> where the lockup started happening).
>>
>> Can you try to feed the stacktrace through addr2line utility (it will need
>> objects & debug symbols for the kernel)? Maybe it will show something
>> useful...
> 
> Sure, I think this worked fine. It's the buffer lock but right before it we're
> opening a journal transaction. Symbolized it looks like this:
> 
>    ext4_mark_iloc_dirty (include/linux/buffer_head.h:308 fs/ext4/inode.c:5712) ext4
>    __schedule (kernel/sched/core.c:4994 kernel/sched/core.c:6341)
>    _raw_spin_lock_irqsave (arch/x86/include/asm/paravirt.h:585 arch/x86/include/asm/qspinlock.h:51 include/asm-generic/qspinlock.h:85 include/linux/spinlock.h:199 include/linux/spinlock_api_smp.h:119 kernel/locking/spinlock.c:162)
>    __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:105) ext4
>    __wait_on_bit_lock (arch/x86/include/asm/bitops.h:214 include/asm-generic/bitops/instrumented-non-atomic.h:135 kernel/sched/wait_bit.c:89)
>    out_of_line_wait_on_bit_lock (kernel/sched/wait_bit.c:118)
>    var_wake_function (kernel/sched/wait_bit.c:22)
>    ext4_xattr_block_set (include/linux/buffer_head.h:391 fs/ext4/xattr.c:2019) ext4
>    ext4_xattr_set_handle (fs/ext4/xattr.c:2395) ext4
>    ext4_initxattrs (fs/ext4/xattr_security.c:48) ext4
>    security_inode_init_security (security/security.c:1114)
>    ext4_init_acl (fs/ext4/xattr_security.c:38) ext4
>    __ext4_new_inode (fs/ext4/ialloc.c:1325) ext4
>    ext4_create (fs/ext4/namei.c:2796) ext4
>    path_openat (fs/namei.c:3334 fs/namei.c:3404 fs/namei.c:3612)
>    do_filp_open (fs/namei.c:3642)
>    vfs_statx (include/linux/namei.h:57 fs/stat.c:221)
>    __check_object_size (mm/usercopy.c:240 mm/usercopy.c:286 mm/usercopy.c:256)
>    do_sys_openat2 (fs/open.c:1214)
>    __x64_sys_openat (fs/open.c:1241)
>    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)

Is the symbolised stack trace Jeremi sent helpful to get to the bottom 
of this issue? Can we do anything else to help?

Best regards,
Thilo
