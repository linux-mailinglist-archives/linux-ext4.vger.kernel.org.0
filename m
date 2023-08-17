Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3D77FE3D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbjHQS7J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 14:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354687AbjHQS7I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 14:59:08 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871CF2722;
        Thu, 17 Aug 2023 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692298747; x=1723834747;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=NjuisVqpjoBSHXIxzEUxS1vTdeNnvezEaa/XepIm5Ug=;
  b=pnrfsYd7ExN4NOwJU8J2WzIbjvkoiIfO884Ro7Ef59xrxRHzLe0wiZES
   OLdy/cAAooVVk6lyovkXTWZxvwtPEG66mIxr6YP2OSZyBJu+QJ6oOmvpK
   056rA+Jf7puwTkMLm08teRAc3yQ9xY4AyUYBVSugRXQFI7tiyzeLUDm+V
   k=;
X-IronPort-AV: E=Sophos;i="6.01,180,1684800000"; 
   d="scan'208";a="357969552"
Subject: Re: Tasks stuck jbd2 for a long time
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:59:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 60E8880F7C;
        Thu, 17 Aug 2023 18:59:05 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 17 Aug 2023 18:59:05 +0000
Received: from [192.168.6.165] (10.187.171.32) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 17 Aug 2023 18:59:04 +0000
Message-ID: <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
Date:   Thu, 17 Aug 2023 11:59:03 -0700
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
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20230817104917.bs46doo6duo7utlm@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.32]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/17/23 3:49 AM, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed 16-08-23 15:53:05, Bhatnagar, Rishabh wrote:
>> I collected dump and looked at some processes that were stuck in
>> uninterruptible sleep.These are from upstream stable tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/?h=linux-5.10.y
>> (5.10.191)
>>
>> One of them is the journal thread that is waiting for some other thread to
>> close transaction handle.
>>
>> PID: 10642  TASK: ffff9768823f4000  CPU: 37  COMMAND: "jbd2/md0-8"
>>   #0 [ffffbd6c40c17c60] __schedule+617 at ffffffffbb912df9
>>   #1 [ffffbd6c40c17cf8] schedule+60 at ffffffffbb91330c
>>   #2 [ffffbd6c40c17d08] jbd2_journal_commit_transaction+877 at
>> ffffffffc016b90d [jbd2] (/home/ec2-user/linux/fs/jbd2/commit.c:497)
>>   #3 [ffffbd6c40c17ea0] kjournald2+282 at ffffffffc01723ba [jbd2]
>> (/home/ec2-user/linux/fs/jbd2/journal.c:214)
>>   #4 [ffffbd6c40c17f10] kthread+279 at ffffffffbb0b9167
>>   #5 [ffffbd6c40c17f50] ret_from_fork+34 at ffffffffbb003802
> Yes, correct. This is waiting for transaction->t_updates to drop to 0.
>
>> One of threads that have started the handle and waiting for journal to
>> commit and unlock the current transaction. This stack only shows
>> ext4lazyinit but with lazyinit disabled we have seen other threads stuck in
>> same place.
>>
>> PID: 10644  TASK: ffff976901010000  CPU: 37  COMMAND: "ext4lazyinit"
>>   #0 [ffffbd6c40c1fbe0] __schedule+617 at ffffffffbb912df9
>>   #1 [ffffbd6c40c1fc78] schedule+60 at ffffffffbb91330c
>>   #2 [ffffbd6c40c1fc88] wait_transaction_locked+137 at ffffffffc0168089
>> [jbd2] (/home/ec2-user/linux/fs/jbd2/transaction.c:184)
>>   #3 [ffffbd6c40c1fcd8] add_transaction_credits+62 at ffffffffc016813e [jbd2]
>> (/home/ec2-user/linux/fs/jbd2/transaction.c:241)
>>   #4 [ffffbd6c40c1fd30] start_this_handle+533 at ffffffffc0168615 [jbd2]
>> (/home/ec2-user/linux/fs/jbd2/transaction.c:416)
>>   #5 [ffffbd6c40c1fdc0] jbd2__journal_start+244 at ffffffffc0168dc4 [jbd2]
>>   #6 [ffffbd6c40c1fe00] __ext4_journal_start_sb+250 at ffffffffc02ef65a
>> [ext4]
>>   #7 [ffffbd6c40c1fe40] ext4_init_inode_table+190 at ffffffffc0302ace [ext4]
>>   #8 [ffffbd6c40c1feb0] ext4_lazyinit_thread+906 at ffffffffc033ec9a [ext4]
>>   #9 [ffffbd6c40c1ff10] kthread+279 at ffffffffbb0b9167
>> #10 [ffffbd6c40c1ff50] ret_from_fork+34 at ffffffffbb003802
> This thread actually didn't start a transaction. It is *trying* to start a
> transaction but it has failed and we are now waiting for transaction commit
> to proceed (i.e., for jbd2/md0-8 process). So this isn't the process jbd2
> is waiting for.
>
>> To replicate the download scenario i'm just using dd to copy random data to
>> disk. I launch a bunch of threads and try to stress the system. Many of
>> those threads seem to be stuck in balance_dirty_pages_ratelimited as can be
>> seen below.
>>
>> PID: 10709  TASK: ffff9769016f8000  CPU: 25  COMMAND: "dd"
>>   #0 [ffffbd6c40dafa48] __schedule+617 at ffffffffbb912df9
>>   #1 [ffffbd6c40dafae0] schedule+60 at ffffffffbb91330c
>>   #2 [ffffbd6c40dafaf0] schedule_timeout+570 at ffffffffbb916a7a
>>   #3 [ffffbd6c40dafb68] io_schedule_timeout+25 at ffffffffbb913619 ((inlined
>> by) io_schedule_finish at /home/ec2-user/linux/kernel/sched/core.c:6274)
>>   #4 [ffffbd6c40dafb80] balance_dirty_pages+654 at ffffffffbb2367ce
>> (/home/ec2-user/linux/mm/page-writeback.c:1799)
>>   #5 [ffffbd6c40dafcf0] balance_dirty_pages_ratelimited+763 at
>> ffffffffbb23752b  (/home/ec2-user/linux/mm/page-writeback.c:1926)
>>   #6 [ffffbd6c40dafd18] generic_perform_write+308 at ffffffffbb22af44
>> (/home/ec2-user/linux/mm/filemap.c:3370)
>>   #7 [ffffbd6c40dafd88] ext4_buffered_write_iter+161 at ffffffffc02fcba1
>> [ext4] (/home/ec2-user/linux/fs/ext4/file.c:273)
>>   #8 [ffffbd6c40dafdb8] ext4_file_write_iter+96 at ffffffffc02fccf0 [ext4]
>>   #9 [ffffbd6c40dafe40] new_sync_write+287 at ffffffffbb2e0c0f
>> #10 [ffffbd6c40dafec8] vfs_write+481 at ffffffffbb2e3161
>> #11 [ffffbd6c40daff00] ksys_write+165 at ffffffffbb2e3385
>> #12 [ffffbd6c40daff40] do_syscall_64+51 at ffffffffbb906213
>> #13 [ffffbd6c40daff50] entry_SYSCALL_64_after_hwframe+103 at
>> ffffffffbba000df
> Yes, this is waiting for page writeback to reduce amount of dirty pages in
> the pagecache. We are not holding transaction handle during this wait so
> this is also not the task jbd2 is waiting for.
>
>> There are other dd threads that are trying to read and are handling page
>> fault. These are in runnable state and not uninterruptible sleep.
>>
>> PID: 14581  TASK: ffff97c3cfdbc000  CPU: 29  COMMAND: "dd"
>>   #0 [ffffbd6c4a1d3598] __schedule+617 at ffffffffbb912df9
>>   #1 [ffffbd6c4a1d3630] _cond_resched+38 at ffffffffbb9133e6
>>   #2 [ffffbd6c4a1d3638] shrink_page_list+126 at ffffffffbb2412fe
>>   #3 [ffffbd6c4a1d36c8] shrink_inactive_list+478 at ffffffffbb24441e
>>   #4 [ffffbd6c4a1d3768] shrink_lruvec+957 at ffffffffbb244e3d
>>   #5 [ffffbd6c4a1d3870] shrink_node+552 at ffffffffbb2452a8
>>   #6 [ffffbd6c4a1d38f0] do_try_to_free_pages+201 at ffffffffbb245829
>>   #7 [ffffbd6c4a1d3940] try_to_free_pages+239 at ffffffffbb246c0f
>>   #8 [ffffbd6c4a1d39d8] __alloc_pages_slowpath.constprop.114+913 at
>> ffffffffbb28d741
>>   #9 [ffffbd6c4a1d3ab8] __alloc_pages_nodemask+679 at ffffffffbb28e2e7
>> #10 [ffffbd6c4a1d3b28] alloc_pages_vma+124 at ffffffffbb2a734c
>> #11 [ffffbd6c4a1d3b68] handle_mm_fault+3999 at ffffffffbb26de2f
>> #12 [ffffbd6c4a1d3c28] exc_page_fault+708 at ffffffffbb909c84
>> #13 [ffffbd6c4a1d3c80] asm_exc_page_fault+30 at ffffffffbba00b4e
>>   #14 [ffffbd6c4a1d3d30] copyout+28 at ffffffffbb5160bc
>> #15 [ffffbd6c4a1d3d38] _copy_to_iter+158 at ffffffffbb5188de
>> #16 [ffffbd6c4a1d3d98] get_random_bytes_user+136 at ffffffffbb644608
>> #17 [ffffbd6c4a1d3e48] new_sync_read+284 at ffffffffbb2e0a5c
>> #18 [ffffbd6c4a1d3ed0] vfs_read+353 at ffffffffbb2e2f51
>> #19 [ffffbd6c4a1d3f00] ksys_read+165 at ffffffffbb2e3265
>> #20 [ffffbd6c4a1d3f40] do_syscall_64+51 at ffffffffbb906213
>> #21 [ffffbd6c4a1d3f50] entry_SYSCALL_64_after_hwframe+103 at
>> ffffffffbba000df
> This process is in direct reclaim trying to free more memory. It doesn't
> have transaction handle started so jbd2 also isn't waiting for this
> process.
>
>>>> Can low available memory be a reason for a thread to not be able to close
>>>> the transaction handle for a long time?
>>>> Maybe some writeback thread starts the handle but is not able to complete
>>>> writeback?
>>> Well, even that would be a bug but low memory conditions are certainly some
>>> of less tested paths so it is possible there's a bug lurking there.
>> Amongst the things we have tested 2 things seem to give good improvements.
>>
>> One is disabling journalling. We don't see any stuck tasks. System becomes
>> slow but eventually recovers. But its not something we want to disable.
>>
>> Other is enabling swap memory. Adding some swap memory also avoids system
>> going into low memory state and system doesn't freeze.
> OK, these are just workarounds. The question really is which process holds
> the transaction handle jbd2 thread is waiting for. It is none of the
> processes you have shown above. Since you have the crashdump, you can also
> search all the processes and find those which have non-zero
> task->journal_info. And from these processes you can select those where
> task->journal_info points to an object from jbd2_handle_cache and then you
> can verify whether the handles indeed point (through handle->h_transaction)
> to the transaction jbd2 thread is trying to commit. After you've identified
> such task it is interesting to see what is it doing...
>
Hi Jan

I think I found the thread that is holding the transaction handle. It 
seems to be in runnable state though.
It has the journal_info set to the journal handle that has the matching 
transaction as the journal's running transaction.
Here is the associated stack trace. It is converting unwritten extents 
to extents.

PID: 287    TASK: ffff976801890000  CPU: 20  COMMAND: "kworker/u96:35"
  #0 [ffffbd6c40b3f498] __schedule+617 at ffffffffbb912df9
  #1 [ffffbd6c40b3f530] _cond_resched+38 at ffffffffbb9133e6
  #2 [ffffbd6c40b3f538] shrink_lruvec+670 at ffffffffbb244d1e
  #3 [ffffbd6c40b3f640] _cond_resched+21 at ffffffffbb9133d5
  #4 [ffffbd6c40b3f648] shrink_node+552 at ffffffffbb2452a8
  #5 [ffffbd6c40b3f6c8] do_try_to_free_pages+201 at ffffffffbb245829
  #6 [ffffbd6c40b3f718] try_to_free_pages+239 at ffffffffbb246c0f
  #7 [ffffbd6c40b3f7b0] __alloc_pages_slowpath.constprop.114+913 at 
ffffffffbb28d741
  #8 [ffffbd6c40b3f890] __alloc_pages_nodemask+679 at ffffffffbb28e2e7
  #9 [ffffbd6c40b3f900] allocate_slab+726 at ffffffffbb2b0886
#10 [ffffbd6c40b3f958] ___slab_alloc+1173 at ffffffffbb2b3ff5
#11 [ffffbd6c40b3f988] insert_revoke_hash+37 at ffffffffc016f435 [jbd2]  
(/home/ec2-user/linux/fs/jbd2/revoke.c:146)
#12 [ffffbd6c40b3f9b8] kmem_cache_free+924 at ffffffffbb2b712c )(inlined 
by) slab_alloc at /home/ec2-user/linux/mm/slub.c:2904)
#13 [ffffbd6c40b3fa18] insert_revoke_hash+37 at ffffffffc016f435 [jbd2] 
(/home/ec2-user/linux/fs/jbd2/revoke.c:146)
#14 [ffffbd6c40b3fa40] kmem_cache_alloc+928 at ffffffffbb2b4590 
(/home/ec2-user/linux/mm/slub.c:290)
#15 [ffffbd6c40b3fa78] insert_revoke_hash+37 at ffffffffc016f435 [jbd2] 
(/home/ec2-user/linux/fs/jbd2/revoke.c:146)
#16 [ffffbd6c40b3faa0] __ext4_forget+338 at ffffffffc02efb32 [ext4]  
(/home/ec2-user/linux/fs/ext4/ext4_jbd2.c:298)
#17 [ffffbd6c40b3fae0] ext4_free_blocks+2437 at ffffffffc031fd55 [ext4] 
(/home/ec2-user/linux/fs/ext4/mballoc.c:5709 (discriminator 2))
#18 [ffffbd6c40b3fbb0] ext4_ext_handle_unwritten_extents+596 at 
ffffffffc02f56a4 [ext4] ((inlined by) ext4_ext_handle_unwritten_extents 
at /home/ec2-user/linux/fs/ext4/extents.c:3892)
#19 [ffffbd6c40b3fc98] ext4_ext_map_blocks+1325 at ffffffffc02f710d 
[ext4] (/home/ec2-user/linux/fs/ext4/extents.c:4165)
#20 [ffffbd6c40b3fd60] ext4_map_blocks+813 at ffffffffc030bd0d [ext4] 
(/home/ec2-user/linux/fs/ext4/inode.c:659)
#21 [ffffbd6c40b3fdd0] ext4_convert_unwritten_extents+303 at 
ffffffffc02f8adf [ext4] (/home/ec2-user/linux/fs/ext4/extents.c:4810)
#22 [ffffbd6c40b3fe28] ext4_convert_unwritten_io_end_vec+95 at 
ffffffffc02f8c5f [ext4] (/home/ec2-user/linux/fs/ext4/extents.c:4850)
#23 [ffffbd6c40b3fe58] ext4_end_io_rsv_work+269 at ffffffffc032c3fd 
[ext4] ((inlined by) ext4_do_flush_completed_IO at 
/home/ec2-user/linux/fs/ext4/page-io.c:262)
#24 [ffffbd6c40b3fe98] process_one_work+405 at ffffffffbb0b2725
#25 [ffffbd6c40b3fed8] worker_thread+48 at ffffffffbb0b2920
#26 [ffffbd6c40b3ff10] kthread+279 at ffffffffbb0b9167
#27 [ffffbd6c40b3ff50] ret_from_fork+34 at ffffffffbb003802

Thanks
Rishabh

