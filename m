Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB177ED70
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbjHPWxh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347040AbjHPWxO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 18:53:14 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F8E5F;
        Wed, 16 Aug 2023 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692226392; x=1723762392;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=oM7PbGseE9W1qmqEpY5fs4eY5EoU5z9dGP0AeqfSDwE=;
  b=X6hC4Ft8xYJrjvhDFnQMFj7u6DTh0qUnqr9F/Qtg1gv6zUSVpijYQclJ
   kbu1SKshMp5Paj8krajt3oBKVSYlXcVTzbDN0q0Ll2AYU4kgUjt0AWY35
   1whh7kdyjGWBVmuxHkRuV9xsozWE96rDkUYNsda2vpL+De/yvuOBGR0pu
   w=;
X-IronPort-AV: E=Sophos;i="6.01,178,1684800000"; 
   d="scan'208";a="1148912148"
Subject: Re: Tasks stuck jbd2 for a long time
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 22:53:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 0445F80437;
        Wed, 16 Aug 2023 22:53:07 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 22:53:07 +0000
Received: from [10.94.35.220] (10.94.35.220) by EX19D002UWC004.ant.amazon.com
 (10.13.138.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 22:53:06 +0000
Message-ID: <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
Date:   Wed, 16 Aug 2023 15:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20230816215227.jlvmqasfbc73asi4@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.94.35.220]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/16/23 2:52 PM, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed 16-08-23 11:32:47, Bhatnagar, Rishabh wrote:
>> On 8/16/23 7:53 AM, Jan Kara wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>> On Tue 15-08-23 20:57:14, Bhatnagar, Rishabh wrote:
>>>> On 8/15/23 7:28 PM, Theodore Ts'o wrote:
>>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>>>
>>>>>
>>>>>
>>>>> It would be helpful if you can translate address in the stack trace to
>>>>> line numbers.  See [1] and the script in
>>>>> ./scripts/decode_stacktrace.sh in the kernel sources.  (It is
>>>>> referenced in the web page at [1].)
>>>>>
>>>>> [1] https://docs.kernel.org/admin-guide/bug-hunting.html
>>>>>
>>>>> Of course, in order to interpret the line numbers, we'll need a
>>>>> pointer to the git repo of your kernel sources and the git commit ID
>>>>> you were using that presumably corresponds to 5.10.184-175.731.amzn2.x86_64.
>>>>>
>>>>> The stack trace for which I am particularly interested is the one for
>>>>> the jbd2/md0-8 task, e.g.:
>>>> Thanks for checking Ted.
>>>>
>>>> We don't have fast_commit feature enabled. So it should correspond to this
>>>> line:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/jbd2/commit.c?h=linux-5.10.y#n496
>>>>
>>>>>>          Not tainted 5.10.184-175.731.amzn2.x86_64 #1
>>>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2
>>>>>> flags:0x00004080
>>>>>> Call Trace:
>>>>>> __schedule+0x1f9/0x660
>>>>>>     schedule+0x46/0xb0
>>>>>>     jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]  <--------- line #?
>>>>>>     ? update_load_avg+0x7a/0x5d0
>>>>>>     ? add_wait_queue_exclusive+0x70/0x70
>>>>>>     ? lock_timer_base+0x61/0x80
>>>>>>     ? kjournald2+0xcf/0x360 [jbd2]
>>>>>>     kjournald2+0xcf/0x360 [jbd2]
>>>>> Most of the other stack traces you refenced are tasks that are waiting
>>>>> for the transaction commit to complete so they can proceed with some
>>>>> file system operation.  The stack traces which have
>>>>> start_this_handle() in them are examples of this going on.  Stack
>>>>> traces of tasks that do *not* have start_this_handle() would be
>>>>> specially interesting.
>>>> I see all other stacks apart from kjournald have "start_this_handle".
>>> That would be strange. Can you post full output of "echo w
>>>> /proc/sysrq-trigger" to dmesg, ideally passed through scripts/faddr2line as
>>> Ted suggests. Thanks!
>> Sure i'll try to collect that. The system freezes when such a situation
>> happens and i'm not able
>> to collect much information. I'll try to crash the kernel and collect kdump
>> and see if i can get that info.
> Thanks!

I collected dump and looked at some processes that were stuck in 
uninterruptible sleep.These are from upstream stable tree:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/?h=linux-5.10.y 
(5.10.191)

One of them is the journal thread that is waiting for some other thread 
to close transaction handle.

PID: 10642  TASK: ffff9768823f4000  CPU: 37  COMMAND: "jbd2/md0-8"
  #0 [ffffbd6c40c17c60] __schedule+617 at ffffffffbb912df9
  #1 [ffffbd6c40c17cf8] schedule+60 at ffffffffbb91330c
  #2 [ffffbd6c40c17d08] jbd2_journal_commit_transaction+877 at 
ffffffffc016b90d [jbd2] (/home/ec2-user/linux/fs/jbd2/commit.c:497)
  #3 [ffffbd6c40c17ea0] kjournald2+282 at ffffffffc01723ba [jbd2] 
(/home/ec2-user/linux/fs/jbd2/journal.c:214)
  #4 [ffffbd6c40c17f10] kthread+279 at ffffffffbb0b9167
  #5 [ffffbd6c40c17f50] ret_from_fork+34 at ffffffffbb003802

One of threads that have started the handle and waiting for journal to 
commit and unlock the current transaction. This stack only shows 
ext4lazyinit but with lazyinit disabled we have seen other threads stuck 
in same place.

PID: 10644  TASK: ffff976901010000  CPU: 37  COMMAND: "ext4lazyinit"
  #0 [ffffbd6c40c1fbe0] __schedule+617 at ffffffffbb912df9
  #1 [ffffbd6c40c1fc78] schedule+60 at ffffffffbb91330c
  #2 [ffffbd6c40c1fc88] wait_transaction_locked+137 at ffffffffc0168089 
[jbd2] (/home/ec2-user/linux/fs/jbd2/transaction.c:184)
  #3 [ffffbd6c40c1fcd8] add_transaction_credits+62 at ffffffffc016813e 
[jbd2] (/home/ec2-user/linux/fs/jbd2/transaction.c:241)
  #4 [ffffbd6c40c1fd30] start_this_handle+533 at ffffffffc0168615 [jbd2] 
(/home/ec2-user/linux/fs/jbd2/transaction.c:416)
  #5 [ffffbd6c40c1fdc0] jbd2__journal_start+244 at ffffffffc0168dc4 [jbd2]
  #6 [ffffbd6c40c1fe00] __ext4_journal_start_sb+250 at ffffffffc02ef65a 
[ext4]
  #7 [ffffbd6c40c1fe40] ext4_init_inode_table+190 at ffffffffc0302ace [ext4]
  #8 [ffffbd6c40c1feb0] ext4_lazyinit_thread+906 at ffffffffc033ec9a [ext4]
  #9 [ffffbd6c40c1ff10] kthread+279 at ffffffffbb0b9167
#10 [ffffbd6c40c1ff50] ret_from_fork+34 at ffffffffbb003802

To replicate the download scenario i'm just using dd to copy random data 
to disk. I launch a bunch of threads and try to stress the system. Many 
of those threads seem to be stuck in balance_dirty_pages_ratelimited as 
can be seen below.

PID: 10709  TASK: ffff9769016f8000  CPU: 25  COMMAND: "dd"
  #0 [ffffbd6c40dafa48] __schedule+617 at ffffffffbb912df9
  #1 [ffffbd6c40dafae0] schedule+60 at ffffffffbb91330c
  #2 [ffffbd6c40dafaf0] schedule_timeout+570 at ffffffffbb916a7a
  #3 [ffffbd6c40dafb68] io_schedule_timeout+25 at ffffffffbb913619 
((inlined by) io_schedule_finish at 
/home/ec2-user/linux/kernel/sched/core.c:6274)
  #4 [ffffbd6c40dafb80] balance_dirty_pages+654 at ffffffffbb2367ce  
(/home/ec2-user/linux/mm/page-writeback.c:1799)
  #5 [ffffbd6c40dafcf0] balance_dirty_pages_ratelimited+763 at 
ffffffffbb23752b  (/home/ec2-user/linux/mm/page-writeback.c:1926)
  #6 [ffffbd6c40dafd18] generic_perform_write+308 at ffffffffbb22af44 
(/home/ec2-user/linux/mm/filemap.c:3370)
  #7 [ffffbd6c40dafd88] ext4_buffered_write_iter+161 at ffffffffc02fcba1 
[ext4] (/home/ec2-user/linux/fs/ext4/file.c:273)
  #8 [ffffbd6c40dafdb8] ext4_file_write_iter+96 at ffffffffc02fccf0 [ext4]
  #9 [ffffbd6c40dafe40] new_sync_write+287 at ffffffffbb2e0c0f
#10 [ffffbd6c40dafec8] vfs_write+481 at ffffffffbb2e3161
#11 [ffffbd6c40daff00] ksys_write+165 at ffffffffbb2e3385
#12 [ffffbd6c40daff40] do_syscall_64+51 at ffffffffbb906213
#13 [ffffbd6c40daff50] entry_SYSCALL_64_after_hwframe+103 at 
ffffffffbba000df

There are other dd threads that are trying to read and are handling page 
fault. These are in runnable state and not uninterruptible sleep.

PID: 14581  TASK: ffff97c3cfdbc000  CPU: 29  COMMAND: "dd"
  #0 [ffffbd6c4a1d3598] __schedule+617 at ffffffffbb912df9
  #1 [ffffbd6c4a1d3630] _cond_resched+38 at ffffffffbb9133e6
  #2 [ffffbd6c4a1d3638] shrink_page_list+126 at ffffffffbb2412fe
  #3 [ffffbd6c4a1d36c8] shrink_inactive_list+478 at ffffffffbb24441e
  #4 [ffffbd6c4a1d3768] shrink_lruvec+957 at ffffffffbb244e3d
  #5 [ffffbd6c4a1d3870] shrink_node+552 at ffffffffbb2452a8
  #6 [ffffbd6c4a1d38f0] do_try_to_free_pages+201 at ffffffffbb245829
  #7 [ffffbd6c4a1d3940] try_to_free_pages+239 at ffffffffbb246c0f
  #8 [ffffbd6c4a1d39d8] __alloc_pages_slowpath.constprop.114+913 at 
ffffffffbb28d741
  #9 [ffffbd6c4a1d3ab8] __alloc_pages_nodemask+679 at ffffffffbb28e2e7
#10 [ffffbd6c4a1d3b28] alloc_pages_vma+124 at ffffffffbb2a734c
#11 [ffffbd6c4a1d3b68] handle_mm_fault+3999 at ffffffffbb26de2f
#12 [ffffbd6c4a1d3c28] exc_page_fault+708 at ffffffffbb909c84
#13 [ffffbd6c4a1d3c80] asm_exc_page_fault+30 at ffffffffbba00b4e
  #14 [ffffbd6c4a1d3d30] copyout+28 at ffffffffbb5160bc
#15 [ffffbd6c4a1d3d38] _copy_to_iter+158 at ffffffffbb5188de
#16 [ffffbd6c4a1d3d98] get_random_bytes_user+136 at ffffffffbb644608
#17 [ffffbd6c4a1d3e48] new_sync_read+284 at ffffffffbb2e0a5c
#18 [ffffbd6c4a1d3ed0] vfs_read+353 at ffffffffbb2e2f51
#19 [ffffbd6c4a1d3f00] ksys_read+165 at ffffffffbb2e3265
#20 [ffffbd6c4a1d3f40] do_syscall_64+51 at ffffffffbb906213
#21 [ffffbd6c4a1d3f50] entry_SYSCALL_64_after_hwframe+103 at 
ffffffffbba000df

>
>> Can low available memory be a reason for a thread to not be able to close
>> the transaction handle for a long time?
>> Maybe some writeback thread starts the handle but is not able to complete
>> writeback?
> Well, even that would be a bug but low memory conditions are certainly some
> of less tested paths so it is possible there's a bug lurking there.
Amongst the things we have tested 2 things seem to give good improvements.

One is disabling journalling. We don't see any stuck tasks. System 
becomes slow but eventually recovers. But its not something we want to 
disable.

Other is enabling swap memory. Adding some swap memory also avoids 
system going into low memory state and system doesn't freeze.

>
>                                                                  Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
