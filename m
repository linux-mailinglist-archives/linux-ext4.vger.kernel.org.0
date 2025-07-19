Return-Path: <linux-ext4+bounces-9109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2814B0ACD9
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FC5A1222
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337171BC5C;
	Sat, 19 Jul 2025 00:37:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542E23DE;
	Sat, 19 Jul 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752885478; cv=none; b=GBkOZVrASg6XwU5onC/JOA4HYzD7oqT84mLi+XWlO3VnJ10pmnVW/PRfdzPH68K6ciuRjA4eAnSUnBeN/IpDoddw2WjIODBygkh8444zNzWuBq+Ku+wMNYHc+bL6MNuC95dg46xjsCZE/Me9dHJdK1heH629xff7ToMcLaA0hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752885478; c=relaxed/simple;
	bh=iHuRoaqiqgLMa15x4TcvHU/rCSRoHuJ3bjn6cbUe/7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mem0AVRld8UK3zC9hw8QFM87WRt5zsIIt5REPRNRj7z0HJYkSgKuxz+wbJBZMG5OhcXr4q7ZcYGhIUJsb8pt+fRCWADUTajyV7rhAM8T7UIOhUfyLU734U7uTTxLXYInG1ceibydSI1vb0bfdESq4RWGQWdYmP0NWgT7VYnp0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bkSLL2PFcz14Lx6;
	Sat, 19 Jul 2025 08:32:58 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E1F3180B3F;
	Sat, 19 Jul 2025 08:37:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Jul
 2025 08:37:45 +0800
Message-ID: <bf0bda81-5e75-4b5e-aac1-685e4697f513@huawei.com>
Date: Sat, 19 Jul 2025 08:37:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <julia.lawall@inria.fr>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
 <aHjL5J3Ui9VMZt2o@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aHjL5J3Ui9VMZt2o@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/17 18:09, Ojaswin Mujoo wrote:
> On Mon, Jul 14, 2025 at 09:03:11PM +0800, Baokun Li wrote:
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
>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>> Observation: Average fallocate operations per container per second.
>>
>> |CPU: Kunpeng 920   |          P80            |
>> |Memory: 512GB      |-------------------------|
>> |960GB SSD (0.5GB/s)| base  |    patched      |
>> |-------------------|-------|-----------------|
>> |mb_optimize_scan=0 | 2667  | 4821  (+80.7%)  |
>> |mb_optimize_scan=1 | 2643  | 4784  (+81.0%)  |
>>
>> |CPU: AMD 9654 * 2  |          P96            |
>> |Memory: 1536GB     |-------------------------|
>> |960GB SSD (1GB/s)  | base  |    patched      |
>> |-------------------|-------|-----------------|
>> |mb_optimize_scan=0 | 3450  | 15371 (+345%)   |
>> |mb_optimize_scan=1 | 3209  | 6101  (+90.0%)  |
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> Hey Baokun, I reviewed some of the patches in v2 but i think that was
> very last moment so I'll add the comments in this series, dont mind the
> copy paste :)
>
> The patch itself looks good, thanks for the changes.
>
> Feel free to add:
>
>   Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Sorry for missing your review, I've snowed under with work lately.

Thanks for the review!


Cheers,
Baokun


