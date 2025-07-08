Return-Path: <linux-ext4+bounces-8891-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE28AFCB7A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B22175CDA
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17D2E041C;
	Tue,  8 Jul 2025 13:08:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745C2DECC0;
	Tue,  8 Jul 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980087; cv=none; b=h0e49g2/6nHvnMgDglvIrgDr4IwiCFgKvyRhEr3YDVNgqlqoMWoOy+tRLpsCYATshIPXLyPBTvfGDkqc1qY3YCVje9Uea7rk75AHrWFue1S6HEkwNk4JgZyOuCH/xUx4ATOH/gTHdFVfSnPRt+zWtp/co9fXPF1ww8qzjeoiNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980087; c=relaxed/simple;
	bh=2uaD/VD++TV7hISLF6YeACqov0K0HpHORMz+xCIZ9vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fqJSbqTYViXsD4wyQco6nmYI3tUOymCHAO7GSolbN2bvhwnBAXA5TnJHWQtxjsmlpuur6eqAXUJff48YGCQYq3u3oBsxPf90lnM8r4Igb3xmc1bPoKilZDBiDTMD4SaHFhOhGDOyGOH5u/Fr1EIoc9sfZ6KruDP61Ma47b/Q+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bc1WC0xkLz14LrH;
	Tue,  8 Jul 2025 21:03:19 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 607DD140276;
	Tue,  8 Jul 2025 21:08:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Jul
 2025 21:08:01 +0800
Message-ID: <9ecfe98f-b9d5-478a-b2a5-437b452dbd58@huawei.com>
Date: Tue, 8 Jul 2025 21:08:00 +0800
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
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
 <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
 <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/1 20:21, Jan Kara wrote:
> On Tue 01-07-25 10:39:53, Baokun Li wrote:
>> On 2025/7/1 0:32, Jan Kara wrote:
>>> On Mon 30-06-25 17:21:48, Baokun Li wrote:
>>>> On 2025/6/30 15:47, Jan Kara wrote:
>>>>> On Mon 30-06-25 11:48:20, Baokun Li wrote:
>>>>>> On 2025/6/28 2:19, Jan Kara wrote:
>>>>>>> On Mon 23-06-25 15:32:51, Baokun Li wrote:
>>>>>>>> After we optimized the block group lock, we found another lock
>>>>>>>> contention issue when running will-it-scale/fallocate2 with multiple
>>>>>>>> processes. The fallocate's block allocation and the truncate's block
>>>>>>>> release were fighting over the s_md_lock. The problem is, this lock
>>>>>>>> protects totally different things in those two processes: the list of
>>>>>>>> freed data blocks (s_freed_data_list) when releasing, and where to start
>>>>>>>> looking for new blocks (mb_last_group) when allocating.
>>>>>>>>
>>>>>>>> Now we only need to track s_mb_last_group and no longer need to track
>>>>>>>> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
>>>>>>>> two are consistent, and we can ensure that the s_mb_last_group read is up
>>>>>>>> to date by using smp_store_release/smp_load_acquire.
>>>>>>>>
>>>>>>>> Besides, the s_mb_last_group data type only requires ext4_group_t
>>>>>>>> (i.e., unsigned int), rendering unsigned long superfluous.
>>>>>>>>
>>>>>>>> Performance test data follows:
>>>>>>>>
>>>>>>>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>>>>>>>> Observation: Average fallocate operations per container per second.
>>>>>>>>
>>>>>>>>                        | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>>>>>>>>      Disk: 960GB SSD   |-------------------------|-------------------------|
>>>>>>>>                        | base  |    patched      | base  |    patched      |
>>>>>>>> -------------------|-------|-----------------|-------|-----------------|
>>>>>>>> mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
>>>>>>>> mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
>>>>>>>>
>>>>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>>>> ...
>>>>>>>
>>>>>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>>>>>> index 5cdae3bda072..3f103919868b 100644
>>>>>>>> --- a/fs/ext4/mballoc.c
>>>>>>>> +++ b/fs/ext4/mballoc.c
>>>>>>>> @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>>>>>>>      	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>>>>>>>>      	folio_get(ac->ac_buddy_folio);
>>>>>>>>      	/* store last allocated for subsequent stream allocation */
>>>>>>>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>>>>>>>> -		spin_lock(&sbi->s_md_lock);
>>>>>>>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>>>>>>>> -		spin_unlock(&sbi->s_md_lock);
>>>>>>>> -	}
>>>>>>>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>>>>>>>> +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
>>>>>>>> +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
>>>>>>> Do you really need any kind of barrier (implied by smp_store_release())
>>>>>>> here? I mean the store to s_mb_last_group is perfectly fine to be reordered
>>>>>>> with other accesses from the thread, isn't it? As such it should be enough
>>>>>>> to have WRITE_ONCE() here...
>>>>>> WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
>>>>>> that variable reads/writes access values directly from L1/L2 cache rather
>>>>>> than registers.
>>>>> I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
>>>>> particular they force the compiler to read / write the memory location
>>>>> exactly once instead of reading it potentially multiple times in different
>>>>> parts of expression and getting inconsistent values, or possibly writing
>>>>> the value say byte by byte (yes, that would be insane but not contrary to
>>>>> the C standard).
>>>> READ_ONCE() and WRITE_ONCE() rely on the volatile keyword, which serves
>>>> two main purposes:
>>>>
>>>> 1. It tells the compiler that the variable's value can change unexpectedly,
>>>>      preventing the compiler from making incorrect optimizations based on
>>>>      assumptions about its stability.
>>>>
>>>> 2. It ensures the CPU directly reads from or writes to the variable's
>>>>      memory address. This means the value will be fetched from cache (L1/L2)
>>>>      if available, or from main memory otherwise, rather than using a stale
>>>>      value from a CPU register.
>>> Yes, we agree on this.
>>>
>>>>>> They do not guarantee that other CPUs see the latest values. Reading stale
>>>>>> values could lead to more useless traversals, which might incur higher
>>>>>> overhead than memory barriers. This is why we use memory barriers to ensure
>>>>>> the latest values are read.
>>>>> But smp_load_acquire() / smp_store_release() have no guarantee about CPU
>>>>> seeing latest values either. They are just speculation barriers meaning
>>>>> they prevent the CPU from reordering accesses in the code after
>>>>> smp_load_acquire() to be performed before the smp_load_acquire() is
>>>>> executed and similarly with smp_store_release(). So I dare to say that
>>>>> these barries have no (positive) impact on the allocation performance and
>>>>> just complicate the code - but if you have some data that show otherwise,
>>>>> I'd be happy to be proven wrong.
>>>> smp_load_acquire() / smp_store_release() guarantee that CPUs read the
>>>> latest data.
>>>>
>>>> For example, imagine a variable a = 0, with both CPU0 and CPU1 having
>>>> a=0 in their caches.
>>>>
>>>> Without a memory barrier:
>>>> When CPU0 executes WRITE_ONCE(a, 1), a=1 is written to the store buffer,
>>>> an RFO is broadcast, and CPU0 continues other tasks. After receiving ACKs,
>>>> a=1 is written to main memory and becomes visible to other CPUs.
>>>> Then, if CPU1 executes READ_ONCE(a), it receives the RFO and adds it to
>>>> its invalidation queue. However, it might not process it immediately;
>>>> instead, it could perform the read first, potentially still reading a=0
>>>> from its cache.
>>>>
>>>> With a memory barrier:
>>>> When CPU0 executes smp_store_release(&a, 1), a=1 is not only written to
>>>> the store buffer, but data in the store buffer is also written to main
>>>> memory. An RFO is then broadcast, and CPU0 waits for ACKs from all CPUs.
>>>>
>>>> When CPU1 executes smp_load_acquire(a), it receives the RFO and adds it
>>>> to its invalidation queue. Here, the invalidation queue is flushed, which
>>>> invalidates a in CPU1's cache. CPU1 then replies with an ACK, and when it
>>>> performs the read, its cache is invalid, so it reads the latest a=1 from
>>>> main memory.
>>> Well, here I think you assume way more about the CPU architecture than is
>>> generally true (and I didn't find what you write above guaranteed neither
>>> by x86 nor by arm64 CPU documentation). Generally I'm following the
>>> guarantees as defined by Documentation/memory-barriers.txt and there you
>>> can argue only about order of effects as observed by different CPUs but not
>>> really about when content is fetched to / from CPU caches.
>> Explaining why smp_load_acquire() and smp_store_release() guarantee the
>> latest data is read truly requires delving into their underlying
>> implementation details.
>>
>> I suggest you Google "why memory barriers are needed." You might find
>> introductions to concepts like 'Total Store Order', 'Weak Memory Ordering',
>> MESI, store buffers, and invalidate queue, along with the stories behind
>> them.
> Yes, I know these things. Not that I'd be really an expert in them but I'd
> call myself familiar enough :). But that is kind of besides the point here.
> What I want to point out it that if you have code like:
>
>    some access A
>    grp = smp_load_acquire(&sbi->s_mb_last_group)
>    some more accesses
>
> then the CPU is fully within it's right to execute them as:
>
>    grp = smp_load_acquire(&sbi->s_mb_last_group)
>    some access A
>    some more accesses
>
> Now your *particular implementation* of the ARM64 CPU model may never do
> that similarly as no x86 CPU currently does it but some other CPU
> implementation may (e.g. Alpha CPU probably would, as much as that's
> irrevelent these days :). So using smp_load_acquire() is at best a
> heuristics that may happen to help using more fresh value for some CPU
> models but it isn't guaranteed to help for all architectures and all CPU
> models Linux supports.
>
> So can you do me a favor please and do a performance comparison of using
> READ_ONCE / WRITE_ONCE vs using smp_load_acquire / smp_store_release on
> your Arm64 server for streaming goal management? If smp_load_acquire /
> smp_store_release indeed bring any performance benefit for your servers, we
> can just stick a comment there explaining why they are used. If they bring
> no measurable benefit I'd put READ_ONCE / WRITE_ONCE there for code
> simplicity. Do you agree?
>
> 								Honza

Sorry for getting to this so late – I've been totally overloaded
with stuff recently.

Anyway, back to what we were discussing. I managed to test
the performance difference between READ_ONCE / WRITE_ONCE and
smp_load_acquire / smp_store_release on an ARM64 server.
Here's the results:

CPU: Kunpeng 920
Memory: 512GB
Disk: 960GB SSD (~500M/s)

         | mb_optimize_scan  |       0        |       1        |
         |-------------------|----------------|----------------|
         | Num. containers   |  P80  |   P1   |  P80  |   P1   |
--------|-------------------|-------|--------|-------|--------|
         | acquire/release   | 9899  | 290260 | 5005  | 307361 |
  single | [READ|WRITE]_ONCE | 9636  | 337597 | 4834  | 341440 |
  goal   |-------------------|-------|--------|-------|--------|
         |                   | -2.6% | +16.3% | -3.4% | +11.0% |
--------|-------------------|-------|--------|-------|--------|
         | acquire/release   | 19931 | 290348 | 7365  | 311717 |
  muti   | [READ|WRITE]_ONCE | 19628 | 320885 | 7129  | 321275 |
  goal   |-------------------|-------|--------|-------|--------|
         |                   | -1.5% | +10.5% | -3.2% | +3.0%  |

So, my tests show that READ_ONCE / WRITE_ONCE gives us better
single-threaded performance. That's because it skips the mandatory
CPU-to-CPU syncing. This also helps explain why x86 has double the
disk bandwidth (~1000MB/s) of Arm64, but surprisingly, single
containers run much worse on x86.

However, in multi-threaded scenarios, not consistently reading
the latest goal has these implications:

  * ext4_get_group_info() calls increase, as ext4_mb_good_group_nolock()
    is invoked more often on incorrect groups.

  * ext4_mb_load_buddy() calls increase due to repeated group accesses
    leading to more folio_mark_accessed calls.

  * ext4_mb_prefetch() calls increase with more frequent prefetch_grp
    access. (I suspect the current mb_prefetch mechanism has some inherent
    issues we could optimize later.)

At this point, I believe either approach is acceptable.

What are your thoughts?


Cheers,
Baokun


