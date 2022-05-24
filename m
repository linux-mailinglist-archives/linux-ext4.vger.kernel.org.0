Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C69532A92
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiEXMmw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiEXMmv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 08:42:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB18BD14;
        Tue, 24 May 2022 05:42:49 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6v2Q17C2zgYGl;
        Tue, 24 May 2022 20:41:18 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 20:42:47 +0800
Message-ID: <4c7b5130-5fe3-8fee-3283-bfc0de367a59@huawei.com>
Date:   Tue, 24 May 2022 20:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
To:     Lukas Czerner <lczerner@redhat.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-2-libaokun1@huawei.com>
 <20220523095803.gomx2q62ymocrkrz@fedora>
 <2525e39a-5be9-bae1-b77d-60f583892868@huawei.com>
 <20220524121139.cm6475vnmkupsp5q@fedora>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220524121139.cm6475vnmkupsp5q@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/24 20:11, Lukas Czerner 写道:
> On Mon, May 23, 2022 at 08:19:03PM +0800, libaokun (A) wrote:
>> 在 2022/5/23 17:58, Lukas Czerner 写道:
>>> On Sat, May 21, 2022 at 09:42:16PM +0800, Baokun Li wrote:
>>>> Hulk Robot reported a BUG_ON:
>>>> ==================================================================
>>>> kernel BUG at fs/ext4/mballoc.c:3211!
>>>> [...]
>>>> RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
>>>> [...]
>>>> Call Trace:
>>>>    ext4_mb_new_blocks+0x9df/0x5d30
>>>>    ext4_ext_map_blocks+0x1803/0x4d80
>>>>    ext4_map_blocks+0x3a4/0x1a10
>>>>    ext4_writepages+0x126d/0x2c30
>>>>    do_writepages+0x7f/0x1b0
>>>>    __filemap_fdatawrite_range+0x285/0x3b0
>>>>    file_write_and_wait_range+0xb1/0x140
>>>>    ext4_sync_file+0x1aa/0xca0
>>>>    vfs_fsync_range+0xfb/0x260
>>>>    do_fsync+0x48/0xa0
>>>> [...]
>>>> ==================================================================
>>>>
>>>> Above issue may happen as follows:
>>>> -------------------------------------
>>>> do_fsync
>>>>    vfs_fsync_range
>>>>     ext4_sync_file
>>>>      file_write_and_wait_range
>>>>       __filemap_fdatawrite_range
>>>>        do_writepages
>>>>         ext4_writepages
>>>>          mpage_map_and_submit_extent
>>>>           mpage_map_one_extent
>>>>            ext4_map_blocks
>>>>             ext4_mb_new_blocks
>>>>              ext4_mb_normalize_request
>>>>               >>> start + size <= ac->ac_o_ex.fe_logical
>>>>              ext4_mb_regular_allocator
>>>>               ext4_mb_simple_scan_group
>>>>                ext4_mb_use_best_found
>>>>                 ext4_mb_new_preallocation
>>>>                  ext4_mb_new_inode_pa
>>>>                   ext4_mb_use_inode_pa
>>>>                    >>> set ac->ac_b_ex.fe_len <= 0
>>>>              ext4_mb_mark_diskspace_used
>>>>               >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>>>>
>>>> we can easily reproduce this problem with the following commands:
>>>> 	`fallocate -l100M disk`
>>>> 	`mkfs.ext4 -b 1024 -g 256 disk`
>>>> 	`mount disk /mnt`
>>>> 	`fsstress -d /mnt -l 0 -n 1000 -p 1`
>>>>
>>>> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
>>>> Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
>>>> when the size is truncated. So start should be the start position of
>>>> the group where ac_o_ex.fe_logical is located after alignment.
>>>> In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
>>>> is very large, the value calculated by start_off is more accurate.
>>>>
>>>> Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
>>>> Reported-by: Hulk Robot<hulkci@huawei.com>
>>>> Signed-off-by: Baokun Li<libaokun1@huawei.com>
>>>> ---
>>>>    fs/ext4/mballoc.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index ea653d19f9ec..32410b79b664 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -4107,6 +4107,17 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>>>>    	size = size >> bsbits;
>>>>    	start = start_off >> bsbits;
>>>> +	/*
>>>> +	 * Because size must be less than or equal to
>>>> +	 * EXT4_BLOCKS_PER_GROUP, start should be the start position of
>>>> +	 * the group where ac_o_ex.fe_logical is located after alignment.
>>>> +	 * In addition, when the value of fe_logical or
>>>> +	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
>>>> +	 * by start_off is more accurate.
>>>> +	 */
>>>> +	start = max(start, round_down(ac->ac_o_ex.fe_logical,
>>>> +			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
>>> This does not look right. The second argument in round_down() must be a
>>> power of two, but there is no such restriction on blocks per group.
>> Indeed, block peer group size should be a multiple of 8. I forgot.
>>
>> Thank you very much for your correction.
>>
>>> Also I am not quite sure why do we adjust the start in this way at all?
>>> If we found what seems to be a preallocated extent which we can use and
>>> we're actually going to use 0 lenght extent it seems like the problem is
>>> somewhere else? Can you desribe the problem a bit more in detail?
>>>
>>> Maybe I need to look at the ext4_mb_normalize_request() some more.
>>>
>>> -Lukas
>> The logical block map reached before the problem stack was 1011.
>>
>> The estimated location of the size logical block of the inde plus the
>> required allocation length 7, the size is 1018.
>>
>> But the i_size of inode is 1299, so the size is 1299, the aligned size is
>> 2048, and the end is 2048.
>>
>> Because of the restriction of ar -> pleft, start==648.
>>
>> EXT4_BLOCKS_PER_GROUP (ac- > ac_sb) is 256, so the size is 256 and the end
>> is 904.
>>
>> It is not normal to truncate here, the end is less than 1299 of the target
>> logical block,
>> that is, the allocated range does not contain the target logical block.
>>
>> Then this new scope conflicts with the previous PA, as follows:
>>
>>            pa_start-506           pa_end-759
>>   |____________P________V_________P__________V_____________l________|
>>   0                       start-648                   end-904 logical-1299
>> 2048
>>
>> In this case, start is changed to pa_end, that is, 759.
>> In this case, a bug_ON is reported in ext4_mb_mark_diskspace_used.
>>
>> The problem is caused by the truncation introduced in the
>> cd648b8a8fd5 ("ext4: trim allocation requests to group size").
>> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
>> However, the truncation method is incorrect. The group where the logical is
>> located should be used for allocation. If the value of EXT4_BLOCKS_PER_GROUP
>> is 256, size 2048 can be divided into eight groups. If the value of logical
>> is 1299,
>> the value of logical must be in the sixth group, that is,
>> start=1299/256*256=5*256=1280, end=size+1280=1536.
>> Then, the value range can be further narrowed down based on other
>> restrictions.
>>
>>                                     1024     1280     1536
>> |________|________|________|________|________|__l______|________|________|
>> 0 group1 group2 group3 group4 group5 group6 group7 group8 2048
> Ok, thanks for the explanation it makes sense now, although should not
> we just adjust the start only when the size is being truncated to the
> EXT4_BLOCKS_PER_GROUP?
>
> -Lukas
Yes, it is. Assume that the value of fe_logical is 1011,
and the value of EXT4_BLOCKS_PER_GROUP is 1024.
In this case, 1011 / 1024 = 0, and 0 x 1024 is still 0.
Therefore, the value of start is 0, which does not change.

>>>> +
>>>>    	/* don't cover already allocated blocks in selected range */
>>>>    	if (ar->pleft && start <= ar->lleft) {
>>>>    		size -= ar->lleft + 1 - start;
>>>> -- 
>>>> 2.31.1
>>>>
>>> .
>> -- 
>> With Best Regards,
>> Baokun Li
> .

-- 
With Best Regards,
Baokun Li

