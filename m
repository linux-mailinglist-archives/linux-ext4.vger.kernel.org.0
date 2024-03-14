Return-Path: <linux-ext4+bounces-1632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3387BBDF
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 12:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0289828414C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FB6EB69;
	Thu, 14 Mar 2024 11:25:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D916EB5C;
	Thu, 14 Mar 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415502; cv=none; b=GdI0bNDXks6SdbSHnKodZBBUHSDQNYN7c7E3HFmEfFbtLsi6OJHbOVGK486rO7fA9RYsLKdVFdO4+zJg63XseEfrA6vimPh6gDUO8I9pVbLB9hvUs6SQKiiA8QjRZXoYq54Ijg5F2o30MDUPMRfs3ZhkvQJsdmyHdXQy8U/QvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415502; c=relaxed/simple;
	bh=dRotbT0kJtqO9wQLyoxla3srawYljMDh+1EQIZUfVDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HUue4l/ayEv6OYflYejoI8tlywYs/7Zi1r6RNtR/OPCzvr/y50Zezw8CoSHKMcxELY6klQcp4pnAornjAMbLj+nzeXJhXoEJoqB6h2sV1DrGFafE8Br868uXaY7omV/AuZLOx/V9A4P5HnLBoukvgp8OnmWmE9Op/k8NCZmAfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TwQ3f6tqGz1xqxw;
	Thu, 14 Mar 2024 19:23:10 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DAC41A0187;
	Thu, 14 Mar 2024 19:24:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 19:24:56 +0800
Message-ID: <50f9333b-831a-8b4b-a6f2-ae79ab46a88b@huawei.com>
Date: Thu, 14 Mar 2024 19:24:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-5-libaokun1@huawei.com>
 <20240314103056.rykwi2hhfm7v575a@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240314103056.rykwi2hhfm7v575a@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hi Jan,

On 2024/3/14 18:30, Jan Kara wrote:
> On Tue 27-02-24 17:11:43, Baokun Li wrote:
>
>
> At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> to be triggered by an attempt to access an element at index 29.
>
> Add a new attr_id attr_clusters_in_group with values in the range
> [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> that type to fix the issue. In addition avoid returning an order
> from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> and reduce some useless loops.
>
> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good. Just one nit below. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> ---
>>   fs/ext4/mballoc.c |  6 ++++++
>>   fs/ext4/sysfs.c   | 13 ++++++++++++-
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 85a91a61b761..7ad089df2408 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>>   		return 0;
>>   	if (order == MB_NUM_ORDERS(sb))
>>   		order--;
>> +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
>> +		order = MB_NUM_ORDERS(sb) - 1;
>>   	return order;
>>   }
>>   
>> @@ -1057,6 +1059,10 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>>   			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
>>   			return;
>>   		}
>> +
>> +		/* Skip some unnecessary loops. */
>> +		if (unlikely(i > MB_NUM_ORDERS(ac->ac_sb)))
>> +			i = MB_NUM_ORDERS(ac->ac_sb);
> How can this possibly trigger now? MB_NUM_ORDERS is sb->s_blocksize_bits +
> 2. 'i' is starting at fls(ac->ac_g_ex.fe_len) and ac_g_ex.fe_len shouldn't
> be larger than clusters per group, hence fls() should be less than
> sb->s_blocksize_bits? Am I missing something? And if yes, we should rather
> make sure 'order' is never absurdly big?
>
> I suspect this code is defensive upto a point of being confusing :)
>
> Honza 

Yes, this is indeed defensive code! Only walk into this branch when
WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)) is triggered.
As previously mentioned by ojaswin in the following link:

"The reason for this is that otherwise when order is large eg 29,
we would unnecessarily loop from i=29 to i=13 while always
looking at the same avg_fragment_list[13]."

Link：https://lore.kernel.org/lkml/ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/

Thank you so much for the review! ღ( ´･ᴗ･` )
-- 
With Best Regards,
Baokun Li
.

