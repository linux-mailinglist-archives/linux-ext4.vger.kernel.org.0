Return-Path: <linux-ext4+bounces-8697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B220AED311
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 05:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE417061F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883ED1DE4FF;
	Mon, 30 Jun 2025 03:48:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5761D61A3;
	Mon, 30 Jun 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255308; cv=none; b=Fvld9j3nCLQs+cDf93ZguATMhsFJiT8u3uR9nzfxRA+7hiPz6vC65KmxEj/USFO0V5ZWVFC7BEoc419AuQJnb9huKelqRHZ7BpE1cL3qZVoP7GaAMOCR/rcMTWHyOtgKAgxt7ElUKFN1md8DmjE199SCsYJziWwz4ng1Ne7wPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255308; c=relaxed/simple;
	bh=17QpAgJ4r9C/x9Pu2xFPaLnne8wZM8gBFobd40eyv0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WvS9xdeeR0v6k1qhN4GoOX6LH85K+0mK7ZBIPHtvo8cucYffY9Wxn+YpjHyF90WqxWeUbUfGdOEVdAxsNWuykJCQmkyuHu9OwWbztqDgSDBv1iCyX4eYgIuKL2d06cGpnteWocxxXCC6PK2gq78sdQSWYBtt8LWcRBQY1Ns1d/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bVsWl4zH3z13Md3;
	Mon, 30 Jun 2025 11:45:55 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 88788180064;
	Mon, 30 Jun 2025 11:48:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 11:48:21 +0800
Message-ID: <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
Date: Mon, 30 Jun 2025 11:48:20 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/28 2:19, Jan Kara wrote:
> On Mon 23-06-25 15:32:51, Baokun Li wrote:
>> After we optimized the block group lock, we found another lock
>> contention issue when running will-it-scale/fallocate2 with multiple
>> processes. The fallocate's block allocation and the truncate's block
>> release were fighting over the s_md_lock. The problem is, this lock
>> protects totally different things in those two processes: the list of
>> freed data blocks (s_freed_data_list) when releasing, and where to start
>> looking for new blocks (mb_last_group) when allocating.
>>
>> Now we only need to track s_mb_last_group and no longer need to track
>> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
>> two are consistent, and we can ensure that the s_mb_last_group read is up
>> to date by using smp_store_release/smp_load_acquire.
>>
>> Besides, the s_mb_last_group data type only requires ext4_group_t
>> (i.e., unsigned int), rendering unsigned long superfluous.
>>
>> Performance test data follows:
>>
>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>> Observation: Average fallocate operations per container per second.
>>
>>                     | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>>   Disk: 960GB SSD   |-------------------------|-------------------------|
>>                     | base  |    patched      | base  |    patched      |
>> -------------------|-------|-----------------|-------|-----------------|
>> mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
>> mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5cdae3bda072..3f103919868b 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>   	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>>   	folio_get(ac->ac_buddy_folio);
>>   	/* store last allocated for subsequent stream allocation */
>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		spin_lock(&sbi->s_md_lock);
>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>> -		spin_unlock(&sbi->s_md_lock);
>> -	}
>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>> +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
>> +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
> Do you really need any kind of barrier (implied by smp_store_release())
> here? I mean the store to s_mb_last_group is perfectly fine to be reordered
> with other accesses from the thread, isn't it? As such it should be enough
> to have WRITE_ONCE() here...

WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
that variable reads/writes access values directly from L1/L2 cache rather
than registers.

They do not guarantee that other CPUs see the latest values. Reading stale
values could lead to more useless traversals, which might incur higher
overhead than memory barriers. This is why we use memory barriers to ensure
the latest values are read.

If we could guarantee that each goal is used on only one CPU, we could
switch to the cheaper WRITE_ONCE()/READ_ONCE().


Regards,
Baokun

>>   	/*
>>   	 * As we've just preallocated more space than
>>   	 * user requested originally, we store allocated
>> @@ -2844,12 +2842,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   	}
>>   
>>   	/* if stream allocation is enabled, use global goal */
>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		/* TBD: may be hot point */
>> -		spin_lock(&sbi->s_md_lock);
>> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>> -		spin_unlock(&sbi->s_md_lock);
>> -	}
>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>> +		/* pairs with smp_store_release in ext4_mb_use_best_found() */
>> +		ac->ac_g_ex.fe_group = smp_load_acquire(&sbi->s_mb_last_group);
> ... and READ_ONCE() here.
>
> 								Honza



