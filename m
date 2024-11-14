Return-Path: <linux-ext4+bounces-5148-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513189C814B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 04:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1520228350E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1CA1E47D8;
	Thu, 14 Nov 2024 03:04:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4454654;
	Thu, 14 Nov 2024 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553478; cv=none; b=igBhW5CuFHtpMtZxeVc8U5KhiZKF2+/q5CKM3FX+unpIr9Xylp1Wg4IPZjcixrFe70yxvWoCYqn71bRF4lNlT+7TePCB1Gkqu15Ys4GjBmkxP5XnTneUouSBezDBB1j7LXmruZxKna7+jmNU0bH3xpfzT8iV/nqzUEUiFIms6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553478; c=relaxed/simple;
	bh=lyc2GGhmmforu9w0iIhDcMTtNNWVE+a46m1xojTuOKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N+U140n/B4QpTC7W1Tau+OmwWIj7gE9CnPsdTyuG/7AHRRRGu6tY66Pe/pc/jxy/jrLXwAsXwEySJWeWSGS0tFQp9VKjbRt3GaI8V9zZcPzoIdGTxYZ2vuiWDn/KYBdilaZwCku9rUDy1kAMWyMZe6xGzuEzcHiU0tdB5BE132E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XplLK2QP1z10Rbs;
	Thu, 14 Nov 2024 11:02:01 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 95B361400DC;
	Thu, 14 Nov 2024 11:04:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 11:04:30 +0800
Message-ID: <4be150fb-45c8-424f-84d0-378d2cdbc229@huawei.com>
Date: Thu, 14 Nov 2024 11:04:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC: <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, Yang Erkun <yangerkun@huawei.com>
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
 <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
 <CAEivzxc-=zsDk_dy7LnTUNzHqVTqm5vW9_3TBaCRrnmZJTxu5g@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAEivzxc-=zsDk_dy7LnTUNzHqVTqm5vW9_3TBaCRrnmZJTxu5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Alexander,

On 2024/11/11 23:25, Aleksandr Mikhalitsyn wrote:
> On Sat, Nov 9, 2024 at 4:32 AM Baokun Li <libaokun1@huawei.com> wrote:
>> Hi Alexander,
>>
>> Thanks for the patch.
>>
>> On 2024/11/8 21:48, Alexander Mikhalitsyn wrote:
>>> Add a new testcase for [1] commit in ext4 online resize testsuite.
>>>
>>> Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>> ---
>>>    tests/ext4/032 | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tests/ext4/032 b/tests/ext4/032
>>> index 6bc3b61b..77d592f4 100755
>>> --- a/tests/ext4/032
>>> +++ b/tests/ext4/032
>>> @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
>>>    # Check if online resizing with bigalloc is supported by the kernel
>>>    ext4_online_resize 4096 8192 1
>>>
>>> +_fixed_by_kernel_commit 6121258c2b33 \
>>> +     "ext4: fix off by one issue in alloc_flex_gd()"
>>> +ext4_online_resize $(c2b 6400) $(c2b 786432)
>>> +
> Hi Baokun,
>
>> I think this test would be better placed in the loop below. Then add some
>> comments describing the scenario being tested.
> Have done. Thanks!
Okay.
>> There are two current scenarios for off by one:
>>    * The above test is to expand from the first block group of a flex_bg to
>>      the next flex_bg;
>>    * Another scenario is to expand from the first block group of a flex_bg
>>      to the last block group of this flex_bg. For example,
>>        `ext4_online_resize $(c2b 6400) $(c2b 524288)`
> This test does not fail for me when I test without "ext4: fix off by
> one issue in alloc_flex_gd()" fix, so I decided not to take it.
Well, since we didn't check the off-by-one case directly, the latter case
really didn't cause the test case to fail before, and it doesn't appear
to have any effect at the moment, other than using some more memory.


Cheers,
Baokun

