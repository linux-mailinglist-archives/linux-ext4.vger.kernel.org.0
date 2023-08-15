Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5E77C4FC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 03:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHOBUa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 21:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjHOBUY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 21:20:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8B1715;
        Mon, 14 Aug 2023 18:20:23 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPthQ6RrVz1GDWw;
        Tue, 15 Aug 2023 09:19:02 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 09:20:20 +0800
Message-ID: <aa03f191-445c-0d2e-d6d7-0a3208d7df7a@huawei.com>
Date:   Tue, 15 Aug 2023 09:20:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230814074351.96741-1-libaokun1@huawei.com>
 <20230814104546.xtjuoxu7jn3bysk3@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230814104546.xtjuoxu7jn3bysk3@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/14 18:45, Jan Kara wrote:
> On Mon 14-08-23 15:43:51, Baokun Li wrote:
>> Yikebaer reported an issue:
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
>> fs/ext4/extents_status.c:894
>> Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438
>>
>> CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
>> Call Trace:
>>   [...]
>>   kasan_report+0xba/0xf0 mm/kasan/report.c:588
>>   ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
>>   ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>>   ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>>   ext4_zero_range fs/ext4/extents.c:4622 [inline]
>>   ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>>   [...]
>>
>> Allocated by task 8438:
>>   [...]
>>   kmem_cache_zalloc include/linux/slab.h:693 [inline]
>>   __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
>>   ext4_es_insert_extent+0x672/0xcb0 fs/ext4/extents_status.c:873
>>   ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>>   ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>>   ext4_zero_range fs/ext4/extents.c:4622 [inline]
>>   ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>>   [...]
>>
>> Freed by task 8438:
>>   [...]
>>   kmem_cache_free+0xec/0x490 mm/slub.c:3823
>>   ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
>>   __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
>>   ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
>>   ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>>   ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>>   ext4_zero_range fs/ext4/extents.c:4622 [inline]
>>   ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>>   [...]
>> ==================================================================
>>
>> The flow of issue triggering is as follows:
>> 1. remove es
>>        raw es               es  removed  es1
>> |-------------------| -> |----|.......|------|
>>
>> 2. insert es
>>    es   insert   es1      merge with es  es1     merge with es and free es1
>> |----|.......|------| -> |------------|------| -> |-------------------|
>>
>> es merges with newes, then merges with es1, frees es1, then determines
>> if es1->es_len is 0 and triggers a UAF.
>>
>> The code flow is as follows:
>> ext4_es_insert_extent
>>    es1 = __es_alloc_extent(true);
>>    es2 = __es_alloc_extent(true);
>>    __es_remove_extent(inode, lblk, end, NULL, es1)
>>      __es_insert_extent(inode, &newes, es1) ---> insert es1 to es tree
>>    __es_insert_extent(inode, &newes, es2)
>>      ext4_es_try_to_merge_right
>>        ext4_es_free_extent(inode, es1) --->  es1 is freed
>>    if (es1 && !es1->es_len)
>>      // Trigger UAF by determining if es1 is used.
>>
>> We determine whether es1 or es2 is used immediately after calling
>> __es_remove_extent() or __es_insert_extent() to avoid triggering a
>> UAF if es1 or es2 is freed.
>>
>> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
>> Closes: https://lore.kernel.org/lkml/CALcu4raD4h9coiyEBL4Bm0zjDwxC2CyPiTwsP3zFuhot6y9Beg@mail.gmail.com
>> Fixes: 2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Good spotting!
>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 9b5b8951afb4..cceac517265f 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -878,23 +878,21 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>   	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
>>   	if (err1 != 0)
>>   		goto error;
>> +	if (es1 && !es1->es_len)
>> +		__es_free_extent(es1);
> I'd prefer if you also set es1 to NULL after freeing es1. Something like:
>
> 	/* Free preallocated extent if it didn't get used. */
> 	if (es1) {
> 		if (!es1->es_len)
> 			__es_free_extent(es1);
> 		es1 = NULL;
> 	}
>
> Currently I don't think there's a realistic case how we could trigger the
> retry loop after we've once decided to preallocate entries but it just
> makes the code more obvously correct. Similarly below for es2 and for the
> cases in ext4_es_insert_delayed_block(). Thanks!
>
> 								Honza
Indeed, the code looks more correct this way！
>>   
>>   	err2 = __es_insert_extent(inode, &newes, es2);
>>   	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
>>   		err2 = 0;
>>   	if (err2 != 0)
>>   		goto error;
>> +	if (es2 && !es2->es_len)
>> +		__es_free_extent(es2);
>>   
>>   	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
>>   	    (status & EXTENT_STATUS_WRITTEN ||
>>   	     status & EXTENT_STATUS_UNWRITTEN))
>>   		__revise_pending(inode, lblk, len);
>> -
>> -	/* es is pre-allocated but not used, free it. */
>> -	if (es1 && !es1->es_len)
>> -		__es_free_extent(es1);
>> -	if (es2 && !es2->es_len)
>> -		__es_free_extent(es2);
>>   error:
>>   	write_unlock(&EXT4_I(inode)->i_es_lock);
>>   	if (err1 || err2)
>> @@ -2047,19 +2045,17 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>>   	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
>>   	if (err1 != 0)
>>   		goto error;
>> +	if (es1 && !es1->es_len)
>> +		__es_free_extent(es1);
> The same
>
>>   
>>   	err2 = __es_insert_extent(inode, &newes, es2);
>>   	if (err2 != 0)
>>   		goto error;
>> +	if (es2 && !es2->es_len)
>> +		__es_free_extent(es2);
>>   
>>   	if (allocated)
>>   		__insert_pending(inode, lblk);
>> -
>> -	/* es is pre-allocated but not used, free it. */
>> -	if (es1 && !es1->es_len)
>> -		__es_free_extent(es1);
>> -	if (es2 && !es2->es_len)
>> -		__es_free_extent(es2);
>>   error:
>>   	write_unlock(&EXT4_I(inode)->i_es_lock);
>>   	if (err1 || err2)
>> -- 
>> 2.31.1
>>
Thank you very much for your review!
I will send a new version with your suggestions later!

-- 
With Best Regards,
Baokun Li
.
