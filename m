Return-Path: <linux-ext4+bounces-8346-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA5AD39EB
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 15:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B8C16F0E1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEA29290A;
	Tue, 10 Jun 2025 13:48:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4E1E489;
	Tue, 10 Jun 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563317; cv=none; b=SdiMtqXb2HarmWtLZrHm/946G5SQ8tHgB7ctSrvFf/XgVEGAk6Eaa6bttXs/bpeTr7l1oY3/wFA4axVms+EhUNZvgu/KEAxzvwxhOtHQmI9mQYscStPafw1qX1UVacuk3VsRIVEZoQt2W1WcH4KTHjUs2VhzJqTZsRWuy8GP82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563317; c=relaxed/simple;
	bh=v/zl0EyABA+Q5MzhJscMCa7Vet9GH1tmcKdrrg5bFBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WX+fPJH5bHVAMmxLInIypQuX4qFCo7qDaEag5Lx43iKVs27MUgYad4u8F0ecBE7xRkOxA+Rda+bWQOT1UNwfuj4MAev5ysZR9bqG60j84XqIn8+UcjC9raqUF+QPPac/e+Xh+6taS4dMZ4fSxfyLIM7K72hDxLmLHIM5xPDtp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bGqpm69Zhz1fxjv;
	Tue, 10 Jun 2025 21:47:12 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id BDE881A016C;
	Tue, 10 Jun 2025 21:48:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Jun
 2025 21:48:30 +0800
Message-ID: <bff134da-e056-4eaf-b5ac-cace99208e40@huawei.com>
Date: Tue, 10 Jun 2025 21:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ext4: better scalability for ext4 block allocation
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <aDchmYDc_OOAu2yC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <f21507f9-ebc6-43ce-97c4-cd055c53747e@huawei.com>
 <aEgfwKvcJzt9gkGq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aEgfwKvcJzt9gkGq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/6/10 20:06, Ojaswin Mujoo wrote:
> On Thu, May 29, 2025 at 08:24:14PM +0800, Baokun Li wrote:
>> On 2025/5/28 22:53, Ojaswin Mujoo wrote:
>>> On Fri, May 23, 2025 at 04:58:17PM +0800, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
> <...>
>
>>>> |--------|--------|--------|--------|--------|--------|--------|--------|
>>>> |    -   |    1   |    2   |    4   |    8   |   16   |   32   |   64   |
>>>> |--------|--------|--------|--------|--------|--------|--------|--------|
>>>> |  base  | 295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588  |
>>>> |--------|--------|--------|--------|--------|--------|--------|--------|
>>>> | linear | 286328 | 123102 | 119542 | 90653  | 60344  | 35302  | 23280  |
>>>> |        | -3.0%  | 74.20% | 252.9% | 367.5% | 497.2% | 531.6% | 548.7% |
>>>> |--------|--------|--------|--------|--------|--------|--------|--------|
>>>> |mb_optim| 292498 | 133305 | 103069 | 61727  | 29702  | 16845  | 10430  |
>>>> |ize_scan| -0.9%  | 88.64% | 204.3% | 218.3% | 193.9% | 201.4% | 190.6% |
>>>> |--------|--------|--------|--------|--------|--------|--------|--------|
>>> Hey Baokun, nice improvements! The proposed changes make sense to me,
>>> however I suspect the performance improvements may come at a cost of
>>> slight increase in fragmentation, which might affect rotational disks
>>> especially. Maybe comparing e2freefrag numbers with and without the
>>> patches might give a better insight into this.
>> While this approach might slightly increase free space fragmentation on
>> the disk, it significantly reduces file fragmentation, leading to faster
>> read speeds on rotational disks.
>>
>> When multiple processes contend for free blocks within the same block
>> group, the probability of blocks allocated by the same process being
>> merged on consecutive allocations is low. This is because other processes
>> may preempt the free blocks immediately following the current process's
>> last allocated region.
>>
>> Normally, we rely on preallocation to avoid files becoming overly
>> fragmented (even though preallocation itself can cause fragmentation in
>> free disk space). But since fallocate doesn't support preallocation, the
>> fragmentation issue is more pronounced. Counterintuitively, skipping busy
>> groups actually boosts opportunities for file extent merging, which in turn
>> reduces overall file fragmentation.
>>
>> Referencing will-it-scale/fallocate2, I tested 64 processes each appending
>> 4KB via fallocate to 64 separate files until they reached 1GB. This test
>> specifically examines contention in block allocation, unlike fallocate2,
>> it omits the contention between fallocate and truncate. Preliminary results
>> are provided below; detailed scripts and full test outcomes are attached in
>> the email footer.
>>
>> ----------------------------------------------------------
>>                       |       base      |      patched    |
>> ---------------------|--------|--------|--------|--------|
>> mb_optimize_scan     | linear |opt_scan| linear |opt_scan|
>> ---------------------|--------|--------|--------|--------|
>> bw(MiB/s)            | 217    | 219    | 5685   | 5670   |
>> Avg. free extent size| 1943732| 1943728| 1439608| 1368328|
>> Avg. extents per file| 261879 | 262039 | 744    | 2084   |
>> Avg. size per extent | 4      | 4      | 1408   | 503    |
>> Fragmentation score  | 100    | 100    | 2      | 6      |
>> ----------------------------------------------------------
> Hi Baokun,
>
> Thanks for the info and data and apologies for being late, I caught a
> viral last week :/
Hi Ojaswin,

Being sick really takes a toll.
Please get some good rest and take care of yourself.
>
> These numbers look pretty interesting and your explanation of why the
> fragmentation is better makes sense. It is definitely a win-win then for
> performance and fragmentation!
>
>>> Regardless the performance benefits are significant and I feel it is
>>> good to have these patches.
>>>
>>> I'll give my reviews individually as I'm still going through patch 2
>>> However, I wanted to check on a couple things:
>> Okay, thank you for your feedback.
>>> 1. I believe you ran these in docker. Would you have any script etc open
>>>      sourced that I can use to run some benchmarks on my end (and also
>>> 	 understand your test setup).
>> Yes, these two patches primarily mitigate contention between block
>> allocations and between block allocation and release. The testing script
>> can be referenced from the fio script mentioned earlier in the email
>> footer. You can also add more truncate calls based on it.
> Thanks for the scripts.
>
>>> 2. I notice we are getting way less throughput in mb_optimize_scan? I
>>>      wonder why that is the case. Do you have some data on that? Are your
>>>      tests starting on an empty FS, maybe in that case linear scan works a
>>>      bit better since almost all groups are empty. If so, what are the
>>>      numbers like when we start with a fragmented FS?
>> The throughput of mb_optimize_scan is indeed much lower, and we continue
>> to optimize it, as mb_optimize_scan is the default mount option and
>> performs better in scenarios with large volume disks and high space usage.
>>
>> Disk space used is about 7%; mb_optimize_scan should perform better with
>> less free space. However, this isn't the critical factor. The poor
>> throughput here is due to the following reasons。
>>
>> One reason is that mb_optimize_scan's list traversal is unordered and
>> always selects the first group.
>>
>> While traversing the list, holding a spin_lock prevents load_buddy, making
>> direct use of ext4_lock_group impossible. This can lead to a "bouncing"
>> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
>> fails, forcing the list traversal to repeatedly restart from grp_A.
>>
>> In contrast, linear traversal directly uses ext4_try_lock_group(),
>> avoiding this bouncing. Therefore, we need a lockless, ordered traversal
>> to achieve linear-like efficiency.
> Hmm, right the non ordered traversal has led to other issues as well in
> the past.
>
>> Another reason is that opt_scan tends to allocate from groups that have
>> just received freed blocks, causing it to constantly "jump around"
>> between certain groups.
>>
>> This leads to intense contention between allocation and release, and even
>> between release events. In contrast, linear traversal always moves forward
>> without revisiting groups, resulting in less contention between allocation
>> and release.
> By just received free blocks, you mean the blocks got freed in the group
> right?
Yes.
> I was under the impression that when we free blocks and the group's
> largest order/ avg fragment changes, the group is added to the end of
> the free fragment list/order list so it should be the last to be picked.
> Is that not the case?
Yes, we are indeed adding the group to the list tail. However, because
we traverse all ordered lists from low to high, a group might end up
"bouncing" repeatedly between order_0 and order_1 here.

For instance, if order_1 only contains group 1, linear traversal would
rarely revisit it after the initial pass. However, after a non-linear
allocation, this group is moved from the order_1 list to the order_0 list.
When blocks are freed, it's moved back to the order_1 list, and then
non-linear traversal prioritizes allocation in this same group again...
>
>> However, because linear involves more groups in allocation, journal
>> becomes a bottleneck. If opt_scan first attempts to traverse block groups
>> to the right from the target group in all lists, and then from index 0 to
>> the left in all lists, competition between block groups would be
>> significantly reduced.
>>
>> To enable ordered traversal, we attempted to convert list_head to an
>> ordered xarray. This ordering prevents "bouncing" during retries.
>> Additionally, traversing all right-side groups before left-side groups
>> significantly reduced contention. Performance improved from 10430 to 17730.
> Do you maybe have some code you can share of this?
Yes, V2 will include those changes.
>
>> However, xarray traversal introduces overhead; list_head group selection
>> was O(1), while xarray becomes O(n log n). This results in a ~10%
>> performance drop in single-process scenarios, and I'm not entirely sure if
>> this trade-off is worthwhile. 🤔
>>
>> Additionally, by attempting to merge before inserting in
>> ext4_mb_free_metadata(), we can eliminate contention on sbi->s_md_lock
>> during merges, resulting in roughly a 5% performance gain.
>>>      - Or maybe it is that the lazyinit thread has not yet initialized all
>>>      the buddies yet which means we have lesser BGs in the freefrag list
>>>      or the order list used by faster CRs. Hence, if they are locked we
>>>      are falling more to CR_GOAL_LEN_SLOW. To check if this is the case,
>>>      one hack is to cat /proc/fs/ext4/<disk>/mb_groups (or something along
>>>      the lines) before the benchmark, which forces init of all the group
>>>      buddies thus populating all the lists used by mb_opt_scan. Maybe we
>>>      can check if this gives better results.
>> All groups are already initialized at the time of testing, and that's not
>> where the problem lies.
>>> 3. Also, how much IO are we doing here, are we filling the whole FS?
>>>
>> In a single container, create a file, then repeatedly append 8KB using
>> fallocate until the file reaches 1MB. After that, truncate the file to
>> 0 and continue appending 8KB with fallocate. The 64 containers will
>> occupy a maximum of 64MB of disk space in total, so they won't fill the
>> entire file system.
> Also, as per your theory, if we do similar experiments in a fragmented
> FS we should see opt_scan perform better right? I'd like to test this as
> well. I'll try to play with the scripts you have shared.
>
Yes, mb_optimize_scan performs well when free space fragmentation is
severe. We have a 600TB disk array where the write bandwidth is
approximately 5 GB/s when empty. When space utilization reaches 95%,
linear traversal drops bandwidth to 1 GB/s, whereas enabling
mb_optimize_scan restores it to 4.2 GB/s.


Cheers,
Baokun


