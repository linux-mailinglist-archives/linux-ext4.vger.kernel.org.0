Return-Path: <linux-ext4+bounces-8741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF74AEF807
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74F5173AD1
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96F273D90;
	Tue,  1 Jul 2025 12:13:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18138273D76;
	Tue,  1 Jul 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371980; cv=none; b=nW72iYO2JID9/ogSjPp63P+SuR0TI+Fi2sM7NcEGZottWqgsc6FohOf7GFuTNLSyTxSbmGxHof1x3rLMZftyHlXqVAE+4nNo7Z7EaQKkNzXGqKkhNO2RuV6XmtYIFxE6D8InbPp9S+7X3lynN/T6e3S3e0HJyI3Uk2UCNHDI8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371980; c=relaxed/simple;
	bh=4R0V5A94QxHl9omhKFGrj8PiH/81BRRuyaj31yZLA/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dn69y3jNVQuoiQVbGag90GgX5ueJxHJPkU2bNlMrTpv2GvTuJIs+w32Epwvk7yBzlxXyZhEXMlh5yRQkXtrqYtPBwPCk8PILlf7flVpaaEhmyZeb5xVC+qZ034MOS6JS1KF8UAmBqF4qO2dMSkMEcpSfy3QUlUESrsYCQK4PvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bWhdb65z1zHrQm;
	Tue,  1 Jul 2025 20:08:51 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 63953140159;
	Tue,  1 Jul 2025 20:12:52 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Jul
 2025 20:12:51 +0800
Message-ID: <5e02a1fb-8fdf-4523-8f51-9bcacfa74f1a@huawei.com>
Date: Tue, 1 Jul 2025 20:12:49 +0800
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
 <4f15d0aa-39e0-42ef-a9ca-ddbb3ff36060@huawei.com>
 <trjf7lqckchx6bc3p4lwh5yy3bqczo6yvdll7ujguhvvezwtja@cpfhj6ai7gzp>
 <4cbb9bc3-617d-43f7-a1cd-9afbd864fc68@huawei.com>
 <36bqxyj7gbozrewg2vk5mbfa4vwetwrl4iyae4h47eb5mlcs4s@ms56slymlwn4>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <36bqxyj7gbozrewg2vk5mbfa4vwetwrl4iyae4h47eb5mlcs4s@ms56slymlwn4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/1 19:53, Jan Kara wrote:
> On Tue 01-07-25 11:32:23, Baokun Li wrote:
>> On 2025/7/1 1:41, Jan Kara wrote:
>>> On Mon 30-06-25 18:02:49, Baokun Li wrote:
>>>> On 2025/6/30 16:38, Jan Kara wrote:
>>>>> We could make streaming goal to be ext4_fsblk_t so that also offset of the
>>>>> last big allocation in the group is recorded as I wrote above. That would
>>>>> tend to pack big allocations in each group together which is benefitial to
>>>>> combat fragmentation even with higher proportion of groups that are streaming
>>>>> goals (and likely becomes more important as the blocksize and thus group
>>>>> size grow). We can discuss proper number of slots for streaming allocation
>>>>> (I'm not hung up on it being quarter of the group count) but I'm convinced
>>>>> sb->s_groups_count is too much :)
>>>>>
>>>>> 								Honza
>>>> I think sbi->s_groups_count / 4 is indeed acceptable. However, I don't
>>>> believe recording offsets is necessary. As groups become larger,
>>>> contention for groups will intensify, and adding offsets would only
>>>> make this contention worse.
>>> I agree the contention for groups will increase when the group count goes
>>> down. I just thought offsets may help to find free space faster in large
>>> groups (and thus reduce contention) and also reduce free space
>>> fragmentation within a group (by having higher chances of placing large
>>> allocations close together within a group) but maybe that's not the case.
>>> Offsets are definitely not requirement at this point.
>>>
>>> 								Honza
>>>
>> Thinking this over, with LBS support coming, if our block size jumps from
>> 4KB to 64KB, the maximum group size will dramatically increase from 128MB
>> to 32GB (even with the current 4GB group limit). If free space within a
>> group gets heavily fragmented, iterating through that single group could
>> become quite time-consuming.
>>
>> Your idea of recording offsets to prevent redundant scanning of
>> already-checked extents within a group definitely makes sense. But with
>> reference to the idea of optimizing linear traversal of groups, I think it
>> might be better to record the offset of the first occurrence of each order
>> in the same way that bb_counters records the number of each order.
> Yes, something like that makes sense. But I guess that's a material for the
> next patch set :)
>
> 								Honza

Yes, this isn't urgent right now. I plan to implement this idea after
the LBS patch set is complete.

Thank you very much for your review and patient explanations! 😀


Regards,
Baokun


