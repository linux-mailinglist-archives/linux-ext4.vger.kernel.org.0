Return-Path: <linux-ext4+bounces-8707-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0560BAED93F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 12:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BA91624A2
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E3248F53;
	Mon, 30 Jun 2025 10:02:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448F248F71;
	Mon, 30 Jun 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277777; cv=none; b=GpIbdjmtd9ReqM/RJ2GOWMBcAvwMR9GMwZOReVXh3QH75Oz/JFngrWm0n407Vff3kG0vo5XGviHAu32o1qlWI1QoVTKQ0qhZ+z/4pvMmxM1D4sHigCC4x1JZhaOSRWgKsU8MV0LshmkpnO4fqdO1QTmH33Wg0KPppQH76LH5wFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277777; c=relaxed/simple;
	bh=NyVT655muCwMeK+wcA1oZ5Wpn3kTCXV00ptp3XX4WIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pWUtmFymk3G1rgNC044oVC0h42RvTRvgsuTojBGr52hr1NE/OG8o+sVxJvJfO7eN8LB13uq+9AlkusanQtEoAplP+/QGCuiKep5Cqhig/94zayAR0FFARTQ7glxShkrDmJe7ro4KeXdssbT2irLPbyQDEHMdQPd+HJ4fibl5bZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW1nG6s20z14LqC;
	Mon, 30 Jun 2025 17:58:10 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C0831402CF;
	Mon, 30 Jun 2025 18:02:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 18:02:49 +0800
Message-ID: <4f15d0aa-39e0-42ef-a9ca-ddbb3ff36060@huawei.com>
Date: Mon, 30 Jun 2025 18:02:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] ext4: utilize multiple global goals to reduce
 contention
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-5-libaokun1@huawei.com>
 <xmhuzjcgujdvmgmnc3mfd45txehmq73fiyg32vr6h7ldznctlq@rosxe25scojb>
 <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
 <qtdxe2rmnvrxdjmp26ro4l5erwq5lrbvmvysxfgqddadnpr7x4@xrkrdjkgsh67>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <qtdxe2rmnvrxdjmp26ro4l5erwq5lrbvmvysxfgqddadnpr7x4@xrkrdjkgsh67>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/30 16:38, Jan Kara wrote:
> On Mon 30-06-25 14:50:30, Baokun Li wrote:
>> On 2025/6/28 2:31, Jan Kara wrote:
>>> On Mon 23-06-25 15:32:52, Baokun Li wrote:
>>>> When allocating data blocks, if the first try (goal allocation) fails and
>>>> stream allocation is on, it tries a global goal starting from the last
>>>> group we used (s_mb_last_group). This helps cluster large files together
>>>> to reduce free space fragmentation, and the data block contiguity also
>>>> accelerates write-back to disk.
>>>>
>>>> However, when multiple processes allocate blocks, having just one global
>>>> goal means they all fight over the same group. This drastically lowers
>>>> the chances of extents merging and leads to much worse file fragmentation.
>>>>
>>>> To mitigate this multi-process contention, we now employ multiple global
>>>> goals, with the number of goals being the CPU count rounded up to the
>>>> nearest power of 2. To ensure a consistent goal for each inode, we select
>>>> the corresponding goal by taking the inode number modulo the total number
>>>> of goals.
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
>>>> mb_optimize_scan=0 | 7612  | 19699 (+158%)   | 21647 | 53093 (+145%)   |
>>>> mb_optimize_scan=1 | 7568  | 9862  (+30.3%)  | 9117  | 14401 (+57.9%)  |
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ...
>>>
>>>> +/*
>>>> + * Number of mb last groups
>>>> + */
>>>> +#ifdef CONFIG_SMP
>>>> +#define MB_LAST_GROUPS roundup_pow_of_two(nr_cpu_ids)
>>>> +#else
>>>> +#define MB_LAST_GROUPS 1
>>>> +#endif
>>>> +
>>> I think this is too aggressive. nr_cpu_ids is easily 4096 or similar for
>>> distribution kernels (it is just a theoretical maximum for the number of
>>> CPUs the kernel can support)
>> nr_cpu_ids is generally equal to num_possible_cpus(). Only when
>> CONFIG_FORCE_NR_CPUS is enabled will nr_cpu_ids be set to NR_CPUS,
>> which represents the maximum number of supported CPUs.
> Indeed, CONFIG_FORCE_NR_CPUS confused me.
>
>>> which seems like far too much for small
>>> filesystems with say 100 block groups.
>> It does make sense.
>>
>>> I'd rather pick the array size like:
>>>
>>> min(num_possible_cpus(), sbi->s_groups_count/4)
>>>
>>> to
>>>
>>> a) don't have too many slots so we still concentrate big allocations in
>>> somewhat limited area of the filesystem (a quarter of block groups here).
>>>
>>> b) have at most one slot per CPU the machine hardware can in principle
>>> support.
>>>
>>> 								Honza
>> You're right, we should consider the number of block groups when setting
>> the number of global goals.
>>
>> However, a server's rootfs can often be quite small, perhaps only tens of
>> GBs, while having many CPUs. In such cases, sbi->s_groups_count / 4 might
>> still limit the filesystem's scalability.
> I would not expect such root filesystem to be loaded by many big
> allocations in parallel :). And with 4k blocksize 32GB filesystem would
> have already 64 goals which doesn't seem *that* limiting?

Docker's default path is on the rootfs. Our rootfs size is typically 70GB,
but we might have 300+ or even 500+ CPUs. This could lead to scalability
issues in certain specific scenarios. However, in general,
sbi->s_groups_count / 4 does appear to be sufficient.

> Also note that as the filesystem is filling up and the free space is getting
> fragmented, the number of groups where large allocation can succeed will
> reduce. Thus regardless of how many slots for streaming goal you have, they
> will all end up pointing only to those several groups where large
> still allocation succeeds. So although large number of slots looks good for
> an empty filesystem, the benefit for aged filesystem is diminishing and
> larger number of slots will make the fs fragment faster.
I don't think so. Although we're now splitting into multiple goals, these
goals all start from zero. This means 'n' goals will cause us to scan all
groups 'n' times. We'll repeatedly search for free space on disk rather
than creating more fragmentation.

This approach can actually solve the issue where a single goal, despite
having 4K free space available, causes an 8K allocation request to skip it,
forcing subsequent 4K allocation requests to split larger free spaces.
>
>> Furthermore, after supporting LBS, the number of block groups will
>> sharply decrease.
> Right. This is going to reduce scalability of block allocation in general.
> Also as the groups grow larger with larger blocksize the benefit of
> streaming allocation which just gives a hint about block group to use is
> going to diminish when the free block search will be always starting from
> 0. We will maybe need to store ext4_fsblk_t (effectively combining
> group+offset in a single atomic unit) as a streaming goal to mitigate this.
I don't think that's necessary. We still need to consider block group lock
contention, so the smallest unit should always be the group.
>
>> How about we directly use sbi->s_groups_count (which would effectively be
>> min(num_possible_cpus(), sbi->s_groups_count)) instead? This would also
>> avoid zero values.
> Avoiding zero values is definitely a good point. My concern is that if we
> have sb->s_groups_count streaming goals, then practically each group will
> become a streaming goal group and thus we can just remove the streaming
> allocation altogether, there's no benefit.
Having 'n' goals simply means we scan the groups 'n' times; it's not
related to the number of groups. However, when there are too many goals,
the probability of contention due to identical goals increases.
Nevertheless, this is always better than having a single goal, where they
would always contend for the same one.

Now that we're hashing based on an inode's ino, we can later specify the
corresponding inode ino based on the CPU ID during inode allocation.
>
> We could make streaming goal to be ext4_fsblk_t so that also offset of the
> last big allocation in the group is recorded as I wrote above. That would
> tend to pack big allocations in each group together which is benefitial to
> combat fragmentation even with higher proportion of groups that are streaming
> goals (and likely becomes more important as the blocksize and thus group
> size grow). We can discuss proper number of slots for streaming allocation
> (I'm not hung up on it being quarter of the group count) but I'm convinced
> sb->s_groups_count is too much :)
>
> 								Honza

I think sbi->s_groups_count / 4 is indeed acceptable. However, I don't
believe recording offsets is necessary. As groups become larger,
contention for groups will intensify, and adding offsets would only
make this contention worse.


Regards,
Baokun


