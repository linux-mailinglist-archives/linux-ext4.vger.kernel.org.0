Return-Path: <linux-ext4+bounces-985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6583ECBE
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 11:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB05282E66
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769FE200AE;
	Sat, 27 Jan 2024 10:44:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53F13AF8;
	Sat, 27 Jan 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706352277; cv=none; b=OSIyQNcG0dVAUhcKOVJ8heFPkovEdIIshO7wyquXW+2OnePHls4c1bKbVfUndEFEI1/GzBxODHfKNr44ndB6yw8dbByY9dIS1xxtcmN1bO+pjgCDEk6kjm+wYKBsQiuK3XgWDgdCuTP+3nhnFboidQ6CpfVvejyOAcG/UyDley0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706352277; c=relaxed/simple;
	bh=Z0OLXXueoKiA/wGx60KBXxyU+VA6Uzmv+t+EL7bXNe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QvPDhN9EIoWg1J3qYGVTX7/S0/4B4PieLhiFSqeIeowkJJf+alVDxS+OJ0KMaNng3Kmf3ym1UWcH0262F7YtjH98i8kAK1l2BwHZrZOMIF3gpivX5SS9UYaatKxZPh3ICnREAmHIJzIgzShSKTtJBBtkeG9JxdXix7Ga1jNMv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TMWPf6K9jzNlbd;
	Sat, 27 Jan 2024 18:43:34 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id F10CC18001C;
	Sat, 27 Jan 2024 18:44:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 18:44:30 +0800
Message-ID: <ad5c3487-e847-7ab9-41bc-f13329265abc@huawei.com>
Date: Sat, 27 Jan 2024 18:44:29 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <1da0649d-812f-4dee-9c1b-af567afa2e46@p183>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <1da0649d-812f-4dee-9c1b-af567afa2e46@p183>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/27 17:44, Alexey Dobriyan wrote:
> Baokun Li wrote:
>
>> @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>>   		ret = kstrtoul(skip_spaces(buf), 0, &t);
>>   		if (ret)
>>   			return ret;
>> +		if (t != (unsigned int)t)
>> +			return -EINVAL;
> kstrto*() interface has variants for all standard types.
> It should be changed to kstrtou32() or kstrtouint();
>
> If you check if kstrto*() result fits into another type,
> you're probably doing it wrong.
Thanks for your comments!

The reason for not using those helper functions directly is as follows:

1）Those functions are also based on kstrtoull() wrappers, and if we
use kstrtou32() or kstrtouint(), we'd need to declare u32 t or int t,
which would leave us with a lot of declared but unused variables,
and an unsigned long t would be enough to cover our scenario.

2）Moreover, the actual range of a uint type sysfs interface may not
be 0-UINT_MAX, but 0-INT_MAX or 0-s_clusters_per_group, and we
need to limit the range of the variable according to the actual
meaning of the variable.

3）In addition, by declaring only an unsigned long type and then
uniformly parsing it with kstrtoul() and then restricting the range
of the variable according to the actual meaning of the variable,
we can reduce a lot of repetitive code.
>>   		if (a->attr_ptr == ptr_ext4_super_block_offset)
>>   			*((__le32 *) ptr) = cpu_to_le32(t);
-- 
With Best Regards,
Baokun Li
.

