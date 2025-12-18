Return-Path: <linux-ext4+bounces-12396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33696CCA01E
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 02:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF64301D0DE
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F026F296;
	Thu, 18 Dec 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6A/mdIIZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E92222A1;
	Thu, 18 Dec 2025 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022578; cv=none; b=S7YNObeVp/6+PKgVS7MN0sBi2aFTUdFj21liPgCMm3mcb14GdYBvIDFGSQqH9ytsknS/dUJd/cCZQSslqAVEVCjqLmHi6RiPNAscbZ0cB8UIVtu5xVaHKm4s94ofZ8aoxzIDIGmVhMDk2xGAzR4vRfZ2OR8gcxgRVk9Yrzdfwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022578; c=relaxed/simple;
	bh=Y3j0EAisbltsGlSTRM4jaAd6NNFo868LaUIwD3U0zUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mzSoQ3JN9DT2tVNpXXJhxhcfXHVQCWLIqKd99C50P0hHNQmJIGIf2obfTWdU9PCV7UXEx7fIEFNu/I+cPq7yu9Ee6GaFVHE8ym6cU0lmF8nqe2zeuNRXwF7pqmFKriS7VvldGwRn7SdNLL4lrTX7NsZGxZD1/9/nQL+gVWTn368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6A/mdIIZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sFR/d/jFXb8PTareX7VZTkOyVQRNbiDQjgxkI8reTPM=;
	b=6A/mdIIZ1MZWiGTzV7igDiWbHAqWMZJroMQ261gX5Bw4EDDNw5Dvbo9iMCDCFOmstHvDBGPDz
	I7N3XBbNVkxd0XkHR3/N5tv8rIiadtDH/hc7A0YfRZmXRHyK97cTpp9rJ5evN2QiUzL4s7Jj2yy
	wX3oza8VpGOrrw36YQqV2K0=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dWtpB6ZQ8z1prKB;
	Thu, 18 Dec 2025 09:47:30 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6133B1402CD;
	Thu, 18 Dec 2025 09:49:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Dec
 2025 09:49:32 +0800
Message-ID: <7e3278d0-032c-447a-a4f4-0a34a09541f1@huawei.com>
Date: Thu, 18 Dec 2025 09:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
Content-Language: en-GB
To: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
CC: <security@kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
 <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
 <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
 <3f5ec6d7-d291-4b37-8914-3b4347564e98@huawei.com>
 <2ef68a02.45e3e.19b2ce7b7a0.Coremail.3230100410@zju.edu.cn>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2ef68a02.45e3e.19b2ce7b7a0.Coremail.3230100410@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-17 23:22, 余昊铖 wrote:
> Hi,
>
> Sorry but I am a bit confused by your words. My original fuzz tesing already enabled CONFIG_BLK_DEV_WRITE_MOUNTED as in most major Linux distributions. 
>
> So does a bug found when CONFIG_BLK_DEV_WRITE_MOUNTED is enabled still hold value for reporting? Should I enable or disable this configuration in my future fuzzing work?

Oh, my apologies—I mistakenly wrote "enable" instead of "disable" which
must have been confusing.

Distributions typically enable this config because some userspace tools
still rely on writing directly to the raw disk. Once all userspace tools
transition to using ioctls, we will be able to disable it globally or
specifically for certain filesystems in distributions.

However, during testing, this feature is often disabled to avoid false
positives by prohibiting raw writes that bypass the filesystem.

You can find more details in the original patchset if you're interested:
https://lore.kernel.org/all/20231101173542.23597-1-jack@suse.cz


Cheers,
Baokun

>
> Thanks,
> Haocheng Yu
>
>>> Hi,
>>>
>>> I have disabled CONFIG_BLK_DEV_WRITE_MOUNTED and spent some time trying to trigger the reported KASAN issues. And I found neither of the two bugs has been observed since. Is this issue still worth investigating?
>> That essentially confirms the issue is caused by bypassing the
>> filesystem to write directly to the raw disk. This is a known
>> issue and is quite tricky to solve.
>>
>> You can work around this specific class of issues in your fuzz
>> testing by enabling CONFIG_BLK_DEV_WRITE_MOUNTED. Syzbot runs
>> with this configuration enabled by default.
>>
>>
>> Cheers,
>> Baokun



