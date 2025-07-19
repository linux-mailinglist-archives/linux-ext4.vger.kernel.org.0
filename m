Return-Path: <linux-ext4+bounces-9111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D2B0AD60
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D51B5A1015
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167312E1CD;
	Sat, 19 Jul 2025 01:54:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E345038;
	Sat, 19 Jul 2025 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752890088; cv=none; b=VacWkw9gufD/PVcojPq9rm4TnrJJsQLgjZd2FxD5nDSza5oaCsxi25K8aOB52iovxMPQUsINRNBSgua/MqHIc002qnmte7KWKG+jtcJMPL6tmW22q3xRBmSy9eZKOdCKBHQjYc5gx0sJFM3ZPtTkPuPo8lMJhGTOzQ1USmrZoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752890088; c=relaxed/simple;
	bh=C8hfgA5QmGnvg7jR+nJml5IjQLPv88RfEXFakkmic1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gf/zCYD50jXMs83HjGkCimi8R97Oo5vCKJSI6uhZ6Vy5GsvPI+lZsL8go7x7vymnkziUEjJMhHtoxoALL6sTQF12mfXknPrT7e2MUwqizPUcJUmSfWL5fYEIuB6whseN5w/bvIrA/BM1NBga67Ew/0IHRXHaci2AqJMgtox/ZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bkV631QY9z2RVsw;
	Sat, 19 Jul 2025 09:52:27 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EE172140297;
	Sat, 19 Jul 2025 09:54:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Jul
 2025 09:54:33 +0800
Message-ID: <61de582c-4000-45e7-afcf-3e00062a6682@huawei.com>
Date: Sat, 19 Jul 2025 09:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <julia.lawall@inria.fr>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-5-libaokun1@huawei.com>
 <aHj8WmfJvB3h6lOZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aHj8WmfJvB3h6lOZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/17 21:36, Ojaswin Mujoo wrote:
> On Mon, Jul 14, 2025 at 09:03:14PM +0800, Baokun Li wrote:
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
>> two are consistent. Since s_mb_last_group is merely a hint and doesn't
>> require strong synchronization, READ_ONCE/WRITE_ONCE is sufficient.
> Hi Baokun,
>
> So i just got curious of the difference between smp_load_acquire vs
> READ_ONCE on PowerPC, another weak memory ordering arch.
> Interestingly, I didn't see that big of a single threaded drop.
>
> The number are as follows (mb_opt_scan=1):
>
> 100 threads
> w/ smp_load_acquire    1668 MB/s
> w/ READ_ONCE           1599 MB/s
>
> 1 thread pinned to 1 cpu
> w/ smp_load_acquire    292 MB/s
> w/ READ_ONCE           296 MB/s
>
> Either ways, this is much better than the base which is around 500MB/s
> but just thought I'd share it here

Thank you for providing the test data for PowerPC, it is true that
the results may vary slightly between architectures.

>
> Feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
Thank you for you review!

Cheers,
Baokun

>> Besides, the s_mb_last_group data type only requires ext4_group_t
>> (i.e., unsigned int), rendering unsigned long superfluous.
>>
>> Performance test data follows:
>>
>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>> Observation: Average fallocate operations per container per second.
>>
>> |CPU: Kunpeng 920   |          P80           |            P1           |
>> |Memory: 512GB      |------------------------|-------------------------|
>> |960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
>> |-------------------|-------|----------------|--------|----------------|
>> |mb_optimize_scan=0 | 4821  | 9636  (+99.8%) | 314065 | 337597 (+7.4%) |
>> |mb_optimize_scan=1 | 4784  | 4834  (+1.04%) | 316344 | 341440 (+7.9%) |
>>
>> |CPU: AMD 9654 * 2  |          P96           |             P1          |
>> |Memory: 1536GB     |------------------------|-------------------------|
>> |960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
>> |-------------------|-------|----------------|--------|----------------|
>> |mb_optimize_scan=0 | 15371 | 22341 (+45.3%) | 205851 | 219707 (+6.7%) |
>> |mb_optimize_scan=1 | 6101  | 9177  (+50.4%) | 207373 | 215732 (+4.0%) |
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/ext4.h    |  2 +-
>>   fs/ext4/mballoc.c | 12 +++---------
>>   2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index b83095541c98..7f5c070de0fb 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1630,7 +1630,7 @@ struct ext4_sb_info {
>>   	unsigned int s_mb_group_prealloc;
>>   	unsigned int s_max_dir_size_kb;
>>   	/* where last allocation was done - for stream allocation */
>> -	unsigned long s_mb_last_group;
>> +	ext4_group_t s_mb_last_group;
>>   	unsigned int s_mb_prefetch;
>>   	unsigned int s_mb_prefetch_limit;
>>   	unsigned int s_mb_best_avail_max_trim_order;
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e3a5103e1620..025b759ca643 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2168,11 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>   	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>>   	folio_get(ac->ac_buddy_folio);
>>   	/* store last allocated for subsequent stream allocation */
>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		spin_lock(&sbi->s_md_lock);
>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>> -		spin_unlock(&sbi->s_md_lock);
>> -	}
>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>> +		WRITE_ONCE(sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
>>   	/*
>>   	 * As we've just preallocated more space than
>>   	 * user requested originally, we store allocated
>> @@ -2845,10 +2842,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   
>>   	/* if stream allocation is enabled, use global goal */
>>   	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		/* TBD: may be hot point */
>> -		spin_lock(&sbi->s_md_lock);
>> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>> -		spin_unlock(&sbi->s_md_lock);
>> +		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_group);
>>   		ac->ac_g_ex.fe_start = -1;
>>   		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
>>   	}
>> -- 
>> 2.46.1
>>

