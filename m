Return-Path: <linux-ext4+bounces-8308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C52ACD968
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jun 2025 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75EC188622B
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jun 2025 08:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8B24EF76;
	Wed,  4 Jun 2025 08:14:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3826FA50;
	Wed,  4 Jun 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024840; cv=none; b=e5ImA12FTN6zQmsOTm8/RdDPoZE2NPviuFCN0epqaA1SRA6MqivPCEX+bVmkbyKsUhHQQdySth2YeeqDcpSQNC3UtgPo3wlGmlMKNljGHn6Ge5SH5C4qnGUGi/kSP7MTHpwWd5k6qKVRud3crYo7dXEf3/ZH5YLvDYctpx0gKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024840; c=relaxed/simple;
	bh=sx7dt9fASGXFnof0E6le4fHW/32v2bXW+fx07LKwKcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PgAxdnnaFdVKMS3eUDMolwSr6CWEjClYem8eHu9SJ2xVLHlQYht3HMYIiFWVdA/8u+ufFFaFBh1k8chmt3NbTCUCgSot4Pxb4JDbm/Sv21ce8ULP5CFpsuuMjVBkK/0wIGa94ZmdZzNjKVM7xXax3/8WhkT0q6itOIG2XZaslfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bC0cT6nfyz2Cddv;
	Wed,  4 Jun 2025 16:10:01 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 09155180042;
	Wed,  4 Jun 2025 16:13:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Jun
 2025 16:13:49 +0800
Message-ID: <ffb669b5-dc98-4264-a92d-5ad1baa4e06e@huawei.com>
Date: Wed, 4 Jun 2025 16:13:48 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ext4: move mb_last_[group|start] to ext4_inode_info
To: Jan Kara <jack@suse.cz>, <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-3-libaokun@huaweicloud.com>
 <afjkyrm4y5mp5p72ew3ddqma7v4gkmjqdkcloeaidcj55ruami@zfkn6dzgqfwh>
 <6200e067-0ad1-4dc4-9694-05ee1e977f4c@huawei.com>
 <5oqysbekjn7vazkzrh4lgtg25vqqxgrugvld6av7r2nx7dbghr@kk4yidjw735c>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <5oqysbekjn7vazkzrh4lgtg25vqqxgrugvld6av7r2nx7dbghr@kk4yidjw735c>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/6/2 23:44, Jan Kara wrote:
> Hello!
>
> On Fri 30-05-25 17:31:48, Baokun Li wrote:
>> On 2025/5/29 20:56, Jan Kara wrote:
>>> On Fri 23-05-25 16:58:19, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> After we optimized the block group lock, we found another lock
>>>> contention issue when running will-it-scale/fallocate2 with multiple
>>>> processes. The fallocate's block allocation and the truncate's block
>>>> release were fighting over the s_md_lock. The problem is, this lock
>>>> protects totally different things in those two processes: the list of
>>>> freed data blocks (s_freed_data_list) when releasing, and where to start
>>>> looking for new blocks (mb_last_[group|start]) when allocating.
>>>>
>>>> Moreover, when allocating data blocks, if the first try (goal allocation)
>>>> fails and stream allocation is on, it tries a global goal starting from
>>>> the last group we used (s_mb_last_group). This can make things faster by
>>>> writing blocks close together on the disk. But when many processes are
>>>> allocating, they all fight over s_md_lock and might even try to use the
>>>> same group. This makes it harder to merge extents and can make files more
>>>> fragmented. If different processes allocate chunks of very different sizes,
>>>> the free space on the disk can also get fragmented. A small allocation
>>>> might fit in a partially full group, but a big allocation might have
>>>> skipped it, leading to the small IO ending up in a more empty group.
>>>>
>>>> So, we're changing stream allocation to work per inode. First, it tries
>>>> the goal, then the last group where that inode successfully allocated a
>>>> block. This keeps an inode's data closer together. Plus, after moving
>>>> mb_last_[group|start] to ext4_inode_info, we don't need s_md_lock during
>>>> block allocation anymore because we already have the write lock on
>>>> i_data_sem. This gets rid of the contention between allocating and
>>>> releasing blocks, which gives a huge performance boost to fallocate2.
>>>>
>>>> Performance test data follows:
>>>>
>>>> CPU: HUAWEI Kunpeng 920
>>>> Memory: 480GB
>>>> Disk: 480GB SSD SATA 3.2
>>>> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
>>>> Observation: Average fallocate operations per container per second.
>>>>
>>>>                         base     patched
>>>> mb_optimize_scan=0    6755     23280 (+244.6%)
>>>> mb_optimize_scan=1    4302     10430 (+142.4%)
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> Good spotting with the s_md_lock contention here. But your changes don't
>>> quite make sense to me. The idea of streaming allocation in mballoc is to
>>> have an area of filesystem for large files to reduce fragmentation.  When
>>> you switch to per-inode, this effect of packing large files together goes
>>> away. Futhermore for each inode either all allocations will be very likely
>>> streaming or not streaming (the logic uses file size) so either your
>>> per-inode target will be unused or just another constantly used copy of
>>> goal value.
>> Sorry, I didn't intend to  break streaming allocation's semantics.
>> A precise definition of streaming allocation is not found in the
>> existing code, documentation, or historical records. Consequently,
>> my previous understanding of it was somewhat inaccurate.
>>
>> I previously thought it was used to optimize the efficiency of linear
>> traversal. For instance, if 500 inodes are created in group 0 and each
>> file is sequentially filled to 1GB, each file's goal, being empty, would
>> be group 1 (the second group in the inode's flex_bg).
>>
>> Without a global goal and in the absence of non-linear traversal,
>> after the first inode is filled, the second inode would need to traverse
>> groups 1 through 8 to find its first free block.
>>
>> This inefficiency escalates, eventually requiring the 500th inode to
>> potentially traverse almost 4000 block groups to find its first available
>> block.
> I see. But doesn't ext4_mb_choose_next_group() usually select group from
> which allocation can succeed instead of linearly scanning through all the
> groups? The linear scan is just a last resort as far as I remember.
Yes, that's right. I was referring to how streaming allocation worked
before mb_optimize_scan was introduced, when we only had linear traversal.

Because mb_optimize_scan's traversal is unordered, it doesn't encounter
this problem. But linear traversal is still needed when criteria are
CR_GOAL_LEN_SLOW or CR_ANY_FREE, or when s_mb_max_linear_groups is
specified.
> Anyway
> I'm not 100% sure what was the original motivation for the streaming goal.
> Maybe Andreas would remember since he was involved in the design.  What I
> wrote is mostly derived from the general understanding of mballoc operating
> principles but I could be wrong.
Hey Andreas, do you happen to remember what the initial thinking was
behind bringing in the streaming goal (EXT4_MB_STREAM_ALLOC)?
>> I initially believed it could be split to the inode level to reduce
>> traversal time and file fragmentation. However, as you pointed out,
>> its purpose is to cluster large files, not data blocks within a file.
>> Given this, splitting it to the inode level no longer makes sense.
>>> So I can see two sensible solutions here:
>>> a) Drop streaming allocations support altogether.
>> As mentioned above, it can also greatly improve the efficiency of linear
>> traversal, so we can't simply remove it.
>>> b) Enhance streaming allocation support to avoid contention between
>>> processes allocating in parallel and freeing. Frankly, there's no strong
>>> reason why reads & writes of streaming allocation goal need to use a
>>> spinlock AFAICS.
>> Yes, since it's just a hint, we don't need a lock at all, not even
>> fe_start, we just need the last fe_group.
>>> We could just store a physical block number and use
>>> atomic64 accessors for it? Also having single goal value is just causing
>>> more contention on group locks for parallel writers that end up using it
>>> (that's the problem I suspect you were hitting the most).
>> Spot on! We did try a single, lockless atomic64 variable, and just as
>> you pointed out, all processes started traversing from the very same
>> group, which just cranked up the contention, dropping OPS to just 6745.
>>>    So perhaps we
>>> can keep multiple streaming goal slots in the superblock (scale the count
>>> based on CPU count & filesystem group count) and just pick the slot based
>>> on inode number hash to reduce contention?
>>>
>>> 								Honza
>> That's a brilliant idea, actually!
>>
>> Since most containers are CPU-pinned, this would naturally cluster a single
>> container's data blocks together. I believe we can also apply this to inode
>> allocation, so a container's inodes and data are all in a single region,
>> significantly reducing interference between containers.
>>
>> My gratitude for your valuable suggestion!
>> I'm going to try out the CPU bucketing approach.
> Cool, let's see how it works out :).

Initially, I tried defining a per-CPU variable where each process would
use the goal corresponding to its current CPU. In CPU-pinned scenarios,
this resulted in almost no interference between CPUs. However, when
writing to the same file sequentially in a non-CPU-pinned environment,
the data blocks could become highly fragmented.

Therefore, I switched to defining a regular array whose length is the
number of CPUs rounded up to the nearest power of 2. By taking the inode
number modulo the array length, we can get the corresponding goal. This
guarantees that the same file consistently uses the same goal. Its
performance is largely similar to inode i_mb_last_group, but it's more
memory-efficient. I'll be switching to this method in the next version.

Thanks again for your suggestion!


Cheers,
Baokun


