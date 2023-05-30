Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11071616D
	for <lists+linux-ext4@lfdr.de>; Tue, 30 May 2023 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjE3NT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 May 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjE3NTZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 May 2023 09:19:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1347E8;
        Tue, 30 May 2023 06:19:10 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QVtJd5yWtzTksd;
        Tue, 30 May 2023 21:18:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 21:19:06 +0800
Message-ID: <14cf4066-bd6f-268d-76b7-d9892e7d651e@huawei.com>
Date:   Tue, 30 May 2023 21:19:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix race condition between buffer write and
 page_mkwrite
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <jun.nie@linaro.org>,
        <ebiggers@kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com>,
        <stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20230529080148.3810143-1-libaokun1@huawei.com>
 <20230529144435.bj65ltbww5jbh2uc@quack3>
 <7f6ab488-9eef-fb94-b007-839eb1c1f487@huawei.com>
 <20230530074225.ly6vnolykqu5teos@quack3>
 <78f61c71-be47-cd4d-36c8-161c7a86c9c0@huawei.com>
 <20230530102804.6t7np7om6tczscuo@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230530102804.6t7np7om6tczscuo@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/5/30 18:28, Jan Kara wrote:
> On Tue 30-05-23 17:39:16, Baokun Li wrote:
>> On 2023/5/30 15:42, Jan Kara wrote:
>>> On Tue 30-05-23 10:00:44, Baokun Li wrote:
>>>> On 2023/5/29 22:44, Jan Kara wrote:
>>>>> On Mon 29-05-23 16:01:48, Baokun Li wrote:
>>>>>> Syzbot reported a BUG_ON:
>>>>>> ==================================================================
>>>>>> EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
>>>>>> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1098: group 0, block
>>>>>>         bitmap and bg descriptor inconsistent: 25 vs 150994969 free clusters
>>>>>> ------------[ cut here ]------------
>>>>>> kernel BUG at fs/ext4/ext4_jbd2.c:53!
>>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>>>> CPU: 1 PID: 494 Comm: syz-executor.0 6.1.0-rc7-syzkaller-ga4412fdd49dc #0
>>>>>> RIP: 0010:__ext4_journal_stop+0x1b3/0x1c0
>>>>>>     [...]
>>>>>> Call Trace:
>>>>>>     ext4_write_inline_data_end+0xa39/0xdf0
>>>>>>     ext4_da_write_end+0x1e2/0x950
>>>>>>     generic_perform_write+0x401/0x5f0
>>>>>>     ext4_buffered_write_iter+0x35f/0x640
>>>>>>     ext4_file_write_iter+0x198/0x1cd0
>>>>>>     vfs_write+0x8b5/0xef0
>>>>>>     [...]
>>>>>> ==================================================================
>>>>>>
>>>>>> The above BUG_ON is triggered by the following race:
>>>>>>
>>>>>>               cpu1                    cpu2
>>>>>> ________________________|________________________
>>>>>> ksys_write
>>>>>>     vfs_write
>>>>>>      new_sync_write
>>>>>>       ext4_file_write_iter
>>>>>>        ext4_buffered_write_iter
>>>>>>         generic_perform_write
>>>>>>          ext4_da_write_begin
>>>>>>                              do_fault
>>>>>>                               do_page_mkwrite
>>>>>>                                ext4_page_mkwrite
>>>>>>                                 ext4_convert_inline_data
>>>>>>                                  ext4_convert_inline_data_nolock
>>>>>>                                   ext4_destroy_inline_data_nolock
>>>>>>                                    //clear EXT4_STATE_MAY_INLINE_DATA
>>>>>>                                   ext4_map_blocks --> return error
>>>>>>           ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>>>>>>           ext4_block_write_begin
>>>>>>                                   ext4_restore_inline_data
>>>>>>                                    // set EXT4_STATE_MAY_INLINE_DATA
>>>>>>          ext4_da_write_end
>>>>>>           ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>>>>>>           ext4_write_inline_data_end
>>>>>>            handle=NULL
>>>>>>            ext4_journal_stop(handle)
>>>>>>             __ext4_journal_stop
>>>>>>              ext4_put_nojournal(handle)
>>>>>>               ref_cnt = (unsigned long)handle
>>>>>>               BUG_ON(ref_cnt == 0)  ---> BUG_ON
>>>>>>
>>>>>> The root cause of this problem is that the ext4_convert_inline_data() in
>>>>>> ext4_page_mkwrite() does not grab i_rwsem, so it may race with
>>>>>> ext4_buffered_write_iter() and cause the write_begin() and write_end()
>>>>>> functions to be inconsistent and trigger BUG_ON.
>>>>>>
>>>>>> To solve the above issue, we cannot add inode_lock directly to
>>>>>> ext4_page_mkwrite(), because this function is a hot path and frequent calls
>>>>>> to inode_lock will cause performance degradation for multi-threaded reads
>>>>>> and writes. Hence, we move ext4_convert_inline_data() to ext4_file_mmap(),
>>>>>> and only when inline_data is enabled and mmap a file in shared write mode,
>>>>>> we hold the lock to convert, which can reduce the impact on performance.
>>>>>>
>>>>>> Reported-by: Jun Nie <jun.nie@linaro.org>
>>>>>> Closes: https://lore.kernel.org/lkml/63903521.5040307@huawei.com/t/
>>>>>> Reported-by: syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com
>>>>>> Closes: https://syzkaller.appspot.com/bug?id=899b37f20ce4072bcdfecfe1647b39602e956e36
>>>>>> Fixes: 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map")
>>>>>> CC: stable@vger.kernel.org # 4.12+
>>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>> Thanks for the patch! The problem with i_rwsem in ext4_page_mkwrite() is
>>>>> not so much about performance as about lock ordering. In
>>>>> ext4_page_mkwrite() we are called with mmap_sem held and so we cannot
>>>>> acquire i_rwsem because it ranks about it.
>>>> Thank you for your review!
>>>>
>>>> I'm sorry I didn't make myself clear here.
>>>>
>>>> Yes, we can't get i_rwsem after holding mmap_sem at any time, otherwise
>>>> ABBA deadlock may occur. The "add inode_lock directly" in my patch
>>>> description actually looks like this:
>>>> ```
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index b98d2d58b900..c9318dc2a613 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -6025,12 +6025,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>>>>           sb_start_pagefault(inode->i_sb);
>>>>           file_update_time(vma->vm_file);
>>>>
>>>> -       filemap_invalidate_lock_shared(mapping);
>>>> -
>>>> +       inode_lock(inode);
>>>>           err = ext4_convert_inline_data(inode);
>>>> +       inode_unlock(inode);
>>>>           if (err)
>>>>                   goto out_ret;
>>>>
>>>> +       filemap_invalidate_lock_shared(mapping);
>>>> +
>>>>           /*
>>>>            * On data journalling we skip straight to the transaction handle:
>>>>            * there's no delalloc; page truncated will be checked later; the
>>>> ```
>>> Yes, but even this could deadlock. The ABBA deadlock I'm speaking about
>>> would not be created with mapping->invalidate_lock but rather with
>>> task->mm->mmap_lock which is acquired at the beginning of page fault in the
>>> arch code.
>> Thanks for the explanation!
>>
>> I thought the mmap_sem said was "&EXT4_I(inode)->i_mmap_sem".
> We don't have that one anymore :). But yes, there are too many mmap locks so
> I should have been more precise from the start. I'm sorry for the
> confusion.
>
>> But here are some more questions:
>>
>> 1) In the arch code page fault is handled by mmap_read_lock(mm) to get the
>>     shared lock, why would this lead to ABBA deadlock?
>>
>> 2) Why would page fault be triggered in the write process?
>>
>> Could you explain it in more detail?
> OK, let me draw here the exact deadlock graph:
>
> CPU0				CPU1			CPU2
> write(2)			page fault		mmap(2)
> 				  do_user_addr_fault()
> 				    mmap_read_lock()      ...
> 				    ...                   vm_mmap_pgoff()
> 							    mmap_write_lock_killable(mm)
> 							      - blocks on CPU1
> 								holding the lock
>    ext4_buffered_write_iter()
>      inode_lock(inode);
>      ...
>      generic_perform_write(iocb, from);
>        fault_in_iov_iter_readable(i, bytes)
>          - hits pagefault
> 	do_user_addr_fault()
> 	  mmap_read_lock()
> 	    - blocks on CPU2 as writer queued first
> 				    ext4_page_mkwrite()
> 				      - would deadlock here if we
> 				        try to take inode lock
>
> 								Honza

Got it! This graph is very clear!  👍

Thank you very much for your patient and detailed explanation!

-- 
With Best Regards,
Baokun Li
.
