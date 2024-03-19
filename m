Return-Path: <linux-ext4+bounces-1685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE987FB6D
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5A1F2273A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E827D401;
	Tue, 19 Mar 2024 10:06:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53C53379;
	Tue, 19 Mar 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842765; cv=none; b=HskZrMZjnJUeE+6UObeYIpgODdW6KBmWD3Rx1akXQHJKplgQxOf6v7r+B5qg9/LyprzlTqJ1mWW1mJBQmIW0mdCctqSBROYad76HBvCTSQDYH41Ezwq1XStsVewdrvdsRn59ZJTxaM7lJWT5wCglF7pbwdz3fJJ4G8Frcqj6Rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842765; c=relaxed/simple;
	bh=EEy2lMXJzmH6TjIwVmbz71izRsffH2IfZXtYInV7Uh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J35QYFR+xD079B1exam+++oPetOnr8XWlZ1NjPcIKkDf2aIl6bGqdi7O3Tv/9wDReycNko6cI80xUs3gCo+6Vuu03SvNPRYevp2BH3puy9IsPHMqe7WFEJ8+oOTVNdFp1OapUZEJUTUtPN5iOiIUi35ql3rCrfNjfsFRrH88iWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzS5m1vYFz1HBhJ;
	Tue, 19 Mar 2024 18:05:32 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E79B1A0187;
	Tue, 19 Mar 2024 18:05:54 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 18:05:53 +0800
Message-ID: <469c58c5-1095-cb9d-bd1d-514476e262e0@huawei.com>
Date: Tue, 19 Mar 2024 18:05:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/18 20:39, Ojaswin Mujoo wrote:
> On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>>      return 0;
>>    if (order == MB_NUM_ORDERS(sb))
>>      order--;
>> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
>> +   order = MB_NUM_ORDERS(sb) - 1;
> Hey Baokun,
Hi Ojaswin,
>
> Thanks for fixing this. This patch looks good to me, feel free to add:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Thanks for the review!
> my comments after this are less about the patch and more about some
> thoughts on the working of average fragment lists.
>
> So going through the v2 and this patch got me thinking about what really
> is going to happen when a user tries to allocate 32768 blocks which is also
> the maximum value we could have in say ac->ac_g_ex.fe_len.
>
> When this happens, ext4_mb_regular_allocator() will directly set the
> criteria as CR_GOAL_LEN_FAST. Now, we'll follow:
>
> ext4_mb_choose_next_group_goal_fast()
>    for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
>
> Here, mb_avg_fragment_siz_order() will do something like:
>
>    order = fls(32768) - 2 = 14
>    ...
>    if (order == MB_NUM_ORDERS(sb))
>      order--;
>
>    return order;
>
> And we'll look in the fragment list[13] and since none of the groups
> there would have 32768 blocks free (since we dont track it here) we'll
> unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
> (this will become a noop due to the way order and min_order
> are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
> something or end up splitting.
That's not quite right, in ext4_mb_choose_next_group_goal_fast() even
though we're looking for the group with order 13, the group with 32768
free blocks is also in there. So after passing ext4_mb_good_group() in
ext4_mb_find_good_group_avg_frag_lists(), we get a group with 32768
free blocks. And in ext4_mb_choose_next_group_best_avail() we were
supposed to allocate blocks quickly by trim order, so it's necessary
here too. So there are no unnecessary loops here.

But this will trigger the freshly added WARN_ON_ONCE, so in the
new iteration I need to change it to:

if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) + 1))
         order = MB_NUM_ORDERS(ac->ac_sb) - 1;

In addition, when the block size is 4k, there are these limitations:

1) Limit the maximum size of the data allocation estimate to 8M in
     ext4_mb_normalize_request().
2) #define MAX_WRITEPAGES_EXTENT_LEN 2048
3) #define DIO_MAX_BLOCKS 4096
4) Metadata is generally not allocated in many blocks at a time

So it seems that only group_prealloc will allocate more than 2048
blocks at a time.

And I've tried removing those 8M/2048/4096 limits before, but the
performance of DIO write barely changed, and it doesn't look like
the performance bottleneck is here in the number of blocks allocated
at a time at the moment.

Thanks,
Baokun
> I think something more optimal would be to:
>
> 1. Add another entry to average fragment lists for completely empty
> groups. (As a sidenote i think we should use something like MB_NUM_FRAG_ORDER
> instead of MB_NUM_ORDERS in calculating limits related to average
> fragment lists since the NUM_ORDERS seems to be the buddy max order ie
> 8192 blocks only valid for CR_POWER2 and shouldn't really limit the
> fragment size lists)
>
> 2. If we don't want to go with 1 (maybe there's some history for that),
> then probably should exit early from CR_GOAL_LEN_FAST so that we don't
> iterate there.
>
> Would like to hear your thoughts on it Baokun, Jan.
>
> Regards,
> ojaswin
>

