Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3CE6D5F04
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjDDLcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjDDLcA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 07:32:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38158268A;
        Tue,  4 Apr 2023 04:31:58 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PrQZJ4xRTzKqv7;
        Tue,  4 Apr 2023 19:31:20 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 19:31:55 +0800
Message-ID: <2b8d916c-c3a0-3d1c-220a-727f47321df6@huawei.com>
Date:   Tue, 4 Apr 2023 19:31:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230325063443.1839558-1-libaokun1@huawei.com>
 <20230327124700.mnldh4sosp3ptbls@quack3>
 <a4ee8f3e-9428-ebb1-c0b4-9348075902b6@huawei.com>
 <20230328100037.vy23wsnl437ujdoh@quack3>
 <7410b9be-da2d-57e0-c4f8-19900df2c440@huawei.com>
 <20230329162228.evbppkkcbbbnaeeo@quack3>
 <e2b97584-4305-8dac-51f0-12656c295bc9@huawei.com>
 <20230404100439.wrtlibaiu5nsvdem@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230404100439.wrtlibaiu5nsvdem@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/4 18:04, Jan Kara wrote:
> On Mon 03-04-23 22:02:56, Baokun Li wrote:
>> On 2023/3/30 0:22, Jan Kara wrote:
>>> On Wed 29-03-23 15:23:19, Baokun Li wrote:
>>>> On 2023/3/28 18:00, Jan Kara wrote:
>>>>> On Mon 27-03-23 21:09:42, Baokun Li wrote:
>>>>>> On 2023/3/27 20:47, Jan Kara wrote:
>>>>>>> On Sat 25-03-23 14:34:43, Baokun Li wrote:
>>>>>>>> In our fault injection test, we create an ext4 file, migrate it to
>>>>>>>> non-extent based file, then punch a hole and finally trigger a WARN_ON
>>>>>>>> in the ext4_da_update_reserve_space():
>>>>>>>>
>>>>>>>> EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
>>>>>>>> ino 14, used 11 with only 10 reserved data blocks
>>>>>>>>
>>>>>>>> When writing back a non-extent based file, if we enable delalloc, the
>>>>>>>> number of reserved blocks will be subtracted from the number of blocks
>>>>>>>> mapped by ext4_ind_map_blocks(), and the extent status tree will be
>>>>>>>> updated. We update the extent status tree by first removing the old
>>>>>>>> extent_status and then inserting the new extent_status. If the block range
>>>>>>>> we remove happens to be in an extent, then we need to allocate another
>>>>>>>> extent_status with ext4_es_alloc_extent().
>>>>>>>>
>>>>>>>>            use old    to remove   to add new
>>>>>>>>         |----------|------------|------------|
>>>>>>>>                   old extent_status
>>>>>>>>
>>>>>>>> The problem is that the allocation of a new extent_status failed due to a
>>>>>>>> fault injection, and __es_shrink() did not get free memory, resulting in
>>>>>>>> a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
>>>>>>>> we map to the same extent again, and the number of reserved blocks is again
>>>>>>>> subtracted from the number of blocks in that extent. Since the blocks in
>>>>>>>> the same extent are subtracted twice, we end up triggering WARN_ON at
>>>>>>>> ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
>>>>>>> Hum, but this second call to ext4_map_blocks() should find already allocated
>>>>>>> blocks in the indirect block and thus should not be subtracting
>>>>>>> ei->i_reserved_data_blocks for the second time. What am I missing?
>>>>>>>
>>>>>>> 								Honza
>>>>>>>
>>>>>> ext4_map_blocks
>>>>>>      1. Lookup extent status tree firstly
>>>>>>           goto found;
>>>>>>      2. get the block without requesting a new file system block.
>>>>>> found:
>>>>>>      3. ceate and map the block
>>>>>>
>>>>>> When we call ext4_map_blocks() for the second time, we directly find the
>>>>>> corresponding blocks in the extent status tree, and then go directly to step
>>>>>> 3,
>>>>>> because our flag is brand new and therefore does not contain EXT4_MAP_MAPPED
>>>>>> but contains EXT4_GET_BLOCKS_CREATE, thus subtracting
>>>>>> ei->i_reserved_data_blocks
>>>>>> for the second time.
>>>>> Ah, I see. Thanks for explanation. But then the problem is deeper than just
>>>>> a mismatch in number of reserved delalloc block. The problem really is that
>>>>> if extent status tree update fails, we have inconsistency between what is
>>>>> stored in the extent status tree and what is stored on disk. And that can
>>>>> cause even data corruption issues in some cases.
>>>> The scenario we encountered was this:
>>>> ```
>>>> write:
>>>>       ext4_es_insert_delayed_block
>>>>       [0/16) 576460752303423487 (U,D)
>>>> writepages:
>>>>       alloc lblk 11 pblk 35328
>>>>       [0/16) 576460752303423487 (U,D)
>>>>       -- remove block 11 from extent
>>>>         [0/11) 576460752303423487 (U,D,R)  +  (Newly allocated)[12/4)
>>>> 549196775151 (U,D,R)
>>>>         --Failure to allocate memory for a new extent will undo as:
>>>>               [0/16) 576460752303423487 (U,D,R)
>>> Yes, this is what I was expecting. So now extent status tree is
>>> inconsistent with the on-disk allocation info because the block 11 is
>>> already allocated on disk but recorded as unallocated in the extent status
>>> tree.
>> Yes! There is an inconsistency here, but do_writepages finds that the
>> writeback returns -ENOMEM and keeps retrying until it succeeds, at which
>> point the above inconsistency does not exist.
> Well, do_writepages() will not retry if wbc->sync_mode == WB_SYNC_NONE. So
> the inconsistency can stay for a long time.

Indeed! There may still be problems in WB_SYNC_NONE mode.

>>> If the similar problem happened say when we punch a hole into a middle of a
>>> written extent and so block on disk got freed but extent status tree would
>>> still record it as allocated, user would be able to access freed block thus
>>> potentially exposing sensitive data.
>> ext4_punch_hole
>>    // remove extents in extents status tree
>>    ext4_es_remove_extent
>>    // remove extents tree on disk
>>    ext4_ext_remove_space
>>
>> In this scenario, we always try to delete the extents in the in-memory
>> extents status tree first, and then delete the extents tree on disk. So
>> even if we fail in deleting extents in memory, there is no inconsistency,
>> am I missing something?
> No, you are right, this case is safe. Still I suspect inconsistencies with
> extent status tree can cause more problems and possibly stale data
> exposure.

Yes, we also suspect that this inconsistency may cause problems, but we have
not found a scenario where the problem may occur, which is why we asked you
for advice on what scenarios would be problematic. But in any case, the 
fix you
suggested before would avoid this problem.

Thank you for your confirmation!

>>>>       -- if success insert block 11 to extent status tree
>>>>         [0/11) 576460752303423487 (U,D,R) + (Newly allocated)[11/1) 35328 (W)
>>>> + [12/4) 549196775151 (U,D,R)
>>>>
>>>> U: UNWRITTEN
>>>> D: DELAYED
>>>> W: WRITTEN
>>>> R: REFERENCED
>>>> ```
>>>>
>>>> When we fail to allocate a new extent, we don't map buffer and we don't do
>>>> io_submit, so why is the extent tree in memory inconsistent with the one
>>>> stored on disk? Am I missing something?
>>>>
>>>> I would appreciate it if you could explain under what cases and what kind of
>>>> data corruption issues can be caused.
>>> See above.
>>>
>>>>> And this should also fix the problem you've hit because in case of
>>>>> allocation failure we may just end up with removed extent from the extent
>>>>> status tree and thus we refetch info from the disk and find out blocks are
>>>>> already allocated.
>>>> Reloading extent tree from disk I don't quite understand here, how do we
>>>> handle reserved blocks? could you explain it in more detail?
>>>>
>>>> Logically, I think it is still necessary to update i_reserved_data_blocks
>>>> only after a successful allocation. This is also done in
>>>> ext4_ext_map_blocks().
>>> I guess there is some misunderstanding here. Both with
>>> ext4_ext_map_blocks() and ext4_ind_map_blocks() we end up updating
>>> i_reserved_data_blocks only after the blocks are successfully allocated and
>>> inserted in the respective data structure but *before* updating extent
>>> status tree. If extent status tree operation fails, we currently get
>>> inconsistency between extent status tree and on-disk info in both cases
>>> AFAICS. Am I missing something?
>> Yes, our code is indeed designed to only update the number of reserved
>> blocks after the block allocation is complete. We have different
>> treatment for extent based file and non-extent based file in commit
>> 5f634d064c70 ("ext4: Fix quota accounting error with fallocate").
>>
>> For extent based file, we update the number of reserved blocks before the
>> "got_allocated_blocks" tag after the blocks are successfully allocated in
>> ext4_ext_map_blocks().
>>
>> For the non-extent based file we update the number of reserved blocks
>> after ext4_ind_map_blocks() is executed, which leads to the problem that
>> when we call ext4_ind_map_blocks() to create a block, it does not always
>> create a block.  For example, if the extents status tree we encountered
>> earlier does not match the extents tree on disk, this is of course a
>> problem in itself, but in terms of code logic, updating the number of
>> reserved blocks as ext4_ext_map_blocks() does can prevent us from trying
>> to create a block and not creating it, resulting in an incorrect number
>> of reserved blocks.
> I see, thanks for explanation! Indeed it may be good to cleanup this code
> so that indirect block and extent based inodes are handled in the same way.
>
> 								Honza

Thanks for your support!

I will send a patch V2 with the changes suggested by you!


-- 
With Best Regards,
Baokun Li
.
