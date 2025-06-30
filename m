Return-Path: <linux-ext4+bounces-8706-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E1AED892
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEECA3B177E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD7242930;
	Mon, 30 Jun 2025 09:21:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399E23F41A;
	Mon, 30 Jun 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275317; cv=none; b=sXXQHnhtVrtc/P7OocKWj9V9xsYSMX5BC2OkvrmMyJRIrNFHBwxg3IOUwDousSqLfHxUn2RUvvUipqwtNsODHSabBP07oftUFiXvVQHT06FAXu/rZZj8Coblr5mJcBvYOBdtx2in4gmHf1rRRg3jJR8MEmnFH9Tm20MPzv72fe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275317; c=relaxed/simple;
	bh=FvmMuITo9Ro24oRzUmSRrTyhE6Wm3EK03DVTU2JrtuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DkjCL+qqyfnZNyoOFAijgwXeuQlSupyW4yz3kjVxd2q4ixcfHgO/KqkgVSG6xO+c/IqNxUaYs7M2h0FegmuaxfvW3SrN4ZOHLcyywLhNAU58uyaews4mbENx0eeqna+31IaeBLciE/P8oAQGA5VlBDu2r8LPdm4iGW98JXDdLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW0sy6srBz14LpZ;
	Mon, 30 Jun 2025 17:17:10 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 88C3E180493;
	Mon, 30 Jun 2025 17:21:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 17:21:49 +0800
Message-ID: <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
Date: Mon, 30 Jun 2025 17:21:48 +0800
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
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/30 15:47, Jan Kara wrote:
> On Mon 30-06-25 11:48:20, Baokun Li wrote:
>> On 2025/6/28 2:19, Jan Kara wrote:
>>> On Mon 23-06-25 15:32:51, Baokun Li wrote:
>>>> After we optimized the block group lock, we found another lock
>>>> contention issue when running will-it-scale/fallocate2 with multiple
>>>> processes. The fallocate's block allocation and the truncate's block
>>>> release were fighting over the s_md_lock. The problem is, this lock
>>>> protects totally different things in those two processes: the list of
>>>> freed data blocks (s_freed_data_list) when releasing, and where to start
>>>> looking for new blocks (mb_last_group) when allocating.
>>>>
>>>> Now we only need to track s_mb_last_group and no longer need to track
>>>> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
>>>> two are consistent, and we can ensure that the s_mb_last_group read is up
>>>> to date by using smp_store_release/smp_load_acquire.
>>>>
>>>> Besides, the s_mb_last_group data type only requires ext4_group_t
>>>> (i.e., unsigned int), rendering unsigned long superfluous.
>>>>
>>>> Performance test data follows:
>>>>
>>>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>>>> Observation: Average fallocate operations per container per second.
>>>>
>>>>                      | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>>>>    Disk: 960GB SSD   |-------------------------|-------------------------|
>>>>                      | base  |    patched      | base  |    patched      |
>>>> -------------------|-------|-----------------|-------|-----------------|
>>>> mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
>>>> mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ...
>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index 5cdae3bda072..3f103919868b 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>>>    	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>>>>    	folio_get(ac->ac_buddy_folio);
>>>>    	/* store last allocated for subsequent stream allocation */
>>>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>>>> -		spin_lock(&sbi->s_md_lock);
>>>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>>>> -		spin_unlock(&sbi->s_md_lock);
>>>> -	}
>>>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>>>> +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
>>>> +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
>>> Do you really need any kind of barrier (implied by smp_store_release())
>>> here? I mean the store to s_mb_last_group is perfectly fine to be reordered
>>> with other accesses from the thread, isn't it? As such it should be enough
>>> to have WRITE_ONCE() here...
>> WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
>> that variable reads/writes access values directly from L1/L2 cache rather
>> than registers.
> I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
> particular they force the compiler to read / write the memory location
> exactly once instead of reading it potentially multiple times in different
> parts of expression and getting inconsistent values, or possibly writing
> the value say byte by byte (yes, that would be insane but not contrary to
> the C standard).
READ_ONCE() and WRITE_ONCE() rely on the volatile keyword, which serves
two main purposes:

1. It tells the compiler that the variable's value can change unexpectedly,
    preventing the compiler from making incorrect optimizations based on
    assumptions about its stability.

2. It ensures the CPU directly reads from or writes to the variable's
    memory address. This means the value will be fetched from cache (L1/L2)
    if available, or from main memory otherwise, rather than using a stale
    value from a CPU register.
>> They do not guarantee that other CPUs see the latest values. Reading stale
>> values could lead to more useless traversals, which might incur higher
>> overhead than memory barriers. This is why we use memory barriers to ensure
>> the latest values are read.
> But smp_load_acquire() / smp_store_release() have no guarantee about CPU
> seeing latest values either. They are just speculation barriers meaning
> they prevent the CPU from reordering accesses in the code after
> smp_load_acquire() to be performed before the smp_load_acquire() is
> executed and similarly with smp_store_release(). So I dare to say that
> these barries have no (positive) impact on the allocation performance and
> just complicate the code - but if you have some data that show otherwise,
> I'd be happy to be proven wrong.
smp_load_acquire() / smp_store_release() guarantee that CPUs read the
latest data.

For example, imagine a variable a = 0, with both CPU0 and CPU1 having
a=0 in their caches.

Without a memory barrier:
When CPU0 executes WRITE_ONCE(a, 1), a=1 is written to the store buffer,
an RFO is broadcast, and CPU0 continues other tasks. After receiving ACKs,
a=1 is written to main memory and becomes visible to other CPUs.
Then, if CPU1 executes READ_ONCE(a), it receives the RFO and adds it to
its invalidation queue. However, it might not process it immediately;
instead, it could perform the read first, potentially still reading a=0
from its cache.

With a memory barrier:
When CPU0 executes smp_store_release(&a, 1), a=1 is not only written to
the store buffer, but data in the store buffer is also written to main
memory. An RFO is then broadcast, and CPU0 waits for ACKs from all CPUs.

When CPU1 executes smp_load_acquire(a), it receives the RFO and adds it
to its invalidation queue. Here, the invalidation queue is flushed, which
invalidates a in CPU1's cache. CPU1 then replies with an ACK, and when it
performs the read, its cache is invalid, so it reads the latest a=1 from
main memory.

This is a general overview. Please let me know if I've missed anything.


Thanks,
Baokun


