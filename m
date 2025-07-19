Return-Path: <linux-ext4+bounces-9108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94627B0ACCD
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 02:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CF11C288BB
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD51BC5C;
	Sat, 19 Jul 2025 00:29:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9E13FEE;
	Sat, 19 Jul 2025 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884985; cv=none; b=NkEoaN/MArLcPKTq2wU/oRmUFntUaA94sXVAbf7rBifxhzQdvjOzgzSE5CX4O/PDnDE5GkRtz1FY6S9HzeBov1chdpbSYWTN1c6bIhdlUGn6nVPvFh7h7dnqw4tYLuqM+qA67dzZoz3+j/ndCZEyIx/CY/l/QmqVZtv0WbUNVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884985; c=relaxed/simple;
	bh=F+1FvYPAqBoL2W1fDm9o4jMhXdj1PoZl2bY+461+tfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=seFkxRqoWYcrnugolGTYlq4mndLZwNW/4mmH7oO3cH8gR9F5eMR0iF0KtOEOf25jVWGpnhUPkfptVhYyxc2iHwcqB3CqOlDnmo0Qgnka8SXz2EJioI/r5MlrKwG7Vl6XYoEN7mpYapW2VwHsBZmj1UTPQQfUt4dt8vBNrOhdQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bkSFG3PczztScc;
	Sat, 19 Jul 2025 08:28:34 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 498BE1402DF;
	Sat, 19 Jul 2025 08:29:39 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Jul
 2025 08:29:38 +0800
Message-ID: <d87eab9a-8224-477f-ae81-d4f205ee78b6@huawei.com>
Date: Sat, 19 Jul 2025 08:29:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
To: Andi Kleen <ak@linux.intel.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
 <87pldy78qc.fsf@linux.intel.com>
Content-Language: en-US
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87pldy78qc.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/18 6:28, Andi Kleen wrote:
> Baokun Li <libaokun1@huawei.com> writes:
>
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
> It seems this makes block allocation non deterministic, but depend on
> the system load. I can see where this could cause problems when
> reproducing bugs at least, but perhaps also in other cases.
>
> Better perhaps just round robin the groups?
> Or at least add a way to turn it off.
>
> -Andi
>
As Ted mentioned, Ext4 has never guaranteed deterministic allocation. We
do attempt a predetermined goal in ext4_mb_find_by_goal(), and this part
has no trylock logic, meaning we'll always attempt to scan the target
group once—that's deterministic.

However, if the target attempt fails, the primary goal for subsequent
allocation is to find suitable free space as quickly as possible, so
there's no need to contend with other processes for non-target groups.


Cheers,
Baokun


