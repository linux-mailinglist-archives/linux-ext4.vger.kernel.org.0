Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779486CD2DC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC2HXZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC2HXY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 03:23:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0563C0E;
        Wed, 29 Mar 2023 00:23:22 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PmdH90fdTz17P4q;
        Wed, 29 Mar 2023 15:20:05 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 15:23:20 +0800
Message-ID: <7410b9be-da2d-57e0-c4f8-19900df2c440@huawei.com>
Date:   Wed, 29 Mar 2023 15:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
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
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230328100037.vy23wsnl437ujdoh@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/28 18:00, Jan Kara wrote:
> On Mon 27-03-23 21:09:42, Baokun Li wrote:
>> On 2023/3/27 20:47, Jan Kara wrote:
>>> On Sat 25-03-23 14:34:43, Baokun Li wrote:
>>>> In our fault injection test, we create an ext4 file, migrate it to
>>>> non-extent based file, then punch a hole and finally trigger a WARN_ON
>>>> in the ext4_da_update_reserve_space():
>>>>
>>>> EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
>>>> ino 14, used 11 with only 10 reserved data blocks
>>>>
>>>> When writing back a non-extent based file, if we enable delalloc, the
>>>> number of reserved blocks will be subtracted from the number of blocks
>>>> mapped by ext4_ind_map_blocks(), and the extent status tree will be
>>>> updated. We update the extent status tree by first removing the old
>>>> extent_status and then inserting the new extent_status. If the block range
>>>> we remove happens to be in an extent, then we need to allocate another
>>>> extent_status with ext4_es_alloc_extent().
>>>>
>>>>          use old    to remove   to add new
>>>>       |----------|------------|------------|
>>>>                 old extent_status
>>>>
>>>> The problem is that the allocation of a new extent_status failed due to a
>>>> fault injection, and __es_shrink() did not get free memory, resulting in
>>>> a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
>>>> we map to the same extent again, and the number of reserved blocks is again
>>>> subtracted from the number of blocks in that extent. Since the blocks in
>>>> the same extent are subtracted twice, we end up triggering WARN_ON at
>>>> ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
>>> Hum, but this second call to ext4_map_blocks() should find already allocated
>>> blocks in the indirect block and thus should not be subtracting
>>> ei->i_reserved_data_blocks for the second time. What am I missing?
>>>
>>> 								Honza
>>>
>> ext4_map_blocks
>>    1. Lookup extent status tree firstly
>>         goto found;
>>    2. get the block without requesting a new file system block.
>> found:
>>    3. ceate and map the block
>>
>> When we call ext4_map_blocks() for the second time, we directly find the
>> corresponding blocks in the extent status tree, and then go directly to step
>> 3,
>> because our flag is brand new and therefore does not contain EXT4_MAP_MAPPED
>> but contains EXT4_GET_BLOCKS_CREATE, thus subtracting
>> ei->i_reserved_data_blocks
>> for the second time.
> Ah, I see. Thanks for explanation. But then the problem is deeper than just
> a mismatch in number of reserved delalloc block. The problem really is that
> if extent status tree update fails, we have inconsistency between what is
> stored in the extent status tree and what is stored on disk. And that can
> cause even data corruption issues in some cases.
The scenario we encountered was this:
```
write:
     ext4_es_insert_delayed_block
     [0/16) 576460752303423487 (U,D)
writepages:
     alloc lblk 11 pblk 35328
     [0/16) 576460752303423487 (U,D)
     -- remove block 11 from extent
       [0/11) 576460752303423487 (U,D,R)  +  (Newly allocated)[12/4) 
549196775151 (U,D,R)
       --Failure to allocate memory for a new extent will undo as:
             [0/16) 576460752303423487 (U,D,R)
     -- if success insert block 11 to extent status tree
       [0/11) 576460752303423487 (U,D,R) + (Newly allocated)[11/1) 35328 
(W) + [12/4) 549196775151 (U,D,R)

U: UNWRITTEN
D: DELAYED
W: WRITTEN
R: REFERENCED
```

When we fail to allocate a new extent, we don't map buffer and we don't do
io_submit, so why is the extent tree in memory inconsistent with the one
stored on disk? Am I missing something?

I would appreciate it if you could explain under what cases and what kind of
data corruption issues can be caused.
>
> So I think we rather need to work on handling of errors in extent status
> tree operations. In the extent status tree, we have extents which we can
> just drop without issues and extents we must not drop - this depends on the
> extent's status - currently ext4_es_is_delayed() extents must stay, others
> may be dropped but I'd wrap the decision in a helper function.
>
> I'm currently inclined towards the following:
>
> 1) Removal must never fail. If we need to split extent, we use GFP_NOFAIL
> if we cannot just drop the second part of the split extent in case of
> allocation failure.
>
> 2) Similarly if inserting extent that cannot be dropped, we use GFP_NOFAIL.
>
> 3) We do not try to "undo" failed operations like we currently do - with
> the above rules we never loose information that cannot be restored.

Totally agree!

This solution looks very effective and clear, I will try to implement it.

Thank you very much for your suggestion!

>
> And this should also fix the problem you've hit because in case of
> allocation failure we may just end up with removed extent from the extent
> status tree and thus we refetch info from the disk and find out blocks are
> already allocated.
>
> 								Honza
Reloading extent tree from disk I don't quite understand here, how do we 
handle
reserved blocks? could you explain it in more detail?

Logically, I think it is still necessary to update 
i_reserved_data_blocks only after
a successful allocation. This is also done in ext4_ext_map_blocks().

Thanks again!
-- 
With Best Regards,
Baokun Li
.
