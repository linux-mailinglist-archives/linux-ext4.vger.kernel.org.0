Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BB6EC423
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDXDp0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXDpZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:45:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609EC123;
        Sun, 23 Apr 2023 20:45:24 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q4WC04rGHznf7m;
        Mon, 24 Apr 2023 11:41:32 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 11:45:22 +0800
Message-ID: <ffed2428-7016-1431-eaea-14ac28541988@huawei.com>
Date:   Mon, 24 Apr 2023 11:45:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v3 3/8] ext4: use __GFP_NOFAIL if allocating
 extents_status cannot fail
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-4-libaokun1@huawei.com>
 <20230413103004.a4hjlxgpfqnhcgtg@quack3>
Content-Language: en-US
In-Reply-To: <20230413103004.a4hjlxgpfqnhcgtg@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/13 18:30, Jan Kara wrote:
> On Wed 12-04-23 20:41:21, Baokun Li wrote:
>> If extent status tree update fails, we have inconsistency between what is
>> stored in the extent status tree and what is stored on disk. And that can
>> cause even data corruption issues in some cases.
>>
>> For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
>> And with the above logic, the undo operation in __es_remove_extent that
>> may cause inconsistency if the split extent fails is unnecessary, so we
>> remove it as well.
>>
>> Suggested-by: Jan Kara<jack@suse.cz>
>> Signed-off-by: Baokun Li<libaokun1@huawei.com>
> When I was looking through this patch, I've realized there's a problem with
> my plan :-|. See below...
>
>>   static struct extent_status *
>>   ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>> -		     ext4_fsblk_t pblk)
>> +		     ext4_fsblk_t pblk, int nofail)
>>   {
>>   	struct extent_status *es;
>> -	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
>> +	gfp_t gfp_flags = GFP_ATOMIC;
>> +
>> +	if (nofail)
>> +		gfp_flags |= __GFP_NOFAIL;
>> +
>> +	es = kmem_cache_alloc(ext4_es_cachep, gfp_flags);
>>   	if (es == NULL)
>>   		return NULL;
> I have remembered that the combination of GFP_ATOMIC and GFP_NOFAIL is
> discouraged because the kernel has no sane way of refilling reserves for
> atomic allocations when in atomic context. So this combination can result
> in lockups.

Indeed. GFP_NOFAIL is only applicable to sleepable allocations,

GFP_ATOMIC will ignore it. I didn't notice that.

> So what I think we'll have to do is that we'll just have to return error
> from __es_insert_extent() and __es_remove_extent() and in the callers we
> drop the i_es_lock, allocate needed status entries (one or two depending on
> the desired operation) with GFP_KERNEL | GFP_NOFAIL, get the lock again and
> pass the preallocated entries into __es_insert_extent /
> __es_remove_extent(). It's a bit ugly but we can at least remove those
> __es_shrink() calls which are not pretty either.
>
> 								Honza

Yes, there's really no better way, thank you very much for your review!
I've sent a patch for v4 as you suggested.
Thanks again!

-- 
With Best Regards,
Baokun Li
.
