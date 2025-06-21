Return-Path: <linux-ext4+bounces-8575-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74412AE26A0
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14B13B7A02
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869B211F;
	Sat, 21 Jun 2025 00:25:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6C382
	for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750465527; cv=none; b=SsDFY4byj7Vn+MBEG7+MOGRbLjJoo5ft1WzhWiQmLpYSWc49OJIMajnsvCyxKgNairBGR+TtfeMnqp1Fq/7qV0Oj3iHYx6I6iDJ9H0pQvMuwvYF2wYWB/dV3ViJ3iM5gx+0eZKoeDQIQgU3lJd/Yu4pf3Ldusk5iaLyOyPWM44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750465527; c=relaxed/simple;
	bh=b+IU9rxW6GeU2yfRm6hcfW313TR3E8ni9Zl1uvenvZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HzxIZZKmvIUY7MrDi8Y5Od+IC27FIsibw5ABPyvohunysRDyc8S9azZupxFAZRIveiy7DkE54j+SqY2GR0y8om5yTaiUab4UoH7lG7Tg+1Ou0VKZHRb8Ofm3jelFzbPgvNaQXQUkli0wiucom5mndQKV2QM6EWKp2U2GlMvx4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bPFP91Lnvz10XK3;
	Sat, 21 Jun 2025 08:20:45 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CAD2140277;
	Sat, 21 Jun 2025 08:25:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 21 Jun
 2025 08:25:19 +0800
Message-ID: <1c38b8e5-2b3f-4072-8b0a-0af5ad249829@huawei.com>
Date: Sat, 21 Jun 2025 08:25:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LBS support for EXT4
To: Pankaj Raghav <kernel@pankajraghav.com>
CC: Jan Kara <jack@suse.cz>, <tytso@mit.edu>, Luis Chamberlain
	<mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
	<linux-ext4@vger.kernel.org>, Zhang Yi <yi.zhang@huaweicloud.com>, Baokun Li
	<libaokun1@huawei.com>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi Pankaj Raghav,

We have some local patches that enable LBS (Logical Block Size) support in
ext4. Previously, we held off on releasing them because of an issue with
bdev LBS support in migration scenarios, and Zhang Yi's folio-related
patches hadn't been merged yet.

Now that both of these prerequisites are met, I will rebase and send out
this patch series as soon as possible.


Regards,
Baokun


On 2025/6/20 23:55, Jan Kara wrote:
> [added ext4 list and Zhang to CC]
>
> Hi,
>
> On Thu 19-06-25 15:05:14, Pankaj Raghav wrote:
>> Hello Jan and Ted,
>>
>> As you might know, I added LBS support to XFS sometime back. And after
>> that Luis added LBS support to block devices/buffer head path.
>>
>> And now that EXT4 supports large folios, it should be possible to add LBS
>> support to EXT4.
>>
>> I started digging in to the code, and it looks like it might require some
>> rework throughout EXT4 and lot of testing.
>>
>> My question is:
>>
>> I have seen patches from Zhang Yi to add iomap buffered IO support to EXT4.
>> If that happens, then adding LBS support should become trivial.
>>
>> Do you think it might happen soon or it is going to take more time?
>> Seeing the patches it is hard for me to say what the status is as the
>> last patches posted for them was last year.
> Well, time is always relative so it's difficult to tell what do you mean by
> "soon" :). We are definitely interested in converting ext4 to iomap.
> Currently we are fixing up some remaining issues caused by conversion to
> support large order folios but after that iomap conversion would be a next
> logical step. Zhang Yi had patches for that, I'm not sure how much from
> them is left to apply after the large order folios have landed.
>
>> The reason I am asking is, should I take up the challenge to add LBS
>> support with buffer heads in EXT4, or should I wait until iomap patches
>> are merged.
> I think better spent time would be to help with the iomap conversion. I
> don't think there will be that much coding left (perhaps some more exotic
> features need attention) but there's definitely testing needed and review
> is always welcome and most needed...
>
> 								Honza



