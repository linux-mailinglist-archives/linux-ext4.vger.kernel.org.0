Return-Path: <linux-ext4+bounces-8247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6ACAC89DA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5171BA4E41
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CF21516E;
	Fri, 30 May 2025 08:20:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336042116F5;
	Fri, 30 May 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748593251; cv=none; b=BL4YFlNLjpdz2+c5YDGAv1ciTU4l/5yUJUsU+rt/6JaEQgoh6MjjaOwxVz8nQ2Gqx1U77+FOwqA+AIneGgqOn9AJkOXZ0qhhmskY+9YZ2IHdXgElXxqgUCNsz//6U1jkNmlGJD0Ph61iPWr4VwDgkz2SchLojAR9InWfBmgf0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748593251; c=relaxed/simple;
	bh=Ucz1ygW9HG1Og2peBspr33vdjTpvWXFaRtJTMZFth+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ROCqcKzM3jRKvLEmBmrDZS+h5g5YFuYsbaqOEkH6LrotzMsCT5d+4KdqxjzRrOlIY3bHCoEuFmM5X0W6hMFoeu3qYIyVmrT1ZqkWiZgP2kzpjV3laimwEKuRcFZ2QodAhMjNFiegVBaOYIlt2CkQ5OkRBlNZmjpy0XB3wCOYDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4b7x3y0mjpz23jTN;
	Fri, 30 May 2025 16:19:42 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 77A591A016C;
	Fri, 30 May 2025 16:20:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 16:20:44 +0800
Message-ID: <d5d840c5-d030-48de-84df-3891f498cfc7@huawei.com>
Date: Fri, 30 May 2025 16:20:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ext4: add ext4_try_lock_group() to skip busy groups
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-2-libaokun@huaweicloud.com>
 <aDcmRdOrWatcBJWc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aDcmRdOrWatcBJWc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/28 23:05, Ojaswin Mujoo wrote:
> On Fri, May 23, 2025 at 04:58:18PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> When ext4 allocates blocks, we used to just go through the block groups
>> one by one to find a good one. But when there are tons of block groups
>> (like hundreds of thousands or even millions) and not many have free space
>> (meaning they're mostly full), it takes a really long time to check them
>> all, and performance gets bad. So, we added the "mb_optimize_scan" mount
>> option (which is on by default now). It keeps track of some group lists,
>> so when we need a free block, we can just grab a likely group from the
>> right list. This saves time and makes block allocation much faster.
>>
>> But when multiple processes or containers are doing similar things, like
>> constantly allocating 8k blocks, they all try to use the same block group
>> in the same list. Even just two processes doing this can cut the IOPS in
>> half. For example, one container might do 300,000 IOPS, but if you run two
>> at the same time, the total is only 150,000.
>>
>> Since we can already look at block groups in a non-linear way, the first
>> and last groups in the same list are basically the same for finding a block
>> right now. Therefore, add an ext4_try_lock_group() helper function to skip
>> the current group when it is locked by another process, thereby avoiding
>> contention with other processes. This helps ext4 make better use of having
>> multiple block groups.
>>
>> Also, to make sure we don't skip all the groups that have free space
>> when allocating blocks, we won't try to skip busy groups anymore when
>> ac_criteria is CR_ANY_FREE.
>>
>> Performance test data follows:
>>
>> CPU: HUAWEI Kunpeng 920
>> Memory: 480GB
>> Disk: 480GB SSD SATA 3.2
>> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
>> Observation: Average fallocate operations per container per second.
>>
>>                        base    patched
>> mb_optimize_scan=0    3588    6755 (+88.2%)
>> mb_optimize_scan=1    3588    4302 (+19.8%)
> The patch looks mostly good. Same observations about mb_optimize_scan=1
> improving less. We can continue this discussion in my reply to the cover
> letter. That being said, I have some minor suggestions:
Thanks for the review!
>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/ext4.h    | 23 ++++++++++++++---------
>>   fs/ext4/mballoc.c | 14 +++++++++++---
>>   2 files changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 5a20e9cd7184..9c665a620a46 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3494,23 +3494,28 @@ static inline int ext4_fs_is_busy(struct ext4_sb_info *sbi)
>>   	return (atomic_read(&sbi->s_lock_busy) > EXT4_CONTENTION_THRESHOLD);
>>   }
>>   
>> +static inline bool ext4_try_lock_group(struct super_block *sb, ext4_group_t group)
>> +{
>> +	if (!spin_trylock(ext4_group_lock_ptr(sb, group)))
>> +		return false;
>> +	/*
>> +	 * We're able to grab the lock right away, so drop the lock
>> +	 * contention counter.
>> +	 */
>> +	atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
>> +	return true;
>> +}
>> +
>>   static inline void ext4_lock_group(struct super_block *sb, ext4_group_t group)
>>   {
>> -	spinlock_t *lock = ext4_group_lock_ptr(sb, group);
>> -	if (spin_trylock(lock))
>> -		/*
>> -		 * We're able to grab the lock right away, so drop the
>> -		 * lock contention counter.
>> -		 */
>> -		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
>> -	else {
>> +	if (!ext4_try_lock_group(sb, group)) {
>>   		/*
>>   		 * The lock is busy, so bump the contention counter,
>>   		 * and then wait on the spin lock.
>>   		 */
>>   		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, 1,
>>   				  EXT4_MAX_CONTENTION);
>> -		spin_lock(lock);
>> +		spin_lock(ext4_group_lock_ptr(sb, group));
>>   	}
>>   }
>>   
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 1e98c5be4e0a..5c13d9f8a1cc 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -896,7 +896,8 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
>>   				    bb_largest_free_order_node) {
>>   			if (sbi->s_mb_stats)
>>   				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
>> -			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
>> +			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED)) &&
>> +			    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
> Maybe reversing the && order to be (!spin_is_locked() && ext4_mb_good_group()) would be better?
Yeah.
>>   				*group = iter->bb_group;
>>   				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
>>   				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
>> @@ -932,7 +933,8 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
>>   	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
>>   		if (sbi->s_mb_stats)
>>   			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
>> -		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
>> +		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr)) &&
>> +		    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {
> same as above
Okay.
>   
>>   			grp = iter;
>>   			break;
>>   		}
>> @@ -2911,7 +2913,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   			if (err)
>>   				goto out;
>>   
>> -			ext4_lock_group(sb, group);
>> +			/* skip busy group */
>> +			if (cr >= CR_ANY_FREE) {
>> +				ext4_lock_group(sb, group);
>> +			} else if (!ext4_try_lock_group(sb, group)) {
>> +				ext4_mb_unload_buddy(&e4b);
>> +				continue;
>> +			}
> This in itself looks good. I am just thinking that now that we are
> deciding to skip locked groups, in the code above this one, shall we do
> something like:
>
>        
>        if (spin_is_locked(group_lock))
>          continue;
>        
>        err = ext4_mb_load_buddy(sb, group, &e4b);
>        if (err)
>          goto out;
>
>        /* skip busy group */
>        if (cr >= CR_ANY_FREE) {
>          ext4_lock_group(sb, group);
>        } else if (!ext4_try_lock_group(sb, group)) {
>          ext4_mb_unload_buddy(&e4b);
>          continue;
>        }
>
> With this we can even avoid loading the folio as well.
I previously assumed that for busy groups, the buddy was already loaded,
so reloading it would incur minimal overhead. However, I was mistaken.

After implementing a change, the proportion of time spent in
ext4_mb_load_buddy() decreased from 3.6% to 1.7%, resulting in
approximately a 2% performance improvement.

Thank you for your suggestion！
I will prevent unnecessary buddy loading in the next version.

Cheers,
Baokun


