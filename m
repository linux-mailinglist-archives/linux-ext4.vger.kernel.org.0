Return-Path: <linux-ext4+bounces-1379-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA386225A
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Feb 2024 03:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CDB2850CE
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Feb 2024 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B6111BD;
	Sat, 24 Feb 2024 02:46:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907834416;
	Sat, 24 Feb 2024 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708742786; cv=none; b=Tqp46cNzBz8ooBkEu9E9VCKnGNYZof9h5OT4CZYYvS+yUdgg5CRfEwMuNg4Fz7Ic5+Hi7AriiLl4rOOmBuOPel0WKQ16bgUS9Ns0iwZ08ZtmJBirHBGojNZvlRIfIn0Fvpu/c2/M0NjYP1PJ3/bNlW2vlEjZ2n5bCUrcaJvuJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708742786; c=relaxed/simple;
	bh=HWJlQsFECB33Mr/v6+zkBFxjz6TamDpqLpDUv+jZaMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YPCuY67tiNSzBCpAGpbB3FdoSMUgWkY8gwcqDHwRi4MFDzvqSAuL8VQfbfgC/PGZBVPQgVzzRFVmURHocT/n4g8ORxOCBAwPjUJbsXY6VlVIae23S+Xc/cjYtz8lyDdnDbOyJQYCiYbDg6CTu6ns021smppATJXAN7PDsSGRymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ThWSP50FtzNlln;
	Sat, 24 Feb 2024 10:44:53 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C3791400DD;
	Sat, 24 Feb 2024 10:46:19 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 10:46:18 +0800
Message-ID: <c276f6d9-38e0-0113-a134-bedd3f16298f@huawei.com>
Date: Sat, 24 Feb 2024 10:46:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/7] ext4: add positive int attr pointer to avoid sysfs
 variables overflow
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-5-libaokun1@huawei.com>
 <20240213165810.3k4lnxaqzdwrdj35@quack3>
 <83c16b1a-832d-2ffd-6100-1f2b80ca2f35@huawei.com>
 <20240223120547.lojc4ccfewi6iotw@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240223120547.lojc4ccfewi6iotw@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/23 20:05, Jan Kara wrote:
> On Sat 17-02-24 15:41:43, Baokun Li wrote:
>> On 2024/2/14 0:58, Jan Kara wrote:
>>> On Fri 26-01-24 16:57:13, Baokun Li wrote:
>>>> We can easily trigger a BUG_ON by using the following commands:
>>>>
>>>>       mount /dev/$disk /tmp/test
>>>>       echo 2147483650 > /sys/fs/ext4/$disk/mb_group_prealloc
>>>>       echo test > /tmp/test/file && sync
>>>>
>>>> ==================================================================
>>>> kernel BUG at fs/ext4/mballoc.c:2029!
>>>> invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>>> CPU: 3 PID: 320 Comm: kworker/u36:1 Not tainted 6.8.0-rc1 #462
>>>> RIP: 0010:mb_mark_used+0x358/0x370
>>>> [...]
>>>> Call Trace:
>>>>    ext4_mb_use_best_found+0x56/0x140
>>>>    ext4_mb_complex_scan_group+0x196/0x2f0
>>>>    ext4_mb_regular_allocator+0xa92/0xf00
>>>>    ext4_mb_new_blocks+0x302/0xbc0
>>>>    ext4_ext_map_blocks+0x95a/0xef0
>>>>    ext4_map_blocks+0x2b1/0x680
>>>>    ext4_do_writepages+0x733/0xbd0
>>>> [...]
>>>> ==================================================================
>>>>
>>>> In ext4_mb_normalize_group_request():
>>>>       ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
>>>>
>>>> Here fe_len is of type int, but s_mb_group_prealloc is of type unsigned
>>>> int, so setting s_mb_group_prealloc to 2147483650 overflows fe_len to a
>>>> negative number, which ultimately triggers a BUG_ON() in mb_mark_used().
>>>>
>>>> Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
>>>> value range of 0-INT_MAX to avoid the above problem. In addition to the
>>>> mb_group_prealloc sysfs interface, the following interfaces also have uint
>>>> to int conversions that result in overflows, and are also fixed.
>>>>
>>>>     err_ratelimit_burst
>>>>     msg_ratelimit_burst
>>>>     warning_ratelimit_burst
>>>>     err_ratelimit_interval_ms
>>>>     msg_ratelimit_interval_ms
>>>>     warning_ratelimit_interval_ms
>>>>     mb_best_avail_max_trim_order
>>>>
>>>> CC: stable@vger.kernel.org
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> I don't think you need to change s_mb_group_prealloc here and then restrict
>>> it even further in the next patch. I'd just leave it alone here.
>> Yes, we could put the next patch before this one, but using
>> s_mb_group_prealloc as an example makes it easier to understand
>> why the attr_pointer_pi case is added here.There are several other
>> variables that don't have more convincing examples.
> Yes, I think reordering would be good. Because I've read the convertion and
> started wondering: "is this enough?"
Well, I will put the next patch before this one in the next version.
>>> Also I think that limiting mb_best_avail_max_trim_order to 64 instead of
>>> INT_MAX will make us more resilient to surprises in the future :) But I
>>> don't really insist.
>>>
>>> 								Honza
>> I think it's enough here to make sure that mb_best_avail_max_trim_order
>> is a positive number, since we always make sure that min_order
>> is not less than 0, as follows:
>>
>>           order = fls(ac->ac_g_ex.fe_len) - 1;
>>           min_order = order - sbi->s_mb_best_avail_max_trim_order;
>>           if (min_order < 0)
>>                   min_order = 0;
>>
>> An oversized mb_best_avail_max_trim_order can be interpreted as
>> always being CR_ANY_FREE. 😄
> Well, s_mb_best_avail_max_trim_order is not about allocation passes but
> about how many times are we willing to shorten the goal extent to half and
> still use the advanced free blocks search.
Yes, this means that in CR1.5, in case the original request is satisfied,
we allow allocation of blocks with an order of (goal_extent_order -
s_mb_best_avail_max_trim_order) to accelerate block allocation.
> And I agree that the mballoc
> code is careful enough that large numbers don't matter there but still why
> allowing storing garbage values? It is nicer to tell sysadmin he did
> something wrong right away.
>
> 								Honza
Yes, we shouldn't allow storing rubbish values, otherwise it may
mislead admins, I will add an extra type to check it.


Thanks!
-- 
With Best Regards,
Baokun Li
.

