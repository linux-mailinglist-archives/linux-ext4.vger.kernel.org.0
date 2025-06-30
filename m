Return-Path: <linux-ext4+bounces-8699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD0AED4EA
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A86318967E1
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB91FBE83;
	Mon, 30 Jun 2025 06:50:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46D20322;
	Mon, 30 Jun 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266238; cv=none; b=AN4V0vDbaWivPRV4qeBGRpSg0u85zclg0AvZwZjqB8KPO2kFZe17mhJ38urQRnZFBCOpDzSEKqWparJIKxe/fqTqHs+CDCEVQgiaDzpnQUV2Y0jPABstLqciTZMg+Q7akRWuxsdRz5ZrjJDOKMHcW63eX6+x8n0Gj8V5FWueMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266238; c=relaxed/simple;
	bh=Iivev3SIZqW0SaRJo9EnFrOxkXH0TOMUQKHax2I4Cd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AMx91kyjc64gFhOamkIuYnMniAITD0OdLxvKKrxJM+9V1pHGxpI74vNnWpYPxFmaDD9ds7F1D79/U3gdSR43IUBJzRWDHGFQAgNkvAHzUgeaB3755P/MBrMOJgpwL4HbKFSqACioiZgV3B/lawWnJ4wtOIc+nhmlxhbQj/WSYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bVxYx1rKgz13MJf;
	Mon, 30 Jun 2025 14:48:05 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 42594140257;
	Mon, 30 Jun 2025 14:50:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 14:50:31 +0800
Message-ID: <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
Date: Mon, 30 Jun 2025 14:50:30 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <xmhuzjcgujdvmgmnc3mfd45txehmq73fiyg32vr6h7ldznctlq@rosxe25scojb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/28 2:31, Jan Kara wrote:
> On Mon 23-06-25 15:32:52, Baokun Li wrote:
>> When allocating data blocks, if the first try (goal allocation) fails and
>> stream allocation is on, it tries a global goal starting from the last
>> group we used (s_mb_last_group). This helps cluster large files together
>> to reduce free space fragmentation, and the data block contiguity also
>> accelerates write-back to disk.
>>
>> However, when multiple processes allocate blocks, having just one global
>> goal means they all fight over the same group. This drastically lowers
>> the chances of extents merging and leads to much worse file fragmentation.
>>
>> To mitigate this multi-process contention, we now employ multiple global
>> goals, with the number of goals being the CPU count rounded up to the
>> nearest power of 2. To ensure a consistent goal for each inode, we select
>> the corresponding goal by taking the inode number modulo the total number
>> of goals.
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
>> mb_optimize_scan=0 | 7612  | 19699 (+158%)   | 21647 | 53093 (+145%)   |
>> mb_optimize_scan=1 | 7568  | 9862  (+30.3%)  | 9117  | 14401 (+57.9%)  |
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>
>> +/*
>> + * Number of mb last groups
>> + */
>> +#ifdef CONFIG_SMP
>> +#define MB_LAST_GROUPS roundup_pow_of_two(nr_cpu_ids)
>> +#else
>> +#define MB_LAST_GROUPS 1
>> +#endif
>> +
> I think this is too aggressive. nr_cpu_ids is easily 4096 or similar for
> distribution kernels (it is just a theoretical maximum for the number of
> CPUs the kernel can support)

nr_cpu_ids is generally equal to num_possible_cpus(). Only when
CONFIG_FORCE_NR_CPUS is enabled will nr_cpu_ids be set to NR_CPUS,
which represents the maximum number of supported CPUs.

> which seems like far too much for small
> filesystems with say 100 block groups.

It does make sense.

> I'd rather pick the array size like:
>
> min(num_possible_cpus(), sbi->s_groups_count/4)
>
> to
>
> a) don't have too many slots so we still concentrate big allocations in
> somewhat limited area of the filesystem (a quarter of block groups here).
>
> b) have at most one slot per CPU the machine hardware can in principle
> support.
>
> 								Honza

You're right, we should consider the number of block groups when setting
the number of global goals.

However, a server's rootfs can often be quite small, perhaps only tens of
GBs, while having many CPUs. In such cases, sbi->s_groups_count / 4 might
still limit the filesystem's scalability. Furthermore, after supporting
LBS, the number of block groups will sharply decrease.

How about we directly use sbi->s_groups_count (which would effectively be
min(num_possible_cpus(), sbi->s_groups_count)) instead? This would also
avoid zero values.


Cheers,
Baokun


