Return-Path: <linux-ext4+bounces-1700-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074E880918
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C572850D2
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60B67490;
	Wed, 20 Mar 2024 01:31:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B55CA1;
	Wed, 20 Mar 2024 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898265; cv=none; b=uO35SoB5YVPVcbHsXW+qZiH+1olfI1cLtGDKr4l4Fbge9mvIiIx9xh+7z2+C2A9uFmrJvfRp9YieADETRj0kl9hMjZ8QEFaM1BZQMt/ZTkHKrSGoVae+XmJ5iX/C1K0GVEGkUDlCF9W9R6aLyDk3s2s8EVeo71/05JDpzEcu2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898265; c=relaxed/simple;
	bh=XHz5VCdXnffuaiojZ/VTmcVsvE3Ba/8f5VJSiyHrtkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YDQVN2/koXCy9k/w0xafKEYlYpbnAU3rTpPKiSuZd4X+KN4h2IdXwtrBeaflqGe7YMw0Er+MGOeUTUBkbAfa5n0aTFsbNtXK8y4Ewdm0jPJrCS0BtfPnO9jucBo9wRWzgYLtcxHqRjWz4Cjq+CLjP5RzJjlFwM7YLwP8Y4TXtwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TzrbQ3DpKz1xryQ;
	Wed, 20 Mar 2024 09:29:06 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id E40D01A016C;
	Wed, 20 Mar 2024 09:30:58 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 09:30:58 +0800
Message-ID: <340be7bb-c5e6-7140-5e19-cb63d44e6149@huawei.com>
Date: Wed, 20 Mar 2024 09:30:57 +0800
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
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <469c58c5-1095-cb9d-bd1d-514476e262e0@huawei.com>
 <ZfnYmzPIQfbtITPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZfnYmzPIQfbtITPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/20 2:25, Ojaswin Mujoo wrote:
> On Tue, Mar 19, 2024 at 06:05:53PM +0800, Baokun Li wrote:
>> On 2024/3/18 20:39, Ojaswin Mujoo wrote:
>>> On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>>>>       return 0;
>>>>     if (order == MB_NUM_ORDERS(sb))
>>>>       order--;
>>>> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
>>>> +   order = MB_NUM_ORDERS(sb) - 1;
>>> Hey Baokun,
>> Hi Ojaswin,
>>> Thanks for fixing this. This patch looks good to me, feel free to add:
>>>
>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Thanks for the review!
>>> my comments after this are less about the patch and more about some
>>> thoughts on the working of average fragment lists.
>>>
>>> So going through the v2 and this patch got me thinking about what really
>>> is going to happen when a user tries to allocate 32768 blocks which is also
>>> the maximum value we could have in say ac->ac_g_ex.fe_len.
>>>
>>> When this happens, ext4_mb_regular_allocator() will directly set the
>>> criteria as CR_GOAL_LEN_FAST. Now, we'll follow:
>>>
>>> ext4_mb_choose_next_group_goal_fast()
>>>     for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
>>>
>>> Here, mb_avg_fragment_siz_order() will do something like:
>>>
>>>     order = fls(32768) - 2 = 14
>>>     ...
>>>     if (order == MB_NUM_ORDERS(sb))
>>>       order--;
>>>
>>>     return order;
>>>
>>> And we'll look in the fragment list[13] and since none of the groups
>>> there would have 32768 blocks free (since we dont track it here) we'll
>>> unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
>>> (this will become a noop due to the way order and min_order
>>> are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
>>> something or end up splitting.
>> That's not quite right, in ext4_mb_choose_next_group_goal_fast() even
>> though we're looking for the group with order 13, the group with 32768
>> free blocks is also in there. So after passing ext4_mb_good_group() in
>> ext4_mb_find_good_group_avg_frag_lists(), we get a group with 32768
>> free blocks. And in ext4_mb_choose_next_group_best_avail() we were
> Hey Baokun,
>
> So IIUC, a BG with 32768 blocks free will have bb_fragments = 0 and in
> mb_update_avg_fragment_size() we exit early if a BG has bb_fragments = 0
> hence it won't show up in the order 13 list.
Hello Ojaswin,

This sounded strange, so I added the following debugging information:

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c65fac9b8c72..c6ec423e2971 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1212,6 +1212,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
                         i = mb_find_next_zero_bit(bitmap, max, i);
         }
         grp->bb_fragments = fragments;
+       pr_err(">>> greoup: %u, bb_free: %d, bb_fragments: %d\n", 
grp->bb_group, grp->bb_free, grp->bb_fragments);

         if (free != grp->bb_free) {
                 ext4_grp_locked_error(sb, group, 0, 0,


Then mount an ext4 image , wait for a moment , and got the
following printout:

 >>> greoup: 6, bb_free: 32768, bb_fragments: 1
 >>> greoup: 5, bb_free: 31741, bb_fragments: 1
 >>> greoup: 4, bb_free: 32768, bb_fragments: 1
 >>> greoup: 3, bb_free: 31741, bb_fragments: 1
 >>> greoup: 2, bb_free: 32768, bb_fragments: 1
 >>> greoup: 1, bb_free: 31741, bb_fragments: 1
 >>> greoup: 0, bb_free: 23511, bb_fragments: 1
>> supposed to allocate blocks quickly by trim order, so it's necessary
>> here too. So there are no unnecessary loops here.
>>
>> But this will trigger the freshly added WARN_ON_ONCE, so in the
>> new iteration I need to change it to:
>>
>> if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) + 1))
>>          order = MB_NUM_ORDERS(ac->ac_sb) - 1;
>>
>> In addition, when the block size is 4k, there are these limitations:
>>
>> 1) Limit the maximum size of the data allocation estimate to 8M in
>>      ext4_mb_normalize_request().
>> 2) #define MAX_WRITEPAGES_EXTENT_LEN 2048
>> 3) #define DIO_MAX_BLOCKS 4096
>> 4) Metadata is generally not allocated in many blocks at a time
>>
>> So it seems that only group_prealloc will allocate more than 2048
>> blocks at a time.
>>
>> And I've tried removing those 8M/2048/4096 limits before, but the
>> performance of DIO write barely changed, and it doesn't look like
>> the performance bottleneck is here in the number of blocks allocated
>> at a time at the moment.
> Ohh that's interesting, on paper I think it does seem like it should
> improve the performance. I think if CR_GOAL_LEN_FAST can start including
> blocks which are completely empty, and lift those restrictions then we
> might see better performance. I'll try to play around a bit with this as
> well.
>
> Regards,
> ojaswin
>
OK, waiting for your good news.

-- 
With Best Regards,
Baokun Li
.

