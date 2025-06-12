Return-Path: <linux-ext4+bounces-8390-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0201AD6F0F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6188B7A9A2D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463212F430D;
	Thu, 12 Jun 2025 11:31:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909AEC2;
	Thu, 12 Jun 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727862; cv=none; b=FkHaEnvnJnk9c61S6BipXncaH5aVPw0hTmq0LGpKkKEtvxOh43f7/U4tKVWaQGwyVt6BnIhvb4Wsn5ajWuETUT7zs15n23cafKjTNwqO/j3lws5QH6M10m+3oWehYRZ26GPzfW5bn1R04Mi6gzxxcglGiWnbx+OzqnLpF8q4QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727862; c=relaxed/simple;
	bh=t34Qsq3FLgijejopvQb4g/9oC3yiNefOtHAPCHcuUWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SCWTXNBBkFr9CPi7qPzuRucw1i4xHa9RFTQuonhjZW5+m8ww+EFbHFeTiF9SVVkST3Z6fD/dvYdyt/pHvE40kgh57CFiJfA7M7f6rFJPKuAPzmaearqIJ+USYkvC7kSdsbK2XFsFYTCssNAJ5RmV331mnTPNAah8w15sB/1y0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bJ0jS2tnqz2QTyj;
	Thu, 12 Jun 2025 19:31:40 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A1DA1A0188;
	Thu, 12 Jun 2025 19:30:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Jun
 2025 19:30:46 +0800
Message-ID: <4fd0b1b9-6054-42ea-9cb3-250910f644c7@huawei.com>
Date: Thu, 12 Jun 2025 19:30:45 +0800
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
	<yangerkun@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <aDchmYDc_OOAu2yC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <f21507f9-ebc6-43ce-97c4-cd055c53747e@huawei.com>
 <aEgfwKvcJzt9gkGq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <bff134da-e056-4eaf-b5ac-cace99208e40@huawei.com>
 <aEk8xcy9Zykrx3m3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aEk8xcy9Zykrx3m3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/6/11 16:22, Ojaswin Mujoo wrote:
> On Tue, Jun 10, 2025 at 09:48:30PM +0800, Baokun Li wrote:
>> On 2025/6/10 20:06, Ojaswin Mujoo wrote:
>>> On Thu, May 29, 2025 at 08:24:14PM +0800, Baokun Li wrote:
>>>> On 2025/5/28 22:53, Ojaswin Mujoo wrote:
>>>>> On Fri, May 23, 2025 at 04:58:17PM +0800, libaokun@huaweicloud.com wrote:
>>>> ----------------------------------------------------------
>>>>                        |       base      |      patched    |
>>>> ---------------------|--------|--------|--------|--------|
>>>> mb_optimize_scan     | linear |opt_scan| linear |opt_scan|
>>>> ---------------------|--------|--------|--------|--------|
>>>> bw(MiB/s)            | 217    | 219    | 5685   | 5670   |
>>>> Avg. free extent size| 1943732| 1943728| 1439608| 1368328|
>>>> Avg. extents per file| 261879 | 262039 | 744    | 2084   |
>>>> Avg. size per extent | 4      | 4      | 1408   | 503    |
>>>> Fragmentation score  | 100    | 100    | 2      | 6      |
>>>> ----------------------------------------------------------
>>> Hi Baokun,
>>>
>>> Thanks for the info and data and apologies for being late, I caught a
>>> viral last week :/
>> Hi Ojaswin,
>>
>> Being sick really takes a toll.
>> Please get some good rest and take care of yourself.
> Thanks Baokun!
>
> <snip>
>
>>>> Another reason is that opt_scan tends to allocate from groups that have
>>>> just received freed blocks, causing it to constantly "jump around"
>>>> between certain groups.
>>>>
>>>> This leads to intense contention between allocation and release, and even
>>>> between release events. In contrast, linear traversal always moves forward
>>>> without revisiting groups, resulting in less contention between allocation
>>>> and release.
>>> By just received free blocks, you mean the blocks got freed in the group
>>> right?
>> Yes.
>>> I was under the impression that when we free blocks and the group's
>>> largest order/ avg fragment changes, the group is added to the end of
>>> the free fragment list/order list so it should be the last to be picked.
>>> Is that not the case?
>> Yes, we are indeed adding the group to the list tail. However, because
>> we traverse all ordered lists from low to high, a group might end up
>> "bouncing" repeatedly between order_0 and order_1 here.
>>
>> For instance, if order_1 only contains group 1, linear traversal would
>> rarely revisit it after the initial pass. However, after a non-linear
>> allocation, this group is moved from the order_1 list to the order_0 list.
>> When blocks are freed, it's moved back to the order_1 list, and then
>> non-linear traversal prioritizes allocation in this same group again...
> Right, I get what you mean now. Thanks.
>
>>>> However, because linear involves more groups in allocation, journal
>>>> becomes a bottleneck. If opt_scan first attempts to traverse block groups
>>>> to the right from the target group in all lists, and then from index 0 to
>>>> the left in all lists, competition between block groups would be
>>>> significantly reduced.
>>>>
>>>> To enable ordered traversal, we attempted to convert list_head to an
>>>> ordered xarray. This ordering prevents "bouncing" during retries.
>>>> Additionally, traversing all right-side groups before left-side groups
>>>> significantly reduced contention. Performance improved from 10430 to 17730.
>>> Do you maybe have some code you can share of this?
>> Yes, V2 will include those changes.
> Okay sure
>
> <snip
>
>>>> In a single container, create a file, then repeatedly append 8KB using
>>>> fallocate until the file reaches 1MB. After that, truncate the file to
>>>> 0 and continue appending 8KB with fallocate. The 64 containers will
>>>> occupy a maximum of 64MB of disk space in total, so they won't fill the
>>>> entire file system.
>>> Also, as per your theory, if we do similar experiments in a fragmented
>>> FS we should see opt_scan perform better right? I'd like to test this as
>>> well. I'll try to play with the scripts you have shared.
>>>
>> Yes, mb_optimize_scan performs well when free space fragmentation is
>> severe. We have a 600TB disk array where the write bandwidth is
>> approximately 5 GB/s when empty. When space utilization reaches 95%,
>> linear traversal drops bandwidth to 1 GB/s, whereas enabling
>> mb_optimize_scan restores it to 4.2 GB/s.
> Got it, thanks for confirming. Seems like in mostly empty FS linear
> traversal seems to do better. Makes me wonder if we should use some
> heurestic to switch between linear and opt_scan based allocation, for
> example opt_scan can be used if FS is 60% full or has a fragmentation
> score of X. (or something like that..)
Yes, it would be nice if we could switch at the right point in time so we
could have the best of both allocations. But we need some data to support
us in choosing the right strategy, but that can come later.
> But Im also curious about your improved optimize scan implementation
> with ordered traversal, so lets see how that goes first.
>
The v2 version of the patch is currently being tested and if it goes
well, it could be sent out next week.


Cheers,
Baokun


